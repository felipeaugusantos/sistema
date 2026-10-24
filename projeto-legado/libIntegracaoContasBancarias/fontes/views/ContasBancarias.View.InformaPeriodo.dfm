inherited frmInformaPeriodo: TfrmInformaPeriodo
  Width = 336
  Height = 233
  BorderIcons = [biSystemMenu]
  Caption = 'Informe o per'#237'odo'
  Position = poMainFormCenter
  ExplicitWidth = 336
  ExplicitHeight = 233
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 188
    Width = 330
    Height = 0
    Enabled = False
    TabOrder = 2
    Visible = False
    ExplicitTop = 188
    ExplicitWidth = 330
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 326
      ExplicitWidth = 326
    end
    inherited btnSair: TBitBtnLocked
      Left = 250
      Top = -25
      ExplicitLeft = 250
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 188
    Width = 330
    ExplicitTop = 188
    ExplicitWidth = 330
    inherited pnlNomeForm: TPanel
      Left = 186
      Width = 144
      ExplicitLeft = 186
      ExplicitWidth = 144
    end
    inherited pnlInfo: TPanel
      Width = 186
      ExplicitWidth = 186
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 330
    Height = 188
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlFundo'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    StyleElements = []
    object pnlCardPeriodo: TPanel
      Left = 20
      Top = 21
      Width = 292
      Height = 149
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 20
      BevelOuter = bvNone
      Caption = 'pnlCardPeriodo'
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      StyleElements = []
      object lblPeriodo: TcxLabel
        Left = 28
        Top = 9
        Caption = 'Per'#237'odo'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -16
        Style.Font.Name = 'Segoe UI Semibold'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.TextColor = 3947580
        Style.IsFontAssigned = True
      end
      object pnlDataInicial: TPanel
        Left = 28
        Top = 42
        Width = 110
        Height = 33
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        ShowCaption = False
        TabOrder = 1
        StyleElements = []
        object mskDataInicial: TcxDateEdit
          Tag = 99
          AlignWithMargins = True
          Left = 4
          Top = 4
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          ParentFont = False
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          Style.BorderStyle = ebsNone
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI Semibold'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clWhite
          StyleHot.BorderStyle = ebsNone
          StyleHot.TextStyle = [fsBold]
          TabOrder = 0
          Width = 102
        end
      end
      object pnlDataFinal: TPanel
        Left = 157
        Top = 42
        Width = 110
        Height = 33
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        ShowCaption = False
        TabOrder = 2
        StyleElements = []
        object mskDataFinal: TcxDateEdit
          Tag = 99
          AlignWithMargins = True
          Left = 4
          Top = 4
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          ParentFont = False
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          Style.BorderStyle = ebsNone
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI Semibold'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clWhite
          StyleHot.BorderStyle = ebsNone
          StyleHot.TextStyle = [fsBold]
          TabOrder = 0
          Width = 102
        end
      end
      object pnlConfirmar: TPanel
        Left = 70
        Top = 92
        Width = 142
        Height = 35
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentBackground = False
        ParentFont = False
        ShowCaption = False
        TabOrder = 3
        StyleElements = []
        object btnConfirmar: TcxButton
          Tag = 99
          Left = -9
          Top = -7
          Width = 155
          Height = 51
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          ParentCustomHint = False
          BiDiMode = bdLeftToRight
          Caption = '&Confirmar'
          Colors.Default = clMoneyGreen
          Colors.Normal = clMoneyGreen
          Colors.Hot = clMoneyGreen
          Colors.Pressed = clMoneyGreen
          LookAndFeel.Kind = lfFlat
          LookAndFeel.NativeStyle = False
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C00000021744558745469746C65004170706C793B4F4B3B436865
            636B3B426172733B526962626F6E3B6463C8680000009449444154785EC59341
            0A83400C4547BAEAB6E0097A912E2DB8D2BBB8F1201EC19BD82B74E3294AC159
            C52F2464182498B6D0C5239B798F309040445FF1FB40370E4728787E14A8C004
            2EBE80CA0B20F0008523A032CF3B08B97CF2C81BA97C054F703B220B229FC1CC
            8FDE1AB1E57C8316C424D2677295CB7B7FD0680498B206AC4894B53D0189BC40
            0D823720943C4DFE7F8D2B585260AAC36B7FD80000000049454E44AE426082}
          ParentBiDiMode = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Segoe UI Semibold'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnConfirmarClick
        end
      end
      object lblA: TcxLabel
        Left = 142
        Top = 43
        Caption = #225
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -16
        Style.Font.Name = 'Segoe UI Semibold'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.TextColor = 3947580
        Style.IsFontAssigned = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 372
    Top = 88
  end
end
