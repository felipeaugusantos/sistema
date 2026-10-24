object frmModuloFr3: TfrmModuloFr3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 514
  Width = 387
  object frxRepor: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 40564.368349247680000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 16
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
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 25.877180000000000000
        Top = 64.252010000000000000
        Visible = False
        Width = 793.701300000000000000
      end
    end
  end
  object frxDBImpEti: TfrxDBDataset
    UserName = 'frxDBImpEti'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 88
    Top = 16
  end
  object frxReporM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41332.327133761570000000
    ReportOptions.LastChange = 41332.327133761570000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 80
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
    object Page1: TfrxDMPPage
      PaperWidth = 210.819863845504600000
      PaperHeight = 296.862308276425900000
      PaperSize = 9
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 796.800000000000000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    FileName = 'C:\DOCUME~1\Usuario\CONFIG~1\Temp\fr117.tmp'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    EscModel = 3
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = False
    Left = 96
    Top = 80
  end
  object frxPDFExport: TfrxPDFExport
    ShowDialog = False
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
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 88
    Top = 136
  end
  object frxReportVias: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 42402.731566562500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      'procedure FooterViasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure HeaderViasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      '                         '
      ''
      'end.')
    Left = 32
    Top = 232
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
    object pageVias: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 7.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftTop]
      OnAfterPrint = 'pageViasOnAfterPrint'
      object masterVias: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'masterViasOnBeforePrint'
        Child = frxReportVias.ChildVias
        RowCount = 1
        object subRelatorio: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportVias.subRelat
        end
      end
      object ChildVias: TfrxChild
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 64.252010000000000000
        Width = 718.110700000000000000
      end
    end
    object subRelat: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        DataSet = frxDBImpEti
        DataSetName = 'frxDBImpEti'
        RowCount = 0
      end
    end
  end
end
