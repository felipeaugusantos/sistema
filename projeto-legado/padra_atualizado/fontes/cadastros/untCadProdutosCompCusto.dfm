inherited frmCadProdutosCompCusto: TfrmCadProdutosCompCusto
  Left = 317
  Top = 186
  Width = 1030
  Height = 768
  Caption = 'Composi'#231#227'o do pre'#231'o de custo'
  Position = poMainFormCenter
  ExplicitWidth = 1030
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1024
    TabOrder = 2
    ExplicitTop = 468
    ExplicitWidth = 1024
    inherited FlwBotoes: TFlowPanel
      Width = 1020
      ExplicitWidth = 1020
    end
    inherited btnSair: TBitBtnLocked
      Left = 943
      ExplicitLeft = 943
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1024
    TabOrder = 3
    ExplicitTop = 496
    ExplicitWidth = 1024
    inherited pnlNomeForm: TPanel
      Left = 853
      ExplicitLeft = 853
    end
    inherited pnlInfo: TPanel
      Width = 853
      ExplicitWidth = 853
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1024
    Height = 57
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 37
      Height = 14
      Caption = 'Produto'
    end
    object edtDesIte: TEditFocus
      Left = 7
      Top = 22
      Width = 454
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 57
    Width = 1024
    Height = 384
    Align = alTop
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object Label13: TLabel
      Left = 36
      Top = 12
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Compra:'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object dbePreCom: TDBEditFocus
      Left = 120
      Top = 8
      Width = 92
      Height = 22
      HelpType = htKeyword
      DataField = 'ITE_PRECOM'
      DataSource = dtsCadIte
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbDescontos: TGroupBox
      Left = 6
      Top = 32
      Width = 300
      Height = 185
      Caption = 'Descontos'
      TabOrder = 1
      object Label14: TLabel
        Left = 31
        Top = 22
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto 01 (-):'
      end
      object Label15: TLabel
        Left = 80
        Top = 45
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '02 (-):'
      end
      object Label16: TLabel
        Left = 80
        Top = 68
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '03 (-):'
      end
      object Label17: TLabel
        Left = 81
        Top = 91
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '04 (-):'
      end
      object Label18: TLabel
        Left = 81
        Top = 114
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '05 (-):'
      end
      object Label19: TLabel
        Left = 81
        Top = 137
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '06 (-):'
      end
      object Label33: TLabel
        Left = 205
        Top = 22
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label34: TLabel
        Left = 205
        Top = 45
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label35: TLabel
        Left = 205
        Top = 68
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label36: TLabel
        Left = 206
        Top = 91
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label37: TLabel
        Left = 206
        Top = 114
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label38: TLabel
        Left = 206
        Top = 137
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label2: TLabel
        Left = 21
        Top = 161
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o L'#237'quido:'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object dbeDesf01: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 18
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF01'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesf02: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 41
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF02'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesf03: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 64
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF03'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesf04: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 87
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF04'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesf05: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 110
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF05'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesf06: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 133
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF06'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtPreLiq: TEditFocus
        Tag = 99
        Left = 112
        Top = 156
        Width = 92
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,####0.0000'
      end
    end
    object gpbImpOutros: TGroupBox
      Left = 312
      Top = 32
      Width = 300
      Height = 345
      Caption = 'Impostos de entrada / Outros'
      TabOrder = 2
      object Label20: TLabel
        Left = 87
        Top = 22
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'ICMS Entrada (-):'
      end
      object Label21: TLabel
        Left = 99
        Top = 68
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'IPI Entrada (+):'
      end
      object Label22: TLabel
        Left = 125
        Top = 91
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frete (+):'
      end
      object Label39: TLabel
        Left = 264
        Top = 22
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label40: TLabel
        Left = 264
        Top = 68
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label41: TLabel
        Left = 265
        Top = 91
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label23: TLabel
        Left = 66
        Top = 137
        Width = 104
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Finan. (+):'
      end
      object Label42: TLabel
        Left = 265
        Top = 137
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label24: TLabel
        Left = 80
        Top = 160
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sub. Tribut'#225'ria (+):'
      end
      object Label43: TLabel
        Left = 265
        Top = 160
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label3: TLabel
        Left = 66
        Top = 45
        Width = 103
        Height = 14
        Alignment = taRightJustify
        Caption = 'Imposos Federais (-):'
      end
      object Label4: TLabel
        Left = 264
        Top = 45
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblValFre: TLabel
        Left = 96
        Top = 114
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Frete (+):'
      end
      object lblDesAdi: TLabel
        Left = 6
        Top = 184
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descontos Adicionais (Boleto) (-):'
      end
      object Label133: TLabel
        Left = 264
        Top = 184
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblFatReg: TLabel
        Left = 6
        Top = 297
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Fator Regional (+):'
      end
      object lblDeICMS: TLabel
        Left = 6
        Top = 274
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desconto de ICMS (-):'
      end
      object lblDePiCo: TLabel
        Left = 6
        Top = 251
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desconto de PIS/COFINS (-):'
      end
      object lblTSCust: TLabel
        Left = 6
        Top = 228
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TS (+):'
      end
      object lblTCIFCu: TLabel
        Left = 6
        Top = 205
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TCIF (+):'
      end
      object lblPerFatReg: TLabel
        Left = 265
        Top = 297
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPerDeICMS: TLabel
        Left = 265
        Top = 274
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPerDePiCo: TLabel
        Left = 265
        Top = 251
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPerTSCust: TLabel
        Left = 265
        Top = 228
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPerTCIFCu: TLabel
        Left = 265
        Top = 205
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPrecoCusto: TLabel
        Left = 76
        Top = 321
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Custo:'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object dbeIcmEnt: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 18
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMENT'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeIpiEnt: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 64
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_IPIENT'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFreEnt: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 87
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FREENT'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAcrFin: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 133
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ACRFIN'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSubsti: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 156
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_SUBSTI'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSubFed: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 41
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_SUBFED'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValFre: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 110
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_VALFRE'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesAdb: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 179
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESADB'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTCIFCu: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 202
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_TCIFCU'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTSCust: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 225
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_TSCUST'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDePiCo: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 248
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DEPICO'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDeICMS: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 271
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DEICMS'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFatReg: TDBEditFocus
        Tag = 99
        Left = 171
        Top = 294
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FATREG'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbPrecoCusto: TDBEditFocus
        Left = 170
        Top = 318
        Width = 92
        Height = 22
        HelpType = htKeyword
        DataField = 'ITE_PRECUS'
        DataSource = dtsCadIte
        ReadOnly = True
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object GroupBox1: TGroupBox
      Left = 618
      Top = 32
      Width = 270
      Height = 134
      Caption = 'Impostos de sa'#237'da / Outros'
      TabOrder = 3
      object Label25: TLabel
        Left = 70
        Top = 42
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'ICMS Sa'#237'da (+):'
      end
      object Label28: TLabel
        Left = 36
        Top = 64
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Caption = 'Impostos Federais (+):'
      end
      object Label66: TLabel
        Left = 8
        Top = 86
        Width = 136
        Height = 14
        Alignment = taRightJustify
        Caption = 'Despesas Operacionais (+):'
      end
      object lblOutVal: TLabel
        Left = 51
        Top = 20
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Outros Valores (+):'
      end
      object Label44: TLabel
        Left = 248
        Top = 42
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label29: TLabel
        Left = 248
        Top = 64
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesOpePer: TLabel
        Left = 248
        Top = 86
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblCusReaTit: TLabel
        Left = 26
        Top = 112
        Width = 114
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Custo Real:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbeIcmSai: TDBEditFocus
        Tag = 99
        Left = 150
        Top = 40
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMSAI'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeImpFed: TDBEditFocus
        Tag = 99
        Left = 150
        Top = 62
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_IMPFED'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesOpe: TDBEditFocus
        Tag = 99
        Left = 150
        Top = 84
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESOPE'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeOutVal: TDBEditFocus
        Tag = 99
        Left = 150
        Top = 18
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_OUTVAL'
        DataSource = dtsCadIte
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtCusRea: TEditFocus
        Left = 150
        Top = 107
        Width = 92
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlCompras: TPanel [4]
    Left = 0
    Top = 441
    Width = 1024
    Height = 254
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 1022
    ExplicitHeight = 636
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 24
  end
  object dtsCadIte: TDataSource
    DataSet = qryCadIte
    Left = 504
    Top = 8
  end
  object qryCadIte: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 536
    Top = 8
  end
end
