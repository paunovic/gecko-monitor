unit uTrialRegisterForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinVS2010,
  cxTextEdit, cxLabel, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxMaskEdit;

type
  TfrmTrialRegister = class(TForm)
    lbHotkey: TcxLabel;
    lbHeader: TcxLabel;
    btOk: TcxButton;
    btExit: TcxButton;
    lbPurchaseURL: TcxLabel;
    meSerial: TcxMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbPurchaseURLClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
  public
    class function RunModal: Integer;
  end;

var
  frmTrialRegister: TfrmTrialRegister;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, uResources, uDataModel, uSerialValidator;


class function TfrmTrialRegister.RunModal: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmTrialRegister) then
  begin
    Application.CreateForm(TfrmTrialRegister, frmTrialRegister);
    result := frmTrialRegister.ShowModal;
    FreeAndNil(frmTrialRegister);
  end
  else
    result := -1;
end;

procedure TfrmTrialRegister.btOkClick(Sender: TObject);
begin
  if TSerialValidator.Validate(TSerial(meSerial.Text)) then
  begin
    DataModel.Settings.General.Serial := TSerial(meSerial.Text);
    ModalResult := mrOk
  end
  else
    ModalResult := mrCancel;
end;

procedure TfrmTrialRegister.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTrialRegister.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  self.Color := clBlack;
  SetBackground(self, RES_BACKGROUND_TRIAL);
end;

procedure TfrmTrialRegister.lbPurchaseURLClick(Sender: TObject);
begin
  ShellOpen('http://www.geckomonitor.com');
end;

end.
