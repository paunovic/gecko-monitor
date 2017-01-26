unit uPrintersMonitor;

interface

uses
  Winapi.Windows, Winapi.WinSpool, System.Classes, Generics.Collections,
  System.SyncObjs, Vcl.Printers;

type
  TPrinterJobStatus       = (pjsUnknown, pjsNew, pjsProcessing, pjsDone, pjsAborted, pjsCompleted, pjsError, pjsPaused);
  TPrinterJobInformation  = record
                              Status      : TPrinterJobStatus;
                              PrinterInfo : TPrinterInfo2;
                              ID          : Integer;
                              Computer    : String;
                              Username    : String;
                              Document    : String;
                              TotalPages  : DWORD;
                              BytesPrinted: DWORD;
                              PagesPrinted: DWORD;
                              Copies      : DWORD;
                              Orientation : TPrinterOrientation;
                            end;

  TPrinterJobEvent = procedure(Sender: TObject; const AJobInfo: TPrinterJobInformation) of object;

  TPrinterMonitor  = class;

  TPrintersMonitor = class
                     private
                       FNotifiers        : TObjectList<TPrinterMonitor>;
                       FMonitoredPrinters: TStringList;
                       FMonitoring       : Boolean;

                       FOnJobAdd   : TPrinterJobEvent;
                       FOnJobChange: TPrinterJobEvent;
                       FOnJobAbort : TPrinterJobEvent;
                       FOnJobDone  : TPrinterJobEvent;

                       procedure CreateNotifiers;
                       procedure DestroyNotifiers;
                       procedure JobChangeEvent(Sender: TObject; const AJobInfo: TPrinterJobInformation);
                     protected
                     public
                       constructor Create;
                       destructor Destroy; override;

                       procedure Start;
                       procedure Stop;

                       property MonitoredPrinters: TStringList read FMonitoredPrinters;
                       property Monitoring       : Boolean read FMonitoring;

                       property OnJobAdd   : TPrinterJobEvent read FOnJobAdd write FOnJobAdd;
                       property OnJobChange: TPrinterJobEvent read FOnJobChange write FOnJobChange;
                       property OnJobAbort : TPrinterJobEvent read FOnJobAbort write FOnJobAbort;
                       property OnJobDone  : TPrinterJobEvent read FOnJobDone write FOnJobDone;
                     end;

  TPrinterMonitor  = class(TThread)
                     private
                       FPrinterHandle  : THandle;
                       FPrinterInfo    : TPrinterInfo2;
                       FWakeupEvent    : TSimpleEvent;
                       FJobInformation : TPrinterJobInformation;

                       FOnJobChange    : TPrinterJobEvent;

                       procedure InternalCreate(const APrinterIndex: Integer);
                       procedure HandleNotification(const AFindHandle: THandle);
                       procedure DoJobChange;
                     protected
                       procedure Execute; override;
                     public
                       constructor Create(const APrinterIndex: Integer);
                       destructor Destroy; override;
                       procedure Terminate;

                       property OnJobChange: TPrinterJobEvent read FOnJobChange write FOnJobChange;
                     end;


implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon;


function OpenCurrentPrinter: THandle;
const
  DEFAULTS: TPrinterDefaults = (pDataType    : nil;
                                pDevMode     : nil;
                                DesiredAccess: PRINTER_ACCESS_USE or PRINTER_ACCESS_ADMINISTER);
var
  device, driver, port: Array[0..255] of Char;
  hDeviceMode         : THandle;
begin
  Printer.GetPrinter(device, driver, port, hDeviceMode);
  if not OpenPrinter(@device, result, @defaults) then
    result := 0;
end;


////////////////////////////////////////////////////////////////////////////////
/// TPrintersMonitor
/// ////////////////////////////////////////////////////////////////////////////

constructor TPrintersMonitor.Create;
begin
  FNotifiers := TObjectList<TPrinterMonitor>.Create;
  FMonitoredPrinters := TStringList.Create;
end;

destructor TPrintersMonitor.Destroy;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FNotifiers.Free;
  FMonitoredPrinters.Free;

  inherited;
end;

procedure TPrintersMonitor.Start;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  CreateNotifiers;
  FMonitoring := TRUE;
end;

procedure TPrintersMonitor.Stop;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  DestroyNotifiers;
  FMonitoring := FALSE;
end;

procedure TPrintersMonitor.CreateNotifiers;
var
  notifier : TPrinterMonitor;
  C1, C2   : Integer;
  oldIndex : Integer;
  monitor  : Boolean;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if Printer.Printers.Count > 0 then
  begin
    oldIndex := Printer.PrinterIndex;
    for C1 := 0 to Printer.Printers.Count - 1 do
    begin
      monitor := FALSE;
      for C2 := 0 to FMonitoredPrinters.Count - 1 do
        if Printer.Printers[C1] = FMonitoredPrinters[C2] then
        begin
          monitor := TRUE;
          Break;
        end;

      if monitor then
      begin
        notifier := TPrinterMonitor.Create(C1);
        if Assigned(notifier) then
        begin
          notifier.OnJobChange := JobChangeEvent;
          notifier.Start;
          FNotifiers.Add(notifier);
        end;
      end;
    end;
    Printer.PrinterIndex := oldIndex;
  end;
end;

procedure TPrintersMonitor.DestroyNotifiers;
var
  C1 : Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  for C1 := 0 to FNotifiers.Count - 1 do
  begin
    FNotifiers[C1].Terminate;
    FNotifiers[C1].WaitFor;
  end;
  FNotifiers.Clear;
end;

procedure TPrintersMonitor.JobChangeEvent(Sender: TObject; const AJobInfo: TPrinterJobInformation);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  case AJobInfo.Status of
    pjsNew      : if Assigned(FOnJobAdd) then
                    FOnJobAdd(self, AJobInfo);
    pjsAborted  : if Assigned(FOnJobAbort) then
                    FOnJobAbort(self, AJobInfo);
    pjsCompleted: if Assigned(FOnJobDone) then
                    FOnJobDone(self, AJobInfo);
  else
    if Assigned(FOnJobChange) then
      FOnJobChange(self, AJobInfo);
  end;
end;


////////////////////////////////////////////////////////////////////////////////
/// TPrinterMonitor
/// ////////////////////////////////////////////////////////////////////////////

constructor TPrinterMonitor.Create(const APrinterIndex: Integer);
begin
  inherited Create(TRUE);

  InternalCreate(APrinterIndex);
end;

procedure TPrinterMonitor.InternalCreate(const APrinterIndex: Integer);
var
  oldIndex      : Integer;
  printerHandle : THandle;
  bytesNeeded   : DWORD;
  printerInfo   : PPrinterInfo2;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  oldIndex := Printer.PrinterIndex;
  Printer.PrinterIndex := APrinterIndex;
  printerHandle := OpenCurrentPrinter;
  if printerHandle <> 0 then
  begin
    GetPrinter(printerHandle, 2, nil, 0, @bytesNeeded);
    if GetLastError = ERROR_INSUFFICIENT_BUFFER then
    begin
      printerInfo := AllocMem(bytesNeeded);
      if GetPrinter(printerHandle, 2, printerInfo, bytesNeeded, @bytesNeeded) then
      begin
        FPrinterHandle := printerHandle;
        FPrinterInfo := printerInfo^;
      end;
    end;
  end;
  Printer.PrinterIndex := oldIndex;

  FWakeupEvent := TSimpleEvent.Create;
end;

destructor TPrinterMonitor.Destroy;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if FPrinterHandle <> 0 then
    ClosePrinter(FPrinterHandle);

  FWakeupEvent.SetEvent;
  FWakeupEvent.Free;

  inherited;
end;

procedure TPrinterMonitor.Terminate;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  inherited;

  FWakeupEvent.SetEvent;
end;


procedure TPrinterMonitor.Execute;
const
  JOB_FIELDS : Array[1..9] of Word = (JOB_NOTIFY_FIELD_MACHINE_NAME,
                                      JOB_NOTIFY_FIELD_USER_NAME,
                                      JOB_NOTIFY_FIELD_DOCUMENT,
                                      JOB_NOTIFY_FIELD_TOTAL_PAGES,
                                      JOB_NOTIFY_FIELD_TOTAL_BYTES,
                                      JOB_NOTIFY_FIELD_BYTES_PRINTED,
                                      JOB_NOTIFY_FIELD_PAGES_PRINTED,
                                      JOB_NOTIFY_FIELD_STATUS,
                                      JOB_NOTIFY_FIELD_DEVMODE);
type
  TLocalHandles = packed record
                    FindHandle, WakeHandle: THandle;
                  end;
var
  notifyOptions : TPrinterNotifyOptions;
  notifyType    : TPrinterNotifyOptionsType;
  handles       : TLocalHandles;
  retval        : DWORD;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FillChar(notifyType, SizeOf(notifyType), 0);
  notifyType.wType := JOB_NOTIFY_TYPE;
  notifyType.pFields := @JOB_FIELDS;
  notifyType.Count := High(JOB_FIELDS) - LOW(JOB_FIELDS) + 1;

  notifyOptions.Version := 2;
  notifyOptions.Flags := 0;
  notifyOptions.Count := 1;
  notifyOptions.pTypes := @notifyType;

  handles.WakeHandle := FWakeupEvent.Handle;
  handles.FindHandle := FindFirstPrinterChangeNotification(FPrinterHandle, PRINTER_CHANGE_JOB, 0, @notifyOptions);
  if handles.FindHandle <> INVALID_HANDLE_VALUE then
  begin
    while not Terminated do
    begin
      retval := WaitForMultipleObjects(2, @handles, FALSE, INFINITE);
      if (not Terminated) and
         (retval = WAIT_OBJECT_0) then
        HandleNotification(handles.FindHandle);
    end;
    FindClosePrinterChangeNotification(handles.FindHandle);
  end;
end;

procedure TPrinterMonitor.HandleNotification(const AFindHandle: THandle);

  function IsReason(const AReason, AFlag: DWORD): Boolean;
  begin
    result := (AFlag and AReason) <> 0;
  end;

  function FindJobStatus(const ANotifyInfo: TPrinterNotifyInfo) : TPrinterJobStatus;
  var
    C1    : Integer;
    status: DWORD;
  begin
    result := pjsUnknown;

    for C1 := 0 to ANotifyInfo.Count - 1 do
      if ANotifyInfo.aData[C1].Field = JOB_NOTIFY_FIELD_STATUS then
      begin
        status := ANotifyInfo.aData[C1].NotifyData.adwData[0];
        if IsReason(status, JOB_STATUS_PRINTED) then
          result := pjsCompleted
        else
          if IsReason(status, JOB_STATUS_DELETING) then
            result := pjsAborted
          else
          if IsReason(status, JOB_STATUS_SPOOLING or JOB_STATUS_PRINTING) then
            result := pjsProcessing
          else
            if IsReason(status, JOB_STATUS_ERROR or JOB_STATUS_OFFLINE or JOB_STATUS_PAPEROUT) then
              result := pjsError
            else
            if IsReason(status, JOB_STATUS_PAUSED) then
              result := pjsPaused;
      end;
  end;

  function GetJobInformation(const ANotifyInfo: TPrinterNotifyInfo) : Boolean;
  var
    C1: Integer;
  begin
    if ANotifyInfo.Count = 0 then
      Exit(FALSE);

    FJobInformation.ID := ANotifyInfo.aData[0].Id;
    for C1 := 0 to ANotifyInfo.Count - 1 do
      case ANotifyInfo.aData[C1].Field of
        JOB_NOTIFY_FIELD_MACHINE_NAME : FJobInformation.Computer := PChar(ANotifyInfo.aData[C1].NotifyData.Data.pBuf);
        JOB_NOTIFY_FIELD_USER_NAME    : FJobInformation.Username := PChar(ANotifyInfo.aData[C1].NotifyData.Data.pBuf);
        JOB_NOTIFY_FIELD_DOCUMENT     : FJobInformation.Document := PChar(ANotifyInfo.aData[C1].NotifyData.Data.pBuf);
        JOB_NOTIFY_FIELD_TOTAL_PAGES  : FJobInformation.TotalPages := ANotifyInfo.aData[C1].NotifyData.adwData[0];
        JOB_NOTIFY_FIELD_BYTES_PRINTED: FJobInformation.BytesPrinted := ANotifyInfo.aData[C1].NotifyData.adwData[0];
        JOB_NOTIFY_FIELD_PAGES_PRINTED: FJobInformation.PagesPrinted := ANotifyInfo.aData[C1].NotifyData.adwData[0];
        JOB_NOTIFY_FIELD_DEVMODE      : begin
                                          FJobInformation.Copies := PDeviceMode(ANotifyInfo.aData[C1].NotifyData.Data.pBuf)^.dmCopies;

                                          case PDeviceMode(ANotifyInfo.aData[C1].NotifyData.Data.pBuf)^.dmOrientation of
                                            DMORIENT_PORTRAIT : FJobInformation.Orientation := poPortrait;
                                            DMORIENT_LANDSCAPE: FJobInformation.Orientation := poLandscape;
                                          else
                                            FJobInformation.Orientation := poPortrait;
                                          end;
                                        end;
      end;

    result := TRUE;
  end;

var
  pni         : PPrinterNotifyInfo;
  ChangeReason: DWORD;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if FindNextPrinterChangeNotification(AFindHandle, ChangeReason, nil, pointer(pni)) then
  begin
    FJobInformation.Status := pjsUnknown;

    if IsReason(ChangeReason, PRINTER_CHANGE_ADD_JOB) then
      FJobInformation.Status := pjsNew
    else
      if IsReason(ChangeReason, PRINTER_CHANGE_DELETE_JOB) then
        FJobInformation.Status := pjsAborted
      else
      if IsReason(ChangeReason, PRINTER_CHANGE_WRITE_JOB) then
        FJobInformation.Status := pjsProcessing
      else
        if (IsReason(ChangeReason, PRINTER_CHANGE_SET_JOB)) and
           (Assigned(pni)) then
          FJobInformation.Status := FindJobStatus(pni^);

    if (FJobInformation.Status <> pjsUnknown) and
       (Assigned(pni)) and
       (GetJobInformation(pni^)) then
    begin
      FJobInformation.PrinterInfo := FPrinterInfo;
      Synchronize(DoJobChange);
    end;

    FreePrinterNotifyInfo(pni);
  end;
end;

procedure TPrinterMonitor.DoJobChange;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if Assigned(FOnJobChange) then
    FOnJobChange(self, FJobInformation);
end;

end.
