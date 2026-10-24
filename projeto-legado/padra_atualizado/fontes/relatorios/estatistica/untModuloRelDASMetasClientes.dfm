object frmModuloRelDASMetasClientes: TfrmModuloRelDASMetasClientes
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 300
  Width = 289
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 40
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
    Left = 200
    Top = 16
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
    Left = 120
    Top = 72
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
    Left = 200
    Top = 72
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
    Left = 200
    Top = 128
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
    Left = 40
    Top = 72
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
    Left = 40
    Top = 128
  end
  object frxAnaliticoM: TfrxReport
    Version = '5.2'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40485.414400497700000000
    ReportOptions.LastChange = 40487.714726562500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  pIniciaProcessamento;    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pProcessaCliente(<frxRelatorio."CODCLI">, <frxRelatorio."FATUR' +
        'A">);'
      'end;'
      ''
      'begin'
      'end.')
    OnUserFunction = frxAnaliticoMUserFunction
    Left = 40
    Top = 184
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxConRec
        DataSetName = 'frxConRec'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxUserGen
        DataSetName = 'frxUserGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 330.199786745971100000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1228.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
          Left = 336.000000000000000000
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
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 988.800000000000000000
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
        object rllRepresentante: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          TruncOutboundText = False
        end
        object rllEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 85.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 170.000000000000000000
        Width = 1228.800000000000000000
        ReprintOnNewPage = True
        object rllTitClient: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object rllTitDescri: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object rllTitDtaIni: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DT.INICIAL')
          TruncOutboundText = False
        end
        object rllTitDtaFin: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DT.FINAL')
          TruncOutboundText = False
        end
        object rllTitMetLit: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MET LT/KG')
          TruncOutboundText = False
        end
        object rllTitLitrag: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          TruncOutboundText = False
        end
        object rllTitMetFat: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MET FATURA')
          TruncOutboundText = False
        end
        object rllTitFatura: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'FATURAM.')
          TruncOutboundText = False
        end
        object rllTitRealiz: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%REALIZ.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1228.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rdbValClient: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
        object rdbValDescri: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          TruncOutboundText = False
        end
        object rdbValDtaIni: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DTAINI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAINI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValDtaFin: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DTAFIN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAFIN"]')
          TruncOutboundText = False
        end
        object rdbValMetLit: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METLIT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METLIT"]')
          TruncOutboundText = False
        end
        object rdbValLitrag: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'LITRAG'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LITRAG"]')
          TruncOutboundText = False
        end
        object rdbValMetFat: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METVAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METVAL"]')
          TruncOutboundText = False
        end
        object rdbValFatura: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FATURA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FATURA"]')
          TruncOutboundText = False
        end
        object rdbValRealiz: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REALIZ"]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1228.800000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODREP"'
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REPRESENTANTE:')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMREP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMREP"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 306.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo4: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METLIT">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METVAL">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTREP'
          DataSet = frxUserGen
          DataSetName = 'frxUserGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserGen."TOTREP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."REALIZ">,rlbDetalhes)/COUNT(rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 85.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 85.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 85.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 901.000000000000000000
        Width = 1228.800000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbDetConRec: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 561.000000000000000000
        Width = 1228.800000000000000000
        DataSet = frxConRec
        DataSetName = 'frxConRec'
        RowCount = 0
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxConRec."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCID'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCID"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCER'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCER"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'TOTREC'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."TOTREC"]')
          TruncOutboundText = False
        end
      end
      object rltTitConRec: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 442.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VENCIDAS')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'A VENCER')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTAS A RECEBER EM ABERTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 527.000000000000000000
        Width = 1228.800000000000000000
        Condition = 'frxConRec."CODREP"'
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REPRESENTANTE:')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMREP'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxConRec."NOMREP"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 595.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo20: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCID">,rlbDetConRec)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCER">,rlbDetConRec)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."TOTREC">,rlbDetConRec)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          TruncOutboundText = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 748.000000000000000000
        Width = 1228.800000000000000000
        Condition = 'frxMarPra."CODREP"'
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REPRESENTANTE:')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMREP'
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxMarPra."NOMREP"]')
          TruncOutboundText = False
        end
      end
      object rlbDetMarPra: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 782.000000000000000000
        Width = 1228.800000000000000000
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
        RowCount = 0
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxMarPra."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda(<frxMarPra."TOTCUS">, <frxMarPra."TOTITE">)' +
              ')]%')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxMarPra."TOTPRA"> = 0,0, (<frxMarPra."PARPRA"> / <frxMa' +
              'rPra."TOTPRA">)))]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 816.000000000000000000
        Width = 1228.800000000000000000
        object rllTotMar: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda((SUM(<frxMarPra."TOTCUS">,rlbDetMarPra)), (' +
              'SUM(<frxMarPra."TOTITE">,rlbDetMarPra))))]%')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotPra: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(SUM(<frxMarPra."TOTPRA">,rlbDetMarPra) = 0,0, (SUM(<frxMar' +
              'Pra."PARPRA">,rlbDetMarPra) / SUM(<frxMarPra."TOTPRA">,rlbDetMar' +
              'Pra))))]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 998.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          TruncOutboundText = False
        end
      end
      object rlbTitMarPra: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 663.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MARGEM E PRAZO MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PRAZO')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxConRec: TfrxDBDataset
    UserName = 'frxConRec'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 120
    Top = 16
  end
  object frxMarPra: TfrxDBDataset
    UserName = 'frxMarPra'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 120
    Top = 184
  end
  object frxSinteticoM: TfrxReport
    Version = '5.2'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40485.414400497700000000
    ReportOptions.LastChange = 40487.693519594900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' pIniciaProcessamento;    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pProcessaCliente(<frxRelatorio."CODCLI">, <frxRelatorio."FATUR' +
        'A">);'
      'end;'
      ''
      'begin'
      'end.')
    OnUserFunction = frxAnaliticoMUserFunction
    Left = 200
    Top = 184
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxConRec
        DataSetName = 'frxConRec'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxUserGen
        DataSetName = 'frxUserGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 330.199786745971100000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1228.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
          Left = 336.000000000000000000
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
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 988.800000000000000000
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
        object rllRepresentante: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REPRESENTANTE]')
          TruncOutboundText = False
        end
        object rllEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 85.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 170.000000000000000000
        Width = 1228.800000000000000000
        ReprintOnNewPage = True
        object rllTitClient: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REPRESENTANTE')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object rllTitMetLit: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MET LT/KG')
          TruncOutboundText = False
        end
        object rllTitLitrag: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          TruncOutboundText = False
        end
        object rllTitMetFat: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MET FATURA')
          TruncOutboundText = False
        end
        object rllTitFatura: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'FATURAM.')
          TruncOutboundText = False
        end
        object rllTitRealiz: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%REALIZ.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1228.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rdbValClient: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMREP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMREP"]')
          TruncOutboundText = False
        end
        object rdbValMetLit: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METLIT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METLIT"]')
          TruncOutboundText = False
        end
        object rdbValLitrag: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'LITRAG'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LITRAG"]')
          TruncOutboundText = False
        end
        object rdbValMetFat: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METVAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METVAL"]')
          TruncOutboundText = False
        end
        object rdbValFatura: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FATURA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FATURA"]')
          TruncOutboundText = False
        end
        object rdbValRealiz: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REALIZ"]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 238.000000000000000000
        Width = 1228.800000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODREP"'
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 289.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo4: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METLIT">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METVAL">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTREP'
          DataSet = frxUserGen
          DataSetName = 'frxUserGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserGen."TOTREP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."REALIZ">,rlbDetalhes)/COUNT(rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 85.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 85.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 85.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 850.000000000000000000
        Width = 1228.800000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbDetConRec: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 510.000000000000000000
        Width = 1228.800000000000000000
        DataSet = frxConRec
        DataSetName = 'frxConRec'
        RowCount = 0
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMREP'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxConRec."NOMREP"]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCID'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCID"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCER'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCER"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'TOTREC'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."TOTREC"]')
          TruncOutboundText = False
        end
      end
      object rltTitConRec: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 425.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REPRESENTANTE')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VENCIDAS')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'A VENCER')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTAS A RECEBER EM ABERTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
      end
      object rlbDetMarPra: TfrxMasterData
        FillType = ftBrush
        Top = 714.000000000000000000
        Width = 1228.800000000000000000
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
        RowCount = 0
      end
      object rlbTitMarPra: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 612.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REPRESENTANTE')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1219.200000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Align = baCenter
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MARGEM E PRAZO MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PRAZO')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 544.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo20: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCID">,rlbDetConRec)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCER">,rlbDetConRec)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."TOTREC">,rlbDetConRec)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 765.000000000000000000
        Width = 1228.800000000000000000
        object rllTotMar: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda((SUM(<frxMarPra."TOTCUS">,rlbDetMarPra)), (' +
              'SUM(<frxMarPra."TOTITE">,rlbDetMarPra))))]%')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotPra: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(SUM(<frxMarPra."TOTPRA">,rlbDetMarPra) = 0,0, (SUM(<frxMar' +
              'Pra."PARPRA">,rlbDetMarPra) / SUM(<frxMarPra."TOTPRA">,rlbDetMar' +
              'Pra))))]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 998.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          TruncOutboundText = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Top = 697.000000000000000000
        Width = 1228.800000000000000000
        Condition = 'frxMarPra."CODREP"'
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 731.000000000000000000
        Width = 1228.800000000000000000
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMREP'
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxMarPra."NOMREP"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(SUM(<frxMarPra."TOTPRA">,rlbDetMarPra) = 0,0, (SUM(<frxMar' +
              'Pra."PARPRA">,rlbDetMarPra) / SUM(<frxMarPra."TOTPRA">,rlbDetMar' +
              'Pra))))]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda((SUM(<frxMarPra."TOTCUS">,rlbDetMarPra)), (' +
              'SUM(<frxMarPra."TOTITE">,rlbDetMarPra))))]%')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxAnaliticoJ: TfrxReport
    Version = '5.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40485.414400497700000000
    ReportOptions.LastChange = 40487.728269490740000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  pIniciaProcessamento;    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pProcessaCliente(<frxRelatorio."CODCLI">, <frxRelatorio."FATUR' +
        'A">);'
      'end;'
      ''
      'begin'
      'end.')
    OnUserFunction = frxAnaliticoMUserFunction
    Left = 40
    Top = 240
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxConRec
        DataSetName = 'frxConRec'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxUserGen
        DataSetName = 'frxUserGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 330.199786750000000000
      PaperHeight = 278.870653230000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 107.661410000000000000
        Top = 18.897650000000000000
        Width = 1228.800000015228000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 283.200000007613800000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
          Left = 331.200000007613800000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1099.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1147.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 988.800000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object rllRepresentante: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REPRESENTANTE]')
        end
        object rllEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Top = 85.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 37.795275590551180000
        Top = 188.976500000000000000
        Width = 1228.800000015228000000
        ReprintOnNewPage = True
        object Memo9: TfrxMemoView
          Left = 4.005905010000000000
          Top = 16.051175000000000000
          Width = 1220.788190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object rllTitClient: TfrxMemoView
          Left = 14.600000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object rllTitDescri: TfrxMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
        end
        object rllTitDtaIni: TfrxMemoView
          Left = 503.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT.INICIAL')
          ParentFont = False
        end
        object rllTitDtaFin: TfrxMemoView
          Left = 609.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DT.FINAL')
          ParentFont = False
        end
        object rllTitMetLit: TfrxMemoView
          Left = 713.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MET LT/KG')
          ParentFont = False
        end
        object rllTitLitrag: TfrxMemoView
          Left = 814.600000000000000000
          Top = 17.000000000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          ParentFont = False
        end
        object rllTitMetFat: TfrxMemoView
          Left = 926.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MET FATURA')
          ParentFont = False
        end
        object rllTitFatura: TfrxMemoView
          Left = 1031.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FATURAM.')
          ParentFont = False
        end
        object rllTitRealiz: TfrxMemoView
          Left = 1137.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%REALIZ.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 291.023810000000000000
        Width = 1228.800000015228000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1228.800000015228000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rdbValClient: TfrxMemoView
          Left = 14.600000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
        end
        object rdbValDescri: TfrxMemoView
          Left = 259.200000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DESCRI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
        end
        object rdbValDtaIni: TfrxMemoView
          Left = 503.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DTAINI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAINI"]')
          WordWrap = False
        end
        object rdbValDtaFin: TfrxMemoView
          Left = 609.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'DTAFIN'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAFIN"]')
        end
        object rdbValMetLit: TfrxMemoView
          Left = 713.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METLIT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METLIT"]')
        end
        object rdbValLitrag: TfrxMemoView
          Left = 814.600000000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'LITRAG'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LITRAG"]')
        end
        object rdbValMetFat: TfrxMemoView
          Left = 926.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METVAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METVAL"]')
        end
        object rdbValFatura: TfrxMemoView
          Left = 1031.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FATURA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FATURA"]')
        end
        object rdbValRealiz: TfrxMemoView
          Left = 1137.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REALIZ"]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 249.448980000000000000
        Width = 1228.800000015228000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODREP"'
        object Memo2: TfrxMemoView
          Left = 14.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REPRESENTANTE:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 153.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMREP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."NOMREP"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 69.897650000000000000
        Top = 332.598640000000000000
        Width = 1228.800000015228000000
        object Memo4: TfrxMemoView
          Left = 713.000000000000000000
          Top = 3.771645000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 814.600000000000000000
          Top = 3.771645000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 926.200000000000000000
          Top = 3.771645000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METVAL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1031.800000000000000000
          Top = 3.771645000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTREP'
          DataSet = frxUserGen
          DataSetName = 'frxUserGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserGen."TOTREP"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 1137.400000000000000000
          Top = 3.771645000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."REALIZ">,rlbDetalhes)/COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 814.151640000000000000
          Top = 26.456710000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 814.931170000000000000
          Top = 49.354360000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 591.283860000000000000
          Top = 3.779530000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 591.945270000000000000
          Top = 26.456710000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 591.945270000000000000
          Top = 50.133890000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 854.173780000000000000
        Width = 1228.800000015228000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 596.938590000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 607.359060000000000000
          Top = 17.000000000000000000
          Width = 606.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbDetConRec: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 532.913730000000000000
        Width = 1228.800000015228000000
        DataSet = frxConRec
        DataSetName = 'frxConRec'
        RowCount = 0
        object rllZebra1: TfrxMemoView
          Align = baClient
          Width = 1228.800000015228000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 14.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxConRec."NOMCLI"]')
        end
        object Memo11: TfrxMemoView
          Left = 907.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCID'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCID"]')
        end
        object Memo12: TfrxMemoView
          Left = 1012.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCER'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCER"]')
        end
        object Memo19: TfrxMemoView
          Left = 1118.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'TOTREC'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."TOTREC"]')
        end
      end
      object rltTitConRec: TfrxHeader
        FillType = ftBrush
        Height = 41.543290000000000000
        Top = 427.086890000000000000
        Width = 1228.800000015228000000
        object Memo31: TfrxMemoView
          Left = 4.005905010000000000
          Top = 19.015770000000000000
          Width = 1220.788190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 14.600000000000000000
          Top = 19.964595000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 907.000000000000000000
          Top = 19.964595000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VENCIDAS')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 1012.600000000000000000
          Top = 19.964595000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A VENCER')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Top = 2.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTAS A RECEBER EM ABERTO')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 19.964595000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 491.338900000000000000
        Width = 1228.800000015228000000
        Condition = 'frxConRec."CODREP"'
        object Memo24: TfrxMemoView
          Left = 14.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REPRESENTANTE:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 153.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMREP'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxConRec."NOMREP"]')
          ParentFont = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 24.543290000000000000
        Top = 574.488560000000000000
        Width = 1228.800000015228000000
        object Memo20: TfrxMemoView
          Left = 907.000000000000000000
          Top = 3.771645000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCID">,rlbDetConRec)]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 1012.600000000000000000
          Top = 3.771645000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCER">,rlbDetConRec)]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 3.771645000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."TOTREC">,rlbDetConRec)]')
          ParentFont = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 687.874460000000000000
        Width = 1228.800000015228000000
        Condition = 'frxMarPra."CODREP"'
        object Memo26: TfrxMemoView
          Left = 14.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REPRESENTANTE:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 153.600000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMREP'
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxMarPra."NOMREP"]')
          ParentFont = False
        end
      end
      object rlbDetMarPra: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 729.449290000000000000
        Width = 1228.800000015228000000
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
        RowCount = 0
        object rllZebra2: TfrxMemoView
          Align = baClient
          Width = 1228.800000015228000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 14.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMCLI'
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxMarPra."NOMCLI"]')
        end
        object Memo29: TfrxMemoView
          Left = 1012.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda(<frxMarPra."TOTCUS">, <frxMarPra."TOTITE">)' +
              ')]%')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 1118.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxMarPra."TOTPRA"> = 0,0, (<frxMarPra."PARPRA"> / <frxMa' +
              'rPra."TOTPRA">)))]')
          WordWrap = False
        end
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 771.024120000000000000
        Width = 1228.800000015228000000
        object rllTotMar: TfrxMemoView
          Left = 1012.600000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda((SUM(<frxMarPra."TOTCUS">,rlbDetMarPra)), (' +
              'SUM(<frxMarPra."TOTITE">,rlbDetMarPra))))]%')
          ParentFont = False
          WordWrap = False
        end
        object rllTotPra: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 2.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(SUM(<frxMarPra."TOTPRA">,rlbDetMarPra) = 0,0, (SUM(<frxMar' +
              'Pra."PARPRA">,rlbDetMarPra) / SUM(<frxMarPra."TOTPRA">,rlbDetMar' +
              'Pra))))]')
          ParentFont = False
        end
      end
      object rlbTitMarPra: TfrxHeader
        FillType = ftBrush
        Height = 41.543290000000000000
        Top = 623.622450000000000000
        Width = 1228.800000015228000000
        object Memo23: TfrxMemoView
          Left = 4.005905010000000000
          Top = 19.015770000000000000
          Width = 1220.788190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 14.600000000000000000
          Top = 19.964595000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 1022.200000000000000000
          Top = 19.964595000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Top = 2.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MARGEM E PRAZO MEDIO')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 19.964595000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PRAZO')
          ParentFont = False
        end
      end
    end
  end
  object frxSinteticoJ: TfrxReport
    Version = '5.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40485.414400497700000000
    ReportOptions.LastChange = 40487.743168761580000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' pIniciaProcessamento;    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pProcessaCliente(<frxRelatorio."CODCLI">, <frxRelatorio."FATUR' +
        'A">);'
      'end;'
      ''
      'begin'
      'end.')
    OnUserFunction = frxAnaliticoMUserFunction
    Left = 120
    Top = 240
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxConRec
        DataSetName = 'frxConRec'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxUserGen
        DataSetName = 'frxUserGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 330.199786750000000000
      PaperHeight = 278.870653230000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 107.716535433071000000
        Top = 18.897650000000000000
        Width = 1228.800000015228000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 283.200000007613800000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
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
          Left = 331.200000007613800000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1152.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 988.800000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object rllRepresentante: TfrxMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REPRESENTANTE]')
        end
        object rllEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Top = 85.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ORDEM]')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 188.976500000000000000
        Width = 1228.800000015228000000
        ReprintOnNewPage = True
        object Memo9: TfrxMemoView
          Left = 7.559060000000000000
          Top = 16.051175000000000000
          Width = 1220.788190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          ParentFont = False
        end
        object rllTitClient: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REPRESENTANTE')
          ParentFont = False
        end
        object rllTitMetLit: TfrxMemoView
          Left = 711.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MET LT/KG')
          ParentFont = False
        end
        object rllTitLitrag: TfrxMemoView
          Left = 815.600000000000000000
          Top = 17.000000000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LITROS/KILOS')
          ParentFont = False
        end
        object rllTitMetFat: TfrxMemoView
          Left = 926.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MET FATURA')
          ParentFont = False
        end
        object rllTitFatura: TfrxMemoView
          Left = 1031.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FATURAM.')
          ParentFont = False
        end
        object rllTitRealiz: TfrxMemoView
          Left = 1137.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%REALIZ.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURAMENTO')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.126160000000000000
        Width = 1228.800000015228000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1228.800000015228000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rdbValClient: TfrxMemoView
          Left = 9.600000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMREP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMREP"]')
        end
        object rdbValMetLit: TfrxMemoView
          Left = 711.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METLIT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METLIT"]')
        end
        object rdbValLitrag: TfrxMemoView
          Left = 815.600000000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'LITRAG'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LITRAG"]')
        end
        object rdbValMetFat: TfrxMemoView
          Left = 926.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'METVAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."METVAL"]')
        end
        object rdbValFatura: TfrxMemoView
          Left = 1031.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FATURA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FATURA"]')
        end
        object rdbValRealiz: TfrxMemoView
          Left = 1137.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REALIZ"]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 249.448980000000000000
        Width = 1228.800000015228000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODREP"'
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 69.921289130000000000
        Top = 313.700990000000000000
        Width = 1228.800000015228000000
        object Memo4: TfrxMemoView
          Left = 711.000000000000000000
          Top = 3.783464570000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 815.600000000000000000
          Top = 3.783464570000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 926.200000000000000000
          Top = 3.783464566929134000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."METVAL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1031.800000000000000000
          Top = 3.783464566929134000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTREP'
          DataSet = frxUserGen
          DataSetName = 'frxUserGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserGen."TOTREP"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 1137.400000000000000000
          Top = 3.783464566929134000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."REALIZ">,rlbDetalhes)/COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 815.151640000000000000
          Top = 26.456710000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTLIT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 815.151640000000000000
          Top = 49.133890000000000000
          Width = 103.559060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTKIL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 574.488560000000000000
          Top = 3.779530000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 574.488560000000000000
          Top = 27.236240000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LITROS:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 574.488560000000000000
          Top = 49.133890000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL KILOS:')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 793.701300000000000000
        Width = 1228.800000015228000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 589.379530000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 599.800000000000000000
          Top = 17.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbDetConRec: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 468.661720000000000000
        Width = 1228.800000015228000000
        DataSet = frxConRec
        DataSetName = 'frxConRec'
        RowCount = 0
        object rllZebra1: TfrxMemoView
          Align = baClient
          Width = 1228.800000015228000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMREP'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxConRec."NOMREP"]')
        end
        object Memo11: TfrxMemoView
          Left = 907.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCID'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCID"]')
        end
        object Memo12: TfrxMemoView
          Left = 1012.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'VENCER'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."VENCER"]')
        end
        object Memo19: TfrxMemoView
          Left = 1118.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'TOTREC'
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxConRec."TOTREC"]')
        end
      end
      object rltTitConRec: TfrxHeader
        FillType = ftBrush
        Height = 37.763760000000000000
        Top = 408.189240000000000000
        Width = 1228.800000015228000000
        object Memo13: TfrxMemoView
          Left = 9.600000000000000000
          Top = 19.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REPRESENTANTE')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 907.000000000000000000
          Top = 19.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VENCIDAS')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 1012.600000000000000000
          Top = 19.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'A VENCER')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Top = 2.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTAS A RECEBER EM ABERTO')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 19.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
      object rlbDetMarPra: TfrxMasterData
        FillType = ftBrush
        Top = 642.520100000000000000
        Width = 1228.800000015228000000
        DataSet = frxMarPra
        DataSetName = 'frxMarPra'
        RowCount = 0
      end
      object rlbTitMarPra: TfrxHeader
        FillType = ftBrush
        Height = 37.763760000000000000
        Top = 559.370440000000000000
        Width = 1228.800000015228000000
        object Memo34: TfrxMemoView
          Left = 9.600000000000000000
          Top = 19.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REPRESENTANTE')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 1022.200000000000000000
          Top = 19.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARGEM')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Align = baCenter
          Left = 331.200000007613800000
          Top = 2.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'MARGEM E PRAZO MEDIO')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 19.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PRAZO')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 24.566929130000000000
        Top = 510.236550000000000000
        Width = 1228.800000015228000000
        object Memo20: TfrxMemoView
          Left = 907.000000000000000000
          Top = 3.783464566929134000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCID">,rlbDetConRec)]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 1012.600000000000000000
          Top = 3.783464566929134000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."VENCER">,rlbDetConRec)]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 3.783464566929134000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxConRec
          DataSetName = 'frxConRec'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxConRec."TOTREC">,rlbDetConRec)]')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 24.566929130000000000
        Top = 706.772110000000000000
        Width = 1228.800000015228000000
        object rllTotMar: TfrxMemoView
          Left = 1012.600000000000000000
          Top = 3.783464570000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda((SUM(<frxMarPra."TOTCUS">,rlbDetMarPra)), (' +
              'SUM(<frxMarPra."TOTITE">,rlbDetMarPra))))]%')
          ParentFont = False
        end
        object rllTotPra: TfrxMemoView
          Left = 1118.200000000000000000
          Top = 3.783464566929134000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(SUM(<frxMarPra."TOTPRA">,rlbDetMarPra) = 0,0, (SUM(<frxMar' +
              'Pra."PARPRA">,rlbDetMarPra) / SUM(<frxMarPra."TOTPRA">,rlbDetMar' +
              'Pra))))]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Top = 619.842920000000000000
        Width = 1228.800000015228000000
        Condition = 'frxMarPra."CODREP"'
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 665.197280000000000000
        Width = 1228.800000015228000000
        object rllZebra2: TfrxMemoView
          Align = baClient
          Width = 1228.800000015228000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> MOD 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'NOMREP'
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxMarPra."NOMREP"]')
        end
        object Memo2: TfrxMemoView
          Left = 1118.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(SUM(<frxMarPra."TOTPRA">,rlbDetMarPra) = 0,0, (SUM(<frxMar' +
              'Pra."PARPRA">,rlbDetMarPra) / SUM(<frxMarPra."TOTPRA">,rlbDetMar' +
              'Pra))))]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 1012.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxMarPra
          DataSetName = 'frxMarPra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(fCalculaPrecoVenda((SUM(<frxMarPra."TOTCUS">,rlbDetMarPra)), (' +
              'SUM(<frxMarPra."TOTITE">,rlbDetMarPra))))]%')
          ParentFont = False
        end
      end
    end
  end
  object frxUserGen: TfrxUserDataSet
    UserName = 'frxUserGen'
    OnGetValue = frxUserGenGetValue
    Left = 200
    Top = 240
  end
end
