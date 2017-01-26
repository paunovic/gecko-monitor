object frmFirstStart: TfrmFirstStart
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Gecko Monitor'
  ClientHeight = 337
  ClientWidth = 415
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    415
    337)
  PixelsPerInch = 96
  TextHeight = 13
  object lbHeader: TcxLabel
    Left = 9
    Top = 36
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 
      'As this is your first time running Gecko Monitor you will need t' +
      'o enter your chosen password. Please don'#39't forget this password ' +
      'as you'#39'll need it to open Gecko Monitor in future.'#13#10#13#10'For stealt' +
      'h reasons, Gecko Monitor will always start in hidden mode, unles' +
      's you change the option in settings. To unhide use the key combi' +
      'nation:'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.WordWrap = True
    Transparent = True
    Height = 138
    Width = 406
  end
  object lbHotkey: TcxLabel
    Left = 9
    Top = 174
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Ctrl+Alt+F12'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.TextStyle = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 35
    Width = 406
    AnchorX = 212
    AnchorY = 192
  end
  object lbHotkeyFooter: TcxLabel
    Left = 9
    Top = 204
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = '(this can also be changed in settings)'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 24
    Width = 406
    AnchorX = 212
    AnchorY = 216
  end
  object lbPassword: TcxLabel
    Left = 25
    Top = 241
    Anchors = [akLeft, akRight]
    AutoSize = False
    Caption = 'Password:'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 21
    Width = 132
    AnchorX = 157
    AnchorY = 252
  end
  object lbConfirmPassword: TcxLabel
    Left = 25
    Top = 265
    Anchors = [akLeft, akRight]
    AutoSize = False
    Caption = 'Confirm Password:'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 21
    Width = 132
    AnchorX = 157
    AnchorY = 276
  end
  object btOk: TcxButton
    Left = 216
    Top = 301
    Width = 88
    Height = 28
    Anchors = [akLeft, akRight]
    Caption = 'OK'
    LookAndFeel.SkinName = 'VS2010'
    TabOrder = 2
    OnClick = btOkClick
  end
  object btExit: TcxButton
    Left = 317
    Top = 301
    Width = 88
    Height = 28
    Anchors = [akLeft, akRight]
    Caption = 'Exit'
    LookAndFeel.SkinName = 'VS2010'
    ModalResult = 2
    TabOrder = 3
  end
  object edPassword: TEdit
    Left = 166
    Top = 243
    Width = 203
    Height = 19
    Anchors = [akLeft, akBottom]
    Ctl3D = False
    MaxLength = 64
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
    OnKeyDown = edPasswordKeyDown
  end
  object edPasswordConfirm: TEdit
    Left = 166
    Top = 267
    Width = 203
    Height = 19
    Anchors = [akLeft, akBottom]
    Ctl3D = False
    MaxLength = 64
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = edPasswordKeyDown
  end
  object cxLabel1: TcxLabel
    Left = 9
    Top = 6
    AutoSize = False
    Caption = 'Welcome to Gecko Monitor!'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.TextStyle = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 35
    Width = 406
    AnchorX = 212
    AnchorY = 24
  end
end
