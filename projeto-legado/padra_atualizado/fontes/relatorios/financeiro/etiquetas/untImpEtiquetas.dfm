inherited frmImpEtiquetas: TfrmImpEtiquetas
  Left = 151
  Top = 92
  Width = 1112
  Height = 682
  BorderStyle = bsSizeable
  Caption = 'Impress'#227'o de Etiquetas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1112
  ExplicitHeight = 682
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 1096
    TabOrder = 7
    ExplicitTop = 510
    ExplicitWidth = 1096
    DesignSize = (
      1096
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1092
      ExplicitWidth = 1092
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 627
    Width = 1096
    ExplicitTop = 627
    ExplicitWidth = 1096
    inherited pnlNomeForm: TPanel
      Left = 925
      ExplicitLeft = 925
    end
    inherited pnlInfo: TPanel
      Width = 925
      ExplicitWidth = 925
    end
  end
  inherited pgcDados: TPageControl
    Top = 52
    Width = 1096
    Height = 458
    Visible = False
    ExplicitTop = 52
    ExplicitWidth = 1096
    ExplicitHeight = 458
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1088
      ExplicitHeight = 426
    end
  end
  object pnlBotoesImp: TPanel [3]
    Left = 0
    Top = 586
    Width = 1096
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object btnConfirma: TBitBtnLocked
      Left = 577
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F10] Confirma'
      TabOrder = 5
      WordWrap = True
      OnClick = btnConfirmaClick
    end
    object btnSairImp: TBitBtnLocked
      Left = 979
      Top = 2
      Width = 115
      Height = 37
      Align = alRight
      Caption = '[Esc] Sair'
      TabOrder = 6
      WordWrap = True
      OnClick = btnSairImpClick
    end
    object btnConfigurar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F6] &Configurar'
      TabOrder = 0
      WordWrap = True
      OnClick = btnConfigurarClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 462
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '   [F9] Marcar / Desmarcar Todas '
      TabOrder = 4
      WordWrap = True
      OnClick = btnMarDesClick
    end
    object btnIniBusca: TBitBtnLocked
      Left = 117
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F5] Filtro de Etiquetas'
      TabOrder = 1
      WordWrap = True
      OnClick = btnIniBuscaClick
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 232
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F7] Limpa Filtros'
      TabOrder = 2
      WordWrap = True
      OnClick = BitBtnLocked1Click
    end
    object btnQtdEti: TBitBtnLocked
      Left = 347
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F8] Definir quantidade de Etiquetas Itens Grid'
      TabOrder = 3
      Visible = False
      WordWrap = True
      OnClick = btnQtdEtiClick
    end
    object btnEtiquetaEletronica: TBitBtnLocked
      Left = 692
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F11] Gerar .csv para Etiquetas Eletr'#244'nicas'
      TabOrder = 7
      Visible = False
      WordWrap = True
      OnClick = btnEtiquetaEletronicaClick
    end
    object btnHlpExpEtiEle: TBitBtnLocked
      Left = 1037
      Top = 2
      Width = 24
      Height = 37
      Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
      Align = alLeft
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      TabOrder = 8
      Visible = False
      OnClick = btnHlpExpEtiEleClick
    end
    object btnCfgVisualizacao: TBitBtnLocked
      Left = 807
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = '[F12] Configurar Visualiza'#231#227'o'
      TabOrder = 9
      Visible = False
      WordWrap = True
      OnClick = btnCfgVisualizacaoClick
    end
    object btnCodBar: TBitBtnLocked
      Left = 922
      Top = 2
      Width = 115
      Height = 37
      Align = alLeft
      Caption = 'Selecionar itens por C'#243'digo de Barras'
      TabOrder = 10
      Visible = False
      WordWrap = True
      OnClick = btnCodBarClick
    end
  end
  object pnlBusca: TPanel [4]
    Left = 0
    Top = 510
    Width = 1096
    Height = 69
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblPercentDesconto: TColorLabel
      Left = 898
      Top = 11
      Width = 117
      Height = 14
      Alignment = taRightJustify
      Caption = 'Percentual de desconto:'
      Visible = False
      CorDestaque = clRed
    end
    object lblSimboloDesconto: TColorLabel
      Left = 1066
      Top = 7
      Width = 10
      Height = 14
      Caption = '%'
      Visible = False
      CorDestaque = clRed
    end
    object lblTotEti: TLabel
      Left = 948
      Top = 35
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Etiquetas:'
    end
    object lblPromocao: TLabel
      Left = 463
      Top = 16
      Width = 112
      Height = 14
      Caption = 'ITEM EM PROMO'#199#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ShpJaImp: TShape
      Left = 758
      Top = 6
      Width = 17
      Height = 11
      Brush.Color = clMoneyGreen
    end
    object ShpNaoImp: TShape
      Left = 758
      Top = 23
      Width = 17
      Height = 11
    end
    object ShpSemData: TShape
      Left = 758
      Top = 40
      Width = 17
      Height = 11
      Brush.Color = clSilver
    end
    object lblJaImp: TLabel
      Left = 780
      Top = 5
      Width = 237
      Height = 14
      Caption = 'Item ja impresso ap'#243's a ultima altera'#231#227'o de pre'#231'o'
    end
    object lblNaoImp: TLabel
      Left = 780
      Top = 21
      Width = 247
      Height = 14
      Caption = 'Item n'#227'o impresso ap'#243's a ultima altera'#231#227'o de pre'#231'o'
    end
    object lblSemData: TLabel
      Left = 780
      Top = 38
      Width = 237
      Height = 14
      Caption = 'Item sem data da '#250'ltima impress'#227'o (sem controle)'
    end
    object edtPercentDesconto: TEditFocus
      Left = 1021
      Top = 6
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      Visible = False
      OnExit = edtPercentDescontoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '##0.00'
    end
    object edtTotEti: TEditFocus
      Left = 1021
      Top = 31
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      Color = 16770261
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object rdgStatus: TRadioGroup
      Left = 12
      Top = 2
      Width = 211
      Height = 36
      Caption = 'Status'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        '&Ativo'
        '&Inativo'
        '&Todos')
      TabOrder = 1
      Visible = False
      OnClick = rdgStatusClick
    end
    object rdgSaldos: TRadioGroup
      Left = 223
      Top = 2
      Width = 234
      Height = 36
      Caption = 'Saldo'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Positivo'
        'Negativo')
      TabOrder = 3
      Visible = False
      OnClick = rdgSaldosClick
    end
    object Panel1: TPanel
      Left = 12
      Top = 32
      Width = 733
      Height = 41
      BevelOuter = bvNone
      TabOrder = 4
      object ColorLabel1: TColorLabel
        AlignWithMargins = True
        Left = 448
        Top = 15
        Width = 259
        Height = 23
        Margins.Top = 15
        Align = alLeft
        Caption = 'A ordem da impress'#227'o seguir'#225' a ordena'#231#227'o da grade!'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
        ExplicitHeight = 14
      end
      object chkOpcCarregamento: TCheckBox
        Left = 0
        Top = 0
        Width = 445
        Height = 41
        Align = alLeft
        Caption = 
          'Abrir esta tela sem informa'#231#245'es e limpar  os dados ap'#243's impress'#227 +
          'o?'
        TabOrder = 0
      end
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 1096
    Height = 52
    Align = alTop
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 135
      Height = 14
      Caption = 'Escolha o tipo de impress'#227'o'
    end
    object rdbTermica: TRadioButton
      Left = 8
      Top = 28
      Width = 73
      Height = 17
      Caption = '&T'#233'rmica'
      TabOrder = 0
      OnClick = rdbTermicaClick
    end
    object rdbMatricial: TRadioButton
      Left = 80
      Top = 27
      Width = 73
      Height = 17
      Caption = '&Matricial'
      TabOrder = 1
      OnClick = rdbMatricialClick
    end
  end
  object pgbEtique: TcxProgressBar [6]
    Left = 0
    Top = 579
    Align = alBottom
    AutoSize = False
    Properties.ShowTextStyle = cxtsText
    TabOrder = 5
    Height = 7
    Width = 1096
  end
  object dbgEtiquetas: TcxGrid [7]
    Left = 0
    Top = 52
    Width = 1096
    Height = 458
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgEtiquetasTableView: TcxGridDBTableView
      OnKeyDown = dbgEtiquetasTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgEtiquetasTableViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.OnChanged = dbgEtiquetasTableViewDataControllerFilterChanged
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.MRUItemsList = False
      Filtering.ColumnAddValueItems = False
      Filtering.ColumnMRUItemsList = False
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro encontrado>'
      OptionsView.GroupByBox = False
    end
    object dbgEtiquetasLevel1: TcxGridLevel
      GridView = dbgEtiquetasTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 112
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 120
  end
  object frxDBImpEti: TfrxDBDataset
    UserName = 'frxDBImpEti'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 96
    Top = 360
  end
  object frxPagina: TfrxReport
    Version = '5.6.11'
    DataSetName = 'frxEtiquetaItens'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'IMP_EDUARDO'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39377.549029351900000000
    ReportOptions.LastChange = 39826.491681307900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 472
    Top = 336
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 18.897650000000000000
        Width = 793.701299999999900000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 18.897650000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Visible = False
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 18.897650000000000000
          Top = 41.574830000000000000
          Width = 230.551330000000000000
          Height = 41.574830000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 18.897650000000000000
          Top = 86.929190000000010000
          Width = 230.551330000000000000
          Height = 60.472480000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxEtiqClientes: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 39826.442771990740000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 432
    Top = 224
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 96.000000000000000000
        Top = 18.897650000000000000
        Width = 797.102877000000000000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Width = 252.094485750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."NOME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Top = 22.677180000000000000
          Width = 252.094485750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Top = 41.574830000000000000
          Width = 252.094485750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxDBImpEti."BAIRRO"> + '#39' - '#39' + FormatMaskText('#39'99999-999;0;_'#39 +
              ',<frxDBImpEti."C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Top = 60.472479999999990000
          Width = 252.094485750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxEtiqItensCodBarra: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.406450532400000000
    ReportOptions.LastChange = 40002.465640000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllVal5xOnAfterData(Sender: TfrxComponent);'
      'begin'
      
        '  rllVal5x.Text := '#39'5 x R$ '#39' + FormatFloat('#39'#,##0.00'#39', <frxDBImp' +
        'Eti."VALITE"> / 5);'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 624
    Top = 192
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object CodBarraComPreco: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 3.000000000000000000
      RightMargin = 3.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 117.165354330000000000
        Top = 18.897650000000000000
        Width = 771.024120000000000000
        Columns = 3
        ColumnWidth = 249.448818897638000000
        ColumnGap = 7.559055118110240000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 4.774273330000000000
          Top = 12.435683340000000000
          Width = 236.551330000000000000
          Height = 34.771655980000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."CODITE"] - [frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object rllVal5x: TfrxMemoView
          Left = 4.774273330000000000
          Top = 45.989486670000010000
          Width = 236.551330000000000000
          Height = 23.118119990000000000
          OnAfterData = 'rllVal5xOnAfterData'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'R$ #,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
        object rdbValorVista: TfrxMemoView
          Left = 68.811070000000000000
          Top = 75.590600000000000000
          Width = 172.299320000000000000
          Height = 15.559059990000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'R$ #,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."VALVIS"]')
          ParentFont = False
        end
        object rllEtiqueta: TfrxMemoView
          Left = 7.559060000000000000
          Top = 75.590600000000000000
          Width = 56.692950000000000000
          Height = 15.496062990000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'A VISTA')
          ParentFont = False
        end
      end
    end
  end
  object CodigoBarra: TfrxBarCodeObject
    Left = 672
    Top = 288
  end
  object frxEtiqFornecedores: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39456.493103935200000000
    ReportOptions.LastChange = 39826.435170532400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 352
    Top = 224
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 96.000000000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Width = 255.874015750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."NOME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Top = 22.677180000000000000
          Width = 255.874015750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Top = 41.574830000000000000
          Width = 255.874015750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxDBImpEti."BAIRRO"> + '#39' - '#39' + FormatMaskText('#39'99999-999;0;_'#39 +
              ',<frxDBImpEti."C_E_P_">)] ')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Top = 60.472480000000000000
          Width = 255.874015750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxEtiqItensZebra: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.411589062500000000
    ReportOptions.LastChange = 40451.551144016200000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 584
    Top = 288
  end
  object frxUserDataSet1: TfrxUserDataSet
    UserName = 'frxUserDataSet1'
    OnCheckEOF = frxUserDataSet1CheckEOF
    OnFirst = frxUserDataSet1First
    OnNext = frxUserDataSet1Next
    OnGetValue = frxUserDataSet1GetValue
    Left = 24
    Top = 360
  end
  object frxEtiqEstruturaCodBarra: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.411589062500000000
    ReportOptions.LastChange = 39826.404307719910000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 424
    Top = 168
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Gondola: TfrxReportPage
      PaperWidth = 104.000000000000000000
      PaperHeight = 29.500000000000000000
      PaperSize = 256
      Columns = 2
      ColumnWidth = 52.000000000000000000
      ColumnPositions.Strings = (
        '0'
        '52')
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 90.708661420000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 196.535560000000000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object BarCode1: TfrxBarCodeView
          Left = 85.695423330000000000
          Top = 42.204700000000000000
          Width = 95.000000000000000000
          Height = 43.989486670000000000
          BarType = bcCodeEAN13
          DataField = 'CODBAR'
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Rotation = 0
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo4: TfrxMemoView
          Left = 29.015770000000000000
          Top = 38.574830000000000000
          Width = 35.884353330000010000
          Height = 8.692913389999999000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 29.015770000000000000
          Top = 26.913420000000000000
          Width = 151.937007870000000000
          Height = 8.692913389999999000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."ITEM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 1.220470000000000000
          Top = 38.574830000000000000
          Width = 26.834645670000000000
          Height = 8.692913389999999000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 1.220470000000000000
          Top = 26.913420000000000000
          Width = 26.834645670000000000
          Height = 8.692913389999999000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM:')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 1.220470000000000000
          Top = 16.209956670000000000
          Width = 179.506493330000000000
          Height = 8.692913389999999000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."ESTRUT"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxEtiqDiversos: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 39826.435998796290000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 203
    Top = 348
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 96.000000000000000000
        Top = 18.897650000000000000
        Width = 778.205227000000000000
        Columns = 2
        ColumnWidth = 377.952755905511800000
        ColumnGap = 22.677165354330710000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Width = 365.480385750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."NOME"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Top = 22.677180000000000000
          Width = 365.480385750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Top = 41.574830000000000000
          Width = 365.480385750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Top = 60.472479999999990000
          Width = 267.212605750000000000
          Height = 18.897650000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 272.126160000000000000
          Top = 60.472480000000000000
          Width = 93.354225750000000000
          Height = 18.897650000000000000
          DataField = 'C_E_P_'
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."C_E_P_"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object cdsImpEti: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 304
    object cdsImpEtiNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsImpEtiENDERE: TStringField
      FieldName = 'ENDERE'
      Size = 60
    end
    object cdsImpEtiBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 30
    end
    object cdsImpEtiC_E_P_: TStringField
      FieldName = 'C_E_P_'
      Size = 9
    end
    object cdsImpEtiNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 40
    end
    object cdsImpEtiENDNUM: TStringField
      FieldName = 'ENDNUM'
      Size = 10
    end
    object cdsImpEtiENDCOM: TStringField
      FieldName = 'ENDCOM'
      Size = 50
    end
  end
  object cdsImpEtiEst: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspImpEti'
    Left = 424
    Top = 288
    object cdsImpEtiEstESTRUT: TStringField
      FieldName = 'ESTRUT'
      Size = 70
    end
    object cdsImpEtiEstCODSUB: TStringField
      FieldName = 'CODSUB'
      Size = 5
    end
    object cdsImpEtiEstITEM: TStringField
      FieldName = 'ITEM'
      Size = 70
    end
    object cdsImpEtiEstQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsImpEtiEstDESPCA: TStringField
      FieldName = 'DESPCA'
      Size = 30
    end
    object cdsImpEtiEstQTDETI: TIntegerField
      FieldName = 'QTDETI'
    end
    object cdsImpEtiEstCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
  end
  object cdsImpEtiIte: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspImpEti'
    Left = 496
    Top = 296
    object cdsImpEtiIteNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 40
    end
    object cdsImpEtiIteDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsImpEtiIteQTDETI: TIntegerField
      FieldName = 'QTDETI'
    end
    object cdsImpEtiIteVALITE: TFloatField
      FieldName = 'VALITE'
    end
    object cdsImpEtiIteCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object cdsImpEtiIteREFERE: TStringField
      FieldName = 'REFERE'
      Size = 50
    end
    object cdsImpEtiIteSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsImpEtiIteCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsImpEtiIteCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsImpEtiIteLOCFIS: TStringField
      FieldName = 'LOCFIS'
      Size = 10
    end
    object cdsImpEtiIteCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsImpEtiIteVALVIS: TFloatField
      FieldName = 'VALVIS'
    end
    object cdsImpEtiIteCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object cdsImpEtiIteDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 40
    end
    object cdsImpEtiIteCODAMZ: TStringField
      FieldName = 'CODAMZ'
      Size = 3
    end
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.406450532400000000
    ReportOptions.LastChange = 40198.577235057870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllVal5xOnAfterData(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 680
    Top = 128
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ProdutoSemCodBarra: TfrxReportPage
      PaperWidth = 220.000000000000000000
      PaperHeight = 285.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 15.000000000000000000
      TopMargin = 12.000000000000000000
      BottomMargin = 11.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 49.133858267716530000
        Top = 18.897650000000000000
        Width = 752.126470000000000000
        Columns = 4
        ColumnWidth = 171.968503937008000000
        ColumnGap = 7.559055118110240000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 9.913385830000000000
          Top = 13.435683340000000000
          Width = 154.204736610000000000
          Height = 19.653535980000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBImpEti."CODITE"] - [frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object rllEtiqueta: TfrxMemoView
          Left = 147.196970000000000000
          Top = 33.244094490000000000
          Width = 17.007864250000000000
          Height = 11.716532990000000000
          DataField = 'SIGUNI'
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."SIGUNI"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 9.559060000000000000
          Top = 40.472480000000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          DataSet = frxDBImpEti
          DataSetName = 'frxDBImpEti'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'R$ #,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object cdsPromoc: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 304
    object cdsPromocITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
      Size = 5
    end
    object cdsPromocITE_PREPRO: TFloatField
      FieldName = 'ITE_PREPRO'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object frxReport2: TfrxReport
    Version = '5.6.11'
    DataSetName = 'frxEtiquetaItens'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'IMP_EDUARDO'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39377.549029351900000000
    ReportOptions.LastChange = 39826.492693495400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 536
    Top = 136
    Datasets = <
      item
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 18.897650000000000000
        Width = 793.701299999999900000
        Columns = 3
        ColumnGap = 264.566929133858000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 18.897650000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 18.897650000000000000
          Top = 56.692950000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBImpEti."DESITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 18.897650000000000000
          Top = 86.929190000000010000
          Width = 230.551330000000000000
          Height = 60.472480000000000000
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBImpEti."VALITE"]')
          ParentFont = False
        end
      end
    end
  end
  object cdsCodBar: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 96
    object cdsCodBarCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsCodBarCODBAR: TStringField
      FieldName = 'CODBAR'
    end
  end
  object cdsArmaze: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 224
    object cdsArmazeCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsArmazeCODAMZ: TStringField
      FieldName = 'CODAMZ'
      Size = 3
    end
  end
  object frxEtiEletronica: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43924.649143819440000000
    ReportOptions.LastChange = 43924.649143819440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 592
    Top = 375
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 300.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 1058.268400000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 937.323440000000000000
        Top = 102.047310000000000000
        Width = 1058.268400000000000000
        object SysMemo1: TfrxSysMemoView
          Align = baCenter
          Left = 377.953000000000000000
          Top = 26.456710000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TABELA DE CAMPOS E DADOS')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Align = baCenter
          Left = 192.756030000000000000
          Top = 71.811070000000010000
          Width = 672.756340000000000000
          Height = 842.835190000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D49484452000002A5
            0000035A08020000003F09A21D000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            00FFA549444154785EECFDFF931CE77DE709F65F8161FF420FD911DC885BDC97
            2036021E0C2CD71D573DA7C1E8B62776B937680D6B23B07104BD9A93695A6E18
            F4F0441F694074DFC0E35DB63592A7E710587A0CCBAA81660D8DC8E6F488A469
            C20DB5487128B0D98448C16DB0710C1864038D2F6C35DBBCCFB7E7C9E77932AB
            B2AA32ABEAA9ACCF2B3280ACECA79E7CBEE4E7F3CEE7C9ACE733F699A2288AA2
            28552747EFC71445511445194E44CB897CBD97BDF888B96C4AA78C6C6F56A3E2
            6A8C8A12218161E65869CC66AC2EA64A8C6C6F56A3E26A8C8A12218161E65869
            CC66AC2EA64A8C6C6F56A3E26A8C8A12218161E65869CC66AC2EA64A8C6C6F56
            A3E26A8C8A12218161E658691333BEBEBA383F531B87BF8E8D8DD7664E2DAF6F
            C1D1EDE5D9093A444CCE345636D3074F2EADEF40DACDE5D99A1C430E37D63757
            E71FC4DDF12F372E636E9F7DB6B3B97C8212ED9959BC4A473CE00FB2A70C3F23
            DB9B7EC5B7D71B87F1927798985DDEC63F1993999C5F450B02FB58999F441B1C
            3FD4B8CC473EFB7879F600A6193FBA785D0E19037C707EF50E1D08F2596BD427
            C6EA8D75390E968867E36FC9A937C9DCF13BF83563C21EF007D95314251A02C3
            CCB1D22C3366191EAF1D5D58DFD9D95C3959079F533BB1BCB9433E62A2DE58FB
            6CE752E3D06EF61DC941B84B681CC52FCE2E6DFACE85B07700E393F32BE44FAE
            2ECEECA123FCF510F883EC29C3CFC8F66666C53DB9658CBA27CA6D943C39727D
            718693249675476EA313B3B286766076F9E336F49EEF21268F2EC24DC5F595F9
            43E362C21E909DEC298A120D8161E6586996199383480610EC506AB3CB9BA1DE
            531A47EF8DCFC2E3D79BE8FD9E5A6D42461EE8BCC6F7D5F68DABDE8F0023DB9B
            99154FEBFDCEEAFCE4D883DF6AFCFEA4556E4EB4AF561BE7233BD7178F8EB305
            59CB428B9B98FCD6E96F81DDC9809E0C6DE2F0CCAFEE199F59BC9EABF7EB8D3A
            DC2C604A824DD8BB1341D41815254202C3CCB1D20C33664F6027156506122599
            FF228C1F9A5F41174107AD60B34F81E1C855DA11C87BF09F0E7D6BFEB1714C70
            8B9CD783DF987FC2F9BA077C51F694E167647B33B3E289DCCA01BAAB861BE58F
            2FA0DCB2F571A2FAEFCFCFECA123341F36393B7F3C916DBA4BD833B3B84637E5
            3C0DC07A3FBB84397DB971F9A7BEDE7B4001EEE049ECDC0040F707DE9D3A0289
            654F519468080C33C74A33CC3847EF61E7A7971B5F1E1FDB7DA871C938A5667A
            9F1EDF1F6EAC3C0FC3FADAEC771BE4C52E2CB95FF75017532546B637332B1EEA
            3D8DAA6990CDD369A4DCA2F77FBA8277C60766174E83E14CCE2F2D259665EE12
            AEEF90F0B36C8BDE2F6F5D6A1CDA3339FFBD3F6D39BE57BD5794E12530CC1C2B
            CD30E3644E9E3D8095F03B89B4F37344BA27F0F43E7F3E1F8EAC9BC7F6E865B6
            DCAFFB64944D195A46B637332B1EE83DA9B50B09B0E87D633D796CEFDF49B3B9
            B9A0491ABDDFA6F9FFDA74BD36DE42EFB7E8D4C97C3EFF21B9DD17206FD95314
            251A02C3CCB1D22C33DEE2E17B7DFEADCDCFE47D3D7E43D891767ED5CEBF0968
            EB7D3D38B24533F940F0F51075315562647B33B3E2566EC93C784C6F8CC5DE4C
            D3BD3049B579B3D5CA3925A6BB046B3BD624E98680B3B63704CDF57E5BDEC5E1
            C773FCBE9E4CDDB964D6425194C11218668E95669BF1CEFAF249FBFB9CDDF5D9
            E75737D1FC1D6DE65787EC00DD305E9F6D2C37F93DDEC789BB69363DE0035F93
            3D65F819D9DECCAC385DF666169D553919521BE5BEF00A9A164A75626E325D8F
            76C43F70C59B66FA964D731E27FCE55682EFDD5BEA3D9AFBD2C91933BF0026BC
            B01ABC9C0FC05F644F519468080C33C74A633663753155A2586FF2436597DAEC
            B9452387EECD65B25C44DECFCAFD5BD2DACC49BE536525B460FE85803C646F98
            A9462D14A56204869963A5319BB1BA982A51466FB242E34F43F1130BB33772DD
            E2159CE86974EECFCA9DF1EEE64A0307B8F483F524DB72A8C665ACC6A8281112
            18668E95C66CC6EA62AA4419BD99ABF7DB9FD1AFC9F160FECFCA9D6FC1DFED6B
            6BAAF759A8312A4A8404869963A5319BB1BA982A51466FE6EAFD2D7A5C6D5F2B
            310FC891F4CFCC3CBD97DCEC5B72823957012017D91B66AA510B45A9188161E6
            5869CC66AC2EA64A94D19BADF59E91D74BE98F05F45EC7F73ED5A885A2548CC0
            3073AC34663356175325CAE8CDD67AEF6AB9333FCF9FAD9C27AFEC79DFD2F9FC
            D6A8312A4A8404869963A5319BB1BA982A51466F76A0F726C4438B9F953BDFD2
            F7F5F25063549408090C33C74ABB3463F68982F30BA8CF76E83750E03A09FB1B
            A7AE800C64AF64D8D1DBD11ECDF48A7FCF0E046CD72D691699D46B0F7F3901FF
            4FEEAFC29A9CCBC1F961B4F345C93199AC36ABB3397AB6B9344B39F300D72B83
            ED9436A2A096089C43F6BA873BCEFCE29C6BD54CEFBDD6838648FFACDC5C0644
            B27284DF61C5851FF290BD12F0CAECDB57FEE55404C854F6940EF0FB0B2E515C
            4D1C3A0EC38D8A57C17D5E8DD40257725EF470EF2A15E3A563FE5A26AD6DDCCB
            C4B9669A9B80FF173F43F99BF310AD59FEA5CAC48803ED277B448E9506A9DB85
            3B12AF03E8B9067A19BE8259666A4F2E42BF6EBE355FDF6D827276439765CBC7
            1A611030B4692060E7C23562932C718A32437FCF5E35C8F993BBFE60F373599C
            C6DC597FF544FD3177E61931B3D349E9E4082FBD4290AD2665E03CF11EE55A3B
            51504B04CA227B2346A91577EE6CDC3989762EA7628C6CF715C3E92F41562F3D
            D478FF633452BE474F27B33ECACAA75963910D996D1EAD9B071E781390F24279
            3F494D32F1DD78723CC43985EBCD90B45F6A9A7FA93231E2407BCB1E9163A541
            EA76F12E085E0D142EB82B1459876E3F09BE02BCDF4075429765CB876C292360
            28ED248103B85E347BCCF56D1E99D4318310EF4F7C478FA7F859D37309720ADB
            98064A39F9FB8D6F256BABD12938B2301F21D780A5953E72CA605E5BFBE1E976
            A2A09648CF7A33764AADB8270CC93B072D2EDD9218D9EE2B465AC8E118AB1DC5
            35907BB2667ADF3C7A387B24B4EE743C33E385727F929A640258376E260FE4B8
            87778AC49B41F932FC5293FC4B9689112730CC1C2BEDD28CFD0B823E8110D242
            9EB6B301FB6368F9DC193D7331ACF7A980A15C297B73EA1892A96FD3C8A4FC77
            C1BF72E94FD608D98CCD52A999E7123865CA65938D810D7F8C4622F7FE728A6F
            7D83E2A7ADC09D02EE7CE35BC74D1FD932EC5C6EC04D3E9C97C212DAA10360EE
            035CC7542AD030B23762945A715F18F8B283AB887F53D0EA722ACAC8765F31B8
            BF04E318CC22C7C903B874323ED23C7A38773D5837BFA7425ED777359CA4A58D
            DB4C924F949E8F0B9E0BF24FC18524879FE5979AE45FB24C8C38D072B247E458
            6990BA5DFAD2915D962D1FBA4CC1AA8280A15CA9567ADF343229FD3DDBBDFA7F
            3216D2ADDED3BD30DD1AF3CD35E5604EB18C7721B5D985C60CFA8864F575293E
            335E3FB1B0CA2FA11BB34454EF7B45A915E7AB42F57E58F0FB4B30AFFE240698
            4E668E348B1EEE9B34BF9B62FC80747ABE8D7326A11B770233D27117FF145C48
            74F8997EA949FEAAF765022D277B448E9506A9DBC5EB483B51B396CC0811A683
            ED05D7195D962D1FBA4CF12E9AE6CC6DC0506F7ACA24E3EBD2D637796C0FC793
            C8A4F4F76CF7EAFDC99EE2239C5BC83E97E04CAF25F04117FC8A39C5A5E4B1BD
            D500EAA374F19CA960822B980846F940A1646FC428B5E24606C865279DD8E2D2
            2D8991EDBE6278FDC5F01CDB78FDB1C7C0ED4897A593D9234DA287B3C1FA1A19
            9879BE8D7B99380E272B73C63B4572D5DDCAF44B4DF22F5926461C686BD92372
            AC3448DD2E49477A2F62984BF9E40ABE94412F6224EF97764C9765CB876C8927
            D7F89205B02E4D03013BF5356FCDA0D92456EA99818FF327F70D97E6E732C8DC
            7BF256CB638DCB6F6169C57EF801BFEF05E476848C2729B35B06437B51504B04
            8A257B2346A9157784C17B5F2FFF722AC8C8765F31D242CE837B90C3EBD465AC
            73E964F64893E8E18E755B4233CFB5F1249362EFEBB1174DF925C705F5502646
            9CC03073ACB44B33E68E1476D34F99B8B7B6D6974F61BF123C754CC7BB017290
            BD92215B928769E6591A5FAC4D0201BB86915CCD8E957AEDE12BABF7A7E4575F
            CDCF950046F2FC2CBEBC0AE04F5F2E8359C9A909567777962F0982EEDD5CD3AE
            572AA09D28A825022791BD11A3D48AF32527B857531B9753212053D9533AC0EB
            2FF015DF5E3A8D52C763EEE4C732E9DFE3C16D011CA13B0063E6CE93BB167A6F
            C1EFE6D8B8F705C78DFB19B967F1FE62AE3F9A48C8F04BFED2D4BD928911071A
            50F6881C2B0D524745CC65533AA594DE1CC60509202FD91B66AA510B45A91881
            61E65869CC66AC2EA64A94D09BCECF768768410238A7EC0D33D5A885A2548CC0
            3073AC346633561753250AF7266B76F0022340EF0145BC2041352E6335464589
            90C03073AC346633561753250AF7263F0A1DBE0509AA7119AB312A4A84048699
            63A5319BB1BA982A51B837B3F59E26F369D0CF2372EFB5A62816248053C8DE30
            538D5A284AC5080C33C74A633663753155A2706F0EEB82047072D91B66AA510B
            45A9188161E65869CC66AC2EA64A14EFCD215D90A01A97B11AA3A24448609839
            56DAC48C9DDF473AC10AD961DAB7A292D155B3A08DDECF4F6D3CC49D368321C2
            1F654F197ECAE8CDA15C90003293BD36E8ED0F0E0BC4CC852FC89EA228D11018
            668E956699B11B5B736B7DE9D9FA211E3FD9B953EB77AC9CDB2366F93971A69C
            E070637D8BEF03D01939BFAA6A1D0C1172913D65F819D9DEECA0E2BDFDC1E176
            9198B990B1EC298A120D8161E6586996199366CBC2CE0EF83ED4C4E4B74E7FCB
            BC1565E4BC79D0C644EFB74D5084D33FC4481EC95358F66599BF7B5217532546
            B637DBAE788F7F70B8FE3EEE2476CDB7EFA9DF3B34418D5151222430CC1C2BCD
            30631E3BA414D8BC08CDD10ED8CBB09C370FDA98E8FD2DB3587407C191D4C554
            8991EDCDB62BCEC6D2AB1F1C168CA1A7C6A828111218668E95669871B6DED368
            80060724FCEC778C9C370BDA2809185ED39B578A56BD1F3946B637DBAE78B6DE
            9BFBECA23F389443AAF78A522102C3CCB1D20C3366B712CCE7F34117741C76F8
            DE24686332BEB7F70E3C8B984C5A921792514B0064277BCAF033B2BDD976C543
            D320F8A00BDE2B1BBDEFE0078729BB66DB74EEBC5B0267903D4551A22130CC1C
            2BCD32630E19E7BCD773A871190719D67DD8779E6D00F826411B33F4DE867FCE
            0F86A82EA64A8C6C6FB65FF1DEFEE0B058CC5C3546458990C03073ACB489195F
            5F5D3881AFEF02F8639EF7579267F680F53BFC309EE4DCFC14CA996CCCD6FBF6
            8321C25F654F197E46B6373BA9786F7F705824662E7C41F614458986C03073AC
            3466335617532546B637AB51713546458990C03073AC3466335617532546B637
            AB51713546458990C03073AC3466335617532546B637AB51713546458990C030
            73AC14522B8AA2288A328C889613F97A2F7BF11173D9944E19D9DEAC46C5D518
            15254202C3CCB1D298CD585D4C9518D9DEAC46C5D51815254202C3CCB1D298CD
            585D4C9518D9DEAC46C5D51815254202C3CCB1D298CD585D4C9588BE3771399A
            89B6D79F699F6A5CC66A8C8A12218161E65869CC66AC2EA64A44DE9BB8B6DD64
            BBC1613BA21A97B11AA3A24448609839561AB319AB8BA91223DB9BD5A8B81AA3
            A24448609839565A9E19F312BCED86D36E8754D9D61AF503983FAF1BCAE072BF
            EBCEA00C57F07563FBEDAC2F9D9C99E4B4E3F56797D669A17E0CCA6757F96D12
            EF5F2915687FD9B3D0EAB0E3338BB29C32766B72FDB89D6C3AD4EF294E51E341
            39ADDC5C872E7533B11703AFEBBCFB50E392E9635E8696527284464672904FE6
            8231179EB314B4F993BB38F4EEFA8957DD6B91813FC85E74C8F2BDA679AFAF36
            8ED26ABBE3B59946B0D46EC4B55094F8F0BD19F9903DB4BE75CACA36571AA250
            93338D95CD0C330CECD403D2C91E9163A541EA6EB9B33A7FA87EFCC93EEA3D9F
            686B7DE9D9FA381CFC5892047ABF73A971680F05FEC119DBC5A393120FD4D57B
            509D89A9FAF4A41F974C2999546F62148689E9FAF484ABDFC9F5839F820B3CE8
            2911665E5EBE1DBD97F80E082F449FE8BD13E2C1E640170F652E171EC5B3993C
            BA7879072EBCC527E1D0567204EE2C178ED62692B5EE0DA98AC7C2CEEAFC81FA
            93C78D1FA1DA91296D2ECDD6F605E6106D2D1425467C6F66F53E656597318A15
            0E5AB637974FD4C68F2E5CF8766086819D0604869963A5659A7158C3A2A4CA96
            D67B00076A4E43787A8FB1C39D813B851227CF9EB878529D998535FCD70C3495
            1E90EA4DE8B803338B17E85FABDFC9F5839FBC0B3CD55394FEF8FC2C75F1F55C
            BD9F38FEAD6F4C4E53CC27B83D9DAE3D7D7C865336D37B8C50E7EAFD550C4D4B
            D1680C18AC36999FE0D8B55E02246EA5B44D4441B0E47EC8332226EE5A284A64
            F8DECCE8FDCF5256F667CFCFEC9341027EE5EF3D36032388B419669824131866
            8E959669C6610D8B922A5BA6DE6FAF370E3B4ED66B174CE83692F5EC898B07D5
            398C1A8063C7ECB0BC4A2984BD090D7E002E6B52717E2BDEBF7EF0137C07B181
            E0FC9E92F4EF2FCEECABCD2E2CE6EAFDEC2B17589E3112FCF4FC855724255E0C
            CE899213734868C8872FBC2B29930B8C30B81405C848F662C456C12D7C502F24
            EE5A284A64F8DECCE8FDFB292B3B7D5AE6F9F92B7BEAF57F9465861926C90486
            9963A5659A7158C3A2A4CA96A9F785C6F712715C70028F2A6503ED2B7B08C762
            B7D870AEC9F5839F9C7ECDE829939E7A79AA3EBDDBE8FD1E33176D2F06D9D9C2
            94338D85D91ADC41630C793A5DF6F8FE3A4FAFD1C5C3171E8EEF9DD13CA0E37B
            4551B2F0BD99D17B1DDF372755B6B4DEE73EBF8791DC848CD2E8B588711A4A9A
            FB805B8EBF76FD9D523E5E6F62BFD827C470C74657BC7FFDE0A7A4235D65353D
            6505FBB38F97670F40FEA4B578FF27BD8C0FD4F92CF6AAC0BF8E8DD10D813D5D
            B6DE43B6A660E6C2A3FB45F3FC7EE9D9C327E806428EEC6CAE36666A7B9C5702
            85324DAC7C127BA1DAA12939ED9610772D1425327C6F663D5ECACAD6709080CF
            EFEFAC2F3E89CFEF97BE99658671E93D4D065A52439CEE809C644F70F59ECF94
            FD7EBEFC09DFC6BACE6F36D2C7F1DACCA9E5F58B8D3A7C99A66AB75DD5E177B8
            68A0A9F400E800D9636949E65D5CFDA68E022666CF9D73F4DEBB3F303D6527E4
            E1EF34FAE71B829DF5574F488FDB17E6ADB5D0B9F8D49EDE1B20D11D6BA8F616
            D05C78727F8909C7EB271656E16CFCB314FAEED8E4CCC925F75A64E00FB2171B
            6EC5F18EE7DACA3CCFA164FCD0008ECA9EA228B9B822C5D49E5CC45FF45C0FAD
            0CDF13227F053E05FD472A4168A79EE8C321D92372AC34481D1531974DE99491
            EDCD6A545C8D5151222430CC1C2B8DD98CD5C5548991EDCD6A545C8D51512224
            30CC1C2B8DD98CD5C5548991EDCD6A545C8D5151222430CC1C2B85D48AA2288A
            A20C23A2E544BEDECB5E7CC45C36A55346B637AB51713546458990C03073AC34
            66335617532546B637AB51713546458990C03073AC346633561753257ADA9BF8
            7BBC589747ACC665ACC6A828111218668E95C66CC6EA62AA440F7B1303DB4C3B
            6B2EC545352E633546458990C03073AC3466335617532546B637AB5171354645
            8990C03073ACB42433E6C5447151A0F1FAC9153F7276D78465F3562CB2CB0CD1
            0AA976B1364E13C444A774809301AFB547D3BF3BEBCB2767644D3E59E1C8C20B
            AB61A014FEBB509F6F244730C80AE7CCCBB812B4341B2DD7965E017134819692
            3D849741C46523E103B51E7628EED826C30FB8CE5DCBB6850EB2D784C9413EF2
            EA54B8F2A3649974B459B8AA55D79706E42D7BD1918EABBD835103A0C4431605
            405102DC855601700E5B56A4C66A471BABD7C1FC97646D4CBBA064601181AE6D
            6FAE9C94C534C70FCDAF98B81918B8168E9224390E48BCBF7396438D4BEE22A2
            AC1DA9F8F7EE229ECF2E814885093CE0A8EC1139561AA4EE96B5C6A12F63FDB3
            2267774D58362300F291C168697931D12921807F74FB80562DA6F0C3BCD22106
            35AF71EC16C12EA40AD83559837DC4F4B2FD2EAFD3AE7A9FE0F7A6B1460A5840
            AD97A3F74DDA163AC84497226C0EB4C22E7C65D3E83D45E8E18EDEB9BC78F4D0
            ECF2B5965D5F1A5054D98B8C9D745C6DB4DFC97ADDB31A26DA5A284A4BE81656
            56C5DE5D9B5DDA240702D73C45CFC2977E8CAFB893B28866BA2639509A8F9767
            A76AF5E95AA2F7AE48396E2700F39C66074503D46D1CC660B156E627290C073E
            A6DC3339FFE335CC2109906FC3BF318161E65869C9661CAC735E8CB06C615302
            38D4CB8F89CE691D3140700D76E8FDF35E81B1FCBB1DFDE844EF279E98FFC634
            473AC2F5E16B476767F6B969461CBF37A90131203D363EB65E6BBD6FDAB6CDF4
            7E87EEC41DBD0F7B3675ADA6139444DC4AE95EC9E4B9665F5D1DBEA8BE8AD20C
            D0E6498A624531B76098BEFEE3F93ABEEE83BE42E4D37523A16F47425FC14A0C
            EE886E26408C57FF54626E19AF252931E7DDECB87C48B992E06D87E657D656E6
            0F4FC2ED08E6C0113E3944F5EFCF7B01F402050C0D33C74A4B356353F93ECCE7
            8B3F82BE6C23263A7D1BC03F263D497D7CFA74AA7B5CFD808F4DF55E4AE208D5
            D2051B760FC46909EEDFC2EB66848196923D841B73E91ADCD2D64E9C5B3C9EA7
            F7CDDA163AC85C13D4D198583E73D83A339F6F72A3AC89F048D0F5A5014591BD
            18B157B535DE2DF232AAF74A15203535636294EDF1317C98DB5805914AE6C901
            9A5A47D27AEFE89AE46082DFE0187D0A1F4ADA189B8903A2B37CBC04CEAB56C3
            F948E391384BF70682E26803FC94E1B3EBAB8DA3C9A388FA53BF6BFD52DA89A5
            0C33C74A83D405A011D564D6C445B784654BD5B6DD98E8929C32B03D59FEF89E
            A762F6CD34BE4B13355753D7CD48033D247B8869406CF03DD3F5A971ABF7D638
            4D57B66CDB50A44D1763845C0A9767F4DE3330223812767D69F8158F0D7B25FB
            212E015FF2E180EC29CAD00003423338C641798D06FAD639183C5710F8F64C5D
            A3107693F3AB97DDC87500493E41DAB46766E125E35568629F1E5FC21F71EA5E
            F6F1380DF4E9AEC27A3F848380FFAF7F1ADFF81E5F313874885E2E288FB06C61
            6DDB8F892E183180E4F6F93D86C0B7910AF1C68A9EE8C8173AD5FB6D79958C4A
            15A61971FCDEB48D435739F613990ADE84E15B2D18609EA241C3D5DFB26D9BE9
            3DDFCFB9CFEFE9265A9EDF43EFCF9C58BEDAB2EB4BC3AF786CA4AF529E45D4F1
            BD32F478CB72A06B10DF22D27BFDD22AD93E8A7722B4AE4534D335CAC1351B3B
            BE37987702D668A6796993F588353EB9F300F074FC32B2F9CA873F5DFD109F14
            E013C93DE900F9CE0D011218668E959664C6E076ED547B3832E81AC849F618EC
            303E01901A9AB37F6F12139D713270DECFDF5C5D983511CCC368FAADF49EBF01
            C0418C99CE7FC362F0D397B4271D69A0A1640F711A07AFFEDDE61716C9BBA9F6
            85795FC283B6752F3C673200F3E55BFBB72E8BDEC3899CD771679FA709BD165D
            5F1A90B7ECC546765C6DD57BA51A04E378679E9C7D0BFA13FA2813E9698B78DF
            D7B53F5A0299E7FDE0E73C46EF59740879977E677D0146127840CE128CE3939F
            00989F09E0CB80F4D1BC8D1F06C8F780C3B247E45869903A2A622E9BD22923DB
            9BD5A8B81AA3A24448609839561AB319AB8BA91223DB9BD5A8B81AA3A2444860
            9839561AB319AB8BA91223DB9BD5A8B81AA3A24448609839560AA91545511445
            194644CB897CBD97BDF888B96C4AA78C6C6F56A3E26A8C8A12218161E65869CC
            66AC2EA64A8C6C6F56A3E26A8C8A12218161E65869CC66DC7ED9BCDF592A5112
            BD60D8852FE47359544329AB510B45A9188161E65869CC66DC6ED9F007DCF186
            3F5798C805036F19274B5B0ADAA51A4A598D5A284AC5080C33C74A6336637531
            5562647BB31A155763549408090C33C74A4B32635A9210F2C225807A16FF1E06
            61EB4B2739C2815969283942C71670012377F1BBC99993BC2291B3529EB3AA9A
            04180EF3F11650CC5E954FA3E67708D459F62CB4BE55B200163647B25EB2D3EC
            B64168E529BB3415A790F84CD4E9F5C6BA97895D868F2F095E4D93E145AC28A5
            BBA896E4209FCC95602F9EADF5E553261E36FF2939E244D1F6803FC85E6CD878
            2112CCDB2E4066028A38C45B0B45192C8916B007682D40692BBBBEBA80ABBB5B
            D7270A656520B4530F382C7B448E9506A98B821EDC297731C2B25114C2DAD105
            683E5CA4F0C089E52D3AC2AD8641CD27698162EBE521D9AB27EA7B68F962D3DC
            9C89C836363D1CDD767276F291D3A2FF37D969D4FCAE495D69787333315D9F9E
            70F5DBD7FBA021E0EA9A98AA4F4FCA22CAD27CE3144C826C2C47EFC1FA4CB7CA
            529A56EF9DB5AF6D0E745550E6D2A1B4582607B9C24E87435BC911BA266B1312
            D9C22155F148D85E6F3C569F7F8B57F686BBAE8FB02E50A78F53D1BE91586BA1
            288385D6D297C01CA01D8778A4C7AE2B2D40E4435C2B5B5B9D3F543FFE64A2F7
            3B2BF3070E1D3F6EF53EB4D340F003C3CCB1D272CD982AE32A5F2182B261C83B
            3F2601796AE774E8C4E1A31B988E46CCF8C134B71B1ED1101C0C4EE4090FDFD0
            68D4FCCE495D697073736066F102FD6BF5BB85DED3FDC1CCC21AFE4B173DA53F
            3E3F4B7D771D15BDA5DE53B8FD69BA5AEEACCE4FD79E3E3EC3299BE93D2E5BED
            EA3DC5D7F11696772336C9473F0112BD52722DB0614DCCAEF04205A2AF85A20C
            828CB89AAEF90402741D3FA6ADCC777D40CAFB0181B71102C3CCB1D2B2CC9834
            12189751721904654B374178445A2DB9BD42C49BBFCF1A6CBF823B58603FDA0D
            E30B807F16E8368D9ADF0D5067D963E0CEE9005CF7A4E2FC4443BACFD17B6E2A
            094D0DF7078751AD71944FBFC590F4EF5304AA85C55CBD9F7DE5021B0C9AE874
            125A09BBDB395172627B317387FAD715E2762E309C91662486F755A7F041BD90
            D86BA12803C1F75A846F3E9E007D9C6D65A94CF040608136D6BE4F609839565A
            B2192743A21208CA9631340F4666F8B1A3F1BDB4F8969F737FC7F7A31235DFEF
            4D9A048343024DD2F8177D70C5D3D491A496397C939EFA74AA3EBDDBE83DC7D0
            036C83BB1D3DD35898ADC12DB60D9D1C5C4592ED75278C1577288EEFFDFBEBE1
            1FDFA3C13E48CF23C852747CAF281D81CE3F78F8E59A4F49E3FBC44E4302C3CC
            B1D292CD181F79EE0E3C45D78465C3969D30CFEF5F3D71F859524A39C2CFDDE9
            DDB7A41D9B3FBFE717254C4A27677E39C27987CE69FAE4F9BD46CDEF18AF373D
            238181FB3E57BFE96070C5BBCA6A94C90A36C79606506BF11D0889278D0FD4F9
            2CB655F90D09BA21B0A7CBD67BC8D614CC7428DD089AE7F74BCF1E3E41371072
            84E35AEE715E09144A36B1F240EB38F465FBAA29D50EAAF9B1D36E09D1D64251
            060ADDE5CBF37B10889913AD9FDF675A99EFFA00D7FB05761A1018668E959663
            C624F3901510BCDC5E8474D9A8F92412F0ECC22A344F722479791E9D3B1D0132
            DECFDF595F6E8451CFC1593F3F1BE62360D3D31FBC3F69D4FC0E812ACB1E7401
            8EB3ED848AABDFDC36D83AE7CE397A1FDC4463733D984CC8C3DF69F4CF3704CE
            25615F98B7AD4AE7E2537B7A6F905EE16C4DC1766C8726E1F9CD8F41F8DD5AFA
            6E72B179C01F642F2EE8E94302DCF15C33BFB2C9F8A1011C953D45515C781CC8
            8633FBFCEA26BD4B2464BC9FEF5B996F8638628194891FAC37DE4FD9A9270E70
            48F6881C2B0D524745CC65533A65647BB31A155763549408090C33C74A633663
            75315562647BB31A155763549408090C33C74A63366375315562647BB31A1557
            63549408090C33C74A21B5A2288AA228C388683991AFF7B2171F31974DE99491
            EDCD6A545C8D5151222430CC1C2B8DD98CD5C5548991EDCD6A545C8D51512224
            30CC1C2B8DD98CA3281BFFD4B0F6E4E2F21FD5534BA928ED13BD6068FCFB5654
            A3168A523102C3CCB1D298CD388AB2AD37EA93CF2E2E3C59F3A2AB291D13B960
            E02FF835FE7D73AA510B45A9188161E65869CC66AC2EA64A8C6C6F56A3E26A8C
            8A12218161E6586999668C0BFA8FA71700EA9AB06CCE4277C99276EE413CF52D
            B302DA6E8A21888B1F350D4E2C71EB7185235EC92D89826FD6EF8363B4D8AD5D
            92DDCDD0E660C82C61EB10E9EB8D3AAF25477F361C3EDD783A3922CBC2C3E99C
            557B718D395A0F6E4896E2837AC89E85AA90AC3F6F17BCB39FB8FA492D69355C
            BB301FA7D0F8F7ED62036F8B69A45A989704A6BAD48E3670F5C00438267B8A92
            B611F762423FFCB1B3C61C58192E312B9F525ED75BA452FEEA78698A62E564EF
            5A59AE43986F24F910DE110EC4C5D8A533D93AC202509AF4E9127F6571168125
            776DA3D78F4DCE3456369B5A592B1F85A76AE2EA211BD92372AC34485D00E8E0
            A95A7DBAD65BBDE7F6E5BE0117FC71D8E876E1550C30F018C87FF3E0C414B205
            574B35579EB3B4BEC4D7C77A40A34F4ED7A72406AB1BED188A1144BECF2A212D
            F5DA3C443AE93D77A4DBA96107E367680F282F7F97EF4212258C9FD4958655D0
            F8F7FD63BD71A87E726573DBC6010A5B98AF7F5CEB3B23D2762CB55062206D23
            9EDD01D6F4828F29AF2B1ED5AE6BDE9841C71B7C3DF1066483C6E5B6E310F00F
            6E6E61CE42281C78BF1226CB389D5B65828D280912CBB5835B1063771FBDDFC4
            CAA8C040968FB2D54F1318668E9506A9BB0546CD276A50ABD53FF55C6731C2B2
            79ED8BF73ED80261A3C3F17D261C0EF762B3E0C4B48EB17BE5A1DF77C49BC13E
            3EBAB8B680FF822C050BB907F96794D0C460A5431921D43AD07B8AF5CE57039E
            77EAE9D95F6D76114448EA4A83F6D1F8F703C0062F085B18FD8B5CFFA9C68FAE
            16CA2049DB8867774020ABCDBD6EE05185E0EBF682DCD95C395997ABB43D8780
            DF76730B7336F8C291912CFB744E95895044305B190370FA857FD7C4CAE88C4D
            7C949FD22330CC1C2B2DC78C6D68DEC07516232C9BD7BE78B918FF0E0909EE5D
            896443810A92106A166C56492FC374B9F2C228F808F4F11307B0B7A0DB2671A6
            C52B03004AE044BECF28214E1F39B99A62CBC7967A2FA5B441D9E1A670896D03
            5DF6E4FC85A5A6174184404D648F0175D1F8F70380E6E17078E1B630CD343AC6
            8B7FF2AB0A89644F51D236E25C4C64028E9BC58B0A87CBF2C9F7BAC980CDE680
            4783AF532AF928D369ED3A044CE9DA6998331E635CE1701FFB4AB266A7B35A80
            E0B1F17DB57D3C5D0F35BD980804A76FCC37B1322E64B68FF2537AC079648FC8
            B1D2207597241E93F1DBB15B2023D963BCF685D6CF1CDF0B126D70E1A5D4CDA3
            E97BBC47E13FC99547B14DFD92E3E40C475A23E0B674DBBF1BEDEFF8DE84603F
            BD303B05F78C7833E3A6891B683FD943689A8B5B15A11B5EBF2B8316E0087806
            9AB233E969C0AAF1EFDB014657872793C94686FA026ABAB6A0E37BA52DD23662
            8C511224A6E77F4C79DD607C6F2EBCE0EBF6783207DEAE43C06FBBB985390798
            30B5EF07C95A9C4E5210786A7626F2A4E3A5858EC6F74D7C949FD2034A237B44
            8E9506A98B12B8CE6284654BDAB7F9F37B7C4849EF8FC885B5862E589EDF07C1
            897164999A5972E2EB1F7A7A61E99B49D85699EDFC38C9301DF93EAB84740534
            0F91DE99DE6F5231E07ACB9A8F8D1BAF373D23871B238D7FDF7BF0FAFFF2A18C
            370ACD2355BC97859A2F6DE29B2EE073DC3B9B686AA1C440DA467CE34DC9AAFD
            98F2BAF2845BDE5C33561FAAB239EEF9E1F61C02E0E616E62C84C211E87D6BFF
            E380C52361C27C2626E75F5F41BD38B1BC79075FF602BFFDD1852656660B96E1
            A392EAA7080C33C74A4B36E39EEB3D762292FD7E3E34CDE5E42564766D59C189
            A5E9E4D2D934571EC9BC844E9F9C69BCBEEC8DDECC95DD22F27D66095B87486F
            A1F7FC0D000E2641D9F16AE052B9E9E307EA217BD0CE780F6B6EA43CFBE10A63
            9535FE7DC9B8D5C4271717932916F1B6FC70140F985F1F24C041D953146B3B99
            C66B5EC8779C93A3B229AF0B16BBDCB02E353D9D6E8C5252931FFEE69F7CB36D
            8790D67BC997723625747EBD824EC34F868FD5334F27099C8CF8256E605CDE06
            C0571CF8757DFEE941332BB385CCF051AE1C386546E088EC1139561AA48E8A01
            95CDE8BA7C54CA21E62BADA754A3E223DB7D8A12338161E65869CC663C88B2D1
            23585D4AAF078CAC6054A3E223DB7D8A12338161E65869CC66AC2EA64A8C6C6F
            56A3E26A8C8A12218161E65829A456144551146518112D27F2F55EF6E223E6B2
            299D32B2BD598D8AAB312A4A8404869963A5319BB1BA982A31B2BD598D8AAB31
            2A4A8404869963A5319B711465E325776A03897F8FBF4CED4544F68110BD60F4
            AAB5ABA194D5A885A2548CC03073AC3466338EA26CEB038B7F8F3F21ED4D44F6
            8110B960F4AEB5ABA194D5A885A2548CC03073AC3466335617532546B637AB51
            713546458990C03073ACB4243376572392158E8A0379C91EE32E3294BDBEDEE1
            78E2DFF3DA49CE01B3D69B59508FFFC42BBF127C22BB7C12ADAA982C42D7AAD8
            19858C0F28B8EC5970992A8D7FDF47786948D39A6D47E646E098EC29CA10E298
            757A05BD205016791C5CD24F3EA5FC0058CAF3B3FE229EEEB79BB8112074D494
            6A9CE357D1878907EB0F26F920871B6BE79CACC3E56BE190EC1139561AA4EE16
            EB58CB242C1B3607BBF2E6EBE7DB8557071BFF9E9EFACB354327A3F51D29A5AF
            F7122A06610532DA065AE8C65A4E5A38556CFC6B50C818495D6978E96BFCFBFE
            01A671E0D0F1E356EFF94A6E273237124B2D14A52BAC3F31AEF8AA710E06CF75
            E4FB01593C1B6F9A4156524BDC677C1D081D35A642C7442A405970F4352F379B
            55168161E658694966DC67BD07501DF18C615BC0F108E2DF9BB0D0B8AA3466ED
            846D76F57EE289F96F4CF3A5804BCAD78ECECEECA33F9216BAB1965B141BFE18
            14324A52571AF494C6BFEF374EABA2A5881BE22A378DDC8544550B45E9147349
            5B57DCB6DE67F981E06E18084D26E3EB198E9ABE052A4019D287A1D17BC80A49
            CD04760D64267B8C576D54BB60DA445CED80E3DF73D6122CC1299D8C027DBD9F
            5DBAC091636E81024DCE2F614C25FC239CCE8FB5DCBCD87473E017920B131950
            70D963A06A1AFFBEEF60E5A4C4CEA5CB8DD634323712552D14A55312B31657EC
            7854BEEC9D14BEB234F30336077423CEB79BB9910C478DA920AF6B8B1855EFDC
            F3F0814D528EB3013A59E7BA971C2B0D521785E6B1D3F73EDD11960DAB6D5D39
            3459E4F1EF11D36DCE04A9AFF7CB5B9461E3BBB335187ACA2D27CD12CB39DDF9
            6AFC5E4600E95421F1DA8A0E289AEC213499CC0546EC7456D27AA6E9F813CFC2
            496A6913939EA2ED69FCFBB6705A152C48C7F7CAA8602E69EB8AAD733088E11B
            EF2D1FF3FC80F9566832E9AF67396AF32DF224D3F5E9F1E118DF1BBC67154509
            CB96543BFEF8F742D26DF2F5603E1FCF8AC500054B2E41330CC50C6C21EDD519
            169B342C28A4FF48220EBCDEF41E8B18E1F15B2F693AC45556D302C9E48DC6BF
            6F17A755E9EEA4ADC8DC4854B550944E49AE7C71926DCFE7A7FD003FBFC7575C
            93648E6511A9AF6F6739EAE45B2858A00343A1F7C99D8B09FA5B0661D9B0DA74
            1220DEF8F75EC738DD66BE1EEA3D178387A4244B99B196DDABD32BB67B7300D8
            4B333AA0B5640FDAD9BDF43DFDE666C5B71635FE7DD9402D92F645B7824F16A9
            A1722273237050F614650849B9E2F320B078AD13F897C07B271FB3FC0046ECB7
            92776AD9FB2956A61BF9FDC637331CB579C10B8EF094A7CC4D3AA5E50F92313F
            3BA0A3021C923D22C74A83D45131A0B2C52B99434DCC575A4FA946C547B6FB14
            256602C3CCB1D298CD781065A3494E8D7FDF03465630AA51F191ED3E458999C0
            3073AC3466335617532546B637AB51713546458990C03073AC14522B8AA2288A
            328C889613F97A2F7BF11173D9944E19D9DEAC46C5D51815254202C3CCB1D298
            CD585D4C9518D9DEAC46C5D51815254202C3CCB1D298CD388AB2F14F0D6B0389
            7FDF3658C85AE4EF18462F18F87B188D7FDF8C6AD44269879DEDED4F6FDF867F
            E5B312318161E65869CC661C45D9D60716FFBE6D40A87E7592232C454CE48281
            BFE0D7F8F7CDA9462D94D6FCEDCECE2757AFDEB87891B79FDFB8217F50622530
            CC1C2B8DD98CD5C5548991EDCD6A545C8DB1F280D8DF5C5BB362AF923F140486
            9963A5A599B1B38C5D59E3E0B06CEE324371C6BFB78D307E687EE57AAA6CDB99
            85F19651C20F5C425A2D58EA87DF753293159DE84BBCD85C1245DE4966569733
            2BFA217EE27E0205923D4B50182C7AB27A9453111323189742D2F8F705D0F8F7
            4A1332C59EB79190FCC0758BC760648DDB2CFF13AE76870452D8AE95B5F25178
            2A6BB63E908DEC1139561AA4EE165A0B5056952F8DB06C49FB461AFFDE2C13BB
            8DEB921E0AB40770BE1B1606319D6A2E352C1B8B9AD17B4ECAD793E81CDE8EB8
            51E46D325A6296CA96E87D98B89FA4AEB45461FCE64AEA6B81FB038D7FDF3560
            1A1AFF5E69C2ED2B57029977B7CA4B7EE8BA13D7E190E17F5CF7CEB802613FB6
            6365AD7C5486333404869963A525993138C4DDA5AF411B96CD6B5FBCF7C11608
            1B1D8E0F2EFE3DF69089A30004656B5518C4742A1D34ABE8E3C140EF013C11E7
            0CF5F5A2C89B641911F7D389FB49EA4A4B15C66F2EAFBE08DD1F68FCFB6238AD
            8A962236CB55D6F878A30AC87920F0E9ADE2921FB86EDF3313D9FEC7FA2B4320
            85ED5B592B1F95B6474B609839565A8E1953716AB53D901BDC9FF070A73861D9
            BCF645910E665FC5D50E30FE3DCED53C8F7114F8714350B6F0BB807755E1DFF1
            031F5CBAB678146E0CCF2D1ECFD07B7B5EB84CFD28F2CE394D4758BD4F25EE27
            5020D963D285F1DBC7A908CFA7411768FCFBA260E5A4C4CEA5CB8DA6F1EF4795
            5B972F07EA9EB9555AF27DD7EDCA84184533FFE3FA73B11C470A5FFD76BB56D6
            CA47A5EDD102A7913D22C74A83D45D928C5C69FAC2CE4814232C9BD7BED0FAF1
            C5BF17689E1F069DD796BCB261E28CC2D801A2E95453424CBF67BA3E359ED67B
            B8E6707C7F0D5B5B0A07E06DA349968EB84F5D232981D44C468F8153CA1E9255
            18BF2BBDFA42E351043C03CDE19BF41AFFBE7D9C566D7FE48144550BA55CDAD4
            7BD8AA3EB16F5C37CD17BA16D0C2FF480A2694C227661FEB647CDFC447A5EDD1
            02A5913D22C74A83D4DD82BEC33E93489E4014232C5BD2BE71C6BF877C1EA337
            B676442A02BD673DF00A731DCBC0392441C7AD4A513E7879F97A6F9FDF5FBFE0
            DC4088FB4E022C4A81CD7CFE967BB7E1F8FA7EE1F5A677EB630AE377A57F89BB
            CA6A3A2E99BCD1F8F7EDE2B42A5F8D2734FEBDB2B5B111E87A8BAD8A929F72DD
            A1DEB7F63F2EE8341C29C430B8ED59592B1FE53B438FC03073ACB42C3326DF4A
            F73FA9377BBB262C1B561ACF80C419FFDEBE8AC9EFED8765DB4C150645C91CB1
            AF7CDB8E8702D10403DD733899C9FBF99951E42FC03D867CD91498F47E092EB3
            54E2526ECBDA04CA2D7B70FAAC926BFCFB1E03B548DA1787201AFF5E31DCF9F0
            C340D75B6C1594FCC07593C7C08F847D9B4A1227FE4712D85F1001A114B66B65
            AD7C94AB24CEA91038227B448E9506A9A3624065B3A33AA54C62BED27A4A352A
            3EB2DD373A8CBAE40F278161E65869CC663C88B2D12467BC4BE90D31232B18D5
            A8F8C876DF48A1923F7404869963A5319BB1BA982A31B2BD598D8AAB318E082A
            F9C345609839560AA91545511445194644CB897CBD97BDF888B96C4AA78C6C6F
            56A3E26A8C23858EF28785C03073AC3466335617532546B637AB517135C65143
            257F28080C33C74A63366375315562647BB31A1557631C4154F2E32730CC1C2B
            8DD98CD5C55489E87B13D7C3EAC532C3D5B88CD518471395FCC8090C33C74A63
            366375315522F2DEC4157B2639E460C954E33256631C5954F2632630CC1C2B8D
            D98CD5C5548991EDCD6A545C8D719451C98F96C03073ACB41C33F6168E3571EA
            0A0339C91E63174045ECEA83BCF021ADA52F0539DC58BF234BE4BA05F3D6BEA5
            350B798D62C45D3DD1AC8AEA552A585F5D8EDA3CBDB44EF5F9382FE74EF07969
            4DC430FF8F33CA60566ECF3C29418B2D276BD3C60B145CF62CB82CA52C828B60
            1D6DFF7A35364B48FA95E514B836357CA41E947839CD2E12771925CA2A897F6F
            901CE49359F0D2594F77F9D40C2D9669FE941C7196EFF5803FC85EE464B5B805
            8EC99E3292A8E4F70FD789B9568970B0D00438247B448E9506A90B03A23555D6
            62B461D95AB9720A5E27D16003BDE7AF3821761070F793D3F52989649CE4C6AB
            AFEFC17806DEE91CB2F2C46329170950790009886464C6EABD9B7F56193CBDCF
            AA0848E6C4547D7A3259DB3956A0D6B227E0ADCFC4747D7AC2D5EFA441329A34
            A8AC34EE385D6F7419E4E8BD5C2408DD6A387A9F152F078317B8F1EF3769957E
            132F67F14938B4951CE175B327D2177FAAE2B1E2B77FC0D0D442E9192AF97D22
            6D89CD6D3330CC1C2B2DD98CD123DB78714509CBD6DC95DB780698245BEF01D4
            5A51102CE7D1C5B505FC17C5C6E606D0101C3E2471537CB2F2CC8A9D8F60DA89
            27E6BF31CD328071626A476767F6615A2F1F20AB0CDB69BD076C4548326716D6
            F05F1BD7275252571AD4E2C0CCE205FAD7EA77D220D4746E93A62A4BE98FCFCF
            52E81D0C83D45AEFE92299A61BAF3BABF3D3B5A78FCF70CA667A8F812E5CBDC7
            78B8EEE40DE53364F1705BE1B77FC0D0D442E9252AF9FD206D89CD6D3330CC1C
            2B2DD58C03F75794B06C2D5CF9ECD23510C8DA89738BC79BEB3DC6BD25770CCA
            F1C401F4E320399334C7EB6A2D058C874CD6CE251329AE13CFCA730D8E49526F
            BE05D326B1E96E81CC4CCE2F2DF1B9F06FF21DCA3FAB0CEBEF67E9BDAD0894FF
            300A58A9B7593D026A297B0C94F9008CB649C5F979875747FAC48D234D9AAAAC
            A47F9F02502E2CE6EAFDEC2B17F8FAC4687BD34978BD643E9F4E949C789C8323
            9BF97C1B49D9E27759D22F1E9091EC458E5BF19906066F74189A5A283D4625BF
            E7784E8C481F3104869963A5659A3138620EB85E1261D9B0CEDE1377C79573F4
            FA3DD3F5A9F1DCF13D0799B5E01CAFEBB8CDD8BAB4F1BD893DDFF8EE6C0DC697
            57E55C61176695A1E5F89E2693A512665A3B5EA088B287E08FDF92B2F3F30EBF
            41A4E94C9372C45B0355D6A4A7E8BA53F5E9DD46EF9B5E2418AE7E7CA6B1305B
            93F0BB74BAECF1FD7513091B1A3519DFFBB7B3D51ADF1BA8A96D1B0A43570BA5
            77A8E4F716DF1322E92386C03073ACB43C332EFFE7CBA9B2A1CEF1BB6FF4AC94
            03125B9F0EA27D821ED266EA7DF2D8DB0BBE2EF7284683C1D995FEFC1E8F937E
            834CA136980287F9277ADFDEF3FB2B8ED850FEF6E1749478BDE9C5B3876EA500
            C47E83F84DEA2AABA9AC156C7C6BE400F6BCCC79B4B848F0AF63FC9EA63D5DB3
            F97C5B30FBFC1EAE9C31F3FC7EE9D9C327E806428EEC6CAE36666A7BD29115BD
            8A0F03A4F7E18DFBD0D542E9292AF93DC4F78448FA882130CC1C2B2DCD8C3797
            66C5B79646BA6C24843C34B7EF422732492F58EDA6F7B7B71CBDA7E480BCD61E
            8CC9D8A79F87D24BB2ECF7F39DB6CEC8D34F9BA8141DE78F7863C1632657EFE5
            1B943F4E17CBA776DECFF724B3FCC995D28182CB1E74947BCBE5E937D710DBF0
            DC3947EF332B6B27E4E1EF34FAE76E6D7991D0B9F8D4D8A4F4F5643E9FFA2E99
            D7B17751A617E4660B138ED74F2CACC2D9AEAF2E9CE0234EAF79C01F642F6E9C
            1994C999C64AE05A86A5164ADF50C9EF15AEB7671F689D550A48227B448E9506
            A9A322E6B2299D32B2BD598D8AAB312A6954F2074E609839561AB319AB8BA912
            23DB9BD5A8B81AA392894AFE60090C33C74A21B5A2288AA228C388683991AFF7
            B2171F31974DE99491EDCD6A545C8D5169818EF20745609839561AB319AB8BA9
            1223DB9BD5A8B81AA3D21A95FC811018668E95C66CC6EA62AAC4C8F666352AAE
            C6A8E4A292DF7F02C3CCB1D298CD585D4C95E8696FE26FC9625D61B01A97B11A
            A3D20E2AF97D2630CC1C2B8DD98CD5C554891EF626AEBB306D22214547352E63
            3546A54D54F2FB49609839561AB319AB8BA91223DB9BD5A8B81AA3D23E2AF97D
            2330CC1C2B2DC98C7931515A9DAB76B481EB8E9540BA6C3BEB4B276726F12C18
            D2E3D432062077D6B0930F761D225A3CD5AEE3C68B16F9E1D29D3837CCE1C60F
            4FD779713739C2F07AAB6E8694834BFDF40F69513F5AA4DD2E1E6797F36B1128
            DDCDCA5DA38DD6774B82F40BD9F5CDAADDBA599E8FFF4824ED466435119317DA
            BF53E0DBB2877095A16C3828A753600BE34EAA6A5C005E2297E066E185A7A082
            B6742607F9C88D8C316C24CB9DF5E59333D4D0A6FD9323B4605EC6E278250079
            CB5E7480D93E3F5BDF6D9AFCFA6AE328B586C6CB898EAD8D8DCDF7DE0375847F
            B7AE5DFBDB9D5E5CAA65A2925F1E819D7A04869963A5259931B8DDDDB4DE3BEA
            4766B1BA202C1BC5239790653B97178F4EB206648A04EE5F6F235C3AFEC1CF61
            1D1444F6BDE340902182F9D8E4222DEEE2AF669F162B6D16283DC9C459391F80
            C67483F40BD9F5CDAE9DA3F7E6044B27EAE3725B90D944DC7AF9A1013AC5EF4D
            D67BB8BDC135FFA9EC397A2F317510BA4749F47E4F3A2021FCC12C02BF69F49E
            22F4D49E5C847B1DBC780ECD2E5F4B8E407D179FAC25A7281328AAEC45C6CEEA
            FC81FA93C78D1FA116A33BB0ACB5B1A3AD45E50169BFB9B6160824A87EFC1AA9
            925F0A819D0604869963A52599318D62EB2757D67F3C5F2FED496A50367FD175
            FAD85C24E0EF300ACC0F976EBF647368AAF7A90C912CBD7796E83765BEE52FDA
            8F099CB1B29B090D5EF9038AB11BA45FC8AE6F76ED527A0FE0E2F3AD9A88FE04
            C8AD5BB3D07F9DE2F726551903D2A3AEE0695BEBFDC413F3DF98E63B246CD2DA
            D1D9997D94B099DEEF6CAE9CACBB7A8F375EBBDD94E19AFCE9042511B752DA6B
            8F2E3C09B9E45E9042DCB5A82C99626FB75B972FEF6C17B6CC5EA2925F121926
            C904869963A5A59931BACBF1CC99C0AE09CAE6890160C29A658A04C9551BE1D2
            ED976C0E4DF53E9521E2764332754CAF8BBB321FF4561028DDFFABD46B2B15A4
            5FC8AE6F76EDB2F43ED1C8664DC47A2F856C16DABF53E0FBB287709597AE81C6
            D44E9C5B3C9EA7F7B34B17EC9D1308FF128C402921D4C5948EDA1313CB679E4D
            319DE2558D088F84B70E65014591BD18B1D79E7B4D06972B12772DAA496BB1B7
            DBD6B56BF2852851C92F830C936402C3CCB1D272CC1867DA6BA4491899D419C8
            1622285BC6F89E3EA2DFB6C78D13A7C949C880A1596EFB27FCA209974E59E15F
            6C5B36D1FB8C0CF1B0DB0D89DE93941E9859F88119410641F9DA18DF6FA583F4
            535A2E55AABE49C5BDDA65E9BD19DFB768224A0755E8F1F81E72C5DBC43DD3F5
            A971ABF7A9AA49E1B76838DEF8EE6C6DDA895F1C8AB4A9A9BD0E4DA704A37940
            C7F788BDF6747C1F176D8A3D6F372F5DFAF4F66DF9667CA8E41726C32499C030
            73ACB41C33462FBB9BF49E9E923AE25484B06CE89127E4F9FDE64A6366521414
            054CCE8E4F615130DCF973E3C8B2C3A5234624E843B6DEBB82DDCC33BA7A8F69
            266AB57D46BD50869B064A4F32B1CFEFAFBB37375841E7D172467D9DE8AE5EED
            527A9F3CBF6FDD44FD787E4FB9EE6C2E9FA027F9A8F799553305A042C28D0996
            D97EBD99DEDB46B3CFEFE91E4B9EDF4323CC9C58BE9A1CE157D5C67BF20B7EBF
            E2B1E15C7B7889628FD3FB25FEBD51ECB5A820B72E5F0E84307703598DF63D3E
            95FC62B842E31118668E959664C6F6CD5EF0C7A5BDE79C2A9BBCA648A7413135
            AF9A2751C9E5ECC1D08D5D7F9370E9802769997A9F99210AB0DB0DAEDE731A18
            47F39B77F8B979A074CC84FF60FE14CC07C0507B9F99510052F5856358D674ED
            1CBDA7E4F00569B4A64D24E97243FB770A7C5BF610A7DD707268B7F98D4046D5
            925EC042F2AF15ECD7A1824989BD3B1B69B4B72EDB4EE17B1D4CB9BB3EFB3C3E
            75DA5C5D98357D62EA5B3A90B7ECC5063E39B2C0FDD6B595799EF1097E3F82C0
            51D9537ACFF6CD9B8104B6B9E1DBFB1B1B924B64A8E4774968A79E0B8643B247
            E45869903A2AF2CAC6371961FD953889F94AEB29D5A8F8C876DF40E86270EF6E
            F81EDF56F93355C551C92F9DC03073AC3466335617532546B637AB517135C67E
            5250EF798BF367FA2AF9E51218668E95C66CC6EA62AAC4C8F666352AAEC6D84F
            3EB97A3550BEEEB69B972E6DDFBC299946834A7E8904869963A5905A51144551
            946144B49CC8D77BD98B8F98CBA674CAC8F666352AAEC6D867B6AE5D0B46BA45
            365E8557B28E031DE59742609839561AB319AB8BA91223DB9BD5A8B81A639FC1
            DFDF5FBA14C85EC1EDE6DA5A543FD357C92F4E609839561AB319AB8BA912D1F7
            262E1D319144E5298D6A5CC66A8CFD07B439D0BC523650D978DEE353C92F4860
            9839561AB319AB8BA91291F7262E5A3069C208954A352E6335C68170FBCA9540
            F34AD9A20AB7A3925F84C03073AC3466335617532546B637AB517135C6810003
            71D0E640F3822D3741B32D9E9FE9ABE4774D609839565A921927CBA28DD79F5D
            C235EF4A205D3627FEBD3D91B3389DACC8E6AC73E72CA026E9BDE5E2CC9AEDF0
            D7ECF0EA4A694073CB9E05D7CB4B5639749708944FDC4B495FE092FE61B4FE20
            E4BF97895D868F2F125EA997A1AC68493E6FF92AC9413E996B4C9629C4EB7CF9
            D44C0D2F28F3A7E448E6B27400FC41F6628316A5C6828F1F9A5F814ED0F8F731
            B2B5B111085EB0816CDBE8F85D6C91FC4CBF5A929F56A5F411C2F781B49E3A2E
            208BC166C100CD62AFE8939A081224963D22C74A83D45D828BB3D282F014A2DE
            59F9B51061D952F1EF298A8CF5E976E97E1B2285D2CB9ABBE8CBC067A7E3A419
            F76E17A8672550BD2F99D495462106A6EBD336DAAFDF35199738D84618AD1F72
            853E87EB8DCC2947EF9DB04364668EDE3BAB34DA1C928B59F49E162AE62008B8
            BC3F1C826BCE1C015B5D385A9B485FFCA98A470298C963F5F9B7364D8CAB8FB0
            2E50278D7F1F1DB9CBEF6CDFBCB9B3BDDDF5E47F243FD31F0AC9FFF4F66D3875
            DE1D92F53C36345A5AA72059E003ED32EAD757E6BF7CA8B116ABDE6371786173
            D45AAA5E090465B301F1928FE8A6C15B713B421B81EF4DF47ECB4F2F787A8050
            53360BAFAE9446EA4A83FBAA03338B17E85FABDF2DF49E6C2315AD3F0CF9EF65
            E2E93D85DB9FA6BB3AB0ABE9DAD3C767386533BDDF7C6BBEEEEA3DC5D7F1AEED
            20CC81B56D8FE895926B810D6BDC906DB784E86B516576B6B602B50B3618DCB3
            02816C773DD087DB858147D38F5CF2E18C7C6A68E496710AAC05D9409DF688D5
            294816F8409A5AAE1D6DAC1A8F12A9DEBBF17280DEE87D586771D3A8F77C5A13
            EB4CF4DE0672C52FD2DFF193FD00503939DB26E1D595D280F6963D0646D807E0
            A22715E78729D813BEDE733749DC7DB08DCC68FD7EC87F2F135FEF675FB9C0F2
            8CD351D349FC24BC909C13252706D3A3C924D1FB2B26374BA08BD937BB9091EC
            C5098EE6A7E06EC6297C502F24F65A549DDC9FE38352724A10FEAE97E743191B
            F4CFF4A3957C2BF676B36D9E022D887C083039D35881D1437244742ACB074A58
            3513D52C56BDB704239E420465CB19DF27939099E37BE3C23C3D40A429B3C3AB
            2BA5E1F7264D6AC121811EA6F85D135CE22DA2F5D3856142FEE3419E6A02AC6E
            C90E5D12338D85D91ADC5FDBE0BFD9E3FBEB18A857AE9F647CEF5FDBC33FBEC7
            398C07394C338E2D747C1F2BA0E2B93FC7777F5B0FFBED87CF0FB681FF4C3F42
            C94F8B3D6F50D4ACB9FDC482C871817F339A92E854960F64E869353A9668C7F7
            3F5DFD1023BBAF9CAC4BC4D21208CB86C3323FFE3DDE13D996B50E4BF4DE3CBF
            E7378F4C3223129267A22BF475501274DF19FE4E2988D79B5E345E18B853B45F
            BF6BFC4BDC5556D3D149B47E9C3483FC496BF1F50B7EFBD289E36E3B14FF3A36
            4697A83D5DB6DE43B6A660F6F93DDE629AE7F74BCF1E3E41371072646773B531
            53A3B7582423A124132B1F7C39E8D097EDAB43543B7C7EAFF1EFE32437482EDC
            104852030CD6BB9EDE6FA2647D222AC96F26F6BCC1ED91A44B68AEF7D67D6DA7
            7DE0F7BE7DE830D9A3790A10ABDEB31B0578EEA21C526573E3DF9B190F579BF1
            252C68D94DD17BF468CB8D20C039B61C7F06D0AD274D895F0FC2AB2BA501CD2D
            7B2C2DC9D48BABDFDC2FF8E8E5DC39E7126F1AAD5FEE0F78F4CF3704F61D57E7
            8579DBA1742E3EB5A7F7064884CF81385B53B01DD17BF09FCEEF504E2CE06336
            9E7FA3EFC2C57FD2BE779B007F90BDB8A0A70F0970C7A3F1EF6327F78DBCF46C
            FCCEF676D7D1F6E05EA13FA3E74C2291FCD662CF1B1455520BE870D09290643E
            5FFC19B9AF6F367E3FE503BFB90CC358F7E73FAEDE7366FC549ABEC3C011D923
            72AC34481D1531974DE99491EDCD6A545C8D310640BC73C7EB993FA92FF21EDF
            007FA63F70C96F47EC794B497E9F080C33C74A63366375315562647BB31A1557
            638C84767E8E2F497D8ABCC707DBA07EA63F40C96F5FEC791BC86F1A03C3CCB1
            D298CD585D4C9518D9DEAC46C5D518E321F745BC163F152BF41EDF807EA63F10
            C9EF54EC61DB7CEF3DF9721F090C33C74A21B5A2288AA228C388683991AFF7B2
            171F31974DE99491EDCD6A545C8D312A7267E66F5FB922499B50F03DBEFEFF4C
            BF6FA3FC2E46F6BC41B3F4FF9147609839561AB319AB8BA91223DB9BD5A8B81A
            635480AEE4BE7FD7CE6FE88BBCC777F3D2A53EFF4CBF0F925F44EC07F2566360
            9839561AB319AB8BA912D1F7262E7FA1F1EF9BA1C6181BB9CA047ADCCE70B3E0
            7B7CA0C1FD1CD4F654F2874EEC81C03073AC3466335617532522EF4DFC05BFC6
            BF6F8E1A6384E44EC8B73FEB0E72D5F57B7CA0762D17932F991E49FE308A3D10
            18668E95C66CC6EA62AAC4C8F666352AAEC618213BDBDB81F6A4B78EA4A8485C
            5DB85DE89BEC952EF9432AF640609839565AD88C65CD3BB3E84FAB10DA9D1296
            2D7391215CAB28891FEC249135C2D247ECA245B8FCDEC9192AADB3A0584686E3
            B5D9255CC50D3F4CD44F9F4E8A8104479C95591507681AD9B3F84D4DCD2BEBE5
            C9276ED1A4B7691947BB2815A7D0F8F75DA3F1EF871F18C1070A146C59ABBDB6
            02EE21BA8EAB0BDB2757AFF6677A3F4FF25F796EAAF6D499376FBC73E6A9BBC7
            C6F61F4F7909BCD091DACCFCCBEF6E5CBCF8D19923F7DC7DE4E577E8EBF8ADBD
            F8F5D5D77EF0F8D45D906CD783732FBCFAF291BDFC25E11F7FFD3BC73F27FB12
            D5DEACE68E65A455F378F56E979DF5255E9393EDCE2D8C958FB40C59C9F381EF
            C81E9163A541EA4ED9599D3F507FF2B8D17B5AD61497E0CE0CA1DD2961D93C57
            CE6083BA31D46DBBD062E0D876C91159C7F88ED17B0A57C0A18A303EC121CA39
            2B43EC06FA22E545B1DAFCC2B8FB4A1352575AD8D441335263FB9738D880C6BF
            2F0D704C1AFF7EE80171CD8DA3D3C564FBF6CD9BB9D936DB60C8DB9F9FE9B794
            7C5FEFC7767D7E6E39CB4B6CADFDE05F1CDC05297F94A9F71B2F1E7B60D72367
            DF78E7CA0BCF1C7C70EE5DCCF94D50FD7B8E9CF91847F6D78C87213541F7E2EA
            3D0C2A26A7EB5312BFDB605613DFC67033870297C534D5B5348161E658691966
            6CBD2ADDCE884BB507BB272C5B46BB40837A31D44DBBECD8E066C9118CE5E3E8
            3D06C4DB2DE29D9099E113F3DFA0602DF441F5BE3B52575AD8D441335263BB17
            10D980C6BF2F1FAE85C6BF1F563EBD7DDB97BA70C339E7CE03DB177C8F0F57E1
            ED7D34FDE692EFEAFDDE278F1D01D97EE1830F022F41D3F8E7CF3EBC1BF4FB6A
            E6F8FE8D538FEEDAFFE8DC0B57929C49EF7FF3BB5B388D6F2DC546B577F41EC7
            274717D716F05F1ED23038D87002CD782E8B69A66BFC578FC03073ACB40C33B6
            75A6081CE2EF325C46A78465C34AC33182CF020DE7C70F7692C89CA47344C661
            A2F749581487CC0C21F135E8A103B3E79E6FAEF7728EB4BB5718681BD963524D
            ED35A9D7A81AFFBE9768FCFBE12777063EF7E7F8CD28F21E1F6C7DF8997E13C9
            F7F4FEA933FFE9ECC3F7EF3F72F285A7F65B2FF1F597B9D1DE7977EEE0D8D4DC
            DB997A7F71F5CA8BFFE6A9A9FBC6F63EFCAFCEBCB681E9DF7CE537F7DE7BFC1C
            59075A0AF98A3113D5DEEA3D78B6270EE068011CD7A41F36D3047E4B87706303
            6C2643596A0A5F923D22C74A83D45D61BD0396AF8FE3FB8CF8C149BB98C9580C
            BA86474C8441F85E32BE0F262D5B644863A0E9FAF4B88EEFBB041A54F6908CA6
            0E9A31E94A8223E019E02AD3F8F765A0F1EF0B002360185BF7F3D768CD809174
            EE7B7645E6D80BBDC7D7FB9FE967497EA0F73C33FFF9835FBC6FECE073E025BE
            7ECF7E927348E98CEF71EA7E150F267ACFB9BDFDEEA9AFECA7BF6EBEF7D6F9E3
            9F33D6612C25790466F41E0588A3741262592EF84C103DCCB525D7EFE5E85A0A
            48217B448E9506A9BB22F10EF4D41C1F016686D0EE94B06CC6BFCBC7AC18EA46
            DDD37ACFB328CE7C3E49B8DC94E10B14332796CEB7CA107B147A41F5BE4BBCDE
            D4F8F711A0F1EF8B00235796409C2D1FE81BDA0C48B211A7ECADCD9FE337A3E0
            7B7CF0DD9E4EEFA7243FD4FB1B177FF4F2111A8B4FCDFDEC830573F0ED771B5F
            E3E7F734757FDF43732F6D24EAFEF6BB73870E3E7EFADDD5D52B671EC7236F5E
            749ED903D6B1D8DB65D17B1A5A98697C2B3D0824788C5EEC350F9D03BD6FAD6B
            2902C3CCB1D2A2669CCC8502E0345B85D0EE14C845F6185F0FCC5B0FE2ACB8B9
            2F40D3E1D901673E5F5ACAB86FD17BF892794F124A3BFBFCCAF237B33394AFF3
            6D97193BBA85C17D3A27E2F49CE2004D237B4DFA4EE3DFF7177AFA909063BC70
            54F6461E7C45CE9FE28E44F27327DE3FB9EADDC37541C1F7F87AFA337D5FF2D3
            7A7F71E3D5B987768DDDF5F0A90FF0205EE8483251CFDA4F07774D1D6FD0C137
            5F78EEE1FD72E4DF9DDBF69ED903CEBE88FA26E9BD79748869003B722092DFC5
            D02BFDBE7C9817923CDFE8E89AC6BF57868191EDCD6A545C8D91498B3D6F3148
            7EEE8B7BB0152F24B440EE8F005B6CD07ABD9BDE6FFEFA5ED12D925BBA348161
            E65869CC66AC2EA64A8C6C6F56A3E26A8C4C8B25ED629084DC37EA416E256931
            A0A65D87DB81AD773FD3EF85E4472BF640609839561AB319AB8BA91223DB9BD5
            A8B81A2390BB0ADBC085014414CA10942AD84A9C542FF21E1F7CB19D95EFBAA0
            5CC98F59EC81C03073AC14522B8AA2288A328C889613F97A2F7BF11173D9944E
            19D9DEAC46C5D5188160E4D76C1BF8883077A6BDEB9FE337A3C87B7CB06D5DBB
            56FAF47EF1517EE4237B2630CC1C2B8DD98CD5C5548991EDCD6A545C8D11687F
            BDB9C14AC54E1B71744A5FF21604BBC87A7CBDF8997E11C91F0AB10702C3CCB1
            D298CD585D4C9588BE37F1F7961AFFBE196A8C00485AEE6FDEEC3658C1C88FA3
            53ECE7F8CD802AB7DF44E9ADF49FE97727F9C322F640609839561AB319AB8BA9
            1291F726FE825FE3DF37478D911916C9C772E64DB017FF397E330ABEC757EECF
            F43B95FC21127B2030CC1C2B8DD98CD5C5548991EDCD6A545C8DD1322C92DF9F
            9FE367D25113656EF0F512A7F7DB97FCE1127B2030CC1C2B2D6CC641FCFBCF3E
            DB5C5D98AD8F078B0075855F365CC9088E24D41BEBB2529EF32709420CE5B2B1
            ED9D838CBB9E11472C0896C84B964097C51171C935F91B73F874E3692F3D7F7F
            9CE2B830B8DC526A31A41106DA49F62CD444C92A5476C13BFB899B3769455A0D
            D72E3EC52934FE7DD768FCFB6E1916C9CF5D01176A2149CBA3B8D8DBADC49FE9
            B723F925F454DA7BB88E0C57B1FC38A55666C97D37A511268256D94BC7D12720
            ADEC1139561AA4EE941D3FFE3DAE7B7AE0D0F1E3BDD07BC67A70C2D17B3A484B
            DEE21EED48C0220A4BC011599844127879545C331C8F6594D9F4047F70D284E9
            A5ABC6CDA289DC43AAF709A9DEC426D2F8F78383D6F1D6F8F7DD321492DF4E1C
            9D7243D89528F6BC41F9CBFA997E6BC92FA78F12EFB122F1D63D8F0458A764C3
            6BB97ACF291361A2AFC0E024238E3E1318668E959661C6B60202163BF0D45D91
            5536FF5CA1DE9B20C4DBFE72EBB6E919AF03709C07DFC5117C46993BD27B5AFA
            981505CF38F5F4ECAF96D20ED520D59BD0F21AFF3E06B8161AFFBE638642F2B7
            F2E2E860C14A7A45AE74B1B75B59D1F49B497E69BD93780F73D3EC7924C01A97
            0DD99AD67B408409EB8CE39CAC38FA44609839565A861987DE018B1D788BAEC8
            2A9B7F2E47EF2131523BDA5885060C9A18FCF59E267A8F6D0D3E7A0D8E491626
            021ED252EFDDF49CE7D212DF67603C182FD68E92EA4DB88835FE7D0C68FCFB02
            0C85E4E79610D4549216A077626FB752A622D2374065F68BE3B61C319203645F
            8E5A8D4DCE345636B3F5DE3A13F090CDE2E823908BEC1139561AA4EE8AD03B60
            B1036FD1155965F3CF158EEF0DE8D00730BE3721D24F2FCC4EC1B8B04510C311
            C4EF4D0E3668A1A72D5EBF842DACF1EF7B82C6BF2F4CFC92DFCE8B7B057F8EDF
            07B1E7AD949FE94317C0409F7FBF80330725F648E2C4C8C5B97E46488C8B7C9A
            0DA9D7647C9F17471F8EC91E9163A541EAAE08BD03163BF0165D915536FF5CCD
            F49E3DAF3CBFA7B790DC37E99C2E29F5F93DE5C90F8649279AE439A278BDE9DD
            90C195ADF1EF0780C6BF2F8BF8253FF76D352815D442527748DFC4DE6EB7AF5C
            E9BAB4BD25F11E45F43E11261ACC98697C1417E745342230CC1C2B2D6AC6C95C
            28004EF37D5060F9E44D8C770364217B096DEA3D24A49F097041BC771DB94BF8
            0FC99FDC63CE4B762DF55E5253FA24683AE90D29939B5E8176923D96167B117B
            FACD0D8A4DAAF1EF7B0C4D182680F16AFCFBEE895CF2A17870D2A018C1D6DDCF
            F1BB16FBAD6BD78ADC254075CAFD997E39B8C2909ECFC71784F1B1A07CCA98CF
            973F18610A6610ED082401D2CA1E9163A541EAA888B96C4AA78C6C6F56A3E26A
            8CB9442EF9B9C1FD60EB74AABC6BB1B7AFDC1759990736387BFF274BA22230CC
            1C2B8DD98CD5C5548991EDCD6A545C8DB11D2297FCDC383A507849DA06C5C59E
            D9D9DECE5D27A0F556E2CFF4878EC03073AC3466335617532546B637AB517135
            C6368959F2E15C4101D25B9BEFC09725F6968211F6E0BBA547001A0A02C3CCB1
            5248AD288AA228CA30225A4EE4EBBDECC547CC65533A65647BB31A155763EC88
            6847F958B0BC6174EB9FE3973EB20F80A6C87DEED06283C62C77C5C0C8090C33
            C74A63366375315562647BB31A15AF6AF77D7AFB36C8C3ED2B57406360B34A06
            FB773EFC10240AE44D927648B492BF7DF36670F6F4D64C9B7B2DF6167D8FAF4D
            02C3CCB1D298CD786415A2928C6C6F56A3E255EA3E102D909F36DF11C3F162B7
            BFFB8A56F27307D05098F48D4EDFC49E81D315798F0FAA300A4FF403C3CCB1D2
            98CD786415A29244DF9BB83E86ACEC5B2AD5B88CAB518B9DEDEDDC95673237F8
            565AFFDA214EC96F278E0E68ADA426FA2CF6964F6FDFEEFA3DBECCBB968A1118
            668E95C66CC6D570310A13796FE28A3D931C5AB764AA71190F7B2D40E18A3C15
            860DD4AE4A92BF75ED5A70EAF4667F8E3F28B167E0ECED943673ABFCB3FCC030
            73AC346633AE86A3549891EDCD6A54BC77B5C0C516EDAAE01CCAC85F31B420A0
            169F5CBD1AC840775BC524FFE6FB8B73FBBF38F7E24F8202D80D06D650F28E0A
            EF6EED8A7D7B9DDEDD1D5BE59FE207869963A585CD786773F5F9591BFF9E17AB
            874CC7765368ED42A4CBB6B3BE74726612B31F1BAFCD9C5AC6E5F1DDF50AED3A
            A05BEBCBA7666AB836E878FDD92548B6B3BE7C724696311CAFF39AE1CE176D6E
            B8F0AA1CF3D603768FBBCBA6D292ABBC1E3B919527963B7D76BBECEB78FDE44A
            0F8695B10135953D0BC51A48568BC4B693F571E513351860AE2E5AFDDE2EC4CB
            296A3C28A70E9278393613BB8C2E77DF6E67717B5E483FB59EAEE4209FE4E231
            EBE7675C57CE91CC656801F883EC0D98D036532DCC2100A82EBC14A8031C933D
            01DAA494D5A2EFACCE4FDB25423DED2F0370F737D7FEF2B9A9DD07E75E0994C0
            DB5E9B3B3876F0B9D7DE098FA7B60CC90FE22F34A1B56A7E74E6C83D5373EF9A
            8F25483E962AB1A64C7EFE9FBFF1C0FE63AFAF26C5486F185726BBD8EFBC0B6D
            E69439D8DA1FD9B7D1E926BCD6E4FC858D1BE649C42BB9DD0A25970CFA0D389C
            032C1FC9F2DE18C3E54ECAC4AC55825E34565B0A011A6C5E38AE1C5F13A4EE14
            E8AA03F5278F5BBD5F6F1C42F5DA76628B754F58368C14B4474294EE5C5E3C3A
            C96151B015D85D49F8813BB463E29A2C3E7960F6D54B70B948F81C3C52A3806C
            F68B781F71A23E8ECA8161D4B3BC98550EEEBF3DB5D925B224908DC9E9FA9444
            64E72E09F3BC83176B78F68FCDC2C8D757E6BF7CA858A081A12075A5E1ADD2C4
            747DDA0675C6B6F3F53EE8098C843B559F9E94BB2B4C8176426AD18EDE3BD1A5
            38AC51A2F759F172E87AF3E2E584D7D532F82173043A7CE1686D2258DD1A4855
            7C40A46C336C61B62FBCB06D64EE84542DD27A4F0BF28B3F82BF3A11A85BE08D
            ED3CED2F0E48A6D186BCAD2DBD1785FB69B72AD242F203BD87ADA8E4E7EB3DB6
            F67FFD7B7FB1E19CB493ADB9DEBF36F74FC70EE5DE0019DAE974EF7282666CE7
            258C8C3BB37CDC6BB80846EF5DCD025226F6113A108C8B93C4CB6F0E1AEC60F5
            9E48B4D0E20744E992A06C419EF891DCB4715B3B9B2B27EBA8F728A55E9F05D1
            56F02386C7F5FC1D0A0098473AC639E3D691C6F4FC0115E8E8E2DA02FE4B05CB
            C873E97CD6D97F8699A44651152675A5C1ADD28199C50BF4AFD5EFC443792D89
            D0FDC1CCC21AFE4B5244E98FCFCFD25581376AADF57EE2F8B7BE21D2822EA6F6
            F4F1194ED94CEF3156ACABF7180FD7F70590CFF0C5C3B57614B6305EAE127D2B
            D5F8E95AA0DE8FC3ED1A0DBBE08EC78976F48FEAF53DB25B3FFD4370A0B5E93A
            8E69E07A07C7472E5532B71189284B29C09AB924EC2D054BC24B0B1D1DFFE67F
            BE2E62FFE6CB47F6DE73E4CC4728EA7B0F4EEDC582EDFDCAD9D7DEBEF1E6F7E6
            A6EE834F77EDDDBB17F5FE3F3D377537A64CC4EC8DE5630FDE855FB87B6AEA0B
            F7E00E70F0F48B7F581FDB53AB418D0F37D6CED1057301CECE7FA619BB6D7247
            F4192F89647265FAFFF5EFDE5D85B1E9DDF4B7B1BBA69E597E7335A5F76FBC3E
            F7C82F710AF8FAE64A43E635790E096ABABB569FC60CC7EBB3A7393298DC770A
            78554FD46AD4113CD8C023A6CC70B5536BFFEB955B9BE7FEC06F96FF8C75BF7F
            EFFE5D636353FFF3EB2FCE3DBA17F6C6C6764D1D6FBCB67171F5CA0BCF1CC403
            77EFDFBB1B9B885AF5A9336FCA80FB5FFECBAF4B338136FD2C19CECABC260C6F
            382693993D954EC7187163FB6A98D6AD2F7E6B159410F77116EAF4E9FAEE7DB5
            7DE363130FFDF18FFEFCF15F84CEFA9BD74EFE3A9710B8FBC8CBEFD8A64BDA8A
            BF526FBCECF7D1169ED4B938D796EC350C4D742D990FC37CFC927B255CDFC1B6
            6578F2CCE83D1E179B722A6B4DECF8C2F34110EA736B499176D767E767716E80
            0D87BE92E75E727C4D90BA2B5C2D64E0E665CA8C80BB27285BE8838C9BC6E3D8
            D0005FF1A9F2608A4448ECDDA29F211FBC00DF95CC5C0D08F294536F5D5F7CE2
            00EA018EF279AE3823CFD3A733CF0E9D4FA1D59C69FF4A030D2A7B0C5CFA07E0
            422715E7B7E2FD6E72BA955D0334F2613415F8E204453796F4EF2FCEECABCD2E
            2CE6EAFDEC2B17589E794C69C3EB25B64A274A4E2C66465D067A9FBE170CAEB4
            ECC10164247B5190D8A6D3C214A7CB181424C23FF9558544B227409B4C90D3BC
            06AE8D6A9D39BEA783148D9A66475C4300A04F6DBC2FABFD7C6307B7708B33B5
            5A0D2E926D9E03B8D5FEF13FFCFC3F99FB8F6F1BED74F5FEBE83C7BE77E5CDC6
            537BEF3B38F7E2EBC7BE30B6F7F197DFFCC9BBA7BEB23F53EF575F98DB7FFFA3
            A7CE533ECE88F6B5B987C6FE4B7964E95D72ECD3E123DE1DDA7B41BAC7A28B76
            73E9777FF9E01FBCC405BB78E38D538FEE42B10CF47EE3C5630FEC7A70EE8537
            68947F1DEF23E9B915B5E19E99C565D3F81FE2632994F30F4D2F18B037E90116
            8E2969FE958E98C7ACC99DD6D6EAFF0ACDF2D0DC4B1BAB2F3DF7E07DF71CF9D3
            B7A19A74F61B58FDBBF71F695CB9F8F6EADC97EEDAF5C8D91F7D5F8EACBE7AF6
            91FD69BDFFA7CFBD6D3D338D6DA069E062A30979B8CBFCE88237F8498AC1D7C9
            A1F9156830BA8D469FB0837351F8577B39D9AB0E2E19B4BE7B7FFB05282D7599
            4CEF53D3D5BFF3D77768C40C97C7AAF31583F4D1C7E6A41FE389B0CC77EC35EC
            7619E6B3F2BA53F27409E9305707DB1ACA867A8F97C638DD6C00D04D3FFC23DF
            C49E6E9CB626C3CE84F49E8A8459A1A2AD5D97B291D2B95D4C048699E36B5266
            DC0581D783FBA0C3937606A30041D932C6F7DE30C54E425267184B437A34BEDF
            4243C28E64A8D733F2CC1EDFD3BD2D7EA407136E692B0AB490EC21E6819C40F7
            BCD87689DFF45A12DB093C9DA40625469130E9E94A98AA4FEF46CBC183F6750A
            DB6BB283E1EAC7671A0BB368A2362EB5A37388647BDD7926C57AEF797022B8D2
            F0A3E7730928AEEC0D9E4CDB34BE786DA1D3F13D25B132DF5CEF392BCA34B9F2
            0134103BFA71B41F7A647CE64FFF7466374DC97CABF1FB62F8ED1DFFE6B74F3C
            B0EB57CEBEB12A9AEA8FEF9391E8DCF7E538A4C13F658EEFDF7EF7CCDC5353F7
            DD35F5B51FF0C0D7E8FDF4D82FCAB52A17CC65331C04E8B25C5F6EC0C09BC67F
            6EA867B8AD7CE83B3FFEF137FFD97EF998A1F7F81187AAB8BFF9DE5BE78F7FCE
            F406372C8E53E9085ED8A9C627F0AAA6CBDBA6498E005E6B4F8FFD3D6A166CA8
            B1A97FF9325493CFFECE99A7EEE616334DF4CA9F9A23A6899C56FDF6C1FF13F6
            2F9E880C4A5A86CE28076F51ABEC36AFBFD86238D709173801BEF5BEABF7A629
            D8A897AE2E1CA1091899B3B9FE1FFEF9BDFC1181EBCDB615606759002818E93D
            FF4D8A97E83D965D520290CF45A7E4708FEB9770F52D330103692143281BEA3D
            BA266E0A9AC99F3CFEF5C7DA19DF5391A800F45DD39E78C4ED62024E287B448E
            AF0952770517941A141F5A7FF950D65B4B5D10968DEF16D95BD1740ABB5A6A38
            3ABD711FD4CA3CD6C780E5874FE0C04E26B5B8CBE9C62DF96257CFEFE1AE3BB9
            FF30A7CECAF316CA4078F68B8D438769822BE3596925F17AD3BB0333368F6D67
            FD91D3AD88ABAC664C60059BDA10F2274385DCF6F08B1DF4409DCF62BB0FFF3A
            C6EF57DAD359F7C424C5B0CE88F59E6E2CBCEB8A6E20E408BFECB6C779255028
            C3C4CAA0A96D92DE437BE270196ABEB499750F9AAA4513BD17E7057FDD9DF8F1
            647C6FD51D48869888ABFD744F0C43F599C5B5D5F969181FC9139CF68EFFE22F
            FE57F73C7CEA03A39DCDF53E3DBE7FEDECC3BBEF82EFDAC1ABE4701E8ECBC097
            5F70A3ACE45AE50BE6DCA2DC68F25DBE5CC632365882612D0F1699EDE5DFBDF7
            FE5F3BFDE3DCF13D7DFCC91B5FFFC2F897FE358C504D1BE298951A1F2FECA4F1
            5D31C0ABDA8EEFE9B1141E3105735B7BBDF1D0D87F69C6F7BB1F38F6BD77A072
            ACF738BEDF8D33223CBE87BAAF9811BF6D22ACC2EE474F9DFFE4DD7F7FB44623
            193C11658EFDB2876614CC3526D71E9A21963F2986ABF776F4CC8901BECBC9D4
            FBC573ACAC5B5B9FDEBE0DFFD2DDBFD3D4EE57B0A7DC3E6AA2F754CE543E0C97
            9C660A9D1262C6A80550216F7C4F27B28FE72726BFF927DFF44DEC23742098C0
            38AB2BB6489867747A8F45B11C6EFCF0B4F3D1BF97EF1CC842F604F92D00675E
            ABEDE399706C05E94FEBA0D11DF3C333B8BD5E58BDFED9E6EA023FE4026A3327
            97D1E951833299EFE79BCB0F718FF3FBF9C1D84E4EEDDCC83B13F519674FDE85
            36B7BA15076A2A7BD091684BE656C9D36F6A22006E74CF397AEFDD1F186F6527
            E4E1EF34FAE7EE485E8895076FF077760D90199D8B4F8DDD4F5F77AF614874C7
            1C4F04095C06EA3DBE6E195C57F25086BEEBFD702301FE207B83C533551CAF24
            532CF21E09BF018307D2D7241C943DC1BAD14469640E069B97DE5185DD99E757
            E0AF32A5C9DD613DBBB556C0D77E9E29B13E2EF9FD4BFEF15B8BBF7DCF18CA0F
            28258A28AAF88F9AE8FD2B1BAF9D3E8ECFEF77ED3F74E8E02E48F9B67938BDFF
            9F3DFCC5BBA6E6DE7BFD0FA7B13DC6C6FECE3FF98397563697FFF07FF83BB0FF
            FFFC0F2FFDAB2F8DFD7DD14EB9902ECBF35DACECA4F3389FA7D0DD912594F39A
            24DEF55FEDBF7F7FA2F7389EBE1BDF395F7DED078F4FC9B0158EBFF9BDB97FFC
            5FD0077AF292343EF9254FEFCD11ECEE5ABD8EE794DEA423FE854D8D87C7273E
            F7F7FF8F903299C690D905FBB41E46CF8F3CF722DC7FBCFD6EE36B6E13F12B0E
            5897DA9767EAFBD0E7D31304BAABFE30798981AF317B11E294F5474E315CBD07
            7BB5EF2BF04D3CD4B799DED38058E0C6099AFA7DE72BE619BCF4515AEFB79D6B
            F8232F1F2B6DFCD0212821BEEB833E671C64093384B291DED38BBD9409BF7E9F
            BCD5614CCCBE161058479C7ADF4BF2CAC6FD4A2DA2444FCC575A4FA946C5BBAD
            85EFC75DDC216672A75E0818DEF1F8B8EBEDE6DADAD6B56B3052ECFCD5EE6E68
            FD23BD602BE1477A82DFDA741FF0BBE7AFB7FB5B86D4D6EDA23AA5743ADC01D4
            E8B62FB8651C1502C3CCB1D2989DD1C82A442519D9DEAC46C5BBAD4533BD47EF
            2CB3F10068BFFD596601BA5E41EFE6A54B205AFDD1F88001487ED0DAA4F730EE
            6F278E4E7AEB7E05BD723ADD19CDF3ABF2727C54080C33C74AB9A11445511445
            193A44CB897CBD97BDF888B96C4AA78C6C6F56A3E2F1D7A28B586A30B0DED98E
            E269E08026F643A0358273B5D8BA1FD92BE51118668E95C66CC623AB10956464
            7BB31A158FBC16A097811AE56E5D87BCEB1191487E9B916954EC232130CC1C2B
            8DD98C4756212AC9C8F666352A1E792D407E02416ABD81D8CB37632212C96F27
            FEECD6C686A456064A609839561AB3198FAC425492E87B137F22ACF1EF9B1179
            2D3A9ACC0F22BB47450C92FFE9EDDBC189D21B9E3A8E4721234E609839561AB3
            1957C3512A4CE4BD89BFBBD5F8F7CD89BC16203F812035DB404DA39AC64F1383
            E4B773FF14F36DD3E81018668E95C66CC6D570940A33B2BD598D8AF7AE16B8F8
            92FDD9342EAC64C3E5B54B476F99F5680EBC5CFA24F9CD5B1B0AD0CE2DD4F6CD
            9BF2852274D5E90A1318668E951636633FFEBD5966C8AC2A5588B06CB4E05018
            EF9C77045A3D2A09366F97574BBE4D04216AAEE21AAB76B937279D5D890F9749
            4A8739E71573E1808479505A01ED247B165C7145E3DFF70DFB4BE5AAC5BFCF9B
            7F96D5F460BFE9637BB384997CEC8822DF35605FF84BA715957CF3AB7AF99845
            EBD6DEDAD808CEE26FB47EFE3FFE830F0A4F96B4D1E926DC8697CC2EBA1721E0
            70787D3D67B94F5C9DB762F1EF055AEAA8B03308CB26FE699CBC83F1EF894F67
            E8CAE0C5EA718DE2439E7E70BA64657B6A5C5CF62188AACE76C28BA7D2E2C6B8
            C8222F930EDF9630E7DBB2282C2D917828EC06252075A5D18A2B1AFFBE6F5437
            FE7D9E32255BD347CE6D69B65BC192C1BE48E55C48F2F3F53EBFB55B9E5DE2E5
            5CBACA4B1A3B747603D44EA7F74DDACBEA627038A4F76C53364255CAC4AA11FF
            3E888ED02561D9C81187F1CE83B3A3FB70A2CF3978DE0DDD3D1B03AFF3154655
            377682A3C0248E2A1D92C5BAE1D49809AFD8ACE493BAD2A06D0F68FCFBFE83C3
            A94CBDC7EB5916B84D357EBA16A8F791C4BFFF0F5FF93C2D980FE3788E6EF793
            D78F7DF181632F6C883249BC9CEBAFFF2148202F292FF1ABDC65CFF11AB06BAD
            5BBF9F443D7FB0FEA0A920AFA6DE65FC7B9A04C22AD0DF3831F58577E538CBC6
            FDB7DF7CF7CD179E7B98C3E9DD77F0F1D3143EFFBEFD535FC443BBA69EFA9747
            7841FBAF3EF7DAB6957CBCAAF3E3DF6377D39D81D32CB7B0EE1C8AFE4BFFB69D
            F8F70F8DFD12591C548AC37F63728AD1D0C3F8F71CBB1C3A6B0BEFB3B9A1799E
            2ADDD41AFFDE10A4EE0A5771C9E52132E829425836AC2ED8951FEF9CCE4E6704
            ACED6548B0EFC2E8D2C40B0E542733AA3AE7C0663FDF482A680FC2A94DFC9E64
            DA5F690A748FEC31D0E01AFF7E00C0C0A26AF1EFAF7EF7D73020DE1BA71EDDBB
            777FEDD8EBEFBC30B7FF8B732FFEC48C4445EF6FADFEAF12001EC752302A5845
            6785F37C7728A84996DEE3A562475D4E05B1ADCC234BEF92639F0E1F9BC6BFA7
            A0ECAE00E077310FE7CAA1F4F294F06F776EFD185A18E3F8AD6EBC3AF71006A3
            3B037736774D3DB3FCE65F9E7D7837C581FDCB978FD4407D2FDA513E95B09DF8
            F7A9943604FB75183EFDABFFF3DFCD8D7F6F42039B4EB71712B61E344D0FE3DF
            7369A9CB244DAAA935FEBD43CA8CBB20F07A0007DA72EE6BBA222C9BB12BEA09
            13EF3C38BB679F1ED4BE269D3133898624C0851744656D39BE978F140189064C
            7240C902DA57F610F3404EA04BC56B79BFBFA0639BF794773DE0411B36CD5E1B
            B2A3F1EF2B19FFFE939F9C3CB8EBE153FFCBC3FFBBAF3EFD7BFBBFF83FCFFDF3
            07409952F1EFB7FEEA4FCC1437174F0688584BB906D2E3FB2D27EA390D7CB982
            98DE5CAB72C17410FFBEDEF8CF4162CCC3B972FCF6DFFCE133BF7CCF6F9DC538
            FDF22EC2BF3533191CB17EEEDD2460BF99D84F4A88173F16DB2D73D0DA5E4A9A
            92315DF6BBF7FEF2D3DF7D0B9BB165FCFBE38B2CC6BEDE4BCBD019E560F9F1EF
            AFA12E12348D81E7E48F0834AAC6BF770852770517941B54C8BA97EF98B06C58
            5DCED38D771E9C9D7C2ECF5FE173FA19B87BE73F50FB523A3F32BDF1D7E64ED3
            CA80FBFC1EBB8D672CF89DA63D871A3FBDDC788CE679E8164FF53E0FAF37BDDB
            3263F349FF22497F21AEB2A67B4AE3DFB74175E3DFDF5A7B696EFF7DFBF7D61E
            3DF5CAEBC7BEB877EFFD99F1EFA128BEDEA7C7F757F0E2813CA905D8EF1378D9
            882FE6022759990BA6C3F8F741623CE0B872BA8595F1BD5CFC0FFD7F5F5FB944
            E3FB2FCCBDF8620BBD872AA3E4E3CD4DBBF1EFFD946F5D3692430DBEE79FFEC1
            F976E2DF6FFFF5F70718FF9E9221D4744E53BB5F099B5DE3DF770A16C572F8DB
            4BA7CD202CFB5DE58E805C648FC1EACAF5CAA33D7249A9BB0DFBDA3C3EFF78DE
            BEF148CDC798F7F33DD5313680D3BC92CE99A8CF0A731E3CC2A13C9466403BC9
            9ED8A4BD4372F51B9B1301E7AAF1EFCBC533551CAF24532C431EFFFE93AB975F
            3FF685310C75FF0EC5BCCF8E7F9FD2FB3573A98CD71E7BAC3E0ED96E9916987C
            6C667A1C2A651B8DD437A9E0CAB743BDEF2EFEBD24367A8FFFC1FF6B8E13E3E7
            D9F6774F9F7B74EE852BC99B0A69BD972317CFFDC143639F6B3FFE3D3FE94FA6
            31C4F4924BA275FC7B0CD5FFF7FE078D7FAFF1EFBB27E6B2299D32B2BD598D8A
            775B0BDF8FBB24633BC0D5FE8E6967C9F75B972F4BEA61A6A4DFE5FBAD9DDC07
            34A5CD150E3A5C64B750A71BE00E40E3DF27E45869CCCE686415A2928C6C6F56
            A3E2DDD6A299DEA37796597A00B4BF4028F4D1D17BA004C90F5ABB0DBD07DA69
            64381D144FBE904BB14E3738A3F9919C670D0C33C74A83D4511173D9944E19D9
            DEAC46C563AE453BBFBFBF79E992A41E7E4A1AE5774C3B71747491DD3E131866
            8E95426A45511445518611D172225FEF652F3E622E9BD22923DB9BD5A878CCB5
            68F3E9720753CDC3C04046F9773EFC30C839BDDDBC74A9624D1D338161E65869
            CC663CB20A514946B637AB51F1C86B017A16A84E7AFBF4F66D495D15FA2FF970
            C6769AFA93F422BB4A6F080C33C74A6336E39155884A127D6FE24F8435FE7D33
            22AFC5ADCB9703C9496F5BD7AE49EA0AD17FC96F335A41592F0D28AD090C33C7
            4A6336E36A384A8589BC37F177B71AFFBE3991D7A29DB7C7ABFA2A59FF25BF9D
            BB2B2892A4567A49609839561AB31957C3512ACCC8F666352A1E792D40C302BD
            C9DC2475E5E8B3E4B7D9DA1DFE1CBF7B70FD2EFBCB7B5C9BCB895030587A5F98
            C03073ACB4B019FBF1EFF908AEEFCFEB22152255B63559E68C561EE2453AE52F
            B876072F5C9C7C74160435816D1059738DF310B0A8B85A13FCD5590F15974EA4
            6596737E99AAB40334B3EC59826EC22E495ADBED20D3B1D42376613E4EA1F1EF
            BB27305EFB53E68C50DC11D74268E7B9F2F6CD9B92BA72F459F23FB97A35C833
            BDE1599A0520EE889DF5E593337465669AD81D0A9328EBF618ED179B656B76D6
            BEA565791297C21FED028E80B362A6FCA09FBD0783AB1F529EE31C748ABC90BF
            2462B210B2294CB2F237D3C4696CAE2ECCDA33B37BC15C4F9A85FCEC4117382E
            7B448E9506A93B05EA13C6BFC7858227711DC75EEBBD043E07A40B4D1FD2521E
            4E60755A22D15D041783E25337D94203A653ED7D22DF43A8DE970434A5EC0961
            3765E8BDD741D4231AFFBE3C02E3A5DA419DB24371475B0B4B3BAF8E57FBD7E1
            FD947C3C571B3FC72F6399235A7B5F42A25C5E3C8ADE5BFEC2786368ABFD9EDE
            4B442E846FF4DD21C4E4747DCA2CFDC4E7E265D42922C68113B438AEB764BB97
            277E40BD4769C7A108AD987B88B5CF14C6734AA247A1D3206F230BBDD39D3794
            7E9B0F72802B8EE9603D9801CA217B448E9506A9BBC26D0E8EB6F9EA6AC30492
            2A40AA6CAEDE53E073AE3CF6F7D4D3B3BF6AE401BAF08013581DD7DC76C6FA02
            7593D3875C8B6621D295C2A47A33E8264768895407D1FD81C6BF2F19DB4474D3
            2CDEC4B56821EE5A2030760FC4267303A1922F54917E4A7E9B0D5E744E05DD3B
            85E14970176D74AF5BBE8F676977F47EE289F96FC80400AA72EDE8EC0C2D72CF
            E961BCB1B6202BFDE1B9C23BDDB439983CC9F6E903160F4FCD0BF81B6C613CA7
            94ED342ECBED8277719A7B0839881F5D4F4504869963A5659871E23270261FE7
            57B7B03F7AACF7B34B4BDC37D80A93F317968C3C402B7B81D56DF17007F2E451
            1DE6411F788AC6D4A2498874A530D0D0B2C784DDE4082D91EA20B83FD0F8F7A5
            63ABE0163EA81712772D8476469C957C4BDFA59F927FFBCA9520C3F406A72874
            8FE5BB8514E01632A32EB97ACFF10941386FD1807B0963D5E1E50DE99F3880DF
            C5513E3EECB3E7B24E00D3A139D007C0C4AD81E3D740CE0FCC9E7B5EF4DE3E35
            36D3034961BC2A643B8D35CE53C2E420F00943773949C391090129658FC8B1D2
            207557F82EC3A598E44306B227F87A2FF1C84F2FCC4E417FE323122C044DC8F0
            D911B8BDFAD8BB9F324D2F7D96349DD4223B44BA5218E80CD943D2DDA4F1EF07
            826D22D757DA830971D74268E7A1729516D66D46DF247F677B1BBE1E6498DEEE
            7CF8A17CA10BB2C7DC063B86465CEDF7F47E798B32697C77B6363DBF7A552E6F
            89E367808B1F434227E7322E283407739CCC7FBA3E3DCE7ACF50403CF41B1F26
            851197C29EAD9DF1BDEBAFE21DDF5BB2073A9D922A5BA0F79BD4D9E0FCB145BC
            7E950E93EEDFA6E72532D362BE6BFA8C1222B616F0AD548874A5305E6F7A366C
            ACD46F6DBF835C2331CA94DC8D69FCFBAE498C976A07D5B4A1B83D0F1B772D84
            3617DAFBF98D1BF285EAD237C96FF3E7F80586F8A488F2FC7E7DE9C4CC89C421
            BB37A981F6FB7ABF4D29412BD08764A9A97CF73A3DBFE7F0D0D605850297B826
            7CD3057205BD7F7FBDF118BD794793DC90EDDA425298C4A5208E1B719C863CBF
            E7F764CD19D14F4EC82C2345E07583EE338161E6586951334EE64201EB34FBA5
            F7ECDC4906B80F9664DE869BC45E0D5BEBCB0DF37EBE04BFC7F4F419F13A95BE
            C599F8FDA414019A59F6F88A4F7713EA37F707F688C6BFEF39A1F19AA0EC596F
            41C351D98B9BB67E1A3E02437CA06F92DFCE590A2D6E685F7D872B73F6F9557E
            5E8CF66CEFC83191B156FA4AA8F7EC3478E68FBD8179BAC7C9EDCDFD0E698567
            D1989E3F03E221384F99A7A46C6D447C7CABFFF2476E615CB1C12F663B0DEFCC
            C93B83F69765A25C946302FC41F6881C2B0D524745CC65533A65647BB31A151F
            965AB4F912D9280CF181FE483E687990557A2BE7877901DE80DED5FE81D3BFC2
            04869963A5319BF1C82A442519D9DEAC46C54BA90538FD3B1F7E0843F04FAE5E
            2D30C19B433B6FED8DC8101FE88FE4B77E73A2D0F3FBA6E080DEFC8E8EB4BF84
            68FA25D1C7C204869963A5313BA39155884A32B2BD598D8A17AF050CA95D0D00
            11EA91E407276AB6F56DF5B781D307C98753C01783AC78EB5D472B4060983956
            0AA91545511445194644CB897CBD97BDF888B96C4AA78C6C6F56A3E2456AD162
            C0DDA3C15F9B43FCDECC33474A1F46F9C1ACBE8EECFB40609839561AB3331A59
            85A82423DB9BD5A878D7B5C87D99AB47AAD0CE537CD8AA1714BF057D90FCAD8D
            0DF8226CB7AF5C51B1EF038161E65869CCCE686415A292F4B437F1F778BCE85E
            7C54E332EEBA166DC64E2D5D1BDA79691C36B82D182959EA83E42BFD2430CC1C
            2B8DD91955C3512A4C0F7B1397AA98C6402F51528DCBB8EB5A0412D26CEB85E4
            B773AB01DB2757BD95852A8F4A7E95080C33C74A637646D570940A33B2BD598D
            8A775D8B364517B6D225BFCDE5F6601BA9597D4025BF3204869963A5859D912C
            0024CB0D850B09719A2E813C648F7133A7B5FCEC4A6AE3F5932B1F2F397F0570
            4DE3ECE0C1493465BB8C11E56D0B8C1F708535EF84CE72815E62C0CD50422603
            EE2283B4F693176579E480B6913D8497ACC2D55BE103B53376688B5E6812C17A
            AD51B75D6472908FBC481CF68264998EA29DDD71250379CB5E74F8C6DB9BF8F7
            20152018818434DB4A97FCAD6BD78253646E50C2D267172247257F60709C7BEB
            E8ECC27C63BCE87BCA0CC3041E7054F6881C2B0D5277CA4E10FFDEF868FE6B41
            C2B28599DB35D5AFAFCC7FF910472C70D364070F76A2294B6C037CEE8BDFB31D
            6032F10E3AF8C753194AAC6557EFAFFA51964711BF37CD1295B4E424B6679EDE
            3789600D7ABFC7095691740DADB00B5FD9347AEF749344D1BED6A4E34A068A2A
            7B9111182FB518DD81951DFF7E80928FAAD6DE8B7BD50E8D9F894AFE00D85999
            3F70E8F871ABF7EC974E809FE385F7172E7CDB37C3CB418260199FC03073ACB4
            0C676417274F7C34FFA12061D9C2CC699C67621B084E1A7F91768E5270B871F9
            2D6F25765C981D832B5B9D404C26DE4107EF78B0B4BBC91052257ACFCB2DD928
            CB2389DF9B74CD60407A6C3A6CCFD67ADF34827533BDDFD95C395977F53EE917
            43D38E2B99324CAC7758E375971F772CDA50B0160394FC365FDC836D7456E0B1
            A8E40F04C7D1392BEFE2D1BFF7D8CC21DF0CFFEC792F4128AF8161E6586919CE
            28D07BC812C89812EC94B06C49E676769D030F3881049C16C15DD7697118B4B5
            737E93896078894D26CE09DD88877ECE26317D00AC0259BD074FEA47599694A3
            0534A2EC217CCD2C5DC33BB613E7168FE7E97DB308D6CE7C3E5D1298583E7304
            2A339F1F76538B8E2B19288AECC588355E773AAA7CBD070628F9EDC4C9E56DD4
            1EE4032AF9FD877D1A1998E376F0E89E7AFD1FF96678FAB497C0776229C3CCB1
            D2329C518677A0B9C1A28FABC3B265D516A1B97A8974E4A4697B7C6F869836B1
            C904FF0F2A4678C79B0E138D034D47591E49C187AACB1E62AE196CAE3DD3F5A9
            71ABF7CD7A213382754AA44DD760845CBA248CDE07DD0434EDB892F12B1E1BD6
            787B3BBE670625F92869EDCDEAA39EF522B24BDCA8E4F7194741867A7C6F304F
            4F0B3D0D0DCB16D676AD71E830BD63659DBB9F063D783A78B0134D99DF8C6081
            C1504BBB69F0CD0FF5F1A0D32B1EFEF17486FC437079BDE023F7B6C30BE8345A
            F8BD99C80C3E9482BF91DEB7EC05794D8F3ADA7EBD99DEDBA6B6CFEFD351B4AF
            36E9B89229C3C47A4762BC74438C0F0E7B1AFF7E5092DFFEAC7EB9530BC342A7
            923F824D54228E82B05F3AB1BC79873DDEC2D2377D335C0B1288941802C3CCB1
            D2A266EC87D0FEF6D2690EA09DF92661A7402EB2C7602371E60088FAF5CDD5C6
            4C0DCF97BC7B8F69EC3D4193E0C1FC7AA41CADED9357F493D0E6F6556DEF84D2
            3D887B1C0F3B19CA0BFFD22C9347177FBA921965593E8E10D01CB28738F7883C
            FF21D771935EE0A428E16E046B38E6CCE7E325E14EC97053BF7559F41E4E1444
            D1DE71AF04FB4B8DD281BC652F360614FF7E5092DFE6BBFAB08DE0BB7B404792
            3F820F3E4AC27559F49878F3AD791629F178D743330C1378C061D92372AC3448
            1D157D291BDC13C04D434F2672159798AFB49E528D8A975B8B41497EFB7A36BC
            4BEBFFFCC60DD8E44387B42FF93ABE8F84C03073AC34666734B20A514946B637
            AB51F1D26B3110C9DFD9DE6EFFA45DABE600D9BE79930B0F2DD6DD8B08ED48FE
            48C5198A9CC03073AC34666734B20A514946B637AB51F15ED46220926F15B19D
            6DE824DF7D66016D0B2D2C7FE884D6925F564728A51018668E95426A45511445
            518611D172225FEF652F3E622E9BD22923DB9BD5A878EF6A319051FEED2B5782
            9C9B6D5D8F920742E63B89DDCD52A447F93AB28F90C03073AC34666734B20A51
            4946B637AB51F19ED6A2FF929F16B316DB10497EB3DF20742DF97C6374F3D225
            C859C53E4202C3CCB1D2989DD1C82A4425E9AD6068FCFB1ED3EB5AF45FF23B3A
            E3B0487E8BDF1C0ECB2D8BD2118161E65869CCCEA81A8E52617AD89B1AFFBEF7
            F4A1160391FC20DB16DB50487E0BBDC7F28FDED281952730CC1C2B8DD91955C3
            512ACCC8F666352ADE9F5AF45FF27F7EE346906D8B2D7EC96FA1F7B08DE63A42
            D52630CC1C2B2D6CC64108EDCF6C4CFAB1C2AB938665F396BBC3E5570715FF1E
            CC6A7DF994BBB49F93D259C84F7180A6913D0417C8D3F8F783A61FF1EF3BA5FF
            92BFB5B11164DB628B5CF25BEB3D6CF14F510C39814DF17A6EB45C9E8472CD0D
            6F9F9BC0038ECA1E9163A541EA4ED909E2DFBB21E70B1396CD08807C1C5CFC7B
            8A0EC0E1D7300750AD3B36252FDA8ACB1DF7423B8618BF3759EF257A10B6739E
            DE6BFCFBD2098C975ACC0DBCDD93F5F3DBA1FF927FE7C30F836C5B6C50B66857
            93CDADC808C6FCED27D98238BBB46982BC7C145A5918DE7EA8E2DFE38ADCA539
            CDB06C4600E4E3C0E2DF5384036FB89FC80C82CBBCBBE55410BF37E99AD1F8F7
            83C71A6F3FE2E3B54FE4920F5B9C4BF1DCBA7C392867B0E9947EEF71CCC70990
            46AEE9F8C2F3819505E1EF862A3E1E96677C5F6D1F4F5FF0C8A97BC2B261EE98
            3122723B90F8F719DED03F5728420A008D287B08B7A1C6BF1F38F662EE79FCFB
            4E51C9EF82A084E90D6E0824A9D22B1CF361D159C75DF2634F374E07561684B7
            1FAAF8F7328686EAD13C46C1407061D9B26A8BF43BFEBD7D8E90E0A5D4F17D16
            7E6F9A6B06DB5FE3DF0F106BBC718DEF993E4B3E7C1D3209B26DBD45B5923C34
            5750BCF4A67ADF7B1CF3A9F6F89EAA679F3D4CF458EF0716FF9E6E1DCCF3FBA5
            670F9FD0E7F7F9F8BD69AF198D7F3F5812E3A5AB1A8DB7A7F1EF3B257EC9BF7D
            E54AF1A9855268E7C543D5FBDEE308226BD0ECD2A619947E145A5918DE7E98E2
            DF37D66FD17B4F40C62BBE9D02B9C81E83BE1CB32640D40716FF1E5FEF328921
            EDC2EA7527A57322C5019A46F610D7242E69FCFBC130A0F8F79D12BFE443FA18
            7EDADECE22C1AAF7BD25B4A92D7A91083F1891CA0D6FAFF1EF7B08FF5E42E3DF
            F79C98AFB49E328C150789DDBE79F3D3DBB7AD760EB616F14B3E146FB02FED43
            998322656EAAF7152330CC1C2B8DD9198DAC42549291EDCD21AA3868C62757AF
            060A01CAB7B5B131F05AC42FF9B06D5DBB26DFEF3B6DAE2230C0122ABD2030CC
            1C2B8DD9198DAC42549291EDCD61A938086A0B85835ADCF9F0C3C1CE5AF75FF2
            DB99210F361840173C6F17E0DDC9A54B41493237FDFD7DC508DC4B8EAF81D48A
            A2288AA20C23A2E544BEDECB5E7CC45C36A55346B637E3AF783BE366A885FB11
            46B1837A5CDDE7513ED0E9EFF279FBE4EAD5FE0CF4A1418253B7D8E43B4A5508
            DC4B8EAF89D9198DAC42549291EDCDC82BDEA67C422D8223B00D4AF5FB2FF9B9
            EBD2676E372F5DEA75FBB43F930F1B34857C4DA90A817BC9F135313BA3E15008
            FE3959EDC9C5E53FAACBBA484A06D1F7262EB03F9144E5298D982BDEBE70422D
            8223761B88EAF75FF23B8AA4E76EBDFB813E8A7D272F15EACB7A9140B12AC66B
            47BFB7FCA7BF5AF0A761817BC9F135313BA3E81582586FD4279F5D5C78B236C6
            0BC528D944DE9B6881933D592529E68AB73F34845A0447820D84A7CFEBCBF65F
            F2E1B6A6FD33BA1B7C0BB4B65CD5EF54EC618316932F2B83647BBDF1E5C96F3D
            BF7074B2F428B239BE26666714B942281D31B2BD196DC577B6B7033D68B1412D
            8223991BDC40F453F5FB2FF970C6F66F92820D8A0A8D538AEA43DF752AF6506C
            F9B2522102F792E36B0A3B232FDCAFB7209D1763A61B200BD9633077773DDD24
            08BDBB225812F33E598D889762E5A5D90067713764AD513F30BB7CC159A94DE2
            B4A6BE88B92731D4798DB6749A260533708C1FFAA32D614620762C647684784E
            E62EE49715C7DD5969CE80EBD3F17AB403008A267B96A03C7EFF3A35B56B1B52
            245CBBA224A790A58BA9B9EAD0426E26B6A3B931DD09180EAA4B29DD25B12407
            F96496C4E22B04F24C7AD6FCA9755F23F007D98B8C4F6FDFBCF2E2BF796AEABE
            7B8E9CF90825E18DD7E71ED98F15D9B5FFE1B9D7DF5C75D5028EBA1F5B6FFD54
            FDFE4B7E17036B772B3ED6DFBE79B3FD2ADBADDABFC473AC56CC108F5807E8B9
            85B4C76682D0F5860C879065F576F9CEF143F32BE0D2329D062EC64A99FAAE8C
            BE2DB2959C85E1509FFC07CED9030ECB1E91E36B82D49DB21384FBB5E0FAF9D3
            0503E38665F3FA8C1F81F022F6D0580B4779B97E27E63D1E3C70828A058D3B39
            5D9F9A1069C9D47BC996A2EF1CA088C540F0458EA14E117825863AA40AD23429
            18FDC9E4C04BB7D2D27E58C254487E8C298C2161B08FE9CE832E39A3F75C74BE
            BC685DE5ACAFDF49520A78954F4CD7A727C21598FB43EA4A4B95C7EFDF54F9E9
            FE6062AA3E3D29864A8D024640CDDB8EDEDBDB38B9D570F41EDB96FEE0142389
            F9245788D3B3D8CE70087AAE795F0BA98AC7C2A72B7FF80FA6BEF2A4D1FB8D57
            E71EDA557BEACC8F6EBCD9786AEFFD8F9E3AEFAA05D4C2FDD8CE06AA5FFA2476
            26FD977C20BD3051A7DB9D0F3F04E596ECDAE3D3DBB76FE545BCCDDCA07DFAD0
            1103C4BA0B32D29403F4DC42E8B199A65AE63904FC6BA6D56F4B78B66D94E743
            8D75DF69CC3456368DD3C0CC0357E6C81629CB64E2A912F016212C5BCABDE4F8
            9A329C51209F00B9F2C2AF3E8565F3FA2C08522731E92F73103CEBBB196CDCA3
            8B6B0BF82F4A4B0BBD47E99DA89F5CE1E7B8E11721E5EED0A18769B20B26EFF1
            A5A3B401D981DA2E60215B478847D1823B93F39971DEBC94085C2E0766162FD0
            BF7E01FA42EA4A4B95C7EBDFC4800D7451CD2CACE1BFD4BC94FEF8FC2C99D975
            54F4967A4F8DC9F7A0D029D3B5A78FCF70CA667A8FCB56BB7A4FF1756C57222D
            FBDA508689F58A5B97575F3EB297F47EF583538FDCB5FFD8EBAB200F6F9A8389
            60402DEC7E475BF1E16C3B0C44F27F7EE34617E3EC60831C40F821AB166B1981
            CCC3E8BCC8A4425471FC7A8171173C1A6EA9F7A1C776496B59DA21BCBE9269F5
            E88D59D719761A1F6398E950BC435786A1AADCB17EA68A25C30F8FC0BDE4F89A
            329C51AA8D3255AD73C2B2B97D169E54A277AFB97D2C40E33E71009B096FEB68
            4637F86EA2F7782F36615FA0487DD12B00939BB91B56DCA902EE40FD68AA1A83
            EBB9D94279F688DEB78E10CF294F9FCEFA7A4AEFE1723C00971D5D6A3D780B3D
            97B037D3E5F19BD7B6907930042D7C18D51ACD95FA48D2BFBF38B3AF36BBB098
            ABF7B3AF5C6043C5EB737AFEC22B923299CFA71325271E973B6EB942AEF83D0B
            B4EC6B0364247BF1B1B375CD48FB3BEFCE1D1C9B9A7B17E5A14CBDE7AD0FAA3F
            10C9C7C7F9056438BDC1F0DDDD4AC91C9A2586703E3DC5711732F2C623D63813
            B790F6D82E814513AE43C0207038B4C8B27A139E4DA66F9B390D2074655E5181
            600482FE8A26F46512D7030ECB1E91E36B82D45D11B4117A7013C1B71061D992
            3E03B2875638BE776E94109A84C1C662B0604181B96378BAA6965C01E92F6ECB
            D099FF8E6464DE72CCE7DF0949377364F77080CE7A9F1521DE161DEF28DB1CDF
            D32303292580F7BFFC87BE0167953D24AB3C5EFF9AC6B157154E8B496A99C337
            E9E9EE78AA3EBDDBE87DFA450DD9D9C294338D85D91AF4D496395DF6F8FE3A06
            EA956B89AF101CDF3B3D0BB4EC6B031457F66264F3DCFF7B7F4FC7F7C1D6D345
            790722F99049F1B9FD9E6E70A72565AD2EC65D24B1D1F188D502E32BB23C367D
            5F68A6F7895FCAB37A1BC8FB67D669043E21EDCACCB300A33C99E37B8E9B1716
            78E07A1FA86601C2B2F9ED4E8DC2B7721CE36E0F9E14D54E62DEEFACBF7AE2F0
            B34B179CA644810469C147E34EA7B237BF8633F9CEC0D79B63912F7E8C9DC737
            59F8F8FC577F63F689549A3BD905C31400E91CBF01905CA374C5C8BD9B0DC47E
            CD14D28B106FBE02E5B3CFEF6F657DDDBF67F4EE33E0EE725F7A5EA8D778BD99
            591EBF7FBDF27B36666E28AD607F86468E2D847605B9ED19A77EA4476B7C167B
            89E25FC7F8551D7BBA66F3F94943C91DA1D3B318B7F7F009BA8168DAD78257F1
            E8C096B9F76B0BF8FCFEC5630F8CE1F3FB8DD74EFE7A19CFEF5B6CBD53FD8148
            3ED0DD3B747DD8A08E52C44A93B80BE38769875FD1B51ABC93E5D5DD914F3B7A
            9F293D3FBDDC788C5EDC23778DA760BD0F9DC6A1A37FB6947665389214D9FA6C
            73A53133C91ECC87B4232C5C9FF53E990B05C0696E39A3A2A2408EB2C760BBF3
            89681A7CDB79D17D6C72E6A479171F64DE440B9E5DF8F1B2772FC61EFCFC12BF
            BD8540475EA08EF1DFCF9F7862FE1BE92FAEECD89730E9F5F8C6EC7F9391C67D
            03DF2998B0B3BEDCB041D7CD5F3302B13B571EDF9352AB3A6DE0BC9F9F15C7DD
            6DAD5DB5DABEA4534A9B80E9082886EC41095CABF3F49BCB8BFD7BEE5CB3FB15
            63A876421EFE4EB7CCDC17C90590BC306F1B93CEC5A7B666EC5EC3902879BC62
            1BCACC0091C54AF7CBABB62DFB9A803FC85E6C78C65B7FEEB51F2E1F7BF02EDC
            BFEFE0E3A7DFC5817EB2C151BB5FD60C36AA7E0F7E113E28C9877CBA88AFD3D3
            6D1466F219B4667117D60F27D68AE68AA6190CCD6D4A22D432D36ED651246459
            3DE9341E907365388D3118E9AD9CCB7065ABB7E45900E23876C4990A35BFBD72
            81C3B247E4F89A207554C45AB6C1E8E5B013F395D65386A5E2A0BE815AB81BD4
            C2EE838AFCFCC68DD6E9DBDF6EF56079BE41493E10D540BF17B7534A3764CC25
            9443E05E727C4DCCCE28CEB2D1FCCC58D67C8BD28A6191BDD219A28AB79070A8
            4570845F2907B50E8E77B795AEFA03947CC82A8627FA7D5B0241C901A727C78B
            2FA59749E05E727C4DCCCE686415A2928C6C6F0E57C59B493ED42238021B2B4A
            D73F0A4F6FA0BB25AAD400251F28B159BAD854EC4784C0BDE4F81A48AD288AA2
            28CA30225A4EE4EBBDECC547CC65533A65647B73182B9E1EE5432D8223767387
            92658EF54B5A9477B0A37C062AD2F5AAFB1D6D507E7D663F5204EE25C7D7C4EC
            8C4656212AC9C8F6E690563C907CA885FB31D802612E51F541AA8B2FD41383E4
            03A8FAA52ECE136C9F5CBDDAA3922BD112B8971C5F13B3338AA26CFC5BB89A86
            B72F4A4F7BD35F18312EFA7C1997E8F15DC9875AD8FDCC2D3D168F4AF523917C
            009AA5C57B91DD6DD0CE90AD9C40192502F792E36BA2D0D4264451B6750D6F5F
            0E3DEC4DBC279BE6408211D2B7CBD84ADAED2B57CAFAD5B55526A805EFB4D832
            A7DFE351FD78241F80CCA1B98AFF5E1FDAB6D3A03B4A9508DC4B8EAF8942539B
            1073D9944E19D9DEEC4FC5033183FD4CF5ED02967CA885CDBCC5D6ECA4E5AA3E
            14A9BB1B9AA8249F61E1871A75F4801FCA06B73E23B2968ED282C0BDE4F89AC2
            CE4882049895D0683D57C854420B14B296B06CEE8A71B8FED155BB543285DF9D
            9A5D5E5BB60BE799A588B2E20ADB058F76D7E7DFDAA480075CFE2431AECDB74A
            2B2AD1EA3AD921F093B3A4700324F3024CB8C41B7D34D4E71BC991706936B7AE
            B2E69B7C72A23BCB11276ABB170CDECD9FA8533C21F9C0ABCFF60F38A1EC21DC
            1A0732A2FB9B2BC92E6BC53573163CE01EA1251671112B5B2193837CE4864A3A
            D7E9B82464751B5D5914C85BF67A463319EB4CF29DB6E3C6B5801AC1B120F366
            5B8B934239ED8441F1AD3BD58F50F22D501DB8310221870D6E8FDCEDF6952B78
            7C6343E7ED478DE67689C041D923727C4D90BA53768298C1B8242139715C4E28
            5883B063C2B21901908F80C8FC8766E97BBB6CAA596A78EB52231D5718172BA6
            150D31BEE1638DF53B2209382DBC876F539AC7CEE705F0C360F3F817075ADE95
            D74C064D59389A2CAB6E4BE8EDD312B07B4CD07D04EB6AD2B91F29673C6390C0
            5C14E3B43C24EB3DCBB97BC630DB7EE2F7269510A0650AA9EC397AEFC4F8811E
            D9039F2921E83D0603A4E388CDC134D4A6D17BA7E3F04A38C4111372BBB23850
            54D9EB0DAD050C4442D2E5621A5C3EFA402D829C5B6CADEF3340D506ABFA314B
            BEA204785E3145E05E727C4D19CEC851145C48684F7DFEC7EB2B27EB933CD6EC
            9EB06C19FE889CF8BE5A4DDED5B2259150422BB8AE51B2983F2D8D07BA726571
            669F33FD60868078B392F2F870E3E2064B0E1672C78F7EC43CA4450025577DDD
            7D1AB39A0F40D0C7E66393E8CE00354E180C1EFFE09E25E7D2E9297E6F52A95A
            47F7A71A89DE633883695EE91A3BB1767476661F256CA6F7B6A18CDEA77BAAAD
            AE2C81324CAC29ED4857BBA37CD3E0F2D1076AD191487F72D5346C1306ABFA2A
            F9CAB0E079C514817BC9F1356538234F5178B9599CA04E22FF77495836AC3766
            8DD8B9689C489040295C12494031E8C2964245475D31016678165DF41EE7CCC3
            6605196E1D023FD41BC26B102837E49FA7F74ED908A7AE1894DDF928D3064102
            E3ACFD60F098937796F05B7D044E297B0897AA65747FA911EBFDEC92C439BCB5
            3A0FC2BFB4249572E6F3A9BE4E05B9A1CCCD9CC98DB226C223995D59025014D9
            2B9BF645AB2DC94FDA2EE3611CD7A2238586C4FCDD16B0EAB72FBDADB75B9DBC
            A6AE92AF0C05AE4F4BAB2A1C953D22C7D704A9BB225194E4675138D3EE0C9EBA
            222C5BDA65D3F87E62BA3E2DA1087C0585F27871D8ECF85EFE6EE2A55E6149A0
            D8A6C95F11FE319EC57D162009DA1DDFBB7724A684EE7E9BE37B3FBAB393C036
            0E55D90483C73F786D127EAB8F40FBC91E624A850DE847F7B7FD656A2465DEA2
            966F7C77B636ED44346E36BEB70D65F43E18CD03433EBEEF48AE2065FB72458F
            429C1756085B8BD2251F80B26D5DBBD67FD557C95786079ACC76E48C09DC4B8E
            AF29C319258A42FE9AF49E9E8527A106BB222C9B1100F9C88E096F2F3651F5BD
            E7F70674E2A9B8C2F02D7E714F6E4A44EF49129CD8F9879E5E58FA6672BB2001
            8E9C10F84EB0793A5902DD58B80192ADAEB8254CF6DB7F7E6FE32C05099CC671
            83C1035E9B84DFEA237E6FDA5279D1FDA97661C86A5366794D8F54DC7EBD99DE
            DB86B2CFEFE9A98A3CBF5F5F3A317362F96A3B5D591CBFE2E5D09150F1D6A6F4
            02F61D11F94CB8B5E885E403E5AA7E9BCBF3A9E42B4302E97D2A2E6BE05E727C
            4D516784B3D096C38DD5B7240630BEEFCC2FC3770F64227B0CFA72CE1B006D5B
            5B9E9D128D14E57EDFD536427E3E405FB17185ED8F08C257B89DD0E993338DD7
            B362E7AF408EE960F3299C00C9E3FB6AFB0E98D7EF43BDA71440D6FBF94E4D9C
            8F520C3758BC79835F6E86C85F7BCF386C4E5E133AF9F70138A1EC214EA97812
            45EEABD221AB0309E771A7ABF7B642CE6440D2506F5D369D4B32CF79EFAECF3E
            8FF3D56D756551206FD92B892EC41E36F88A7CBF097CD910F9D3863D927C8055
            BFACD567DB517D957C256248E6D92EE921B51C36048699E36B82D45131A0B219
            5D978F6540530B66C03DA2C47CA5F594722BDE9DD8C3D691E8A649D7A27792CF
            804EF74DF555F295212530CC1C5F13B3171E44D968D65797D2EB01315F693DA5
            C48A772DF6C5252AB316BD967CA06FAAAF92AF0C238161E6F89A98BDF0C82A44
            2519D9DE2CABE203147BA0592DFA20F900E8F4ADDE87DD53C957868EC030737C
            0DA456144551146518112D27F2F55EF6E223E6B2299D32B2BD59BCE2831DD933
            AD6BD19F513EF3E9EDDBC5C3CCF09639D6D751BE3244048699E36B62F6C223AB
            109564647BB360C563107B20B716FD947CA0C4E5F9D2AAAF92AF0C0B8161E658
            69CC5E786415A2928C6C6F16A97824620FB4538B3E4B3ED03BD557C9578682C0
            3073AC34662F1C45D9F8D7E1B5271797FFA83EDA3FA82B484F7BD3ACBC54FE6A
            39C5E9BAE2F1883DD0662DFA2FF900A87E590BF5B8AAAF92AFC44F609839561A
            85A636218AB2AD37EA93CF2E2E3C59D31FE915A387BD89F764D31C5A3742BAAB
            7854620FB45F8B81483E00B52E5DF555F295C8090C33C74AA3D0D426C45C36A5
            5346B637BBA8786C620F74548B41493E80AABFB101821D9CA58B8D555F255F89
            99C03073ACB4B01796056B33962CC5A56A394D978465F316833DDC58BF6A83C7
            9840F86BC90AB566355628D1C970895FBB68EBEEFAFC5B9B36A48A9B78BC3EBB
            B04A4B8AF2B2ED4EF8909DF5E59333721A7396145BEBCBA7666ABC0C22AF95EB
            AE9E4BD4E71BADD7D3953F99D572A589F96F66EDD8B1715951981692AD7B91F4
            ECFAC1805B9E12BAA60BE0C4B287706B1CE0413995D9C4CBC9AEE618063E9032
            CB42FA94D05D4FD7E4201FC3C5929D8E332DD056571605F296BDF61898D83B6D
            975E6B198EC95E7B0C50F21990EAB2541F6F20D6D682E3CD36957CA55402E1A0
            38230E7048F6881C2B0D5277CACEEAFC81FA93C78DDE5370367C8C9A1972A353
            C2B21901908F80C8FC87A97839B4E630EC6D61D81E8997B37379F1E8A417E36E
            F3ADF9FA638DF53B265E0E25A648A0183AEFC0097279180977BA3E3521CBD153
            CE12648562BAA443E6E3A9A0FA12B896A2F0ED31CF026C09BDFD0EE2E5C88744
            08C7B8009442F4DE648AF75EB513CB509DB03C13252F18DC067E6F9A8B98C23F
            504572F45EAA89408FEC81CF94B069BC1C7305DA78394EC7E195706876F95A3B
            5D591C28AAECB5C12047F6A6C1E5A34F47B560062EF900AA7EDB52DD62EBA853
            54F2951E40A1C5061C2F0749740B3D86043E091D71178465CBF047E4C4F7D56A
            F2AE962DC9F5957910B8F91550762780A089877B0583C42711BECD101063FFA4
            3CFEF5C59989A38B6B0BF82FE4D35610D58C78B859D1EADCFD36E3E1DA0F4608
            279E98FF069D8B3E787A0F608019488981E09A94A77FF8BD49753FFEAD6F5063
            62995BEB3D56739AEF51B0136B476767F651C2667ABFB3B972B2EEEA7DBAA7DA
            EACA1268DFC4063C8D6F1A5C3EFA74E72862907CE0D3DBB7CB5A9EAFCD4D255F
            291B1C79A6DF210B0C33C74ABB33631F47B738308C80F2C329BA03B2903D06FD
            11E76C83BDB2A479B1E02401851232DE9F5202A8E8341F2281D178165DF4DE9B
            331740869F38803263DA3AF48999B735AE9003987F9EDE3B65239CBAA654DC94
            410E5E831638307BEE79F810A694E25D685E9EFE0135913D84EBBE740DEE726A
            27CE2D1ECFD3FBD9A50B7CEB766B751E847F69496A041534ED4435C2C4F299E7
            33CCCD9CC98DB226C22325DCA166024591BD960CFE997DD276E3CEDDB0D0662D
            D24422F9409F555F255F29119A3B4FC6AE96C03073ACB46B337608E48D08064F
            5D11962DEDB2697C3F315D9F9667076149823632E37BF93BCD6C432125FEFD96
            FF57847F8C67719F054882CC4161C6F8DEBD23312574F7DB18DFDB8A98763069
            287F6C84611BDF4331B101F74CD7A7C6ADDE37ABE616B57CE3BBB3B5E9F9D5AB
            A6E99A8DEF3F36EF7618BD4F5F90C191ECAE2C01BFE2D90C5EEC1DE85188F3C2
            0AD14E2D9A118FE403D0D41D95A7C8A692AF9444D3A8AD8161E6586911333638
            BAB57969159F86D2747AD6CD484784653302201FD931E14CFE26AABEF7FCDE80
            4E7C429EDFD3DC03BEF605DFE217F7246ABEE83D498224C607EA879E5E58FA66
            72BB80DA0977151FA358CA435F8AA34FEF2BD0C912E8C682C7973B9BAB8D193C
            0B7BCF6CBDCF7D7E4F67E71F04D293662A5592062B826FB0797AEF3EBF0FCB63
            DF27E81F7E6FDABAD34329F81BDF69B5AAA6BCA6472A6EBFDE4CEF6D7FD9E7F7
            749723CFEFA165664ED06D506E571627D7C4A2127BC0BCFAE03DD8CAAD456BA2
            927CA0C4857A5A6FB72E5F96532A4AB718A5CBF04E8161E658694133A65968CB
            E1C6CAF333FC0E785664FE4E816C648F415F4E992320FC6BCBB353A291A2DCEF
            877A6F7E3E405FB1EFAB9373C723E12BDCA4BB9C7872A6F1FAB2372C367758F2
            2C80A8CD9C5CCE7CA9FBFAEA82FC50616C7C5F6DDF01F3FA7DA8F79402C87A3F
            DFAB89FD4D41F226B99386DE63A01F11388DE4BE9FEF942775AEFE0027963DC4
            69079E4491FBAA96D54409E771A7ABF7F69A70E73C205FEEAFB72E9BCE951B20
            4CB9BB3EFB3CCE57B7D5954581BC652F8B78C49E649EDB022EFE15771A0D685D
            8B76884DF20156FDEEDABFFD6DEBDA35399FA274839DADCC2030CC1C2B2D6EC6
            BD6340656B3A73D23DFC5A43DFA7D0A322E62BADA7B4A838E84D5423FB1694D2
            7D114A3E002D59D6423DCDB64F6FDF9693294AA904869963A5317BE141948D66
            7D7529BD1E10F395D6535A54BC23FDB3DB409E0A97D57D714A3ED053D5FFE4AA
            F73284A29445609839560AA91545511445194644CB897CBD97BDF888B96C4AA7
            8C6C6FB6A878A73F0F1BE0FBDEE5765FB4A37C4B59CBF3D94DF2559452090C33
            C74A63F6C223AB109564647BB345C5B73636025568B10D50EC81D2BB2F7EC907
            CA527D7D4B5FE9118161E65869CC5E786415A2928C6C6FB6A838E877FB0F8C07
            A5794C2FBA6F28241F28AEFA9083E4A528A51218668E95C6EC854756212A49F4
            BD496B372551794AA375C53FBD7D3BD08616DB0035AF47DD372C920F74BD3CDF
            608BAD549BC03073AC34662F1CBD42281D10796FE2AFCF27716D22F95C1EB915
            87C15FA0102DB6418947EFBA6F88241FE854F555EC959E1218668E95C6EC8523
            5708A52346B637DBA978FC92DFD3EE1B2EC907DA5C9457C55EE9358161E65869
            5133B60172C60FCDAF5C7796AECB08B9D12961D9DCA5E378415C3CE2ADB04BAB
            E5EC318BB599AFD09AB2B29E1D2D7A93C4B9B75921EEA278BCB89BB3049E1B1F
            1D177AB3417AE4244D02B4DB8FE182E4A30634A1EC59FC660C7AD3E96DDB926D
            74AE97895D868FFBD15D5681B2A225F9BC35222507F964AE8DB546FD00E5B9B5
            BE7C6A06972EB67F4A8E2461F57DE00FB2D792C14B7E568B5BE098ECF586A193
            7CE06F7776F0D17E56BCDDCDF7DEDBBE7953D22955C6D108F42757FC8F9B8159
            9D3B977CE215D0251B0B4669E7355E77D7E7DF02A7D3D22E43C3CCB1D2207587
            6CAF371EA332C9827F1FE1929CE0193F360BDC1652B8B06CD695D30AAC58737B
            C402123231559F9E94534B5361685C116F70E81CE73E088ABFC3F1D17951555A
            641EE3DF5BC1A0BF4AEC61D46F0CD2C3117293FEB04B8EB396B82AE546D01F51
            C2DE4C3563D2BF047E0AAEEE763AD7CBC4769FB1491B3D9A6E351CBD77E224D9
            1CE83AA1CC45EF69C5590E4380CBFBC321B82CCC11B8895C385A9B48AFCC98AA
            7853062CF97EFB07B45F8BAE1946C96776B6B7A1EFB6AE5DFBE4EA5528D8D6C6
            C6007F49A1F417EB64323F36372B94C8E930FC7A028D122923CC20F0840E8161
            E658694966CC21E016D6A088E25253D5EE9CB06CB6E1F00E881C71D894242154
            0C11574A707C7E96C2DE5C47A75F6F5CCE0C9A77F9ADAC807EB61612509FAA06
            FA7D6066F102FD8BE9A93F9A056867957222E88F2AA92B2D6CC6C030A855DD0B
            A8ADCE6DA1F7146E9F0D0C2ED7E9DAD3C767386533BDB79799E83DC5D7815348
            3A802F7B7B1B478B337A09908E4C6C9092EFB77F40498E2287E1957C65540994
            2E257CD96645DEACD5DBC1C9081333F072F4080C33C74ACB3163BC55990287B8
            9E1DE8BD4BC2B261BDE118601E16844D091272181D3A4A2C45139204EF2FCEEC
            ABCD2E2C9224AC05CDC7EE7EED9C6465CF8269B016F40186821C488DF4FB0074
            43D261DC1F4D02B443323F823E9D73048126943D26D58C416FDA7E30B35E6D75
            6E2BBD9F7DE502CB3306429C9EBFF08AA44CE6F3E944C989C7651248F41E67EA
            FC4B3AB8C831F05241BD070626F96EC59BC4BFDFBE79B3D7E357957C65A87034
            02870D1F271F39689CE3C812E79004E376BF0E400E9BB4A63B2013874E06F981
            AC727C4D90BA1B7018F420C75A05DFDD8FF1BDC53FE204F802689AD724C031F7
            F8547D7A37B4783BE37BFC1E96DED422793C41B75D720A00E7F025716680F674
            04FD5EF9C9D881DACB1E92D18C416F9A2EE04FED762EE9BD7D55C25E84B2B385
            29671A0BB335E8882D73BAECF1FD750CD42BD74932BE7746F340F9E37B66B013
            FBD4D419F1EFDD52DDBC7469678BDF7A291F957C657868A274E4F9D139F86E8D
            7085B2193B9B2B27EB5E586AF2998E7231817BC9F1355D3823178A13FF65FB22
            1B692778C68FE95966CF9EDF5BBC23AEF3350D6A7D3ABD610019A23BCE0C8A2F
            CFEF258C2F668C7D68FBD264B86DEFCB00187162243D3C0926A234A045580657
            604C0FC1C03415567C74F07A33B9BD05A41983A733A60BF853DB9D8BB9EDE177
            279D8BD0F623FE758CDF9DB4A76B369F6F0B669FDFE3E56D9EDF2F3D7BF804F5
            AF1CA1773E6A7BD253385EC5DB6680924F7A1F5EA8508BE0A4B04121E5CF65A3
            92AF0C092DF43EF3A133FFA9661C057E1D7D979038223243F78BC90CBF0B7C47
            F6881C5F13A4EE109AC04C80B25EC3E7DCB89FFDAE7247402EB2C7A41B0E8FE0
            C9905DFB6AFB9C3B0C16573B672BCDC7629C19141F52AC2F376C38740E12EFF4
            2565F8CDC6EF3B7303223C17968C32611A3740BB9940A6D48E7E8C22D0A6B207
            0DE7DE0679FACD8D8F0F53F045566B46DEFD41EBCEA57B50FB82AB5C84B61FE9
            5C7C6A4FEF0D90E88EBDCC4CC17644EFC1E46C78FEF1FA8905BC35747ED321D7
            0C95D001FE207B1DD267C9E736948AF8D3865012381A9C9137957C65B4F1F53E
            99D06DF6D01944C54E1C66E09821BB2F672AD40C475DE0B0EC1139BE26481D15
            31974DE99491EDCD22151FE028DFC265805AB8E77237957C451914817BC9F135
            317BE19155884A32B2BD59B0E283957C7B76A8853D4B7A53C957948110B8971C
            5F13B3171E5985A82423DB9BC52B3E28C977CF0BB5B0FBE96DF3BDF776B66546
            B37454F215A519817BC9F135905A51144551946144B49CC8D77BD98B8F98CBA6
            74CAC8F6665915EFE7283F7D2EA8457024BDC9977B838EF215254DE05E727C4D
            CC5E786415A2928C6C6F9658F1FE487EE659A016C19160BB79E9927CBF67A8E4
            2B4A40E05E727C4DCC5EB8CA0AC13FDBA83DB9B8FC47F5D40A2D9524FADEC4DF
            BDF43FFE7DA7F45AF29BE50FB5088EB81B3EBFEFD9F23B2E2AF98AE212B8971C
            5F13B3178E5E210AB0DEA84F3EBBB8F064CD0BDA566522EF4DFCD9EB80E2DF77
            4AEF24BF45CE508BE088DDFA26F68C4ABEA25802F792E36B62F6C2912B84D211
            23DB9BBDA8782F24BF759E508BE0086F7D167B46255F5198C0BDE4F89AA2CE28
            8C7F0F47561766EB1CC8AF2061D9DCD5F4307F7F6123841644F322CDA743DA0B
            4E66BC8C11E626076CCA9DF5E5933372D41CE42F368B769F1D593FC967777DF6
            798A44922E6A7E24F5A1066A257B165C264FE3DF7749B9922FB9BDF9E2BF3F32
            75D7DD475E7E27CC016A111C816D2062CFA8E42BD527D3C5C9DF84C0BDE4F89A
            62CE288C7F8F91C70E1C3A7EBC777AEF2E4C68BDB9059CB81B699E97C40F42DA
            5342CE8CBE4CEB1742B636FA995DA698BFCE61F130DE79CD46C781926546BBA7
            35939B44D6A7A510F1E021AA4250542E464E24F5A12675A5E11D8FC6BF2F4259
            922FF9ACBE30577BF0C9AFB6ABF703147B46255FA938992E4EFE2604EE25C7D7
            94E48CBC4061199EBA2BC2B279AE1C48E93DEA8113693E5874DDC714D2862132
            11ED6CA87B2F340EB873F8B8BBDE58A32F6647BBF7A2E3F09F5048DE6FD47787
            321014B5BD486B434DEA4A833B1E8D7F5F94E2921FE4F0D19923F7B4A1F70317
            7B46255FA932992E4EFE2604EE25C7D794E38C24FEFDC7FC29E5A9BB242C1BE6
            0BC708AC76A0F7A0077EA479EBB8ED179DD44E661C1D84EE9E181ED3DBAF0BE0
            F4F718BDCF8E768F9156DC8AB390D8C8FA09A9A28675C98EA43ED440BBCA1E03
            773C1AFFBE0C8A487EFABBEDE87D2462CFA8E42B9525D3C5C9DF84C0BDE4F89A
            129C5112FF5EC042FA7EB13BC2B279AE1CF0BD6D129888480DD08352A50A6972
            B3A1EE83E9016F7C9F1DED3E7B7C8F91F5F18B7C1049177567D4C6F7F48C83AB
            8FD0C311BF7F830E72C2460134C165D253B4BD4AC5BFEF94EE243FF35BB97A1F
            95D8332AF94A35C97471F23721702F39BEA6A0330AE2DF3381A7EE9AB06CA6F2
            F2D1D77B6A11A3B5F8741624E47AF2E03C55AA54216D6E38E2A4E7F7E4BEE5F9
            FDF5D5C6D1DA380E2BCD172919280FBA7BF35DBC274847D677F2D9595F3AF1AB
            BF31FB44AAA877E8E6202792FA50E3F5A6772F0503778D7F5F944E25BF59FAD6
            7A1FA1D8332AF94A05497C91EBE23C02F792E36B8A39A374FCFBF71B753BE7CE
            D3B0DD0359C81EE3EB013B713E139CAB56DBE38CB48CA7CE08692F297C39019C
            BB07A3C1F25B03FEB6BCF7E77C1193B9D1EEE158D3C8FA4BF22B013CD898FD6F
            328ADA4624F5A1066A257BC1CD99A7DF5C7D7CF2126DFCFB87B823FFFBA7FEEC
            95959B977EF2FAC9C70FEEA2EF8EED7FF499C6BBABA828372F5DBA75F9F22757
            AF6E6D6CC01FA8D03DA723C9CFDA5E796EEA6EAEC9D8D8DD07E75E71FF0A87A2
            157B46255FA91A8EE4B92ECE050C53F6881C5F13A48E8A98CBD639563CE4F3A8
            31ECBDF9E9EDDB201220E48172E46EAC94B7AF5C013DFEDB9DDE767F61C96FBA
            412D62167B46255F193502BFAA7A1F053415ECFE6A7FE418DEDE0411ED42E6ED
            0615773FF65AF87B21F970BF322CDDA792AF8C148161E65869CC663CBC0AA1A4
            19C6DE2CA8F4BC41C58323B0818282D8F428667CB992CFD3F843D47D2AF9CAE8
            1018668E95426A45511445518611D172225FEF652F3E622E9BD22943D49B5B1B
            1B30A80D06825D6F50F1E0487ABB75F9F2A7B76FCBE94BA2F8289F47F69CDBD0
            1963FBA37C687CF98EA20C1B8161E65869CC663C742E4669C150F4E6DFEEEC74
            341BDCCE06150F8E34DB4078CA9DE12F22F9AED803C3688C6D76A5EABD32BC04
            869963A5319BF130BA18A519D1F7E6D65F7FE77FBAE7FFFECD55FA415D891B54
            3C38D27AFBE4EAD512DFE6EB4EF203B10786D418DB917C682249AD28C3466098
            39561AB3190FA98B513289BC37B77FF627F55FFAAD97DF5C0DC4A0F806150F8E
            E46E20B7258A50A7929F167B60788DB1B5E4DF5C5BEBF58F2415A57704869963
            A5319BF1F0BA18254DCCBD09F20622172841591B543C38D2E656E2F47E47927F
            FBCA15F99AC3501B6333C9BF79E9928ABD32D404869963A545CD388C7F4FEBCE
            E2E7DD1427B71061D970B121CC1AC1C5D29C15F1045AD3A6E3F8F776213C6FC1
            3E592A5F3EDA95DA32E29D67255342A07564CF82CBE40D3EFEFDCE5FFDC94139
            CFD8D8D4DCBBEF9C79CAAC3277D7D4D77EF0DADBB4F05CEDA9336FDEB8F8F6BB
            67661FDD8BCBE9993F2547C6C6EE3BF8F8695E5FCFDDE00FC191F6B71207FA6D
            49BE897FFF171F84BF52835AC8DE7092967C18D9F7E8F7908A520E992E4EFE26
            04869963A5C5CC3815FF7EBD71A87E726513A4D8C61AE99EB06CBE1E38DEDC02
            4EBCE3F8F7B2D82DB629061C7433B469682D43D286AC78E7B80E6C928C16E255
            52A4AE34BC391B78FCFB67CE5DDB3CF70707C70E3EF7DA3BA204A8F77B51DD57
            5F7AEEC1DD0F1C7B61C3E8FDC6AB730FEDDAFFEBA75EDD00993FF5957F70E4CC
            DF24472E6EBC76F2D7F7DE4DE93D5D81D3B81FBBD860C05DCA303447F2FDF8F7
            2090F235026A217B43CB2757AFDACA96D5A48AD243325D9CFC4D080C33C74A4B
            32E3205058B0407A978465F3F52043EF510F3A8D7F4F1FD0FB43CE61C05393C6
            C6C8FFD8AFA6C4435B0B93A9DE6790BAD2E0E66CC0F1EF7FE3DECF3DFDDDB76E
            BC3697ADF76F7E6F6ECAD5FBF3AF1FFB024E0018CDB871F12770E4AE874F7D40
            1F37DF7BFBCDFFCF3F1AFBEFFEF0BDCB9761EC68D294A0F7B0DDBC7429FD4CBD
            0B7247F96EBC1C57F24B72140306DAF0D3DBB77558AF0C07992E4EFE26048699
            63A5E598B11FFF9E82F94CD56697AC3277475836AC3C1C23B0DA81DE831E7418
            FF3EF9C8B1ED2F60830A1830CD39611223DFCD83E39DA3DE9B646E5C60C5055A
            47F618B8C71A68FCFB3FFCF17F7A9A751DF59EA12031C97CFEAEFD8F9CA4F979
            D6FBD75E3EB2F79E23673E32D278F3D2DBAF3DF9F7EFFD9D3FDF12FD08E3DFC3
            0812D40532BA75F9327FA5E056CADC7E6BC90FE2E359C9875AF08EA2287D22D3
            C5C9DF84C03073ACB404330EE3DF5F5F993F3CC931618B1196CDD783707C5F24
            FE7DCEF85E3EA6A63182F1BD79A8217F553CA04F640F1970FCFB5FFEFC37DF78
            E7BB328ECF1EDFBF71E5CCE3FB773D72F68D55A3F738BEE7D13CE8372D8F937D
            3D641A24683F08EDED2B57E42CDD6E20C0C527A25B487E3A1E2E4B3ED7425194
            FE91E9E2E46F42609839565AD08CC3F8F7F82CFCCB874A7A672D2C9BAF0781DE
            7B4F1050BF4142DA8B7FDFC6F37B0B85BD09E39DDBE7F7E6BC3A9F9F81D79B03
            8E7F7FFFAF3DB79CCCDB379BCFBF78FEECC3F77BCFEF5F3CF6C0D8E77EF3FB3F
            2D12FF1ED47AEBDAB522CBF297F213B266929F19FF1E243F344645517A4DE212
            E38C7FFFC3D34928F1F8E3DFF3E1ECF7F34D24745FEF41D2D351EA1D6532E7E5
            B48A03B497EC0537679E7E73C362EBF728FEFDC72FCCDCB5EB5770D4EEE9BD01
            A4EE2756EF573F38F5C85DFB8FBDBE2A7ABF75ED0AC83CF7FE78FDC402DE4766
            5C0F01F007D9F301C5ED5AF5337F22DF2929C9876AB68A7F2F5F1B2850EBE2F7
            3A8A321C3892E7BA3897C03073AC341233CE24E6B2299D12436F76FD3BFB22FA
            DABAE25DAB3E1469FBE64DC9A55B5A4CEC071BD4C27D7D6F204001B830E52E41
            A828C34BE05E729C6CCC9A1A73D9944E19786F762DF605E7CF732BCE33FCC149
            DBDC40B025976E6953F2A116F0EF0025DF8A3D6F65FD604151869AC0BDE4F89A
            983535E6B2299D32D8DE1C94D8036D567C677BBBBBD7F8B73636248B6E6947F2
            A116BC3310C90FC49EB722932E8A520D02F792E36B20B5A2288AA228C3886839
            91AFF7B2171F31974DE99441F5E60047F64CA7158702BBCBF5B4B9151F76B71E
            E5432DDC8F7D1BE5678EECDD4D47F9CA2813B8971C5F13B3A6C65C36A55306D2
            9B03177BA08B8AC3A973752EBDF554F2A116C1913E487E9B8D005D5C566729CA
            7011B8971C5F13B3A6C65C36A55306D29B9DBCFAFEF6EADC97EE79706E75B54C
            B107BAAE38A86FA7372BBD937CA8457004B69E4A7E9B62CF5B664C3F45A93C81
            7BC9F135316B6ACC65533AA5FFBD0983FB40155A6C180B67FFE32FBFB95AAED8
            03452A8E73FB1DFE5AAF47920FB5088EF0D623C9EF48EC79D3597D650409DC4B
            8EAF895953632E9BD229FDEFCD4F6FDF0E2421772B5DEC81821587F274FADE7E
            2F241F6A111CB15BE992DF85D8C3B675ED9A7C5F514686C0BDE4F89AA25E3888
            7F8F6BE99BA5CDE28E7F9F19C93E3C052EB0279F521174F02B6B4BCEDF114C43
            ABEC3961DA15025A47F62CB84C5E0FE3DFFFEDCE7513E1E64DD8191BBBEFA1B9
            974CB0DAF3671F860B35B5BEDE43DFA11CE4D378FDD9255C7871AD513F407926
            D78CF953D655E4037F90BD02742A815D6AF0E6EAC26C7D9C9A3B907CA885FB31
            D84A94FCEEC41EDFDAD3A8774A25E115DFC10259647D02F792E36B8A39A354FC
            7B394EBAEB4B71178465F3F5C05924D5027AD06EFCFBCC48F6C112EEA933D201
            3AA51BEADE1E1440C6DC30ED0A91BAD228325E8FE3DFFFC5D7F6397A3F36868B
            E39242BC71EAD15DF0D95B3F5F04C3E6801198F650E6A2F7CE35B3B5BEF8241C
            822B2CE32AA2735B5215EF92AD8D0D57E172B78E35786765FEC0A1E3C745EF01
            57F2A116763F732B45F2BB177B9DCC572A8A597D7C1BE3AD1F1A787C3C240814
            46423B39BF9A1AEB744458365F0F32F41EF5A0CDF8F74D229B05A708CF6845C8
            0B756F0E72129231374CBB42A4AE34B839EB79FCFB1F3EF3CBF7FCE67759EFEF
            F9EAD3BFB7FF8B732FFE84E2D67F71FFAF7DF5513F5E8E4CE6DB1C70B2CAD5FB
            ABA9F0774DAE22F92894646248B397E99A6D5D4C7107CD6ECF08B5B0D936DB0A
            4ABE8ABDA26480F3A01C903D83C0BDE4F89A729C5112FF9E5C1E22839E228465
            4357447903E85503BD073D683FFE7DF05D13B93C38457846B7084905F1609217
            9CDD0FD3AE10D064B2C740FBF425FEFDBDC7CF7DFCDE5B34B1FFC7E739A0EDEA
            0B7320FCDFFFE354BC9CBBA7BFF9977FBB75DE9C78BC26619D59EFC370C94DAF
            22F9284046B2570620C01DBDB40FE9E59BEDE15FCC084B3ED4C2CDB6D9D6B5E4
            ABD82B4A137636579F9FADEF1E93B96A8FC0BDE4F89A129C5118FF1EF086BF5D
            1396CDD783D0DB7616FFBEE0F8DE7B7EE1E6CC518C0C3CD5AC20D01CB287F435
            FEFDD6D6B5577E131FE4FFCD8BC71ED8F5F073278FECDF7FECF5B7B3E3E1DEFC
            D9D9DFBDF7976797AF6F2E9FA8C9BB02C9F8DEB966807E8FEF1950B8DE497ED0
            EC0CE400B508B26DB67521F92AF68A92073E43341E2921702F39BEA6A0330AE3
            DF1BC83B7B4AD90561D97C3D08F4BED3F8F79991ECDB7F7E6F4E11CCE7BB0280
            23D7E20F352A83D79B7D8F7F7FFEF8E768629F5FD3DBFDE8A9F32DE2DFFFCE2F
            FCE2EF9E87539982D9E7F7C935D37DFCFB52E848F23BD245BFD913A01641B62D
            B68E245FC55E519A432FC9E18BC03BCE082421702F39BEA698330AE3DF7F7BE9
            B4198465BFABDC11908BEC31BE1EB0DEF3C9C63A8F7F0F8A9D11B93C38057EE4
            04001E77BCA11503C7456686692F36C95119A005650FDAC9BD39F3F49B9B1A9F
            BC941EFF9E26F62F6248FB5D8FE4C6BFFF9DB32B7FBBB36DEED844EFF116BBBC
            F8F705E958F2F35F5F876A261D40CF5012E0104FECB7B9B529F92AF68A9243F2
            23B8E02766081C963D22C7D704A9A322E6B2299D12436F76A49165FD16BF7715
            EF6775B816E54ABE8ABDA21424702F39BE26664D8DB96C4AA744D29BFD97FC9E
            56BCA3EA145974D6D6A22CC957B15794E204EE25C7D7C4ACA931974DE994787A
            B3CF92DFEB8A7724C09F5C35CF443AC4AD4571C957B157945208DC4B8EAF81D4
            8AA2288AA20C23A2E544BEDECB5E7CC45C36A55362EBCDBE8DF2FB53F1F6C7DC
            DD8D92D3B5E86E94AF237B452991C030737C4DCC9A1A73D9944E89B037FB23F9
            7DABF82757AF06656EB6755197CC5A742AF92AF68A522E8161E6F89A983535E6
            B2299D12676F3A929FC4BF77C5C6DDBA93FC7E56BC7D41EDF4417EB35A7424F9
            5D6C2AF68AD282C030737C4DCC9A1A73D9944E29D89B055F9A6B014BBE8D7F1F
            E84DB0953532EE1D50C2A0CCCDB6ED9B37E53B6DD0A216BD937C157B45694D60
            9839BE26664D8DB96C4AA714E9CDAD6BD778140E62D60B017046F9F95BA792DF
            E7CB18CA76F3D2A5A0CC991B54B9FD8AB4AE452F245FC55E5172090C33C7D714
            754641FC7B8496FD8323A985C43B252C9BBBDA1DAEBCE6AF9F8FD04A6DEDC5BF
            77329355D89CB5F39285F68264E980F7A71B4FA7BFE5E66E02A503E9E28D10D0
            14B267C165F2DA8A7F4F316D41036835DC5DBFF21FAFD292859CA279FC7B3E48
            9DC34B31EE7616BBC5657779CDC4CFD61B7539CFD8D8D4DCBBB8EE9E7CBA6BEA
            6B3F78EDED1B175F796EAA862BF15D7CFBDD33B38FEEC548BAE30FFD2FFD8C7F
            DF11EDDFBE84BFC877E2DF07E4D6A25CC957B157946C17277F1302C3CCB1D262
            CE282BFE3DC6CA9BACD7334AD62961D97C3D70BCB9059C78BBF1EF3133FA322D
            C58AABDEDA23E6CF782E3F999CDD4D99F9AD642789A10E04C51B2D52571ADEFD
            B48E7F7FEFBDCFFCF9CF9CD9E9374E3D7AF7E70F7E71FFAF3DB78C6280E92157
            8A9DD396DE531425D663BAD570F4FE307C5364D2AEB3BBFAD2730FEE7EE0D80B
            1B46EF71CE7FD7FE5F3FF5EAC6C5B77F7AFAB17FF8CCF97EC6BFEF88F6D53799
            D54FC5BF7769A7166549BE8ABDA220992E4EFE2604869963A52539231BCE0484
            7FAA36FBEA6A5660D04E09CBE6EB4186DE83136F37FE3D65865F4E42F99923F6
            CF78AE7432E7BB2661EA5BC94E12433D55BC112375A5C1DD4F4EFCFB7B7EE19F
            BFFC8E9581D50F4E3D72CFC327DFC67F4F7D009270EB1CA46F1DFFDED5FB89E3
            DFFAC6E434F5205CAED3B5A78FCF704AA3F7F00594FC77BF2B7AFFE6F7E6A65C
            BD3FFFFAB12FE0048091A59B6B17DFF9C3FFCE89DAD0A7F8786DD2E6EBFA20AE
            EEAC3EB69FBD9E1DDAAC4571C957B1571481BC59E8E2E46F42609839565A8E33
            92F8F7D770261F271FB6320381774A5836AC3C1C2330F340EF61BCD87EFC7B37
            33199FE1919472BBC9661A2B2C236ECACC6FD10E7FCBC6504F158FBE313A405B
            C81E03773F2DE3DFDF7EF9A97BB809C7EE3E38F70A4DE61F9C7BF12734CAFFD2
            73AFBE0DC2FCCCBD9FCB8D7F4F9DC33BAF5CE0BB52BC119C4EC2ED24F3F91824
            066E239E96F9FC5DFB1F39F92EBEAECF7AFF1A05D1E7270BBCBDF9E7BFF58BF7
            3E73DE5E537D887FDF116DBEBB677F1C0F78D7B343FBB52822F92AF68A9220DE
            CC7771F2372130CC1C2B2DC11925F1EF837079451FE14306B2C7F87A108EEF3B
            8B7F6F3F264F22F0880DDA66CE157C8B710F667ECBEC3831D4D3C51B31C1874A
            CB1E921FFF7EE3CF1EBFE7EE23767C4F73E9921A941887DDEF9C79FAEEBDCF9C
            BB961BFFDEE83D85AF1D9F692CCCD6241C1F9DCE19DF23DBCB701BF1F477DFBC
            72E6F1FD1C49CF19DFDFF5F0A90F127DFA091EF995D31B323E8E6B7C0FEC6C6F
            E3138AA4C04DB74F6FDFE6AF60FBA52E78A0A35A7427F92AF68AE2615CA2E7E2
            E46F42609839565AD01935897F9F3DD0E994B06CBE1E047AEF8558C5A7B32021
            ADE2DF271F25F11DDAE157BAB6D6179F649DCE747FDEC1AC6F394585D13C86CD
            DDCE28DE68C5C9F57AD37BD4224D14C4BFFFE8CC1147EF4959456B7162FFAEFD
            C75E7F1B1FB43FFDDDB776B63ECC8D7F6F2E15FCEB18BF32694F97D27B380EB7
            119BEF2D9F7DF87EEFF9FD8BC71E1893E7F7EF36BE76E8F1337F4347BE7AFAFC
            A73BDBFD8C7FDF3E5B1B1BAEA636DB6EAE49F45BEFDA76E8B4169D4ABE8ABDA2
            84242E11C7A5C6C57904869963A5C59C5118FFDE38CDFEE93D9F78ACF3F8F78E
            5F33899DE8E6F665FE4CF7E71FCCF89653547A277FF2F71BDFE4F71B187BC611
            029A47F6829B3369A230FEFD4B679F48F47EF585B9FDF73F7AEABCC8C31BA71E
            DDF585B9EFFF313F6807A9D8FED99FE4C6BFA71EA37305F764C97C3E3DF1B923
            C777B6EE7CF0DCAFE08DC5AAE83DBE9FDFF8DA419A66B86BEAF17FFFE21B372E
            BEF1FAC9C7F948708159E00FB237206E5DBE2CEDD672FBF98DB75BC7BF97BDB6
            695FF255EC1525834447F88571E7D74C86C03073ACB40B33EE1B31974DE9944E
            7B137F47DEF6D2313D120CC813720ECED56C6BF6BBFC815FC66DCEEADFBC7449
            BE904577B56847F255EC15A56B02C3CCB1D2983535E6B2299DD2456F5643F263
            B88CDB9CD5DFBA764DBE90A2EB5AB4967C157B452942609839561AB3A6C65C36
            A553BAEBCD0A487E2497713BCD08D594D4298AD4A299E4ABD82B4A4102C3CCB1
            5248AD288AA228CA30225A4EE4EBBDECC547CC65533AA5486F0EF5283F9ECBB8
            9D17F79A3DC52F5E0B6890AD8D0D28036CB7AF5CD191BDA2142730CC1C2B8D59
            53632E9BD229057B7378253F9ECBF8D3DBB78342666E9971F3D41815254202C3
            CCB1D298CD585D4C9528DE9B432AF9515DC6ED0CF1C3203A841AA3A244486098
            39561AB319AB8BA912A5F4662F251F97FC93957D5BD2A9E4477519C3D83D2861
            E6B6B31D2EB8A3C6A828111218668E95C66CC6EA62AA4459BDD923C9C7E52C26
            39EE643E1D493E549C27F623A19DE8F85B1B1B92DAA0C6A828111218668E95C6
            6CC6EA62AA4489BD395C13FB50719ED8976F0E9A767E8B0F0596D40635464589
            90C03073ACB4A8196FAE3466262193B1F143F32BD769FD3FFC84A496A1ED14C8
            43F69830736FFD7C82564BE5D5D185EBAB0B27C2C56E895449D71AF503B35E40
            BCF1DACCA9E575900A6FE1DE7A630DD32427C6C583F1939BA304DD678252B9B9
            991558DDEFBA6BB95708A818FCBBB3BDBD75ED9ABC118671049C1522B11192F5
            92DD26318D4DABDFD36AB828F93F3BFBD4DD63637B1F7FF9CDD51B17DF7CF9C8
            5E0C566BA3D7A36EE1C17B8E9CF9F8BDB7CE1FFFDCD8188739607821FDD47ABA
            758EB8239FC6EBCF2EE10520D706AE9DBC7C6AA686D713FCE9DC5F6D6EBEF7CE
            BB67661FDDCB0BEADE77F0F1D3144FCFDBE00FF06F3C920F5DE016CFDBDE7CF1
            DF1F99BA8B96310EA6F4A116B2A7284A7F605F842167C17590700C7AFDFCC7EA
            F36F6DD26AFEE8B87D975D90B06C61E669BD07273E395D9F9A1009A1206C22BD
            3B18CEE4C0099B1A33F3BEECE83D1FDF595F825B056C6B0C3CECA6F5BFEBEA3D
            178F57D487DC3EA60441A99262D34AEF7B6AB34B74D6D2DA2D4EA037DD31F1CD
            B54B1FBF3033315D9F9E300BE9FB8DE0373201F7071353F5E949BE73FADBADF3
            BFF30B902BC5CA6BA9F71F5D7CF395DFDC0B4993B08474ABE1E87D182F078F63
            48C33D14E640AE0D5AC29AA327636C243874E7677F52DFF54B1441E7E2C66B27
            7F7DEFDD541847418DDEC3168FE467CF8EACBE30577BF0C9AF8ADE0753FA500B
            D95314A53FA02F02CB1B272F3478BDB76024D0C1EB3DEAC1D1C5B505FC1724C4
            0BC21692929394DE03A80A70C62B1DEA3D80C347491294CA2B360DFDE18389D1
            82C72A0AF4A63F017EFEECC3B5AF9E3DBF387340FAC8EFDF5407615B4DCC2CAC
            E1BF74E7B4BDFCBBF7FEF26FCFFED60318B5F68DD67A8F3BBF71EC0F3EFF4F28
            2C215CAED3B5A78FCFF0E99AE93D067A76F5FE6A2ADC2D5DF65F7DE103A91706
            F1C3322475C40D2A6EF72391FC1653FA362C61F0967E498E425194B6215F747C
            7E96A28BE1B0330EBDDF5C9AAD4DE17016CB07590230AE6EACB6F7F65333C2B2
            25997358C040EF410F9E3880DE19C7D338736B1DB7FDA293DAC98C438165E93D
            1EDC536F5CC086165018FC34997A8F07A990A95205C566B1593BE757AD6AC0C8
            1E6AE649CB1BA71EAD1D7B7D75F56FCEFEBABC15EF3560BA83A0010F4BD8E289
            2F372E6F71FADF3DFFD3EFFDCA7FB5FFC8C9B3B97A7FE48F7FF8F52F803C5FC7
            1BC1E9F90BAFC8E992F97C3A5172E2F1DAD1057A2AC3D74678DB676FDDB664DE
            E29D77E70EB6D67BD862907CE80EB748EE66F51E6A24A909A885EC298AD21FC4
            25BEBF38B3AF36BBB01885DEE330E8419AE44CA0994FF7397A378465F3F5201C
            DFE3EC2B47412526E757B7BDF13D7EDBF1D6C1C75E8DEFD3A5DA19B9F13D4FE3
            43ED1D5D797B75EE4B77719B205328E45E03861DC4E1200D34C165D27FBAF287
            0FECFA0707BF789FD1FBDD26726EA0F714AE7ED7E1EFFC87E33509BF4BA7CB1E
            DF5FDF5C3E5193A0BDC9F8DE8F4769A6B5A48E6FE78EEF798B41F28322D9CDEA
            3DEC43A524B5EABDA2F41FE3E22880F8547D7AF780F51E9F401FFAB2FB1E1C43
            DEF9419A3BED9EB06CBE1E047AEF8554479D86B35FA7E7F7471BAB3CFBDBA1DE
            97F1FC3EAB54576D6EA3F0FC9EC51EC4C3933D2F9EFDF9B30FDFFFF9B9E5643E
            86F01B395156C8126F925CC1FEECE31F3EF30F217FD25AC86DF75D0FCEADAEF2
            03753E8B157EFCEBD8D8EEDF78E183E4726A369F8F376DFBBCE7F7D09B63E6F9
            FDD2B3874F2C6F254776AEFFE44F7E6DEFEE87E65E6AF6FCDEDD062EF9CD16DE
            71F5DE5D682F344645517A4DE28BF00D39747103D57B9AB54E38FCEDA5D36610
            3639D35829285F908BEC31BE1EB0DEF3C9C6C6266AB53DCED8CB78EA9DF5E5C6
            ACBC9F6F5F86277C39011CBDE7E4D9EFE7E333011C8DCB27F8786E2DD17B3968
            DECF77550AE0529D5F4A72CB7C3FDFADE37063C51E36A818EFC0B681E3EC47CE
            BEB14A1F573F38F5C85DFB8FAD6C3A0F35A059E193EDA0E0550CBE73B213F2F0
            771AFDDFF52BA73FC0F7E64E1F9FBA8F72B12FCC5BBDA773C1A9DFBCB8730B4E
            405F4FE6F36DEF72B6E6C66247AE0D73278709C7EB2716F03ED2F901C8D8E46F
            FCEB572F5E74DF51C00DFE101CE16DB0927FE7C30F83F2DCB8F8CA735377734D
            C6C6EE3E38F78A1B1E170EC99EA228FDC1913C7671FEFC221218664FF5BEB7A8
            8B196A5CB1870D7AD3EE676EA07FF2CD6E01F9844C826C9B6D503677BEBA2C82
            5AC3D6A2E203947CD0F2A030E90DEE0924B51AA3A244496098AAF7CA00E848F6
            EC9619A9A5232294FCD6151F94E4B7A3F7B72E5F96D46A8C8A12258161E6EBBD
            A2288AA228C388683991AFF7B2171F31974D69467A64CF1BF4667024D870B49D
            0AD3D21D518DF2732B0E5BFF47F93ABE57940A1018A6EABDD23F9A893D6CAD65
            AF74D18D47F25B57DC6E7D967CD57B45A9008161AADE2B7DA285D8C3D642F67A
            24B791487E8B8A075B3F25BF9D40F8AAF78A12398161AADE2BFDA0B5D8C3D64C
            F64A115AFCB10A2FBAE71383E443C55BB78CBBF54DF2DB898AAB7AAF28911318
            A6EABDD27372C51E36E8CDE0086CE5482C2E62386DA213850C5CF2A1E2EDB48F
            DDFA20F9AD42E4399BEABDA2444E6098AAF74A6F6953CCA0378323BD10D74C06
            2BF97C194725F93FBF71233863E6E686CC5163549408090C33C74A8B9A7110FF
            1EFC1AAE114B2BC68F67CCAF7644583677E93B0E4CDEF2880492DF595F3E3943
            0BDAEDAECF3E8F217C9223B44C9ABB18307F3D156F78677DE92457D39EC85D74
            4F32E1234D82ACDB8F76795D67EDA4E1A57D198376723E7280DA2FF0A09C5A3D
            1588C8B40FF7C938C7D44168D93B5A0A6F1B5745B4FD6D72908FBBEB275E5DDF
            91D58E7F0E927F69F9E5671EDE8F7F32EBEEADBE668E8C8DED9A3ADE788D97C2
            2D57F2216FDE8947F2CDC3FBD52B2FFE9BA7A6EEA39507E1E31BAFCF3D42ADB1
            6BFFC373AFBFB9AAEBEB294A6FD8D95C3929EB721AE914781D77FC037B305752
            7DB522E0B0EC1139561AA4EE1070A67EFC7B0A196EA28A15252C9B11000E8D83
            EEDE3B42A14BED118143E0D312FA3B97178F1E9A5DBE46479E5C44CDC628E6B5
            31679D7F910B3FDEB05B29CC64D20F7B43A73047E0CBD941D6F9A313BEBD027A
            DF91804143D8FDCDF7DE3A7FFC73B6ADA8D573F47E2CE926BE8BB27ABF87A2E7
            09360713C16153A21B7CB6F5D7DFF99FEEFAC5C7CEBEF6F68DD557CF3EF2E053
            677E88317BF67E058F5C7CFBDD535FD93FF685B9177F624A589AE44351652F0E
            C9B793F91B2F1EFB07535F79D2E8FDC6AB730FEDAA3D75E64737DE6C3C457107
            74FD7C45E931E8CDACCF0328E40A0E958D07FB181765C7D18E151A49C9048699
            63A52599B159281E972277E4B31861D98C002481C95B1C11400F7693781B8295
            D8F1E3EE4430E8EB41BCE1CB6ECC1BEE0F1427B8C561BDBFBE327FC8EAFDC4F1
            6F7D63729A5A00DAC409B24EA3D2207CBB5FD421A323E9820D7A9377484AAF99
            B6C2BEC09668ADF7134FCC7F639AFB11DBBF767476661F256CA6F77CFBECE83D
            75F443DFB9944CEC7B317BF8E37D07E75E918FE5497E70190F5CF2FD95F3FDC8
            02FB8FBDEE841BD872964328C951288AE26047AAF2993C98C80D3B378CC62ECB
            E60791BD88C03073ACB41C3336F1EFA9ACFB6AFB683642C6D0DD13960D73C78C
            61FC2DC1F5DD233CFE4E8E502821FCE86B6A78C4170CF9AB176F780D8E591102
            A4D151EFE54452531EF1BF72816F7D8220EB781F9711BE7D48F5BE53B1870DDA
            09FE3522CA6DB5746DF1E878EDC4B9C5E3797A3FBB7481EFBA6EC15DD4E4FC12
            5C7046EF4D7FD393174C2C9F396C5D18BD307996EF45CA87ED95E7A676BB7A0F
            5B29920F45913DC300253FF5A69ED57B37783F1D7CFCCF5CBF92AE85A228DD83
            02912594F6113932516FFC6C73B53153E3A97F60E07AEFC4BF3763DFEDF46D4B
            178465332E5B3E0272C409551EA40986EF001EC919DFC3D7695245E20DE78CEF
            F15E873394197E8C913A3ED358987583AC737423033D2F48576748E842EC6183
            6A3BF2296D45C3EE3DD3F5A971ABF7B6A94DFBE0FFD8ACD4718DEFCED6A69D98
            C2CDC6F7E60193D57BA7DF45F2F3C6F7BC15977CA8B8EC390C4AF2533FBB6F3A
            BEBFF76B0BAAF78AD263ECF4B07C4E08A48AA5C751222630CC1C2B2D68C661FC
            7B7C628D71DF69C43FD12FBD8723307AA600B8611A7CD0203750F81EC4AF1E5D
            5C4B8E7C767DB571B4E6BE57987C1D05030A80A3466CF709993FA09B2F7A9A62
            142B899A6A8FF003E63DD85592E15527306E3A7CFB30D19DD8C3066DE90867D2
            7A78AF860D4DB78978FDF00B8FF46A055DDCD884A4D8FC9A1E35A3FD7A33BDE7
            4BD17D7EEF5D097FF92F7EE3EB677FFCFAB12F8CC9F37B7A556DD7979E7B15F6
            C39217947CA89BECF9F45FF2B73636826C1DBDA720C563F8FC7EE3B593BFBEF7
            FEAF7EEFAFE46B44B35A288A52007A2ACF2E8BD9BCB44ADA84F701E800B7377F
            FA53921E1857EF3622921018668E951633E330FE7D63FD16BD01079829F70240
            2EB2C7845AEE1E7145144F4FD09F92D71D4D913657176C4C7C09546F704EE1C4
            1BDED95C7D7E96DF90F483E24B3789B4D8412715866FC438C3A5F3DE9D1AA7C7
            A97ECA1270FB3B62BA167BF816D45272419CD6A3B72FCDCF169200F3F665545F
            C2E92ECAD37BDB88D8714962B9057CEBB2E83D9CC879F175F6F977AE6FDF5C79
            E9DF1F99BA8BBE3CB6F7E17F7546DECF4F6F45241FF296BD14FD947C385790E1
            8DD7E60E72DD9183CFBDF6C3E5630F526BDC77F0B7BEED58050247654F5194A2
            90CCA3AD594747620AC34BF472749C5F336735A17499920A7F903D22C74A83D4
            51515ED9CCDD40F7DE522924F6F0DD08AF3499D84F153873EB5AF25B57BC3F92
            0FDFEAA8EF3EB99ACC2232313B0A45197E3E5E9E9DEA62463C30CC1C2B8DD98C
            CB2A1B3D71777FC0AD744C41B1871CE2BCD2FA20F9B915EFB5E4775447DED281
            0A6376148A32F4C0B07E92D77DE98CC03073AC34663356171309C5C51E88B637
            7B2DF9ED54BC7792DF85D8DFF9F043F9B2831AA3A24448609839560AA9154551
            1445194644CB897CBD97BDF888B96C234530FE6B674B8F8323EFCDDE8DF2DBAF
            78B9A3FC2E46F6B0B96BE8BAA8312A4A8404869963A5319BB1BA984808242177
            CB94C3F87BB34792DF51C5CB92FCEEC4FEE6A54BCD325463549408090C33C74A
            6336E3D17331FC238DC9A38BAFFE69FD5783759406C8ED2B57026168B13513C2
            9EF666B3F8F79DD20BC9EFB4E2C525BF3BB187EDD3DBB7258B14A3678C8A3204
            04869963A5319BF1E8B998B546BDFEADC5EF1EAD8D47F56B02908140185A6C03
            9810C65FF0378D7FDF29A54B7E17152F22F95D8B7DFA37782EA3678C8A320404
            869963A5319BB1BA9878003108E4A1C5F6F31B37E46B0E43D49BE54A7E7715EF
            4EF2BB167BF8169FB7196A8C8A12218161E658695133F6E3DFE3EA66F88199F0
            16AEEF1CC842F61827F71EC5BF77BE2DB187D34732BFCEC99AC468C785DD4E86
            E1F3DD7C4CC1005A5CC95934716B7DF9940996600A3020524BAFB7DAD2920F15
            903D0417C81B1BA3A597A5F5CCFAF9B2181E1F354BE6356D5B777D3D93837CF4
            E2DFF3FA7A498337EF4AA644C987BC65AF433A95FC9DEDED0EC5DEC4BF7FFCCF
            7E8EB70BB4BC34B5457A25AFAE6BA1284A8AE6F1EF53661871FC7B390EFE7C89
            E29A140A8C1B96CD0800AFC08A4EDC3B5242FC7BFC3689032DA6EBADCF6AA211
            5FCFFC3A26C30EB159F112FAA44954B654F8FC74C16455E089E9FAF4840445A0
            93729C37D0A685A385431214A1D3B16320F97E6FB2DEF735FE7DD2716D5C0940
            59920F4595BDCEE948F23BDD38FEFD6FFFE3FFE2DEE3E7F0AE145BCC06BFF002
            7500456AA1284A13D09B599F8760FC5532431CFB8103A4D82B38DA210F965A25
            3630CC1C2B2DC98C4DFC7BF948BA55F8097458362300BD8B7F6FD4C2464F2721
            778FACBC9EF9754A961DA39DC2E5897EE33770B13FD0B6F7C38221D0F7076616
            2FD0BF708AA05529E20B457D1D144524DFEF4D5A00BFEFF1EFBD09A796570253
            8AE41734B19E4AFEE67B6F9D3FFE396A4977CD6927BA81A12447A1288A831DA9
            CA6776447BEAF33F5E070F862BEE5D07631415882DFEBD7C0C3C69B784652359
            20CC7CA37BA48CF8F7CEB727671A2B90C83D82E3EC265FC7C34D62B4DFA13F25
            BE93FB6CED5C5830006EE80E80C3B5774B81DB350115E4E360E85AF2A1057987
            E0AA0D20FE3D654D8447C25B07A6B8E4435164AF5B7A27F9DB373F34D7987B75
            A9DE2B4A8F4195A4097D99624CE005E08D06EDC41BFF9E70070A8508CBD6D465
            9716FF1EBFEDFB3973C43CB068F275499615A33D7B7C7FF9ADD468927F8C6781
            B1E9C7B18DEF99EE241FAAC45F278CA26003F63BFEBDD0A42BE5A34341C9F72B
            DE25BD907CEA172BED3ABE5794FE13C6BFC7C76AFCD3E2D46335D40E474A98C0
            3073ACB4A01987F1EF019CA0A85108F3A284653302201F81E408073F2D1AFFDE
            A8057F429223F834453438FD75938C9CE6981FA31D85241D3E3F55B085971CF9
            91EA6CE3CD018F53F92E6F4F290D5B9C2E24DFEFCD44660612FF7EE9C4CC097A
            30D6EC4A082822F9054DCC52AEE49B799744DAE94E141F1CD29B22FEBD5179B5
            5014C58186796C81047A30764432D57FE17AC4F1EFB792A176612047D963B025
            9AE9BD199D148B7F9FA885C139626E29B2BE9E2443990962B46786CFC77B25B7
            602BCBDF74EEDDEC60EBFAEA8224C2E99D93A9B7330747A7920F15906F2289CC
            F0DB97FD8F7FDFFA4A48D3B5E443DEBC539CB2245FC41E1F2D59C078AFE15003
            F7337E090247654F5194A238B3B9E2E8CC0335FB9337FCCBB34BEB77789CC332
            11FC6A06803FC81E9163A541EAA828AF6CEE5C6554445BB0B6E84802A137CD98
            B27F6C5DBB76FBCA95B2CEDB9DE4976B62C525BFBBD688D95128CAF0A3F1EF4B
            2A1BBFFE10D58A754CB4056B9FF625107A13FEEDA7E4DFF9F0437B7628A41D70
            17A10BC92FDDC4BA967CF8D6F6CD9B924B87C4EC281465E8B9AEF1EFD5C50C03
            6D4A20F426EFF447F25DB1E7CD0EB80BD2A9E4F7E232EE4EF25B2C8F9F8B1AA3
            A24448609839560AA91545511445194644CB897CBD97BDF888B96CC34B2963DC
            34B9A35EE84DF763EF46F9E991BDBBF57F940F152FEBA401ED8FF28BB7B61AA3
            A244486098AAF78AB07DF3E6CD4B9758009A45B12B426B0984DE0C8EF442F25B
            8B3D6F7D967CAEF80025BF94765663549408090C53F55E41C0E9073200D2287F
            2B8F1612C8B2176C65493E2F5271FACDBF0EF26FB64121E59BC56847F26DC507
            22F965B5B01AA3A244486098AAF70AFE2C2D9001DEFA29F956F682AD0441C25F
            F04F1F5B7837C8B9F556D60C47AEE4BB15EFB3E49725F6801AA3A244486098AA
            F7A34E7A64EF6E7D937C57F682ADB82CB5338D1F6C372F5D922F17A6B5E40715
            EF91E44319DC4680B314791B3F8D1AA3A2444860983DD67B3FFEBDAC4B4A9F33
            1703EA88B06CB8761A660DF428FEBDF77577ED3C3924415986889DED6DAB01CD
            B6FE483E349EF3F1CD978FEC85267EEACC8FE0E347678EDC3B76A855BC1CBCBE
            EC2A05B2B06E6A7DBD83CFBDF60E64758F7CBCEFE0E3A7DF5D7DE7DDB983F71C
            39F3119C74F5B5979F7978BFF9D3C58BEFB5BA123AA485E443DEC1911E493E00
            C500996F5BE965E547D3E4AD8C178ECA9EA22845691EFFDE5D069496B98C38FE
            7D18BBD759FBB673C2B21901E01558D14979474A887F9F9C421676C5BAE0312B
            42C346B399FC60EB83E4436FDA7DA3F76363FB8FBDBE8A7A7FCFD8C16FBFFB91
            D7D4A62FF07F4C6ABBE9AA1BFFFEF47FFF7F3838F78ACD19B3BAFBC8CBEF5CDC
            7875EEA15D5F987BF14DA3F76FAFCE7DE9AEBD5F39FBDADB37565F3DFBC8835F
            7FF9AF5A5D099DD34CF2A1A8C111D87A27F9EDB3B33A7FA0FEE471A3F71AFF5E
            51FA0E7A33575E28280EAE9F4FF628115B628D7F4FE1CE9CD8BD5D8F9790B06C
            568C7B16FFDED17B407A220C683B54B4A9F7B0F55AF27DD943BDBFE7AB4FFFDE
            FEFB1F3D759EF51E46E7B75F7E2A5BEF9BC4BFDFFCF0F5E7A67667E9FDEA9517
            9E39E8EAFDEA0B73FBEFB329F10942EB2BA12B3225DFAF78B2C520F96E940767
            696727BA81A12447A1288A831DA9CA67727B124C8483815D006394303911C6BF
            E735626DFCF8228465C396C0AC93F946F74819F1EFFDBF4A0083B524CB89827A
            D07F3EBD7D3B9099165B4F251F9ACF3917E9FD91C65F9D7AE4AEBD8F2F9EFA2A
            EB3DA8F5BDF73C95A5F719F1EFEFFDDAC247175F796EEA6EEE9BB1A9B97759EF
            E5F3FE5F3FF5EAC645339FFFCE99A7EEDEFBD49937E1ECF2BA40EB2BA15BD292
            0F45713FBA5B04926FA5DD84EBF00E26402D644F5194E2E00083A6ED658AD1E0
            C4CB21C5F959BCF1EF5BC4EEED82B06CA183B6474A8B7FEF7FBD0AE37BE093AB
            57039969B1F54EF2A1379D13B1DEF3B07BF783539FBFCB3E7DDFF5C80B1F6CE0
            D74C5FE0FFD0FE7EFCFBBFF8DA3E9AA507BDCF1CDFFFE8E523B5BB1E3EF581D5
            7B3C11CE2524EF06B6BE120A1048BE5FF1701BB4E4EBF85E51064818FF3E2170
            507000A7FA6D0C552130CCDEEA7D10FF1E5DB317BBB7E3683F2E61D9022D0792
            231CFCB468FC7B27C38A3CBF6740C5039969B1F548F27DD9337A7F71F5CA99C7
            E91D3AD4FB1B6F9C7A74D77D0FCDBDF4C98DBF6911FFFEC30FDF375F6FA6F717
            292BF7F9FD4F5E3FF685B1FD8F9B2BA1B3F8F79DE24ABE5FF18C6DA0929F483B
            CDCC69FC7B45E92761FCFBCF362FAD9247C2FB007480DB9BF1C6BF5F7DCB8FDD
            5BC88B4126B2C7845AEE1E31A39362F1EF2943FE4393F7F38756F8072EF9D078
            CEA8D7EAFDC51BAB2F3DF7E07D63BB1E39FBC6EA8D8B6FBFDBF8DAC15DD4D477
            1DE4FB48A3F7600218FFFED71B2BCED79DF9FC319CAE4FF4FEE2F9B30FDFFFC0
            B1EFBD237A7FF1E71BEF16897FDF2956F2216F53EBA6DB60245FE3DF2BCA6068
            1EFF1EBD1C1DE7D7CCCDCF9112FDF2813FC81ED153BDEF2DE595CD9DAB1C5D06
            2BF9D09BC14477EE96FE5D7E475570B7E23FF1EF02AE2F543C284CE616C7EB7B
            4D89D95128CAF0A3F1EF4B2A1BBF4238D461E6CB628092CFBD5944F2874BEC19
            A82F543C284FB32D66C98FD95128CAD0A3F1EFD5C5F4824149BEEDCDEE247F18
            C59E818AB75FDF68255F8D5151222430CC1C2B85D48AA2288AA20C23A2E544BE
            DECB5E7CC45CB661A7FFA3FCA0373B1DE577B10D7C64CF70C53BAA6F84A37C35
            46458990C03073AC3466335617D353FA2CF9E9DEECA9E44722F680ADF8504BBE
            1AA3A24448609839561AB319AB8BE935FD94FCCCDE2C4BF271B5FCBBBFF4DCAB
            6FF3C778C41E702B3EBC92AFC6A828111218668E95C66CC6EA62FA40DF24BF59
            6F9620F9F80BFE2F72A83DD8A2127B20A8F8904ABE1AA3A24448609839561AB3
            19AB8BE90FFD91FC16BD59D6281FB6D8C41E4857BCA3FA9618A7BF086A8C8A12
            218161E6586951330EE2DFA762F716212C9BB3D05D8FE2DF3BDFB6E5DF5A5F3E
            65C215C8C1AC64C34D1F241F1A4BF6105CC6758C432753B3DF3BF6F0BF5DFE99
            B33ADEC51B26C20D1E1C1BBBEBC1B9D5552EC0EA07A71EB96B6C2CB5BE9E89A8
            2B1FB96B70D52A5914D1BD12B8D7CA8B7FDF02C85BF61C3A927CF94EF968FC7B
            4519084DE3DF7B0A4611DAE28D7FFF112EE8EFC6EEED3E9A3810960D5B8297C8
            ED55FC7BFC36393F2A3FE6433B93120D08D7159F80B3E0A2BD49B2A2D58C845E
            4BBEDF9BACF76363B4E8215DE287BF73796BE3EC6F35D3FBB1B12FCCBDF8133A
            FBF9B30FE3D56FF45ED6CFE791BDDF83D0359B46EFF94AE0480AF95742894051
            65CFA74DC9DF7CEF3DF942D9EC68FC7B45193061FCFB0434C3E9A8E3DF5F036F
            2B017C4A882E1A96CD6A79CFE2DF1BB5E09B2FF0FED4D64988028ABE03A9C364
            55D07BA0A792EFF726856939FEAD6F505F60B3D364CCCFCF3F73CF2FFC5686DE
            DFFDCFE67EFB8B0F1C7B61E3E2C58D178F3DB0F791A71EBEDFD57B3B8D9FEA41
            A3F7E9F0772DAF8412696162ED487E77B3296D63E3E5687C3C45E93B4D03CBA1
            3D4EA0CCA3318A064517FF3E8CDD5BBADE73CEBD8A7FEF7C9BE3F7078E4F421A
            3811F165E85F197A27F9D058B28770C32E5D038DA99D38B7789CF51EDAFFDE7B
            9FF9F39F91047A7A7FE407DF3FF600C6D4F9CFAF1F03E16FFC201D2F8762B7BB
            3D485D63E6F33BBC124A048A227B59B4967CF8132490A43DC15EE1265C877730
            A1752D1445E90C1C60D084BE4C31FA24A3919D78E3DF270483A7AE08CBD6D465
            9716FF1EBFEDF93999B76832BE97A718C9B3974AD023C9F77BD3280AB6FF9EE9
            FAD4B8D1FB89F1A3FFF1E36D94405FEF5F7E9B02D8CF7DE3A9BD5F9C7BF1BC1B
            0FF79F3EF7B6E49AF4A0ED1AA3F7E90BB2E5955022B926D64CF237DF7BAFC762
            0F5869D7F1BDA2F49FCCF8F7D901DEA28B7F9F8ADDEB97B743C2B2055A0E2447
            CA897F6FD4823F21146B87478A7C9FB5E750E3927D7E4F115AAB339F6FE985E4
            FBBD99C80CDEABC1DFF8BE15DB7337B4F0A73B777E7AFAB1FD142457F4FE1D79
            4DEFAE874F7DE0C5C3CD9CCFB75D639FDF0757426FE3DFBBB4636269C9EFFDC8
            9E49A45DE3DF2B4ADF49C5BF077092BF066E90EC7F27E2F8F72BCFFBB17B0B01
            D9C81ED34AEFCD0D51B1F8F769BD47255890EFE324FF498A549C2433F7199CB6
            42942EF9D07CB2873823487AFB724CEE0EB7D6979E35AFAD3EF4F5FF6D79E3E2
            45A3F7176FBC71EAD15DBB1F3D75BE49FCFBFDD0DDA9AE79EBB2E83D9CC8F9F1
            48EFE3DF5B206FD96B09A8FBADCB97A1316158BF75ED5A3FC45EE3DF2BCA6068
            1EFF9E8740C96899A48DD269FCFB36C99E1E515A53AEE477D19BE9516FEB2DC2
            1FDF03319B58FB54A3168A122B1AFFBEA4B269FCFBAE2951F2BBEBCD0A487E35
            94B21AB5509448D1F8F7EA6262A02CC9EFBA37875DF2AB7119AB312A4A840486
            9963A5905A51144551946144B49CC8D77BD98B8F98CBD63B3EBD7D7BEBDAB5DB
            57AEDCBA7C1976E0A3FC61A0141FE517ECCDE11DE557E3321E4D635494C8090C
            33C74A6336E3517331206920F3816EC1B6F9DE7B9F5CBDBAB3EDFD6CA0FF1494
            FCE2BD39A4925F8DCB78D48C51518682C03073AC3466331E2917B3B3B575F3D2
            A540B1820DEE06063BDC2F22F9A5F46633C90FE2DFDB2D06C9AFC6653C52C6A8
            28C342609839561AB3198F8E8B01B187417CA055CDB65B972F0F50F5BB96FCB2
            7A3343F2FDF8F7C13670C9AFC6653C3AC6A8284344609839561AB3198F888BE9
            48ECED3640D5EF4EF24BECCDE19AD8AFC6653C22C6A828C345609839565ACC8C
            D3417C5B85D0EE14C845F6185C3B0DB3067A14FF1ED8595F3A6942FE489EB418
            1C1FA135FBAE381F312690734E5A98CC5BE30FE0B841BC4CD29E6099D2EEC4DE
            6E8352FD2E241F1A82BF4B709326F1EF6DBC9C647D43FC802B2472F33ACB27C8
            8253F7FCD6597F7DBD83CFBDF60E2EC6271FEF3BF8F8E97757DF7977EEE03D47
            CEDC06C98F29FE7D1C68FC7B4519084DE3DF034EC07B0A2E1F4DFC7B8B04F1DD
            6A1942BB53C2B21901E85DFC7BCE4742ED61FA490AD0EE2CFE8A041FA95CF4D9
            0B871F96049A6872BA3E35E12C80BCB3BD5D44ECED0683DDFE0F613B957CBF37
            CD2D142D7A884D95A7F7634937E1C5069FEF7DE6FCC6DA5FDAF8F7BCD9C577F1
            89FEAE2FCCBDF826EBFD4717DFBEF4DCFF23AAF8F70347E3DF2BCAA011E9B46A
            E269104231DBE28A7F2F727BE1A364D9DA5014BB202C9B55D09EC5BF0F0210D1
            C27CA0431FB7A7F77E38FCA024D71767268E2EAE2DE0BF26FF8E243377BB79E9
            529F55BFA3F2FBBD496D988A7F6F5A92929806A4834FCC7F639AFB113BA57674
            76661F24FCF9CEA57FFBDFFEEFB3F47EF5CA0BCF1C74F57EF585B9FDF7B991F4
            E2898F3750ECC5ECAE399D61BC71D7425186133B5295CF1CD5C21D78A0314613
            FF1EBD24CD4AE038E956EB10DA9D12968D6481E865FC7BB7D0D2BEA8F79267C6
            475229F9E884C3F74E04CEF48903D8A938CA37818F3EE3F828E56E7D56FDF625
            1F5A0712CBD7E4F2C8887FDF44EF67972EF0ADD8ADD57910FE25188152C2B5EF
            3C742F37FDD8D4DCBBACF7F279FFAF9F7A75E3A2CCE77F64A2EB268DE3751030
            98F8F783C6DAA9C6BF57943EE24967129613DDD2F8BEDA3EFBA73B91C5BF4738
            88EF379716FA32BEB7C891D2E2DF171BDF4332271CBE5B12BC89A307308C9993
            E985DEF306AABFB5B1F1B7FD08A8DAAEE443BDE15F23F9A60DB1FDC3F8F7D2FE
            A601A579B7A8E31ADF9DAD4DCFAF5E355D8022FDD0772ED9D7F7CCF8FE472F1F
            A951E45CA3F738BEBF9F62EB99D7F75A5E0925021597BD18B117B38EEF15A5FF
            84F1EF8DE880458643FF409E98C03073ACB424339620BE38086B1E42BB53C2B2
            B90ACA244760DC5C42FC7B72FA133255B0B9D29899A4072781FB6BA6F734699F
            359FEFF59393A6A3F9F02EB6CD7E45566DA722D09BBC43929FC84C66FCFB1D7E
            A04E8D669A575ED3A33B2AFB751994DB37F6EDF37B0A9EEB3EBFFFC9EBC7BE30
            B6F72B675F7BFBC6EA6B7F71FCD1A8E2DF0F8EE4622647A3F1EF15A59F887426
            72823ED0BE463331397FE17A34F1EFA9AC900520AF0ED2DD0A7ECE08A1DD2990
            8BEC31A196BB47CCE8A458FC7BC887DF58A6BF41FA53CB2806197A4F0910387E
            470409FE646E3B6037291BBD7091F45392E6D3DBB759027BBAF547F573251FDA
            CAEEDFF9F0FDA44979F243EE87DCF8F7F232AAD17BB604FE8183ABF7B6BF7FF9
            77CEAE247A7FF1FCD987EF7FE0D8F7DE11BDBF0832FF83C7A7EEC294F71D3CF2
            6F2E5CD9882AFEFD00D0F8F78A3218D2D2691FA8F1BBC3F80712AC6D1EE724FA
            E5037F903D22C74A83D451515ED9DCB9CAB8F8E4EA55AB823DDD40F541927BBA
            286F6BC987DE743FD228BF64E2FC5D7ECC26D63ED5A885A2C4CAC71AFFBE9CB2
            D14465A4F1EF3B95A8E25B4F55BF85E4436F06474644F2ABA194D5A885A244CA
            758D7F3F1A2EA6FF920F1BAAFE56F9CFAA8166920FBD191C816D1424BF1A97F1
            8818A3A20C178161E65829A456144551146518112D27F2F55EF6E223E6B2954E
            47A3524809A3F31693E71D6DBD5894375D36E8CDE088DDAA3DCAAFC6653C52C6
            A828C342609839561AB3198F9A8BE954F221FDCEF67659AA0F1996AB7941C1A0
            37DD8FC15661C9AFC6653C6AC6A8284341609839561AB3198FA08BE94CF22F5D
            E267F0303A2F6BE99E7297E773251F7AD3EE676E45241FD77E9FC8F8F57C0C92
            5F8DCB78048D5151E22730CC1C2B8DD98C47D3C57424519BEFBD675FBB8B53F5
            ADE4436FDAFC9B6D5D4A3EFE827F1A57A8C862E0925F8DCB78348D5151222730
            CC1C2B8DD98C47D6C5742DF94089AA5FD6423D2CF9D09B6EE6CDB622A3FC660C
            56F2AB71198FAC312A4ACC04869963A5C5CC382B882FAF59266BA715222C1B2E
            B446E7C225897A13FFDEFD3A5661AD513F309B846405ECA27BFEA9D2B179D61B
            75CCC15D8C6F72E6A43D19AF0E6BC3E187C93ED8DEB9F9B3B34FD9D8EE14DC3D
            9025BB05920FC4A6FAA0E2500727DB375F3EB2776CACF6D4991FC1470A7263A2
            D7DF7DE42F3E20C937EDC9ED9C8E7F9F5A5FCFACC02F1F7991385CB50A52FE1C
            24FFD2F2CBCF3CBC1FFFC4A1F171C53D73646C6CD7D4F1C66B1BA684254A3EE4
            2D7BD1A1F1EF156520348F7FEFEA0A5966BCF1EF31FCC98143C78FF74EEF7989
            5C5C8115CFE01DC98C874BCB16B61FFF3EFCBAA3F75C235E9DB7860B23240799
            E0BB8EDE9BAF42B7EDA9CD2E510A0C94E784C3CF487663EBFCEFFCC22F3E75E6
            4DA391ADB6B4E40351A93EF4A69321EBFDD8D8FE63AFAF867AFFF23B34CA37ED
            89FF6352DB4D78B1C1676A2E593F9F8E23B653289A3B7C6593F57EFBB3ADBFFE
            CEFF74D72F3E46EBE7BF7AF691079F3AF3C3D5B92FDDC52BEA5F7CFBDD535FD9
            3FF685B9177F620B5996E44351652F327634FEBDA20C18239DF231AD41F1C6BF
            97B500ADCF2D485836DB103D8B7F9F6AEB94DE03B88A3BA6F10E02C177537A0F
            27C381297F804CBC70F859C9EE2CFFEEBDB826BC55A0D65BA6E40325AA3E6CA0
            C4DD2DCF07BDC913FBB4A1DEDFF3D5A77F8F62D6A5F51E4FF4C102B727B57376
            FCFBE67ACFB7CF8EDE5347BB91F46E3811F3CCC7FBDC50FAB09522F9712BA5BD
            F0DC35A7DDAB5188BB168A329CF8D289043A42C61867FC7B119B5008BB252C1B
            E68BA74AE61BDD2365C4BF0FBF9EA9F7E62B4EDA09CC21C83943EF6D876DA5C2
            E167255B3B97148682BBBB5294B935937C008E3B725B74EB42F5A112F0AF2903
            E9FD91C65F9D7AE4AEBD8F2F9EFA6A5AEF6FBC73E6D8DFDD671BBF59FCFB643E
            9F62B73B9D327974F13247A1C094A6779267F926223ED7E8C6C5579E9BDA1DE8
            3D6CC5251F8A227B31622F3C8D7FAF287D244B3A91C48549BC9C68E3DFCB5403
            3B68CF5B74455836E3B2E52320474A8B7F9F3A4596DE171FDF6FE1F308EC3B06
            DB2D2B19C6DDC30C3B7ADDAC85E40325FE5E1FB68E541F2ACA3B5400D67B0E4B
            BFFBC1A9CFDF65F57ED72367DF58C5FC498F8F2DBC2FEDDC3CFEBDDBBFA6533E
            5E9E3D4037C546EF9D7E97F66C637CCF5B41C9B7158F127BE1E9F85E51FA4F18
            FFDE42CFD7EC0B5E881757DD1018668E959664C65E10DF5008BB252C5B20A840
            720406CA65C4BF0FBF9ED2FB329EDF5FCF08876F05CC79CCEF6458A2E4030351
            7DB737EF7CF8BEE8FDC5D52B671EA737E650EF2968FD7D0FCDBDB4C10FD449FB
            3717BE46ED4C820437BDA8E2B6559BE9BD6D58FBFCDEBB12FEF25FFCC6D7CFFE
            3889887FF18DD7E71ED9BFEB4BCFBD0AFB6105612B22F92599588F70AE4F8D7F
            AF28FDC6934E17F306D2ADCD88E3DF3BF3AB3CCB5D00C842F698405081E48819
            9D148C7F1F9EC2D17B4E8F9964BD9F0F1D86C371F9841FB125A017D19FCA4179
            3F3F331CFEF9A5F46BFCDE096ABF7BFE7A89920FB0EA43CAE0BBDD6DB7F216E5
            853AC81EB2F9974FED3761E95F7AEEC1FBC66458FFF6BB8DAF1DDC4535362FCC
            C3A0FFDEBFFB3523E12DE2DF63C7619B89F170C3BE7559F41E2A6CAF04FCA5C6
            3BD7B76FAEBCF4EF8F7044FCB1B1BD0FFFAB33C9FBF9E9AD6BC987BC652F36F0
            B191E5B0C6BF57947E91964E79A07619659EFF3039D3580101E3714EA25F3EF0
            07D92372AC34481D15E595CD9DAB1C62CA1DE53390E7D6B56B7D50FD746F8282
            065F6FB1C1AD897CAD3C3A6ECF6E5F5494BD61A61AB5509458D1F8F725952DE6
            F8F79DD20BC907CA557D28617A349CD99BC325F9AD27309A510DA5AC462D1425
            52AE6BFC7B753159F448F20156FD9B972E059974B7058BF236EBCD21927C4829
            DFE9846A5CC66A8C8A12218161E65829A456144551146518112D27F2F55EF6E2
            23E6B20D9CDE8DF22D30F22E71ACDFBA37231FE5C39FBA1BDC03D5B88CD51815
            254202C3CCB1D298CD585D4C6BFA20F900287129CBF3416F42195A2CCA1BADE4
            C3CD4AD7620F54E3325663549408090C33C74A6336637531B9F447F281E28BF2
            426FF24E0BD58F50F28B8CEC996A5CC66A8C8A12218161E65869CC661C61D940
            F640AB406940FC40B75C61800D8EC0F1DB57AE409AEEDEE5EE82BE493E5044F5
            A137DD8FA8FA1B1B92AF4377928F6B534C38EB261500DAF393AB57A17830AC6F
            311BD13ED550CA6AD442512A46609839561AB319C753B6ED9B3741C503B16967
            03750455EBEE77DBEDD34FC907BA5B9E0F7A3338025BF00E3FD3B1E463CC8969
            0CEC1625D550CA6AD442512A46609839561AB3190FBC6CA0A330C22BE59D35D0
            6390B1E283C566F459F2814E551F7A333862B7F4487AE013FB25520DA5AC462D
            14A56204869963A5C5CC381DB49F56A4C7CFBBEBF36F392BDF7603E4227B8CBB
            AA6DFDD9A5F5ADD6472494D0CEFAF2C91929D2ECF3B81E617204BF466B191AF0
            EBB29EEEF6CD0FFFFCF15FC4355F3170CBD8D8DEC75F7E735502B763B4BA579E
            9BAA617435FE2BE3ADC97AFEECC3BBCD32B11CFD45528DFDF25779115FAFB012
            9A0CE1E3CE0241B2A422AE0B1B56F06377BDDE5F3BF1BFBDBB0AA76EA36C8777
            D34AF445EF3F40F541AAE10682A5B7C50645703E72FC7B28E48FE023C7C3FDA3
            73EFDE5AFCED7BEF7D869792FEF9472F73FC3AFAEBD85D0FCEAD62D5605BFDE0
            D423778D8DD172BC50535B43EC6EA779785158132F07CBEA5C09BC5E6C8B2BA1
            3C206FD98B8E9DCDD5E7674DFC7BC7783356EE8CB8168A328C6CAD2F3D2B2BBD
            FB6BC15108150AA846B15D5C976F4C35010ECA1E9163A541EA6E3141FBD71B87
            EA275736B79380750508CB86F5E625F131BE9C113F7B2433FE3D2D535C3BDA58
            BDFED9CEE5C5A3876697AFD1118E97B3B5BEF8646DECC1F9D53B929CBEFEBBE7
            AFD3536A13C34D5473D703C75ED8C8D67B0EABCA6BBF8B8661E897BB3F7FF08B
            FB25029B9F6CFAEFFCD7CFBC7A05CF96EEC0E43EC0160C9B173E7B5516FC783C
            0FDDFF4BBFF5BF5D69B36CFFB75FFA8D173E906C8AC11321AD551FCAEF7C64BD
            1F1BDB7FECF555D17B130FF737CF7D780D33DD5EFEFA3DFBA1F0ACF763635F98
            7BF127F45DBA914AF45E82D8F228DF36A9893661E3E5F095C0F172DAB812CA03
            8A2A7B91B1B33A7FA0FEE471A3F7D462182FE7B3CDA5598D97A328BD84CC8D63
            76FB9096497877A2994C308161E6586939669C0ADA9F19B9AF53C2B259A9C348
            41BEBAA78F086B8DFA6E6F51E2BC78B8CFDCF34B4F7FF72DAB4946EFF73E79EC
            C80338587FA3B9DE8B14910EE118F49E874FBE8DFF9EFA00FE9495ECDA7FF8E7
            F7DEFBF5744752073F31FF8D692E393666EDE8ECCC3EECF4B08289DE43429C06
            B8F7993FFFD95FB65BB6C3CF7D5C7862DFC2AADFECF107F4A6F391DAF6AB4FFF
            1E45A4F5F51EE3DFE373FD8F5E869A7EFDE52B74F09FCDFDF617E97EEBE2C68B
            C71ED8FBC8530FDF1FE83D6C20F9D474D01C3CF3E4E87DD0D140EB2BA13CE256
            4A7BFDB83126DC8B4A88BB168A325C50749CCC902E18C5CA1B78189F261F0302
            C3CCB1D2A2668C5E92A624649CC4E0D2FF18D1553E76495836AC379E2A996F74
            8FF00D51728466C8F1A3AB8E9C20B8214802AA6EFDCD4B8E407A7AFFD499FF74
            F6E1FBF71F3979B695DEBFF3EEDC41FA2B88EB411C8FE2489AA2AC66257B5B46
            AEC0BDAED260192766972EF03DD3ADD57910FE25187361A707150C5C335E2B87
            BF73F9A7FFF6BFFDBFB459B63F7AED9DE2CFF2037E9EB5500F94D7F9C86DDBF8
            AB538FDCB5F7F1C5535F0DF41ED3BC73E677EEFE45D0FBDB2F3F05077FF0FD63
            74BFF59F5F3F06C2DFF801770DF68299CFC7AA5DC4E0B9F299EF9DCD7C7E8757
            42894051642F46ECF523E1B9E8A192EABDA2F41434B1F15A6D1F7A2A235E04BA
            A5F17DB57D89AA3A2E9F23E679C051D92372AC3448DD2D6ED07ED83F3CE954A0
            6BC2B23575D9D793C707419A4E4675F8F6190AE46E99810FF5FE4D1C59EEFAFC
            C12FDED75CEF650CFD37AFCE3DC4415D117A109095ECAA91B74DFFC769580970
            B75B54D4C677676BD34980FCB0115CD74C4334FCB0F69D87FEE1EF9C5D69B36C
            D7CB787D2F4DA0FA7032BB9FB4EDEA0B73FB773F38F5F9BBACDE7B6F3C50B3FF
            D9E3F7FCC23F7FF96D4879FFA373DF786AEF17E75E3C2F5FF7C7F7B0410E143C
            17EE380F50D061A3F741BF03CDAF8472818ACB5E8CD8EB47C7F78AD237302A3A
            DF5E9B278F32A0A7E86EFCE659306B4E4F2453B3E68161E6586949664C45010F
            B1B5BE74E2CB8752C1B3BB232C5B53BD87231CEC3C3D9F4FCD2A4F6DA16CBF7A
            74712D39C22F28D13B11E6557314457E356CE3B593BFBE17679B1DD5FCD1CB47
            E87DA66CBDB7CFC85F7BFDD817EEE2697C7EB96CFFB1D7DF4E27FB91379CA577
            F8597745EFB7E5353DD22DE3829BEB3DBDE5B187A65560A87A00E3E5FFEC6C5B
            655B2DE78DFD4CEC4FF6A1D9B89AB419BDBFB87AE5CCE3FBB14D51EF71CA61D7
            7D0FCDBDB401053EF595FDA4FDA695E4353D2ABCFD7A86DE43E2BFF8E0430A96
            EF3EBF0FAE849913CB5733AF0429777940DD642F469CEB071D0D3EBFDF595F38
            AACFEF15A587906FAF9D58E677DDDC097C745CF6359A8950EF538F0002C3CCB1
            D262664C25802C007EBD19E7932D1305474B9085EC31ADF4DE8C4EB6E0089F1D
            A03FA17397B720E529C0E6EAC2ACFCAA60AC36737279FD96F3BBB28DD74E1F9F
            BA8FFE76DFC1C74FE3EBEECE28798306C72439AEDE537280DF81C7312BDD2870
            9EA8615F98FBFE1FA75F9547719243636346F8B7AE5D337ACF7DBF873CAFABF7
            F20DAAE015382E9FC626674EF22BE6A8F750F7BFDD3AFF3BBF207F6B55367A0F
            AE77920F80EA4311E4A4B859C1BE7863F5A5E71EBCCFFC9081EF4BA8C0BBA68E
            374C2B71E3606979F6C5D5FBA459A13B6CE23B1FAED02DE05B9745EFF186C85C
            09E6971AA92BA18CDBD410C85BF662C3B35618525CC3593ADC37BF5F7080A3B2
            A7284A71F0ADE149B43699A5B70FD4F8DD618005EB4E22B2FCE2B90F1C963D22
            C74A83D451515ED9DCB9CA90AD8D0D4787A2D870A05FD2123DFDFF5D7E33A037
            41F5CD3C4A3F367E637FE0C46C62ED538D5A284AACE04B6FDEABE5ED1118668E
            95C66CC665958D262AC3DF3832DB376F062211C906D2FBF3D4C273DD1189E4DB
            DEEC6E79BEEEB61824BF1A4A598D5A284AA45C5F9C993CB1EC2F7AD10E8161E6
            5829A456144551146518112D27F2F55EF6E2A3D765EB3AF40B6F3068C667ED37
            6F7E7AFB368CA12143F817F66183E330B26CF64BF48E36FB125F41063ECACFEC
            4D2855EE423D05B79E3EA46887984DAC7DAA510B45A9188161E65869CC66DCD3
            B275B442BBBB817E8044B5F97C1D979BDDD8685F6833373823DC55488E0518AC
            E4B7E8CD5EABFEED2B57E44C83A01A4A598D5A284AC5080C33C74A6336E3DE95
            0D95AFABC1F72757AFC27725974E28FEAA1A28A2E45580014A7E6E6FB2EA9732
            2992DEBAEBB552A8865256A3168A523102C3CCB1D298CDB87765035D09F42077
            03F103CD96EF774BC157D5E0BBC5756B5092DF7E6F662ECF57706BA3EFF0C7A5
            13592F7516A41A4A598D5A284AC5080C33C74A6336E3DE95AD533901812CEB07
            724011D587920CA9E477DA9BE5AA7EAEDEE32A575DBD1F9B4B3594B21AB55094
            8A1118668E95C66CC63D2A5BA74FEE4B91D834A040ED8BAEBB810A1617E0FE4B
            7E77BD5996EA9778BBD629D550CA6AD442514A047FE9DD6459970C70C5EEE9D2
            237006869963A5C5CC3815FF1EE3D451E0DEB1DEC6BFF75743E37567791D3A2F
            15416B117348595A7CF8F6952B2203FE6273B43C3EAFF286ABEAF28A6F24F6D7
            ED9AA384AC5EE79C68BC36736AD9860BC245F178115C242B192E9627C7C6EE39
            F807AF4A7928A4CD3D474E2D72AC58CBD4B1E79223771F9C7B65F3DDEF3E732F
            E4E7ACFF4A27CD088FDC9C3E4B3E145DF62C7E4305EB27BAFD78EFEFFCF975FC
            3145D22F582A5ED970EFE32FBF091F71C53D5CE7D8590CD12EC377EBDA1A35F8
            EE438D4BE69AE110C3743A77993989B1249FC6EBCF2E617F498F7FF6D9D6FAF2
            A9991A5EF1E64FC991CC65E900F883EC4587C6BF5794346943082C85B94391CC
            5640051B33EE4A79C0F5D58513F5F1C49B01E6E6C0666E2432FC7A2A01820141
            3297AC8574B247E4586990BA5B4CFC7BF94802DC89F66412962DD183ADF5A567
            EBBCC83002679F9CAE4F4D58E5E0B46E01405A26A6EAD39333FFD19D48FF89B3
            98BCB38F81E33074FDAF3DB74CE3C2648D71C2D17B3ECA0BB5E262C8786540DD
            27A6EBD31312D8202B99770301A730BF0C64BDA75566DD1567BD7DDA6411DFBB
            CC7A4C7CC7D399DE03FD94FCD49516365486DEFBD5F9F4FFF7FDC77EE1FF0AFD
            22B768D208148EA8B9DEDFFBB5856D7B83656FC6F9F628D17BBE29246C319278
            15D2E34EC86A5CF3120E6D3941AC69D97977BD6B2155F1580007A4F1EF152520
            6D0881A508325EBF8EEBDDDA95F025A2E9A1FAF1277DBD373707EB8D43F5932B
            49625A2ED7FDFACAB7FD04E85A70BF365DAF6504F40A0C33C74ACB31E3CC483E
            ED4F7434212C9BA707CE1D066AF9D1C5B505FCD7C40EF2D582A46566616DF1E8
            BDBFF63D5277D992317D32D64FC2C3DFFBD8F7E906224FEF01D40F2E1B14ECC0
            CCE205FAD7CC3784C970D17B27438496F5ED48EF3124FFE71F98C346C62B6FEA
            E9D95F0D04B21DFA26F9A92B2D6C28BF7F831E04A4137FF6FDDFB8E7CB7F8A9D
            681A817AF08D4CBDFF8BAFEDA33CA8078F7FEB1B329F86B6577BFAF80C9FAE99
            DEE36495ABF7145F4722C632188327999FE0903C5E02246EA5B4D736DD328ACD
            06173C12772D14A52C9A194260143619F8310AD506C75C0FE67B33F2FC5E547B
            1CEEA39C7F98FDF524C10EDD764CCD2EFF38336077609839565AD48C51696832
            53E28C91CB4364D05304C845F618AF396C740168F7270E607BE128DF4ED862DA
            A473E04F87B1ADAF2F7EF5EFFE8F188DDE6A18066BC1F1A23F998FE1E1EFFCB4
            3133C113E6414F67E93D1EA4CE807E3D0017018913BDEC9D95EC026448AD0424
            4AB3B375EBA7FFEA4BCDF45E92731C3956B54603EE51BE7AF6673C5374612910
            C876E98FE443D1658F49355470B9E327AEB1CC62259D08FDF29DBFBAF5C995FF
            F8344AFB7F3AFBF0FDFB8F9C3C9BD2FB2D9AC6A726E11E7CE502CB33DF985F78
            454E97CCE7D3899213DBB8D4DCE3E9BBB4E0C27043C8274046B21723B60A1AFF
            5E518066861018859579E3F901D78379DECCBD876070B57C13CB34EBEB4982AC
            940E8161E658694966ECC6BF07F8B9BE773BD30561D9BCE680E6A6F13D4E2DF0
            1B03842903A6359D43F333F2F7B1B1BF43D3BF56C07834FFAD1F98C97C8E8067
            803A418F063DCDDE3F737C7F2D896584600B6425CB18DF13DB1F7CE7E17B9E78
            BECDF1FD5367CED333887FF9BD27FF21941343036665DA0E7D907C680ED9439C
            C88A085D2A5EFF7A3D08F89D48FD42E9BFFEE71FDE7AEDF71ED83579F08BF719
            BDDFFD6BA77F4C25B41D273B5B78CB3CD35898ADC17582ED45A7CB1EDF5F77E6
            D3B8C7717CEF8CE6011DDF2B4AC5686608BE51A0276781B3C2EF2B94E7CD9C34
            08C8E5E149194B647EDD4D00CEC7BEC804848FF0E190EC1139561AA4EE1672DF
            8E8720EF6C6BDB2561D992E6489EDF27931E40D2079456CAE33AE59DF57FFB65
            8EF89E08183EADBF7FFFFD3C992F4FF13FC4382BB6E303F797D27BFB60FEFA85
            F949FBE0533A3291E126CFEF1DF0D6128EDFC2E501DAD1FB372944ECD8D8AE47
            BEFFD32B4E95BBA1D792EFF5268EB0C38662FDB6D78C5F1DAF13A55FAC60CBCB
            2C6363D37FFCD7B7FFFA3F7EF57E8E8DE4C471B73D08E7DA33C6AF76DAD3359B
            CF4F4C517A1C2F3699B8C22BF0F009BA8190233B9BAB8D99DA1EE79540A12413
            EB11C9B54DB5239BD2F8F7CA08D3C4105C1570EF09E82E1FBDFA1D8C636BC5C8
            F5668E30910A7CF950F2626FEAEB1F5DF61358C00B0D787CEF8CD228FEFD7632
            08CB7E57B9232017D963B0053973FB7EBE2B034072AF94A885272D9FB911DFCD
            466F7DF36BDEE629BE8899F4D355E869392FBEE17521D17B39282FDE7B371FE6
            9AC069763F195F3A72CC7BC74EF41E3EFEFCC695577E33733E7F0C0F26B3D658
            789E99D85CF85A11BD077A2AF95072D9638B4A3514E93757111BE5DC3947EFFD
            4E947EB113F2F077BAF0F84AD8597FF584FD91885C84D656E95C7C6A6B90C97C
            3E75C61D733CB16AD17B73A38909E17A5FC058D4FC222E7D776C72E6E452FA9A
            873FC85E6CB815C73B1E8D7FAF28004D57BB86105ACA9564500ED85FA5910882
            67C1270296FAB757929B83202B1AAC075F4F271006AFF7BDA517650B442B73BB
            79E992A41E28A0A6A0A941D95A6F770A877FED9DE4C77CA5F5946A547C64BB4F
            5142DCF17A3EC928B41704869963A5319B71E96503710A142B731B6C7815978E
            D497B768257F6405A31A151FD9EE53141F9CF6737FFB9D03DC1C383F1C2B9DC0
            3073AC3466332EBD6C9FDEBE1DC855E6564A649AB200F5ED346E6F9C923FB282
            518D8A8F6CF7294ACC04869963A5905A51144551946144B49CC8D77BD98B8FD2
            CBD6E6F8BE8D586A03A0D3103B3FBF7143BED92DE58EF263BED27A4A352A3EB2
            DDA728311318668E95C66CC6BD285BA052995B9C7A0FD01A7C6169FFFFEDBDEF
            8F1DD799DFD97F05A37EA35D99809205B86FAC00DC08F4BAB38A397198411AC8
            6A03B6579D055F885A78D656E2713314321821F288767AC160B1E6786CA4078C
            C04D94CC761867348945896B496128B7C2B1ACB129AA4591E6F4504D100CC9E6
            0F916AB55ADAE779CE8F3AE754D53D75EFAD5BF774D5F78342A3BABABAEEF951
            DFE7A95355F77C7B2C49A5FCCE268C7654BCB3DD0740CA04C28CA83465198FA2
            6C418A2A5C36EEDED57B8F1A3559D0D4B327CFFC3FB3B9795A0AE9D7DC2F9D94
            9F7CC2E02F97C2FFBE8C76D4028096110833A2D294653C8AB251420A52547E69
            EE7DBDD5C5D9DDDF3F79E2D929CFBA2D425F29BFE2CB74BDA925E5279E30F81B
            FCF0BF2FA71DB500A06504C28CA83465198FA26C55DE754FEAFDFC42B662CAEF
            6CC26847C53BDB7D0094C1F386D98974A228DB8EAADFDAAF4A20CC884A879371
            CEFF5E6D3C7398678FAB7683BA0761D90AE6D753C83C68D5FCEF7F72D17BEBED
            C6F1030FE9DD1EDEFBCC8BEF2F3B33D9E9C992E8F0AB678ECEE9F9F0CC46F529
            6ADE564195414F96B7B9BA74545B1AD37F28A374F7383B66E77FA26C95DD920B
            3DFCD4CDEC7BEAB3771DF27CDF336FBD77DF3F3EFFF44EF6007860FA777F7AFA
            DDDBA78FCC3CF8CC7F59A703C5CDDA7B3064CAA78FD46B169EB6A292FFBD9967
            4F77A23363259D096A502E5316D229E71DC44EABA7263484FF7D00FCEF01C893
            98FF7DC1F13368AB5E13222A0DF61E148E9EBA2DD8BC6FF7ECAC045FF5C74109
            CB9685F2C1FDEF7FFBA55FBB6989F3FD83075E7F4FD9E4EC7CEEF8699EA9FE99
            3FDEC82C7D6545BBFFB1EBF99475C1E10EB0B32CA9FC219949DC81B5B5DAE6E5
            9307778B8B8F3ACEC1C5E55BB2719F54242CB9CC0B5BE6A7EEE7FB89C9AF1C39
            93F9BE9B7CFF5FB922BBBEF5C2A9354AFC2F7CE337E80AE0F491BD0F1EF84FBF
            5EE979F04A0C93F2C3DE54D356F4E37F6F3B515F1E9976905A54C9F7999D92BA
            D470F27DD1FCF9F0BF7748B61600D44B5E088152347ABC3E6AFFFBDC0EFED43D
            8130232AAD47C6596454E67DA7968B8C41FB252C9B17CA9D2B0C35815145FFFB
            DF7ED9F5BF37F97EF9CACBDFDBCBF3EABFC5F9FEC0F1F50D994B9CD2C3863F73
            3BF7F18ED9C51539FEEF2CFC40BA9036D3B5DBD4C1F939765B1713B6AC24FC27
            4E271717677784C9202C79600720560A5933BAF97EEAD0C23C7DCACB1F7EE8E7
            FB7FF5D6F35F955FB33AD2F89EF2FDEBEFFDEACFFED96F961FBC2A03A7FCDC99
            463D3888FF3D75A2BE3C72DAE1E42DB620EA9DEFE17F5F846D22B9D5A4AF87EC
            C68CB46B01405D9409211085DD8DE298992ED70D3E5E2052030C6F0A5ECE0B1C
            B8A2FEF7A53B28026146543AAC8C39FFC9CD4C1E01DFE70B10BE125967C380FE
            7349405836AFB6E249C01F41EDDE87FFFDDCF6AFFFCBA52C2139F7F3773D7DE4
            E52BAE338D1AD3874DAC4D0BD4F197CEAA2EA10B3A4AFC4B7435489FC97E2B6E
            B054E964E5CD5C57E54B1E9C52B68ED9AFFC575DA48B741E4CCD9F78F9B95D4E
            BE7FE164E0A4478BCEF75CB52FFC93D74A0EDE0783A57C6A51F5EF1AEA8B21FC
            EF172FDBAED1ED70329AEFE17F5F80AD825BF8A05E4CDAB500A02ECA841088C2
            A6799D11789B1B7CBC40E45E4328AAFBDF97EDA009841951694D3256FEF73F78
            F5DF38BE40C440E9C44207D06B0AAFB6D4DC83F9DF4FFE8D7FF69FADFFBDBD9F
            6FF2132745CA97B73FF80FFA9626E786B2F13D8DE5E5AF8BFF6E7E8A068E6CA3
            C7DB0AC7F7977FA9FE516D640A4ADE7BBC18E47BB1679D9C9E9DD931F1BFFCA1
            3BBE577679A646D9F85E59FDDED0B30B140F462B3240CAA72AEA7F66E4E986AA
            382357BEFED9ECF6201174222B2DDF0E541DDE68DF87B012D52BF0BFCF619BC8
            0D49416863D2AE0500755126045F14D978DD267E3F43B9EBEE3E4C5FFEF725C7
            3704C28CA8B426194BF8CE1A63F0B1A34B58B6ACB683FBDF735F3EF6FBD6FFBE
            2CDFDF38BFBCF6EA3F925E9720AE9FDFCB9B14933CB834C7970352FEE1E39B13
            82AF09B6EBA1A1BC6A21AFF539C7610BE46F7E7BFE77F225978B83323FF530DF
            67BEEFB38BBFBEFAA17E7EFFCAF38F4D98E7F78BBFBBEF19FDFC9EDF51903FFD
            F6B1D31B1BEB6566EDD5E937E57BBDE95D459913DA3F9B9D1E24729DE8266CA7
            1D56F9688FC0FFBE32591493DA89A63CDB6F4DDAB500A0364A84E0E67BF79A40
            05F6C323F3BF2F39BE21106644A5C3C9D819A5D9B7D999D1E57BF5611303FBDF
            ABA63FF2EABB2A0F95E7FBF39F7CF892EEA43BCB27E68DC5B9F95E40767C3EA0
            1A50DA1342BFCC29FF603DEF554F6BF374DAB838FF778A4ADEC34F3D9FEFF5A8
            578EB37171E1092939A7F9BDFC7AFEC403D3CFFCF895B7CDF89E6AF7F6CF8F3E
            A3FE943BF820F495F2E923EDB37CEF2ACDCBDFAA6CFCDE23FCEF478E5B71BEE2
            81FF3D004462FEF7E1F13D68B35E13222A0DF64E8AD195ADCA5CF494C9F4DE75
            E25E18D64C5FD9F7E36BDEE86D60AA7F28F566F0C67E47485962D569472D00A8
            0177BC1E271B858E8240981195A62CE3D1958DB24E908D0A97DA27D2973B45EE
            B7F66B86B22FE5D4A016654B5DD306574CF9D49BF4B38329BF1D99B21DB50060
            6878CC06FFFBFA1969D9EE5EBAE466A3C2657823F9E6A16C5A31E5D36E94AAF5
            BF0D4795944FBDA956BA96F2DB9129DB510B005A4620CC884A696F000000006C
            45742E17E2F95EAFA5C748CB56F1D6F7561CE2131F5FBB1654A46C595F5BD3FF
            3334BD47F9D49BEEAFDD19E5A72CB1EAB4A31600B48C40981195A62CE351976D
            FDFA753703952DC9DAE1F7A68A33102D9C7737D44BF035D023E5536F065B3A92
            F2DB9129DB510B005A4620CC884A5396B12D1B65114ABAB46CDCBD4B499A964F
            6EDF1E3E0D571CE253E2D4FF503B6ACA9DA93EFCEFABC3A9B7C23B0AB4D45BC1
            B2944FBD196CA125A594CF5F2E85FF7D19EDA805002D23106644A5C9CA98069D
            54B6FB57AFF64E5AF7AE5C1926F1571CE2D7F52A7BC8EA20FEF7D5A1541A54A4
            6CA9B78285299F7A33D8A2164AF9FADFC60A7F831FFEF7E5B4A31600B48C4098
            5B2FDFD3D85DDD8B2ECB10F965E06F93571CE2D33EB4A7FE9F2DC5FADA5A5097
            C2852EAAEAAD603EE5F7E84DFD3F2DA51D99B21DB500A046F8FBD5D52753E149
            C35AE67FEF4E81672747AB0665081A6DBBA3793A865DE7E5BDE3CF3DA80E3D31
            B1F3C93F387EDA4C83BFFCE10B4F3D30F1DFCFBDCAEFD6B94510D454A932916A
            6E3242DAF90B7AB79CFFFDB6E9438BF211CBA75FFFDE93FFA3DA686638529FD2
            ACFF3D4F1227DB89A9F933379DE9F6E863C44246C1D34164ED5FF1413E35BEFC
            736D04299F0A6DD7F5F2F60B4F6F9B7860FF31FD4D56AE889E2F4FFFA6EA9A55
            C5EF44B507CF3449BF4AE3CCF6F2CBA1F6746EA2C8A1E07F0FFF7B0042FAF4BF
            0FFFAAA6D69698A00CD005737150C1DE5ECDE86A0F67270C4D667E3D8E9E5C3C
            3F645787C6F4F9FBF654366F0BE7FB9DCF1D7FE7B69E3276EAB9E37F2A7F7AEB
            A527773D3EFD9587FEF717D7CC20950BE2760E4F7AE058A71BD46EFFE9C225CF
            FF5E66A55D3EF2B507763DFFF36559D9F98D974EBFFBE9BDB5B1FADFDBECA570
            A7D7A54F9E347BEA2B0F9B24373736AADCC3A0A5C617F7146ECAA712D90F9285
            AFD21EFACDE9BFF7DF7ED3C9DF7EBE777B90083AD1AB78957CAF4C89E42FEA92
            08FEF7F0BF07C0272F8440291A335E0FFFAAE23F5BDBB1AF879934DD5C1C44FD
            EF6F9C5DD8B3EFD0219BEF65CE781E584A06C9DD4E0884D948BEB791D10FD955
            A094503600A5B2795BB27C4FBF528EDFA126BAE761E2834FBDF4C651FAF92767
            F57D693F5BA819911CEB7483DAED676BB703FFFB1BE7DF3EF3FCE39CEFCFBD7C
            64D7179F7EE12DFA50BEABBFF1EEF8FCEF7BE47BB18157A7029F85D3DF99FFA6
            9B2C2BDED51FC5970F6DCA0F7B937B70EA1FBC78F2D56FFF2D277FF7C8F7B94E
            B415E7D686FFFD60D82692CB441D4D82338D49BB1600D44599100251B8BB11CE
            5F792CA1C781591073362A382F70E02AB6B7CFFE518EAC834C10A984409823CE
            F79C5DD48D0BEB16CFBF15DE12CCB3D97332383A8AB7C5CBF76CFF2ABEEF344C
            FCADDF78FEE53519E53F71E4B5DB2B2B94639CF6226818ED5BA71BB2F24E7C39
            F4BF9731BDFFA1E7EF5DF9D3F1F9DFF35F75D9B8D7EFBBF97E7E694939CAF069
            B47BE1EC925F86CF3FCFBF4057B8D43EC42754CAA7427B9FF5F60BFFE07FFAA7
            EF6D6C7016578F4554454C13395D03FFFBD161ABE0163EA81793762D00A88B32
            2104A2A070E4CE8AEFFCD5C9CA1C4B786B70714044ECEDCD3FD2AAF37480196F
            BED728FFFBAC3E724BC47D2C5D40EF644F0B95CDDB5238BE5F7EEDD8E30F733B
            28F80E3CBFB4EFB4972A8CFEBB73DF9BB1BB999BDEC61FEF9DC5E776CAB07E39
            1BDFF3B2FCF20FFFFA7F67F37DB3FEF7C109E78DEF8D3BFB8B27E6A7A9826C35
            E7EC4A7C7AEF9EAE42CF6544F30B51CAA72A3A1FF4EEFB3F34AE728C5CF9EA8A
            38F9DEA94241279AFDE54A19FEF783619B08E37B00886AE3FB70BCEEFCB5607C
            1F5C1CC4EDEDCD3FF2DE16734BC01C460884D94CBE97470B4EF9243A7BB72F02
            A2C99E162A9BB7A5E8F93D7BBA6F7BEAA5B79779077EFFEBAB475EF915AD7FF4
            DA3F31EDE506E5F03ACB6D56F96E5EE67FCFEF00F2D5C3AF7EFEFC57F558FFFC
            DB3F3FF2D4AE6D5FFBA30FD6CC3FCA0129FFF0F14D97F3F07114FEF741140EF2
            FD1D390815858F5978BA502ECF1AB37C19C5109FA0DEA4EB303A3EF5FBFAB59F
            FD73F8DF2741765249EDF8B125FCEF41972911821B7EC33CE2FD55C57F1ABBCB
            CB5B1CB5DC8B83A8FFBD640427FA6DDEF9E0034925EC8AEB8C2E348130479AEF
            25CDD32108797570231B8499570D8BA892EC69A1A3785B38DFAB83DBF7F33919
            3FF0E40B1FEA7D68D0FFC5C7F8DE3E1BDB7FE10BDF95302643701BBCFCEB323F
            A97C7E77E59CC9F7CED5C33BAFFCF8C0F403CEE7DEA28CF5B3EFEA7FE40336E3
            7FEF9E70442EDFAB5427C70CEAA5A044EEB567C932A2213ED547AF51494851D9
            85AA9BBF55C5F96543F8DF8F1CB7E27CC503FF7B00883EFDEFC3BFAEDBAFADC9
            B778EE7B1707DECE85F6F6146DB23838BBF86BFE775E2F7E444E7FD06B4244A5
            C1DE0DC04F73ABCDFB46650BB6F4B50C30337CF5096AEECA5B02FADFFA207F61
            D828631CE2377FA625423B2ADED9EE0320C41F34C6B063B991100833A2D2E665
            AC6EEA5659A86CC196BE96C19C602ABECA4ECB00E360B9533442FFFB281587F8
            B57F179FE86CC26847C53BDB7D00F8F0980DFEF795D8B87B37482D3D162A5BB0
            452D772F5DA28B06CA49743435AF7EE1A23FB27F2A4E5043CBC0F3FA8D912A43
            7C6A61BD777D743661B4A3E29DED3E005226106644A5B43700000000B6223A97
            0BF17CAFD7468FBC001F0E257B2C5436B54243D211BD345EC6A7D5BEBDA69661
            EE258C852A37306A7F6BAFC9332D29DA51F1CE761F0029130833A2D2C664FC59
            35671A77A1B2DDBD74695CD9B4FAD509D56B734BF9B87F72FB765085C245EF5D
            139D4D18EDA87867BB0F809409841951696332AE9863DC85CA36D03BF0B551FD
            D5C2E294AF66D4198DBDFD30502F787C0000458B4944415450AB06E52F5CEA35
            C94D3E61F0974BE17F5F463B6A0140CB08841951696332AE9E3BD572FFEAD5B1
            8718FEEA60B5696869B99BB7945D1DADBDFD3054E98E7A6FE9279E30F81BFCF0
            BF2FA71DB500A06504C28CA8B41919571C50DA45659A14424CC5A981D432E897
            F2C74095AF1DD6FB967E6713463B2ADED9EE03A00CFE7E75F5C954946D47D56F
            ED5725106644A5C3C938E77F4F9B32B3DECC99A6AFAFE151D654FF45C7502B1A
            9E108D0FCC4CCD1D3D63670093496C8C8BBCBB97A0A64A958954B339DD2CEE5C
            786A36259E8B4D7E2578FEA34F6F9FB2F3FA3D30FDBB3FE58975A99C3C81FF84
            9DCA9716B1C9FF12EF556E6F9F59E0DBD9947C7826073D4F1CE1D4C54E79E61A
            AE9B09DDEC54718C9D4BAE68D6773351DD2717DFF8832777C941DC4A854B8DAF
            49D207E9358B5F59BF165E3F9A79F6FC4E547BC0FF7E70F4C96F9A17FEF70010
            A1104A1CE8EF6B8BDBD0C05E4DAD2D31A1E5FEF7CAFA573B0164F4F5EE9B1D22
            8765CB42B99AD694A738963FD0A77B2EF204EF6BDA8BE1490F0AFCEF651E5693
            35B9DDF715D8A06D9CF9EE43BB78DE7EF6E6D9A1E6EB1513DEAFECFDCD5DC64A
            47D9E43F75EC95B7EF5E7AEBD57F54686F2FD30FAB29F4A90AC64A5F3E432133
            39CCCCCE98F9196C2DAC1F812AB063B82E13B617273967D6779323F5FA8D8BD4
            4DBB9E3AFAFE325DA69C7AE9A95DCA67C8ED08B5D4F8083F77A6859575FAD7FC
            E67543AE13790F1681CC5D5525DF93A0CCC5B85C6A38F9BE68FE7CEBF26C5B32
            6B7CF8DF03D04E724258E12113BFD92301DCC6103D5EBF2551DD31B0BFF5EBC5
            D91DE27D67D222EF6D2E0E5AE57FCFA1B360A2C1EA33D87C72FBB6FE9F7CD9BC
            50EE3425A701D7459EF1B3859A1129EF7FEFBAB0586C9230C8E71E7AF5D2ED77
            FEE4C8B4CAF7ECA6F3D09347DFE59F6AF6FE378E4D3FAC2F05EC8DFDA060C124
            F0FCABEF98C795DA3377F2ACFCE4DD4C2DD47D146AD89B7E81C56BA134C99951
            69F6B9BABE3724EBFFC9AF2EAA3667CFA189BDC74EBFA77E75971A27DACB9D69
            6165FDFE0D7A90C875A2EA17F8DF0F856D22B917A5A3494E02A9D70280BAC80B
            E1E49B050EF476378A6366BA5C1D3AE4962A25F5D55F2CCCCEE841290F30BCCC
            6886615BD9FF9E4B39F9E8D4A3D916B557C5B7DE8207C661D99CE6A05F8C4B31
            B57BE0222F7FCEDA8BA03F15FADFDBB8C62B5C661EF0F1F85ED609695C3E96FA
            F52FE93131DFCCDFCB563A3CCAFFDAB153A14D3ED765E5D2DAABFFD82B98577E
            82B288713E5650F1F6D00924894D5E14CF3E599BB00581D834827764BB8FC9F7
            EACD733A634CE2578D73EACFCD45D8E9237B4BF23D5DA8C9316B80EAA0D714B9
            CAFAFDEBD61DFEF7A3C356C12D7C502F26ED5A00501779212CDD2C70A0B769DE
            09E336F8E8B4689F8BB9D7108A56F8DF9FA36AAA0265F74299208B942DC18CF7
            61D9BC504ECD6D9F20A8A7EF826953A7BDD4FD19FD7773FB57E18FCFF4F10BEE
            E7CB763644FFD2B6DF7AE9EDE5B553479ED8A60F3731B18D87F56C93FFF0DE23
            6F64D5597EED5FFEBDBFAC7721A8601B3ADDEAC3F239E18EEFE5768DDE9BE08B
            41530BF67B9572160C28F957DE2F6FFA6EF3BDBE057262E947EAC6BEBAB4FC0F
            E7F445588FF1FDC8F27D4165FDFEF57A9028E844B3BF5407FEF783619BC80D49
            766346DAB500A02E7A09C10CCAE5DEAD1EAFDBC46F42C7D22F17F74DC9C8D3C6
            6D671FA635FEF7D7A9152832AA271FD9B3CC208B942DC1CBED61D9B2E6C89EDF
            7B4D90F581DB5E6E500EAFB3D41359FD96843E7E59BEA75DAEBDFAED471F9BFF
            8F673213DE229BFCE5D33F7DE6EF7FF3C06FB131FF3BE7F97BF9BA607C37DEDC
            F690B7369C571A9DBBEE843E093825A9A298AA717D3DC375F52F7CF593337D77
            F23DEF303535A5DD72E5B3B67FE9FFF8577CAFE29D978F3DB9EB81C78F2C173D
            BFBF73E182FC7B0D78BD595459F8DF8F832CA249ED44539EEDB726ED5A00501B
            39215CCD39D0BB7944AEF25D03FBEB4BF3DBD5ABC1E689FB8D2C3151546A8FFF
            BD7A8FC97DB351ED176491C2C5BE966FA1A3E83505B7011F9AD1EFE7BB6980B0
            01DA692F2FB578D704C2FAEA9945DFABFE3A4540F995E163640940BAF9CB7B67
            FE87BF6A5ED3736CF239CD2B9BFC6DBB9E9C3F76E06FA86B02998AE7435D30F5
            E2A51CD9FF8A4170EDA6CFA7B374E6E85EB755730CD7F9D1C91EF5B26191E9BB
            9BEFE5807212AB5FEF2CFFE4F7FEE7BF22FB73695F2F793F9F16D9BF06E893F4
            5A4965E17FDF346EC5F98A07FEF7001081FFBD0A9E844D6A59A26142037BFB06
            BEDA72F9860E23B2B327BA36FADF579C8B3EEF35D740D906E3B3D27978EC70DF
            DB5E3CFB5E2DA8EF72E4EE2157A1E24B947AEFA149B637474D3B2ADED9EE0320
            241C34F6C6BF38A89B409811953620634A75410A295CF2AF82A71C620AE7E191
            07E11365F7C6DDAF1EA400F27D33B4A3E29DED3E007C78B8EF7FCFAB277471E0
            7C71AC7602614654DA8C8C831452B8E4D361E221A6AFA9F7D412BC90385E82B2
            952D7AEFA1E96CC26847C53BDB7D00A44C20CC884A696F000000006C45742E17
            E2F95EAF8D9260C858B8E4A7726BA66C4332C028FFA3CB97C73ECD7E95F9F369
            C9BF4439305BA23747413B2ADED9EE03206502614654DA8C8CABCCB7B3B59EDF
            BB50CABF7BE952509DDE0BED4FFFA5FF7F1C542CF008E7DBE90CEDA87867BB0F
            809409841951693332AEF26AD8D6CDF744F91BFBE765729E6DBB9EFAE7AFFFDF
            7FDF9D90E7CE850BE37A838F3ED716A3F792FFD2C4C024DF9BFCE552F8DF97D1
            8E5A00D03202614654DA8C8CABF8E5DCBB7245EF6DD85A21A624E5BFF7FE91AF
            3DF69D3FFCF153BB26B6C9CCBBFE0E3526D4EA54BF1B51E31549E2BDC9DFE087
            FF7D39EDA805002D23106644A5CDC8B88A1F6E30793EB1E5424C8F517E8F85FE
            A546DBD92855AEBDEC52E34387CE268C7654BCB3DD0740CA04C28CA874381987
            FEF7EE0C787AF220B5DFC64690480A97E02D363A845E5364F3DC112BD6666073
            75E9A8F60F9E30AEE43C9F9ADA62262D12789E04C7703DC39DB44EF6F76AC293
            AD3A1B9CD9C7C203AE7FF8D6BFF8878FFE25DAE981E9677EFCCADB52AFD0297F
            EDF462E03D7FE7C205E77545359D933709BCDA39AB8BEBA36FE6E9E312DA09E9
            6C5BAD2ECE6E9F5F3AABE7B393B98F78EA5F99FBEFDDF78FCF3FBD5339013CBC
            F79917C50A285BA85472AC7AA0CFD06B96A0F5BCFE95DFA46484A9D6359E0DD7
            4ECCA7F680FF7D6DC0FF1E80119117973359A7F71831B767DE20DF81B6EA3521
            A2D260EF41E1E869730DC3F3E72BEF514D957BC8C1DDE3B06C5E2837F9DE75DC
            DFBC7CF2E06EB1CCB181DECC60CCAD29F324B886EB1AD947674D99057DCF6167
            52550D7FB81C51A66E55932B8507B4B3F15FBBFA17EFBFF08DDF3870FC06D52B
            70CA1713FD42EFF97B57AEC8150F35A6EB9A9FAF8B2AB0E3A32FF3F0DB1232B6
            AD24DF9F59E7F968BFFDF287FC5502B6F6F92215465E2CD8F5AD174EADF125C8
            D16FED7CD0FAF9AAE5FED5AB72AC7AC89D69B9EEF0FA376BF00C9EB902FEF723
            83DB41665CE6C6C93A42B1656A01407A48E81071694FFD6B4E30F1C8ED7959A2
            BD6390EF4FDD130833A2D27A64ECBBE1E950EEBFFAF4F1B56B3691942D418209
            CBE685729DEFFD99D895D501C5EE9B26D06BE33E89F294477DC375453037BBC2
            FB2C8637F011AD153DE5FBE08062A468328AB96D1E3AE5F31C7CEE58DFF7A6A3
            7CBCFE17FFDE73CDCF9296A94B89CF9E29A16CB4E557F97EE3FEB91FFEDD07F6
            1F730AF0676694AF1A5FFC7EA68FBCAF7FE5E5D37BF7E458F5903BD372DDE1B7
            B9571D464E2AF8DF8F0E3E911E995DF8C52A9DE1B95719B64C2D00480E8E5D26
            0DA9A0F4E68A932C04491FDB0F9DF849B0E71FFFC44EC7EB47484520CC884A87
            9531C708B925E1B8DD1766D02A8FF029DBB9B7F4C3B2716DF9A30CFCBC80B7B9
            5941C76ECEF77A2F5B301AB50486EB0ADB88F6F874401EDFCB3A2111DCF97073
            51161ED066178DBC061F3AE5DF387EE0A1070FBCFE9EA975E83D4FD707BFF537
            FFCFD73EB9F717C6CE9F0FAB3F59D5C51658A32F7DBCA6B0FB48BE7FEBA3F55B
            A77FFF8907DD34FFCEEB07763EA4EE40F0F2DEFB541027DFE75FA718122ABE5E
            53E4BBC3AF97D3E0EAC1105D1FC0FF7EB4C8E53211BF6D0800A84CDE53FFE49B
            F3539353538FB2DC6C9C21F27BBEF8629141BE25106644A535C9D81D46BBD732
            1E7C33D9A493B2C5BDA51F96CDAB6DB5F1BDB979A26FDA73E32A1CB703FFEA84
            3F84FEB3F47EBEB534CE1F50EC6EFD70BFF1EB7F3DEB3BE5DFE839BE97BBFD0F
            EBDD89AFFC287B3661EB125C4E995FB984DEB36D9DCCFED7877EEF8DF7A9E5E9
            CA63EAE9A3C7D4CD7CE729BE6AF9707C5FE39BF90AAA8D5E638ABAC3EB5FDBE0
            EA37759B4BEFADEFE19BFDE51C80FFFDB0700BAB0BA94C35195BA51600A4477E
            7CCF630F152B24B2D97C94DF33A9F1BD46C2B78ACE7C6F5FB9FD87DCBF7A5567
            B5F2C59DE0252C9B575B9DEF25DB6DD7D747F25E83BCFB6003BD693EEF1E388D
            145DC32229FCD4C145B6373569A6FCF9BD3CDD7C7CE1DCCFF307DCE0AB0DF37C
            77E9FBFB0EFEF112E583DF3EB1CA2FED1BEBBC732F1FD9F5A07E7E9FF39EF7EE
            F68BD3EEEFBFF1674BCF7FC9ABCBA6E415CF475FD212174CFB2E2B2BE5576F6E
            7CFCABA37BF5ED0479B2B073E74E737CB9D450CFEF97AFBC72E4E99D3B9E38F2
            9A7A7E5FFBE09EF07AD3BB6431DDE19FCD5983336E6635ED00FFFB5AE17ACB8B
            20B9C773CC56A905000922A1839FCA5B4F7D0E62F6A9BC33FECCEDB922D19EF6
            F40CF22D8130232A1D4EC6CE284DBF3A4E99B6E09D02C56635A33CFB1DB0B06C
            5E3E30F95EACDC7D037BFA771BDF757AFEE1E2FF5560B86ECBB82926F8BA26E2
            62EE7AB1CB5B5D4EFAE13430353BE354D31E307BE572822E20CEBDA9B2DA679B
            9B7CADA39DF2FFECCA2B7FF8DCB41AC407DEF3C1989B46E45F7CECF9C59F1ED8
            F9D0337FFCD1DADA67375FD53E8C8E8F3EDF14D22F1B3A9F3EF9C4FC2BEFDEBA
            70819F17D8C7075C806DBB0E2C5ED1C77FFBE7479FD9AB6F3FEC7AFA7B8BF6FD
            FCDA07F7047D865EA3F6A2733ADF7AF0BF1F2FD96BC0F6DB07195BA61600A448
            E0A9CF318BDF2E67D4E333F5FC9E82546ECFD020DF8336EB3521A2D260EF5153
            E52D7DFBD65EC365AB0D958DECF30243C529EB7B2F1F5DBEBC7EFDBAFF269D1A
            59F22B7B9B1B1B1B77EF520356797452B6D43887AECB56EDCDA16947C53BDB7D
            00A44C20CC884A1B9671C59CA7E69FD992218647A234D294FBA23936FB37D7E9
            BD506E56CB00F3FC142E54BC114DFED3D984D18E8A77B6FB0048994098119536
            2CE3CF3637AB243C35C46F6588A116B877E54A50DF7496BC4B615D743661B4A3
            E29DED3E005226106644A5B43700000000B6223A970BF17CAFD79AA2E2DCBA34
            C46FBE6C4DB2B9BE5ED74DF85A16FBDAC48868776FF6A01D15EF6CF701903281
            30232A1D8B8C29B504C9A670E9428859BF7EBDDE27FA832DA34EF6446713463B
            2ADED9EE032065026146543A1619571CE27724C4506B7C74F97250F726970692
            3DD1D984D18E8A77B6FB004899409811958E4BC65586F854B6F5B535FD0F6D67
            E3EEDD2A5F56AC7D6926D913C9270C9E4C22307DA8857664CA76D40280961108
            33A2D271C99806B5D1FBD854B6D17D3D2C4D1ABEBD3F8A7975CA483C61F08C3D
            3993985A6847A66C472D0068198130232A1DA38C8D835CE94265A39F239AFE25
            593EDBDC6C20EBDF5D59B1F31836436713463B2ADED9EE032065026146543A9C
            8C95392C1D63626272DFC239995E3474F52F85125BEF3BD87414B5A2EFEA7BF3
            E912EBAB675E989B521FAFA61EE46953E557C3ECC262B645D9AC2978F2423D77
            AAFEABE26FCFCE3EA2575DB73477FE1C9E3E4F265E1DE57D0795F54774879F8E
            4CC7D79FD414D4A07ACD222D99F9CDF8FDAB1A5E611A5B66BFB713F1AA3D7866
            69FA55BA5EFBE5D883D86974D589A1CC05146A22FDDC7CBAFA08FA3733ADAC33
            9FAE39E5CC9FF227A1FE000BFD41AF8D1D350DB33D75B30974D58C9E6AA246A9
            8BB193B0D036BD06404709E5EF840AAB7D3DBFBB1159A6A9C9D9A3E73852D914
            B96376E197145372812EC8A11BB924EB419BF59A105169B0F7A070F4E4B272E8
            E4B9FE2594BBB9B998DE26B95436B5C277F56930EA85723565BAB6A6156B81ED
            C6E1C346F960DD45E77BB59D0FAC7FC9EDAF7B63D21C5CE654A70D45071D05D4
            4435CECF73FFEAD5713D1FC99D69DC92DB676667B4CDBF6A6A3FDF078D4C27D5
            F6E9D999DD7A227DAF6B24A347F23DE535639AA02EDAB27C5FE49793D9C618BF
            9CEC94634722DAB45E7A1266E42A3E2636CF2DECD977E890CDF7CA26CA3876D0
            55D48D8B54DFA9F9A53BE23FE43B0122DF83AE93973F0F17454D6272C3318456
            F6CC3E7B28CBF72B8BFBBECE49DA7A4EAE2EEEE3C46F44774B6CC2DC40579A43
            4D92D5BF6A026146545A8F8C6D64E4D9641F995DF8C52A5D92547B1ADAE3D574
            2A9B5DBFBBA286DAB6FE3DAC48DD9C9DCBDF9ABEF2FDD4A185F9DD2A557005A7
            BF33FFCD30158D184AD2EB6B6B03BFC67FF7D2A58FAF5D1BEF9B10B9338D4EDF
            3D7327CFCA4F9BBFB3F33B9481BA3E983BB1C23FA5DF6DD7B06C6E7146EF99EF
            B71FFAD10F76CF88AF019D2D3353DF3934A7F62CCBF76C53E1E67BF6C335E798
            A2C749989154A6745A95DADFF7D93CF16FADEF83B39B26A95A00D03805EA3632
            095CE28A924EE0F8451B8C6758A8B5B21C5AE45A4904C28CA874581973E1E45E
            83B66755573A84BA4318A7C78B7B7414F7D78FAFBC5A14CA15622E5492EFB938
            8C13D37BE67BBDBBDA5F85C2A525D55B5CBBDD0B6797C268D8189F6D6ED2889F
            9237E5FEDECFF829C7DFBB7285AE121A7E4E5F0635A85E53D0D5EB1EBA84922C
            AEDE8A574DEDE67BD50FFA410CE5A7FD9C8D78942F8F57F4FE17D9AE70FEC4C9
            68BE17CF694ECF7CD2CE64F67AD9FD7CE7090E33A97D9675BEBFE29C570AF74C
            23DC9330830EA4D712802BA74B4C95520E93A6E51717EC758FB39B26A95A00D0
            3881D8992C5478CFAFF37BCA05817EF2A8B879667E5AEEA5B907D14933CCA1B9
            24EB429BF59A105169B0F7A088851F5D7BAC2CEE53B1D8DEBEA84099890E95CD
            DBF2DEF1EF3EB4CB84F21E432BB7B90B3A49E86F7CAFC67693732F9E989FA65A
            B2716BD141C7C2A7F7EE054B22093EC03FD31C2765468695BAA955FFBA9DC228
            C75B83DCC337FBCB95F2F4ECCC0E93EFC5DE9EB1BDA957D8AE7E726EF1C4FC94
            B6DFB5F93E3FBEBFE55CB367E37BFF2E37C6F700748440EC4C26136FF01D2411
            79CB6DB79BAA295DEEDFADC71216098993074F9CFD3725395427D9CCC65D0884
            1951694D3296B22ACF72F56A5BC9CD87320AEF5453D9BC2DEF1DFFCE833BBFF7
            E675F52F7211A49EA6A877221E316F63B9CD9DCBDF9A7EF3FD1DFDC4B7F00E0C
            A88077A67977B74CE2B14D2DF88DEC8ACDD8D2DB842DCF9BE9F8926BE9688F4C
            CA0D0379A0AE3EC5762BFF7562422E08ECC795DDCFCF32A2797E9F9D726C84BF
            FFB05C40149F84193549AC1E9C5695AB131E73DC5F3DF9AC3CBF3FBBB09B6ABE
            74479CB983D096542D00689EBCFCEDF3FBF27CCF7BEEDBA7DEED153657970E7F
            7D5FC18BBD9243D5CDE3E21CAA93AC09899A409811950E27636794A6ACF8B337
            7EED0BCC9528BCAB4F07F1B6BC77FCB907D5B1D5EB72B7964F1CD62F2E4EEC9E
            3B4A1FAF0E16E67BB507E1B45595FBF9B2BF17FD1F5141D0D91F5485DA53AF29
            E5648FBBDCFCAD1A9E9B9EAF1D6D237BD707EA6DBBC7B31BF2F47719FDABDED9
            5C3D757876871CC5BE346B4F09F92CF5D1B667B3FBF9D2E52C62755853B04D9D
            EF957AD52947E7FB097E83BDEC24CCA03FE8B53143B5C8DA97EFE4F30B0AD250
            4ABC6A20A26B178A9736EA35003A4A287F0E21FC1B6FD0F7F3DD60C2A3888B8E
            E86440E2ED40323C9FE550F5A5983087DE0993AC2E8C8636EB3521A2D260EF31
            F2C9EDDB5E76CFE77BB3F0BB7B60AB91CE99D630EDA87867BB0F809409841951
            6952320EBE784665737F7597C666810575D1D984D18E8A77B6FB004899409811
            95D2DE00000000D88AE85C2EC4F3BD5E4B83CDF5753B88A7B2D9F5C2A5C9E9DF
            EBC2BEA670F7D2A5345FA41F11A99D698DD18E8A77B6FB004899409811952628
            63FB209FCAA6567A2C5B2EE5BB85D7F3067683CE268C7654BCB3DD0740CA04C2
            8CA8344D192BB75C2A9B9B1DCB96AD953283C2D3B215EF520C406713463B2ADE
            D9EE032065026146549AAC8CEFAEAC50D982D458B86CAD51725078B57421E527
            9F30F8CBA5F0BF2FA31DB500A06504C28CA83459197FB6B949650BF262D9B285
            527E7E9A01B56CDCBDABF7682989270CFE063FFCEFCB69472D0068198130232A
            4D59C654B6B2EC985FB64ACA0F8A6D97AD759762003A9B30DA51F1CE761F0029
            130833A2D2E1649CF3BFE7C902D586622FF0BEA0A37886B96A7EBD9DCFBCFECE
            F2EDF3EFBC7E60E7C4F491F769FBF2E9D7BFF7E42EFE502AC6D7D40C446AE623
            35AFAA2073A56553E6A9BD89602255BD75626AEEE81955FC98C1B9CCB36B271F
            758E6177768FB0FBE9EF2DBEBFACEAB2F3B9E3EF48D5B82E0F1D38BE76E9C287
            FFEF9399AD8B1C309B5A6E73F5CCD1393DF95FD1444B8943A5D66B16BFE9B209
            EFEC6FAAB2AAD7789BCC866B27E6537BC0FFBE3AF0BF074093D732511461846C
            1F25A260A3CE2F9E7387EC42D869376D1821A21FE4EE1C1CDC83FE45AF091195
            067B0F0A979EC288F891F0DCBF32BFA9F6DE18185536FBBABE994F77DB63CFBF
            BC96E5FB77978F7CED819DDF78E9F4BBB7CFBF7BFED837BF3CF177E9734D03DA
            32A8F81E4C91EB936D57F3265273DF743C8FD57CEC81C139F7846BE2CEC79078
            6A5B2038C2B776EE78E2C86B6B45F9FEC6F9F7FEFC5FFC6FA619F501CDD4B3F7
            795645ED8FC4EECB5359D5B606AA371DC2A673DADFFC663393829DF1E07F3F28
            74E108FF7B0084BC9659130511C60F05B23235F7C2198EC3B796170FEA7FE4FC
            B27B66765A5B75679187C2C2A9C3B34A564E0A8F7E507871E01EDC23106644A5
            F5C8D894926740D7898A8A6BDC3607C596EDE36BD74CBEDFF9ECF3071EDBF6D4
            4B6FBFADF3FDF2CB47767DF1E917DED2D704F4EB97FEF213FFFA0237E0F6DF59
            F8C18C8ABF9C35A70ECECF3DCA7DE0A504076FBBBA82F187DA050668B49B67E2
            2E9F4B9FA1EE7C504ABEE9BB2ADDFFF9F35FE56297E4FB0F7EF835F96F3B5DBC
            F189092690E75F770CD9BC0D933BD3C2A6F3DBDFB6A4FA8D90EB03F8DF0F87D3
            AAD4FEF0C703DDA450AAC511C60D051B9EF18703E7EF8327574EF04FFE6B96EF
            D561E522DBA6F0F80779F93E3CB84720CC884A879531271E750350869ECE5CFF
            DA936308E8107A8DFAE7EA55730FFCFF7BE9C92FEE3A70F42595EFBDC449CB1B
            C7A677EC3DF2C6BDD79FA380B5745675CF4714DF772F2C2DA93EE0C65525548E
            6A06DBE8F28B78992F2C66DD66373AFF423DE19BB83BC756178F6EC77FFEE9BD
            DBEF1FD9DB23DFD35FBFF0DD9F6DA877C5DD34EF958DA8E172AA61A845F49A22
            D774411D9D9684FF7D6D70E574899D5348351AFCEF41570894AB288C3012094C
            28B0BAB07F91DF2888FDCE1E4ED27484DDF2D0D03FBE1E515C34293CFE41CEFD
            FCFCC13DE87FF49A105169B0F7A0E4AC7983F1E8400465BBFFE1099523D75E79
            FEB16D5FD9FB9B0F178FEF773D4CF9FEC6F1035F78E8B933EB528CC57F373F45
            03BB6BBA0FB871DDDC69F0B653E346C7F78E3D20C363237342D83BA2DE10F093
            DBD7687CFFC0932F7CC8F97E8729B69FEF9F3FC567099F0A074F2CFD485F4E06
            EDC9BF6EE9F17D41D3F9ED9F494B21F7DFF4DEFA1EBED95F1E79C0FFBE124EAB
            D2198EF13DE826817299F208938502DFD8D38417BEBDAD0C3905CE836EBEE721
            8D3BBEAFF24159BE2F38B87CB881B6E93521A2D260EF4191F04D55BA7969591E
            6C70FACFDA6540C2B26D9C79FEBF7954C6C47FFAFA01791C4BF9FEFCAFF80EB9
            7E7EFFF6CF8F3CB56BDBD78E9D7A97F2FD430F1E78F3EA356E6B6A54EE5AD307
            BA717BE47BE7F93D757099C1B9978375F4E424A2FA9912B67A7EEF1CE1BFFEEC
            E8D33BD5D5C95B2F3DB9E381C78F2C2F9F5F3B7DF45B7AA393EFF980535353DA
            8157E712FDFC9E9F1B4D298FE4AD83D79B454D07FFFB06705A559D51F0BF075D
            24A7657768978F302614E8E7F7627DEB8D224CB2D361DF8C2DE958E1F37B77D8
            50FE416ECC090FEEBDB6150833A2D2E164EC8CD2D41BE35C20F935F77EEF00D0
            61F49A62E3CC3FFDC2977FEFA57334265E3B75E4896D133C50A6F1F13BAFFCF8
            C0F403F2B1133B9FFC83E3A7D7CE9F57F9FEF5F7CEDFFF60716E520DF8DC7CAF
            F626542BEBE367DBB3F7F34B0DCEBD9E303D7776293F7E728EB0EDAFEEFAE294
            7A457FEDF48B87A61F96AD0FEF7DE6457E69DFCBF772C009BEE6E0DF08E7BD50
            A7785B062AB55E2B693AF8DF8F18AA45D6BE7C7308FEF7A0BBF85A3EF766CF08
            6343018597338B5E1CBE78CEBB55A0C2FE5B4B65EFE72FBD55ED83F2170784CD
            2919F4017A4D88A834D83B290ACBF6D9E6E6DD95157DF7BEDA42FBD37FE9FF1F
            1F54062ECF3B2F1F7B7297DC9908CBA9964FEFDDD3FFD02E523ED3464A3B2ADE
            D9EE032065026146549AB28CCBCA3648CA4FC08C2EFB6261CF05F9BE65B4A3E2
            9DED3E005226106644A529CBB847D90648F9772E5C18EF34F51F5DBE1C14A970
            D9DC50B7B0DB466713463B2ADED9EE032065026146544A7B03000000602BA273
            B910CFF77A2D3DAA944D39E7F6B5DC5D5969FEDE7EC5C13D954DFF43EB48F94C
            1B29EDA87867BB0F80940984195169CA32AE58B601523E2DEB6B6BFAFF478FE7
            02D073A1BAE8FF691D9D4D18EDA87867BB0F80940984195169CA32AE5EB6C152
            3E8DB91B78584E1F51DDE5AFC9AB9086493E61C89C86F0BF2FA11DB500A06504
            C28CA8346519F755B68A6FBF070B65E2F5EBD7F5214640BFEF15B6D81237F184
            C1DFE087FF7D39EDA805002D23106644A529CBB8DFB251CAAF3E927697BB972E
            8DE25B70FD267B2A86FECF36D2D984D18E8A77B6FB00489940981195D6216335
            9BA9323591A95EE9A0139366D2C1C109CBE6CD8BB77F71E54DE757820BB0F1E7
            A7FE60FF97F8B76DD3871679A23D49A5CB575E39F2F4CE6DBC7DE753C75E79DB
            CDB276F9E8F2E51AB3FE00DF18FCF89A9974A98D50DBEB358BCCC698CD1E6527
            BCB3BF718731669EBD6B3C1BAE9D984FED01FFFBEAC0FF1E8031E10634E5C4A6
            D71514793657CF1C9D93AD7E240975EA415BF59A105169B077FF6CF214FF5333
            B3536CDF22D39ACA14B07796E6F5D4E5831396CD0BE50677A34C6EFCE503FFF1
            834B2B3C29FDD433AFBF27A974F9B5638FEFD87560F18A4CBCAF67E12D596AC9
            FA9BEBEB34580F8E1C5DDAFACD7B45EE4CE39923E17FDF1C9BF0BF07606C1404
            B42C40114A8FE290C20616FB4C10CBE9544F43AE09841951E9B032E6BC3E3D7F
            E617E2ADF96B3BC9B05F930109CBE6857283B3512C103870D3D8DA7B83EFED17
            9EDEF6D523AFFC8AD6EDBCFAD95F8B16CAFA834DCE431FBD7EFD7A70B42A0B7D
            A23E444BC99D6934C286FF7DD338ADEACCC5ADAA0C7F3C0046465E535E962CB5
            3CCDE9D444484520CC884A8793318D03A68DF30FE5FB8B8EFFF788F23D6D136C
            54759A2068D0F5B5359D4D4F1FD93BB1F7D8E9F768BD62BE57CB9D0B17E8BA61
            E3EE5D7DC49ED0E8FCE36BD7067B8180968A9FB275A14ED36B0A1A61C3FFBE71
            B872BAC44AB3125F54A3C1FF1E809191C5151DD0082780280DFAB95CC8E9D4DF
            870EA7D784884A83BDFB848A623330B1EDAF4DFDB5318FEFFDDB1D9FDEBBC709
            B8FFF17D7EA1F1370DDC69D04FC77417BAAAA034DFEFA3FA6069F79B7A0ABF37
            E526959C34820C2BFDFEE5DF9C13A8DC341AFEF77DE0B42AC6F70034475E535E
            960C2C4033121ADF5BF43588DC51A7C878D3B11E1F9CB06C45B5F53672936D57
            63323645DDFF7D6AC8CF36373F5A79EDC8AE07F9F9FDF2A9979EDAD5FBF9FD58
            16BA6E90CAB419AF37BD93DB9CD07EFFFAF27033ABB18C84FF7DFF38AD2A5727
            F0BF07A011FC80A67047C54A8FEAF9FDEAD2E13952A6EC93D3E9389FDF6BEC3D
            875BE716D430ACF85DE5BE08CBC60DC687164C62C8A23393799F4FCECE9F58D6
            5B3FDFBCFE5F7E7FAFBC9EFFC0F4EFFEF4F4BB41BA1DEF72EFCA155DCC56438D
            AFD7A83F789C6D4F5C377F731F31F0BFAF1FAA45D6BEAC56F8DF03D0145EFAD2
            91CDCDF71CB996742CD9313BFF93ECDB6DA14E3D68B35E13222A0DF64E8A7ACB
            C6EFCC0F77D77D14CBDD4B973E4BC09BBF01523ED3464A3B2ADED9EE03206502
            6146549AB28C4751B6C15E9E1FD172E7C285164FA817D0D984D18E8A77B6FB00
            489940981195A62CE311958D52EC47D5DCEA46BDB4FE9D7C97CE268C7654BCB3
            DD0740CA04C28CA894F606000000C05644E772219EEFF55A7A8CBA6C9F6D6E7E
            7CED5A30E66E60B973E1C26093F96C69523ED3464A3B2ADED9EE032065026146
            549AB28C9B29DBE6C6C66076BA832D9D7A66EFD2D984D18E8A77B6FB00489940
            981195A62CE326CBD64CD6FFE8F2E58EBC8D9F27F984C15300C1FFBE8C76D402
            8096110833A2D29465DC7CD928EBAF5FBF3EF09CB83D163AE6FADA9AFE984E92
            78C280FF7D6FDA510B005A4620CC884A5396F118CBF6C9EDDBF7AE5C0972F660
            0B65FA8FAF5DEBECB0DED2D984D18E8A77B6FB00489940981195D62163D7FFFE
            F3D0637B08C2B279131415FBDF6FAE2E1D5556C1E154446A1EB46C26BE2A5092
            1E26F1DFBD7489C6F4C8F40AEA13BD661153DA6CDE567FAA44B7B7CDD924B3E1
            DA89F9D41EF0BFAF0EFCEF0118136E40EBCFFF9E85F993F9D91D854995F6D66B
            4244A5C1DEFDE3F9DFF3BCA79EC7F6508465F342B9C1DD2886E566FEFC1307F7
            1C3665B8BFBCB06FF6D0B3FDE67B17B6C6B97EFDA3CB977B1BDBDF5D59B97FF5
            2AA5F9769BD90F40EE4C13673CF8DF3746A8CD9CAF36FCEF01181905012D0B50
            84D263DEFF9E671FDF33FBECA124F2BDE77FAF3CFE0A2B360861D9BC506E7036
            8A9D8913B8030AFF7D50289D5B8B3CB5601CDF9BDC9946236CF8DF378DD3AAD6
            0DC85419FE78008C8CBCA6BC7CCF162185FEF70AF7CAC023106644A5C3C938F0
            BF6F20DFD336C1465515AA24BE473ED7D913340F759A5E53D0081BFEF78DC395
            D3257634AB1A0DFEF7008C8C2CAED867DF6E00511A2C4D4F49E47B0A19360313
            BA1AF96031187444BDA6286C1167A3EFBA9623D2A060B4F8BD09FFFBF1E0B42A
            C6F70034475E535E160F2C404392C8F796C6C6F7B984ED6EE4260BFDEF330AFF
            1D3485D79BDEC96D128FDF41FE59E4665663530BFFFBFE715A55AE4EE07F0F40
            23F8014DE16671A5C7BCFFBD22D17CEF8EF8ED5D8B01A143E8350537983A3261
            1243169D9912FF7BB9D16AC98DC0400350C3EB35EA26EF4E8C9BBF550FD1B903
            FFFBDAC96913FEF700348597BE7464F3B37899FFBD1BA0722FA8D126BD264454
            1AEC9D1429970DF44B677BB31D15871801489040981195A62C63849836D1D9DE
            6C47C52146001224106644A529CB1821A64D74B637DB51718811800409841951
            29ED0D00000080AD88CEE5423CDFEBB5F448B96CA05F3ADB9BEDA838C4084082
            04C28CA834651923C4B489CEF6663B2A0E310290208130232A4D59C608316D22
            F9DE84FF7D2F2046001224106644A529CB1821A64D24DE9BF0BFEF0DC4084082
            04C28CA834651923C4B489CEF6663B2A0E310290208130232AAD43C6AEFFFDAD
            E5C583DAC177E197667ABB0109CBE64D50D497FF7D66EC3D397BF4DC08C67020
            0A35BE5EB388296D366FAB3F55A2DBDB660A2A990DD74ECCA7F680FF7D75E07F
            0FC09870035A7FFEF756A793FB16CE79AA2468B35E13222A0DF6EE1FDFFF7E75
            711F2754E3A85D665D538DB06C5E2837B81B4BFDEF5716F77D9D5B8ADD7B7B78
            128011923BD3C4190FFEF78DB109FF7B00C6464140CB021451E67FBFB1BAF80F
            65F05CA04A22106644A5C3CAB8C8FF9E8858D555232C9B17CA0DCE46B13309A7
            17F68878108111923BD368840DFFFBA6715AD5BA01992AC31F0F809191D79497
            EF3937F5F0BF278268A309841951E970322EF6BF77B60F4558366E30DA26D8A8
            AA4295C4F7A2067551B72246F24E1688429DA6D71434C286FF7DE370E574891D
            CDAA4683FF3D0023238B2B3AA0114E00511A34D1AF003DB4BEA97F35D0E1F49A
            105169B0779F50C8B01998D08FF0CF2DECDFAD03E550D011F59AA2B0459C8D3D
            6F2A88F7D76EB95B02C681DF9BF0BF1F0F4EAB627C0F4073E435E5E5FBDEF79E
            F95EE3E3EAB9614020CC884A6B92B1192BB0A3DFD7F715BDB5340061D974202E
            CDF7D26485FEF76C63BA6F5F68F1099AC4EB4DEFE43689C7EF5F5F1E6E663536
            B5F0BFEF1FA755E5EA04FEF70034821FD0144EBED77A2CF0BFE75CB6EFEBCEEB
            E71E8130232AAD49C626DF67B746097BD76240E8107A4DC10DA68E4C98C49045
            67A6C4FFDEBF0F911B818106A086D76BD44DDE9D18377FAB1EA27307FEF7B5E3
            AA40B409FF7B009AC24B5F3AB2B9F99E235791FFBD3C25CC085F50A34D7A4D88
            A834D83B29522E1BE897CEF6663B2A0E310290208130232A4D59C608316DA2B3
            BDD98E8A438C00244820CC884A539631424C9BE86C6FB6A3E210230009120833
            A252DA1B000000005B119DCB8578BED76BE99172D940BF74B637DB5171881180
            040984195169CA32468869139DEDCD76541C62042041026146549AB28C1162DA
            44F2BD09FFFB5E408C00244820CC884A539631424C9B48BC37E17FDF1B881180
            040984195169CA32468869139DEDCD76541C62042041026146545A878CD56CA6
            FE8C5D69F9DFDF3AB7A0275F87FFFDB8A0C6D76B1631A5CDE66DF5A74A747BDB
            4C4125B3E1DA89F9D41EF0BFAF0EFCEF0118136E40EBC7FF3E9BF5323DFF7B8D
            4C449ACD13382061D9BC506E703796FADF1B38C1E48E001A2177A6F14902FFFB
            E6D884FF3D0063A320A065018A28F3BFB7F010253C404E9811950E2BE362FF7B
            29BA8DAD831296CD0BE5066763D4FF5EE2B57600030D933BD3E8F485FF7DD338
            AD6ADD804C95E18F07C0C8C86BCACBF76C11D2D3FF3E1B7E7804C28CA8743819
            E7FDEF25E4317AD0330C61D9B8C1E4D8848DAA2A54497C2F6A508D5C0A10D6D1
            1C340DB5BE5E53D0081BFEF78DC395D325B69A352D0FFF7B0046461657744023
            9C00A23468A29F07C72BF594ADC0CF9D36EB3521A2D260EF3EA19061333061AB
            A11E390C3B92A623EA3545618B381B7DD7B522B2111B681ABF37E50E909C3402
            FCEF1BC269558CEF01688EBCA6BC7C1F588016206FA1E5EE9A07C28CA8B42619
            3B630541A27316BB07232C9B0EC4A5F95E9AACD0FFDEC0B74476846D0E1AC1EB
            4DEFE43689C7EF5F5F1E6E663536B5F0BFEF1FA755E5EA04FEF70034821FD014
            4EBED77A2CF0BF37C818293C4228CC884A6B92B1CEF7CE20ACF85DE5BE08CBC6
            0DA60E4E98C4904567A6D8FF5ED2BCFC977DAD1A340D35BE5EA30EF1EEC4B8F9
            5BF512BF910FFFFBBAA15A64EDCB57E7F0BF07A029BCF4A5239B9BEF397215F9
            DF3BB742BD2F9D6968B35E13222A0DF64E8A94CB06FAA5B3BDD98E8A438C0024
            4820CC884A539631424C9BE86C6FB6A3E210230009120833A2D294658C10D326
            3ADB9BEDA838C408408204C28CA894F606000000C05644E772219EEFF55A7AA4
            5C36D02F9DEDCD76541C62042041026146549AB28C1162DA44677BB31D158718
            01489040981195A62C63849836D1D9DE6C47C52146001224106644A529CB1821
            A64D24DF9BFC3D573DB36FADB4E334861801489040981195A62C638498369178
            6FF28C3DBB95B56ECDB4E334861801489040981195A62C63849836D1D9DE6C47
            C52146001224106644A575C858CD5EEE98E59C39CC66E339E3907E09CBE64D48
            B87F71E54DE757820BB0B9BA74744E39E1E5A61E64EBDE49FEC772C35C303AA8
            4FF49A454CE8B379DAFDA991DDDE36534ECAECF776225EB507CF004FBFF2CC94
            C62FC71EC44E57297F9DD8E14C6EAF26D2CFCDA7AB8FA07F33D3CA3AF3E99E79
            618ECF22FBA76C4BD91CD2F407BD3676EE2C9F98B7FEF7F4EBB945259689DD73
            8BE7EE680B00A9CBD4C1459E2D3883B6E9350040FFB8016D6276619123920345
            9ECDD53347E7646B3E9204493683F6D66B4244A5C1DEFD23D97D6A6676CA78F7
            725ADD3D3B2BC157F61898B06C5E2837B81BC521D8F8E59C38B8E7B099989810
            EBDED99929E4FB31913BD3C40977667666BB9BBFFD7C9F4D2D2DB013EEF4ECCC
            6E3D91BE169078E555CAF794D78CBB945C6A38F9BEC82F27339C367E393C4BBF
            F1CB39F92C6D5ACFB6C82937B55D3BCE39E42A3E2636CF2DECD977E890CDF732
            2F375F2D6D6827C01B17593E6C6FCDC1057E3900D4484140CB0214A1F4A8FC72
            2E9F3CB8CF46C28224EB100833A2D26165CCD97D7AFECC2F8C3F9EA4D5F953CB
            4546E0FD1296CD0BE50667A3D89715A673D55E87CF2CFF9117D94183E4CE341A
            61EF993B79567EDAFC9DF56F4E1E727D307762857F4A2A92FD0F2DCC8BF5CEAD
            68BEDF7EE8473FD83D237EAFF7971766A6BE73684EED5996EF33F76495EFD90F
            D73FAB5DD73EFD6BFEB44F2A533AAD6ADDFF4C95E1870BC0C8C86BCACBF76C09
            5690CE9930C97A04C28CA8743819ABEC4E03020A8854945FEBB47A677D7554F9
            9EB609F6E02A54497C2F6A5041B7D7CD30B28306A14ED36B0A1A61EFA1D1B664
            71F556BCD39584D3DBEA2E16E5A7FD9C8D7894FFF5C5CBEB66FF8B94B728599D
            8CE6FBF937CEAAF4CCD29AC9ECF5B2FBF9F241D9074FAA7B45E67EFE954C9C1A
            47AECC46E1694F07D26B09C095D325569A95F0A11A6D71C1AAC3D94D93542D00
            D872647125BB2DEF0410A54113FD1C82243BCE7C4F25B019B888E1523E1D40AF
            290A5BC4D9E8BBAC3AB80F6819A4FC3140EDAED718C7E4919161A5DFBFFC9B93
            721CAB6542EEE19BFDA5DFA7676776987C2FF6F64C90EFC5AE7E726EF1C4FC94
            6B9F5F3CBEBFA5EF72F3E9A4F23D8FEFFDBBDC18DF03002A91D79497EF03CBEF
            8C20C9868FF069935E13222A0DF61E94E0D2A378A0D32F61D974202ECDF7D264
            DBCDF3FB5387F77FDF6F5C95F891ECC783D79BDEC96D128FDFBFBE3CDCCC6A6C
            E96DC296E7CD747C39E5E8688F4CCA0D0379A0AE3EC5EA8AFF3A31211704F6E3
            8AF33D1DD6664495EFE5C262C23CBF5FFAFEFEC37201A1B7A897DD1E715E09D4
            D424B17A705A55AE4EF86EDCFDD593CFCAF3FBB32C1F1A49F0E343BA2E72AF6C
            D2AA05005B0E3FA0299C7CAFF5A89EDFAF2E1D9E2365CA3E9620C96A02614654
            5A938C1BCBF7B44D611243169D194EF3B33BF8EF93B3F32796830643BE1F23D4
            277A8DBAC9BB13E3E66FEE3A66FBFC9B6F3AF2082E7EF96DBBC7B31BF2F47719
            FDAB14959D03D96BAE5657F259EAA3ED99E3DEFEA19DEEDB33CA146C53E77B7E
            1B7FE9FBB3729B6172F6F0097E83FDD6F289C36A0BBFE57E34F84E08437FD06B
            63866A91B52FAB955F50D062912FB36CDE3977D4D44E7DFB208336EA350040FF
            78E94B473637DF73E45AD2B164C7ECFC4F96C3B94012CAF72321E5B2817EE96C
            6FB6A3E210230009120833A2D294658C10D3263ADB9BEDA838C408408204C28C
            A894F606000000C05644E772219EEFF55A7AA45C36D02F9DEDCD76541C620420
            41026146549AB28C1162DA44677BB31D15871801489040981195A62C63849836
            D1D9DE6C47C52146001224106644A529CB1821A64D24DF9BF0BFEF05C4084082
            04C28CA834651923C4B489C47B13FEF7BD811801489040981195A62C63849836
            D1D9DE6C47C52146001224106644A575C858CD661A788DD8298406878EA1D714
            DE04457DF9DFF33446B20F914DC6079A849A5EAF59C494369BB7D59F2AB1E854
            92D970EDC47C6A0FF8DF5707FEF7008C0937A0F5E57F5F14093368A35E13222A
            0DF6EE1FDF9AD78BB6C31296ADF0E0EEC652FF7B7FDA42300E72679A38E3C1FF
            BE3136E17F0FC0D82808685E622AF5BF2FFAC78C409811950E2BE3C09AD78BB6
            C31296ADF0E0CEC672FF7BE4FBF1933BD368840DFFFBA6715AD5BA01992AC31F
            0F809191D7949798D822A4D8FFBEE81F33026146543A9C8C73D6BC5C343A2431
            3935B7989BF1BF3FC2B26507779C7679A38EEFE5EDC2CDAAFF3177A3123403B5
            BD5E53D0081BFEF78DC395D325369AD55BE17F0FC008C9E28A0E688413409406
            4DF47371FE513D77F3A0AD7A4D88A834D8BB4F2864D80C4CD86A28BF326B433E
            207444BDA6286C116763A9FFBD85EFD0EE086E548266F07B13FEF7E3C169558C
            EF01688EBCA6BC7C1F58801620313397E0026146545A938C9DB18220D159C78E
            8109CBA6037169BE9726EBE97F9F3D91054DE3F5A677729BC4E3F7AF2F0F37B3
            1A9B5AF8DFF78FD3AA727502FF7B001AC10F680A27DF6B3DF6F0BF977C6FDF40
            3204C28CA8B42619EB7CEF0CC20AEE3CF44B58366E307570C224862C3A33C5FE
            F732AC97FFAAE12903180C6A7DBD461DE2DD8971F3B7F41201FFFBFAA15A64ED
            CB57E7F0BF07A029BCF4A5239B9BEF397215F9DF3BB7428B1E46D366BD264454
            1AEC9D1429970DF44B677BB31D15871801489040981195A62C63849836D1D9DE
            6C47C52146001224106644A529CB1821A64D74B637DB51718811800409841951
            29ED0D00000080AD88CEE5423CDFEBB5F448B96CA05F3ADB9BEDA838C4084082
            04C28CA834651923C4B489CEF6663B2A0E310290208130232A4D59C608316D22
            F9DEE4EFBDC0FFBE0C881180040984195169CA324688691389F7267F831FFEF7
            E5408C00244820CC884A539631424C9BE86C6FB6A3E210230009120833A2D23A
            64ECF8DFBBB39B4D8AA9C9108465F32628EACBFFDE9BBA283FE32968006A7ABD
            661153DA6CDE567FAA44B7B7CD1454321BAE9D984FED01FFFBEAC0FF1E8031E1
            06B4BEFCEFBD693D730F1C69A35E13222A0DF6EE1FDFFFDE71A01F9EB06C5E28
            37B81B9D4FF7FDEF654A423535311813B9334D9CF1E07FDF189BF0BF07606C14
            04B42C40114E92F2FDEF9DB0534020CC884A879571E07FCFA173589B1C4B5836
            2F941B9C8DE5FEF714AF77E403316892DC9946236CF8DF378DD3AAD60DC85419
            FE78008C8CBCA6BC7CCF162185FEF7E2B29DB3C9B104C28CA874381987FEF75C
            A5C947A71E55B704871D4F8765E3A3F381191B5555A892F85ED4A082FC616AEA
            11F9CFD20B253052A8E9F59A8246D8F0BF6F1CAE9C2EB1D6ACD90AFF7B004648
            1657CCB36F2F80280D9AE8E7C0FB4C4E4D3DCAFF682352066DD56B4244A5C1DE
            7D4221C3666062FBDE6F7F438FB0EB709EA523EA3545618B381B4BFDEFB34B27
            B967527EAD044687DF9BD21172D208F0BF6F08A75531BE07A039F29AF2F27D60
            019A9145158981E1EDF340981195D624633356E0C7A214196FCA7DFE8267997D
            11964D07E2D27C2F4D56E87FCFA1CD3E98EC716F048C0EAF37BD93DB241EBF7F
            7D79B899D5D8D4C2FFBE7F9C56953802FF7B001AC10F680A27DF6B3DE6FDEF25
            DCD9F76C728FCB036146545A938CEDBD417E8F49DE8CAAC1693E2C1B37181F5A
            3089218BCE4CB1FF3D6FA7D0AF9E321458088306A0B6D76BD41DDE9D18377F73
            1731F0BFAF1FAA45D6BEAC56F8DF03D0145EFAD291CDCDF71CB98AFCEF39BAD1
            F5B7FC9BFA1E8D076DD56B4244A5C1DE499172D940BF74B637DB517188118004
            0984195169CA32468869139DEDCD76541C62042041026146549AB28C1162DA44
            677BB31D15871801489040981195D2DE00000000D88AE85C2EC4F3BD5E4B8F94
            CB06FAA5B3BDD98E8A438C00244820CC884A539631424C9BE86C6FB6A3E21023
            0009120833A2D294658C10D32692EF4D9E0208FEF765408C00244820CC884A53
            9631424C9B48BC37F91BFCF0BF2F0762042041026146549AB28C1162DA44677B
            B31D15871801489040981195D621E3CCFFDE9B4228730518103A845E537847EF
            C7FFDE2F567E8673D000D4F07ACD22A6B4D9BCAD76C23BFB9BEA2F3B1B959A0D
            D74ECCA7F680FF7D75E07F0FC09870035A3FFEF72A76599C99BF05DAA4D78488
            4A83BDFBC7F7BFB7F0FCF9CA7B7470C2B279A1DCE06E2CF5BFB7B0A1DF90B3FA
            83C1C89D693C5B2DFCEF9B6313FEF7008C8D828096052842E9B1C0FFDE20A936
            67FE120833A2D261651CF8DF6B24940FFDEA5358362F941B9C8DE5FEF7064E18
            62A50A1A2777A6D1081BFEF74DE3B4AA75033255863F1E002323AF292FDFB345
            48A1FFBD8504BB3B6AC71551E97032E6E1B2EB7FAF3707EE268312968D1B8CB6
            0936AAAA5025F1BDA8415D82E80C1A853A4DAF29E8DA0BFEF78DC395D3257634
            AB1A0DFEF7008C8C2CAE644FBA9D00A23468A25F9E32B7773A9C5E13222A0DF6
            EE130A19360313AA1AD6554CEF34307444BDA6286C116763598B68F8166E6826
            081AC3EF4DF8DF8F07A75531BE07A039F29ACA8DEF7B0C921DB5FA04C28CA8B4
            26193B63057EEA3995BFED300061D974202ECDF7D26485FEF7C4A8BE5D0D2AE2
            F5A677729B53D9EF5F5F1E6E66351794F0BFEF1FA755E5EA04FEF70034821FD0
            144EBED77ACCFBDF333CDA2979121D0833A2D29A646CF3BDBC53D06390DD0F61
            D9B8C1689BC224862C3A3365FEF7F29E410D8F18C0C0509FE835EA26EF4E8C9B
            BFB9EB18F8DFD70FD5226B5F562BFCEF01680A2F7DE9C8E6E67B8E5CC5FEF745
            EFCF5A686FBD2644541AEC9D1429970DF44B677BB31D15871801489040981195
            A62C63849836D1D9DE6C47C52146001224106644A529CB1821A64D74B637DB51
            71881180040984195129ED0D00000080AD88CEE5423CDFEBB5F448B96CA05F3A
            DB9BEDA838C408408204C28CA834651923C4B489CEF6663B2A0E310290208130
            232A4D59C608316D22F9DE1CD50C0DED388D2146001224106644A529CB1821A6
            4D24DE9BF0BFEF0DC408408204C28CA834651923C4B489CEF6663B2A0E310290
            208130232AAD43C66A36533579FEADE5C583E23C3A3935B7E8CC10340861D9BC
            098AFAF1BFD7739DCACC4539636FD00CD4F67ACDC2D3E4C1FFBE41E07F0FC098
            70035A3FFEF7799D7AD056BD2644541AECDD3FBEFF3D874E8A8C37259467B17B
            30C2B279A1DCE06E2CF5BFA778BD437CFC38CA67F3178206C99D693C5B2DFCEF
            9B6313FEF7008C8D828096052842E931EF7F2FAE9BA2539EDE3B3C4228CC884A
            879571E07FCFF39C3F32BBF08BD5734767877E1A1A96CD0BE50667A3D8993881
            3B43DC56668F9E5BFDC5C2EC0C5F8E80C6C99D6974ED05FFFBA6715AD5BA0199
            2AC31F0F809191D79497EF397516FBDF8BDBC8BE85732BE716F6EFE6CB718F40
            9811950E27E302FF7B49BA44C19D877E09CBC60DC687666C5455A14AE27B5183
            1AB835694057C353063018D4697A4D41236CF8DF370E574E9738D3AC6E49F8DF
            033032B2B8A2031AE10410A54113FD7C642041143D8CA6CD7A4D88A834D8BB4F
            2864D80C4C6CDF7BE8396DDB57871F1D1D51AF290A5BC4D9E8BBAE396416BDBD
            8C86C048F17B536E5EC94923C0FFBE219C56C5F81E80E6C86B2A37BE2FCC98F6
            7BC2C5DEB38130232AAD49C67AACC0559A947C9F3DFB1C9CB06C2A2A95E77B69
            B222FF7BDE47BDAB2569C63EC4050DE2F5A677729BC4E3F72FFF96C9C3CDACC6
            A616FEF7FDE3B4AA5C9DC0FF1E8046F0039AC2C9F75A8F79FF7BDE4707341EF3
            E82B724B20CC884A6B92B1B93798BD495860A1DD2F61D9B8C1D4B1099318B2E8
            CC94F8DFDB6F0DF076E7BD7DD01CD4F67A8DBAC9BB13E3E66FD549FC463EFCEF
            EB866A91B5AFA815FEF700348497BE746473F33D47AE22FF7BE75B3345DF00A2
            AD7A4D88A834D83B29522E1BE897CEF6663B2A0E310290208130232A4D59C608
            316DA2B3BDD98E8A438C00244820CC884A539631424C9BE86C6FB6A3E2102300
            09120833A252DA1B000000005B119DCB8578BED76BE99172D940BF74B637DB51
            71881180040984195169CA32468869139DEDCD76541C62042041026146549AB2
            8C1162DA44F2BD69E7B5D0BFD7453B4E63881180040984195169CA3246886913
            89F726FCEF7B03310290208130232A4D59C608316DA2B3BDD98E8A438C002448
            20CC884AEB90B1E37FEFCE1054E405DE1761D9BC098AFAF2BF77A7451B76D63F
            3018D4F87ACD22A6B4D9BCADFE54896E6F9B29A864365C3B319FDA03FEF7D581
            FF3D0063C20D687DF9DFBB93C6E62787A5CD7A4D88A834D8BB7F3CFF7B992795
            E7CF2F9CE9B75FC2B279A1DCE06E2CF3BFE7D9586562F33A66F50783913BD3C4
            190FFEF78D412A80FF3D0063A220A065018A507ACCFBDF8B7508BF57546CFE12
            0833A2D26165ECFBDF7395F4F0CBCCA83F0461D9BC506E70368A9D8913B82DBC
            8FF24C2B762C050D903BD368840DFFFBA6715AD5BA01992AC31F0F809191D794
            97EF79505AE87FCFFBE82013442A21106644A5C3C938E77FEFF8E5E83BFC4340
            87D06B0A6E3075E47EFDEF1DBF1C02F97E1C50C3EB35058DB0E17FDF385C395D
            62E78A5C351AFCEF011819595CC932A3134094064DF47370FD728871E67B0A19
            3603134E820F0CCD06828EA8D714852DE26CF45DD70A090664A039FCDE947B53
            72D208F0BF6F08A75531BE07A039F29AF2F27D858C5998E0026146545A938CED
            F8FED232BFC474EBDCC23EED3A3A0461D974202ECDF7D26445FEF79FDFFA60F9
            AAB1FBB4C900348AD79BDEC96D128FDFBFBE3CDCCC6A6C6AE17FDF3F4EABCAD5
            09FCEF0168043FA0299C7CAFF598F7BFDFBCF3C1077C9751DCABF383D5409811
            95D6246393EFF56B5005EFF70E4058366E303938631243169D9912FF7B15E509
            F51E321803D4FA7A8DBAC9BB5075F3B7F41201FFFBFAA15A64ED2B57E7F0BF07
            A021BCF4A5239B9BEF397215FADF7314E28D9353738B666306FD41AF09119506
            7B2745CA6503FDD2D9DE6C47C52146001224106644A529CB1821A64D74B637DB
            5171881180040984195169CA32468869139DEDCD76541C62042041026146544A
            7B03000000602BA273B910CFF77A2D3D522E1BE897CEF6663B2A0E3102902081
            30232A4D59C608316DA2B3BDD98E8A438C00244820CC884A539631424C9BE86C
            6FB6A3E210230009120833A2D294658C10D32692EF4D9EF24FCFEC5B2BED388D
            2146001224106644A529CB1821A64D24DE9B3C63CF6E65AD5B33ED388D214600
            1224106644A529CB1821A64D74B637DB51718811800409841951E9903276E708
            947901AD135DF1E47F7D4147D16B0A6F42C2FD8B2B6F3ABF123C45E8E6EAD251
            65D0A7A708B5A8794FEDCCBB7596135481DA5AAF5964F6E56C46687F6AE4DCA9
            45C8BCC876225EB507CF004FBFF2CC94BDFDF12626763893DBAB299673F3E9EA
            23E8DFCCB4B2CE7CBA675E505E55E64FD91667FA5E0FFA835E1B3B77964FCC5B
            FF7BFAD5BA59AA79A61D27AEDC7CD8B44DAF0100A2B8F16B62FF8B8BDFF19295
            18769466AB884E3D68AB5E13222A0DF6EE17AE942D96BA293A4991F1A6F8E237
            ED8FF7F9E6A5C57D8F18BF9C1307F71C3605BBBFBCB06FF6D0B336DFD75B4E50
            85DC99C6F3426F9F999DD9EEE6EFAC7F83538B6127DCE9D999DDBABF780F3AAA
            78E555CAF7A4978565A52A6DF4207B96F9E5C8E9E4F9E5F06963FC724E3E4B9B
            D6B32D72CA4D6DD78E730EB98A8F89CD730B7BF61D3A64E3885814F2D5D28676
            02BC7191E5C3F6D6EC3F04BF1C0006C78F660A2FA69565ABA84E7D17BA409811
            950E2963AF0299BF08ADDB503B3861D98A5AD0DD28F665A13D7046B667CDE504
            55C89D6934C2DE3377F2ACFCB4F93BEB5FFFD422E4FA60EEC40AFF945424FB1F
            5A9817EB9D5BD17CBFFDD08F7EB07B46FC5EE9FA6F66EA3B87E6D49E65F99EED
            64DC7CCF7EB862C167715DFBF4AFFE0E4C5299D26955EBFE67AA0C3F5C00EAC2
            0B441A5756BDB3552F9DFAC70C841951E99032E602D02198DD738BBF5C5EDC6F
            E2DD88F2BDFA2CE57C6A37EA2670DAA8886CCF8DD55ACB09AA409DA6D71434C2
            DE43975C92C5D55BF14E57124E6F8B991B9FF7FB391BF128FFEB8B97D7CDFE17
            490F94AC4E46F3FDFC1B67557A66B7BD99CC5E2FBB9F2F1F947DF0A4BAFA36F7
            F3AFE44E95E0E471CFAB0C3A905E4B00AE9C2E31554A3C2DF5D6A9F9C5057BDD
            E3ECA649AA1600A44E1646B26CE5CA2A2F3117E7AF399D9A08A9A0C3EB3521A2
            D260EF41917B0E93DFFEA33FFAF698C7F7B9DB1D19D99E18DF8F01BF37E584A1
            4D1A1956FAFDCBBF391DA31C6F0D720FDFEC2FFD3E3D3BB3C3E47BB1B767827C
            2F76F593738B27E6A7A8F7AD7D7EF1F8FE9673F72C1BDFFB77B931BE070014A1
            C38897AD5C59F5CE56BD74EA1F33106644A535C958C237158A064E1314196FCA
            B3CCE69FDFD3C76F374F444E1DDEFF7D3760B97BCABD94DACA09AAE0F5A6E767
            6F4E68BF7FF9B72CE5B899D55CAED9842DCF9BE9F8926BE9688F4CCA0D03A773
            6DE2E7BF4E4CC80581FDB8B2FBF999D254BE970B8B09F3FC7EE9FBFB0FCB0584
            DEA25E767BC47925505393C4EAC16955B93AE1E782F7574F3E2BCFEFCFB27CE6
            97EE6C5E3E7990AE8BDC2B9BB46A0140EAF8D14CE1C5B49ED9AA974EC7F7FCDE
            19A5E9177A6F9D5B50C3B0E27795FB828EA2D714DC067C68C134A5DFACDC70B3
            3BF8EF93B3F327964D63CB8D560B67853ACB09AA406DADD7D4F55676E2BAF99B
            BB84D93EFFE69B81369CCB327EDBEEF1EC863CFD5D46FF2A4565E740D6B936DF
            CB67A98FB6674E763F5FBE0970DF9E51F63E90CEF774C2539A9F95F36672F6F0
            0939E1E57B1FF2BF13BBE78E7ADF0951D01FF4DA98A15A64EDCB7708F905052D
            16793D78F3CEB9A3A676EADB0719B451AF0100A214652B278B3325D92AAA530F
            DAACD784884A83BD9322E5B2817EE96C6FB6A3E210230009120833A2D294658C
            10D3263ADB9BEDA838C408408204C28CA894F606000000C05644E772219EEFF5
            5A7AA45C36D02F9DEDCD76541C62042041026142A500000040DBF9FCF3FF1FFD
            0CD9BEDA8C24660000000049454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
  object cxRepository: TcxEditRepository
    Left = 80
    Top = 200
    PixelsPerInch = 96
    object cxEditQtdEti: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MinValue = True
      Properties.AutoSelect = False
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0;-,0'
      Properties.EditFormat = ',0;-,0'
      Properties.MaxLength = 6
      Properties.MaxValue = 999999.000000000000000000
      Properties.ValidationOptions = [evoShowErrorIcon]
    end
  end
  object tmrDesmarcaTodos: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrDesmarcaTodosTimer
    Left = 836
    Top = 200
  end
end
