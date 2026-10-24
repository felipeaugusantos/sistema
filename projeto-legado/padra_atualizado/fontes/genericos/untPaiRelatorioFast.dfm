inherited frmPaiRelatorioFast: TfrmPaiRelatorioFast
  Top = 185
  Width = 516
  Caption = 'frmPaiRelatorioFast'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 508
    DesignSize = (
      508
      28)
    inherited btnSair: TBitBtn
      Left = 427
    end
    object btnImprimir: TBitBtn
      Left = 3
      Top = 3
      Width = 76
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Imprimir'
      TabOrder = 1
      OnClick = btnImprimirClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object btnConfigurar: TBitBtn
      Left = 80
      Top = 3
      Width = 76
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Configurar'
      TabOrder = 2
      OnClick = btnConfigurarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF108ABA1895C1066897FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF188CBA138FBD066A990982B213
        99CA1E9DC90B72A00A6D9A2B96BD2692BCFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF1D8FBA21A5D10999CE078ABC0EB7EB2FCBF61F90BB41B0D34CB4D4288E
        B6FF00FFFF00FFFF00FFFF00FF1073A01880AB35A1C96BD0EA37AFD423B8E60F
        CBFF23D0FF44C7ED5AB6D59CD8E677C0D80D72A1FF00FFFF00FFFF00FF45A7CB
        2F9CC539ACD77DE7FF74EAFF40DDFF15CFFF0DCCFF38D9FF5EE1FF63E5FF28BC
        E91C9DCE188EC0FF00FFFF00FF0878AF1190CB35B2E367D5F479EAFF56C6E141
        A5BD369EBA17B7E502C4FF01C1FE03C2FE03BAF205A0D8FF00FFFF00FF0D75A5
        1698D428A9E052CBF378B7C67F7E7E7F7E7E7F7E7E7F7E7E2DAACC00C5FF09C6
        FE0FC5FA0487BCFF00FFFF00FF0F79AA1598D51CA0DA40C1F07F7E7EE2DAD99E
        9F9F978B8BD8A4A17F7E7E3FD1F884EBFFA1EAFB2683ABFF00FFFF00FF0973A5
        0F86BF1597D32EB5EA7F7E7EE2D9D79D9E9E978B8BD1A1A07F7E7E62DCFA97E6
        F770BCD72F8FB4FF00FFFF00FFFF00FF056695108BC620AAE57F7E7EE2D9D79D
        9E9E978B8BD3A3A07F7E7E4AD8FC4DBBDE015E8EFF00FFFF00FFFF00FFFF00FF
        FF00FF086FA00576AC7F7E7EE6DDD99D9E9E978B8BD7A5A37F7E7E0F82B0117A
        A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7EDDDAD999
        9A9A968A8ACCA3A37F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7E9E9E9E898989817E7E9689897F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7ED8D7D7B6
        B7B78F8C8C9F8F8F7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7EDDDCDCE3E2E2AAAAAA8C87877F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7E7F
        7E7E7F7E7E7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  inherited pnlStatus: TPanel
    Width = 508
    inherited pnlNomeForm: TPanel
      Left = 337
    end
    inherited pnlInfo: TPanel
      Width = 337
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 508
    Height = 197
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object gpbDestino: TGroupBox
      Left = 7
      Top = 140
      Width = 138
      Height = 50
      Caption = 'Destino'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel1: TColorLabel
        Left = 28
        Top = 24
        Width = 101
        Height = 14
        Caption = '(V)'#237'deo (I)mpressora'
        CorDestaque = clRed
      end
      object edtDestino: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'V'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
        Alignment = taLeftJustify
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 8
  end
  object frxReport1: TfrxReport
    Version = '4.3.61'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.4831909259
    ReportOptions.LastChange = 39343.4831909259
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 8
    Top = 8
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    Left = 40
    Top = 8
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 72
    Top = 8
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
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
    Left = 104
    Top = 8
  end
  object frxExpHtml: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Left = 136
    Top = 8
  end
  object frxExpXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 168
    Top = 8
  end
  object frxExpRTF: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    Wysiwyg = True
    Creator = 'Citel Software'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 200
    Top = 8
  end
  object frxExpTXT: TfrxTXTExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    ScaleWidth = 1
    ScaleHeight = 1
    Borders = False
    Pseudogrpahic = False
    PageBreaks = True
    OEMCodepage = False
    EmptyLines = False
    LeadSpaces = False
    PrintAfter = False
    PrinterDialog = True
    UseSavedProps = True
    Left = 232
    Top = 8
  end
  object frxQrysAdo: TfrxADOComponents
    Left = 264
    Top = 8
  end
end
