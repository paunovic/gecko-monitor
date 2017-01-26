unit uWindowFocusNotifier;

interface

uses
  Winapi.Windows, Winapi.Messages;

type
  TWindowActivateEvent = procedure(Sender: TObject; const APID: DWORD; const ACaption: String) of object;

  TWindowFocusNotifier = class
                         private
                           var
                             FWinHook : DWORD;

                             FOnWindowActivate : TWindowActivateEvent;

                             procedure MessageHandlerProc(var AMessage: TMessage);
                         protected
                         public
                           procedure Hook;
                           procedure Unhook;

                           property OnWindowActivate : TWindowActivateEvent read FOnWindowActivate write FOnWindowActivate;
                         end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  System.SysUtils, System.Classes,
  uCommon;

var
  MessageHandler: HWND;
  UserMessage   : DWORD;


procedure WinEventProc(AWinEventHook: NativeUInt; AEventType: DWORD; AHWND: HWND; AIDObject, AIDChild: LONG; AIDEventThread, AMsEventTime: DWORD); stdcall;
begin
  if AEventType = EVENT_SYSTEM_FOREGROUND then
    PostMessage(MessageHandler, UserMessage, AHWND, 0);
end;

procedure TWindowFocusNotifier.Hook;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  MessageHandler := AllocateHWnd(MessageHandlerProc);
  FWinHook := SetWinEventHook(EVENT_SYSTEM_FOREGROUND, EVENT_SYSTEM_FOREGROUND, 0, @WinEventProc, 0, 0, WINEVENT_OUTOFCONTEXT);
end;

procedure TWindowFocusNotifier.Unhook;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  UnhookWinEvent(FWinHook);
  DeallocateHWnd(MessageHandler);
end;

procedure TWindowFocusNotifier.MessageHandlerProc(var AMessage: TMessage);
var
  caption : String;
  pid     : DWORD;
begin
  if AMessage.Msg = UserMessage then
  begin
    caption := GetWindowCaption(AMessage.WParam);
    if caption <> '' then
    begin
      GetWindowThreadProcessID(AMessage.WParam, pid);
      if Assigned(FOnWindowActivate) then
        FOnWindowActivate(self, pid, caption);
    end;

    AMessage.Result := 0;
  end
  else
    AMessage.Result := DefWindowProc(MessageHandler, AMessage.Msg, AMessage.WParam, AMessage.LParam);
end;

initialization
  UserMessage := RegisterWindowMessage('GeckoWinFocusMessage');

end.
