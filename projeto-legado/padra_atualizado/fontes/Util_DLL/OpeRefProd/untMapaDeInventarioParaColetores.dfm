inherited frmMapaDeInventarioParaColetores: TfrmMapaDeInventarioParaColetores
  Width = 1024
  Height = 768
  Caption = 'Listagem de Mapa de Invet'#225'rios para Coletores'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 696
    Width = 1018
    Height = 27
    TabOrder = 2
    ExplicitTop = 696
    ExplicitWidth = 1018
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      Height = 23
      ExplicitWidth = 1014
      ExplicitHeight = 23
      object btnNovoMapa: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F10 ] Novo Mapa'
        TabOrder = 0
        OnClick = btnNovoMapaClick
      end
      object btnReiniciarContagem: TBitBtnLocked
        Left = 130
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F9 ] Reinicar Contagem'
        TabOrder = 1
        Visible = False
        OnClick = btnReiniciarContagemClick
      end
      object btnTrocaOperador: TBitBtnLocked
        Left = 260
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F8 ] Trocar Operador'
        TabOrder = 2
        Visible = False
        OnClick = btnTrocaOperadorClick
      end
      object btnExcluirInventario: TBitBtnLocked
        Left = 390
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F7 ] Excluir Invent'#225'rio'
        TabOrder = 3
        OnClick = btnExcluirInventarioClick
      end
      object btnReiniciaContagemLoc: TBitBtnLocked
        Left = 520
        Top = 0
        Width = 407
        Height = 22
        Caption = '[ F8 ] Reiniciar Contagem da Localiza'#231#227'o'
        TabOrder = 4
        OnClick = btnReiniciaContagemLocClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      Top = 2
      ExplicitLeft = 935
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 3
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 133
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 34
      Top = 13
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador.:'
    end
    object Label4: TLabel
      Left = 41
      Top = 60
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto.:'
    end
    object Label6: TLabel
      Left = 454
      Top = 13
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica.:'
    end
    object Label7: TLabel
      Left = 524
      Top = 36
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rua.:'
    end
    object Label8: TLabel
      Left = 514
      Top = 82
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Andar.:'
    end
    object Label9: TLabel
      Left = 513
      Top = 60
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#233'dio.:'
    end
    object Label10: TLabel
      Left = 481
      Top = 105
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Apartamento.:'
    end
    object Label11: TLabel
      Left = 19
      Top = 82
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 24
      Top = 36
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 48
      Top = 105
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtApartamento: TEditFocus
      Left = 552
      Top = 102
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndar: TEditFocus
      Left = 552
      Top = 79
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredio: TEditFocus
      Left = 552
      Top = 56
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRua: TEditFocus
      Left = 552
      Top = 33
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Left = 552
      Top = 10
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 88
      Top = 79
      Width = 57
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 3
      Text = ''
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 146
      Top = 79
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Tag = 99
      Left = 88
      Top = 33
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 146
      Top = 33
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Tag = 99
      Left = 88
      Top = 102
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 4
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 146
      Top = 102
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
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
      Left = 88
      Top = 56
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 146
      Top = 56
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpe: TEditFocus
      Left = 146
      Top = 10
      Width = 300
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 88
      Top = 10
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object btnBusca: TBitBtnLocked
      Left = 701
      Top = 102
      Width = 112
      Height = 22
      Caption = '[ F5 ] Buscar'
      TabOrder = 10
      OnClick = btnBuscaClick
    end
  end
  object cxDados: TcxGridCitel [3]
    Left = 0
    Top = 133
    Width = 1018
    Height = 537
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnFocusedRecordChanged = cxgDadosFocusedRecordChanged
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'KEY_MAPGER'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosColumn1: TcxGridDBColumn
        Caption = 'Invent'#225'rio'
        DataBinding.FieldName = 'MPG_NUMINV'
        OnGetDisplayText = cxgDadosColumn1GetDisplayText
        Options.Editing = False
      end
      object cxgDadosColumn2: TcxGridDBColumn
        Caption = 'C'#243'd. Operador'
        DataBinding.FieldName = 'MPG_CODOPE'
        Visible = False
        Options.Editing = False
        Width = 87
      end
      object cxgDadosColumn3: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'MPD_CODOPE'
        Visible = False
        Options.Editing = False
        Width = 245
      end
      object cxgDadosColumn4: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        MinWidth = 100
        Options.Editing = False
        Width = 100
      end
      object cxgDadosColumn5: TcxGridDBColumn
        Caption = 'Diverg'#234'ncia'
        DataBinding.FieldName = 'DIVERGENCIA_GERAL'
        MinWidth = 64
        Options.Editing = False
      end
      object cxgDadosColumn6: TcxGridDBColumn
        Caption = 'Recontar'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Recontar Divergencias do Mapa'
            Default = True
            Kind = bkText
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = cxgDadosColumn6PropertiesButtonClick
        Width = 219
      end
      object cxgDadosColumn7: TcxGridDBColumn
        Caption = #218'lt. Contagem'
        DataBinding.FieldName = 'MAX_NUMCON'
        Options.Editing = False
        Width = 80
      end
      object cxgDadosColumn8: TcxGridDBColumn
        Caption = 'Status da '#218'lt. Contagem'
        DataBinding.FieldName = 'STATUS_MAXNUMCOM'
        Options.Editing = False
        Width = 130
      end
    end
    object cxgDetalhes: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DetailKeyFieldNames = 'KEY_MAPGER'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.MasterKeyFieldNames = 'AUTOINCREM'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
    end
    object cxgDetalhe: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      OnCustomDrawCell = cxgDetalheCustomDrawCell
      OnFocusedItemChanged = cxgDetalheFocusedItemChanged
      OnFocusedRecordChanged = cxgDetalheFocusedRecordChanged
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dtsDetalhes
      DataController.DetailKeyFieldNames = 'KEY_MAPGER'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.MasterKeyFieldNames = 'AUTOINCREM'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OnCustomDrawGroupCell = cxgDetalheCustomDrawGroupCell
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDetalheMPD_NUMCON: TcxGridDBColumn
        Caption = 'Contagem'
        DataBinding.FieldName = 'MPD_NUMCON'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxgDetalheMPD_LOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o Fisica'
        DataBinding.FieldName = 'MPD_LOCFIS'
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
      end
      object cxgDetalheITE_CODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
        Options.Editing = False
        Width = 100
      end
      object cxgDetalheMPD_CODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'MPD_CODITE'
        MinWidth = 64
        Options.Editing = False
        SortIndex = 2
        SortOrder = soAscending
      end
      object cxgDetalheITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
      end
      object cxgDetalheSALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
      end
      object cxgDetalheLOT_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        Options.Editing = False
        SortIndex = 3
        SortOrder = soAscending
      end
      object cxgDetalheLOT_DTAVAL: TcxGridDBColumn
        Caption = 'Data de Validade'
        DataBinding.FieldName = 'LOT_DTAVAL'
        MinWidth = 80
        Options.Editing = False
      end
      object cxgDetalheMPD_QTDCON: TcxGridDBColumn
        Caption = 'Qtd. Contagem'
        DataBinding.FieldName = 'MPD_QTDCON'
        MinWidth = 80
        Options.Editing = False
      end
      object cxgDetalheSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Visible = False
      end
      object cxgDetalheLINDES_STATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'LINDES_STATUS'
        Options.Editing = False
      end
      object cxgDetalheMPG_CODOPE: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'MPD_CODOPE'
        MinWidth = 64
        Options.Editing = False
      end
      object cxgDetalheCOD_STATUS: TcxGridDBColumn
        DataBinding.FieldName = 'COD_STATUS'
        Visible = False
        OnGetDisplayText = cxGrid1DBTableView1GroupGetDisplayText
        GroupIndex = 0
        IsCaptionAssigned = True
      end
      object cxgDetalheMDP_STATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'MPD_STATUS'
        Visible = False
      end
      object cxgDetalheOPE_NOMOPE: TcxGridDBColumn
        Caption = 'Nome Operador'
        DataBinding.FieldName = 'OPE_NOMOPE'
        Options.Editing = False
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
      object cxlDetalhe: TcxGridLevel
        GridView = cxgDetalhe
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 670
    Width = 1018
    Height = 26
    Align = alBottom
    TabOrder = 4
    object pnlLegendas: TPanel
      Left = 1
      Top = 1
      Width = 488
      Height = 24
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Concluído: TLabel
        Left = 420
        Top = 4
        Width = 47
        Height = 14
        Caption = 'Conclu'#237'do'
      end
      object Label2: TLabel
        Left = 156
        Top = 4
        Width = 58
        Height = 14
        Caption = 'N'#227'o Iniciado'
      end
      object Label3: TLabel
        Left = 252
        Top = 4
        Width = 36
        Height = 14
        Caption = 'Iniciado'
      end
      object Label5: TLabel
        Left = 324
        Top = 4
        Width = 52
        Height = 14
        Caption = 'Divergente'
      end
      object shpConcluido: TShape
        Left = 400
        Top = 4
        Width = 14
        Height = 14
        Brush.Color = clInactiveCaption
      end
      object shpDivergente: TShape
        Left = 304
        Top = 4
        Width = 14
        Height = 14
        Brush.Color = clInactiveCaption
      end
      object shpIniciado: TShape
        Left = 232
        Top = 4
        Width = 14
        Height = 14
        Brush.Color = clInactiveCaption
      end
      object shpNaoInciaido: TShape
        Left = 136
        Top = 3
        Width = 14
        Height = 14
        Brush.Color = clBtnFace
      end
      object btnExpandir: TBitBtnLocked
        Left = 1
        Top = 0
        Width = 65
        Height = 20
        Caption = '&Expandir'
        TabOrder = 0
        OnClick = btnExpandirClick
      end
      object btnRetrai: TBitBtnLocked
        Left = 65
        Top = 0
        Width = 65
        Height = 20
        Caption = '&Retrair'
        TabOrder = 1
        OnClick = btnRetraiClick
      end
    end
    object pnlOpeResp: TPanel
      Left = 489
      Top = 1
      Width = 528
      Height = 24
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object Label14: TLabel
        Left = 11
        Top = 4
        Width = 154
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador Respons'#225'vel Coletor.:'
      end
      object edtCodOpeResp: TEditFocus
        Tag = 99
        Left = 168
        Top = 1
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodOpeRespKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomOpeResp: TEditFocus
        Left = 226
        Top = 1
        Width = 300
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
  end
  object dtsDados: TDataSource
    Left = 500
    Top = 372
  end
  object dtsDetalhes: TDataSource
    Left = 596
    Top = 352
  end
end
