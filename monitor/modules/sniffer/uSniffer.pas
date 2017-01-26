unit uSniffer;

interface

uses
  Winapi.Windows, System.SysUtils, Generics.Collections, OverbyteICSWSocket,
  uCommon;

type
  TSnifferDataAvailable = procedure(Sender: TObject; const ABuffer : TByteArray; const ABufferSize : Integer) of object;

  TSniffer = class
             private
               FSockets           : TObjectList<TWSocket>;
               FNetworkInterfaces : TNetworkInterfaces;
               FOnDataAvailable   : TSnifferDataAvailable;

               procedure CreateListeners;
               procedure CloseListeners;
               function CloseListener(const AIndex : Integer) : Boolean;

               procedure SocketError(Sender: TObject);
               procedure SocketDataAvailable(Sender: TObject; ErrCode: Word);
             protected
             public
               constructor Create;
               destructor Destroy; override;

               procedure Start;
               procedure Stop;

               property OnDataAvailable : TSnifferDataAvailable read FOnDataAvailable write FOnDataAvailable;
             end;

implementation

{$IFDEF DEBUG}
uses
  JclDebug;
{$ENDIF}


constructor TSniffer.Create;
begin
  FSockets := TObjectList<TWSocket>.Create(TRUE);
end;

destructor TSniffer.Destroy;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FSockets.Free;
end;

procedure TSniffer.Start;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  GetNetworkInterfaces(FNetworkInterfaces);
  CreateListeners;
end;

procedure TSniffer.Stop;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  CloseListeners;
end;

procedure TSniffer.CreateListeners;
var
  C1     : Integer;
  socket : TWSocket;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  for C1 := Low(FNetworkInterfaces.Items) to High(FNetworkInterfaces.Items) do
  begin
    socket := TWSocket.Create(nil);
    with socket do
    begin
      Proto := 'raw_ip';
      MultiThreaded := FALSE;
      ComponentOptions := [wsoSIO_RCVALL];
      Addr := GetUnicastIP(FNetworkInterfaces.Items[C1].FirstUnicastAddress);
      Port := '0';
      OnError := SocketError;
      OnDataAvailable := SocketDataAvailable;

      Listen;
    end;

    FSockets.Add(socket);
  end;
end;

function TSniffer.CloseListener(const AIndex : Integer) : Boolean;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  result := FALSE;
  if (AIndex >= 0) and
     (AIndex < FSockets.Count) and
     (Assigned(FSockets[AIndex])) then
  Begin
    FSockets[AIndex].Close;
    FSockets.Delete(AIndex);
    result := TRUE;
  End;
end;

procedure TSniffer.CloseListeners;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  while FSockets.Count > 0 do
    CloseListener(0);
end;

procedure TSniffer.SocketError(Sender: TObject);
var
  C1 : Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  for C1 := 0 to FSockets.Count - 1 do
    if FSockets[C1] = TWSocket(Sender) then
    begin
      CloseListener(C1);
      Break;
    end;
end;

procedure TSniffer.SocketDataAvailable(Sender: TObject; ErrCode: Word);
var
  buffer : TByteArray;
  buflen : Integer;
begin
  buflen := TWSocket(Sender).Receive(@buffer[0], SizeOf(buffer));

  if buflen > 0 then
  begin
    if Assigned(FOnDataAvailable) then
      FOnDataAvailable(self, buffer, buflen);
  end;
end;

end.
