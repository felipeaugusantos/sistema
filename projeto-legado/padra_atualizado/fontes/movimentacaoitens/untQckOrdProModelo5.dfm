object frmQckOrdProModelo5: TfrmQckOrdProModelo5
  OldCreateOrder = False
  Height = 296
  Width = 310
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42941.675330266200000000
    ReportOptions.LastChange = 42941.675330266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 32
    Datasets = <
      item
        DataSet = frxDBComents
        DataSetName = 'frxDBComents'
      end
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
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
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 135.685115040000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo2: TfrxMemoView
          Width = 718.110700000000000000
          Height = 18.897650000000000000
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
        object Memo3: TfrxMemoView
          Top = 22.677180000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'F'#211'RMULA E PROCEDIMENTO DE FABRICA'#199#195'O')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 49.133890000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PRODUTO: [frxDBDataset."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 64.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LINHA: [frxDBDataset."GRU_DESGRU"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 79.370130000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'F'#211'RMULA:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Top = 94.488250000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QUANTIDADE (L):')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 114.165430000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 1.779530000000000000
          Top = 116.385900000000000000
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'MAT'#201'RIA-PRIMA')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 241.889920000000000000
          Top = 116.385900000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'N.R.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 330.598640000000000000
          Top = 116.385900000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'QTDE. F'#211'RM.')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 411.189240000000000000
          Top = 116.385900000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'VOLUME (L)')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 487.559370000000000000
          Top = 116.385900000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'MASSA (KG)')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 563.149970000000000000
          Top = 116.385900000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'DENSIDADE')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 638.740570000000000000
          Top = 116.385900000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'UTILIZADO')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 238.110390000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 328.819110000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 408.189240000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 485.559370000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 561.149970000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 636.961040000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 718.110700000000000000
          Top = 114.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 0.779530000000000000
          Top = 113.385900000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo20: TfrxMemoView
          Left = 68.031540000000000000
          Top = 79.370130000000000000
          Width = 275.905690000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."CODPRO"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 102.047310000000000000
          Top = 94.488250000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."QTDBAS"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.377952760000000000
          Top = 132.504020000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        RowCount = 0
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 1.779530000000000000
          Top = 1.220470000000000000
          Width = 234.330860000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."DESITE"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 330.598640000000000000
          Top = 1.220470000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."QTDFOR"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 411.189240000000000000
          Top = 1.220470000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."QTDITE"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 487.559370000000000000
          Top = 1.220470000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDBDataset."QTDITE"> * <frxDBDataset."DENSID">]'
            ''
            '')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 563.149970000000000000
          Top = 1.220470000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."DENSID"]')
          ParentFont = False
        end
        object Line17: TfrxLineView
          Left = 718.110700000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 0.377952760000000000
          Top = 14.677180000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line11: TfrxLineView
          Left = 238.110390000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 328.819110000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 408.189240000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 485.559370000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line15: TfrxLineView
          Left = 561.149970000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 636.961040000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 0.779530000000000000
          Top = 0.220470000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 415.748300000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 555.590910000000000000
          Top = 1.000000000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina [Page#]')
        end
        object Line20: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 294.803340000000000000
        Width = 718.110700000000000000
        Child = frxReport.Child1
        object Memo7: TfrxMemoView
          Top = 23.897650000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'PROCEDIMENTO DE FABRICA'#199#195'O')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 330.598640000000000000
          Top = 3.779530000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."QTDFOR">,MasterData1)]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 411.189240000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."QTDITE">,MasterData1)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 487.559370000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBDataset."QTDITE"> * <frxDBDataset."DENSID">,MasterDat' +
              'a1)]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 238.110390000000000000
          Top = 3.779530000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 370.393940000000000000
        Width = 718.110700000000000000
        object Subreport1: TfrxSubreport
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Page = frxReport.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDBComents
        DataSetName = 'frxDBComents'
        RowCount = 0
        object Memo6: TfrxMemoView
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBComents."DMT_DESCRI"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 48
    Top = 160
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
    Left = 200
    Top = 96
  end
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
    Left = 200
    Top = 32
  end
  object frxDBComents: TfrxDBDataset
    UserName = 'frxDBComents'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 200
    Top = 160
  end
  object frxReportMOD6: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42941.675330266200000000
    ReportOptions.LastChange = 42941.675330266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 96
    Datasets = <
      item
        DataSet = frxDBComents
        DataSetName = 'frxDBComents'
      end
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
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
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 110.007935040000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo2: TfrxMemoView
          Align = baWidth
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
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
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 22.677180000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'F'#211'RMULA E PROCEDIMENTO DE FABRICA'#199#195'O')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 49.133890000000000000
          Width = 521.574803149606300000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PRODUTO: [frxDBDataset."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baRight
          Left = 525.355006850393700000
          Top = 49.133890000000000000
          Width = 521.574803149606300000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'LINHA: [frxDBDataset."GRU_DESGRU"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 67.031540000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ORDEM PRODU'#199#195'O / LOTE:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 314.480520000000000000
          Top = 67.031540000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QUANTIDADE (L):')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 87.165430000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 1.779530000000000000
          Top = 89.385900000000000000
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'MAT'#201'RIA-PRIMA')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 453.543307090000000000
          Top = 89.385900000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'N.R.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 555.590551181102400000
          Top = 89.385900000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'QTDE. F'#211'RM.')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 657.637795280000000000
          Top = 89.385900000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'VOLUME (L)')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 759.685039370078700000
          Top = 89.385900000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'MASSA (KG)')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 861.732283464566900000
          Top = 89.385900000000000000
          Width = 75.590551181102360000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'DENSIDADE')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 944.881889763779500000
          Top = 89.385900000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'UTILIZADO')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 451.653543310000000000
          Top = 87.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 551.811023622047200000
          Top = 87.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 653.858267716535400000
          Top = 87.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 755.905511811023600000
          Top = 87.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 857.952755905511800000
          Top = 87.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 941.102362200000000000
          Top = 87.165430000000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo20: TfrxMemoView
          Left = 151.960730000000000000
          Top = 67.031540000000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."CODPRO"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 409.527830000000000000
          Top = 67.031540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."QTDBAS"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 105.504020000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line21: TfrxLineView
          Left = 240.110390000000000000
          Top = 87.141732280000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo28: TfrxMemoView
          Left = 241.889920000000000000
          Top = 89.409448820000000000
          Width = 166.299210160000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Line24: TfrxLineView
          Left = 411.748300000000000000
          Top = 87.141732280000000000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo30: TfrxMemoView
          Left = 414.748300000000000000
          Top = 89.409448820000000000
          Width = 34.015750470000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Align = baRight
          Left = 1046.929810000000000000
          Top = 88.100787401574800000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 0.779530000000000000
          Top = 87.307086614173230000
          Height = 18.519685040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 188.976500000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        RowCount = 0
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 1.779530000000000000
          Top = 1.220470000000000000
          Width = 234.330860000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."DESITE"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 555.590551180000000000
          Top = 1.220470000000000000
          Width = 94.488188980000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."QTDFOR"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 657.637795280000000000
          Top = 1.220470000000000000
          Width = 94.488188980000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxDBDataset."QTDITE"> * <frxDBDataset."FATPOR">]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 759.685039370000000000
          Top = 1.220470000000000000
          Width = 94.488188980000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxDBDataset."QTDITE"> * <frxDBDataset."DENSID"> * <frxDBDatas' +
              'et."FATPOR">]'
            ''
            '')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 861.732283464566900000
          Top = 1.220470000000000000
          Width = 75.590551181102360000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."DENSID"]')
          ParentFont = False
        end
        object Line17: TfrxLineView
          Align = baRight
          Left = 1046.929810000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Align = baWidth
          Top = 14.677180000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line11: TfrxLineView
          Left = 451.653543310000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 551.811023622047200000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 653.858267716535400000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 755.905511811023600000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line15: TfrxLineView
          Left = 857.952755905511800000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 941.102362204724400000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 0.779530000000000000
          Top = 0.220470000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 240.000000000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo29: TfrxMemoView
          Left = 241.889920000000000000
          Top = 1.133858270000000000
          Width = 166.299210160000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."REFERE"]')
          ParentFont = False
        end
        object Line23: TfrxLineView
          Left = 411.748300000000000000
          Height = 14.740155040000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo31: TfrxMemoView
          Left = 414.614173230000000000
          Top = 1.133858270000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."NUMFAS"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 389.291590000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Align = baRight
          Left = 884.410020000000000000
          Top = 1.000000000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina [Page#]')
        end
        object Line20: TfrxLineView
          Align = baWidth
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 268.346630000000000000
        Width = 1046.929810000000000000
        Child = frxReportMOD6.Child1
        object Memo7: TfrxMemoView
          Top = 23.897650000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'PROCEDIMENTO DE FABRICA'#199#195'O')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 555.590551181102400000
          Top = 3.779530000000000000
          Width = 94.488188976377950000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."QTDFOR">,MasterData1)]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 657.637795280000000000
          Top = 3.779530000000000000
          Width = 94.488188980000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBDataset."QTDITE">  * <frxDBDataset."FATPOR">,MasterDa' +
              'ta1)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 759.685039370000000000
          Top = 3.779530000000000000
          Width = 94.488188980000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBDataset."QTDITE"> * <frxDBDataset."DENSID">  * <frxDB' +
              'Dataset."FATPOR">,MasterData1)]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 459.212598425196900000
          Top = 3.779530000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.6n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'ArIal'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 343.937230000000000000
        Width = 1046.929810000000000000
        object Subreport1: TfrxSubreport
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          Page = frxReportMOD6.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDBComents
        DataSetName = 'frxDBComents'
        RowCount = 0
        object Memo6: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBComents."DMT_DESCRI"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportMOD7: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42941.675330266200000000
    ReportOptions.LastChange = 42941.675330266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 224
    Datasets = <
      item
        DataSet = frxDBComents
        DataSetName = 'frxDBComents'
      end
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 130.297652440000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo12: TfrxMemoView
          Left = 2.645669290000000000
          Top = 92.370112910000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'SEP')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 472.440944880000000000
          Top = 92.370112910000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 555.574583460000000000
          Top = 92.370112910000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            'UNIDADE')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 638.740157480315000000
          Top = 92.370112910000000000
          Width = 75.590551181102360000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            'CONFERIDO')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 63.118110240000000000
          Top = 92.370112910000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 122.834645670000000000
          Top = 92.370112910000000000
          Width = 347.716535430000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 551.811380000000000000
          Top = 71.488223150000000000
          Width = 79.370081180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 122.834645670000000000
          Top = 109.267780000000000000
          Width = 347.716740470000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'LOCALIZA'#199#195'O F'#205'SICA')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 25.015770000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ORDEM DE PRODU'#199#195'O N'#186'  [frxDBDataset."CODPRO"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 2.000000000000000000
          Top = 71.259876690000000000
          Width = 544.252320000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRODUTO: [frxDBDataset."CODBAS"] - [frxDBDataset."DESITECAB"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo5: TfrxMemoView
          Align = baWidth
          Top = 3.779527560000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
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
        object Line3: TfrxLineView
          Top = 88.606370000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Top = 123.401670000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo15: TfrxMemoView
          Left = 638.740157480000000000
          Top = 71.645669290000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."QTDBAS"]')
          ParentFont = False
        end
        object rllPedido: TfrxMemoView
          Align = baWidth
          Top = 47.133890000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'rllPedido')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        RowCount = 0
        Stretched = True
        object Line1: TfrxLineView
          Left = 2.645669290000000000
          Top = 15.118120000000000000
          Width = 56.692913390000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 638.740157480000000000
          Top = 15.118120000000000000
          Width = 75.590551180000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo1: TfrxMemoView
          Left = 63.118110240000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."CODITE"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 122.834645670000000000
          Top = 1.000000000000000000
          Width = 347.716535430000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."DESITE"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 122.724490000000000000
          Top = 16.118120000000000000
          Width = 347.716535430000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."LOCFIS"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 472.440944880000000000
          Top = 1.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."QTDITE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 551.811380000000000000
          Top = 1.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."SIGUNI"]')
          ParentFont = False
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 309.921460000000000000
        Width = 718.110700000000000000
        object SysMemo3: TfrxSysMemoView
          Left = 4.000000000000000000
          Top = 43.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            '[DATE]')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          Left = 620.063390000000000000
          Top = 43.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            '[TIME]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 4.000000000000000000
          Top = 7.779530000000000000
          Width = 94.488201180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'OBSERVA'#199#195'O')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 106.047310000000000000
          Top = 7.779530000000000000
          Width = 608.503939450000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."OBS001"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 106.047310000000000000
          Top = 23.677180000000000000
          Width = 608.503939450000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset."OBS002"]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Top = 3.779530000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Top = 41.574830000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
