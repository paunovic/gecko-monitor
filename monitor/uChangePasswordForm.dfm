object frmChangePassword: TfrmChangePassword
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Change Password'
  ClientHeight = 138
  ClientWidth = 352
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object edOldPassword: TEdit
    Left = 138
    Top = 11
    Width = 203
    Height = 19
    Ctl3D = False
    MaxLength = 64
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
  end
  object lbOldPassword: TcxLabel
    Left = 8
    Top = 8
    AutoSize = False
    Caption = 'Old password:'
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
    Width = 131
    AnchorY = 19
  end
  object btOk: TcxButton
    Left = 152
    Top = 99
    Width = 88
    Height = 28
    Caption = 'OK'
    LookAndFeel.SkinName = 'VS2010'
    TabOrder = 3
    OnClick = btOkClick
  end
  object btCancel: TcxButton
    Left = 253
    Top = 99
    Width = 88
    Height = 28
    Caption = 'Cancel'
    LookAndFeel.SkinName = 'VS2010'
    ModalResult = 2
    TabOrder = 4
  end
  object edNewPassword1: TEdit
    Left = 138
    Top = 39
    Width = 203
    Height = 19
    Ctl3D = False
    MaxLength = 64
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object lbNewPassword1: TcxLabel
    Left = 8
    Top = 36
    AutoSize = False
    Caption = 'New password:'
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
    Width = 131
    AnchorY = 47
  end
  object edNewPassword2: TEdit
    Left = 138
    Top = 66
    Width = 203
    Height = 19
    Ctl3D = False
    MaxLength = 64
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 2
  end
  object lbNewPassword2: TcxLabel
    Left = 8
    Top = 63
    AutoSize = False
    Caption = 'Confirm password:'
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
    Width = 131
    AnchorY = 74
  end
end
