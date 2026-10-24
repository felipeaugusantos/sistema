inherited frmFiltroSeparacao: TfrmFiltroSeparacao
  Width = 486
  Height = 224
  Caption = 'Filtro Separacao'
  Position = poScreenCenter
  ExplicitWidth = 486
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 14
  object lblDataEfetivacao: TLabel [0]
    Left = 10
    Top = 11
    Width = 79
    Height = 14
    Caption = 'Data Efetiva'#231#227'o:'
  end
  object Label5: TLabel [1]
    Left = 8
    Top = 85
    Width = 61
    Height = 28
    Alignment = taRightJustify
    Caption = 'Operador da Efetiva'#231#227'o:'
    WordWrap = True
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 116
    Width = 61
    Height = 28
    Alignment = taRightJustify
    Caption = 'Operador da Solicita'#231#227'o:'
    WordWrap = True
  end
  inherited pnlBotoes: TPanel
    Top = 151
    Width = 480
    TabOrder = 4
    ExplicitTop = 151
    ExplicitWidth = 480
    inherited FlwBotoes: TFlowPanel
      Width = 476
      ExplicitWidth = 476
      object BitBtnLocked1: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 87
        Height = 23
        Caption = '&Confirmar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000020000000900000011000000110000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000093D332F8268524CF467514BF42E24
          21820000000A0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000108B756CFFEBE8E7FFBAAFA9FF6F58
          50FF000000110000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000011877169FFE5E0DDFFBEB0A7FF715A
          53FF000000120000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000010846E67FFE4DDDAFFC2B4ABFF735C
          56FF000000110000000000000000000000000000000000000000000000000000
          000000000000000000000000000200000012836C64FFDDD5D0FFC2B4ACFF775F
          59FF000000140000000200000000000000000000000000000000000000000000
          000000000000000000030101010F34292681826B64FFD3CFCBFFBDB3AEFF7962
          5CFF2F2523830101011100000004000000010000000000000000000000000000
          0000000000040C0A092662524ACC8F786EFFA18D81FFAE9B8FFFAF9A8EFF9D87
          7AFF826A61FF554440CD0A080829000000050000000100000000000000000000
          0003120F0E2D7F6B63ECA69186FFBEB0A5FFCCC1B8FFBDACA1FFBEABA0FFB29E
          92FFA69082FF937B70FF6B5650ED0F0C0B310000000300000000000000010000
          00076E5E58C6AD9B90FFC4B7ADFFE5DFDAFFDBD5CDFFC9BBB1FFC3B1A6FFBCAB
          9FFFAF9B8EFFA69285FF937B6FFF574642C80000000A00000001000000022B25
          234EA49087FFC5B8ADFFE1DBD5FFF4F3F0FFE5E1DAFFCFC3B9FFC3B1A6FFC3B3
          A8FFB4A296FFAD998CFFA28C7FFF826A61FF211A19530000000300000004685C
          55A6B6A59AFFCEC4BBFFF2F0EDFFFCFCFBFFECEBE4FFD4C9C0FFC3B1A6FFC7B8
          AEFFB6A598FFAF9C8FFFA79284FF927A6DFF4E403CA900000006000000059E8C
          83ECC5B8AEFFE3DED8FFFCFAFAFFFDFCFBFFFCFBFAFFF8F8F5FFF6F3F0FFF2EE
          EBFFEAE4DFFFD8CEC6FFC5B6ACFFA18A7EFF77645DEB0000000800000004B19D
          94FFF0ECE9FFDCD5D2FFB6A8A4FF988681FF77615AFF7E6862FF89746CFF9580
          79FFB1A099FFC4B6B0FFD7CCC5FFDDD4CBFF87736BFE00000007000000023D35
          335CA8968DF0CCC0B9FFE3DBD6FFEFEBE7FFF1EEEAFFF4F0EEFFF1EDEAFFE8E1
          DCFFE0D7D1FFCEC2BAFFB3A39AFF8C7971F12F29266000000003000000000000
          00010807070F3E36335E695E579F897870CE8F7F77DDA49088FFA18D84FF8877
          70DD7D6C65CF5D514CA1352E2B60070606120000000300000000}
        TabOrder = 0
        OnClick = BitBtnLocked1Click
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 400
      ExplicitLeft = 400
    end
  end
  inherited pnlStatus: TPanel
    Top = 179
    Width = 480
    TabOrder = 5
    ExplicitTop = 179
    ExplicitWidth = 480
    inherited pnlNomeForm: TPanel
      Left = 309
      ExplicitLeft = 309
    end
    inherited pnlInfo: TPanel
      Width = 309
      ExplicitWidth = 309
    end
  end
  object dtaDtaEfe: TDateTimePicker [5]
    Tag = 99
    Left = 95
    Top = 8
    Width = 82
    Height = 22
    Date = 45524.715428449080000000
    Time = 45524.715428449080000000
    TabOrder = 0
    OnKeyPress = dtaDtaEfeKeyPress
  end
  object rdgFiltroImpresso: TRadioGroup [6]
    Left = 8
    Top = 28
    Width = 467
    Height = 53
    Caption = 'Impress'#227'o'
    Columns = 2
    ItemIndex = 2
    Items.Strings = (
      'Todos'
      'Impresso'
      'N'#227'o Impresso')
    TabOrder = 1
  end
  object edtCodOpeEfe: TEditFocus [7]
    Tag = 99
    Left = 75
    Top = 90
    Width = 49
    Height = 22
    Alignment = taLeftJustify
    AutoSize = False
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = edtCodOpeEfeKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtDesOpeEfe: TEditFocus [8]
    Left = 124
    Top = 90
    Width = 351
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 6
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodOpeSol: TEditFocus [9]
    Tag = 99
    Left = 75
    Top = 121
    Width = 49
    Height = 22
    Alignment = taLeftJustify
    AutoSize = False
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 3
    OnKeyPress = edtCodOpeSolKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtCodOpeSolDesc: TEditFocus [10]
    Left = 124
    Top = 121
    Width = 351
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 7
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
end
