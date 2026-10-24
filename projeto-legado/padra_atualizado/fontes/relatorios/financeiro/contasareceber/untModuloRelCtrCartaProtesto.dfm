object frmModuloRelCtrCartaProtesto: TfrmModuloRelCtrCartaProtesto
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 279
  Width = 337
  object rldFiltro: TRLDraftFilter
    DisplayName = 'Impressora Matricial'
    Left = 32
    Top = 16
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 144
    Top = 16
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 256
    Top = 16
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
    Left = 256
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
    Left = 144
    Top = 80
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
    Top = 80
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
    Left = 256
    Top = 80
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
    Left = 144
    Top = 144
  end
  object frxCarta_J: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39576.553488044000000000
    ReportOptions.LastChange = 39594.756008449100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxCarta_MUserFunction
    Left = 144
    Top = 208
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      OnBeforePrint = 'Page1OnBeforePrint'
      object PHTitulo: TfrxPageHeader
        FillType = ftBrush
        Height = 177.559060000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object Memo2: TfrxMemoView
          Left = 260.740260000000000000
          Top = 36.000000000000000000
          Width = 525.883240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."ENDERECO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 298.315090000000000000
          Top = 88.031540000000000000
          Width = 83.678230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxEmpresa."TELEFONE">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 260.740260000000000000
          Top = 52.881880000000000000
          Width = 525.883240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 294.756030000000000000
          Top = 71.000000000000000000
          Width = 491.867470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."CEP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 294.535560000000000000
          Top = 104.677180000000000000
          Width = 491.867470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxEmpresa."EMP_F_A_X_">)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 261.392270000000000000
          Top = 71.000000000000000000
          Width = 33.788930000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP : ')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 261.392270000000000000
          Top = 104.677180000000000000
          Width = 33.788930000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FAX : ')
          ParentFont = False
        end
        object Imagem: TfrxPictureView
          Left = 17.007885000000000000
          Top = 18.897650000000000000
          Width = 238.110390000000000000
          Height = 120.944960000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo43: TfrxMemoView
          Left = 262.141930000000000000
          Top = 19.118120000000000000
          Width = 525.883240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMPRESA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 260.787570000000000000
          Top = 87.944960000000000000
          Width = 37.568460000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone : ')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 260.787570000000000000
          Top = 122.063080000000000000
          Width = 67.804700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em : ')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 328.819110000000000000
          Top = 122.063080000000000000
          Width = 457.851700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."DATA"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 381.732530000000000000
          Top = 87.929190000000000000
          Width = 8.087630000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 389.291590000000000000
          Top = 87.929190000000000000
          Width = 83.678230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxEmpresa."TELEFONE">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GHCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 309.763760000000000000
        Top = 257.008040000000000000
        Width = 793.701300000000000000
        Child = frxCarta_J.CCabecalho
        Condition = 'frxRelatorio."CTR_CODCLI"'
        StartNewPage = True
        object Memo20: TfrxMemoView
          Left = 292.176190000000000000
          Top = 26.000000000000000000
          Width = 102.349660000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '3'#186' AVISO: ')
        end
        object Date: TfrxMemoView
          Left = 394.864440000000000000
          Top = 26.000000000000000000
          Width = 102.349660000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo24: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 157.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Lembrando que j'#225' foram feitas v'#225'rias cobran'#231'as, inclusive SPC (S' +
              'ervi'#231'o de Prote'#231#227'o ao Cr'#233'dito),')
        end
        object Memo25: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 174.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'o(s) seu(s) d'#233'bito(s) ainda se encontra(m) em aberto em nosso De' +
              'partamento de Cobran'#231'a.')
        end
        object Memo26: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 191.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
        end
        object Memo27: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 208.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Apesar de todo nosso esfor'#231'o para que vossa pessoa quitasse o(s)' +
              ' seu(s) d'#233'bito(s), n'#227'o nos foi dado')
        end
        object Memo28: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 225.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'uma resposta precisa, e por este motivo estamos comunicando que ' +
              'dentro de 48 horas o(s) seu(s)')
        end
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 243.212740000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'd'#233'bito(s) se encontrar'#225'('#227'o) em poder do Cart'#243'rio de Registro de ' +
              'Protestos.')
        end
        object Memo22: TfrxMemoView
          Left = 259.992270000000000000
          Top = 102.047310000000000000
          Width = 157.984230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PREZADO SENHOR (a) :  ')
        end
        object Memo23: TfrxMemoView
          Left = 417.976500000000000000
          Top = 102.047310000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
        end
      end
      object CCabecalho: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 589.606680000000000000
        Width = 793.701300000000000000
        object Memo29: TfrxMemoView
          Left = 117.875510000000000000
          Top = 34.000000000000000000
          Width = 183.307086610000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'T'#205'TULO')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 581.491280000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 432.658070000000000000
          Top = 34.000000000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO T'#205'TULO')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 319.667470000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O')
          ParentFont = False
        end
      end
      object MDContasReceber: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 665.197280000000000000
        Width = 793.701300000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo34: TfrxMemoView
          Left = 117.875510000000000000
          Width = 183.307086610000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
        end
        object Memo35: TfrxMemoView
          Left = 581.491280000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
        end
        object Memo37: TfrxMemoView
          Left = 432.658070000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
        end
        object Memo38: TfrxMemoView
          Left = 319.667470000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
        end
      end
      object GFCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 309.811070000000000000
        Top = 706.772110000000000000
        Width = 793.701300000000000000
        object Memo39: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 119.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Certos de podermos contar com sua aten'#231#227'o, colocamo-nos a dispos' +
              'i'#231#227'o para quaisquer')
        end
        object Memo40: TfrxMemoView
          Align = baCenter
          Left = 72.718430000000000000
          Top = 136.000000000000000000
          Width = 648.264440000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'esclarecimentos. Caso j'#225' tenha efetuado o pagamento, queira desc' +
              'onsiderar este aviso.')
        end
        object Memo42: TfrxMemoView
          Left = 239.394433330000000000
          Top = 4.779530000000000000
          Width = 109.984230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOTAL : ')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 379.744650000000000000
          Top = 4.324983330000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDUP">,MDContasReceber,0)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baCenter
          Left = 237.127985000000000000
          Top = 265.874150000000000000
          Width = 319.445330000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Departamento Financeiro')
        end
      end
    end
  end
  object frxCarta_M: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39576.553488044000000000
    ReportOptions.LastChange = 40498.679701423600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxCarta_MUserFunction
    Left = 32
    Top = 208
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
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
      PaperWidth = 330.199786745971100000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      FontStyle = []
      object PHTitulo: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo3: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxEmpresa."TELEFONE">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 68.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxEmpresa."CEP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 102.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxEmpresa."EMP_F_A_X_">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 38.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP : ')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Fone : ')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 102.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FAX : ')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Emitido em : ')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 119.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxEmpresa."DATA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[(fRemoveAcentoEspecificos(<frxEmpresa."EMPRESA">))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[(fRemoveAcentoEspecificos(<frxEmpresa."ENDERECO">))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[(fRemoveAcentoEspecificos(<frxEmpresa."BAIRRO">))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fFormataFonePaisInterna(<frxEmpresa."TELEFONE2">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GHCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 238.000000000000000000
        Width = 1248.000000000000000000
        Child = frxCarta_M.CCabecalho
        Condition = 'frxRelatorio."CTR_CODCLI"'
        StartNewPage = True
        object Date: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 153.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PREZADO SENHOR(a) :  ')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 153.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 238.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Lembrando que ja foram feitas varias cobrancas, inclusive SPC (S' +
              'ervico de Protecao ao Credito),')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 272.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'o(s) seu(s) debito(s) ainda se encontra(m) em aberto em nosso De' +
              'partamento de Cobranca.')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 289.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 289.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Apesar de todo nosso esforco para que vossa pessoa quitasse o(s)' +
              ' seu(s) debito(s), nao nos foi dado')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 306.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'uma resposta precisa, e por este motivo estamos comunicando que ' +
              'dentro de 48 horas o(s) seu(s)')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '3'#186' AVISO: ')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 323.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'debito(s) se encontrara(ao) em poder do Cartorio de Registro de ' +
              'Protestos.')
          TruncOutboundText = False
        end
      end
      object CCabecalho: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 595.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo33: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMISSAO')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TITULO')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR DUPLICATA')
          TruncOutboundText = False
        end
      end
      object MDContasReceber: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo38: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          TruncOutboundText = False
        end
      end
      object GFCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 697.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo39: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 119.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Certos de podermos contar com sua atencao, colocamo-nos a dispos' +
              'icao para quaisquer')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 136.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'esclarecimentos. Caso ja tenha efetuado o pagamento, queira desc' +
              'onsiderar este aviso.')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR TOTAL : ')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDUP">,MDContasReceber,0)]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 272.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Departatamento Financeiro')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxEmpresa: TfrxDBDataset
    UserName = 'frxEmpresa'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 256
    Top = 208
  end
end
