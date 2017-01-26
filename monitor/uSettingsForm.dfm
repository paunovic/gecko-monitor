object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 534
  ClientWidth = 739
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object paSettingsPicker: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 150
    Height = 488
    Align = alLeft
    BevelOuter = bvNone
    Ctl3D = False
    DoubleBuffered = True
    Padding.Left = 10
    Padding.Top = 9
    Padding.Right = 10
    Padding.Bottom = 10
    ParentColor = True
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ShowCaption = False
    TabOrder = 0
    object lbSettingsPicker: TAdvSmoothListBox
      Left = 10
      Top = 9
      Width = 130
      Height = 469
      Cursor = crDefault
      Fill.Color = clWhite
      Fill.ColorTo = clWhite
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtSolid
      Fill.GradientMirrorType = gtSolid
      Fill.BorderColor = clBlack
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Glow = gmNone
      Items = <
        item
          Caption = 'General'
          GraphicRightHeight = 30
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Tahoma'
          CaptionFont.Style = []
          CaptionSelectedFont.Charset = DEFAULT_CHARSET
          CaptionSelectedFont.Color = clWindowText
          CaptionSelectedFont.Height = -11
          CaptionSelectedFont.Name = 'Tahoma'
          CaptionSelectedFont.Style = []
          InfoFont.Charset = DEFAULT_CHARSET
          InfoFont.Color = clWindowText
          InfoFont.Height = -11
          InfoFont.Name = 'Tahoma'
          InfoFont.Style = []
          InfoSelectedFont.Charset = DEFAULT_CHARSET
          InfoSelectedFont.Color = clWindowText
          InfoSelectedFont.Height = -11
          InfoSelectedFont.Name = 'Tahoma'
          InfoSelectedFont.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          NotesSelectedFont.Charset = DEFAULT_CHARSET
          NotesSelectedFont.Color = clWindowText
          NotesSelectedFont.Height = -11
          NotesSelectedFont.Name = 'Tahoma'
          NotesSelectedFont.Style = []
          Selected = True
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 13087391
        end
        item
          Caption = 'Screenshots'
          GraphicRightHeight = 30
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Tahoma'
          CaptionFont.Style = []
          CaptionSelectedFont.Charset = DEFAULT_CHARSET
          CaptionSelectedFont.Color = clWindowText
          CaptionSelectedFont.Height = -11
          CaptionSelectedFont.Name = 'Tahoma'
          CaptionSelectedFont.Style = []
          InfoFont.Charset = DEFAULT_CHARSET
          InfoFont.Color = clWindowText
          InfoFont.Height = -11
          InfoFont.Name = 'Tahoma'
          InfoFont.Style = []
          InfoSelectedFont.Charset = DEFAULT_CHARSET
          InfoSelectedFont.Color = clWindowText
          InfoSelectedFont.Height = -11
          InfoSelectedFont.Name = 'Tahoma'
          InfoSelectedFont.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          NotesSelectedFont.Charset = DEFAULT_CHARSET
          NotesSelectedFont.Color = clWindowText
          NotesSelectedFont.Height = -11
          NotesSelectedFont.Name = 'Tahoma'
          NotesSelectedFont.Style = []
          ProgressMaximum = 100.000000000000000000
        end
        item
          Caption = 'Keylogger'
          GraphicRightHeight = 30
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Tahoma'
          CaptionFont.Style = []
          CaptionSelectedFont.Charset = DEFAULT_CHARSET
          CaptionSelectedFont.Color = clWindowText
          CaptionSelectedFont.Height = -11
          CaptionSelectedFont.Name = 'Tahoma'
          CaptionSelectedFont.Style = []
          InfoFont.Charset = DEFAULT_CHARSET
          InfoFont.Color = clWindowText
          InfoFont.Height = -11
          InfoFont.Name = 'Tahoma'
          InfoFont.Style = []
          InfoSelectedFont.Charset = DEFAULT_CHARSET
          InfoSelectedFont.Color = clWindowText
          InfoSelectedFont.Height = -11
          InfoSelectedFont.Name = 'Tahoma'
          InfoSelectedFont.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          NotesSelectedFont.Charset = DEFAULT_CHARSET
          NotesSelectedFont.Color = clWindowText
          NotesSelectedFont.Height = -11
          NotesSelectedFont.Name = 'Tahoma'
          NotesSelectedFont.Style = []
          ProgressMaximum = 100.000000000000000000
        end
        item
          Caption = 'Websites'
          GraphicRightHeight = 30
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Tahoma'
          CaptionFont.Style = []
          CaptionSelectedFont.Charset = DEFAULT_CHARSET
          CaptionSelectedFont.Color = clWindowText
          CaptionSelectedFont.Height = -11
          CaptionSelectedFont.Name = 'Tahoma'
          CaptionSelectedFont.Style = []
          InfoFont.Charset = DEFAULT_CHARSET
          InfoFont.Color = clWindowText
          InfoFont.Height = -11
          InfoFont.Name = 'Tahoma'
          InfoFont.Style = []
          InfoSelectedFont.Charset = DEFAULT_CHARSET
          InfoSelectedFont.Color = clWindowText
          InfoSelectedFont.Height = -11
          InfoSelectedFont.Name = 'Tahoma'
          InfoSelectedFont.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          NotesSelectedFont.Charset = DEFAULT_CHARSET
          NotesSelectedFont.Color = clWindowText
          NotesSelectedFont.Height = -11
          NotesSelectedFont.Name = 'Tahoma'
          NotesSelectedFont.Style = []
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 13087391
        end
        item
          Caption = 'Printers'
          GraphicRightHeight = 30
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Tahoma'
          CaptionFont.Style = []
          CaptionSelectedFont.Charset = DEFAULT_CHARSET
          CaptionSelectedFont.Color = clWindowText
          CaptionSelectedFont.Height = -11
          CaptionSelectedFont.Name = 'Tahoma'
          CaptionSelectedFont.Style = []
          InfoFont.Charset = DEFAULT_CHARSET
          InfoFont.Color = clWindowText
          InfoFont.Height = -11
          InfoFont.Name = 'Tahoma'
          InfoFont.Style = []
          InfoSelectedFont.Charset = DEFAULT_CHARSET
          InfoSelectedFont.Color = clWindowText
          InfoSelectedFont.Height = -11
          InfoSelectedFont.Name = 'Tahoma'
          InfoSelectedFont.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          NotesSelectedFont.Charset = DEFAULT_CHARSET
          NotesSelectedFont.Color = clWindowText
          NotesSelectedFont.Height = -11
          NotesSelectedFont.Name = 'Tahoma'
          NotesSelectedFont.Style = []
          Selected = True
          ProgressMaximum = 100.000000000000000000
        end
        item
          Caption = 'Files'
          GraphicRightHeight = 30
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clWindowText
          CaptionFont.Height = -11
          CaptionFont.Name = 'Tahoma'
          CaptionFont.Style = []
          CaptionSelectedFont.Charset = DEFAULT_CHARSET
          CaptionSelectedFont.Color = clWindowText
          CaptionSelectedFont.Height = -11
          CaptionSelectedFont.Name = 'Tahoma'
          CaptionSelectedFont.Style = []
          InfoFont.Charset = DEFAULT_CHARSET
          InfoFont.Color = clWindowText
          InfoFont.Height = -11
          InfoFont.Name = 'Tahoma'
          InfoFont.Style = []
          InfoSelectedFont.Charset = DEFAULT_CHARSET
          InfoSelectedFont.Color = clWindowText
          InfoSelectedFont.Height = -11
          InfoSelectedFont.Name = 'Tahoma'
          InfoSelectedFont.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          NotesSelectedFont.Charset = DEFAULT_CHARSET
          NotesSelectedFont.Color = clWindowText
          NotesSelectedFont.Height = -11
          NotesSelectedFont.Name = 'Tahoma'
          NotesSelectedFont.Style = []
          ProgressMaximum = 100.000000000000000000
        end>
      ItemAppearance.Fill.Color = clWhite
      ItemAppearance.Fill.ColorTo = 16773087
      ItemAppearance.Fill.ColorMirror = clNone
      ItemAppearance.Fill.ColorMirrorTo = clNone
      ItemAppearance.Fill.GradientType = gtVertical
      ItemAppearance.Fill.GradientMirrorType = gtVertical
      ItemAppearance.Fill.BorderColor = 15592940
      ItemAppearance.Fill.Rounding = 0
      ItemAppearance.Fill.ShadowOffset = 0
      ItemAppearance.Fill.Glow = gmNone
      ItemAppearance.FillSelected.Color = 7131391
      ItemAppearance.FillSelected.ColorTo = clNone
      ItemAppearance.FillSelected.ColorMirror = clNone
      ItemAppearance.FillSelected.ColorMirrorTo = clNone
      ItemAppearance.FillSelected.GradientType = gtVertical
      ItemAppearance.FillSelected.GradientMirrorType = gtVertical
      ItemAppearance.FillSelected.BorderColor = 3181250
      ItemAppearance.FillSelected.Rounding = 0
      ItemAppearance.FillSelected.ShadowOffset = 0
      ItemAppearance.FillSelected.Glow = gmGradient
      ItemAppearance.FillSelected.GlowGradientColor = 8122111
      ItemAppearance.FillDisabled.Color = 15921906
      ItemAppearance.FillDisabled.ColorTo = 11974326
      ItemAppearance.FillDisabled.ColorMirror = clNone
      ItemAppearance.FillDisabled.ColorMirrorTo = clNone
      ItemAppearance.FillDisabled.GradientType = gtVertical
      ItemAppearance.FillDisabled.GradientMirrorType = gtVertical
      ItemAppearance.FillDisabled.BorderColor = 9841920
      ItemAppearance.FillDisabled.Rounding = 0
      ItemAppearance.FillDisabled.ShadowOffset = 0
      ItemAppearance.FillDisabled.Glow = gmNone
      ItemAppearance.ProgressAppearance.BackGroundFill.Color = 16765615
      ItemAppearance.ProgressAppearance.BackGroundFill.ColorTo = 16765615
      ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirror = clNone
      ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
      ItemAppearance.ProgressAppearance.BackGroundFill.GradientType = gtVertical
      ItemAppearance.ProgressAppearance.BackGroundFill.GradientMirrorType = gtSolid
      ItemAppearance.ProgressAppearance.BackGroundFill.BorderColor = clSilver
      ItemAppearance.ProgressAppearance.BackGroundFill.Rounding = 0
      ItemAppearance.ProgressAppearance.BackGroundFill.ShadowOffset = 0
      ItemAppearance.ProgressAppearance.BackGroundFill.Glow = gmNone
      ItemAppearance.ProgressAppearance.ProgressFill.Color = 16773091
      ItemAppearance.ProgressAppearance.ProgressFill.ColorTo = 16768452
      ItemAppearance.ProgressAppearance.ProgressFill.ColorMirror = 16765357
      ItemAppearance.ProgressAppearance.ProgressFill.ColorMirrorTo = 16767936
      ItemAppearance.ProgressAppearance.ProgressFill.GradientType = gtVertical
      ItemAppearance.ProgressAppearance.ProgressFill.GradientMirrorType = gtVertical
      ItemAppearance.ProgressAppearance.ProgressFill.BorderColor = 16765357
      ItemAppearance.ProgressAppearance.ProgressFill.Rounding = 0
      ItemAppearance.ProgressAppearance.ProgressFill.ShadowOffset = 0
      ItemAppearance.ProgressAppearance.ProgressFill.Glow = gmNone
      ItemAppearance.ProgressAppearance.Font.Charset = DEFAULT_CHARSET
      ItemAppearance.ProgressAppearance.Font.Color = clWindowText
      ItemAppearance.ProgressAppearance.Font.Height = -11
      ItemAppearance.ProgressAppearance.Font.Name = 'Tahoma'
      ItemAppearance.ProgressAppearance.Font.Style = []
      ItemAppearance.ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
      ItemAppearance.ProgressAppearance.ProgressFont.Color = clWindowText
      ItemAppearance.ProgressAppearance.ProgressFont.Height = -11
      ItemAppearance.ProgressAppearance.ProgressFont.Name = 'Tahoma'
      ItemAppearance.ProgressAppearance.ProgressFont.Style = []
      ItemAppearance.ProgressAppearance.ValueFormat = '%.0f%%'
      ItemAppearance.ButtonAppearance.Font.Charset = DEFAULT_CHARSET
      ItemAppearance.ButtonAppearance.Font.Color = clWindowText
      ItemAppearance.ButtonAppearance.Font.Height = -11
      ItemAppearance.ButtonAppearance.Font.Name = 'Tahoma'
      ItemAppearance.ButtonAppearance.Font.Style = []
      ItemAppearance.VerticalSpacing = 1
      ItemAppearance.InfoFill.ColorMirror = clNone
      ItemAppearance.InfoFill.ColorMirrorTo = clNone
      ItemAppearance.InfoFill.GradientType = gtVertical
      ItemAppearance.InfoFill.GradientMirrorType = gtSolid
      ItemAppearance.InfoFill.BorderColor = clNone
      ItemAppearance.InfoFill.Rounding = 0
      ItemAppearance.InfoFill.ShadowOffset = 0
      ItemAppearance.InfoFill.Glow = gmNone
      ItemAppearance.InfoFillSelected.ColorMirror = clNone
      ItemAppearance.InfoFillSelected.ColorMirrorTo = clNone
      ItemAppearance.InfoFillSelected.GradientType = gtVertical
      ItemAppearance.InfoFillSelected.GradientMirrorType = gtSolid
      ItemAppearance.InfoFillSelected.BorderColor = clNone
      ItemAppearance.InfoFillSelected.Rounding = 0
      ItemAppearance.InfoFillSelected.ShadowOffset = 0
      ItemAppearance.InfoFillSelected.Glow = gmNone
      ItemAppearance.InfoFillDisabled.ColorMirror = clNone
      ItemAppearance.InfoFillDisabled.ColorMirrorTo = clNone
      ItemAppearance.InfoFillDisabled.GradientType = gtVertical
      ItemAppearance.InfoFillDisabled.GradientMirrorType = gtSolid
      ItemAppearance.InfoFillDisabled.BorderColor = clNone
      ItemAppearance.InfoFillDisabled.Rounding = 0
      ItemAppearance.InfoFillDisabled.ShadowOffset = 0
      ItemAppearance.InfoFillDisabled.Glow = gmNone
      ItemAppearance.DeleteButtonCaption = 'Delete'
      LookupBar.Visible = False
      LookupBar.Font.Charset = DEFAULT_CHARSET
      LookupBar.Font.Color = clWindowText
      LookupBar.Font.Height = -11
      LookupBar.Font.Name = 'Tahoma'
      LookupBar.Font.Style = []
      LookupBar.DisabledFont.Charset = DEFAULT_CHARSET
      LookupBar.DisabledFont.Color = clSilver
      LookupBar.DisabledFont.Height = -11
      LookupBar.DisabledFont.Name = 'Tahoma'
      LookupBar.DisabledFont.Style = []
      Sections.Font.Charset = DEFAULT_CHARSET
      Sections.Font.Color = clWindowText
      Sections.Font.Height = -11
      Sections.Font.Name = 'Tahoma'
      Sections.Font.Style = []
      Sections.BorderColor = clBlack
      SelectedItemIndex = 0
      Header.Fill.Color = 16643823
      Header.Fill.ColorTo = 15784647
      Header.Fill.ColorMirror = clNone
      Header.Fill.ColorMirrorTo = clNone
      Header.Fill.GradientType = gtVertical
      Header.Fill.GradientMirrorType = gtSolid
      Header.Fill.BorderColor = 13087391
      Header.Fill.Rounding = 0
      Header.Fill.ShadowOffset = 0
      Header.Fill.Glow = gmNone
      Header.Caption = 'Header'
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = 5978398
      Header.Font.Height = -13
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Visible = False
      Filter.Fill.Color = 16643823
      Filter.Fill.ColorMirror = clNone
      Filter.Fill.ColorMirrorTo = clNone
      Filter.Fill.GradientType = gtSolid
      Filter.Fill.GradientMirrorType = gtSolid
      Filter.Fill.BorderColor = 13087391
      Filter.Fill.Rounding = 0
      Filter.Fill.ShadowOffset = 0
      Filter.Fill.Glow = gmNone
      Filter.Enabled = False
      Footer.Fill.Color = 16643823
      Footer.Fill.ColorTo = 15784647
      Footer.Fill.ColorMirror = clNone
      Footer.Fill.ColorMirrorTo = clNone
      Footer.Fill.GradientType = gtVertical
      Footer.Fill.GradientMirrorType = gtSolid
      Footer.Fill.BorderColor = 13087391
      Footer.Fill.Rounding = 0
      Footer.Fill.ShadowOffset = 0
      Footer.Fill.Glow = gmNone
      Footer.Caption = 'Footer'
      Footer.Font.Charset = DEFAULT_CHARSET
      Footer.Font.Color = 5978398
      Footer.Font.Height = -13
      Footer.Font.Name = 'Tahoma'
      Footer.Font.Style = []
      Footer.Visible = False
      ScrollIndicator.Visible = False
      OnItemChanged = lbSettingsPickerItemChanged
      ShowFocus = False
      DefaultItem.Caption = 'Item 0'
      DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
      DefaultItem.CaptionFont.Color = clWindowText
      DefaultItem.CaptionFont.Height = -11
      DefaultItem.CaptionFont.Name = 'Tahoma'
      DefaultItem.CaptionFont.Style = []
      DefaultItem.CaptionSelectedFont.Charset = DEFAULT_CHARSET
      DefaultItem.CaptionSelectedFont.Color = clWindowText
      DefaultItem.CaptionSelectedFont.Height = -11
      DefaultItem.CaptionSelectedFont.Name = 'Tahoma'
      DefaultItem.CaptionSelectedFont.Style = []
      DefaultItem.InfoFont.Charset = DEFAULT_CHARSET
      DefaultItem.InfoFont.Color = clWindowText
      DefaultItem.InfoFont.Height = -11
      DefaultItem.InfoFont.Name = 'Tahoma'
      DefaultItem.InfoFont.Style = []
      DefaultItem.InfoSelectedFont.Charset = DEFAULT_CHARSET
      DefaultItem.InfoSelectedFont.Color = clWindowText
      DefaultItem.InfoSelectedFont.Height = -11
      DefaultItem.InfoSelectedFont.Name = 'Tahoma'
      DefaultItem.InfoSelectedFont.Style = []
      DefaultItem.NotesFont.Charset = DEFAULT_CHARSET
      DefaultItem.NotesFont.Color = clWindowText
      DefaultItem.NotesFont.Height = -11
      DefaultItem.NotesFont.Name = 'Tahoma'
      DefaultItem.NotesFont.Style = []
      DefaultItem.NotesSelectedFont.Charset = DEFAULT_CHARSET
      DefaultItem.NotesSelectedFont.Color = clWindowText
      DefaultItem.NotesSelectedFont.Height = -11
      DefaultItem.NotesSelectedFont.Name = 'Tahoma'
      DefaultItem.NotesSelectedFont.Style = []
      DefaultItem.ProgressMaximum = 100.000000000000000000
      SelectionMode = sPersistSelection
      ItemDragging = False
      Categories = <>
      EnableDragging = False
      Align = alClient
      TabOrder = 0
      Parent = paSettingsPicker
    end
  end
  object paSettings: TPanel
    Left = 156
    Top = 0
    Width = 583
    Height = 494
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    DoubleBuffered = True
    Padding.Top = 12
    Padding.Right = 12
    Padding.Bottom = 13
    ParentColor = True
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ShowCaption = False
    TabOrder = 1
    object paInSettings: TAdvPanel
      Left = 0
      Top = 12
      Width = 571
      Height = 469
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UseDockManager = True
      Version = '2.1.0.4'
      BorderWidth = 1
      Caption.Color = clHighlight
      Caption.ColorTo = clNone
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clWindowText
      Caption.Font.Height = -11
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = []
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      FullHeight = 200
      object PageControl: TcxPageControl
        Left = 1
        Top = 1
        Width = 569
        Height = 467
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = tabGeneral
        Properties.HideTabs = True
        ClientRectBottom = 467
        ClientRectRight = 569
        ClientRectTop = 0
        object tabGeneral: TcxTabSheet
          Caption = 'tabGeneral'
          ImageIndex = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          DesignSize = (
            569
            467)
          object shHeader1: TShape
            Left = 8
            Top = 7
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 418
          end
          object shheader6: TShape
            Left = 8
            Top = 235
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
          end
          object lbHeader1: TcxLabel
            Left = 16
            Top = 8
            Caption = 'Application Behaviour'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object chbStartWindows: TcxCheckBox
            Left = 20
            Top = 69
            AutoSize = False
            Caption = 'Start Gecko Monitor with Windows'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 1
            Height = 21
            Width = 257
          end
          object lbHotkeyShowApp: TcxLabel
            Left = 20
            Top = 40
            AutoSize = False
            Caption = 'Show/hide shortcut'
            Height = 17
            Width = 101
          end
          object chbAutoMonitor: TcxCheckBox
            Left = 20
            Top = 96
            AutoSize = False
            Caption = 'Start hidden and automatically monitor activities'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 2
            Height = 21
            Width = 257
          end
          object btUninstall: TcxButton
            Left = 412
            Top = 74
            Width = 130
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Uninstall Gecko Monitor'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 8
            OnClick = btUninstallClick
          end
          object lbHeader6: TcxLabel
            Left = 16
            Top = 236
            Caption = 'Remote Reporting'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object chbReportMail: TcxCheckBox
            Left = 20
            Top = 266
            AutoSize = False
            Caption = 'Send logs via E-Mail'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 9
            Height = 21
            Width = 257
          end
          object lbReportRecp: TcxLabel
            Left = 20
            Top = 324
            AutoSize = False
            Caption = 'Send mails to:'
            Height = 17
            Width = 85
          end
          object teReportRecp: TcxTextEdit
            Left = 108
            Top = 323
            Properties.MaxLength = 64
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 11
            Width = 170
          end
          object lbSMTPUser: TcxLabel
            Left = 20
            Top = 405
            AutoSize = False
            Caption = 'Username:'
            Height = 17
            Width = 73
          end
          object teSMTPUsername: TcxTextEdit
            Left = 108
            Top = 404
            Properties.MaxLength = 64
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 14
            Width = 170
          end
          object lbReportSubject: TcxLabel
            Left = 20
            Top = 351
            AutoSize = False
            Caption = 'Mail subject:'
            Height = 17
            Width = 85
          end
          object teReportSubject: TcxTextEdit
            Left = 108
            Top = 350
            Properties.MaxLength = 64
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 12
            Width = 170
          end
          object lbSMTPServer: TcxLabel
            Left = 300
            Top = 324
            AutoSize = False
            Caption = 'SMTP server:'
            Height = 17
            Width = 73
          end
          object teSMTPServer: TcxTextEdit
            Left = 372
            Top = 323
            Properties.MaxLength = 64
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 16
            Width = 170
          end
          object teSMTPPassword: TcxTextEdit
            Left = 108
            Top = 431
            Properties.BeepOnError = True
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 64
            Properties.PasswordChar = '*'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 15
            Width = 170
          end
          object lbSMTPPass: TcxLabel
            Left = 20
            Top = 432
            AutoSize = False
            Caption = 'Password:'
            Height = 17
            Width = 73
          end
          object lbSMTPPort: TcxLabel
            Left = 300
            Top = 351
            AutoSize = False
            Caption = 'SMTP port:'
            Height = 17
            Width = 73
          end
          object seSMTPPort: TcxSpinEdit
            Left = 372
            Top = 350
            Properties.SpinButtons.Visible = False
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 17
            Width = 57
          end
          object lbReportInterval: TcxLabel
            Left = 19
            Top = 379
            AutoSize = False
            Caption = 'Send on every:'
            Height = 17
            Width = 85
          end
          object chbReportResetLogs: TcxCheckBox
            Left = 20
            Top = 293
            AutoSize = False
            Caption = 'Reset logs after report is successfuly sent'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 10
            Height = 21
            Width = 257
          end
          object seReportInterval: TcxSpinEdit
            Left = 108
            Top = 377
            Properties.MinValue = 5.000000000000000000
            Properties.SpinButtons.Visible = False
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 13
            Value = 5
            Width = 49
          end
          object lbReportIntervalMins: TcxLabel
            Left = 161
            Top = 379
            Caption = 'mins'
          end
          object btReportTest: TcxButton
            Left = 444
            Top = 424
            Width = 98
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Send test mail'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 20
            OnClick = btReportTestClick
          end
          object cbSSLType: TcxComboBox
            Left = 372
            Top = 377
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'None'
              'Implicit'
              'Explicit')
            Style.LookAndFeel.SkinName = 'VS2010'
            Style.ButtonStyle = btsDefault
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 18
            Text = 'None'
            Width = 170
          end
          object cxLabel1: TcxLabel
            Left = 300
            Top = 379
            AutoSize = False
            Caption = 'SSL:'
            Height = 17
            Width = 71
          end
          object btMailHelp: TcxButton
            Left = 444
            Top = 266
            Width = 98
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Need help?'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 19
            OnClick = btMailHelpClick
          end
          object btChangePassword: TcxButton
            Left = 412
            Top = 40
            Width = 130
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Change password'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 7
            OnClick = btChangePasswordClick
          end
          object hkShowHide: THotKey
            Left = 127
            Top = 40
            Width = 150
            Height = 19
            DoubleBuffered = False
            HotKey = 16496
            InvalidKeys = [hcNone]
            Modifiers = [hkCtrl]
            ParentDoubleBuffered = False
            TabOrder = 0
          end
          object chbGeckoTray: TcxCheckBox
            Left = 20
            Top = 124
            Caption = 
              'Show Gecko Monitor in tray (only check if you want to show users' +
              ' that they are being monitored)'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 3
            Width = 488
          end
          object cbElevateGecko: TcxCheckBox
            Left = 20
            Top = 151
            Caption = 
              'Run on standard user accounts (Administrators credentials requir' +
              'ed):'
            Properties.OnChange = cbElevateGeckoPropertiesChange
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 4
            Width = 513
          end
          object lbAdminUsername: TcxLabel
            Left = 48
            Top = 177
            AutoSize = False
            Caption = 'Username:'
            Height = 17
            Width = 61
          end
          object teAdminUsername: TcxTextEdit
            Left = 108
            Top = 176
            Properties.MaxLength = 64
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 5
            Width = 170
          end
          object teAdminPassword: TcxTextEdit
            Left = 108
            Top = 201
            Properties.EchoMode = eemPassword
            Properties.MaxLength = 64
            Properties.PasswordChar = '*'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 6
            Width = 170
          end
          object lbAdminPassword: TcxLabel
            Left = 48
            Top = 202
            AutoSize = False
            Caption = 'Password:'
            Height = 17
            Width = 61
          end
        end
        object tabScreenshots: TcxTabSheet
          Caption = 'tabScreenshots'
          ImageIndex = 1
          DesignSize = (
            569
            467)
          object shHeader2: TShape
            Left = 8
            Top = 7
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 418
          end
          object lbheader2: TcxLabel
            Left = 16
            Top = 8
            Caption = 'Screenshots Settings'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object gbScreenshotInterval: TcxGroupBox
            Left = 11
            Top = 28
            Ctl3D = False
            ParentCtl3D = False
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.LookAndFeel.SkinName = ''
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.SkinName = ''
            TabOrder = 1
            Height = 83
            Width = 325
            object chbScreenshotEvery: TcxCheckBox
              Left = 5
              Top = 10
              AutoSize = False
              Caption = 'Take screenshot every'
              Style.LookAndFeel.SkinName = 'VS2010'
              StyleDisabled.LookAndFeel.SkinName = 'VS2010'
              StyleFocused.LookAndFeel.SkinName = 'VS2010'
              StyleHot.LookAndFeel.SkinName = 'VS2010'
              TabOrder = 0
              Height = 21
              Width = 140
            end
            object seScreenshotInterval: TcxSpinEdit
              Left = 144
              Top = 11
              Properties.MinValue = 1.000000000000000000
              Style.LookAndFeel.SkinName = 'VS2010'
              StyleDisabled.LookAndFeel.SkinName = 'VS2010'
              StyleFocused.LookAndFeel.SkinName = 'VS2010'
              StyleHot.LookAndFeel.SkinName = 'VS2010'
              TabOrder = 1
              Value = 300
              Width = 55
            end
            object lbScreenshotSeconds: TcxLabel
              Left = 203
              Top = 12
              Caption = 'seconds'
              Style.LookAndFeel.SkinName = 'VS2010'
              StyleDisabled.LookAndFeel.SkinName = 'VS2010'
              StyleFocused.LookAndFeel.SkinName = 'VS2010'
              StyleHot.LookAndFeel.SkinName = 'VS2010'
            end
            object rbScrScreen: TcxRadioButton
              Left = 32
              Top = 35
              Width = 122
              Height = 17
              Caption = 'Entire screen'
              TabOrder = 3
              LookAndFeel.SkinName = 'VS2010'
            end
            object rbScrActive: TcxRadioButton
              Left = 32
              Top = 58
              Width = 122
              Height = 17
              Caption = 'Only active window'
              TabOrder = 4
              LookAndFeel.SkinName = 'VS2010'
            end
          end
          object gbScreenshotFocused: TcxGroupBox
            Left = 11
            Top = 111
            Ctl3D = False
            ParentCtl3D = False
            Style.BorderStyle = ebsUltraFlat
            Style.Edges = []
            Style.LookAndFeel.SkinName = ''
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.SkinName = ''
            TabOrder = 2
            Height = 83
            Width = 325
            object chbScreenshotFocused: TcxCheckBox
              Left = 5
              Top = 10
              AutoSize = False
              Caption = 'Take screenshot each time new window is focused'
              Style.LookAndFeel.SkinName = 'VS2010'
              StyleDisabled.LookAndFeel.SkinName = 'VS2010'
              StyleFocused.LookAndFeel.SkinName = 'VS2010'
              StyleHot.LookAndFeel.SkinName = 'VS2010'
              TabOrder = 0
              Height = 21
              Width = 317
            end
            object rbScrFocScreen: TcxRadioButton
              Left = 32
              Top = 35
              Width = 122
              Height = 17
              Caption = 'Entire screen'
              TabOrder = 1
              LookAndFeel.SkinName = 'VS2010'
            end
            object rbScrFocActive: TcxRadioButton
              Left = 32
              Top = 58
              Width = 122
              Height = 17
              Caption = 'Only active window'
              TabOrder = 2
              LookAndFeel.SkinName = 'VS2010'
            end
          end
        end
        object tabKeylogger: TcxTabSheet
          Caption = 'tabKeylogger'
          ImageIndex = 2
          DesignSize = (
            569
            467)
          object shHeader3: TShape
            Left = 8
            Top = 7
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 418
          end
          object lbHeader3: TcxLabel
            Left = 16
            Top = 8
            Caption = 'Keylogger Settings'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object chbBackspaceEmulate: TcxCheckBox
            Left = 16
            Top = 38
            AutoSize = False
            Caption = 'Delete last character when backspace is pressed'
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 1
            Height = 21
            Width = 261
          end
        end
        object tabWebsites: TcxTabSheet
          Caption = 'tabWebsites'
          ImageIndex = 3
          OnShow = tabWebsitesShow
          DesignSize = (
            569
            467)
          object shHeader4: TShape
            Left = 8
            Top = 7
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 418
          end
          object lbHeader4: TcxLabel
            Left = 16
            Top = 8
            Caption = 'Ignore List'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object gridIgnoreSites: TcxGrid
            Left = 16
            Top = 38
            Width = 442
            Height = 415
            TabOrder = 1
            LookAndFeel.SkinName = 'VS2010'
            object gridIgnoreSitesTable: TcxGridBandedTableView
              FilterBox.Visible = fvNever
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.BandMoving = False
              OptionsCustomize.BandSizing = False
              OptionsCustomize.ColumnVertSizing = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.BandHeaders = False
              Bands = <
                item
                end>
              object gridKeyloggerApp: TcxGridBandedColumn
                Caption = 'Site mask'
                PropertiesClassName = 'TcxTextEditProperties'
                SortIndex = 0
                SortOrder = soDescending
                Width = 190
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
            end
            object gridIgnoreSitesLevel: TcxGridLevel
              GridView = gridIgnoreSitesTable
            end
          end
          object btSiteIgnoreAdd: TcxButton
            Left = 470
            Top = 38
            Width = 81
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Add'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 2
            OnClick = btSiteIgnoreAddClick
          end
          object btSiteIgnoreDelete: TcxButton
            Left = 470
            Top = 72
            Width = 81
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Delete'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 3
            OnClick = btSiteIgnoreDeleteClick
          end
          object lbHeaderDescription4: TcxLabel
            Left = 87
            Top = 8
            Caption = 
              '(sites on this list wont appear in website log. * and ? wildcard' +
              's can be used)'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'Tahoma'
            Style.Font.Style = []
            Style.TextColor = clGray
            Style.TextStyle = [fsItalic]
            Style.IsFontAssigned = True
            Transparent = True
          end
        end
        object tabPrinters: TcxTabSheet
          Caption = 'tabPrinters'
          ImageIndex = 5
          OnShow = tabPrintersShow
          ExplicitWidth = 0
          ExplicitHeight = 0
          DesignSize = (
            569
            467)
          object shHeader5: TShape
            Left = 8
            Top = 7
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 418
          end
          object lbHeader5: TcxLabel
            Left = 16
            Top = 8
            Caption = 'Select monitored printers'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object lboxMonitoredPrinters: TcxCheckListBox
            Left = 16
            Top = 38
            Width = 221
            Height = 191
            EditValueFormat = cvfCaptions
            Items = <>
            Style.Edges = []
            Style.LookAndFeel.SkinName = 'VS2010'
            StyleDisabled.LookAndFeel.SkinName = 'VS2010'
            StyleFocused.LookAndFeel.SkinName = 'VS2010'
            StyleHot.LookAndFeel.SkinName = 'VS2010'
            TabOrder = 1
          end
          object lbSpoolNotRunning: TcxLabel
            Left = 180
            Top = 34
            Caption = 'Print Spool service is not running!'
            Style.TextColor = clRed
            Style.TextStyle = [fsItalic]
            Transparent = True
            Visible = False
          end
        end
        object tabFiles: TcxTabSheet
          Caption = 'tabFiles'
          ImageIndex = 4
          OnShow = tabFilesShow
          DesignSize = (
            569
            467)
          object shHeader7: TShape
            Left = 8
            Top = 7
            Width = 546
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Brush.Color = 16510950
            Pen.Style = psClear
            Shape = stRoundRect
            ExplicitWidth = 418
          end
          object lbHeader7: TcxLabel
            Left = 20
            Top = 8
            Caption = 'Ignore List'
            Style.TextStyle = [fsBold]
            Transparent = True
          end
          object lbHeaderDescription7: TcxLabel
            Left = 91
            Top = 8
            Caption = 
              '(items on this list wont appear in file log. * and ? wildcards c' +
              'an be used)'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'Tahoma'
            Style.Font.Style = []
            Style.TextColor = clGray
            Style.TextStyle = [fsItalic]
            Style.IsFontAssigned = True
            Transparent = True
          end
          object btFilesIgnoreAdd: TcxButton
            Left = 470
            Top = 38
            Width = 81
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Add'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 2
            OnClick = btFilesIgnoreAddClick
          end
          object btFilesIgnoreDel: TcxButton
            Left = 470
            Top = 72
            Width = 81
            Height = 28
            Align = alCustom
            Anchors = [akRight, akBottom]
            Caption = 'Delete'
            LookAndFeel.SkinName = 'VS2010'
            TabOrder = 3
            OnClick = btFilesIgnoreDelClick
          end
          object gridFilesIgnore: TcxGrid
            Left = 16
            Top = 38
            Width = 442
            Height = 415
            TabOrder = 4
            LookAndFeel.SkinName = 'VS2010'
            object gridFilesIgnoreTable: TcxGridBandedTableView
              FilterBox.Visible = fvNever
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.BandMoving = False
              OptionsCustomize.BandSizing = False
              OptionsCustomize.ColumnVertSizing = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.BandHeaders = False
              Bands = <
                item
                end>
              object gridFilesIgnoreMask: TcxGridBandedColumn
                Caption = 'Item mask'
                PropertiesClassName = 'TcxTextEditProperties'
                SortIndex = 0
                SortOrder = soDescending
                Width = 190
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
            end
            object gridFilesIgnoreLevel: TcxGridLevel
              GridView = gridFilesIgnoreTable
            end
          end
        end
      end
    end
  end
  object paBottom: TPanel
    Left = 0
    Top = 494
    Width = 739
    Height = 40
    Align = alBottom
    Anchors = [akBottom]
    BevelOuter = bvNone
    Ctl3D = False
    DoubleBuffered = True
    ParentBackground = False
    ParentColor = True
    ParentCtl3D = False
    ParentDoubleBuffered = False
    TabOrder = 2
    object btCancel: TcxButton
      Left = 645
      Top = 0
      Width = 81
      Height = 28
      Align = alCustom
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      LookAndFeel.SkinName = 'VS2010'
      ModalResult = 2
      TabOrder = 0
    end
    object btOk: TcxButton
      Left = 553
      Top = 0
      Width = 81
      Height = 28
      Align = alCustom
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      LookAndFeel.SkinName = 'VS2010'
      ModalResult = 1
      TabOrder = 1
    end
  end
end
