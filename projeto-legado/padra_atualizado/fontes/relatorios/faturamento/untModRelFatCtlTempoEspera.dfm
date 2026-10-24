object frmModRelFatCtlTempoEspera: TfrmModRelFatCtlTempoEspera
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 268
  Width = 408
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
    Left = 32
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
    Left = 232
    Top = 80
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
    Left = 332
    Top = 144
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
    Left = 332
    Top = 80
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
    Left = 32
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
    Left = 136
    Top = 144
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMPED=NUMPED'
      'CODCLI=CODCLI'
      'NOMCLI=NOMCLI'
      'DOCVEN=DOCVEN'
      'CODMOT=CODMOT'
      'NOMMOT=NOMMOT'
      'ESPER1=ESPER1'
      'ESPER2=ESPER2'
      'ESPER3=ESPER3'
      'DTAPED=DTAPED'
      'HORPED=HORPED'
      'DTAFAT=DTAFAT'
      'HORFAT=HORFAT'
      'DTAENT=DTAENT'
      'HORENT=HORENT'
      'DTACHE=DTACHE'
      'HORCHE=HORCHE'
      'TOTESP=TOTESP'
      'CTRFAT=CTRFAT'
      'CTRENT=CTRENT'
      'CTRCHE=CTRCHE')
    DataSet = cdsRelatorio
    BCDToCurrency = False
    Left = 32
    Top = 208
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 136
    Top = 208
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
    Left = 232
    Top = 144
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 16
    object cdsRelatorioNUMPED: TStringField
      FieldName = 'NUMPED'
      Size = 19
    end
    object cdsRelatorioCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsRelatorioNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsRelatorioDOCVEN: TStringField
      FieldName = 'DOCVEN'
      Size = 19
    end
    object cdsRelatorioCODMOT: TStringField
      FieldName = 'CODMOT'
      Size = 5
    end
    object cdsRelatorioNOMMOT: TStringField
      FieldName = 'NOMMOT'
      Size = 60
    end
    object cdsRelatorioESPER1: TStringField
      FieldName = 'ESPER1'
    end
    object cdsRelatorioESPER2: TStringField
      FieldName = 'ESPER2'
    end
    object cdsRelatorioESPER3: TStringField
      FieldName = 'ESPER3'
    end
    object cdsRelatorioDTAPED: TStringField
      FieldName = 'DTAPED'
    end
    object cdsRelatorioHORPED: TStringField
      FieldName = 'HORPED'
    end
    object cdsRelatorioDTAFAT: TStringField
      FieldName = 'DTAFAT'
    end
    object cdsRelatorioHORFAT: TStringField
      FieldName = 'HORFAT'
    end
    object cdsRelatorioDTAENT: TStringField
      FieldName = 'DTAENT'
    end
    object cdsRelatorioHORENT: TStringField
      FieldName = 'HORENT'
    end
    object cdsRelatorioDTACHE: TStringField
      FieldName = 'DTACHE'
    end
    object cdsRelatorioHORCHE: TStringField
      FieldName = 'HORCHE'
    end
    object cdsRelatorioTOTESP: TStringField
      FieldName = 'TOTESP'
    end
    object cdsRelatorioCTRFAT: TStringField
      FieldName = 'CTRFAT'
      Size = 1
    end
    object cdsRelatorioCTRENT: TStringField
      FieldName = 'CTRENT'
      Size = 1
    end
    object cdsRelatorioCTRCHE: TStringField
      FieldName = 'CTRCHE'
      Size = 1
    end
  end
  object frxRelatorioM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40994.476561956000000000
    ReportOptions.LastChange = 40994.713546180600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 136
    Top = 16
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
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1324.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 326.400000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1238.400000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object rllComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80#15#27#80#18#27#77'
        end
        object rllEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMMOT]')
          TruncOutboundText = False
        end
        object rllPeriodo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NOMCLI]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 192.000000000000000000
          Top = 119.000000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 85.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[NOMCID]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 102.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[NOMREG]')
          TruncOutboundText = False
        end
      end
      object rlbTitCol: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 187.000000000000000000
        Width = 1324.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'DT.PEDIDO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DOC.VENDA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'PEDIDO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[TITMOT]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'FATUR.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'TEMPO'
            'ESPERA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'ENTREG')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'TEMPO'
            'ESPERA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'CHEGAD')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'TEMPO'
            'ESPERA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL'
            'ESPERA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1324.800000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '* EVENTO OCORREU EM DIA DIFERENTE DA DATA DO PEDIDO')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1324.800000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."DTAPED"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMPED"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1305.600000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DOCVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMMOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMMOT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'HORPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORPED"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORFAT"][frxRelatorio."CTRFAT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPER1'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESPER1"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORENT"][frxRelatorio."CTRENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPER2'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESPER2"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORCHE"][frxRelatorio."CTRCHE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPER3'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESPER3"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1228.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTESP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTESP"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1324.800000000000000000
      end
    end
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40994.476561956000000000
    ReportOptions.LastChange = 40994.713546180600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 232
    Top = 16
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
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 278.900000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 321.260050000000000000
        Width = 1238.929934000000000000
        object Memo2: TfrxMemoView
          Align = baClient
          Width = 1238.929934000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 139.842519690000000000
        Top = 18.897650000000000000
        Width = 1238.929934000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 288.264967000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 336.264967000000000000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1091.200000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA [Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1158.400000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 1004.800000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object rllEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMMOT]')
          ParentFont = False
        end
        object rllPeriodo: TfrxMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 369.864967000000000000
          Top = 119.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 736.000000000000000000
          Top = 85.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOMCID]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 736.000000000000000000
          Top = 102.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NOMREG]')
          ParentFont = False
        end
      end
      object rlbTitCol: TfrxHeader
        FillType = ftBrush
        Height = 37.795275590551180000
        Top = 219.212740000000000000
        Width = 1238.929934000000000000
        ReprintOnNewPage = True
        object Memo30: TfrxMemoView
          Align = baClient
          Width = 1238.929934000000000000
          Height = 37.795275590551180000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.897637800000012000
          Width = 73.700787400000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT. PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 86.200000000000000000
          Top = 1.897637800000012000
          Width = 117.165378740000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 204.615770000000000000
          Top = 1.897637800000012000
          Width = 241.889739370000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 450.400000000000000000
          Top = 1.897637800000012000
          Width = 121.020469999999900000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOC. VENDA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 745.600000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNomMot: TfrxMemoView
          Left = 572.595300000000200000
          Top = 1.897637800000012000
          Width = 170.759060000000100000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[TITMOT]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 805.800000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'FATUR.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 866.000000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TEMPO'
            'ESPERA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 927.200000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'ENTREGA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 988.400000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TEMPO'
            'ESPERA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 1048.600000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'HORA'
            'CHEGADA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 1108.800000000000000000
          Top = 1.897637800000012000
          Width = 57.600000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TEMPO'
            'ESPERA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 1169.000000000000000000
          Top = 1.897637800000012000
          Width = 67.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAL'
            'ESPERA')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 400.630180000000000000
        Width = 1238.929934000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 732.522820000000000000
          Top = 17.000000000000000000
          Width = 502.677180000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 9.600000000000000000
          Width = 411.968770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '* EVENTO OCORREU EM DIA DIFERENTE DA DATA DO PEDIDO')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 279.685220000000000000
        Width = 1238.929934000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1238.929934000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 9.600000000000000000
          Width = 56.692913385826770000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."DTAPED"]'
            '')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 86.200000000000000000
          Width = 117.165378740000000000
          Height = 17.000000000000000000
          DataField = 'NUMPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMPED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 204.615769999999900000
          Width = 241.889739369999900000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 450.400000000000000000
          Width = 121.020469999999900000
          Height = 17.000000000000000000
          DataField = 'DOCVEN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 572.595300000000200000
          Width = 170.759060000000100000
          Height = 17.000000000000000000
          DataField = 'NOMMOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMMOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 745.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'HORPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORPED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 805.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORFAT"][frxRelatorio."CTRFAT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 866.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPER1'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESPER1"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 927.200000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORENT"][frxRelatorio."CTRENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 988.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPER2'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESPER2"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 1048.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."HORCHE"][frxRelatorio."CTRCHE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 1108.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPER3'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESPER3"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 1169.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTESP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTESP"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
