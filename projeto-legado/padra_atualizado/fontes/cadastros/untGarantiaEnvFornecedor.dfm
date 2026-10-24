inherited frmGarantiaEnvFornecedor: TfrmGarantiaEnvFornecedor
  Left = 342
  Top = 110
  Width = 950
  Height = 550
  BorderIcons = [biSystemMenu]
  Caption = 'Envio para o Fornecedor'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 950
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 477
    Width = 944
    TabOrder = 2
    ExplicitTop = 477
    ExplicitWidth = 944
    object Label2: TLabel [0]
      Left = 9
      Top = 4
      Width = 185
      Height = 14
      Caption = 'Clique no t'#237'tulo da coluna para ordenar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 850
      ExplicitWidth = 850
      object btnConfirmar: TBitBtnLocked
        Tag = 99
        Left = 0
        Top = 0
        Width = 120
        Height = 24
        Caption = '[ F10 ] Confirmar Envio'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Tag = 1
        Left = 120
        Top = 0
        Width = 104
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F8 ] Marcar Todos'
        Enabled = False
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 224
        Top = 0
        Width = 120
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F9 ] Desmarcar Todos'
        Enabled = False
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnSemelhantes: TBitBtnLocked
        Left = 344
        Top = 0
        Width = 132
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F7 ] Alterar C'#243'd. F'#225'brica'
        Enabled = False
        TabOrder = 3
        OnClick = btnSemelhantesClick
      end
      object btnExcel: TBitBtnLocked
        Left = 476
        Top = 0
        Width = 94
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F6 ] Exp. Excel'
        Enabled = False
        TabOrder = 4
        OnClick = btnExcelClick
      end
      object btnUltCompras: TBitBtnLocked
        Left = 570
        Top = 0
        Width = 123
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F5 ] '#218'ltimas Compras'
        Enabled = False
        TabOrder = 5
        OnClick = btnUltComprasClick
      end
      object btnSelecionados: TBitBtnLocked
        Left = 693
        Top = 0
        Width = 148
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F4 ] Consultar Selecionados'
        Enabled = False
        TabOrder = 6
        OnClick = btnSelecionadosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 852
      Top = 2
      Width = 90
      Height = 24
      Align = alRight
      ExplicitLeft = 852
      ExplicitTop = 2
      ExplicitWidth = 90
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 944
    TabOrder = 3
    ExplicitTop = 505
    ExplicitWidth = 944
    inherited pnlNomeForm: TPanel
      Left = 773
      ExplicitLeft = 773
    end
    inherited pnlInfo: TPanel
      Width = 773
      ExplicitWidth = 773
    end
  end
  object pnlFornecedor: TPanel [2]
    Left = 0
    Top = 0
    Width = 944
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 547
      Top = 16
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object edtNomFor: TEditFocus
      Left = 182
      Top = 8
      Width = 363
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 71
      Top = 8
      Width = 110
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 1
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 584
      Top = 8
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 2
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
      Left = 636
      Top = 8
      Width = 154
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
    object chbVenPre: TCheckBox
      Left = 12
      Top = 33
      Width = 302
      Height = 17
      Caption = 'Opera'#231#227'o Presencial - Fornecedor Retirou os produtos'
      TabOrder = 4
    end
    object chkNaoSintetizarItens: TCheckBox
      Left = 344
      Top = 32
      Width = 185
      Height = 17
      Caption = 'N'#227'o Sintetizar Itens'
      TabOrder = 5
    end
  end
  object pbProgresso: TProgressBar [3]
    Left = 0
    Top = 470
    Width = 944
    Height = 7
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  object cxgProdutos: TcxGrid [4]
    Left = 0
    Top = 51
    Width = 944
    Height = 419
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgProdutosDBTableView1: TcxGridDBTableView
      OnDblClick = dbgProdutosDblClick
      OnKeyDown = dbgProdutosKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgProdutosDBTableView1CustomDrawCell
      DataController.DataSource = dtsProdutos
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgProdutosNUMENT: TcxGridDBColumn
        Caption = 'N'#186' Gar.'
        DataBinding.FieldName = 'NUMENT'
        Options.Editing = False
        Options.Focusing = False
        Width = 87
      end
      object cxgProdutosNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Options.Editing = False
        Options.Focusing = False
        Width = 136
      end
      object cxgProdutosCODITE: TcxGridDBColumn
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 52
      end
      object cxgProdutosCODFAB: TcxGridDBColumn
        Caption = 'C'#243'digo de F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Options.Focusing = False
        Width = 104
      end
      object cxgProdutosDESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 176
      end
      object cxgProdutosREFERE: TcxGridDBColumn
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Options.Focusing = False
        Width = 86
      end
      object cxgProdutosUNIDAD: TcxGridDBColumn
        DataBinding.FieldName = 'UNIDAD'
        Options.Editing = False
        Options.Focusing = False
        Width = 46
      end
      object cxgProdutosDTAENT: TcxGridDBColumn
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
        Options.Focusing = False
        Width = 62
      end
      object cxgProdutosNUMDOC: TcxGridDBColumn
        Caption = 'N'#186' Entrada'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 99
      end
      object cxgProdutosQTDREQ: TcxGridDBColumn
        DataBinding.FieldName = 'QTDREQ_1'
        HeaderAlignmentHorz = taRightJustify
        Width = 71
      end
      object cxgProdutosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'GAD_CODEMP'
        Options.Editing = False
        Width = 30
      end
      object cxgProdutosDTAENV: TcxGridDBColumn
        DataBinding.FieldName = 'DTAENV'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgProdutosOBSP_1: TcxGridDBColumn
        Caption = 'Obs 1'
        DataBinding.FieldName = 'OBSP_1'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 200
      end
    end
    object cxgProdutosLevel1: TcxGridLevel
      GridView = cxgProdutosDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 284
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 92
    Top = 164
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsProdutosBeforePost
    AfterScroll = cdsProdutosAfterScroll
    Left = 663
    Top = 88
    object cdsProdutosCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 120
    end
    object cdsProdutosREFERE: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsProdutosUNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'UNIDAD'
      Size = 15
    end
    object cdsProdutosNUMENT: TStringField
      DisplayLabel = 'Nr. Entrada'
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsProdutosQTDREQ: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDREQ'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosDTAENT: TDateTimeField
      DisplayLabel = 'Dt. Entrada'
      FieldName = 'DTAENT'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsProdutosDTAENV: TDateTimeField
      FieldName = 'DTAENV'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsProdutosQTDREQ_1: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDREQ_1'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsProdutosCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsProdutosPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsProdutosTABPRE: TStringField
      FieldName = 'TABPRE'
      Size = 1
    end
    object cdsProdutosNUMDOC: TStringField
      FieldName = 'NUMDOC'
    end
    object cdsProdutosNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsProdutosFIS_ACESSO: TStringField
      FieldName = 'FIS_ACESSO'
      Size = 50
    end
    object cdsProdutosVLRTOT: TFloatField
      FieldName = 'VLRTOT'
    end
    object cdsProdutosNFENTRADA: TStringField
      FieldName = 'NFENTRADA'
    end
    object cdsProdutosOBSP_1: TStringField
      FieldName = 'OBSP_1'
      Size = 70
    end
    object cdsProdutosCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsProdutosGAD_CODEMP: TStringField
      FieldName = 'GAD_CODEMP'
      Size = 3
    end
    object cdsProdutosDOCDEV: TStringField
      FieldName = 'DOCDEV'
      Size = 12
    end
    object cdsProdutosEMPDEV: TStringField
      FieldName = 'EMPDEV'
      Size = 3
    end
    object cdsProdutosESPDEV: TStringField
      FieldName = 'ESPDEV'
      Size = 2
    end
    object cdsProdutosINCDEV: TStringField
      FieldName = 'INCDEV'
    end
    object cdsProdutosINCTMP: TStringField
      FieldName = 'INCTMP'
    end
    object cdsProdutosAGG_QTDREQ_1: TAggregateField
      FieldName = 'AGG_QTDREQ_1'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDREQ_1)'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    OnDataChange = dtsProdutosDataChange
    Left = 693
    Top = 88
  end
  object frxDBGarantia: TfrxDBDataset
    UserName = 'frxDBGarantia'
    CloseDataSource = False
    DataSource = dtsProdutos
    BCDToCurrency = False
    Left = 632
    Top = 128
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 592
    Top = 128
  end
  object frxDocEnvioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40114.449667604200000000
    ReportOptions.LastChange = 40147.706205787000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo11OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 664
    Top = 128
    Datasets = <
      item
        DataSet = frxDBGarantia
        DataSetName = 'frxDBGarantia'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 47.244094490000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 177.637910000000000000
          Width = 362.834880000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 177.637910000000000000
          Top = 15.118120000000000000
          Width = 362.834880000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENVIO PARA O FORNECEDOR')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 545.031850000000000000
          Top = 22.677180000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nro.: [NUMENV]')
          ParentFont = False
        end
        object rllNumPEd: TfrxMemoView
          Left = 545.031850000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo11OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nro.: [NUMPED]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 128.504020000000000000
        Width = 718.110700000000000000
        object Shape1: TfrxShapeView
          Top = 29.574829999999990000
          Width = 718.110236220000000000
          Height = 18.897650000000000000
        end
        object rllTitDoc: TfrxMemoView
          Left = 587.716908900000000000
          Top = 30.574829999999990000
          Width = 118.299229690000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
        end
        object rllTitHis: TfrxMemoView
          Left = 92.522820000000000000
          Top = 30.574829999999990000
          Width = 477.732393310000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object rllTitDta: TfrxMemoView
          Left = 5.669288900000000000
          Top = 30.708688270000010000
          Width = 69.165339690000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'Item')
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559059999999988000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Envio:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 102.047310000000000000
          Top = 7.559059999999988000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DataField = 'DTAENV'
          DataSet = frxDBGarantia
          DataSetName = 'frxDBGarantia'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantia."DTAENV"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 491.338900000000000000
          Top = 7.559059999999988000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total de Itens Enviados: [TOTQTD]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        object Memo10: TfrxMemoView
          Top = 64.252009999999990000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMFRM]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 7.559060000000000000
          Top = 34.795300000000000000
          Width = 313.700990000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Operador: [NOMOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 396.850650000000000000
          Top = 34.795300000000000000
          Width = 313.700990000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Fornecedor: [NOMFOR]')
          ParentFont = False
          WordWrap = False
        end
        object rllData: TfrxMemoView
          Left = 604.724800000000000000
          Top = 64.252009999999990000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] - [Time]')
          ParentFont = False
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 204.094620000000000000
        Width = 718.110700000000000000
        DataSet = frxDBGarantia
        DataSetName = 'frxDBGarantia'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 5.559060000000000000
          Top = 1.779530000000000000
          Width = 69.165354330000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxDBGarantia
          DataSetName = 'frxDBGarantia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBGarantia."CODITE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 90.598488660000000000
          Top = 1.779530000000000000
          Width = 481.134124330000000000
          Height = 15.118120000000000000
          DataField = 'DESITE'
          DataSet = frxDBGarantia
          DataSetName = 'frxDBGarantia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantia."DESITE"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 589.496448660000000000
          Top = 1.779530000000000000
          Width = 114.519714330000000000
          Height = 15.118120000000000000
          DataField = 'QTDREQ_1'
          DataSet = frxDBGarantia
          DataSetName = 'frxDBGarantia'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantia."QTDREQ_1"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDocEnvioM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40114.742711944400000000
    ReportOptions.LastChange = 40148.690060648100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 696
    Top = 128
    Datasets = <
      item
        DataSet = frxDBGarantia
        DataSetName = 'frxDBGarantia'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 208.279865485920200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      LeftMargin = 5.079996719168790000
      RightMargin = 5.079996719168790000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENVIO PARA O FORNECEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNumPed: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nro.: [NUMPED]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nro.: [NUMENV]')
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 119.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data de Envio:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAENV'
          DataSet = frxDBGarantia
          DataSetName = 'frxDBGarantia'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBGarantia."DTAENV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Itens Enviados: [TOTQTD]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.ShadowColor = clNone
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            ' Item         ')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 34.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'Descricao')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 34.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 748.800000000000000000
        DataSet = frxDBGarantia
        DataSetName = 'frxDBGarantia'
        RowCount = 0
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantia."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantia."DESITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 556.799999999999900000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDREQ_1'
          DataSet = frxDBGarantia
          DataSetName = 'frxDBGarantia'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantia."QTDREQ_1"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 255.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.ShadowColor = clNone
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMFRM]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] - [Time]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Operador: [NOMOPE]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Fornecedor: [NOMFOR]')
          TruncOutboundText = False
        end
      end
    end
  end
end
