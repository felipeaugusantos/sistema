inherited frmBalancoEstoqueImportar: TfrmBalancoEstoqueImportar
  Left = 350
  Top = 161
  Width = 383
  Height = 437
  BorderStyle = bsDialog
  Caption = 'Balan'#231'o de Estoque - Importar Contagem Coletor'
  Position = poMainFormCenter
  PrintScale = poNone
  ExplicitWidth = 383
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 364
    Width = 377
    TabOrder = 2
    ExplicitTop = 364
    ExplicitWidth = 377
    DesignSize = (
      377
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 373
      TabOrder = 2
      ExplicitWidth = 373
    end
    inherited btnSair: TBitBtnLocked
      Left = 294
      ExplicitLeft = 294
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 97
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 392
    Width = 377
    TabOrder = 3
    ExplicitTop = 392
    ExplicitWidth = 377
    inherited pnlNomeForm: TPanel
      Left = 206
      ExplicitLeft = 206
    end
    inherited pnlInfo: TPanel
      Width = 206
      ExplicitWidth = 206
    end
  end
  object pnlSaldo: TPanel [2]
    Left = 0
    Top = 0
    Width = 377
    Height = 79
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 122
      Height = 14
      Caption = 'Arquivo para Importa'#231#227'o:'
    end
    object chkImpRel: TCheckBox
      Left = 8
      Top = 56
      Width = 193
      Height = 17
      Caption = 'Imprimir Relat'#243'rio de Confer'#234'ncia'
      TabOrder = 1
    end
    object flnArqTxt: TFilenameEditFocus
      Left = 8
      Top = 28
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000004020FF406040FF406040FF4060
            40FF004020FF0000000000000000000000000000000000000000806040FFC080
            60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
            80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
            FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
            60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
            FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
            60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
            FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
            60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
            60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
            80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
            A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
            FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
            80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
            80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
            80FFC0A080FF808060FF000000000000000000000000}
          Kind = bkGlyph
        end>
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      OnExit = flnArqTxtExit
      Width = 356
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 79
    Width = 377
    Height = 285
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object memArqTxt: TMemo
      Left = 1
      Top = 1
      Width = 375
      Height = 283
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Lines.Strings = (
        '')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = memArqTxtKeyPress
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 304
    Top = 16
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 8
    Top = 88
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 40
    Top = 88
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
    Left = 72
    Top = 88
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
    Left = 104
    Top = 88
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
    Top = 88
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
    Left = 168
    Top = 88
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
    Left = 200
    Top = 88
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
    Left = 264
    Top = 88
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
    Left = 296
    Top = 88
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39889.550702037040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 8
    Top = 120
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioDTAENV: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object frxRelatorioHORENV: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object frxRelatorioNOMDES: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIDAD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDCON'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDCON"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 119.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.BARRAS')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOCALIZACAO')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTAGEM')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUMERO DO LOTE')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE CONFERENCIA (CONTAGEM ESTOQUE)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 1257.600000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39889.553134039350000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 40
    Top = 120
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
    object qckPagina: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 177.637910000000000000
        Width = 1096.063700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo12: TfrxMemoView
          Left = 7.559060000000000000
          Width = 1078.073100000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object frxRelatorioDTAENV: TfrxMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Left = 334.488250000000000000
          Width = 307.048670000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          WordWrap = False
        end
        object frxRelatorioNOMDES: TfrxMemoView
          Left = 647.357390000000000000
          Width = 170.759060000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 76.800000000000000000
          Width = 123.363760000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 823.936920000000000000
          Width = 45.959060000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 875.716450000000000000
          Width = 109.379530000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 990.916450000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDCON"]')
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 204.094620000000000000
          Width = 123.363760000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMLOT"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.881880000000000000
        ParentFont = False
        Top = 136.063080000000000000
        Width = 1096.063700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 7.559060000000000000
          Width = 1077.166050000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo1: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
        end
        object Memo2: TfrxMemoView
          Left = 334.488250000000000000
          Top = 1.000000000000000000
          Width = 307.048670000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
        end
        object Memo3: TfrxMemoView
          Left = 647.357390000000000000
          Top = 1.000000000000000000
          Width = 170.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
        end
        object Memo5: TfrxMemoView
          Left = 76.800000000000000000
          Top = 1.000000000000000000
          Width = 123.363760000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.BARRAS')
        end
        object Memo7: TfrxMemoView
          Left = 823.936920000000000000
          Top = 1.000000000000000000
          Width = 45.959060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object Memo9: TfrxMemoView
          Left = 875.716450000000000000
          Top = 1.000000000000000000
          Width = 109.379530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOCALIZACAO')
        end
        object Memo11: TfrxMemoView
          Left = 990.916450000000000000
          Top = 1.000000000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTAGEM')
        end
        object Memo15: TfrxMemoView
          Left = 204.094620000000000000
          Top = 1.000000000000000000
          Width = 123.363760000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#218'MERO DO LOTE')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 56.661409999999990000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
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
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 908.900680000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 995.300680000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 889.700680000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE CONFERENCIA (CONTAGEM ESTOQUE)')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 257.008040000000000000
        Width = 1096.063700000000000000
        object Memo13: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 555.817440000000100000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 563.980890000000100000
          Top = 3.779530000000022000
          Width = 517.719790000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
    end
  end
end
