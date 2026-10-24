inherited frmImportacaoCadRegioesDescontoConfirma: TfrmImportacaoCadRegioesDescontoConfirma
  Width = 1071
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o de Descontos por Regi'#245'es / Fornecedores - Confirma'#231#227'o'
  WindowState = wsMaximized
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
      Brush.Color = clMoneyGreen
    end
    object lblValoresAlterados: TLabel
      Left = 46
      Top = 20
      Width = 85
      Height = 14
      Caption = 'Valores alterados'
    end
    object Label1: TLabel
      Left = 166
      Top = 20
      Width = 56
      Height = 14
      Caption = 'Itens novos'
    end
    object Shape1: TShape
      Left = 143
      Top = 19
      Width = 17
      Height = 15
      Brush.Color = clYellow
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
      object cxgItensViewRDS_CODREG: TcxGridDBColumn
        Caption = 'Codigo Regi'#227'o'
        DataBinding.FieldName = 'RDS_CODREG'
        Width = 80
      end
      object cxgItensViewREG_DESREG: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Regi'#227'o'
        DataBinding.FieldName = 'REG_DESREG'
        Width = 80
      end
      object cxgItensViewRDS_CODFOR: TcxGridDBColumn
        Caption = 'C'#243'digo Fornecedor'
        DataBinding.FieldName = 'RDS_CODFOR'
      end
      object cxgItensViewFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
      end
      object RDS_PERCOM: TcxGridDBColumn
        Caption = 'Comiss'#227'o'
        DataBinding.FieldName = 'RDS_PERCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 65
      end
      object NOVO_PERCOM: TcxGridDBColumn
        Caption = 'Comiss'#227'o Novo'
        DataBinding.FieldName = 'NOVO_PERCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 93
      end
      object RDS_PERDES: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'RDS_PERDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 105
      end
      object NOVO_PREULT: TcxGridDBColumn
        Caption = 'Desconto Novo'
        DataBinding.FieldName = 'NOVO_PERDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '###,###,##0.000'
        Width = 133
      end
      object cxgItensViewPossuiDiferenca: TcxGridDBColumn
        DataBinding.FieldName = 'POSSUI_DIFERENCA'
        Visible = False
      end
      object DIF_PERCOM: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PERCOM'
        Visible = False
      end
      object DIF_PERDES: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PERDES'
        Visible = False
      end
      object cxgItensViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
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
    ReportOptions.LastChange = 45484.687614525460000000
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
        object Memo2: TfrxMemoView
          Top = 0.779530000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'REGI'#195'O')
        end
        object Memo5: TfrxMemoView
          Left = 188.976377952755900000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'MOTIVO')
        end
        object Memo1: TfrxMemoView
          Left = 94.488250000000000000
          Top = 0.755905511811023600
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'FORNECEDOR')
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
        object Memo7: TfrxMemoView
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."RDS_CODREG"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 188.976377950000000000
          Width = 850.394250000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."MOTIVO"]')
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 94.488250000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."RDS_CODFOR"]')
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
