object frmModuloRctAgro: TfrmModuloRctAgro
  Left = 0
  Top = 0
  ClientHeight = 111
  ClientWidth = 398
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
    BCDToCurrency = False
    Left = 24
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
    Left = 297
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
    Left = 216
    Top = 16
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
    Left = 361
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
    Left = 152
    Top = 16
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
    Left = 344
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
    Left = 88
    Top = 16
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40772.569103726860000000
    ReportOptions.LastChange = 40773.721788553240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 72
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
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
      Orientation = poLandscape
      PaperWidth = 297.179808071374000000
      PaperHeight = 211.401946802909400000
      PaperSize = 9
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1123.200000000000000000
        object rllComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#77'
        end
      end
      object rlbHeader: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 85.000000000000000000
        Width = 1123.200000000000000000
        object rllTitPor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'PORT.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTitulo01: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 51.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1123.200000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rlbCampo01: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbFooter: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 1123.200000000000000000
        object rlbSoma01: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 289.000000000000000000
        Width = 1123.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40772.569103726900000000
    ReportOptions.LastChange = 45898.479639386580000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxParametros."IMAGEM"> <> '#39#39') Then'
      '    imgLogo.LoadFromFile(<frxParametros."IMAGEM">);'
      'end;'
      ''
      'procedure rdbFonCliOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rdbFonCli.Text) <> '#39#39') Then'
      '    rdbFonCli.Text := fFormataFoneInterna(rdbFonCli.Text);  '
      'end;'
      ''
      'procedure mmoValorCPFCNPJOnAfterData(Sender: TfrxComponent);'
      'begin                 '
      '  If (Length(Trim(<frxRelatorio."MGR_CPFCLI">)) <= 11) Then'
      '  Begin                    '
      '    mmoCPFCNPJ.Text := '#39'CPF:'#39';    '
      
        '    mmoValorCPFCNPJ.Text := FormatMaskText('#39'999.999.999-99;0;_'#39',' +
        '<frxRelatorio."MGR_CPFCLI">);                         '
      '  End              '
      '  Else'
      '  Begin             '
      '    mmoCPFCNPJ.Text := '#39'CNPJ:'#39';'
      
        '    mmoValorCPFCNPJ.Text := FormatMaskText(<MaskCNPJ>,<frxRelato' +
        'rio."MGR_CPFCLI">);       '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnGetValue = frxReportJGetValue
    OnUserFunction = frxReportJUserFunction
    Left = 88
    Top = 72
    Datasets = <
      item
        DataSet = frxParametros
        DataSetName = 'frxParametros'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = 'MaskCNPJ'
        Value = ''
      end>
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
      OnBeforePrint = 'Page1OnBeforePrint'
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.370081180000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 79.370081180000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Left = 175.748031496063000000
          Top = 20.779530000000000000
          Width = 566.929133858268000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
          VAlign = vaCenter
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 175.748031496063000000
          Top = 3.381879999999999000
          Width = 566.929133858268000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEITA AGRON'#212'MICA AGROT'#211'XICOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 175.748031496063000000
          Top = 37.795300000000000000
          Width = 566.929133858268000000
          Height = 11.338582680000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[END001]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 175.748031500000000000
          Top = 49.133889999999990000
          Width = 566.929133860000000000
          Height = 11.338582680000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[END002]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 175.748031500000000000
          Top = 60.472480000000000000
          Width = 566.929133860000000000
          Height = 7.559052680000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[END003]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Left = 175.748031496063000000
          Top = 68.031540000000010000
          Width = 566.929133858268000000
          Height = 7.559052680000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[END004]')
          ParentFont = False
          VAlign = vaCenter
        end
        object imgLogo: TfrxPictureView
          Left = 3.779530000000000000
          Top = 3.779530000000001000
          Width = 166.299320000000000000
          Height = 71.811070000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object rlbHeader: TfrxHeader
        FillType = ftBrush
        Height = 37.795273150000000000
        Top = 158.740260000000000000
        Width = 755.906000000000000000
        object Memo3: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 37.795273150000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
        end
        object rllTitPor: TfrxMemoView
          Left = 11.338582680000000000
          Top = 0.755905509999990900
          Width = 177.637795280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECEITA SEQUENCIAL NRO.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitulo01: TfrxMemoView
          Left = 219.480356460000000000
          Top = 0.755905509999990900
          Width = 122.834621260000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA FISCAL NRO.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitulo02: TfrxMemoView
          Left = 400.629921259843000000
          Top = 0.755905509999990900
          Width = 171.968503937008000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VINCULADA A ART NRO.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTitulo03: TfrxMemoView
          Left = 634.960629921260000000
          Top = 0.755905509999990900
          Width = 103.936988350000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'NRO. RECEITA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Top = 13.118120000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 204.094620000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 359.055350000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 612.283860000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo1: TfrxMemoView
          Left = 11.338582680000000000
          Top = 18.874025510000000000
          Width = 177.637795280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NUMREC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbCampo01: TfrxMemoView
          Left = 219.480356460000000000
          Top = 18.874025510000000000
          Width = 122.834621260000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NOTFIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbCampo02: TfrxMemoView
          Left = 400.629921260000000000
          Top = 18.874025510000000000
          Width = 171.968503940000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."MGR_ARTIGO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rlbCampo03: TfrxMemoView
          Left = 634.960629920000000000
          Top = 18.874025510000000000
          Width = 103.936988350000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NROREC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 907.086614170000000000
        Top = 219.212740000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo39: TfrxMemoView
          Top = 757.590590240000000000
          Width = 755.906000000000000000
          Height = 114.141732280000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 21.019540000000000000
          Top = 836.039580000000100000
          Width = 136.440940000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Width = 755.906000000000000000
          Height = 53.669291340000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 7.559060000000000000
          Top = 4.559059999999988000
          Width = 96.000000000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOME DO USU'#193'RIO:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 7.559060000000000000
          Top = 21.677179999999990000
          Width = 60.472440940000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERE'#199'O:')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoCPFCNPJ: TfrxMemoView
          Left = 439.683603080000000000
          Top = 4.669291340000001000
          Width = 31.041724510000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 613.329885380000000000
          Top = 4.559059999999988000
          Width = 33.749159900000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FONE:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 105.165430000000000000
          Top = 2.779529999999994000
          Width = 324.167242200000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NOMCLI"]-[frxRelatorio."MGR_CODCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 67.149660000000000000
          Top = 19.677179999999990000
          Width = 351.689884910000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_ENDCLI"], [frxRelatorio."MGR_BAICLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object mmoValorCPFCNPJ: TfrxMemoView
          Left = 470.725442310000000000
          Top = 2.779527560000000000
          Width = 140.278606820000000000
          Height = 15.118110240000000000
          OnAfterData = 'mmoValorCPFCNPJOnAfterData'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CPFCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbFonCli: TfrxMemoView
          Left = 647.811023620000000000
          Top = 2.779529999999994000
          Width = 98.645669290000000000
          Height = 15.118110240000000000
          OnAfterData = 'rdbFonCliOnAfterData'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_TELCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line5: TfrxLineView
          Top = 87.685046689999970000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Top = 121.700794720000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Top = 189.724438740000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Top = 223.748060790000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Top = 305.881928819999900000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line10: TfrxLineView
          Top = 339.897676850000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Left = 2.779530000000000000
          Top = 54.692949999999990000
          Width = 71.810955280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CULTURA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 249.448818900000000000
          Top = 54.692949999999990000
          Width = 102.047195280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DIAGN'#211'STICO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 27.692950000000000000
          Top = 70.031540000000010000
          Width = 207.874015750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CULTUR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 264.566929130000000000
          Top = 70.031540000000010000
          Width = 483.779527560000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_DIAGNO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 2.779530000000000000
          Top = 89.283471889999990000
          Width = 185.196855280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOME COMERCIAL DO PRODUTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 249.448980000000000000
          Top = 89.283471889999990000
          Width = 185.196855280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'GRUPO QU'#205'MICO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 2.645669290000000000
          Top = 123.299241890000000000
          Width = 79.370015280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLASSE. TOXIC.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 98.267780000000000000
          Top = 123.212605750000000000
          Width = 71.810955280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #193'REA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 2.645669290000000000
          Top = 156.755934800000000000
          Width = 147.401555280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PER'#205'ODO DE CAR'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 382.953000000000000000
          Top = 156.755934800000000000
          Width = 185.196855280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MANEJO INTEGRADO DE PRAGAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 2.645669290000000000
          Top = 190.480344250000000000
          Width = 170.078735280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOSAGEM DE APLICA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 249.448818900000000000
          Top = 190.480344250000000000
          Width = 132.283435280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'INTERVALO DE APLICA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 488.260050000000000000
          Top = 190.480344250000000000
          Width = 98.267665280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONCENTRA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 224.496114250000000000
          Width = 120.944845280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORMULA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 249.448818900000000000
          Top = 224.496114250000000000
          Width = 98.267665280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL A ADQUIRIR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 488.314960630000000000
          Top = 224.496114250000000000
          Width = 90.708605280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NRO. APLICA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 2.645669290000000000
          Top = 307.275629610000100000
          Width = 253.228395280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MODALIDADE DE APLICA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 3.779527560000000000
          Top = 258.094620000000000000
          Width = 264.566985280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #201'POCA DE APLICA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 383.645669290000000000
          Top = 307.291377640000000000
          Width = 253.228395280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'INFORMA'#199#213'ES ADICIONAIS SE PRECISAR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 341.787440629999900000
          Width = 313.700875280000000000
          Height = 45.354352680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PRECAU'#199#213'ES DE USO: VIDE ABAIXO'
            'PRIMEIROS SOCORROS NO CASO DE ACIDENTE: VIDE ABAIXO'
            'INFORMA'#199#213'ES SOBRE ANT'#205'DOTO E TRATAMENTO: A CRIT'#201'RIO DO M'#201'DICO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 321.378170000000000000
          Top = 341.787440629999900000
          Width = 430.866305280000000000
          Height = 45.354352680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'ADVERT'#202'NCIAS RELACIONADAS A PROTE'#199#195'O DO MEIO AMBIENTE: VIDE ABAI' +
              'XO (ITEM 5)'
            
              'INSTRU'#199#213'ES SOBRE DISPOSI'#199#195'O FINAL DE SOBRAS E EMBALAGENS: CONSUL' +
              'TE O '#211'RG'#195'O FISCALIZADOR'
            'EQUIPAMENTO DE PROTE'#199#195'O INDIVIDUAL: VIDE ABAIXO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 764.771692600000000000
          Width = 120.944845280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOME / RESPONS'#193'VEL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 779.716760000000000000
          Width = 120.944845280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERE'#199'O:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Top = 794.834880000000100000
          Width = 120.944845280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#218'MERO DO CREA:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 532.913730000000000000
          Top = 762.598640000000100000
          Width = 37.795185280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 128.504020000000000000
          Top = 762.598640000000100000
          Width = 396.850535280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NOMRES"]-[frxRelatorio."MGR_CODRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 128.504020000000000000
          Top = 777.716760000000000000
          Width = 396.850535280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_ENDRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 128.504020000000000000
          Top = 792.834880000000100000
          Width = 166.299205280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NUMCRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 574.488560000000000000
          Top = 762.598640000000100000
          Width = 173.858265280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'999.999.999-99;0;_'#39',<frxRelatorio."MGR_CPFRES">' +
              ')]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 18.897650000000000000
          Top = 850.850650000000100000
          Width = 139.842495280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 272.126160000000000000
          Top = 848.850650000000100000
          Width = 200.314975280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'ASSINATURA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 514.016080000000000000
          Top = 848.850650000000100000
          Width = 200.314975280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'ASSINATURA DO USU'#193'RIO OU RESPONS'#193'VEL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 27.692950000000000000
          Top = 103.937015200000000000
          Width = 207.874035280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NOMCOM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 27.692950000000000000
          Top = 171.850422990000000000
          Width = 343.937115280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_PERCAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Left = 27.692950000000000000
          Top = 206.574832440000000000
          Width = 207.874015750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_DOSAPL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 27.692950000000000000
          Top = 322.771692600000000000
          Width = 343.937115280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_MODAPL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 408.692950000000000000
          Top = 322.889802829999900000
          Width = 340.157585280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_INFADD"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line11: TfrxLineView
          Left = 241.889763780000000000
          Top = 53.669298659999980000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 241.889920000000000000
          Top = 87.685046689999970000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 86.929190000000000000
          Top = 121.700816690000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line15: TfrxLineView
          Left = 377.952755910000000000
          Top = 155.377982050000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 241.889763780000000000
          Top = 189.732312760000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 483.779527560000000000
          Top = 189.732312760000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 241.889763780000000000
          Top = 223.748082760000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 483.779527560000000000
          Top = 223.748082760000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 377.952755910000000000
          Top = 305.866180790000000000
          Height = 34.015748030000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo56: TfrxMemoView
          Left = 264.567100000000000000
          Top = 103.937015200000000000
          Width = 483.779725280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_GRUQUI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 6.047244090000000000
          Top = 137.952785200000000000
          Width = 71.810955280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CLATOX"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 109.606370000000000000
          Top = 137.952763230000000000
          Width = 638.740455280000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_AREREC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 400.629921260000000000
          Top = 171.850422990000000000
          Width = 347.716532990000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_MANPRA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 264.566929130000000000
          Top = 206.574832440000000000
          Width = 211.653545750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_INTAPL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 510.236220470000000000
          Top = 206.574832440000000000
          Width = 238.110255750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CONCEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Left = 27.590551180000000000
          Top = 240.590602440000000000
          Width = 207.874015750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_FORMUL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 264.566929130000000000
          Top = 240.590602440000000000
          Width = 211.653545750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_TOTADQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 510.236220470000000000
          Top = 240.590602440000000000
          Width = 238.110255750000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NUMAPL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 27.590551180000000000
          Top = 273.543336380000000000
          Width = 721.890005430000000000
          Height = 30.236220470000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_EPOAPL"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 17.236240000000000000
          Top = 400.834684720000000000
          Width = 480.000073230000000000
          Height = 343.937222680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            'INFORMA'#199#213'ES ADICIONAIS'
            ''
            
              '01- LEIA E SIGA ATENTAMENTE AS INSTRU'#199#213'ES DOS R'#211'TULOS, BULAS E F' +
              'OLHETOS EXPLICATIVOS, ANTES DE ABRIR A EMBALAGEM. ATEN'#199#195'O PARA A' +
              ' TR'#205'PLICE LAVAGEM DAS EMBALAGENS. CONSULTE UM ENGENHEIRO AGR'#212'NOM' +
              'O.'
            ''
            
              '02- USE OS EQUIPAMENTOS DE PROTE'#199#195'O RECOMENDADOS: MASCARAS PROTE' +
              'TORAS, '#211'CULOS DE SEGURAN'#199'A COM PROTE'#199#195'O LATERAL, LUVAS NITRILICA' +
              'S IMPERME'#193'VEIS, TOUCA '#193'RABE, BOTAS IMPERME'#193'VEIS, MACAC'#195'O HIDRORR' +
              'EPELENTE COMPLETO COM MANGAS COMPRIDAS E AVENTAL IMPERME'#193'VEL.'
            ''
            
              '03- N'#195'O FUME, N'#195'O BEBA E NEM SE ALIMENTE DURANTE A APLICA'#199#195'O DE ' +
              'QUALQUER AGROT'#211'XICO. SE HOUVER CONTATO ACIDENTAL, LAVE MUITO BEM' +
              ' AS PARTES AFETADAS COM BASTANTE '#193'GUA FRIA E SAB'#195'O. EVITE CONTAT' +
              'O COM OS OLHOS E CASO ISSO OCORRA, LAVE-OS IMEDIATAMENTE COM BAS' +
              'TANTE '#193'GUA LIMPA.'
            ''
            
              '04- N'#195'O PERMITA QUE ANIMAIS, CRIAN'#199'AS E PESSOAS ESTRANHAS AO TRA' +
              'BALHO PERMANE'#199'AM NOS LOCAIS DE PREPARO E APLICA'#199#195'O DOS AGROT'#211'XIC' +
              'OS.'
            ''
            
              '05- N'#195'O CONTAMINE RIOS, LAGOS, NASCENTES, C'#211'RREGOS, V'#193'RZEAS, PO'#199 +
              'OS, REPRESAS E OUTROS MANANCIAIS DE '#193'GUA DURANTE O PREPARO, APLI' +
              'CA'#199#195'O E LIMPEZA DO EQUIPAMENTO DE APLICA'#199#195'O. '#193'GUA CONTAMINADA MA' +
              'TA OS PEIXES, CRIAN'#199'AS E HOMENS.'
            ''
            
              '06- VERIFIQUE SE OS EQUIPAMENTOS DE PROTE'#199#195'O EST'#195'O EM BOAS CONDI' +
              #199#213'ES DE USO, SEM VAZAMENTOS E BEM CALIBRADOS. NUNCA USE A BOCA P' +
              'ARA DESENTUPIR BICOS OU MANGUEIRAS DOS PULVERIZADORES.'
            ''
            
              '07- N'#195'O GUARDE OU TRANSPORTE OS AGROT'#211'XICOS JUNTAMENTE COM ALIME' +
              'NTOS, RA'#199#213'ES, BEBIDAS E MEDICAMENTOS. GUARDE-OS SEMPRE EM DEP'#211'SI' +
              'TO FECHADO E QUE N'#195'O D'#202' ACESSO A CRIAN'#199'AS, PESSOAS DESAVISADAS O' +
              'U ANIMAIS DOM'#201'STICOS, PERMANECENDO AS EMBALAGENS BEM FECHADAS CO' +
              'M SEUS R'#211'TULOS ORIGINAIS.'
            ''
            
              '08- N'#195'O REUTILIZE AS EMBALAGENS VAZIAS, AS MESMAS DEVEM SER LAVA' +
              'DAS 3 VEZES E DESCARTADAS ADEQUADAMENTE, CONFORME LOCAL INDICADO' +
              ' NA NOTA FISCAL.'
            ''
            '09- RESPEITE O INTERVALO DE SEGURAN'#199'A.'
            ''
            '10- EVITE APLICAR OS PRODUTOS NAS HORAS MAIS QUENTES DO DIA.')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 532.913730000000000000
          Top = 400.834684720000000000
          Width = 200.314853230000000000
          Height = 343.937222680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            'PRIMEIROS SOCORROS'
            ''
            
              '01- PROCURE ASSIST'#202'NCIA M'#201'DICA EM QUALQUER CASO DE SUSPEITA DE I' +
              'NTOXICA'#199#195'O LEVANDO A EMBALAGEM OU R'#211'TULO DO PRODUTO.'
            ''
            '02- N'#195'O DE NADA POR VIA ORAL A UMA PESSOA INCONSCIENTE.'
            ''
            
              '03- EM CASO DE INALA'#199#195'O OU ASPIRA'#199#195'O DO PRODUTO PROCURE LOCAL AR' +
              'EJADO E SE MOSTRAR SINTOMAS DE INTOXICA'#199#195'O PROCURE UM M'#201'DICO.'
            ''
            
              '04- EM CASO DE CONTATO COM A PELE LAVE COM '#193'GUA CORRENTE E SAB'#195'O' +
              ' EM ABUND'#194'NCIA E SE PERSISTIR A IRRITA'#199#195'O PROCURE UM M'#201'DICO.'
            ''
            
              '05- EM CASO DE CONTATO COM OS OLHOS LAVE IMEDIATAMENTE COM '#193'GUA ' +
              'CORRENTE.'
            ''
            ''
            ''
            ''
            ''
            
              'ATEN'#199#195'O: N'#195'O NOS RESPONSABILIZAMOS PELO MAU USO DO PRODUTO INDIC' +
              'ADO E PELA N'#195'O OBEDI'#202'NCIA '#192'S SUAS ESPECIFICA'#199#213'ES.'
            ''
            'ESTOU CIENTE DAS INFORMA'#199#213'ES T'#201'CNICAS CONTIDAS NESTA RECEITA.')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Top = 390.165393390000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line23: TfrxLineView
          Left = 516.016080000000000000
          Top = 400.834684720000000000
          Height = 343.937230000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 532.913730000000000000
          Top = 648.063390000000000000
          Width = 204.094620000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line18: TfrxLineView
          Top = 257.228510000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line25: TfrxLineView
          Top = 155.181200000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 421.605085380000000000
          Top = 19.677165350000000000
          Width = 188.976377950000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CIDCLI"] - [frxRelatorio."MGR_ESTCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 616.923076920000000000
          Top = 21.523177629999990000
          Width = 31.041724510000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'IE:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 647.964916150000000000
          Top = 19.633413850000010000
          Width = 98.703776820000000000
          Height = 15.118110240000000000
          OnAfterData = 'mmoValorCPFCNPJOnAfterData'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_IESCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 8.166666670000000000
          Top = 35.787260000000000000
          Width = 741.000575530000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CORGEO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbFooter: TfrxFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 1148.977120000000000000
        Width = 755.906000000000000000
        object Memo7: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.881880000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 9.448818900000000000
          Top = 2.755905510000048000
          Width = 438.425392130000000000
          Height = 9.440940000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              '1'#170' VIA - EMPRESA                                     2'#170' VIA - US' +
              'U'#193'RIO                                     3'#170' VIA - PROFISSIONAL')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxParametros: TfrxUserDataSet
    UserName = 'frxParametros'
    Fields.Strings = (
      'IMAGEM'
      'DOCUMENTO'
      'PRECO'
      'STATUS'
      'MODELO')
    OnGetValue = frxParametrosGetValue
    Left = 233
    Top = 72
  end
  object frxServAgro: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40772.569103726900000000
    ReportOptions.LastChange = 42188.670133877300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 160
    Top = 72
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
      Orientation = poLandscape
      PaperWidth = 253.999835958439300000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 960.000000000000000000
        object rllComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#51#27#48'
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 850.000000000000000000
        Top = 221.000000000000000000
        Width = 960.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo25: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_ARTIGO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NUMREC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CLINOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_ENDCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 68.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CLICID"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CULTUR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 102.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_DIAGNO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NOMCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 187.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_GRUQUI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 187.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CLATOX"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 238.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_CONCEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 238.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_PRIATI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 238.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_FORMUL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 238.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_PERCAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 289.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_DOSAPL"] P/ [frxRelatorio."MGR_DOSESP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 289.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_AREREC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 289.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NUMAPL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 289.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."MGR_TOTADQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 340.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[Copy(<frxRelatorio."MGR_MODAPL">, 1, 33)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 340.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_EPOAPL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 391.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[Copy(<frxRelatorio."MGR_MANPRA">, 1, 33)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 391.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 459.000000000000000000
          Width = 700.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[Copy(<frxRelatorio."MGR_ALARME">, 1, 180)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 799.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CLIRES"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 816.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_ENDRES"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 833.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[FormatDateTime('#39'dd/mm/yyyy'#39', <frxRelatorio."MGR_DTAEMI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 799.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'999.999.999-99;0;_'#39',<frxRelatorio."MGR_CPFRES">' +
              ')]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 816.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MGR_NUMCRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 544.000000000000000000
          Width = 700.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[Copy(<frxRelatorio."MGR_ANTIDO">, 1, 180)]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 629.000000000000000000
          Width = 700.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[Copy(<frxRelatorio."MGR_OBSERV">, 1, 180)]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 442.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '<< ALARMES E SINTOMAS >>')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 527.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '<< ANTIDOTO E TRATAMENTO >>')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 612.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '<< OBSERVACOES >>')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 731.000000000000000000
          Width = 144.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[Copy(<frxRelatorio."MGR_INFADD">, 1, 30)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
end
