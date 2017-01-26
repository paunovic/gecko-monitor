object frmTrialRegister: TfrmTrialRegister
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Gecko Monitor'
  ClientHeight = 197
  ClientWidth = 315
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    315
    197)
  PixelsPerInch = 96
  TextHeight = 13
  object lbHotkey: TcxLabel
    Left = 26
    Top = 14
    Caption = 'Serial:'
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
    Width = 44
    AnchorX = 48
    AnchorY = 26
  end
  object lbHeader: TcxLabel
    Left = 8
    Top = 48
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      'To unlock the full version of Gecko Monitor click the visit webs' +
      'ite link below to purchase, then come back here to enter your se' +
      'rial and click OK.'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.WordWrap = True
    Transparent = True
    Height = 81
    Width = 299
  end
  object btOk: TcxButton
    Left = 62
    Top = 161
    Width = 89
    Height = 28
    Anchors = [akLeft, akRight]
    Caption = 'OK'
    Default = True
    LookAndFeel.SkinName = 'VS2010'
    TabOrder = 1
    OnClick = btOkClick
  end
  object btExit: TcxButton
    Left = 172
    Top = 161
    Width = 89
    Height = 28
    Anchors = [akLeft, akRight]
    Cancel = True
    Caption = 'Cancel'
    LookAndFeel.SkinName = 'VS2010'
    ModalResult = 2
    TabOrder = 2
  end
  object lbPurchaseURL: TcxLabel
    Left = 8
    Top = 129
    Cursor = crHandPoint
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Purchase from Gecko website now'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Calibri'
    Style.Font.Style = []
    Style.TextColor = clRed
    Style.TextStyle = [fsUnderline]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.WordWrap = True
    Transparent = True
    OnClick = lbPurchaseURLClick
    Height = 25
    Width = 299
    AnchorX = 158
  end
  object meSerial: TcxMaskEdit
    Left = 76
    Top = 16
    ParentFont = False
    Properties.CharCase = ecUpperCase
    Properties.EditMask = 'CCCCC-CCCCC-CCCCC-CCCCC-CCCCC'
    Properties.MaxLength = 0
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Courier New'
    Style.Font.Style = []
    Style.LookAndFeel.SkinName = 'VS2010'
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.SkinName = 'VS2010'
    StyleFocused.LookAndFeel.SkinName = 'VS2010'
    StyleHot.LookAndFeel.SkinName = 'VS2010'
    TabOrder = 0
    Text = '     -     -     -     -     '
    Width = 210
  end
end
