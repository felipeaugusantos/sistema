object frmChartRelatorioFrame: TfrmChartRelatorioFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object pnlChart: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlChart'
    Color = 15263976
    ParentBackground = False
    TabOrder = 0
    StyleElements = [seFont, seBorder]
    OnResize = pnlChartResize
    DesignSize = (
      451
      305)
    object shpGrafico: TShape
      Left = 0
      Top = 0
      Width = 451
      Height = 305
      Align = alClient
      Pen.Style = psClear
      ExplicitLeft = 6
      ExplicitTop = -4
      ExplicitWidth = 781
      ExplicitHeight = 459
    end
    object imgSupEsq: TImage
      Left = 0
      Top = 0
      Width = 10
      Height = 10
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        0000434944415428538DCDD10900200845516B09F7DFCE2DEC8552560A9D9F84
        4BDA44841ECC6C43B7275A0D8E8C101BEC7C05E3396D90DC8E66AEBE4253551F
        331FCB4B4403FAA107AB2DD58AAA0000000049454E44AE426082}
    end
    object imgSupDir: TImage
      Left = 440
      Top = 0
      Width = 10
      Height = 10
      Anchors = [akTop, akRight]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00004349444154285363FCFFFF3F0318BC7CF912C240064C509A81415C5C1CCA
        420208DD70806C0C42371C201B83451A08E02AB04BC3014E698801589C860CC8
        351C04181800F6D40F93759654D70000000049454E44AE426082}
      ExplicitLeft = 985
    end
    object imgInfEsq: TImage
      Left = 0
      Top = 294
      Width = 10
      Height = 10
      Anchors = [akLeft, akBottom]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00003649444154285363FCFFFF3F036EC004A5710042D22F5FBE8432B101906E
        3C2A88B31B970108DD5855A0180E5481A6088BDD08150C0C001839162E94ECBA
        750000000049454E44AE426082}
      ExplicitTop = 462
    end
    object imgInfDir: TImage
      Left = 440
      Top = 294
      Width = 10
      Height = 10
      Anchors = [akRight, akBottom]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00003749444154285363FCFFFF3F036EC004A571000AA45FBE7C89531A280724
        C9321CA21508B048C3E58000C5DFC8121080D08D29C7C0C00000A454166F77F2
        649E0000000049454E44AE426082}
      ExplicitLeft = 985
      ExplicitTop = 462
    end
    object cxgGrafico: TcxGrid
      Left = 58
      Top = 56
      Width = 855
      Height = 422
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvGrafico: TcxGridDBChartView
        Categories.DataBinding.FieldName = 'legenda'
        DataController.DataSource = dtsGrafico
        DiagramArea.Legend.Position = cppNone
        DiagramArea.Transparency = 70
        DiagramBar.AxisCategory.GridLines = False
        DiagramBar.Values.VaryColorsByCategory = True
        DiagramColumn.Active = True
        DiagramColumn.Legend.Position = cppNone
        DiagramColumn.AxisCategory.GridLines = False
        DiagramColumn.Values.VaryColorsByCategory = True
        DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
        DiagramLine.Legend.Position = cppNone
        DiagramPie.SeriesSites = True
        DiagramPie.Values.CaptionPosition = pdvcpOutsideEndWithLeaderLines
        DiagramPie.Values.CaptionItems = [pdvciPercentage]
        DiagramStackedArea.Legend.Position = cppNone
        Legend.Border = lbNone
        Title.Alignment = cpaStart
        ToolBox.Border = tbNone
        OnActiveDataLevelChanged = cxvGraficoActiveDataLevelChanged
        object cxvGraficoSeries1: TcxGridDBChartSeries
          DataBinding.FieldName = 'VALOR'
          ValueCaptionFormat = '#,###.00'
        end
      end
      object cxgGraficoLevel1: TcxGridLevel
        GridView = cxvGrafico
      end
    end
  end
  object dtsGrafico: TDataSource
    Left = 500
    Top = 401
  end
  object tmrRefreshDados: TTimer
    Enabled = False
    Interval = 5000000
    OnTimer = tmrRefreshDadosTimer
    Left = 120
    Top = 128
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLink1
    PreviewOptions.EnableOptions = [peoCanChangeMargins, peoPageBackground, peoPreferences, peoPrint]
    PreviewOptions.VisibleOptions = [pvoPageBackground, pvoPrint, pvoReportFileOperations, pvoPageMargins]
    PrintTitle = 'League Table'
    Version = 0
    Left = 248
    Top = 96
    PixelsPerInch = 96
    object dxComponentPrinterLink1: TdxGridReportLink
      PrinterPage.DMPaper = 256
      PrinterPage.Footer = 5080
      PrinterPage.Header = 2540
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.CenterTitle.Strings = (
        'Produced by Eco Tools '#169' 1997 State Of The Art')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageSize.X = 210820
      PrinterPage.PageSize.Y = 297180
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'League Table Report'
      ReportDocument.CreationDate = 45681.418720509260000000
      ReportDocument.Creator = 'Eco Tools'
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clRed
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Times New Roman'
      ReportTitle.Font.Style = [fsBold]
      ReportTitle.Text = 'Eco Tools League Table Report'
      ShrinkToPageWidth = True
      OptionsCharts.GraphicClassName = 'TMetafile'
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.Caption = False
      OptionsOnEveryPage.FilterBar = False
      OptionsView.Footers = False
      OptionsView.Caption = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
  object dxPrintStyleManager1: TdxPrintStyleManager
    CurrentStyle = dxPrintStyleManager1Style1
    PageSetupDialog = dxPageSetupDialog1
    Version = 0
    Left = 248
    Top = 128
    object dxPrintStyleManager1Style1: TdxPSPrintStyle
      PrinterPage.DMPaper = 256
      PrinterPage.Footer = 5080
      PrinterPage.Header = 2540
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.LeftTitle.Strings = (
        ''
        'Produced by Eco Tools '#169' 1997 State Of The Art')
      PrinterPage.PageHeader.CenterTitle.Strings = (
        '')
      PrinterPage.PageSize.X = 210820
      PrinterPage.PageSize.Y = 297180
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInStyle = True
    end
  end
  object dxPrintDialog1: TdxPrintDialog
    StyleManager = dxPrintStyleManager1
    Left = 248
    Top = 160
  end
  object dxPageSetupDialog1: TdxPageSetupDialog
    ButtonsEnabled = [psbPreview, psbPrint]
    ButtonsVisible = [psbStyleOptions]
    OptionsVisible = [psoCenterOnPage, psoMargins, psoPageOrder, psoShading, psoStyleCaption, psoHFAutoText, psoHFBackground, psoHFFont, psoHFReverse, psoHFVertAlignment]
    PrintStyle = dxPrintStyleManager1Style1
    Left = 248
    Top = 192
  end
  object dlgImprimir: TPrintDialog
    Left = 368
    Top = 104
  end
end
