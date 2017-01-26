unit uClipboardMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes;

type
  TClipboardMonitor = class
                      private
                        FMessageHandler: HWND;
                        FChainWindow   : HWND;
                        FOnChange      : TNotifyEvent;

                        procedure MessageHandlerProc(var AMessage: TMessage);
                      protected
                      public
                        procedure Start;
                        procedure Stop;

                        property OnChange: TNotifyEvent read FOnChange write FOnChange;
                      end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon;


procedure TClipboardMonitor.Start;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FMessageHandler := AllocateHwnd(MessageHandlerProc);
  FChainWindow := SetClipboardViewer(FMessageHandler);
end;

procedure TClipboardMonitor.Stop;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  ChangeClipboardChain(FMessageHandler, FChainWindow);
  DeallocateHwnd(FMessageHandler);
end;

procedure TClipboardMonitor.MessageHandlerProc(var AMessage: TMessage);
begin
  if AMessage.Msg = WM_DRAWCLIPBOARD then
  begin
    if Assigned(FOnChange) then
      FOnChange(self);

    AMessage.Result := 0;
  end
  else
    AMessage.Result := DefWindowProc(FMessageHandler, AMessage.Msg, AMessage.wParam, AMessage.lParam);
end;

end.
