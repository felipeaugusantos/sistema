inherited frmAlteracaoGeraldePrecosdeProdutos: TfrmAlteracaoGeraldePrecosdeProdutos
  Left = 214
  Top = 165
  Width = 1355
  Height = 760
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o Geral de Pre'#231'os de Produtos Para Lojas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1355
  ExplicitHeight = 760
  PixelsPerInch = 96
  TextHeight = 14
  object pgbProgresso: TProgressBar [0]
    Left = 0
    Top = 694
    Width = 1339
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 670
    Width = 1339
    TabOrder = 4
    ExplicitTop = 670
    ExplicitWidth = 1339
    DesignSize = (
      1339
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1335
      ExplicitWidth = 1335
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 705
    Width = 1339
    TabOrder = 3
    ExplicitTop = 705
    ExplicitWidth = 1339
    inherited pnlNomeForm: TPanel
      Left = 1192
      Width = 147
      ExplicitLeft = 1192
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 1192
      ExplicitWidth = 1192
      object shpMultSel: TShape
        Left = 1174
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas desta tela possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 350
        ExplicitTop = -1
        ExplicitHeight = 14
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 313
    Width = 1339
    Height = 357
    TabOrder = 2
    Visible = False
    ExplicitTop = 313
    ExplicitWidth = 1339
    ExplicitHeight = 357
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1331
      ExplicitHeight = 325
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1339
    Height = 313
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object pnlFiltro1: TPanel
      Left = 2
      Top = 2
      Width = 1335
      Height = 112
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 31
        Top = 5
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label2: TLabel
        Left = 47
        Top = 27
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel
        Left = 327
        Top = 27
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label4: TLabel
        Left = 372
        Top = 93
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label6: TLabel
        Left = 66
        Top = 50
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label167: TLabel
        Left = 11
        Top = 70
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo de Produto:'
      end
      object Label14: TLabel
        Left = 327
        Top = 49
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo de Compra:'
      end
      object Label50: TLabel
        Left = 701
        Top = 73
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Incide PIS?:'
      end
      object ColorLabel2: TColorLabel
        Left = 810
        Top = 73
        Width = 99
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos '
        CorDestaque = clRed
      end
      object Label9: TLabel
        Left = 29
        Top = 94
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento:'
      end
      object lblCodGpr: TLabel
        Left = 336
        Top = 72
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo de Pre'#231'o:'
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 101
        Top = 2
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = ''
        OnExit = mskLinGruExit
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 151
        Top = 2
        Width = 541
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
      object edtDesIte: TEditFocus
        Tag = 99
        Left = 101
        Top = 24
        Width = 221
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        OnKeyPress = edtDesIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRefere: TEditFocus
        Tag = 99
        Left = 385
        Top = 24
        Width = 307
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        OnKeyPress = edtRefereKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodUni: TEditFocus
        Tag = 99
        Left = 417
        Top = 90
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 17
        OnExit = edtCodUniExit
        OnKeyPress = edtCodUniKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 101
        Top = 46
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 6
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 149
        Top = 46
        Width = 172
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object rdgTipAltFor: TRadioGroup
        Left = 698
        Top = 5
        Width = 249
        Height = 56
        Caption = 'Tipo de Altera'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Alterar Pre'#231'o de Venda'
          'Alterar Margem de Lucro')
        TabOrder = 3
        Visible = False
        OnClick = rdgTipAltForClick
      end
      object rdgTipAlt: TRadioGroup
        Left = 698
        Top = 1
        Width = 249
        Height = 65
        Caption = 'Tipo de Altera'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
          'Pre'#231'o de Custo, Alterando Margem de Lucro'
          'Pre'#231'o de Venda, Alterando Margem de Lucro')
        TabOrder = 2
        OnClick = rdgTipAltClick
      end
      object edtPrdGru: TEditFocus
        Tag = 99
        Left = 101
        Top = 68
        Width = 48
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 10
        OnExit = edtPrdGruExit
        OnKeyPress = edtPrdGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesPrdPro: TEditFocus
        Left = 149
        Top = 68
        Width = 172
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
      object edtGruCmp: TEditFocus
        Tag = 99
        Left = 417
        Top = 46
        Width = 69
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
        TabOrder = 8
        OnExit = edtGruCmpExit
        OnKeyPress = edtGruCmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesGruCmp: TEditFocus
        Left = 486
        Top = 46
        Width = 206
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtIncPis: TEditFocus
        Tag = 99
        Left = 759
        Top = 69
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 14
        Text = 'T'
        OnKeyPress = edtIncPisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfanumerico
      end
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 101
        Top = 90
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnExit = edtCodDepExit
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesDep: TEditFocus
        Left = 149
        Top = 90
        Width = 172
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 16
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodGpr: TEditFocus
        Tag = 99
        Left = 417
        Top = 68
        Width = 69
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
        MaxLength = 6
        ParentFont = False
        TabOrder = 12
        OnExit = edtCodGprExit
        OnKeyPress = edtCodGprKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesGpr: TEditFocus
        Left = 486
        Top = 68
        Width = 206
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
    end
    object pnlFiltro2: TPanel
      Left = 2
      Top = 114
      Width = 1335
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label8: TLabel
        Left = 40
        Top = 4
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label5: TLabel
        Left = 33
        Top = 26
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Fiscal:'
      end
      object ColorLabel1: TColorLabel
        Left = 622
        Top = 71
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object Label13: TLabel
        Left = 549
        Top = 71
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo:'
      end
      object Label18: TLabel
        Left = 47
        Top = 48
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Pis:'
      end
      object Label19: TLabel
        Left = 30
        Top = 70
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Cofins:'
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 101
        Top = 0
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnExit = edtCodForExit
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 170
        Top = 0
        Width = 370
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
      object edtCodAbr: TEditFocus
        Tag = 99
        Left = 101
        Top = 22
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodAbrExit
        OnKeyPress = edtCodAbrKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesAbr: TEditFocus
        Left = 170
        Top = 22
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtStatus: TEditFocus
        Tag = 99
        Left = 579
        Top = 67
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 6
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtAbfPis: TEditFocus
        Tag = 99
        Left = 101
        Top = 43
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 3
        OnExit = edtAbfPisExit
        OnKeyPress = edtAbfPisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesPis: TEditFocus
        Left = 170
        Top = 44
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtAbfCof: TEditFocus
        Tag = 99
        Left = 101
        Top = 66
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 4
        OnExit = edtAbfCofExit
        OnKeyPress = edtAbfCofKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCof: TEditFocus
        Left = 170
        Top = 66
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlNotEnt: TPanel
      Left = 2
      Top = 206
      Width = 1335
      Height = 104
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label12: TLabel
        Left = 19
        Top = 9
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nota de Entrada:'
      end
      object grpDadosNE: TGroupBox
        Left = 101
        Top = 1
        Width = 439
        Height = 100
        TabOrder = 0
        object lblDocumento: TLabel
          Left = 6
          Top = 23
          Width = 54
          Height = 14
          Caption = 'Documento'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEspecie: TLabel
          Left = 108
          Top = 23
          Width = 38
          Height = 14
          Caption = 'Esp'#233'cie'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblSerie: TLabel
          Left = 148
          Top = 23
          Width = 25
          Height = 14
          Caption = 'S'#233'rie'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEmpresa: TLabel
          Left = 179
          Top = 23
          Width = 42
          Height = 14
          Caption = 'Empresa'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblForNot: TLabel
          Left = 7
          Top = 60
          Width = 56
          Height = 14
          Caption = 'Fornecedor'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDtaFin: TLabel
          Left = 373
          Top = 60
          Width = 47
          Height = 14
          Caption = 'Data Final'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDtaIni: TLabel
          Left = 310
          Top = 60
          Width = 51
          Height = 14
          Caption = 'Data Inicial'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDocumento: TEditFocus
          Tag = 99
          Left = 6
          Top = 37
          Width = 100
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 12
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtEspecie: TEditFocus
          Left = 108
          Top = 37
          Width = 38
          Height = 21
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 2
          Text = 'NF'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtSerie: TEditFocus
          Left = 148
          Top = 37
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmpresa: TEditFocus
          Tag = 99
          Left = 179
          Top = 37
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 4
          OnExit = edtCodEmpresaExit
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
          Left = 209
          Top = 37
          Width = 225
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkNotEnt: TCheckBox
          Tag = 99
          Left = 5
          Top = 8
          Width = 289
          Height = 17
          Caption = 'Informar nota de entrada para selecionar os produtos?'
          TabOrder = 0
          OnClick = chkNotEntClick
        end
        object edtForNot: TEditFocus
          Tag = 99
          Left = 6
          Top = 73
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnExit = edtForNotExit
          OnKeyPress = edtForNotKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesForNot: TEditFocus
          Left = 66
          Top = 73
          Width = 242
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskDtaEntFin: TMaskEditFocus
          Tag = 99
          Left = 373
          Top = 73
          Width = 61
          Height = 22
          Enabled = False
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 9
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaEntIni: TMaskEditFocus
          Tag = 99
          Left = 310
          Top = 73
          Width = 61
          Height = 22
          Enabled = False
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 8
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
      object pnlTipAltNota: TPanel
        Left = 919
        Top = 0
        Width = 416
        Height = 104
        Align = alRight
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        Visible = False
      end
    end
  end
  object pnlBotoesEnt: TPanel [5]
    Left = 0
    Top = 670
    Width = 1339
    Height = 24
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 20
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairAlt: TBitBtnLocked
      Left = 1226
      Top = 2
      Width = 111
      Height = 20
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAltClick
    end
  end
  object pnlDadosAlt: TPanel [6]
    Left = 0
    Top = 313
    Width = 1339
    Height = 357
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object cxgTiposAlt: TcxGrid
      Left = 0
      Top = 0
      Width = 1124
      Height = 357
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvTiposAlt: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyPress = cxvTiposAltEditKeyPress
        OnFocusedRecordChanged = cxvTiposAltFocusedRecordChanged
        DataController.DataSource = dtsAltGlo
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Filter.OnChanged = cxvTiposAltDataControllerFilterChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.CellAutoHeight = True
        OptionsView.GroupByBox = False
        object cxvTiposAltALTERA: TcxGridDBColumn
          Caption = 'Alterar'
          DataBinding.FieldName = 'ITE_ALTERA'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Properties.OnChange = cxvTiposAltALTERAPropertiesChange
          HeaderAlignmentHorz = taCenter
          Width = 54
        end
        object cxvTiposAltDESCAM: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Tipo de Altera'#231#227'o'
          DataBinding.FieldName = 'ITE_DESCAM'
          OnGetDisplayText = cxvTiposAltDESCAMGetDisplayText
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Styles.Content = cxsCorAzul
          Styles.OnGetContentStyle = cxvTiposAltDESCAMStylesGetContentStyle
          Width = 327
        end
        object cxvTiposAltPROPER: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_PROPER'
          Visible = False
        end
        object cxvTiposAltNOMCAM: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_NOMCAM'
          Visible = False
        end
        object cxvTiposAltDESCRI: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_DESCRI'
          Visible = False
        end
        object cxvTiposAltEmpOrigem: TcxGridDBColumn
          Caption = 'Emp. Origem'
          DataBinding.FieldName = 'ITE_EMPORI'
          Width = 74
        end
        object cxvTiposAltEMPDES: TcxGridDBColumn
          Caption = 'Emp. Dest.'
          DataBinding.FieldName = 'ITE_EMPDES'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = cxvTiposAltEMPDESPropertiesButtonClick
          Width = 101
        end
      end
      object cxgTiposAltLevel1: TcxGridLevel
        GridView = cxvTiposAlt
      end
    end
    object Panel2: TPanel
      Left = 1124
      Top = 0
      Width = 215
      Height = 357
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 1
        Top = 14
        Width = 204
        Height = 35
        TabOrder = 0
        object Shape3: TShape
          Left = 13
          Top = 12
          Width = 12
          Height = 14
          Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
          Brush.Color = clRed
          ParentShowHint = False
          ShowHint = True
        end
        object Label17: TLabel
          Left = 31
          Top = 13
          Width = 160
          Height = 14
          Caption = 'Informa'#231#245'es que ser'#227'o alteradas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 744
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 744
    Top = 184
  end
  object cdsAltGlo: TUniClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    BeforePost = cdsAltGloBeforePost
    Left = 680
    Top = 216
    object cdsAltGloITE_DESCAM: TStringField
      FieldName = 'ITE_DESCAM'
      Size = 60
    end
    object cdsAltGloITE_VALCAM: TStringField
      FieldName = 'ITE_VALCAM'
      Size = 6000
    end
    object cdsAltGloITE_EMPORI: TStringField
      FieldName = 'ITE_EMPORI'
      Size = 3
    end
    object cdsAltGloITE_EMPDES: TStringField
      FieldName = 'ITE_EMPDES'
      Size = 500
    end
    object cdsAltGloITE_MASCAM: TStringField
      FieldName = 'ITE_MASCAM'
      Size = 15
    end
    object cdsAltGloITE_NOMCAM: TStringField
      FieldName = 'ITE_NOMCAM'
      Size = 10
    end
    object cdsAltGloITE_DESABR: TStringField
      FieldName = 'ITE_DESABR'
      Size = 15
    end
    object cdsAltGloITE_LIMCAM: TIntegerField
      FieldName = 'ITE_LIMCAM'
    end
    object cdsAltGloITE_TIPCAM: TStringField
      FieldName = 'ITE_TIPCAM'
      Size = 15
    end
    object cdsAltGloITE_ALTERA: TStringField
      FieldName = 'ITE_ALTERA'
      Size = 1
    end
    object cdsAltGloITE_PROPER: TStringField
      FieldName = 'ITE_PROPER'
      Size = 100
    end
    object cdsAltGloITE_DESCRI: TStringField
      FieldName = 'ITE_DESCRI'
      Size = 100
    end
  end
  object dtsAltGlo: TDataSource
    DataSet = cdsAltGlo
    Left = 712
    Top = 216
  end
  object dspIteGlo: TUniDataSetProvider
    Options = []
    Left = 680
    Top = 256
  end
  object cdsIteGlo: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ITE_DESITE'
    Params = <>
    ProviderName = 'dspIteGlo'
    Left = 712
    Top = 256
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 384
    Top = 488
    PixelsPerInch = 96
    object cxsCorAzul: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsCombo: TcxStyle
      AssignedValues = [svColor]
      Color = 10801663
    end
    object cxsAltera: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsConsulta: TcxStyle
      AssignedValues = [svColor]
      Color = 11206613
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 108
    Top = 491
    PixelsPerInch = 96
    object cxeString16: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 16
    end
    object cxeString20: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
    end
    object cxeString02: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 2
    end
    object cxeString03: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnValidate = cxeString03PropertiesValidate
    end
    object cxeString05: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 5
    end
    object cxeString06: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 6
    end
    object cxeString07: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 7
    end
    object cxeString08: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 8
    end
    object cxeString10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
    end
    object cxeString25: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 25
    end
    object cxeString30: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 30
    end
    object cxeString50: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 50
    end
    object cxeString70: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 70
    end
    object cxeString80: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 80
    end
    object cxeString255: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 255
    end
    object cxeLocFis: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeLocSup: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeTamLcf: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeLocSep: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeDate: TcxEditRepositoryDateItem
      Properties.OnValidate = cxeDatePropertiesValidate
    end
    object cxeInt03: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 3
      Properties.OnValidate = cxeMasIntPropertiesValidate
    end
    object cxeInt11: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 11
      Properties.OnValidate = cxeMasIntPropertiesValidate
    end
    object cmbSimNao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbClaCRM: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbNivGir: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'A'
        'B'
        'C')
    end
    object cmbNivCri: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'X'
        'Y'
        'Z')
    end
    object cmbFrePFU: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbEsMiDg: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeMemo: TcxEditRepositoryMemoItem
      Properties.CharCase = ecUpperCase
      Properties.ScrollBars = ssBoth
      Properties.VisibleLineCount = 5
    end
    object cxeMasFat: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeDecUni: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeDec05: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeDec06: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasVal: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasPer: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasPerPropertiesValidate
    end
    object cxeMasMar: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasMBr: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasInt: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasIntPropertiesValidate
    end
    object cmbTipPro: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeConsTam8: TcxEditRepositoryTextItem
      Properties.MaxLength = 8
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam6: TcxEditRepositoryTextItem
      Properties.MaxLength = 6
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam5: TcxEditRepositoryTextItem
      Properties.MaxLength = 5
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam3: TcxEditRepositoryTextItem
      Properties.MaxLength = 3
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTamLse: TcxEditRepositoryTextItem
      Properties.MaxLength = 6
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam4: TcxEditRepositoryTextItem
      Properties.MaxLength = 4
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam2: TcxEditRepositoryTextItem
      Properties.MaxLength = 2
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeClassfIPI: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeClassfIPIPropertiesValidate
    end
    object cxeConsTam7: TcxEditRepositoryTextItem
      Properties.MaxLength = 7
    end
    object cmbPerVda: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALUE'
      Properties.ListColumns = <
        item
          FieldName = 'DESCRICAO'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsPermissaoVenda
    end
  end
  object dtsPermissaoVenda: TDataSource
    Left = 748
    Top = 300
  end
end
