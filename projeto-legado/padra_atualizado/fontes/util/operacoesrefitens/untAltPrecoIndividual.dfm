inherited frmAltPrecoIndividual: TfrmAltPrecoIndividual
  Left = 186
  Top = 106
  Width = 1118
  Height = 780
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o de Pre'#231'o Individual'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1118
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  object pnlProdutos: TPanel [0]
    Left = 0
    Top = 241
    Width = 1102
    Height = 455
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object cxgTiposAlt: TcxGrid
      Left = 1
      Top = 26
      Width = 1100
      Height = 346
      Align = alClient
      TabOrder = 5
      OnEnter = cxgTiposAltEnter
      OnExit = cxgTiposAltExit
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvTiposAlt: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhum registro encontrado>'
        OptionsView.CellAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.FixedBandSeparatorWidth = 0
        Bands = <
          item
            FixedKind = fkLeft
            Width = 354
          end
          item
            Width = 114
          end>
      end
      object cxgTiposAltLevel1: TcxGridLevel
        GridView = cxvTiposAlt
      end
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 402
      Width = 1100
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object Label10: TLabel
        Left = 8
        Top = 8
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
      end
      object Label11: TLabel
        Left = 65
        Top = 8
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
      end
      object Label12: TLabel
        Left = 485
        Top = 8
        Width = 53
        Height = 14
        Caption = 'Refer'#234'ncia'
      end
      object Label13: TLabel
        Left = 611
        Top = 8
        Width = 39
        Height = 14
        Caption = 'Unidade'
      end
      object Label14: TLabel
        Left = 701
        Top = 10
        Width = 77
        Height = 14
        Caption = #218'ltima Alt. Pre'#231'o'
      end
      object Label15: TLabel
        Left = 791
        Top = 10
        Width = 95
        Height = 14
        Caption = 'Possui embalagem?'
      end
      object Label16: TLabel
        Left = 887
        Top = 10
        Width = 61
        Height = 14
        Caption = #218'ltima venda'
      end
      object dbeCodIte: TDBEditFocus
        Left = 8
        Top = 24
        Width = 56
        Height = 22
        TabStop = False
        DataField = 'ITE_CODITE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesIte: TDBEditFocus
        Left = 65
        Top = 24
        Width = 419
        Height = 22
        TabStop = False
        DataField = 'ITE_DESITE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRefere: TDBEditFocus
        Left = 485
        Top = 24
        Width = 125
        Height = 22
        TabStop = False
        DataField = 'ITE_REFERE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeUnidad: TDBEditFocus
        Left = 611
        Top = 24
        Width = 89
        Height = 22
        TabStop = False
        DataField = 'ITE_DESUNI'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAltPre: TDBEditFocus
        Left = 701
        Top = 24
        Width = 89
        Height = 22
        TabStop = False
        DataField = 'ITE_ALTPRE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePosEmb: TDBEditFocus
        Left = 791
        Top = 24
        Width = 95
        Height = 22
        TabStop = False
        DataField = 'ITE_POSEMB'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaUve: TDBEditFocus
        Left = 887
        Top = 24
        Width = 95
        Height = 22
        TabStop = False
        DataField = 'ITE_DTAUVE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlAviso: TPanel
      Left = 1
      Top = 387
      Width = 1100
      Height = 15
      Align = alBottom
      Caption = 
        'Para editar o valor do Campo Aplica'#231#227'o '#233' preciso apertar a tecla' +
        ' enter sobre o campo ou duplo clique do mouse.'
      ParentColor = True
      TabOrder = 1
      Visible = False
    end
    object pnlBusca: TPanel
      Left = 1
      Top = 1
      Width = 1100
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object btnIniBus: TBitBtnLocked
        Left = 114
        Top = 0
        Width = 90
        Height = 25
        Align = alLeft
        Caption = '[F5] Inicia Busca'
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 114
        Height = 25
        Align = alLeft
        Caption = '[F9] Localiza Pr'#243'xima'
        TabOrder = 1
        OnClick = btnLocProxClick
      end
    end
    object pnlInfoCotDol: TPanel
      Left = 1
      Top = 372
      Width = 1100
      Height = 15
      Align = alBottom
      Caption = 'Cota'#231#227'o Atual do D'#243'lar de Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object pnlGridResultado: TPanel
      Left = 1
      Top = 26
      Width = 1100
      Height = 346
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
    end
  end
  object pnlFiltros: TPanel [1]
    Left = 0
    Top = 241
    Width = 1102
    Height = 455
    Align = alClient
    Alignment = taLeftJustify
    ParentBackground = False
    ParentColor = True
    TabOrder = 5
    TabStop = True
    object cxGrid: TcxGrid
      Left = 1
      Top = 21
      Width = 1100
      Height = 433
      Align = alClient
      TabOrder = 0
      object cxGridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        DataController.DataSource = dtsParametros
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir o filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsView.GroupByBox = False
        object cxGridViewCAMPO: TcxGridDBColumn
          DataBinding.FieldName = 'CAMPO'
          Visible = False
        end
        object cxGridViewDESCRI: TcxGridDBColumn
          Caption = 'Parametro'
          DataBinding.FieldName = 'DESCRI'
          OnGetDisplayText = cxGridViewDESCRIGetDisplayText
          Options.Editing = False
          Width = 365
        end
        object cxGridViewMARCADO: TcxGridDBColumn
          Caption = 'Sel.'
          DataBinding.FieldName = 'MARCADO'
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridView
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1100
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lbl5: TLabel
        Left = 331
        Top = 0
        Width = 769
        Height = 20
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos Visualizados'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 480
        ExplicitWidth = 609
        ExplicitHeight = 24
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 331
        Height = 20
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnMarcar: TBitBtnLocked
          Left = 120
          Top = 0
          Width = 101
          Height = 20
          Align = alLeft
          Caption = '[F2] Marcar Todos'
          TabOrder = 0
          TabStop = False
          OnClick = btnMarcarClick
        end
        object btnDesmarcar: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 120
          Height = 20
          Align = alLeft
          Caption = ' [F3] Desmarcar Todos'
          TabOrder = 1
          TabStop = False
          OnClick = btnDesmarcarClick
        end
        object btnLimpaFiltros: TBitBtnLocked
          Left = 221
          Top = 0
          Width = 108
          Height = 20
          Align = alLeft
          BiDiMode = bdLeftToRight
          Caption = '[F8] Limpa Filtros'
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = btnLimpaFiltrosClick
        end
      end
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1102
    Height = 241
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 28
      Top = 32
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 272
      Top = 32
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label4: TLabel
      Left = 440
      Top = 32
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label6: TLabel
      Left = 47
      Top = 56
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblFornec: TLabel
      Left = 21
      Top = 102
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label7: TLabel
      Left = 266
      Top = 56
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Fiscal:'
    end
    object Label9: TLabel
      Left = 577
      Top = 147
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo?:'
    end
    object ColorLabel1: TColorLabel
      Left = 658
      Top = 146
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object lbl1: TLabel
      Left = 544
      Top = 101
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classif. do IPI:'
    end
    object lbl2: TLabel
      Left = 830
      Top = 246
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
      Visible = False
    end
    object lbl4: TLabel
      Left = 15
      Top = 79
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc. Entrada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEspecie: TLabel
      Left = 173
      Top = 79
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
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
      Left = 250
      Top = 79
      Width = 28
      Height = 14
      Caption = 'S'#233'rie:'
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
      Left = 307
      Top = 79
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblOrdem: TLabel
      Left = 393
      Top = 126
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem:'
      Enabled = False
    end
    object Label167: TLabel
      Left = 7
      Top = 125
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Produto:'
    end
    object Label1: TLabel
      Left = 7
      Top = 147
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Compra:'
    end
    object Label50: TLabel
      Left = 556
      Top = 169
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Incide PIS?:'
    end
    object ColorLabel2: TColorLabel
      Left = 658
      Top = 169
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 6
      Top = 194
      Width = 74
      Height = 14
      Caption = 'Depto. Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl50: TLabel
      Left = 543
      Top = 124
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo EX IPI:'
    end
    object lblMarIde: TLabel
      Left = 366
      Top = 147
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Ideal:'
    end
    object lblTabPrc: TLabel
      Left = 367
      Top = 171
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Pre'#231'o:'
    end
    object lblCodGpr: TLabel
      Left = 16
      Top = 170
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Pre'#231'o:'
    end
    object Label8: TLabel
      Left = 12
      Top = 9
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lblAtivoCompras: TLabel
      Left = 525
      Top = 192
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo p/ Compras:'
    end
    object ColorLabel3: TColorLabel
      Left = 659
      Top = 193
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object ColorLabel4: TColorLabel
      Left = 930
      Top = 82
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label17: TLabel
      Left = 797
      Top = 76
      Width = 83
      Height = 28
      Alignment = taRightJustify
      Caption = 'Exporta'#231#227'o para E-Commerce:'
      WordWrap = True
    end
    object pnlCadMon: TPanel
      Left = 2
      Top = 213
      Width = 534
      Height = 25
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 19
      object lbl3: TLabel
        Left = 24
        Top = 3
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Montadora:'
      end
      object edtCodMon: TEditFocus
        Tag = 99
        Left = 80
        Top = 0
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodMonExit
        OnKeyPress = edtCodMonKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesMon: TEditFocus
        Left = 150
        Top = 0
        Width = 369
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
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 82
      Top = 5
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
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 82
      Top = 28
      Width = 185
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
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
      Left = 330
      Top = 28
      Width = 104
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
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
      Left = 485
      Top = 28
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 3
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
      Left = 82
      Top = 51
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 4
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
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 82
      Top = 98
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 10
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
    object edtDesGru: TEditFocus
      Left = 131
      Top = 5
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 135
      Top = 51
      Width = 131
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 27
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 152
      Top = 98
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgTipAlt: TRadioGroup
      Left = 537
      Top = 2
      Width = 247
      Height = 72
      Caption = 'Tipo de Altera'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
        'Pre'#231'o de Custo, Alterando Margem de Lucro'
        'Pre'#231'o de Venda, Alterando Margem de Lucro')
      TabOrder = 20
    end
    object chkArrMai: TCheckBox
      Left = 587
      Top = 78
      Width = 191
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Arredonda '#250'ltima casa decimal'
      ParentBiDiMode = False
      TabOrder = 21
    end
    object edtCodAbr: TEditFocus
      Tag = 99
      Left = 334
      Top = 52
      Width = 32
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
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
      Left = 367
      Top = 52
      Width = 154
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 28
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
      Left = 614
      Top = 143
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 24
      Text = 'T'
      OnKeyPress = edtStatusKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtClaIpi: TEditFocus
      Tag = 99
      Left = 614
      Top = 97
      Width = 167
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtDocumento: TEditFocus
      Left = 82
      Top = 75
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 6
      OnExit = edtDocumentoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Tag = 99
      Left = 217
      Top = 75
      Width = 30
      Height = 22
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
      TabOrder = 7
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
      Left = 280
      Top = 75
      Width = 24
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
      TabOrder = 8
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
      Left = 355
      Top = 75
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 9
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
      Left = 392
      Top = 75
      Width = 129
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 29
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxOrdem: TComboBoxFocus
      Left = 434
      Top = 121
      Width = 87
      Height = 22
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 12
      Text = 'Alfab'#233'tica'
      Items.Strings = (
        'Alfab'#233'tica'
        'Digita'#231#227'o')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 82
      Top = 121
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 11
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
      Left = 152
      Top = 121
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 31
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
      Left = 82
      Top = 144
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
      TabOrder = 13
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
      Left = 152
      Top = 144
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 32
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
      Left = 614
      Top = 166
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 25
      Text = 'T'
      OnExit = edtIncPisExit
      OnKeyPress = edtStatusKeyPress
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
      Left = 82
      Top = 190
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
      TabOrder = 17
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
      Left = 152
      Top = 190
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 33
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtExcIpi: TEditFocus
      Tag = 99
      Left = 614
      Top = 120
      Width = 59
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 23
      OnExit = edtExcIpiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object cbxMarIde: TComboBoxFocus
      Left = 434
      Top = 144
      Width = 87
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 14
      Text = 'Nenhum'
      OnChange = cbxMarIdeChange
      Items.Strings = (
        'Nenhum'
        'Maior ou Igual'
        'Menor ou Igual'
        'Maior'
        'Menor'
        'Igual')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbxTabPrc: TComboBoxFocus
      Left = 434
      Top = 167
      Width = 87
      Height = 22
      Style = csDropDownList
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkPenRec: TCheckBox
      Left = 798
      Top = 172
      Width = 288
      Height = 29
      Caption = 
        'Exibir somente produtos com pend'#234'ncia de rec'#225'lculo de pre'#231'o devi' +
        'do '#224' altera'#231#227'o de abrevi'#231#227'o fiscal'
      TabOrder = 34
      WordWrap = True
    end
    object edtCodGpr: TEditFocus
      Tag = 99
      Left = 82
      Top = 167
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
      TabOrder = 15
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
      Left = 152
      Top = 167
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 37
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAtivoCompras: TEditFocus
      Tag = 99
      Left = 614
      Top = 189
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 18
      Text = 'T'
      OnExit = edtAtivoComprasExit
      OnKeyPress = edtAtivoComprasKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtExpEcomm: TEditFocus
      Tag = 99
      Left = 886
      Top = 79
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 35
      Text = 'T'
      OnKeyPress = edtStatusKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object gpbNvgiro: TcxGroupBox
      Left = 798
      Top = 107
      Caption = 'N'#237'vel de Giro'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 14
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.Shadow = True
      Style.IsFontAssigned = True
      TabOrder = 36
      Height = 36
      Width = 244
      object ColorLabel8: TColorLabel
        Left = 34
        Top = 15
        Width = 186
        Height = 14
        Caption = 'N'#237'vel (A)   N'#237'vel(B)   N'#237'vel (C)   (T)odos'
        CorDestaque = clRed
      end
      object edtGirEst: TEditFocus
        Tag = 99
        Left = 10
        Top = 12
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
        OnKeyPress = edtGirEstKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkNOReordenaGrid: TCheckBox
      Left = 798
      Top = 149
      Width = 219
      Height = 17
      Caption = 'N'#227'o reordenar os itens ao editar'
      TabOrder = 38
    end
  end
  inherited pnlBotoes: TPanel
    Top = 705
    Width = 1102
    Height = 23
    TabOrder = 1
    ExplicitTop = 705
    ExplicitWidth = 1102
    ExplicitHeight = 23
    inherited FlwBotoes: TFlowPanel
      Left = 308
      Width = 5
      Height = 19
      Align = alLeft
      TabOrder = 4
      ExplicitLeft = 308
      ExplicitWidth = 5
      ExplicitHeight = 19
    end
    inherited btnSair: TBitBtnLocked
      Left = 1032
      Top = 2
      Width = 68
      Height = 19
      Align = alRight
      Caption = '[ Esc ] Sair'
      Glyph.Data = {00000000}
      ParentBiDiMode = False
      TabOrder = 3
      ExplicitLeft = 1032
      ExplicitTop = 2
      ExplicitWidth = 68
      ExplicitHeight = 19
    end
    object btnConfirmaAlt: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 98
      Height = 19
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaAltClick
    end
    object btnExcel: TBitBtnLocked
      Left = 220
      Top = 2
      Width = 88
      Height = 19
      Align = alLeft
      BiDiMode = bdLeftToRight
      Caption = '[F7] Exp. Excel'
      ParentBiDiMode = False
      TabOrder = 2
      Visible = False
      OnClick = btnExcelClick
    end
    object btnEstLoj: TBitBtnLocked
      Left = 100
      Top = 2
      Width = 120
      Height = 19
      Align = alLeft
      Caption = ' [F6] Estoque das Lojas'
      TabOrder = 1
      TabStop = False
      Visible = False
      OnClick = btnEstLojClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 728
    Width = 1102
    Height = 13
    TabOrder = 2
    ExplicitTop = 728
    ExplicitWidth = 1102
    ExplicitHeight = 13
    inherited pnlNomeForm: TPanel
      Left = 931
      Height = 13
      ExplicitLeft = 931
      ExplicitHeight = 13
    end
    inherited pnlInfo: TPanel
      Width = 931
      Height = 13
      ExplicitWidth = 931
      ExplicitHeight = 13
      object shpMultSel: TShape
        Left = 913
        Top = 2
        Width = 16
        Height = 9
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
    inherited pnlBotoesTrace: TPanel
      Height = 13
      ExplicitHeight = 13
      inherited btnIniciarTrace: TSpeedButton
        Height = 13
        ExplicitHeight = 13
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 13
        ExplicitHeight = 13
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 13
        ExplicitHeight = 13
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 13
        ExplicitHeight = 13
      end
    end
  end
  object pgbStatus: TProgressBar [5]
    Left = 0
    Top = 696
    Width = 1102
    Height = 9
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1008
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 80
  end
  object cdsDuplic: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 856
    Top = 24
    object qryDuplicCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object qryDuplicCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object qryDuplicCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object qryDuplicDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object qryDuplicCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object qryDuplicCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object qryDuplicBAREMB: TStringField
      FieldName = 'BAREMB'
      Size = 15
    end
    object qryDuplicORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 1
    end
    object cdsDuplicITEAGR: TStringField
      FieldName = 'ITEAGR'
      Size = 100
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 388
    Top = 211
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
      Properties.OnValidate = cxeString70PropertiesValidate
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
      Properties.OnValidate = cxeInt03PropertiesValidate
    end
    object cxeInt11: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 11
      Properties.OnValidate = cxeInt03PropertiesValidate
    end
    object cmbSimNao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
      Properties.OnValidate = cmbSimNaoPropertiesValidate
    end
    object cmbClaCRM: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownAutoSize = True
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
    object cmbRspGar: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'L'
        'F')
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
    object cmbMltRca: TcxEditRepositoryLookupComboBoxItem
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
      Properties.OnValidate = cmbEsMiDgPropertiesValidate
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
    object cxeMasInt: TcxEditRepositoryTextItem
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
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeFatCom: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = '#,###0.0000;-#,###0.0000'
      Properties.OnValidate = cxeFatComPropertiesValidate
    end
    object cxePCAPM3: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 6
      Properties.DisplayFormat = '#,###0.000000;-#,###0.000000'
      Properties.OnValidate = cxeFatComPropertiesValidate
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
    object cmbSimNaoFornecedor: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'Sim'
        'N'#227'o'
        'Fornecedor')
    end
    object cxeBarPrinVendaCompra: TcxEditRepositoryTextItem
      Properties.MaxLength = 20
      Properties.OnValidate = cxeBarPrinVendaCompraPropertiesValidate
    end
    object cmbTpEstM: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          Caption = 'DESCAM'
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
      Properties.OnValidate = cmbTpEstMPropertiesValidate
    end
    object cmbTipRet: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownAutoSize = True
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
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 792
    Top = 232
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
    object cmbCarEst: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'ITEM ESTRUTURA'
        'SUB-PRODUTOS')
    end
    object cxBtnMontadora: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = cxBtnMontadoraPropertiesButtonClick
    end
    object cxBtnCklMerGar: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = cxBtnCklMerGarPropertiesButtonClick
    end
  end
  object dtsPermissaoVenda: TDataSource
    Left = 880
    Top = 168
  end
  object dtsParametros: TDataSource
    DataSet = cdsParametros
    Left = 776
    Top = 364
  end
  object cdsParametros: TUniClientDataSet
    PersistDataPacket.Data = {
      6F0000009619E0BD0100000018000000040000000000030000006F000543414D
      504F0100490000000100055749445448020002000A00074D41524341444F0200
      0300000000000644455343524901004900000001000557494454480200020064
      00075649534956454C04000100000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CAMPO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'MARCADO'
        DataType = ftBoolean
      end
      item
        Name = 'DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'VISIVEL'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsParametrosBeforePost
    Left = 540
    Top = 440
    object cdsParametrosCAMPO: TStringField
      FieldName = 'CAMPO'
      Size = 10
    end
    object cdsParametrosMARCADO: TBooleanField
      FieldName = 'MARCADO'
    end
    object cdsParametrosDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsParametrosVISIVEL: TIntegerField
      FieldName = 'VISIVEL'
    end
  end
end
