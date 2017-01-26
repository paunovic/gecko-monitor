unit uChangePasswordForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinVS2010,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel;

type
  TfrmChangePassword = class(TForm)
    edOldPassword: TEdit;
    lbOldPassword: TcxLabel;
    btOk: TcxButton;
    btCancel: TcxButton;
    edNewPassword1: TEdit;
    lbNewPassword1: TcxLabel;
    edNewPassword2: TEdit;
    lbNewPassword2: TcxLabel;
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function RunModal: Integer;
  end;

var
  frmChangePassword: TfrmChangePassword;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, uResources, uDataModel;


procedure TfrmChangePassword.btOkClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if TShortString(edOldPassword.Text) <> DataModel.Settings.General.Password then
  begin
    edOldPassword.SetFocus;
    MessageDlg('Incorrect password!', mtError, [mbOk], 0);
  end
  else
    if (edNewPassword1.Text <> edNewPassword2.Text) then
    begin
      edNewPassword1.SetFocus;
      MessageDlg('New passwords aren''t same!', mtError, [mbOk], 0);
    end
    else
    begin
      DataModel.Settings.General.Password := TShortString(edNewPassword1.Text);
      MessageDlg('Password successfully changed!', mtInformation, [mbOk], 0);
      ModalResult := mrOk;
    end;
end;

procedure TfrmChangePassword.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}
end;

procedure TfrmChangePassword.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_RETURN: self.SelectNext(ActiveControl, TRUE, TRUE);
    vk_ESCAPE: ModalResult := mrCancel;
  end;
end;

class function TfrmChangePassword.RunModal: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmChangePassword) then
  begin
    Application.CreateForm(TfrmChangePassword, frmChangePassword);
    result := frmChangePassword.ShowModal;
    FreeAndNil(frmChangePassword);
  end
  else
    result := -1;
end;

end.
