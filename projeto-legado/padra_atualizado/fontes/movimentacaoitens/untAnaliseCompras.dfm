inherited frmAnaliseCompras: TfrmAnaliseCompras
  Width = 1083
  Caption = 'An'#225'lise de Compras'
  Position = poMainFormCenter
  ExplicitWidth = 1083
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 433
    Width = 1077
    Height = 27
    Enabled = True
    TabOrder = 3
    Visible = True
    ExplicitTop = 433
    ExplicitWidth = 1077
    ExplicitHeight = 27
    DesignSize = (
      1077
      27)
    inherited FlwBotoes: TFlowPanel
      Width = 1073
      Height = 23
      TabOrder = 1
      ExplicitWidth = 1073
      ExplicitHeight = 23
      object btnNotEnt: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F3 ] - Notas Entrada'
        TabOrder = 1
        OnClick = btnNotEntClick
      end
      object btnPedCom: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F4 ] - Pedidos Compra'
        TabOrder = 2
        OnClick = btnPedComClick
      end
      object btnCompra: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 109
        Height = 22
        Caption = '[ F8 ] - Compras'
        TabOrder = 4
        OnClick = btnCompraClick
      end
      object btnVendas: TBitBtnLocked
        Left = 349
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F9 ] - Vendas'
        TabOrder = 5
        OnClick = btnVendasClick
      end
      object btnSaldos: TBitBtnLocked
        Left = 469
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F11 ] - Estoque'
        TabOrder = 6
        OnClick = btnSaldosClick
      end
      object btnLimpaTela: TBitBtnLocked
        Left = 589
        Top = 0
        Width = 99
        Height = 22
        Caption = '[ F12 ] - Limpa Tela'
        TabOrder = 3
        OnClick = btnLimpaTelaClick
      end
      object btnCfgGri: TBitBtnLocked
        Left = 688
        Top = 0
        Width = 148
        Height = 22
        Caption = 'Confi&gura colunas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
          4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
          ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
          6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
          9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
          71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
          64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
          75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
          B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
          78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
          BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
          7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
          BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
          7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
          C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
          84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
          C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
          87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
          D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
          8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
          97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
          8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
          AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
          91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
          F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
          95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
          6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
          93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
        TabOrder = 0
        OnClick = btnCfgGriClick
      end
      object btnTabRel: TBitBtnLocked
        Left = 836
        Top = 0
        Width = 143
        Height = 22
        Caption = '[ F5 ] Tabelas  Relacionadas'
        TabOrder = 7
        OnClick = btnTabRelClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 979
      Top = 2
      Width = 94
      Caption = '[ ESC ] - &Sair'
      TabOrder = 0
      ExplicitLeft = 979
      ExplicitTop = 2
      ExplicitWidth = 94
    end
  end
  inherited pnlStatus: TPanel
    Width = 1077
    ExplicitTop = 460
    ExplicitWidth = 1077
    inherited pnlNomeForm: TPanel
      Left = 906
      ExplicitLeft = 906
    end
    inherited pnlInfo: TPanel
      Width = 906
      ExplicitWidth = 906
    end
  end
  inherited pgcDados: TPageControl
    Width = 1077
    Height = 433
    ExplicitWidth = 1077
    ExplicitHeight = 433
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1069
      ExplicitHeight = 401
    end
  end
  object TPanel [3]
    Left = 0
    Top = 0
    Width = 1077
    Height = 433
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 1077
      Height = 174
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object lbl10: TLabel
        Left = 656
        Top = 38
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o '#218'ltima Compra:'
      end
      object lbl9: TLabel
        Left = 690
        Top = 84
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'IPI de Entrada:'
      end
      object lbl1: TLabel
        Left = 51
        Top = 15
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
      end
      object lbl3: TLabel
        Left = 27
        Top = 38
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd. F'#225'brica:'
      end
      object lbl4: TLabel
        Left = 32
        Top = 84
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
      object lbl5: TLabel
        Left = 440
        Top = 38
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Venda:'
      end
      object lbl6: TLabel
        Left = 423
        Top = 84
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Promo'#231#227'o:'
      end
      object lbl7: TLabel
        Left = 29
        Top = 61
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha/Grupo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl8: TLabel
        Left = 408
        Top = 107
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Validade da Promo'#231#227'o:'
      end
      object lbl11: TLabel
        Left = 680
        Top = 130
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Margem L'#237'quida:'
      end
      object lbl12: TLabel
        Left = 696
        Top = 61
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o M'#233'dio:'
      end
      object lbl13: TLabel
        Left = 443
        Top = 130
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estoque M'#237'nimo:'
      end
      object lblEntFut: TLabel
        Left = 35
        Top = 107
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Substitu'#237'do:'
      end
      object lbl14: TLabel
        Left = 614
        Top = 107
        Width = 144
        Height = 14
        Alignment = taRightJustify
        Caption = 'Margem da Promo'#231#227'o L'#237'quida:'
      end
      object Label1: TLabel
        Left = 5
        Top = 130
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prazo de Entrega:'
      end
      object Label2: TLabel
        Left = 662
        Top = 15
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data '#218'ltima Compra:'
      end
      object Label3: TLabel
        Left = 400
        Top = 61
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data da '#218'ltima Altera'#231#227'o:'
      end
      object Shape1: TShape
        Left = 372
        Top = 154
        Width = 14
        Height = 14
        Brush.Color = clRed
      end
      object Label4: TLabel
        Left = 389
        Top = 154
        Width = 136
        Height = 14
        Caption = 'Meses utilizados para m'#233'dia'
      end
      object edtValPro: TEditFocus
        Left = 524
        Top = 103
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 95
        Top = 11
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Left = 153
        Top = 11
        Width = 451
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFab: TEditFocus
        Tag = 99
        Left = 95
        Top = 34
        Width = 150
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 95
        Top = 80
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 153
        Top = 80
        Width = 199
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 18
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPreVen: TEditFocus
        Tag = 99
        Left = 524
        Top = 34
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtPrePro: TEditFocus
        Tag = 99
        Left = 524
        Top = 80
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 95
        Top = 57
        Width = 57
        Height = 22
        TabStop = False
        Color = 16768952
        EditMask = '999.999;0;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtLinGru: TEditFocus
        Left = 153
        Top = 57
        Width = 199
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 19
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMargem: TEditFocus
        Tag = 99
        Left = 762
        Top = 126
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '0.00'
      end
      object edtEstMin: TEditFocus
        Tag = 99
        Left = 524
        Top = 126
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.000'
      end
      object edtSubsti: TEditFocus
        Tag = 99
        Left = 95
        Top = 103
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtUltAlt: TEditFocus
        Tag = 99
        Left = 524
        Top = 57
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtDtaUlt: TEditFocus
        Tag = 99
        Left = 762
        Top = 11
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtUltCom: TEditFocus
        Tag = 99
        Left = 762
        Top = 34
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtPreMed: TEditFocus
        Tag = 99
        Left = 762
        Top = 57
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtIPIEnt: TEditFocus
        Tag = 99
        Left = 762
        Top = 80
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtMarPro: TEditFocus
        Tag = 99
        Left = 762
        Top = 103
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = ',0.00'
      end
      object edtPraEnt: TEditFocus
        Tag = 99
        Left = 95
        Top = 126
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object chkTransf: TCheckBox
        Left = 96
        Top = 152
        Width = 273
        Height = 17
        Caption = 'Considerar Pedidos de Transfer'#234'ncia entre Lojas'
        TabOrder = 20
        OnClick = chkTransfClick
      end
    end
    object grdAnaCom: TcxGrid
      Left = 0
      Top = 174
      Width = 1077
      Height = 259
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdAnaComView: TcxGridDBTableView
        OnKeyDown = grdAnaComViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'VENATU'
            Column = grdAnaComVENATU
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'ESTATU'
            Column = grdAnaComESTATU
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'PEDCOM'
            Column = grdAnaComPEDCOM
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'VENME1'
            Column = grdAnaComVENME1
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'VENME2'
            Column = grdAnaComVENME2
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'VENME3'
            Column = grdAnaComVENME3
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'MEDIA_'
            Column = grdAnaComMEDIA_
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'SUGEST'
            Column = grdAnaComSUGEST
          end
          item
            Format = ',0.00'
            Kind = skSum
            FieldName = 'ENTFUT'
            Column = grdAnaComENTFUT
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME4
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME5
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME6
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME7
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME8
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME9
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME10
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME11
          end
          item
            Format = ',0.00'
            Kind = skSum
            Column = grdAnaComVENME12
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
        OptionsView.HeaderAutoHeight = True
        Styles.ContentEven = cxStyle1
        object grdAnaComCODEMP: TcxGridDBColumn
          Caption = 'Emp'
          DataBinding.FieldName = 'CODEMP'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 35
        end
        object grdAnaComVENATU: TcxGridDBColumn
          Caption = 'Qtde. Venda M'#234's'
          DataBinding.FieldName = 'VENATU'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComESTATU: TcxGridDBColumn
          Caption = 'Saldo F'#237'sico'
          DataBinding.FieldName = 'ESTATU'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComSALDIS: TcxGridDBColumn
          Caption = 'Saldo Dispon'#237'vel'
          DataBinding.FieldName = 'SALDIS'
          Options.Editing = False
          Width = 90
        end
        object grdAnaComPEDCOM: TcxGridDBColumn
          Caption = 'Pedido Compra'
          DataBinding.FieldName = 'PEDCOM'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComVENME1: TcxGridDBColumn
          Tag = 1
          Caption = 'Vendas'
          DataBinding.FieldName = 'VENME1'
          OnCustomDrawCell = grdAnaComVENME1CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComVENME2: TcxGridDBColumn
          Tag = 2
          Caption = 'Vendas'
          DataBinding.FieldName = 'VENME2'
          OnCustomDrawCell = grdAnaComVENME2CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComVENME3: TcxGridDBColumn
          Tag = 3
          Caption = 'Vendas'
          DataBinding.FieldName = 'VENME3'
          OnCustomDrawCell = grdAnaComVENME3CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComVENME4: TcxGridDBColumn
          Tag = 4
          DataBinding.FieldName = 'VENME4'
          OnCustomDrawCell = grdAnaComVENME4CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME5: TcxGridDBColumn
          Tag = 5
          DataBinding.FieldName = 'VENME5'
          OnCustomDrawCell = grdAnaComVENME5CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME6: TcxGridDBColumn
          Tag = 6
          DataBinding.FieldName = 'VENME6'
          OnCustomDrawCell = grdAnaComVENME6CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME7: TcxGridDBColumn
          Tag = 7
          DataBinding.FieldName = 'VENME7'
          OnCustomDrawCell = grdAnaComVENME7CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME8: TcxGridDBColumn
          Tag = 8
          DataBinding.FieldName = 'VENME8'
          OnCustomDrawCell = grdAnaComVENME8CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME9: TcxGridDBColumn
          Tag = 9
          DataBinding.FieldName = 'VENME9'
          OnCustomDrawCell = grdAnaComVENME9CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME10: TcxGridDBColumn
          Tag = 10
          DataBinding.FieldName = 'VENME10'
          OnCustomDrawCell = grdAnaComVENME10CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME11: TcxGridDBColumn
          Tag = 11
          DataBinding.FieldName = 'VENME11'
          OnCustomDrawCell = grdAnaComVENME11CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComVENME12: TcxGridDBColumn
          Tag = 12
          DataBinding.FieldName = 'VENME12'
          OnCustomDrawCell = grdAnaComVENME12CustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 89
        end
        object grdAnaComMEDIA_: TcxGridDBColumn
          Caption = 'M'#233'dia'
          DataBinding.FieldName = 'MEDIA_'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComSUGEST: TcxGridDBColumn
          Caption = 'Sugest'#227'o'
          DataBinding.FieldName = 'SUGEST'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 89
        end
        object grdAnaComENTFUT: TcxGridDBColumn
          Caption = 'Ent. Fut.'
          DataBinding.FieldName = 'ENTFUT'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 76
        end
        object grdAnaComPMED_V: TcxGridDBColumn
          Caption = 'Pre'#231'o M'#233'dio Venda'
          DataBinding.FieldName = 'PMED_V'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 108
        end
      end
      object grdAnaComLevel1: TcxGridLevel
        GridView = grdAnaComView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 624
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 224
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 624
    Top = 240
    object cdsDadosCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsDadosVENATU: TFloatField
      FieldName = 'VENATU'
      DisplayFormat = ',0.00'
    end
    object cdsDadosESTATU: TFloatField
      FieldName = 'ESTATU'
      DisplayFormat = ',0.00'
    end
    object cdsDadosPEDCOM: TFloatField
      FieldName = 'PEDCOM'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME1: TFloatField
      FieldName = 'VENME1'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME2: TFloatField
      FieldName = 'VENME2'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME3: TFloatField
      FieldName = 'VENME3'
      DisplayFormat = ',0.00'
    end
    object cdsDadosMEDIA_: TFloatField
      FieldName = 'MEDIA_'
      DisplayFormat = ',0.00'
    end
    object cdsDadosSUGEST: TFloatField
      FieldName = 'SUGEST'
      DisplayFormat = ',0.00'
    end
    object cdsDadosENTFUT: TFloatField
      FieldName = 'ENTFUT'
      DisplayFormat = ',0.00'
    end
    object cdsDadosPMED_V: TFloatField
      FieldName = 'PMED_V'
    end
    object cdsDadosVENME4: TFloatField
      FieldName = 'VENME4'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME5: TFloatField
      FieldName = 'VENME5'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME6: TFloatField
      FieldName = 'VENME6'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME7: TFloatField
      FieldName = 'VENME7'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME8: TFloatField
      FieldName = 'VENME8'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME9: TFloatField
      FieldName = 'VENME9'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME10: TFloatField
      FieldName = 'VENME10'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME11: TFloatField
      FieldName = 'VENME11'
      DisplayFormat = ',0.00'
    end
    object cdsDadosVENME12: TFloatField
      FieldName = 'VENME12'
      DisplayFormat = ',0.00'
    end
    object cdsDadosSALDIS: TFloatField
      FieldName = 'SALDIS'
      DisplayFormat = ',0.00'
    end
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 496
    Top = 244
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
