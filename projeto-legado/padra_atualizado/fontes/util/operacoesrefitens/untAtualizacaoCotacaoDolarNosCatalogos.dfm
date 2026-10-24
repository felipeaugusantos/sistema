inherited frmAtualizacaoCotacaoDolarNosCatalogos: TfrmAtualizacaoCotacaoDolarNosCatalogos
  Width = 596
  Height = 291
  Caption = 'Atualiza'#231#227'o da Cota'#231#227'o do Dolar Nos Cat'#225'logos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 596
  ExplicitHeight = 291
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel [0]
    Left = 326
    Top = 60
    Width = 42
    Height = 14
    Alignment = taRightJustify
    Caption = 'Unidade:'
  end
  object Label10: TLabel [1]
    Left = 33
    Top = 59
    Width = 33
    Height = 14
    Alignment = taRightJustify
    Caption = 'Marca:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [2]
    Left = 7
    Top = 36
    Width = 59
    Height = 14
    Alignment = taRightJustify
    Caption = 'Fornecedor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [3]
    Left = 437
    Top = 8
    Width = 78
    Height = 14
    Caption = 'Cota'#231#227'o D'#243'lar:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDolar: TLabel [4]
    Left = 537
    Top = 8
    Width = 33
    Height = 14
    Alignment = taRightJustify
    Caption = '0,0000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 218
    Width = 590
    TabOrder = 5
    ExplicitTop = 218
    ExplicitWidth = 590
    inherited FlwBotoes: TFlowPanel
      Width = 586
      ExplicitTop = 2
      ExplicitWidth = 586
      ExplicitHeight = 24
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Calcular'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0001000000040000000700000005000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000001000000020000
          00063D29238F714C43FF311F1A8F000000070000000200000001000000060000
          00090000000A0000000A0000000A0000000A0000000A0D09072C2016135C2519
          156B715045F3C2B0A7FF5E3F35F3231713671D1310570B070625704A3EBD9A66
          56FF9A6654FF9A6554FF996554FF996453FFBD9C90FF8B6D62FF987F76FF8467
          5DFFBFAEA4FFE2D9D2FFC6B7B1FF7D5F56FF896D63FF472F28B9B78877FFF8F2
          EEFFF7EFE9FFF6EFE9FFF7EEE9FFF6EEE9FFFBF7F4FFBAA8A2FFA48A80FFECE7
          E3FFBDA69CFF9E7E70FFC3AFA6FFEAE2DEFF997C72FF38282479B88979FFF8F3
          EFFFC2917FFFC0917EFFF7EFEAFFBF8F7DFFDFC7BEFFD5BDB4FF8D6C5EFFEAE4
          E0FF8B6B5FFFB79D93FF8B6B60FFE7DFD9FF765549FC00000008B88A7AFFF9F3
          EFFFCBA190FFC79A89FFF6EFEAFFCB9F8EFFE3CCC3FFC8B6AFFFAC9388FFEFEA
          E6FFB19E98FF755349FFAC978FFFE9E1DCFFA1887EFF3A2A257ABA8C7CFFF9F4
          F1FFF7EFEBFFF7F0EBFFF7EFEAFFF7EFEAFFFBF7F5FFAF978BFFB1998EFFA487
          7AFFD9CDC7FFF6F3F1FFD4C5BEFFA4877AFFB1998EFF675045B6BA8D7DFFF9F5
          F2FFC79B8DFFC79B8CFFF7F0EBFFC69A8AFFDABDB4FFEDE5E2FFDBCDC8FFD1C4
          BEFFA28274FFE2D8D2FF9B796CFF3127225D30252151120E0C21BC8D7EFFFAF5
          F2FFD1AB9CFFCDA496FFF7F1ECFFD1A89BFFD0A89BFFF8F2EEFFF8F2EFFFEDE9
          E8FFCDB9B0FFA28273FFBCA095FF0000000E0000000000000000BC8F80FFFAF6
          F3FFF7F1ECFFF7F1EDFFF7F0EDFFF7F0ECFFF8F0ECFFF7F0ECFFF7F0ECFFFBF8
          F5FFFCF8F5FFDCC5BCFF00000006000000000000000000000000BE9081FFFAF6
          F4FFD29857FFE4BC87FFE3BB85FFE3BB85FFE3BA84FFE3B984FFE2B982FFCF92
          52FFF8F1ECFFB98B7BFF00000006000000000000000000000000BF9182FFFAF7
          F4FFE0B277FFF0D4ABFFF2D9B3FFF2DAB4FFF2DAB3FFF2D9B1FFEED2A9FFDEAD
          71FFF7F1ECFFBA8C7BFF00000005000000000000000000000000BF9283FFFAF7
          F5FFE2B071FFE2B071FFE2B070FFE0B070FFE0AF70FFE0AF6EFFE0AF6EFFE0AC
          6CFFF8F1EDFFBB8D7DFF00000005000000000000000000000000C09485FFFCF8
          F6FFFCF8F6FFFBF7F6FFFBF7F5FFFAF7F5FFFBF7F4FFFBF7F4FFFAF7F4FFFAF7
          F4FFFBF7F4FFBC8E7EFF000000040000000000000000000000009B8175BFD1AE
          9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE
          9EFFD1AE9EFF9B8175BF00000002000000000000000000000000}
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 510
      ExplicitLeft = 510
    end
  end
  inherited pnlStatus: TPanel
    Top = 246
    Width = 590
    TabOrder = 6
    ExplicitTop = 246
    ExplicitWidth = 590
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 262
      ExplicitLeft = 328
      ExplicitWidth = 262
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
    end
  end
  object gpbRecalcular: TGroupBox [8]
    Left = 70
    Top = 130
    Width = 503
    Height = 44
    Caption = 'Recalcular:'
    TabOrder = 4
    object rdbMargem: TRadioButton
      Left = 258
      Top = 18
      Width = 113
      Height = 17
      Caption = 'Margem de Lucro'
      TabOrder = 0
    end
    object rdbPreVen: TRadioButton
      Left = 9
      Top = 18
      Width = 113
      Height = 17
      Caption = 'Pre'#231'o de Venda'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object pnlProgress: TPanel [9]
    Left = 0
    Top = 183
    Width = 590
    Height = 35
    Align = alBottom
    TabOrder = 8
    Visible = False
    object lblInf: TLabel
      Left = 1
      Top = 1
      Width = 588
      Height = 16
      Align = alClient
      Caption = 'lblStatus'
      ExplicitWidth = 41
      ExplicitHeight = 14
    end
    object prgProgress: TProgressBar
      Left = 1
      Top = 17
      Width = 588
      Height = 17
      Align = alBottom
      TabOrder = 0
    end
  end
  object edtCodFor: TEditFocus [10]
    Tag = 99
    Left = 70
    Top = 32
    Width = 58
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 0
    OnExit = edtCodForExit
    OnKeyPress = edtCodForKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttAlfanumerico
  end
  object edtNomFor: TEditFocus [11]
    Left = 129
    Top = 32
    Width = 444
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodMar: TEditFocus [12]
    Tag = 99
    Left = 70
    Top = 55
    Width = 58
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 1
    OnExit = edtCodMarExit
    OnKeyPress = edtCodMarKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 6
    TipoTexto = ttAlfanumerico
  end
  object edtDesMar: TEditFocus [13]
    Left = 129
    Top = 55
    Width = 184
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 10
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodUni: TEditFocus [14]
    Tag = 99
    Left = 370
    Top = 56
    Width = 31
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 2
    TabOrder = 2
    OnExit = edtCodUniExit
    OnKeyPress = edtCodUniKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 2
    TipoTexto = ttAlfanumerico
  end
  object edtDesUni: TEditFocus [15]
    Left = 402
    Top = 56
    Width = 171
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rdgSituacao: TRadioGroup [16]
    Left = 70
    Top = 80
    Width = 503
    Height = 50
    Caption = 'Situa'#231#227'o'
    Columns = 2
    ItemIndex = 2
    Items.Strings = (
      'Ativados para Cad. Produtos'
      'N'#227'o Ativados para Cad. Produtos'
      'Todos os Produtos')
    TabOrder = 3
    OnClick = rdgSituacaoClick
  end
end
