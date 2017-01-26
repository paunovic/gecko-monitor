unit uTrialUnlocker;

interface

uses
  Winapi.Windows, System.SyncObjs, System.Classes;

type
  TTrialUnlocker = class(TThread)
                   private
                     FExpirationTime: DWORD;
                     FRunTime       : DWORD;
                     FWakeupEvent   : TSimpleEvent;

                     FOnTrialExpiry : TNotifyEvent;

                     procedure SetRunTime;
                     function GetRunTime: DWORD;
                     function GetRemainingTime: DWORD;

                     procedure syncTrialExpiryEvent;
                   protected
                     procedure Execute; override;
                   public
                     constructor Create(const AExpirationTime: DWORD);
                     destructor Destroy; override;

                     procedure Terminate;

                     property RunTime       : DWORD read FRunTime;
                     property ExpirationTime: DWORD read FExpirationTime;
                     property RemainingTime : DWORD read GetRemainingTime;

                     property OnTrialExpiry : TNotifyEvent read FOnTrialExpiry write FOnTrialExpiry;
                   end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, System.Win.Registry;

constructor TTrialUnlocker.Create(const AExpirationTime: DWORD);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  inherited Create(TRUE);

  FRunTime := GetRunTime;

  FExpirationTime := AExpirationTime;
  FWakeupEvent := TSimpleEvent.Create;
end;


destructor TTrialUnlocker.Destroy;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FWakeupEvent.SetEvent;
  FWakeupEvent.Free;

  inherited;
end;

procedure TTrialUnlocker.Terminate;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  inherited;

  FWakeupEvent.SetEvent;
end;

procedure TTrialUnlocker.Execute;
var
  waitTime: DWORD;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  waitTime := 0;
  while not Terminated do
  begin
    Inc(FRunTime, waitTime);
    SetRunTime;

    if FRunTime > FExpirationTime then
      Synchronize(syncTrialExpiryEvent);

    waitTime := Random(3000);
    WaitForSingleObject(FWakeupEvent.Handle, waitTime);
  end;
end;

function TTrialUnlocker.GetRemainingTime: DWORD;
//
// Returns remaining time in seconds
//
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if FRunTime > FExpirationTime then
    result := 0
  else
    result := (FExpirationTime - FRunTime) div 1000;
end;

function TTrialUnlocker.GetRunTime: DWORD;
var
  reg: TRegistry;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  result := 0;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CLASSES_ROOT;
    if (reg.OpenKey('.pnf', FALSE)) and
       (reg.ValueExists('DataType')) then
      result := reg.ReadInteger('DataType');
  finally
    reg.Free;
  end;
end;

procedure TTrialUnlocker.SetRunTime;
var
  reg: TRegistry;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CLASSES_ROOT;
    if reg.OpenKey('.pnf', TRUE) then
      reg.WriteInteger('DataType', FRunTime);
  finally
    reg.Free;
  end;
end;

procedure TTrialUnlocker.syncTrialExpiryEvent;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if Assigned(FOnTrialExpiry) then
    FOnTrialExpiry(self);
end;

end.
