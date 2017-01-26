unit uIgnoreItemAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinVS2010,
  cxTextEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons;

type
  TfrmIgnoreItemAdd = class(TForm)
    teItem: TcxTextEdit;
    btOk: TcxButton;
    btCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    class function RunModal(var AItem: String; const ADefaultText: String = ''): Integer;
  end;

var
  frmIgnoreItemAdd: TfrmIgnoreItemAdd;

implementation

{$R *.dfm}

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon, uDataModel;


procedure TfrmIgnoreItemAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  Action := caHide;
end;

procedure TfrmIgnoreItemAdd.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_RETURN: btOK.Click;
    vk_ESCAPE: btCancel.Click;
  end;
end;

class function TfrmIgnoreItemAdd.RunModal(var AItem: String; const ADefaultText: String = ''): Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if not Assigned(frmIgnoreItemAdd) then
  begin
    Application.CreateForm(TfrmIgnoreItemAdd, frmIgnoreItemAdd);
    frmIgnoreItemAdd.teItem.Text := ADefaultText;
    result := frmIgnoreItemAdd.ShowModal;
    AItem := frmIgnoreItemAdd.teItem.Text;
  end
  else
    result := -1;
end;

end.
