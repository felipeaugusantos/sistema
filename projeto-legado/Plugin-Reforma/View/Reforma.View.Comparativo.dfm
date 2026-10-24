object frameComparativo: TframeComparativo
  Left = 0
  Top = 0
  Width = 1030
  Height = 736
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object scrComparativoAtual: TScrollBox
    Left = 0
    Top = 0
    Width = 500
    Height = 736
    Align = alLeft
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
    object pnlCalculoAtual: TPanel
      Left = 0
      Top = 0
      Width = 483
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = True
      ParentFont = False
      TabOrder = 4
      ExplicitLeft = -3
      ExplicitTop = -1
      object shpCalculoAtual: TShape
        Left = 0
        Top = 15
        Width = 483
        Height = 1
        Align = alBottom
        Brush.Color = clSkyBlue
        Pen.Color = clSkyBlue
        ExplicitTop = 0
        ExplicitWidth = 1260
      end
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 276
        Height = 15
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#225'lculo Atual'
      end
    end
    object pnlPrecoCompraAtual: TPanel
      Left = 0
      Top = 16
      Width = 483
      Height = 375
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlPrecoCompraAtual'
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 0
      object lblPreComAtual: TLabel
        Left = 30
        Top = 5
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o Compra:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDesF01Atual: TLabel
        Left = 28
        Top = 28
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desconto 01 (-):'
      end
      object lblDesF01PerAtual: TLabel
        Left = 276
        Top = 27
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF02Atual: TLabel
        Left = 30
        Top = 49
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '02 (-):'
      end
      object lblDesF02PerAtual: TLabel
        Left = 276
        Top = 49
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF03Atual: TLabel
        Left = 30
        Top = 71
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '03 (-):'
      end
      object lblDesF03PerAtual: TLabel
        Left = 276
        Top = 71
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF04Atual: TLabel
        Left = 30
        Top = 93
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '04 (-):'
      end
      object lblDesF04PerAtual: TLabel
        Left = 276
        Top = 93
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF05Atual: TLabel
        Left = 30
        Top = 115
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '05 (-):'
      end
      object lblDesF05PerAtual: TLabel
        Left = 276
        Top = 115
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF06Atual: TLabel
        Left = 30
        Top = 137
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '06 (-):'
      end
      object lblDesF06PerAtual: TLabel
        Left = 276
        Top = 137
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblComLiqAtual: TLabel
        Left = 30
        Top = 159
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o Compra L'#237'qu.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblIcmEntAtual: TLabel
        Left = 30
        Top = 181
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ICMS Entrada (-):'
      end
      object lblIcmEntPerAtual: TLabel
        Left = 277
        Top = 181
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblIpiEntAtual: TLabel
        Left = 30
        Top = 225
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'IPI Entrada (+):'
      end
      object lblIpiEntPerAtual: TLabel
        Left = 277
        Top = 225
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblFreEntAtual: TLabel
        Left = 30
        Top = 247
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Frete (+):'
      end
      object lblFreEntPerAtual: TLabel
        Left = 277
        Top = 247
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblAcrFinAtual: TLabel
        Left = 30
        Top = 291
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Acr'#233'scimo Finan. (+):'
      end
      object lblAcrFinPerAtual: TLabel
        Left = 277
        Top = 291
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblSubstiAtual: TLabel
        Left = 30
        Top = 313
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Sub. Tribut'#225'ria (+):'
      end
      object lblSubstiPerAtual: TLabel
        Left = 277
        Top = 313
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPreCusAtual: TLabel
        Left = 30
        Top = 357
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o de Custo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValFreAtual: TLabel
        Left = 30
        Top = 269
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Frete (+):'
      end
      object lblDesAdiAtual: TLabel
        Left = 7
        Top = 335
        Width = 173
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descontos Adicionais (Boleto) (-):'
      end
      object lblDesAdiPerAtual: TLabel
        Left = 277
        Top = 335
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblSubFedAtual: TLabel
        Left = 30
        Top = 203
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Impostos Federais (-):'
      end
      object lblSubFedPerAtual: TLabel
        Left = 277
        Top = 203
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object dbePrecomAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 1
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_PRECOM'
        DataSource = dtsIteGer
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
      object dbeDesF01Atual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 23
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF01'
        DataSource = dtsIteGer
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
      object dbeDesF02Atual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 45
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF02'
        DataSource = dtsIteGer
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
      object dbeDesF03Atual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 67
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF03'
        DataSource = dtsIteGer
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
      object dbeDesF04Atual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 89
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF04'
        DataSource = dtsIteGer
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
      object dbeDesF05Atual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 111
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF05'
        DataSource = dtsIteGer
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF06Atual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 133
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF06'
        DataSource = dtsIteGer
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtComLiqAtual: TEditFocus
        Left = 184
        Top = 155
        Width = 92
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkPreDolAtual: TDBCheckBox
        Left = 279
        Top = 4
        Width = 70
        Height = 17
        TabStop = False
        Caption = 'Em d'#243'lar'
        Color = 16770261
        Ctl3D = True
        DataField = 'ITE_PREDOL'
        DataSource = dtsIteGer
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 17
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeIcmEntAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 177
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMENT'
        DataSource = dtsIteGer
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
      object dbeIpiEntAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 221
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_IPIENT'
        DataSource = dtsIteGer
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
      object dbeFreEntAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 243
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FREENT'
        DataSource = dtsIteGer
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
      object dbeAcrFinAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 287
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ACRFIN'
        DataSource = dtsIteGer
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSubstiAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 309
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_SUBSTI'
        DataSource = dtsIteGer
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreCusAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 353
        Width = 92
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'ITE_PRECUS'
        DataSource = dtsIteGer
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValFreAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 265
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_VALFRE'
        DataSource = dtsIteGer
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
      object dbeDesAdbAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 331
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESADB'
        DataSource = dtsIteGer
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSubFedAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 199
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_SUBFED'
        DataSource = dtsIteGer
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
    end
    object pnlCamposSuframaAtual: TPanel
      Left = 0
      Top = 391
      Width = 483
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      Visible = False
      object lblTCIFAtual: TLabel
        Left = 134
        Top = 4
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'TCIF (+):'
      end
      object lblTSAtual: TLabel
        Left = 145
        Top = 26
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'TS (+):'
      end
      object lblDEPICOAtual: TLabel
        Left = 55
        Top = 48
        Width = 125
        Height = 13
        Alignment = taRightJustify
        Caption = 'Desconto PIS/COFINS (-):'
      end
      object lblDEICMSAtual: TLabel
        Left = 88
        Top = 70
        Width = 92
        Height = 13
        Alignment = taRightJustify
        Caption = 'Desconto ICMS (-):'
      end
      object lblFatRegAtual: TLabel
        Left = 87
        Top = 92
        Width = 93
        Height = 13
        Alignment = taRightJustify
        Caption = 'Fator Regional (+):'
      end
      object lblTCIFPerAtual: TLabel
        Left = 279
        Top = 4
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblTSPerAtual: TLabel
        Left = 279
        Top = 26
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDEPICOPerAtual: TLabel
        Left = 279
        Top = 48
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDEICMSPerAtual: TLabel
        Left = 279
        Top = 72
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblFatRegPerAtual: TLabel
        Left = 279
        Top = 94
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object dbeTCIFAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 0
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_TCIFCU'
        DataSource = dtsIteGer
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
        TipoTexto = ttNumerico
      end
      object dbeTSAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 22
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_TSCUST'
        DataSource = dtsIteGer
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
        TipoTexto = ttNumerico
      end
      object dbeDEPICOAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 44
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DEPICO'
        DataSource = dtsIteGer
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
        TipoTexto = ttNumerico
      end
      object dbeDEICMSAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 66
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DEICMS'
        DataSource = dtsIteGer
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
        TipoTexto = ttNumerico
      end
      object dbeFatRegAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 88
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FATREG'
        DataSource = dtsIteGer
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
        TipoTexto = ttNumerico
      end
    end
    object pnlOutValAtual: TPanel
      Left = 0
      Top = 501
      Width = 483
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlOutValAtual'
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 2
      object lblOutValAtual: TLabel
        Left = 30
        Top = 3
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Outros Valores (+):'
      end
      object lblIcmSaiAtual: TLabel
        Left = 30
        Top = 25
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ICMS Sa'#237'da (+):'
      end
      object lblImpFedAtual: TLabel
        Left = 30
        Top = 47
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Impostos Federais (+):'
      end
      object lblDesOpeAtual: TLabel
        Left = 30
        Top = 69
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desp. Operacionais (+):'
      end
      object lblCusReaTitAtual: TLabel
        Left = 30
        Top = 91
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o de Custo Real:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblIcmSaiPerAtual: TLabel
        Left = 277
        Top = 26
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblImpFedPerAtual: TLabel
        Left = 277
        Top = 48
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesOpePerAtual: TLabel
        Left = 277
        Top = 70
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object dbeOutValAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 0
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_OUTVAL'
        DataSource = dtsIteGer
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
      object dbeIcmSaiAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 22
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMSAI'
        DataSource = dtsIteGer
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
      object dbeImpFedAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 44
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_IMPFED'
        DataSource = dtsIteGer
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
      object dbeDesOpeAtual: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 66
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESOPE'
        DataSource = dtsIteGer
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
      object edtCusReaAtual: TEditFocus
        Left = 184
        Top = 88
        Width = 92
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
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
      object lblValDesOpeAtual: TLabel
        Left = 388
        Top = 70
        Width = 13
        Height = 13
        Caption = 'R$'
      end
      object edtValDesOpeAtual: TEditFocus
        Left = 294
        Top = 66
        Width = 92
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlTabela1Atual: TPanel
      Left = 0
      Top = 611
      Width = 483
      Height = 155
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlTabela1Atual'
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 3
      object pnlTitulosTabelaAtual: TPanel
        Left = 0
        Top = 0
        Width = 181
        Height = 155
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object lblTitMarBr1Atual: TLabel
          Left = 30
          Top = 22
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb1Atual: TLabel
          Left = 28
          Top = 45
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitPreVe1Atual: TLabel
          Left = 30
          Top = 65
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblDolar1Atual: TLabel
          Left = 157
          Top = 109
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'US$:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblMarIde1Atual: TLabel
          Left = 30
          Top = 131
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Margem Ideal:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object lblCusVenAtual: TLabel
          Left = 30
          Top = 87
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pre'#231'o de Custo da Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
      object cxgTabela1Atual: TcxGroupBox
        AlignWithMargins = True
        Left = 181
        Top = 2
        Caption = 'Tabela 1:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 1
        Height = 153
        Width = 126
        object lblMarPerAtual: TLabel
          Left = 99
          Top = 19
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComAtual: TLabel
          Left = 99
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblMarIde1PerAtual: TLabel
          Left = 99
          Top = 129
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          Visible = False
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb1Atual: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 38
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB1'
          DataSource = dtsIteGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr1Atual: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 16
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR1'
          DataSource = dtsIteGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe1Atual: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 60
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE1'
          DataSource = dtsIteGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDolar1Atual: TEditFocus
          Tag = 50
          Left = 3
          Top = 104
          Width = 92
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeMarIde1Atual: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 126
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARID1'
          DataSource = dtsIteGer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 5
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen1Atual: TEditFocus
          Tag = 50
          Left = 3
          Top = 82
          Width = 92
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
    end
  end
  object scrComparativoNovo: TScrollBox
    Left = 500
    Top = 0
    Width = 530
    Height = 736
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 1
    object pnlCalculoNovo: TPanel
      Left = 0
      Top = 0
      Width = 513
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object shpCalculoNovo: TShape
        Left = 0
        Top = 15
        Width = 513
        Height = 1
        Align = alBottom
        Brush.Color = clSkyBlue
        Pen.Color = clSkyBlue
        ExplicitTop = 0
        ExplicitWidth = 1260
      end
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 292
        Height = 15
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#225'lculo Novo'
        ExplicitLeft = 6
        ExplicitTop = -1
      end
    end
    object pnlPrecoCompraNovo: TPanel
      Left = 0
      Top = 16
      Width = 513
      Height = 353
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlPrecoCompraNovo'
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 1
      object lblPreComNovo: TLabel
        Left = 47
        Top = 5
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o Compra:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDesF01Novo: TLabel
        Left = 45
        Top = 28
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desconto 01 (-):'
      end
      object lblDesF01PerNovo: TLabel
        Left = 293
        Top = 27
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesPisNovo: TLabel
        Left = 24
        Top = 28
        Width = 173
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desconto PIS/COFINS 2027(-):'
        Visible = False
      end
      object lblDesPisPctNovo: TLabel
        Left = 293
        Top = 27
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
        Visible = False
      end
      object lblPreLiqNovo: TLabel
        Left = 24
        Top = 49
        Width = 173
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o L'#237'quido com Desconto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Charter'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblDesF02Novo: TLabel
        Left = 47
        Top = 49
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '02 (-):'
      end
      object lblDesF02PerNovo: TLabel
        Left = 293
        Top = 49
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF03Novo: TLabel
        Left = 47
        Top = 71
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '03 (-):'
      end
      object lblDesF03PerNovo: TLabel
        Left = 293
        Top = 71
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF04Novo: TLabel
        Left = 47
        Top = 93
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '04 (-):'
      end
      object lblDesF04PerNovo: TLabel
        Left = 293
        Top = 93
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF05Novo: TLabel
        Left = 47
        Top = 115
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '05 (-):'
      end
      object lblDesF05PerNovo: TLabel
        Left = 293
        Top = 115
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF06Novo: TLabel
        Left = 47
        Top = 137
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '06 (-):'
      end
      object lblDesF06PerNovo: TLabel
        Left = 293
        Top = 137
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblComLiqNovo: TLabel
        Left = 47
        Top = 159
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o Compra L'#237'qu.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblIcmEntNovo: TLabel
        Left = 47
        Top = 181
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ICMS Entrada (-):'
      end
      object lblIcmEntPerNovo: TLabel
        Left = 294
        Top = 181
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblIpiEntNovo: TLabel
        Left = 47
        Top = 204
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'IPI Entrada (+):'
      end
      object lblIpiEntPerNovo: TLabel
        Left = 294
        Top = 204
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblFreEntNovo: TLabel
        Left = 47
        Top = 226
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Frete (+):'
      end
      object lblFreEntPerNovo: TLabel
        Left = 294
        Top = 226
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblAcrFinNovo: TLabel
        Left = 47
        Top = 270
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Acr'#233'scimo Finan. (+):'
      end
      object lblAcrFinPerNovo: TLabel
        Left = 294
        Top = 270
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblSubstiNovo: TLabel
        Left = 47
        Top = 292
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Sub. Tribut'#225'ria (+):'
      end
      object lblSubstiPerNovo: TLabel
        Left = 294
        Top = 292
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPreCusNovo: TLabel
        Left = 47
        Top = 336
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o de Custo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValFreNovo: TLabel
        Left = 47
        Top = 248
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor Frete (+):'
      end
      object lblDesAdiNovo: TLabel
        Left = 24
        Top = 314
        Width = 173
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descontos Adicionais (Boleto) (-):'
      end
      object lblDesAdiPerNovo: TLabel
        Left = 294
        Top = 314
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object dbePreComNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 1
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_PRECOM'
        DataSource = dtsCalculadora
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
      object dbeDesPisNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 23
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DPISCO'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 17
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreLiqNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 45
        Width = 92
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'ITE_PRELIQ'
        DataSource = dtsCalculadora
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 18
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF01Novo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 23
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF01'
        DataSource = dtsCalculadora
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
      object dbeDesF02Novo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 45
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF02'
        DataSource = dtsCalculadora
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
      object dbeDesF03Novo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 67
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF03'
        DataSource = dtsCalculadora
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
      object dbeDesF04Novo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 89
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF04'
        DataSource = dtsCalculadora
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
      object dbeDesF05Novo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 111
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF05'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF06Novo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 133
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF06'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtComLiqNovo: TEditFocus
        Left = 201
        Top = 155
        Width = 92
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkPreDolNovo: TDBCheckBox
        Left = 299
        Top = 4
        Width = 70
        Height = 17
        TabStop = False
        Caption = 'Em d'#243'lar'
        Color = 16770261
        Ctl3D = True
        DataField = 'ITE_PREDOL'
        DataSource = dtsCalculadora
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 9
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeIcmEntNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 177
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMENT'
        DataSource = dtsCalculadora
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
      object dbeIpiEntNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 200
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_IPIENT'
        DataSource = dtsCalculadora
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
      object dbeFreEntNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 222
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FREENT'
        DataSource = dtsCalculadora
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
      object dbeAcrFinNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 266
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ACRFIN'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSubstiNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 288
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_SUBSTI'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreCusNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 332
        Width = 92
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'ITE_PRECUS'
        DataSource = dtsCalculadora
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValFreNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 244
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_VALFRE'
        DataSource = dtsCalculadora
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
      object dbeDesAdbNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 310
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESADB'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlCamposSuframaNovo: TPanel
      Left = 0
      Top = 369
      Width = 513
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      Visible = False
      object lblTCIFNovo: TLabel
        Left = 151
        Top = 4
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'TCIF (+):'
      end
      object lblTSNovo: TLabel
        Left = 162
        Top = 26
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'TS (+):'
      end
      object lblDEPICONovo: TLabel
        Left = 72
        Top = 48
        Width = 125
        Height = 13
        Alignment = taRightJustify
        Caption = 'Desconto PIS/COFINS (-):'
      end
      object lblDEICMSNovo: TLabel
        Left = 105
        Top = 70
        Width = 92
        Height = 13
        Alignment = taRightJustify
        Caption = 'Desconto ICMS (-):'
      end
      object lblFatRegNovo: TLabel
        Left = 104
        Top = 92
        Width = 93
        Height = 13
        Alignment = taRightJustify
        Caption = 'Fator Regional (+):'
      end
      object lblTCIFPerNovo: TLabel
        Left = 296
        Top = 4
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblTSPerNovo: TLabel
        Left = 296
        Top = 26
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDEPICOPerNovo: TLabel
        Left = 296
        Top = 48
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDEICMSPerNovo: TLabel
        Left = 296
        Top = 72
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblFatRegPerNovo: TLabel
        Left = 296
        Top = 94
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object dbeTCIFNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 0
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_TCIFCU'
        DataSource = dtsCalculadora
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
        TipoTexto = ttNumerico
      end
      object dbeTSNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 22
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_TSCUST'
        DataSource = dtsCalculadora
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
        TipoTexto = ttNumerico
      end
      object dbeDEPICONovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 44
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DEPICO'
        DataSource = dtsCalculadora
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
        TipoTexto = ttNumerico
      end
      object dbeDEICMSNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 66
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DEICMS'
        DataSource = dtsCalculadora
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
        TipoTexto = ttNumerico
      end
      object dbeFatRegNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 88
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FATREG'
        DataSource = dtsCalculadora
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
        TipoTexto = ttNumerico
      end
    end
    object pnlOutValNovo: TPanel
      Left = 0
      Top = 479
      Width = 513
      Height = 89
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlOutValNovo'
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 3
      object lblOutValNovo: TLabel
        Left = 47
        Top = 3
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Outros Valores (+):'
      end
      object lblIcmSaiNovo: TLabel
        Left = 47
        Top = 25
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ICMS Sa'#237'da (+):'
      end
      object lblDesOpeNovo: TLabel
        Left = 47
        Top = 48
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desp. Operacionais (+):'
      end
      object lblCusReaTitNovo: TLabel
        Left = 47
        Top = 70
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre'#231'o de Custo Real:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblIcmSaiPerNovo: TLabel
        Left = 294
        Top = 26
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesOpePerNovo: TLabel
        Left = 294
        Top = 49
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object dbeOutValNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 0
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_OUTVAL'
        DataSource = dtsCalculadora
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
      object dbeIcmSaiNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 22
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMSAI'
        DataSource = dtsCalculadora
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
      object dbeDesOpeNovo: TDBEditFocus
        Tag = 99
        Left = 201
        Top = 45
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESOPE'
        DataSource = dtsCalculadora
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
      object edtCusReaNovo: TEditFocus
        Left = 201
        Top = 67
        Width = 92
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object lblValDesOpeNovo: TLabel
        Left = 405
        Top = 49
        Width = 13
        Height = 13
        Caption = 'R$'
      end
      object edtValDesOpeNovo: TEditFocus
        Left = 311
        Top = 45
        Width = 92
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
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
    object pnlTabela1Novo: TPanel
      Left = 0
      Top = 568
      Width = 513
      Height = 174
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlTabela1Novo'
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 4
      object pnlTitulosTabelaNovo: TPanel
        Left = 0
        Top = 0
        Width = 198
        Height = 174
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object lblTitMarBr1Novo: TLabel
          Left = 47
          Top = 22
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb1Novo: TLabel
          Left = 47
          Top = 45
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitPreVe1Novo: TLabel
          Left = 47
          Top = 65
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblIBSNovo: TLabel
          Left = 47
          Top = 109
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'IBS:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblISNovo: TLabel
          Left = 47
          Top = 131
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'IS:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblPreCliNovo: TLabel
          Left = 40
          Top = 153
          Width = 157
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pre'#231'o Venda com Impostos:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblCBSNovo: TLabel
          Left = 47
          Top = 87
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CBS:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
      object cxgTabela1Novo: TcxGroupBox
        AlignWithMargins = True
        Left = 198
        Top = 2
        Caption = 'Tabela 1:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 1
        Height = 172
        Width = 126
        object lblMarPerNovo: TLabel
          Left = 99
          Top = 19
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComNovo: TLabel
          Left = 99
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCBSPerNovo: TLabel
          Left = 99
          Top = 85
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPerNovo: TLabel
          Left = 99
          Top = 107
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPerNovo: TLabel
          Left = 99
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb1Novo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 38
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr1Novo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 16
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe1Novo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 60
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCBSNovo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 82
          Width = 92
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
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
        object dbeIBSNovo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 104
          Width = 92
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
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
        object dbeISNovo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 126
          Width = 92
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
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
        object dbePreCliNovo: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 148
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  object dtsIteGer: TDataSource
    Left = 8
    Top = 8
  end
  object dtsCalculadora: TDataSource
    Left = 40
    Top = 8
  end
end
