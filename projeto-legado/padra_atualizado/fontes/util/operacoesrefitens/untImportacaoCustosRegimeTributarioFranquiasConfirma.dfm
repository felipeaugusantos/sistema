inherited frmImportacaoCustosRegimeTributarioFranquiasConfirma: TfrmImportacaoCustosRegimeTributarioFranquiasConfirma
  Width = 1071
  Height = 600
  BorderStyle = bsSizeable
  Caption = 
    'Importa'#231#227'o De Custos Por Regime Tribut'#225'rio Para Franquias - Conf' +
    'irma'#231#227'o'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1071
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1055
    ExplicitTop = 519
    ExplicitWidth = 1055
    inherited FlwBotoes: TFlowPanel
      Width = 1051
      ExplicitWidth = 1051
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 968
      Top = 2
      ExplicitLeft = 968
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1055
    ExplicitTop = 545
    ExplicitWidth = 1055
    inherited pnlNomeForm: TPanel
      Left = 884
      ExplicitLeft = 884
    end
    inherited pnlInfo: TPanel
      Width = 884
      ExplicitWidth = 884
    end
  end
  object grpLegenda: TGroupBox [2]
    Left = 0
    Top = 479
    Width = 1055
    Height = 40
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 2
    object shpNaoImportados: TShape
      Left = 23
      Top = 19
      Width = 17
      Height = 15
      Brush.Color = clRed
    end
    object lblValoresAlterados: TLabel
      Left = 46
      Top = 20
      Width = 85
      Height = 14
      Caption = 'Valores alterados'
    end
  end
  object cxDados: TcxGridCitel [3]
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1055
    Height = 479
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensViewCodEmp: TcxGridDBColumn
        Caption = 'C'#243'd. Empresa'
        DataBinding.FieldName = 'ITE_CODEMP'
        Width = 75
      end
      object cxgItensViewRegTri: TcxGridDBColumn
        Caption = 'Regime Tribut'#225'rio '
        DataBinding.FieldName = 'ITE_REGTRI'
        Width = 90
      end
      object cxgItensViewCodIte: TcxGridDBColumn
        Caption = 'Codigo Item'
        DataBinding.FieldName = 'ITE_CODITE'
        Width = 80
      end
      object cxgItensViewDesIte: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Item'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 80
      end
      object ITE_MARBR1: TcxGridDBColumn
        Caption = 'Margem 1'
        DataBinding.FieldName = 'ITE_MARBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR1: TcxGridDBColumn
        Caption = 'Margem 1 Novo'
        DataBinding.FieldName = 'NOVO_MARBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1'
        DataBinding.FieldName = 'ITE_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1 Novo'
        DataBinding.FieldName = 'NOVO_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object ITE_MARBR2: TcxGridDBColumn
        Caption = 'Margem 2'
        DataBinding.FieldName = 'ITE_MARBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR2: TcxGridDBColumn
        Caption = 'Margem 2 Novo'
        DataBinding.FieldName = 'NOVO_MARBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2'
        DataBinding.FieldName = 'ITE_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2 Novo'
        DataBinding.FieldName = 'NOVO_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object ITE_MARBR3: TcxGridDBColumn
        Caption = 'Margem 3'
        DataBinding.FieldName = 'ITE_MARBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR3: TcxGridDBColumn
        Caption = 'Margem 3 Novo'
        DataBinding.FieldName = 'NOVO_MARBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3'
        DataBinding.FieldName = 'ITE_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3 Novo'
        DataBinding.FieldName = 'NOVO_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object ITE_MARBR4: TcxGridDBColumn
        Caption = 'Margem 4'
        DataBinding.FieldName = 'ITE_MARBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR4: TcxGridDBColumn
        Caption = 'Margem 4 Novo'
        DataBinding.FieldName = 'NOVO_MARBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4'
        DataBinding.FieldName = 'ITE_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4 Novo'
        DataBinding.FieldName = 'NOVO_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object ITE_MARBR5: TcxGridDBColumn
        Caption = 'Margem 5'
        DataBinding.FieldName = 'ITE_MARBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR5: TcxGridDBColumn
        Caption = 'Margem 5 Novo'
        DataBinding.FieldName = 'NOVO_MARBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5'
        DataBinding.FieldName = 'ITE_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5 Novo'
        DataBinding.FieldName = 'NOVO_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object ITE_MARBR6: TcxGridDBColumn
        Caption = 'Margem 6'
        DataBinding.FieldName = 'ITE_MARBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR6: TcxGridDBColumn
        Caption = 'Margem 6 Novo'
        DataBinding.FieldName = 'NOVO_MARBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6'
        DataBinding.FieldName = 'ITE_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6 Novo'
        DataBinding.FieldName = 'NOVO_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object ITE_MARBR7: TcxGridDBColumn
        Caption = 'Margem 7'
        DataBinding.FieldName = 'ITE_MARBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
      end
      object NOVO_MARBR7: TcxGridDBColumn
        Caption = 'Margem 7 Novo'
        DataBinding.FieldName = 'NOVO_MARBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 85
      end
      object ITE_PREVE7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7'
        DataBinding.FieldName = 'ITE_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 80
      end
      object NOVO_PREVE7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7 Novo'
        DataBinding.FieldName = 'NOVO_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object cxgItensViewPossuiDiferenca: TcxGridDBColumn
        DataBinding.FieldName = 'POSSUI_DIFERENCA'
        Visible = False
      end
      object DIF_MARBR1: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR1'
        Visible = False
      end
      object DIF_PREVE1: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE1'
        Visible = False
      end
      object DIF_MARBR2: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR2'
        Visible = False
      end
      object DIF_PREVE2: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE2'
        Visible = False
      end
      object DIF_MARBR3: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR3'
        Visible = False
      end
      object DIF_PREVE3: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE3'
        Visible = False
      end
      object DIF_MARBR4: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR4'
        Visible = False
      end
      object DIF_PREVE4: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE4'
        Visible = False
      end
      object DIF_MARBR5: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR5'
        Visible = False
      end
      object DIF_PREVE5: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE5'
        Visible = False
      end
      object DIF_MARBR6: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR6'
        Visible = False
      end
      object DIF_PREVE6: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE6'
        Visible = False
      end
      object DIF_MARBR7: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_MARBR7'
        Visible = False
      end
      object DIF_PREVE7: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PREVE7'
        Visible = False
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 160
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 160
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 48
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 32
    Top = 44
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 40
    Top = 236
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 40
    Top = 152
    PixelsPerInch = 96
    object styDentro: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styFora: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 8421631
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styEditavel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clDefault
    end
  end
  object frxReportJ_Criticas: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45405.467535243060000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 432
    Top = 56
    Datasets = <
      item
        DataSet = frxDbCriticas
        DataSetName = 'frxDBCriticas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 370.393940000000000000
        Width = 1046.929810000000000000
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 96.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 203.074305000000000000
          Top = 34.000000000000000000
          Width = 640.781200000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REL'#193'TORIOS DE ITENS COM INCONSIST'#202'NCIAS')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPagina: TfrxMemoView
          Left = 921.635190000000000000
          Top = 34.015770000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 969.414720000000000000
          Top = 58.574830000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 837.055660000000000000
          Top = 58.574830000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 16.897650000000000000
        ParentFont = False
        Top = 177.637910000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Top = 0.779530000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'DIGO EMPRESA')
        end
        object Memo2: TfrxMemoView
          Left = 238.110236220000000000
          Top = 0.779530000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'DIGO ITEM')
        end
        object Memo3: TfrxMemoView
          Left = 113.385826770000000000
          Top = 0.755905510000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'REGIME TRIBUT'#193'RIO')
        end
        object Memo5: TfrxMemoView
          Left = 332.598425200000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'MOTIVO')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 219.212740000000000000
        Width = 1046.929810000000000000
        AllowSplit = True
        DataSet = frxDbCriticas
        DataSetName = 'frxDBCriticas'
        RowCount = 0
        Stretched = True
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmoCodigo: TfrxMemoView
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."ITE_CODEMP"]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 113.385826770000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."ITE_REGTRI"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 238.110236220000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."ITE_CODITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 332.598425200000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."MOTIVO"]')
          WordWrap = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 298.582870000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object MemoErros: TfrxMemoView
          Top = 11.000000000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDbCriticas: TfrxDBDataset
    UserName = 'frxDBCriticas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 328
    Top = 52
  end
end
