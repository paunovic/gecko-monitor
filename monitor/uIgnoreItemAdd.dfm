object frmIgnoreItemAdd: TfrmIgnoreItemAdd
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Add item to ignore list'
  ClientHeight = 69
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  DesignSize = (
    442
    69)
  PixelsPerInch = 96
  TextHeight = 13
  object teItem: TcxTextEdit
    Left = 8
    Top = 8
    Anchors = [akLeft, akTop, akRight]
    Properties.MaxLength = 255
    Style.LookAndFeel.SkinName = 'VS2010'
    StyleDisabled.LookAndFeel.SkinName = 'VS2010'
    StyleFocused.LookAndFeel.SkinName = 'VS2010'
    StyleHot.LookAndFeel.SkinName = 'VS2010'
    TabOrder = 0
    Width = 425
  end
  object btOk: TcxButton
    Left = 352
    Top = 34
    Width = 81
    Height = 28
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'OK'
    LookAndFeel.SkinName = 'VS2010'
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TcxButton
    Left = 265
    Top = 34
    Width = 81
    Height = 28
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    LookAndFeel.SkinName = 'VS2010'
    ModalResult = 2
    TabOrder = 2
  end
end
