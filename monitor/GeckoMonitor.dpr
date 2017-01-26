program GeckoMonitor;

{$I defines.inc}

{$R *.dres}
{$R *.res}
{$R _resources\fonts.res}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Winapi.Windows,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Themes,
  Vcl.Styles,
  uCommon in 'uCommon.pas',
  uResources in 'uResources.pas',
  uSniffer in 'modules\sniffer\uSniffer.pas',
  uKeylogger in 'modules\keylogger\uKeylogger.pas',
  uSiteTracker in 'modules\site_tracker\uSiteTracker.pas',
  uScreenshotter in 'modules\screenshoting\uScreenshotter.pas',
  uWindowFocusNotifier in 'modules\app_tracker\uWindowFocusNotifier.pas',
  uPrintersMonitor in 'modules\printers\uPrintersMonitor.pas',
  uServiceManager in 'modules\servicemanager\uServiceManager.pas',
  uSerialValidator in 'modules\trialunlocker\uSerialValidator.pas',
  uTrialUnlocker in 'modules\trialunlocker\uTrialUnlocker.pas',
  uEncryption in 'modules\encryption\uEncryption.pas',
  uStartup in 'modules\startup\uStartup.pas',
  uMailSender in 'modules\mail_sender\uMailSender.pas',
  uClipboardMonitor in 'modules\clipboard_monitor\uClipboardMonitor.pas',
  uMainForm in 'uMainForm.pas' {frmMain},
  uDataModel in 'uDataModel.pas' {DataModel: TDataModule},
  uSettingsForm in 'uSettingsForm.pas' {frmSettings},
  uTrialRegisterForm in 'uTrialRegisterForm.pas' {frmTrialRegister},
  uFirstStartForm in 'uFirstStartForm.pas' {frmFirstStart},
  uIgnoreItemAdd in 'uIgnoreItemAdd.pas' {frmIgnoreItemAdd},
  uUnlockForm in 'uUnlockForm.pas' {frmUnlock},
  uChangePasswordForm in 'uChangePasswordForm.pas' {frmChangePassword},
  uSaveReportForm in 'uSaveReportForm.pas' {frmSaveReport},
  uInstanceController in 'modules\instance_controller\uInstanceController.pas';

begin
  if not TInstanceController.IsAlphaInstance then
    Exit;
  TInstanceController.RegisterInstance;

  Application.Initialize;
  Application.MainFormOnTaskbar := TRUE;
  Application.CreateForm(TDataModel, DataModel);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

