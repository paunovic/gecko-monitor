object frmUnlock: TfrmUnlock
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Enter Password'
  ClientHeight = 110
  ClientWidth = 373
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edPassword: TEdit
    Left = 95
    Top = 39
    Width = 203
    Height = 19
    Ctl3D = False
    MaxLength = 16
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
    OnKeyDown = edPasswordKeyDown
  end
  object lbPassword: TcxLabel
    Left = 8
    Top = 8
    AutoSize = False
    Caption = 'To unlock Gecko Monitor, please enter your password:'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 21
    Width = 357
    AnchorY = 19
  end
  object btOk: TcxButton
    Left = 102
    Top = 71
    Width = 88
    Height = 28
    Caption = 'OK'
    LookAndFeel.SkinName = 'VS2010'
    TabOrder = 2
    OnClick = btOkClick
  end
  object btCancel: TcxButton
    Left = 203
    Top = 71
    Width = 88
    Height = 28
    Caption = 'Cancel'
    LookAndFeel.SkinName = 'VS2010'
    ModalResult = 2
    TabOrder = 3
  end
end
