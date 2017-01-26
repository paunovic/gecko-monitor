unit uFirstStartForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Menus, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinVS2010, cxLabel,
  cxTextEdit, Vcl.StdCtrls, cxButtons, cxMaskEdit;

type
  TfrmFirstStart = class(TForm)
    lbHeader: TcxLabel;
    lbHotkey: TcxLabel;
    lbHotkeyFooter: TcxLabel;
    lbPassword: TcxLabel;
    lbConfirmPassword: TcxLabel;
    btOk: TcxButton;
    btExit: TcxButton;
    edPassword: TEdit;
    edPasswordConfirm: TEdit;
    cxLabel1: TcxLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function RunModal: Integer;
  end;

var
  frmFirstStart: TfrmFirstStart;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, uResources, uDataModel;


class function TfrmFirstStart.RunModal: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmFirstStart) then
  begin
    Application.CreateForm(TfrmFirstStart, frmFirstStart);
    result := frmFirstStart.ShowModal;
    FreeAndNil(frmFirstStart);
  end
  else
    result := -1;
end;


procedure TfrmFirstStart.btOkClick(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if (edPassword.Text = edPasswordConfirm.Text) and
     (edPassword.Text <> '') then
  begin
    DataModel.Settings.General.Password := TShortString(edPassword.Text);
    ModalResult := mrOk;
  end
  else
    edPassword.SetFocus;
end;

procedure TfrmFirstStart.edPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_RETURN then
    SelectNext((Sender as TWinControl), TRUE, TRUE);
end;

procedure TfrmFirstStart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  Action := caFree;
end;

procedure TfrmFirstStart.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  self.Color := clBlack;
  SetBackground(self, RES_BACKGROUND_FIRSTFORM);
  lbHotkey.Caption := ShortcutToText(DataModel.Settings.General.ShowHideHotkey);
end;

end.

