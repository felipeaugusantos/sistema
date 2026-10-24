object frmModuloBaixaChequesTelecheque: TfrmModuloBaixaChequesTelecheque
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 270
  Width = 304
  object frxBordero: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40462.499328703700000000
    ReportOptions.LastChange = 40462.639544803200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  {CARREGO A IMAGEM}             '
      '  If (<frxGen."IMAGEM"> <> '#39#39') Then'
      '    Picture1.LoadFromFile(<frxGen."IMAGEM">);  '
      'end;'
      ''
      'begin'
      '  '
      'end.          ')
    Left = 56
    Top = 24
    Datasets = <
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'Page1OnBeforePrint'
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 113.385826770000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Picture1: TfrxPictureView
          Left = 11.338590000000000000
          Top = 9.338590000000000000
          Width = 113.385826770000000000
          Height = 94.488188980000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 139.842519690000000000
          Top = 48.192913390000000000
          Width = 850.393630000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SOLICITA'#199#195'O PARA RESSARCIMENTO DE CHEQUES')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 139.842920000000000000
          Top = 86.929190000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object rlbEmpresa: TfrxMemoView
          Left = 205.740570000000000000
          Top = 86.929190000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 737.008350000000000000
          Top = 86.929190000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'C'#211'DIGO:')
          ParentFont = False
        end
        object rlbCodigo: TfrxMemoView
          Left = 815.378480000000000000
          Top = 86.929190000000000000
          Width = 173.858331180000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_DOCUME"]')
          ParentFont = False
        end
        object rlbBordero: TfrxMemoView
          Left = 948.662030000000000000
          Top = 7.559060000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          DataField = 'CHQ_SEQTEL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_SEQTEL"]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 24.543290000000000000
        Top = 215.433210000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = -0.109848110000000000
          Top = 2.822820000000000000
          Width = 1046.929036220000000000
          Height = 18.897650000000000000
        end
        object Memo8: TfrxMemoView
          Left = 3.779527560000000000
          Top = 3.000000000000000000
          Width = 49.889758900000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 63.020470000000000000
          Top = 3.000000000000000000
          Width = 208.629870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CPF / CNPJ')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 495.497650000000000000
          Top = 3.000000000000000000
          Width = 54.273840000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'AG.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 559.584230000000000000
          Top = 3.000000000000000000
          Width = 82.620470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#186' CHEQUE')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 398.297650000000000000
          Top = 3.000000000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'BANCO')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 282.346630000000000000
          Top = 3.023622050000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'AUTORIZA'#199#195'O')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 650.504330000000000000
          Top = 3.000000000000000000
          Width = 298.053680000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MOTIVO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 957.102970000000000000
          Top = 3.000000000000000000
          Width = 82.620470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ VALOR')
          ParentFont = False
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 264.567100000000000000
        Width = 1046.929810000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo35: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.948818897637795300
          Width = 49.889758900000000000
          Height = 17.000000000000000000
          DataField = 'CONTADOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CONTADOR"]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 63.020472440000000000
          Top = 0.948818897637795300
          Width = 208.629870000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_C_G_C_'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_C_G_C_"]')
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 650.504332440000000000
          Top = 0.948818897637795300
          Width = 298.053680000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_MOTDEV'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_MOTDEV"]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 495.497652440000000000
          Top = 0.948818897637795300
          Width = 54.273840000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMAGE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_NUMAGE"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 559.584232440000000000
          Top = 0.948818900000000000
          Width = 82.620470000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_NUMCHQ"]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 957.102972440000000000
          Top = 0.948818897637795300
          Width = 82.620470000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_VALCHQ'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_VALCHQ"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 282.346632440000000000
          Top = 0.948818897637795300
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_TELNUM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_TELNUM"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 398.297652440000000000
          Top = 0.948818897637795300
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_CODBCO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CHQ_CODBCO"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 151.181102360000000000
        Top = 343.937230000000000000
        Width = 1046.929810000000000000
        object Memo3: TfrxMemoView
          Left = 22.677180000000000000
          Top = 34.015770000000000000
          Width = 1005.354980000000000000
          Height = 34.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Anexamos '#224' presente o(s) cheques(s) relacionado(s) acima indevid' +
              'amente endossado(s).'
            
              'Concordamos com o ressarcimento do(s) cheque(s) acima relacionad' +
              'o(s) nas condi'#231#245'es do Contrato de Servi'#231'os assinado com a Telech' +
              'eque.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 721.890230000000000000
          Top = 129.724490000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Carimbo e Assinatura')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 79.370130000000000000
          Top = 129.724490000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 166.261565000000000000
          Top = 109.606370000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 957.102970000000000000
          Top = 1.000000000000000000
          Width = 82.620470000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
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
            '[SUM(<frxRelatorio."CHQ_VALCHQ">,rlbDetalhe)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 827.717070000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 0.220470000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 192.756030000000000000
        Width = 1046.929810000000000000
        Condition = 'frxRelatorio."CHQ_SEQTEL"'
        StartNewPage = True
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 128
    Top = 24
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL'
      'IMAGEM')
    OnGetValue = frxGenGetValue
    Left = 200
    Top = 24
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
    Left = 56
    Top = 72
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
    Left = 128
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
    Left = 56
    Top = 120
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
    Top = 120
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
    Left = 56
    Top = 168
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
    Top = 168
  end
end
