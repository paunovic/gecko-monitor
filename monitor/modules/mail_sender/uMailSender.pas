unit uMailSender;

interface

uses
  Generics.Collections, OverbyteIcsWndControl, OverbyteIcsSmtpProt, OverbyteIcsWSocket;

type
  TMailSendDoneEvent   = procedure(Sender: TObject; const ASuccess: Boolean) of object;
  TMailerSendDoneEvent = procedure(Sender: TObject; SenderThread: TObject; const ASuccess: Boolean) of object;

  TMailSenderThread = class
                      private
                        FSSLContext    : TSslContext;
                        FSMTPClient    : TSslSMTPCli;
                        FSendSuccessful: Boolean;

                        FOnSendDone    : TMailSendDoneEvent;

                        procedure SMTPClientRequestDone(Sender: TObject; RqType: TSmtpRequest; ErrorCode: Word);
                      protected
                      public
                        constructor Create;
                        destructor Destroy; override;

                        procedure Send(const ARecipient, ASubject, AFile, AHost, APort, AUsername, APassword: String; const ASSLType: TSmtpSslType);

                        property SMTPClient: TSslSMTPCli read FSMTPClient;
                        property OnSendDone: TMailSendDoneEvent read FOnSendDone write FOnSendDone;
                      end;

  TMailSender = class
                private
                  FThreads   : TList<TMailSenderThread>;

                  FOnSendDone: TMailerSendDoneEvent;

                  procedure ThreadSendDone(Sender: TObject; const ASuccess: Boolean);
                protected
                public
                  constructor Create;
                  destructor Destroy; override;

                  procedure Send(const ARecipient, ASubject, AFile, AHost, APort, AUsername, APassword: String; const ASSLType: TSmtpSslType);

                  property OnSendDone: TMailerSendDoneEvent read FOnSendDone write FOnSendDone;
                end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  Winapi.Windows, System.SysUtils,
  uCommon;


constructor TMailSender.Create;
begin
  FThreads := TList<TMailSenderThread>.Create;
end;

destructor TMailSender.Destroy;
begin
  FThreads.Free;

  inherited;
end;

procedure TMailSender.Send(const ARecipient, ASubject, AFile, AHost, APort, AUsername, APassword: String; const ASSLType: TSmtpSslType);
var
  thread: TMailSenderThread;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  thread := TMailSenderThread.Create;
  thread.OnSendDone := ThreadSendDone;
  thread.Send(ARecipient, ASubject, AFile, AHost, APort, AUsername, APassword, ASSLType);
  FThreads.Add(thread);
end;

procedure TMailSender.ThreadSendDone(Sender: TObject; const ASuccess: Boolean);
var
  C1: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if Assigned(FOnSendDone) then
    FOnSendDone(self, Sender, ASuccess);

  for C1 := 0 to FThreads.Count - 1 do
    if FThreads[C1] = TMailSenderThread(Sender) then
    begin
      FThreads.Delete(C1);
      Break;
    end;

  TMailSenderThread(Sender).Free;
end;

////////////////////////////////////////////////////////////////////////////////

constructor TMailSenderThread.Create;
begin
  FSSLContext := TSslContext.Create(nil);
  FSMTPClient := TSslSMTPCli.Create(nil);
  FSMTPClient.MultiThreaded := TRUE;
  FSendSuccessful := FALSE;
end;

destructor TMailSenderThread.Destroy;
begin
  FSMTPClient.Free;
  FSSLContext.Free;

  inherited;
end;

procedure TMailSenderThread.Send(const ARecipient, ASubject, AFile, AHost, APort, AUsername, APassword: String; const ASSLType: TSmtpSslType);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FSMTPClient.SslContext := FSSLContext;
  FSMTPClient.AuthType := smtpAuthAutoSelect;
  FSMTPClient.OnRequestDone := SMTPClientRequestDone;
  FSMTPClient.HdrSubject := ASubject;
  FSMTPClient.RcptName.Clear;
  FSMTPClient.RcptName.Add(ARecipient);
  FSMTPClient.EmailFiles.Clear;
  if FileExists(AFile) then
    FSMTPClient.EmailFiles.Add(AFile);
  FSMTPClient.Host := AHost;
  FSMTPClient.Port := APort;
  FSMTPClient.Username := AUsername;
  FSMTPClient.Password := APassword;
  FSMTPClient.SslType := ASSLType;

  FSMTPClient.Open;
end;

procedure TMailSenderThread.SMTPClientRequestDone(Sender: TObject; RqType: TSmtpRequest; ErrorCode: Word);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if ErrorCode <> 0 then
    FSMTPClient.Quit
  else
  begin
    case RqType of
      smtpOpen : FSMTPClient.Mail;
      smtpMail : begin
                   FSendSuccessful := TRUE;
                   FSMTPClient.Quit;
                 end;
      smtpQuit : if Assigned(FOnSendDone) then
                   FOnSendDone(self, FSendSuccessful);
    end;

  end;
end;

end.


