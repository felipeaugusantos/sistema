object frmQckBoletimRec: TfrmQckBoletimRec
  Left = 0
  Top = 0
  ClientHeight = 469
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40681.580685578700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '    '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 32
    Top = 40
    Datasets = <
      item
        DataSet = frxDBRel
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxDBRel
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatoriofrxRelatorio: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '________________')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 289.000000000000000000
        Width = 1276.800000000000000000
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 1276.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo10: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO DE BARRAS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO DE FABRICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 393.600000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 102.000000000000000000
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[DTAENT]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[DTAPED]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 85.000000000000000000
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#33'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 105.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
      end
    end
  end
  object frxDBRel: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 96
    Top = 40
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = False
    Left = 152
    Top = 40
  end
  object frxReportA4Retrato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45421.648656851850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '    '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 64
    Top = 120
    Datasets = <
      item
        DataSet = frxDBRel
        DataSetName = 'frxRelatorio'
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
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 273.865060000000000000
          Top = 22.440940000000000000
          Width = 170.380580000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 576.847000000000000000
          Top = 19.440940000000000000
          Width = 137.347990000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 179.376810000000000000
          Top = 4.440940000000001000
          Width = 359.357080000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 631.267470000000000000
          Top = 5.440940000000001000
          Width = 81.788930000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'G. [Page#] / [TotalPages#]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133889999999990000
          Width = 86.929133858267720000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Empresa:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 84.811070000000000000
          Width = 86.929133858267720000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pedido:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 103.488250000000000000
          Width = 86.929133858267720000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Pedido:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.819110000000000000
          Top = 67.252010000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fornecedor:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 201.819110000000000000
          Top = 102.929190000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Entrega:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 94.866141732283460000
          Top = 49.133889999999990000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"] - [frxRelatorio."NOMEMP"] ')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo19: TfrxMemoView
          Left = 94.866141730000000000
          Top = 85.252010000000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 94.866141732283460000
          Top = 103.370130000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAPED"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 94.866141730000000000
          Top = 67.252010000000000000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"] - [frxRelatorio."NOMFOR"] ')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 294.126160000000000000
          Top = 104.149660000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 18.897637800000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo7: TfrxMemoView
          Left = 0.755905510000000000
          Top = 2.755905509999991000
          Width = 45.354330708661410000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 47.755905510000000000
          Top = 2.755905509999991000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 410.527559060000000000
          Top = 2.755905509999991000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Unid.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 442.543307090000000000
          Top = 2.755905509999991000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Barras')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 550.134199999999900000
          Top = 2.755905509999991000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de F'#225'brica')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 653.858690000000000000
          Top = 2.755905509999991000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        Height = 22.677180000000000000
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        DataSet = frxDBRel
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo13: TfrxMemoView
          Left = 0.755905510000000000
          Top = 4.755905509999991000
          Width = 45.354330708661410000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 47.755905510000000000
          Top = 4.755905509999991000
          Width = 362.834880000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 410.527559060000000000
          Top = 4.755905509999991000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 442.543307090000000000
          Top = 4.755905509999991000
          Width = 105.826771650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 550.511811020000000000
          Top = 4.755905509999991000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677180000000000000
        Top = 294.803340000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object frxReportA4Paisagem: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45422.608337337970000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '    '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 200
    Top = 112
    Datasets = <
      item
        DataSet = frxDBRel
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 438.274615000000100000
          Top = 22.440940000000000000
          Width = 170.380580000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Align = baRight
          Left = 909.581820000000100000
          Top = 19.440940000000000000
          Width = 137.347990000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 343.786365000000100000
          Top = 4.440940000000001000
          Width = 359.357080000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Align = baRight
          Left = 965.140880000000000000
          Top = 5.440940000000001000
          Width = 81.788930000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'G. [Page#] / [TotalPages#]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133889999999990000
          Width = 86.929133858267700000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Empresa:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 84.811070000000000000
          Width = 86.929133858267700000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pedido:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 103.488250000000000000
          Width = 86.929133858267700000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Pedido:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.819110000000000000
          Top = 67.252010000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fornecedor:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 201.819110000000000000
          Top = 102.929190000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data Entrega:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 94.866141732283490000
          Top = 49.133889999999990000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"] - [frxRelatorio."NOMEMP"] ')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo19: TfrxMemoView
          Left = 94.866141730000000000
          Top = 85.252010000000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 94.866141732283490000
          Top = 103.370130000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAPED"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 94.866141730000000000
          Top = 67.252010000000000000
          Width = 608.504330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"] - [frxRelatorio."NOMFOR"] ')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 294.126160000000000000
          Top = 104.149660000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 18.897637800000000000
        Top = 207.874150000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Memo7: TfrxMemoView
          Left = 0.755905511811023600
          Top = 2.755905509999991000
          Width = 49.133858267716530000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 52.535433070866140000
          Top = 2.755905509999991000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 681.448818897637800000
          Top = 2.755905509999991000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Unidade')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 734.362204720000000000
          Top = 2.755905509999991000
          Width = 120.944881889763800000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Barras')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 859.086614170000000000
          Top = 2.755905509999991000
          Width = 120.944881889763800000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de F'#225'brica')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 982.677800000000000000
          Top = 2.755905509999991000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftBottom]
        Height = 22.677180000000000000
        Top = 249.448980000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBRel
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo13: TfrxMemoView
          Left = 0.755905511811023600
          Top = 4.755905509999991000
          Width = 49.133858267716530000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 52.535433070000010000
          Top = 4.755905509999991000
          Width = 627.401574803149600000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 681.448818897637800000
          Top = 4.755905509999991000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 734.362204720000000000
          Top = 4.755905509999991000
          Width = 120.944881889763800000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 859.086614170000000000
          Top = 4.755905509999991000
          Width = 120.944881889763800000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677180000000000000
        Top = 294.803340000000000000
        Width = 1046.929810000000000000
      end
    end
  end
end
