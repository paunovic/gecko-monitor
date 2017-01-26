unit uSaveReportForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinVS2010,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel, cxCheckBox, cxGroupBox, AbBase,
  AbBrowse, AbZBrows, AbZipper, cxProgressBar;

type
  TfrmSaveReport = class(TForm)
    btSave: TcxButton;
    btCancel: TcxButton;
    gbItems: TcxGroupBox;
    chbFiles: TcxCheckBox;
    chbClipboard: TcxCheckBox;
    chbPrinters: TcxCheckBox;
    chbScreenshots: TcxCheckBox;
    chbKeystrokes: TcxCheckBox;
    chbWebsites: TcxCheckBox;
    chbApps: TcxCheckBox;
    SaveDialog: TSaveDialog;
    AbZipper: TAbZipper;
    lbSaving: TcxLabel;
    procedure btSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function RunModal: Integer;
  end;

var
  frmSaveReport: TfrmSaveReport;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, uResources, uDataModel, uMainForm;


procedure TfrmSaveReport.btSaveClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if SaveDialog.Execute then
  begin
    lbSaving.Visible := TRUE;
    lbSaving.Refresh;
    frmMain.CreateReportFile(SaveDialog.FileName, chbScreenshots.Checked, chbKeystrokes.Checked, chbWebsites.Checked,
                             chbApps.Checked, chbPrinters.Checked, chbClipboard.Checked, chbFiles.Checked);
    ModalResult := mrOk;
    lbSaving.Visible := FALSE;
  end;
end;

procedure TfrmSaveReport.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_ESCAPE: ModalResult := mrCancel;
  end;
end;

class function TfrmSaveReport.RunModal: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmSaveReport) then
  begin
    Application.CreateForm(TfrmSaveReport, frmSaveReport);
    result := frmSaveReport.ShowModal;
    FreeAndNil(frmSaveReport);
  end
  else
    result := -1;
end;

end.
