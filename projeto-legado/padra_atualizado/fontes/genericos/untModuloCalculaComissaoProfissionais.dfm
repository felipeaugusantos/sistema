object frmModuloCalculaComissaoProfissionais: TfrmModuloCalculaComissaoProfissionais
  Left = 0
  Top = 0
  ClientHeight = 225
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 32
    Top = 16
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 80
    Top = 16
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
    Left = 32
    Top = 144
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
    Left = 80
    Top = 144
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
    Left = 128
    Top = 144
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
    Left = 176
    Top = 144
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
    Left = 128
    Top = 80
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
    Left = 32
    Top = 208
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
    Left = 128
    Top = 16
  end
  object frxUser: TfrxUserDataSet
    UserName = 'frxUser'
    Fields.Strings = (
      'DTAREC'
      'VALREC'
      'NOMREC'
      'NOMASS'
      'HISREC'
      'CIDREC'
      'NROVIA'
      'VLREXT')
    Left = 176
    Top = 16
  end
  object frxReciboJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 45848.449439768520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 80
    Datasets = <
      item
        DataSet = frxReportsBaixas
        DataSetName = 'frxReportsBaixas'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
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
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 222.992270000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Memo25: TfrxMemoView
          Left = 47.456710000000000000
          Top = 0.826840000000004200
          Width = 695.433520000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' [frxRelatorio."HISREC"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 26.456710000000000000
          Top = 0.826840000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARCA_"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 26.456710000000000000
          Top = 19.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 181.417440000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Stretched = True
        object Memo24: TfrxMemoView
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 49.133890000000000000
          Width = 699.213050000000000000
          Height = 45.354360000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[MOEDA] [VALREC] [PONTO]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 26.456710000000000000
          Top = 123.826840000000000000
          Width = 702.992580000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxRelatorio."NOMREC"] a importa' +
              'ncia supra mencionada de [MOEDA] [VALREC] [PONTO] [(] [VALEXT] [' +
              ')], referente:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 25.677180000000000000
          Top = 105.047310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 26.456710000000000000
          Top = 157.740260000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 177.637910000000000000
        Top = 453.543600000000000000
        Width = 755.906000000000000000
        object frxUserNOMASS: TfrxMemoView
          Left = 286.244280000000000000
          Top = 98.212740000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMASS"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 26.456710000000000000
          Top = 151.126160000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxRelatorio."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 26.456710000000000000
          Top = 11.338590000000010000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 370.393940000000000000
        Width = 755.906000000000000000
        DataSet = frxReportsBaixas
        DataSetName = 'frxReportsBaixas'
        RowCount = 0
        object Memo12: TfrxMemoView
          Left = 29.118120000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxReportsBaixas."DUPLICATA"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 170.078850000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxReportsBaixas."ESPECIE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 245.669450000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxReportsBaixas."CLIENTE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 389.291590000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxReportsBaixas."VALOR_ORIGINAL"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 529.134200000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxReportsBaixas."VALOR_ABATIDO"]')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 287.244280000000000000
        Width = 755.906000000000000000
        object Memo6: TfrxMemoView
          Left = 26.559060000000000000
          Top = 1.881880000000000000
          Width = 702.992580000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    No ato do acerto foi/foram abatidos [MOEDA] [ValorTotalComis' +
              'sao] [PONTO] [(] [ValorTotalComissaoExtenso] [)] de comiss'#227'o nos' +
              ' seguintes documentos do contas a receber:')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Memo7: TfrxMemoView
          Left = 28.456710000000000000
          Top = 34.015770000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 170.078850000000000000
          Top = 34.015770000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Especie')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 247.448980000000000000
          Top = 34.015770000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 389.291590000000000000
          Top = 34.015770000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor Original')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 529.134200000000000000
          Top = 34.015770000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor Abatido')
          ParentFont = False
        end
      end
    end
  end
  object frxReciboM: TfrxReport
    Version = '5.2'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 40343.742533993100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      '                              '
      'end.')
    Left = 80
    Top = 80
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 238.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."HISREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MARCA_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        Stretched = True
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object frxUserVALREC: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 68.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[MOEDA] [VALREC] [PONTO]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 192.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object frxUserNOMREC: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 739.200000000000000000
          Height = 34.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxRelatorio."NOMREC"] a importa' +
              'ncia supra mencionada de [MOEDA] [VALREC] [PONTO] [(] [VALEXT] [' +
              ')], referente: ')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 170.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 306.000000000000000000
        Width = 768.000000000000000000
        object frxUserNOMASS: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMASS"]')
          TruncOutboundText = False
        end
        object frxUserNROVIA: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxRelatorio."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object frxUserCIDREC: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxRPAJ: TfrxReport
    Version = '5.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40843.529159247700000000
    ReportOptions.LastChange = 41416.624533229170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo17OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."VALIMP"> = 0 Then'
      
        '    Memo17.Visible := False;                                    ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 128
    Top = 208
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
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
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 2.500000000000000000
      object rllHeader: TfrxHeader
        FillType = ftBrush
        Height = 377.952755910000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        object Shape3: TfrxShapeView
          Align = baCenter
          Left = 9.449069095000000000
          Top = 326.141930000000000000
          Width = 755.905511810000000000
          Height = 28.346456690000000000
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 9.449069095000000000
          Top = 13.228293970000000000
          Width = 755.905511810000000000
          Height = 37.795275590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 614.173478540000000000
          Top = 60.472480000000000000
          Width = 151.181102360000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.DropShadow = True
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO [frxRelatorio."NROREC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 15.118120000000000000
          Top = 69.921292800000000000
          Width = 585.826771650000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[ENDEMP]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 15.118120000000000000
          Top = 101.102421400000000000
          Width = 302.362204720000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ: [CGCEMP]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 462.992376180000000000
          Top = 101.102421400000000000
          Width = 302.362204720000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'INSCR. ESTADUAL: [IESEMP]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape1: TfrxShapeView
          Align = baCenter
          Left = 9.449069095000000000
          Top = 130.283464570000000000
          Width = 755.905511810000000000
          Height = 56.692913390000000000
        end
        object Memo6: TfrxMemoView
          Left = 15.118120000000000000
          Top = 136.062992130000000000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO CONTRIBUINTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 15.118120000000000000
          Top = 162.519790000000000000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[INSINSS]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 219.212740000000000000
          Top = 136.062992130000000000
          Width = 538.582677170000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMASS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 219.212740000000000000
          Top = 162.519790000000000000
          Width = 538.582677170000000000
          Height = 18.897650000000000000
          DataField = 'NUMPIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMPIS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape2: TfrxShapeView
          Align = baCenter
          Left = 9.449069095000000000
          Top = 191.976500000000000000
          Width = 755.905511810000000000
          Height = 79.370093390000000000
        end
        object Memo10: TfrxMemoView
          Left = 15.118120000000000000
          Top = 197.756027560000000000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SERVI'#199'OS PRESTADOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 15.118120000000000000
          Top = 244.212825430000000000
          Width = 377.952755910000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PER'#205'ODO DE [DTAINI] A [DTAFIN]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 219.212740000000000000
          Top = 197.756027560000000000
          Width = 538.582677170000000000
          Height = 45.354330710000000000
          DataField = 'HISREC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."HISREC"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 15.118120000000000000
          Top = 277.008040000000000000
          Width = 226.771653540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VALOR TOTAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 15.118120000000000000
          Top = 303.464750000000000000
          Width = 226.771653540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[RETINSS] [(][PERIMP][%][)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 15.118120000000000000
          Top = 329.921460000000000000
          Width = 226.771653540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'L'#205'QUIDO A RECEBER')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 644.409590400000000000
          Top = 277.008040000000000000
          Width = 113.385826770000000000
          Height = 18.897650000000000000
          DataField = 'VALTOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALTOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 644.409590400000000000
          Top = 303.464750000000000000
          Width = 113.385826770000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo17OnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALIMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 644.409590400000000000
          Top = 329.921460000000000000
          Width = 113.385826770000000000
          Height = 18.897650000000000000
          DataField = 'VALREC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rllFooter: TfrxFooter
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 442.205010000000000000
        Width = 774.803650000000000000
        object Memo19: TfrxMemoView
          Left = 15.118110240000000000
          Top = 7.559060000000000000
          Width = 744.566929130000000000
          Height = 37.795275590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'RECEBI DE [NOMEMP], A IMPORT'#194'NCIA DE [MOEDA] [FormatFloat('#39'#,##0' +
              '.00'#39', <frxRelatorio."VALREC">)] [PONTO] [(][frxRelatorio."VALEXT' +
              '"][)].')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 15.118110240000000000
          Top = 59.870130000000000000
          Width = 744.566929130000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDEMP], ___/___/______.')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 15.118120000000000000
          Top = 112.181200000000000000
          Width = 359.055118110000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMASS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 398.740299060000000000
          Top = 112.181200000000000000
          Width = 359.055118110000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'LIBERADO POR'
            '[OPELIB]')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Top = 419.527830000000000000
        Width = 774.803650000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
      end
    end
  end
  object frxRPAM: TfrxReport
    Version = '5.2'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40843.528674039350000000
    ReportOptions.LastChange = 40843.528674039350000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure DMPMemo20OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."VALIMP"> = 0 Then'
      
        '    DMPMemo20.Visible := False;                                 ' +
        '                    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 80
    Top = 208
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 215.899860564673400000
      PaperHeight = 278.870653229369800000
      PaperSize = 1
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 391.000000000000000000
        Top = 17.000000000000000000
        Width = 816.000000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 68.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Frame.DropShadow = True
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO [frxRelatorio."NROREC"]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            '[ENDEMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'CNPJ: [CGCEMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 102.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'CNPJ: [CGCEMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo6: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 777.600000000000000000
          Height = 51.000000000000000000
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'NOME DO CONTRIBUINTE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 170.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            '[INSINSS]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 136.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMASS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMASS"]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 170.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMPIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMPIS"]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo11: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 221.000000000000000000
          Width = 777.600000000000000000
          Height = 51.000000000000000000
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 221.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'SERVICOS PRESTADOS')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 255.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'PERIODO DE [DTAINI] A [DTAFIN]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 221.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataField = 'HISREC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."HISREC"]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 289.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VALOR TOTAL..........(+)')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 323.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[RETINSS] [(][PERIMP][%][)][..][(][-][)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baCenter
          Left = 19.200000000000000000
          Top = 357.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 357.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'LIQUIDO A RECEBER....(=)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 289.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALTOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALTOT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 323.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo20OnBeforePrint'
          DataField = 'VALIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALIMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 357.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Top = 425.000000000000000000
        Width = 816.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 442.000000000000000000
        Width = 816.000000000000000000
        object frxUserNOMASS: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMASS"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              'RECEBI DE [NOMEMP], A IMPORTANCIA DE [MOEDA] [FormatFloat('#39'#,##0' +
              '.00'#39', <frxRelatorio."VALREC">)] [PONTO] [(][frxRelatorio."VALEXT' +
              '"][)].')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CIDEMP], ___/___/______.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 136.000000000000000000
          Width = 384.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'LIBERADO POR'
            '[OPELIB]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportsBaixas: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxReportsBaixas'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 216
    Top = 16
  end
end
