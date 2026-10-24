inherited frmAgendamentoCiclicoComDia: TfrmAgendamentoCiclicoComDia
  Left = 134
  Top = 170
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Agendamento c'#237'clico com dia de in'#237'cio de ciclo'
  Position = poScreenCenter
  OnClose = FormClose
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1008
    Height = 26
    ExplicitTop = 519
    ExplicitWidth = 1008
    ExplicitHeight = 26
    DesignSize = (
      1008
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 1004
      ExplicitHeight = 22
      object btnMarDes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 128
        Height = 22
        Caption = '[F6] Marcar / Desmarcar'
        TabOrder = 0
        OnClick = btnMarDesClick
      end
      object btnMarDesTodos: TBitBtnLocked
        Left = 128
        Top = 0
        Width = 158
        Height = 22
        Caption = '[F7] Marcar / Desmarcar Todos'
        TabOrder = 1
        OnClick = btnMarDesTodosClick
      end
      object btnAltData: TBitBtnLocked
        Left = 286
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F8] Alterar Data Selecionados'
        TabOrder = 2
        OnClick = btnAltDataClick
      end
      object btnCadCli: TBitBtnLocked
        Left = 446
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F9] Cadastro de Clientes'
        TabOrder = 3
        OnClick = btnCadCliClick
      end
      object btnVendasCliente: TBitBtnLocked
        Left = 606
        Top = 0
        Width = 128
        Height = 22
        Caption = '[F10] Vendas Cliente'
        TabOrder = 4
        OnClick = btnVendasClienteClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 907
      Top = 2
      Width = 99
      ExplicitLeft = 907
      ExplicitTop = 2
      ExplicitWidth = 99
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object lblVenRep: TLabel
      Left = 28
      Top = 14
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
    object shpVen: TShape
      Left = 80
      Top = 10
      Width = 8
      Height = 22
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 88
      Top = 10
      Width = 64
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
      TabOrder = 0
      OnEnter = edtCodVendedorEnter
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 152
      Top = 10
      Width = 400
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgStatusCliente: TRadioGroup
      Left = 562
      Top = 3
      Width = 241
      Height = 34
      Caption = 'Status do Cliente'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Ativos'
        'Inativos'
        'Todos')
      TabOrder = 2
    end
  end
  object dbgAgendamento: TDBGridCitel [3]
    Left = 284
    Top = 300
    Width = 521
    Height = 94
    Ctl3D = False
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgTitleClick]
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    Visible = False
    OnDrawColumnCell = dbgAgendamentoDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CLI_CODVEN'
        ReadOnly = True
        Title.Caption = 'Vendedor'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_CODCLI'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Cliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        ReadOnly = True
        Title.Caption = 'Nome do Cliente'
        Width = 202
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_BAIRRO'
        ReadOnly = True
        Title.Caption = 'Bairro'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REG_DESREG'
        ReadOnly = True
        Title.Caption = 'Regi'#227'o'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        ReadOnly = True
        Title.Caption = 'Cidade'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_ESTADO'
        ReadOnly = True
        Title.Caption = 'UF'
        Width = 22
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATI_DESATI'
        ReadOnly = True
        Title.Caption = 'Atividade'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGE_DTABAI'
        ReadOnly = True
        Title.Caption = #218'ltimo Contato'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGE_DTAAGE'
        Title.Caption = 'Pr'#243'x. Agenda'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_INICIC'
        Title.Caption = 'In'#237'cio'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_INTERV'
        Title.Caption = 'Intervalo'
        Width = 48
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CLI_ULTCOM'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Dta. '#218'lt. Compra'
        Width = 90
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CLI_NASCIM'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Dta. Nascimento'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOT_ORABER'
        ReadOnly = True
        Title.Caption = 'Qtd. Orc. Aberto'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOT_PDABER'
        ReadOnly = True
        Title.Caption = 'Qtd. Ped. Aberto'
        Width = 90
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxGridAgendamento: TcxGridCitel [5]
    Left = 0
    Top = 41
    Width = 1008
    Height = 478
    Align = alClient
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridAgendamentoDBView: TcxGridDBTableViewCitel
      OnKeyDown = cxGridAgendamentoDBViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Insert.Enabled = False
      Navigator.Buttons.Append.Enabled = False
      Navigator.Buttons.Delete.Enabled = False
      Navigator.Buttons.Edit.Enabled = False
      Navigator.Buttons.Post.Enabled = False
      Navigator.Buttons.Cancel.Enabled = False
      FilterBox.Visible = fvAlways
      FindPanel.InfoText = 'Digite um texto para busca...'
      OnCellDblClick = cxGridAgendamentoDBViewCellDblClick
      OnCustomDrawCell = cxGridAgendamentoDBViewCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Filter.AutoDataSetFilter = True
      DataController.MultiThreadedOptions.Filtering = bTrue
      DataController.MultiThreadedOptions.Sorting = bTrue
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.HeaderFilterButtonShowMode = fbmSmartTag
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridAgendamentoCLI_CODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'CLI_CODVEN'
        BestFitMaxWidth = 65
        MinWidth = 65
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 65
      end
      object cxGridAgendamentoCLI_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd.Cliente'
        DataBinding.FieldName = 'CLI_CODCLI'
        BestFitMaxWidth = 65
        MinWidth = 65
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 65
      end
      object cxGridAgendamentoCLI_NOMCLI: TcxGridDBColumn
        Caption = 'Nome do Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 200
      end
      object cxGridAgendamentoREG_DESREG: TcxGridDBColumn
        Caption = 'Regi'#227'o'
        DataBinding.FieldName = 'REG_DESREG'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAgendamentoSUB_DESSUB: TcxGridDBColumn
        AlternateCaption = 'cxGridAgendamentoCLI_CODSUB'
        Caption = 'Sub Regi'#227'o'
        DataBinding.FieldName = 'SUB_DESSUB'
      end
      object cxGridAgendamentoCLI_BAIRRO: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'CLI_BAIRRO'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAgendamentoCID_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAgendamentoCID_ESTADO: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CID_ESTADO'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAgendamentoCLI_STATUS: TcxGridDBColumn
        Caption = 'Status Cliente'
        DataBinding.FieldName = 'STATUS'
        Width = 83
      end
      object cxGridAgendamentoATI_DESATI: TcxGridDBColumn
        Caption = 'Atividade'
        DataBinding.FieldName = 'ATI_DESATI'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAgendamentoAGE_DTABAI: TcxGridDBColumn
        Caption = #218'ltimo Contato'
        DataBinding.FieldName = 'AGE_DTABAI'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 90
      end
      object cxGridAgendamentoAGE_DTAAGE: TcxGridDBColumn
        Caption = 'Pr'#243'x. Agenda'
        DataBinding.FieldName = 'AGE_DTAAGE'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.ClearKey = 46
        Properties.ImmediatePost = True
        Properties.SaveTime = False
        Properties.ShowTime = False
        Options.ShowEditButtons = isebNever
        Styles.Content = cxStyle2
        Width = 90
      end
      object cxGridAgendamentoCLI_INICIC: TcxGridDBColumn
        Caption = 'In'#237'cio'
        DataBinding.FieldName = 'CLI_INICIC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Options.ShowEditButtons = isebNever
        Styles.Content = cxStyle2
      end
      object cxGridAgendamentoCLI_INTERV: TcxGridDBColumn
        Caption = 'Intervalo'
        DataBinding.FieldName = 'CLI_INTERV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Options.ShowEditButtons = isebNever
        Styles.Content = cxStyle2
      end
      object cxGridAgendamentoCLI_ULTCOM: TcxGridDBColumn
        Caption = 'Dta. '#218'lt. Compra'
        DataBinding.FieldName = 'CLI_ULTCOM'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 90
      end
      object cxGridAgendamentoCLI_NASCIM: TcxGridDBColumn
        Caption = 'Dta. Nascimento'
        DataBinding.FieldName = 'CLI_NASCIM'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 90
      end
      object cxGridAgendamentoTOT_ORABER: TcxGridDBColumn
        Caption = 'Qtd. Orc. Aberto'
        DataBinding.FieldName = 'TOT_ORABER'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 90
      end
      object cxGridAgendamentoTOT_PDABER: TcxGridDBColumn
        Caption = 'Qtd. Ped. Aberto'
        DataBinding.FieldName = 'TOT_PDABER'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 90
      end
      object cxGridAgendamentoMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        Options.Editing = False
      end
    end
    object cxGridAgendamentoPrimeiroNivel: TcxGridLevel
      GridView = cxGridAgendamentoDBView
      Options.DetailTabsPosition = dtpLeft
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 648
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 488
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 8
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      ' ')
    Constraints = <>
    Left = 520
    Top = 8
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 552
    Top = 8
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    ProviderName = 'dspConsulta'
    AfterInsert = cdsConsultaAfterInsert
    BeforePost = cdsConsultaBeforePost
    AfterPost = cdsConsultaAfterPost
    Left = 584
    Top = 8
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    OnDataChange = dtsConsultaDataChange
    Left = 616
    Top = 8
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
  end
end
