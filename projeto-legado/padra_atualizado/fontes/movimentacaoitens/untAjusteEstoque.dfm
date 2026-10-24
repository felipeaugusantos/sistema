inherited frmAjusteEstoque: TfrmAjusteEstoque
  Left = 124
  Top = 185
  Width = 1108
  Height = 755
  BorderIcons = [biSystemMenu]
  Caption = 'Ajuste de Estoque'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1108
  ExplicitHeight = 755
  PixelsPerInch = 96
  TextHeight = 14
  object pnlItemContainer: TPanel [0]
    Left = 0
    Top = 272
    Width = 1102
    Height = 226
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      1102
      226)
    object pnlItemSai: TPanel
      Left = 2
      Top = 124
      Width = 1098
      Height = 100
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label9: TLabel
        Left = 40
        Top = 32
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 38
        Top = 76
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 231
        Top = 76
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Unit'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 438
        Top = 76
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 369
        Top = 32
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 19
        Top = 54
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Movimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 458
        Top = 32
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object ColorLabel1: TColorLabel
        Left = 142
        Top = 54
        Width = 35
        Height = 14
        Caption = '(S)a'#237'da'
        CorDestaque = clRed
      end
      object lblTipAjuSai: TLabel
        Left = 183
        Top = 54
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ajustar em:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblDesTipAjuSai: TColorLabel
        Left = 283
        Top = 54
        Width = 122
        Height = 14
        Caption = '(E)mbalagem (G)rama/ML'
        Visible = False
        CorDestaque = clRed
      end
      object lblSalMlSai: TLabel
        Left = 418
        Top = 54
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Gr / Ml:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblNumLotSai: TLabel
        Left = 617
        Top = 9
        Width = 24
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lote:'
      end
      object lblItemSaida: TLabel
        Left = 44
        Top = 10
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Item Sa'#237'da:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblSaldoDisponivelSaida: TLabel
        Left = 606
        Top = 32
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo dispon'#237'vel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodIteSai: TEditFocus
        Tag = 99
        Left = 99
        Top = 4
        Width = 89
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 15
        TabOrder = 0
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtQtdIteSai: TEditFocus
        Tag = 99
        Left = 99
        Top = 72
        Width = 63
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtUnitarSai: TEditFocus
        Left = 301
        Top = 72
        Width = 63
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTotIteSai: TEditFocus
        Left = 496
        Top = 72
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtEntSaiSai: TEditFocus
        Tag = 99
        Left = 99
        Top = 50
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 7
        Text = 'S'
        OnKeyPress = edtEntSaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtDesIteSai: TEditFocus
        Left = 187
        Top = 4
        Width = 378
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtRefereSai: TEditFocus
        Left = 99
        Top = 28
        Width = 265
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUnidadeSai: TEditFocus
        Left = 414
        Top = 28
        Width = 35
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtSaldosSai: TEditFocus
        Left = 497
        Top = 28
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTipAjuSai: TEditFocus
        Tag = 99
        Left = 243
        Top = 50
        Width = 35
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 8
        Text = 'E'
        Visible = False
        OnExit = edtTipAjuExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtSalMlSai: TEditFocus
        Left = 455
        Top = 50
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumLotSai: TEditFocus
        Tag = 99
        Left = 643
        Top = 5
        Width = 120
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 2
        OnKeyPress = edtNumLotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSaldoDisponivelSaida: TEditFocus
        Left = 694
        Top = 28
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlItemEnt: TPanel
      Left = 2
      Top = 2
      Width = 1098
      Height = 123
      Align = alTop
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label10: TLabel
        Left = 48
        Top = 33
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 337
        Top = 33
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTipMov: TLabel
        Left = 27
        Top = 55
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Movimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 426
        Top = 33
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTipAju: TLabel
        Left = 366
        Top = 55
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ajustar em:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblDesTipAju: TColorLabel
        Left = 462
        Top = 55
        Width = 122
        Height = 14
        Caption = '(E)mbalagem (G)rama/ML'
        Visible = False
        CorDestaque = clRed
      end
      object lblSalMl: TLabel
        Left = 606
        Top = 56
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Gr / Ml:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblNumLot: TLabel
        Left = 617
        Top = 33
        Width = 24
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lote:'
      end
      object clbTipoMovimento: TColorLabel
        Left = 152
        Top = 55
        Width = 83
        Height = 14
        Caption = '(E)ntrada (S)a'#237'da'
        CorDestaque = clRed
      end
      object lblItemEntrada: TLabel
        Left = 82
        Top = 9
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'Item:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblSaldoDisponivel: TLabel
        Left = 607
        Top = 12
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo dispon'#237'vel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 107
        Top = 6
        Width = 89
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 15
        TabOrder = 0
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtEntSai: TEditFocus
        Tag = 99
        Left = 107
        Top = 52
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 7
        OnKeyPress = edtEntSaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtDesIte: TEditFocus
        Left = 196
        Top = 6
        Width = 378
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtRefere: TEditFocus
        Left = 107
        Top = 29
        Width = 222
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUnidade: TEditFocus
        Left = 382
        Top = 29
        Width = 35
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSaldos: TEditFocus
        Left = 465
        Top = 29
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTipAju: TEditFocus
        Tag = 99
        Left = 422
        Top = 52
        Width = 35
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 8
        Text = 'E'
        Visible = False
        OnExit = edtTipAjuExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtSalMl: TEditFocus
        Left = 643
        Top = 52
        Width = 120
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumLot: TEditFocus
        Tag = 99
        Left = 643
        Top = 29
        Width = 120
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 2
        OnKeyPress = edtNumLotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSaldoDisponivel: TEditFocus
        Left = 694
        Top = 6
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object pnlQuantidade: TPanel
        Left = 1
        Top = 97
        Width = 788
        Height = 23
        BevelOuter = bvNone
        TabOrder = 10
        object lblQuantidade: TLabel
          Left = 45
          Top = 4
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 239
          Top = 4
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Unit'#225'rio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 446
          Top = 4
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtQtdIte: TEditFocus
          Tag = 99
          Left = 106
          Top = 1
          Width = 63
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtUnitar: TEditFocus
          Left = 309
          Top = 1
          Width = 63
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTotIte: TEditFocus
          Left = 504
          Top = 1
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object pnlMedidasMarmore: TPanel
        Left = 2
        Top = 75
        Width = 788
        Height = 22
        BevelOuter = bvNone
        TabOrder = 9
        object lblMarBruLXA: TLabel
          Left = 7
          Top = 3
          Width = 94
          Height = 14
          Alignment = taRightJustify
          Caption = 'Medida Bruta(LxA):'
        end
        object lblMBLxA: TLabel
          Left = 172
          Top = 3
          Width = 7
          Height = 14
          Alignment = taRightJustify
          Caption = 'X'
        end
        object lblMarliqLXA: TLabel
          Left = 247
          Top = 3
          Width = 102
          Height = 14
          Alignment = taRightJustify
          Caption = 'Medida L'#237'quida(LxA):'
        end
        object lblEspessura: TLabel
          Left = 497
          Top = 3
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Espessura:'
        end
        object lblMLLxA: TLabel
          Left = 417
          Top = 3
          Width = 7
          Height = 14
          Alignment = taRightJustify
          Caption = 'X'
        end
        object lblQtdChapa: TLabel
          Left = 634
          Top = 3
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd Chapa:'
          Visible = False
        end
        object edtLOT_MEDB_L: TEditFocus
          Tag = 99
          Left = 105
          Top = 0
          Width = 63
          Height = 22
          Alignment = taRightJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtLOT_MEDB_A: TEditFocus
          Tag = 99
          Left = 181
          Top = 0
          Width = 63
          Height = 22
          Alignment = taRightJustify
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtLOT_MEDL_L: TEditFocus
          Tag = 99
          Left = 350
          Top = 0
          Width = 64
          Height = 22
          Alignment = taRightJustify
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtLOT_MEDL_A: TEditFocus
          Tag = 99
          Left = 428
          Top = 0
          Width = 64
          Height = 22
          Alignment = taRightJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtLOT_ESPESS: TEditFocus
          Tag = 99
          Left = 554
          Top = 0
          Width = 64
          Height = 22
          Alignment = taRightJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtQtdChapa: TEditFocus
          Tag = 99
          Left = 689
          Top = 0
          Width = 63
          Height = 22
          Alignment = taRightJustify
          TabOrder = 5
          Visible = False
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
    object btnCancelaItem: TBitBtnLocked
      Left = 663
      Top = 207
      Width = 103
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 3
      OnClick = btnCancelaItemClick
    end
    object btnAdicionar: TBitBtnLocked
      Left = 663
      Top = 185
      Width = 103
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnAdicionarClick
    end
  end
  object pgbItens: TProgressBar [1]
    Left = 0
    Top = 562
    Width = 1102
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 573
    Width = 1102
    TabOrder = 5
    ExplicitTop = 573
    ExplicitWidth = 1102
    DesignSize = (
      1102
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1098
      ExplicitWidth = 1098
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 710
    Width = 1102
    TabOrder = 4
    ExplicitTop = 710
    ExplicitWidth = 1102
    inherited pnlNomeForm: TPanel
      Left = 955
      Width = 147
      ExplicitLeft = 955
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 955
      ExplicitWidth = 955
    end
  end
  inherited pgcDados: TPageControl
    Top = 498
    Width = 1102
    Height = 64
    TabOrder = 3
    Visible = False
    ExplicitTop = 498
    ExplicitWidth = 1102
    ExplicitHeight = 64
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1094
      ExplicitHeight = 32
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 1102
    Height = 256
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 39
      Top = 7
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 241
      Top = 7
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 61
      Top = 30
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 387
      Top = 7
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Entrada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'charter'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 46
      Top = 53
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblObserv: TLabel
      Left = 33
      Top = 143
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDigita: TLabel
      Left = 51
      Top = 76
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpSalExt: TLabel
      Left = 24
      Top = 120
      Width = 74
      Height = 14
      Caption = 'Emp. Saldo Ext:'
      Visible = False
    end
    object lblLotExt: TLabel
      Left = 558
      Top = 120
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote Est. Externo:'
      Visible = False
    end
    object lblFinalidade: TLabel
      Left = 45
      Top = 98
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Finalidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblObsAdc: TLabel
      Left = 24
      Top = 220
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs. Adicional:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtNumDoc: TEditFocus
      Left = 99
      Top = 3
      Width = 119
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Left = 284
      Top = 3
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 1
      Text = 'AJ'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 99
      Top = 26
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object mskDtaEnt: TMaskEditFocus
      Left = 470
      Top = 3
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 99
      Top = 49
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 4
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse01: TEditFocus
      Tag = 99
      Left = 99
      Top = 139
      Width = 434
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse02: TEditFocus
      Tag = 99
      Left = 99
      Top = 162
      Width = 434
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 164
      Top = 26
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomVen: TEditFocus
      Left = 164
      Top = 49
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 99
      Top = 72
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 164
      Top = 72
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 99
      Top = 116
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
      Visible = False
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 164
      Top = 116
      Width = 369
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLotExt: TEditFocus
      Tag = 99
      Left = 645
      Top = 116
      Width = 120
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 17
      Visible = False
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFinAju: TEditFocus
      Tag = 99
      Left = 99
      Top = 94
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 6
      OnKeyPress = edtFinAjuKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttAlfanumerico
    end
    object edtDesFinAju: TEditFocus
      Left = 164
      Top = 94
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkSubPro: TCheckBox
      Tag = 99
      Left = 99
      Top = 185
      Width = 434
      Height = 26
      Caption = 
        'Carregar os sub-produtos do item estrutura informado para fazer ' +
        'o ajuste do estoque externo proporcional '#224' quantidade do cadastr' +
        'o da estrutura'
      Checked = True
      State = cbChecked
      TabOrder = 10
      Visible = False
      WordWrap = True
    end
    object btnImportarPlanilha: TBitBtnLocked
      Left = 535
      Top = 120
      Width = 108
      Height = 22
      Caption = '&Importar Planilha'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFF848484FF848484FFFFFFFFFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
        0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 15
      OnClick = btnImportarPlanilhaClick
    end
    object edtObsAdc: TEditFocus
      Tag = 99
      Left = 99
      Top = 217
      Width = 434
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 100
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItens: TDBGridCitel [6]
    Left = 0
    Top = 498
    Width = 1102
    Height = 64
    Align = alClient
    DataSource = dtsAjuste
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 7
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'Item'
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_NUMLOT'
        Title.Caption = 'Lote'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ENTSAI'
        Title.Caption = 'E/S'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SIGUNI'
        Title.Caption = 'UN'
        Width = 30
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr. Unit'#225'rio'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr. Total'
        Width = 95
        Visible = True
      end>
  end
  object pnlDetalhe: TPanel [7]
    Left = 0
    Top = 573
    Width = 1102
    Height = 76
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 8
    object Label32: TLabel
      Left = 681
      Top = 10
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 559
      Top = 11
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd Itens:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtTotGer: TEditFocus
      Left = 708
      Top = 3
      Width = 62
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtToItem: TEditFocus
      Left = 608
      Top = 3
      Width = 62
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlOcorrencia: TPanel
      Left = 2
      Top = 25
      Width = 1098
      Height = 49
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        1098
        49)
      object lbl2: TLabel
        Left = 67
        Top = 10
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ocorr'#234'ncia:'
      end
      object lblHisCom: TLabel
        Left = 8
        Top = 33
        Width = 116
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico Complementar:'
      end
      object edtCodOco: TEditFocus
        Tag = 99
        Left = 127
        Top = 2
        Width = 50
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodOcoExit
        OnKeyPress = edtCodOcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesOco: TEditFocus
        Left = 179
        Top = 2
        Width = 897
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        Color = 16768952
        Enabled = False
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
      object edtHisCom: TEditFocus
        Tag = 99
        Left = 127
        Top = 25
        Width = 949
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 2
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
  object pnlBotoesEnt: TPanel [8]
    Left = 0
    Top = 681
    Width = 1102
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 9
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 25
      Align = alLeft
      Caption = '[ F10 ] Fechamento'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 989
      Top = 2
      Width = 111
      Height = 25
      Align = alRight
      Caption = '[ Esc ] Cancelar'
      TabOrder = 2
      OnClick = btnCancelarEntradaClick
    end
    object btnEstLoj: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 113
      Height = 25
      Align = alLeft
      Caption = '[ F6 ] Estoque Lojas'
      Enabled = False
      TabOrder = 1
      OnClick = btnEstLojClick
    end
  end
  object pnlOpcCod: TPanel [9]
    Left = 0
    Top = 256
    Width = 1102
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object rdbCodIte: TRadioButton
      Left = 99
      Top = 1
      Width = 96
      Height = 14
      Caption = 'C'#243'digo do Item'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbCodIteClick
    end
    object rdbProAca: TRadioButton
      Left = 201
      Top = 1
      Width = 113
      Height = 14
      Caption = 'Produto Acabado'
      TabOrder = 1
      OnClick = rdbProAcaClick
    end
    object pnlSaldoProAca: TPanel
      Left = 335
      Top = -3
      Width = 163
      Height = 20
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      Visible = False
      object rdbComSaldo: TRadioButton
        Left = 1
        Top = 3
        Width = 80
        Height = 17
        Caption = 'Com Saldo'
        TabOrder = 0
      end
      object rdbTodos: TRadioButton
        Left = 96
        Top = 3
        Width = 59
        Height = 17
        Caption = 'Todos'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
    end
  end
  object pnlInfoPlan: TPanel [10]
    Left = 0
    Top = 649
    Width = 1102
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
    Visible = False
    object lblInfoPlan: TLabel
      Left = 8
      Top = 1
      Width = 498
      Height = 28
      AutoSize = False
      Caption = 
        'Ajuste de estoque externo via planilha. Importa'#231#227'o autom'#225'tica pa' +
        'usada at'#233' que a rotina seja finalizada. Data e hora da extra'#231#227'o ' +
        'da planilha no site da empresa externa: %s %s'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 712
    Top = 40
  end
  object dtsAjuste: TDataSource
    OnDataChange = dtsAjusteDataChange
    Left = 648
    Top = 40
  end
end
