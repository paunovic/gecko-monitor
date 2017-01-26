unit uUnlockForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinVS2010,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel;

type
  TfrmUnlock = class(TForm)
    edPassword: TEdit;
    lbPassword: TcxLabel;
    btOk: TcxButton;
    btCancel: TcxButton;
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function RunModal: Integer;
  end;

var
  frmUnlock: TfrmUnlock;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, uResources, uDataModel, uSerialValidator;


procedure TfrmUnlock.btOkClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if TShortString(edPassword.Text) = DataModel.Settings.General.Password then
    ModalResult := mrOk
  else
    ModalResult := mrClose;
end;

procedure TfrmUnlock.edPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_RETURN then
    btOk.Click;
end;

procedure TfrmUnlock.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  self.Color := clBlack;
  SetBackground(self, RES_BACKGROUND_UNLOCK);
end;

procedure TfrmUnlock.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfrmUnlock.FormShow(Sender: TObject);
begin
  SetForegroundWindow(self.WindowHandle);
end;

class function TfrmUnlock.RunModal: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmUnlock) then
  begin
    Application.CreateForm(TfrmUnlock, frmUnlock);
    result := frmUnlock.ShowModal;
    FreeAndNil(frmUnlock);
  end
  else
    result := -1;
end;

end.
