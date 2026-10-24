object frmQckOrdemServico: TfrmQckOrdemServico
  Left = 260
  Top = 218
  Caption = 'frmQckOrdemServico'
  ClientHeight = 95
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxDesigner: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    TemplateDir = 'C:\autpas\padra_atualizado\fontes\relatorios'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 24
    Top = 21
  end
  object frxExpHtml: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 72
    Top = 21
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
    Left = 120
    Top = 24
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 160
    Top = 24
  end
  object frxExpRTF: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'Citel Software'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 334
    Top = 24
  end
  object frxExpXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 278
    Top = 24
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 406
    Top = 29
  end
  object frxComandos: TfrxUserDataSet
    UserName = 'frxComandos'
    Fields.Strings = (
      'UM_OITAVO_ON'
      'UM_OITAVO_OFF'
      'NEGRITO_ON'
      'NEGRITO_OFF'
      'EXPANDIDO_ON'
      'EXPANDIDO_OFF'
      'ITALICO_ON'
      'ITALICO_OFF'
      'COND_10CPI_ON'
      'COND_10CPI_OFF'
      'COND_12CPI_ON'
      'COND_12CPI_OFF'
      'RESETA')
    Left = 462
    Top = 29
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 518
    Top = 32
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45308.760873726900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 574
    Top = 32
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 929.732840000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 7.975140000000000000
          Top = 5.661410000000000000
          Width = 702.160420000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Top = 37.795300000000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 56.692950000000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data...:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 7.559060000000000000
          Top = 75.590600000000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'No Doc.:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 79.370130000000000000
          Top = 37.795300000000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 79.370130000000000000
          Top = 56.692950000000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[DATA]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 79.370130000000000000
          Top = 75.590600000000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[DOCUMENTO]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Top = 105.826840000000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Produto:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 7.559060000000000000
          Top = 124.724477800000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Medidas:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559060000000000000
          Top = 143.622115590000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Quantid:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 7.559060000000000000
          Top = 162.519753390000000000
          Width = 67.199380000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Obs....:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 79.370130000000000000
          Top = 105.826842440000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 79.370130000000000000
          Top = 124.724492440000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[MEDIDAS]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 79.370130000000000000
          Top = 143.622142440000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[QUANTIDADE]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 79.370130000000000000
          Top = 162.519792440000000000
          Width = 626.569820000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[OBSERVACAO]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 7.559060000000000000
          Top = 30.236240000000000000
          Width = 706.772110000000000000
          Color = clBlack
          Frame.Width = 1.500000000000000000
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 7.559060000000000000
          Top = 98.267780000000000000
          Width = 706.772110000000000000
          Color = clBlack
          Frame.Width = 1.500000000000000000
          Diagonal = True
        end
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 0.416080000000000000
          Top = 188.976500000000000000
          Width = 717.278540000000000000
          Height = 20.779530000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '* * *   D E S E N H O S    * * *')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Top = 188.976500000000000000
          Width = 718.110700000000000000
          Height = 820.126470000000000000
          Frame.Width = 1.500000000000000000
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 1009.134510000000000000
        Width = 718.110700000000000000
        object Memo16: TfrxMemoView
          Left = 11.338590000000000000
          Top = 15.118120000000000000
          Width = 116.333270000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[TARJA]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 166.299320000000000000
          Top = 15.118120000000000000
          Width = 184.364810000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[RECORTE]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 370.393940000000000000
          Top = 15.118120000000000000
          Width = 229.719170000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VOLUMES: ________________')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorioM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44949.712441724500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin        '
      '  '
      'end.')
    Left = 648
    Top = 32
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 391.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Cliente:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Data...:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'No Doc.:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 68.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 102.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[DATA]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 136.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[DOCUMENTO]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 1468.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 187.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Produto:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 221.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Medidas:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 255.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Quantid:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 187.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[PRODUTO]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 221.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[MEDIDAS]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 255.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[QUANTIDADE]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 289.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'Obs....:')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 289.000000000000000000
          Width = 1372.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[OBSERVACAO]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo15: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 340.000000000000000000
          Width = 1468.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '* * *   D E S E N H O S   * * *')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPLine1: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 178.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 331.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 442.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo16: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[TARJA]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 345.600000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[RECORTE]')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 508.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            'VOLUMES: ___________________')
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPLine3: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
      end
    end
  end
end
