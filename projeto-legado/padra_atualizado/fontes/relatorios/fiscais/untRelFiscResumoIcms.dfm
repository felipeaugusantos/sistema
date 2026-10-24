inherited frmRelFiscResumoIcms: TfrmRelFiscResumoIcms
  Left = 147
  Top = 98
  Width = 1132
  Height = 700
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio do Resumo de Impostos'
  Position = poScreenCenter
  ExplicitWidth = 1132
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 627
    Width = 1126
    TabOrder = 1
    ExplicitTop = 627
    ExplicitWidth = 1126
    DesignSize = (
      1126
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1122
      TabOrder = 4
      ExplicitWidth = 1122
    end
    inherited btnSair: TBitBtnLocked
      Left = 1044
      TabOrder = 3
      ExplicitLeft = 1044
    end
    object btnCalcular: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 155
      Height = 22
      Caption = '&Calcular'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnCalcularClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 318
      Top = 3
      Width = 155
      Height = 22
      Caption = '&Imprimir'
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
      TabOrder = 2
      OnClick = btnImprimirClick
    end
    object btnGravaSaldo: TBitBtnLocked
      Left = 161
      Top = 3
      Width = 155
      Height = 22
      Caption = 'Gravar Saldo M'#234's Anterior'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnGravaSaldoClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 1126
    TabOrder = 2
    ExplicitTop = 655
    ExplicitWidth = 1126
    inherited pnlNomeForm: TPanel
      Left = 955
      ExplicitLeft = 955
    end
    inherited pnlInfo: TPanel
      Width = 955
      ExplicitWidth = 955
      object shpMultSel: TShape
        Left = 710
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 0
    Width = 1126
    Height = 627
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pgcPrincipal: TPageControl
      Left = 1
      Top = 96
      Width = 1124
      Height = 530
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      TabStop = False
    end
    object pnlDados: TPanel
      Left = 6
      Top = 99
      Width = 1115
      Height = 523
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object grdIcms: TStringGrid
        Left = 5
        Top = 29
        Width = 532
        Height = 261
        BiDiMode = bdLeftToRight
        Color = clWhite
        ColCount = 6
        Ctl3D = True
        DefaultColWidth = 152
        DefaultRowHeight = 15
        RowCount = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearType
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        ColWidths = (
          152
          152
          152
          152
          152
          152)
        RowHeights = (
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15)
      end
      object grdIpi: TStringGrid
        Left = 537
        Top = 29
        Width = 576
        Height = 261
        BiDiMode = bdLeftToRight
        Color = clWhite
        ColCount = 4
        Ctl3D = True
        DefaultColWidth = 152
        DefaultRowHeight = 15
        RowCount = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearType
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        ColWidths = (
          152
          152
          152
          152)
        RowHeights = (
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15)
      end
      object Panel1: TPanel
        Left = 5
        Top = 8
        Width = 531
        Height = 22
        BevelOuter = bvNone
        Caption = 'RESUMO DE ICMS / ICMS ST'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object Panel2: TPanel
        Left = 537
        Top = 8
        Width = 576
        Height = 22
        BevelOuter = bvNone
        Caption = 'RESUMO DE IPI'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
      end
      object Panel4: TPanel
        Left = 5
        Top = 291
        Width = 531
        Height = 22
        BevelOuter = bvNone
        Caption = 'RESUMO DE PIS'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
      end
      object Panel5: TPanel
        Left = 537
        Top = 291
        Width = 576
        Height = 22
        BevelOuter = bvNone
        Caption = 'RESUMO DE COFINS'
        Color = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
      end
      object grdCofins: TStringGrid
        Left = 537
        Top = 313
        Width = 576
        Height = 182
        BiDiMode = bdLeftToRight
        Color = clWhite
        ColCount = 3
        Ctl3D = True
        DefaultColWidth = 190
        DefaultRowHeight = 15
        RowCount = 11
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearType
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        ColWidths = (
          190
          190
          190)
        RowHeights = (
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15)
      end
      object grdPis: TStringGrid
        Left = 5
        Top = 313
        Width = 532
        Height = 182
        BiDiMode = bdLeftToRight
        Color = clWhite
        ColCount = 3
        Ctl3D = True
        DefaultColWidth = 175
        DefaultRowHeight = 15
        RowCount = 11
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearType
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 7
        ColWidths = (
          175
          175
          175)
        RowHeights = (
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15
          15)
      end
    end
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 1124
      Height = 95
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label11: TLabel
        Left = 6
        Top = 38
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 6
        Top = 3
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblDesDtaFin: TLabel
        Left = 80
        Top = 54
        Width = 105
        Height = 14
        Caption = '(DATA DE ENTRADA)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDesDtaIni: TLabel
        Left = 77
        Top = 21
        Width = 105
        Height = 14
        Caption = '(DATA DE ENTRADA)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 203
        Top = 4
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rdgFiltroDatas: TRadioGroup
        Left = 203
        Top = 34
        Width = 335
        Height = 32
        Columns = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Data de Entrada'
          'Data de Documento')
        ParentFont = False
        TabOrder = 4
        OnClick = rdgFiltroDatasClick
      end
      object pnlFiltroMarca: TPanel
        Left = 203
        Top = 64
        Width = 335
        Height = 28
        BevelOuter = bvNone
        TabOrder = 5
        object lblMarca: TLabel
          Left = 1
          Top = 10
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
        end
        object edtDesMar: TEditFocus
          Left = 87
          Top = 6
          Width = 245
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 38
          Top = 6
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          TabOrder = 0
          OnExit = edtCodMarExit
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
      end
      object chkConsolidarSaldoCredorEmp: TCheckBox
        Left = 758
        Top = 57
        Width = 323
        Height = 17
        Caption = 'Consolidar Saldo Credor do Pis/Cofins em uma Unica Empresa'
        TabOrder = 10
      end
      object chkEnviaCreDebDifal: TCheckBox
        Left = 544
        Top = 24
        Width = 407
        Height = 17
        Caption = 'Adicionar o total de "Cr'#233'dito e D'#233'bito sobre DIFAL"'
        TabOrder = 7
      end
      object chkEnviarValorCupomConfirmado: TCheckBox
        Left = 544
        Top = 41
        Width = 200
        Height = 17
        Caption = 'Enviar valor lan'#231'amentos 5929/6929'
        TabOrder = 8
      end
      object chkEnviaTotalCredIcmCat158: TCheckBox
        Left = 544
        Top = 8
        Width = 414
        Height = 17
        Caption = 
          'Adicionar o total de "Cr'#233'tidos de ICMS sobre vendas INTERESTADUA' +
          'IS - Cat 158"'
        TabOrder = 6
      end
      object chkIncNFServicos: TCheckBox
        Left = 544
        Top = 57
        Width = 208
        Height = 17
        Caption = 'Incluir Notas Fiscais de Servi'#231'os x933'
        TabOrder = 9
      end
      object edtDesEmpresa: TEditFocus
        Left = 244
        Top = 18
        Width = 294
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEmpresa: TEditFocus
        Tag = 99
        Left = 203
        Top = 18
        Width = 37
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        OnExit = edtEmpresaExit
        OnKeyPress = edtEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 6
        Top = 51
        Width = 68
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 6
        Top = 16
        Width = 68
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 904
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 864
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 953
    Top = 207
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
    Left = 936
    Top = 440
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
    Left = 984
    Top = 440
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
    Left = 1032
    Top = 440
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
    Left = 1032
    Top = 472
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
    Left = 984
    Top = 472
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
    Left = 936
    Top = 472
  end
  object rldFiltro: TRLDraftFilter
    DisplayName = 'Impressora Matricial'
    Left = 936
    Top = 502
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 984
    Top = 502
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45112.480354583300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 936
    Top = 536
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
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 4.500000000000000000
      RightMargin = 4.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 2.500000000000000000
      ColumnWidth = 2.500000000000000000
      LargeDesignHeight = True
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 616.063023860000000000
        Top = 143.622140000000000000
        Width = 1088.504640000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        StartNewPage = True
        object Shape3: TfrxShapeView
          Left = 11.338590000000000000
          Top = 22.677180000000000000
          Width = 580.535433070000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo63: TfrxMemoView
          Left = 11.338590000000000000
          Top = 22.677180000000000000
          Width = 580.535433070000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE ICMS / ICMS ST')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line22: TfrxLineView
          Left = 11.338590000000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line23: TfrxLineView
          Left = 429.882190000000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line24: TfrxLineView
          Left = 120.944886770000000000
          Top = 45.354318500000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line25: TfrxLineView
          Left = 224.330713540000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line26: TfrxLineView
          Left = 327.716540310000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line27: TfrxLineView
          Left = 11.338590000000000000
          Top = 64.251968500000000000
          Width = 580.535433070000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo64: TfrxMemoView
          Left = 156.299320000000000000
          Top = 45.354360000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Cont'#225'bil')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 244.567100000000000000
          Top = 45.354360000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base ICMS')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 362.850650000000000000
          Top = 45.354360000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. ICMS')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 11.338590000000000000
          Top = 64.252010000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Saldo Anterior')
          ParentFont = False
        end
        object Line28: TfrxLineView
          Left = 11.338590000000000000
          Top = 83.149660000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo68: TfrxMemoView
          Left = 11.338590000000000000
          Top = 83.149660000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line29: TfrxLineView
          Left = 11.338590000000000000
          Top = 102.047310000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo69: TfrxMemoView
          Left = 11.338590000000000000
          Top = 102.047310000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line30: TfrxLineView
          Left = 11.338590000000000000
          Top = 120.944960000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo70: TfrxMemoView
          Left = 11.338590000000000000
          Top = 120.944960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line31: TfrxLineView
          Left = 11.338590000000000000
          Top = 139.842610000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo71: TfrxMemoView
          Left = 11.338590000000000000
          Top = 139.842610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Ajuste:')
          ParentFont = False
        end
        object Line32: TfrxLineView
          Left = 11.338590000000000000
          Top = 158.740260000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo72: TfrxMemoView
          Left = 11.338590000000000000
          Top = 158.740260000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Difal:')
          ParentFont = False
        end
        object Line33: TfrxLineView
          Left = 11.338590000000000000
          Top = 177.637910000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo73: TfrxMemoView
          Left = 11.338590000000000000
          Top = 177.637910000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line34: TfrxLineView
          Left = 11.338590000000000000
          Top = 196.535560000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo74: TfrxMemoView
          Left = 11.338590000000000000
          Top = 196.535560000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line35: TfrxLineView
          Left = 11.338590000000000000
          Top = 215.433210000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo75: TfrxMemoView
          Left = 11.338590000000000000
          Top = 215.433210000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line36: TfrxLineView
          Left = 11.338590000000000000
          Top = 234.330860000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo76: TfrxMemoView
          Left = 11.338590000000000000
          Top = 234.330860000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line37: TfrxLineView
          Left = 11.338590000000000000
          Top = 253.228510000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo77: TfrxMemoView
          Left = 11.338590000000000000
          Top = 253.228510000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Ajuste:')
          ParentFont = False
        end
        object Line38: TfrxLineView
          Left = 11.338590000000000000
          Top = 272.126160000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo78: TfrxMemoView
          Left = 11.338590000000000000
          Top = 272.126160000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Difal:')
          ParentFont = False
        end
        object Line39: TfrxLineView
          Left = 11.338590000000000000
          Top = 291.023810000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo79: TfrxMemoView
          Left = 11.338590000000000000
          Top = 291.023810000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos CAT158:')
          ParentFont = False
        end
        object Line40: TfrxLineView
          Left = 11.338590000000000000
          Top = 309.921460000000000000
          Width = 580.535433070000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo80: TfrxMemoView
          Left = 11.338590000000000000
          Top = 309.921460000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Line41: TfrxLineView
          Left = 11.338590000000000000
          Top = 328.819110000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo81: TfrxMemoView
          Left = 11.338590000000000000
          Top = 328.819110000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Line42: TfrxLineView
          Left = 11.338590000000000000
          Top = 347.716760000000000000
          Width = 580.535433070000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo82: TfrxMemoView
          Left = 332.393940000000000000
          Top = 64.913420000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ICMANT"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 126.842610000000000000
          Top = 83.811070000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOS"]')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 230.228510000000000000
          Top = 83.811070000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSBASICM"]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 332.393940000000000000
          Top = 83.811070000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."VENDAS_PRODUTOSVLRICM"> + <frxRelatorio."VALICM' +
              '_ECF">)]')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 126.842610000000000000
          Top = 102.708720000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOS"]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 230.228510000000000000
          Top = 102.708720000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSBASICM"]')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 332.393940000000000000
          Top = 102.708720000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSVLRICM"]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 126.842610000000000000
          Top = 121.606370000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAI"]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 230.228510000000000000
          Top = 121.606370000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIBASICM"]')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 332.393940000000000000
          Top = 121.606370000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIVLRICM"]')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 126.842610000000000000
          Top = 140.504020000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 230.228510000000000000
          Top = 140.504020000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 332.393940000000000000
          Top = 140.504020000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_DEBITO_AJUSTE_ICMS"]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 126.842610000000000000
          Top = 159.401670000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 230.228510000000000000
          Top = 159.401670000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 332.393940000000000000
          Top = 159.401670000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_DEBITO_DIFAL"]')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 126.842610000000000000
          Top = 178.299320000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_VLCON"]')
          ParentFont = False
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo99: TfrxMemoView
          Left = 230.228510000000000000
          Top = 178.299320000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_BASIC"]')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 332.393940000000000000
          Top = 178.299320000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SAI_VLRIC"> + <frxRelatorio."VALICM_ECF"> + <fr' +
              'xRelatorio."VLR_DEBITO_AJUSTE_ICMS"> + <frxRelatorio."VLR_DEBITO' +
              '_DIFAL">)]')
          ParentFont = False
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo101: TfrxMemoView
          Left = 126.842610000000000000
          Top = 197.196970000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOS"]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 230.228510000000000000
          Top = 197.196970000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSBASICM"]')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 332.393940000000000000
          Top = 197.196970000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSVLRICM"]')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 126.842610000000000000
          Top = 216.094620000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOS"]')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 230.228510000000000000
          Top = 216.094620000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSBASICM"]')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 332.393940000000000000
          Top = 216.094620000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSVLRICM"]')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 126.842610000000000000
          Top = 234.992270000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENT"]')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 230.228510000000000000
          Top = 234.992270000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTBASICM"]')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 332.393940000000000000
          Top = 234.992270000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTVLRICM"]')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 126.842610000000000000
          Top = 253.889920000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 230.228510000000000000
          Top = 253.889920000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 332.393940000000000000
          Top = 253.889920000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CREDITO_AJUSTE_ICMS"]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 126.842610000000000000
          Top = 272.787570000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 230.228510000000000000
          Top = 272.787570000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 332.393940000000000000
          Top = 272.787570000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CREDITO_DIFAL"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 126.842610000000000000
          Top = 291.685220000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 230.228510000000000000
          Top = 291.685220000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 332.393940000000000000
          Top = 291.685220000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CRED_ICMS_CAT158"]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 126.842610000000000000
          Top = 310.582870000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_VLCON"]')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 230.228510000000000000
          Top = 310.582870000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_BASIC"]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 332.393940000000000000
          Top = 310.582870000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."ENT_VLRIC"> + <frxRelatorio."VLR_CREDITO_AJUSTE' +
              '_ICMS"> + <frxRelatorio."VLR_CREDITO_DIFAL"> + <frxRelatorio."VL' +
              'R_CRED_ICMS_CAT158">)]')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 126.842610000000000000
          Top = 329.480520000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_VLCON"> - <frxRelatorio."ENT_VLCON">)]')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 230.228510000000000000
          Top = 329.480520000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_BASIC"> - <frxRelatorio."ENT_BASIC">)]')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 332.393940000000000000
          Top = 329.480520000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SAI_VLRIC"> + <frxRelatorio."VALICM_ECF"> + <fr' +
              'xRelatorio."VLR_DEBITO_AJUSTE_ICMS"> + <frxRelatorio."VLR_DEBITO' +
              '_DIFAL"> - <frxRelatorio."ENT_VLRIC"> - <frxRelatorio."VLR_CREDI' +
              'TO_AJUSTE_ICMS"> - <frxRelatorio."VLR_CREDITO_DIFAL"> - <frxRela' +
              'torio."VLR_CRED_ICMS_CAT158">) - <frxRelatorio."ICMANT">]')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 605.118430000000000000
          Top = 22.677180000000000000
          Width = 453.543600000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 605.118430000000000000
          Top = 22.677180000000000000
          Width = 453.543307090000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Left = 605.118430000000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 1058.662030000000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Left = 714.724726770000000000
          Top = 45.354318500000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line4: TfrxLineView
          Left = 828.110553540000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Left = 941.496380310000000000
          Top = 45.354323390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Left = 605.102362204724000000
          Top = 64.252010000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo3: TfrxMemoView
          Left = 760.079160000000000000
          Top = 45.354360000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Cont'#225'bil')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 896.142240000000000000
          Top = 45.354360000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 990.630490000000000000
          Top = 45.354360000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 605.118430000000000000
          Top = 64.252010000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Saldo Anterior')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 605.118430000000000000
          Top = 83.149660000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo7: TfrxMemoView
          Left = 605.118430000000000000
          Top = 83.149660000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Left = 605.118430000000000000
          Top = 102.047310000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo8: TfrxMemoView
          Left = 605.118430000000000000
          Top = 102.047310000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Left = 605.118430000000000000
          Top = 120.944960000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo9: TfrxMemoView
          Left = 605.118430000000000000
          Top = 120.944960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 605.118430000000000000
          Top = 139.842610000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo10: TfrxMemoView
          Left = 605.118430000000000000
          Top = 139.842610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Ajuste:')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Left = 605.118430000000000000
          Top = 158.740260000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo11: TfrxMemoView
          Left = 605.118430000000000000
          Top = 158.740260000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Difal:')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 605.118430000000000000
          Top = 177.637910000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo12: TfrxMemoView
          Left = 605.118430000000000000
          Top = 177.637910000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line13: TfrxLineView
          Left = 605.118430000000000000
          Top = 196.535560000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo13: TfrxMemoView
          Left = 605.118430000000000000
          Top = 196.535560000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line14: TfrxLineView
          Left = 605.118430000000000000
          Top = 215.433210000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo14: TfrxMemoView
          Left = 605.118430000000000000
          Top = 215.433210000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 605.118430000000000000
          Top = 234.330860000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo15: TfrxMemoView
          Left = 605.118430000000000000
          Top = 234.330860000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line16: TfrxLineView
          Left = 605.118430000000000000
          Top = 253.228510000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo16: TfrxMemoView
          Left = 605.118430000000000000
          Top = 253.228510000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Ajuste:')
          ParentFont = False
        end
        object Line17: TfrxLineView
          Left = 605.118430000000000000
          Top = 272.126160000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 605.118430000000000000
          Top = 272.126160000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Difal:')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Left = 605.118430000000000000
          Top = 291.023810000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo18: TfrxMemoView
          Left = 605.118430000000000000
          Top = 291.023810000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos CAT158:')
          ParentFont = False
        end
        object Line19: TfrxLineView
          Left = 605.118430000000000000
          Top = 309.921460000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo19: TfrxMemoView
          Left = 605.118430000000000000
          Top = 309.921460000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Line20: TfrxLineView
          Left = 605.118430000000000000
          Top = 328.819110000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo20: TfrxMemoView
          Left = 605.118430000000000000
          Top = 328.819110000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Line21: TfrxLineView
          Left = 605.118430000000000000
          Top = 347.716760000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo21: TfrxMemoView
          Left = 957.173780000000000000
          Top = 64.913420000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."IPIANT"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 726.622450000000000000
          Top = 83.811070000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSIPI"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 840.008350000000000000
          Top = 83.811070000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSBASIPI"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 957.173780000000000000
          Top = 83.811070000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSVLRIPI"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 726.622450000000000000
          Top = 102.708720000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSIPI"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 840.008350000000000000
          Top = 102.708720000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSBASIPI"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 957.173780000000000000
          Top = 102.708720000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSVLRIPI"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 726.622450000000000000
          Top = 121.606370000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAI"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 840.008350000000000000
          Top = 121.606370000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIBASIPI"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 957.173780000000000000
          Top = 121.606370000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIVLRIPI"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 726.622450000000000000
          Top = 140.504020000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 840.008350000000000000
          Top = 140.504020000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 957.173780000000000000
          Top = 140.504020000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 726.622450000000000000
          Top = 159.401670000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 840.008350000000000000
          Top = 159.401670000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 957.173780000000000000
          Top = 159.401670000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 726.622450000000000000
          Top = 178.299320000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_VLCON_IPI"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 840.008350000000000000
          Top = 178.299320000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_BASIP"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 957.173780000000000000
          Top = 178.299320000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_VLRIP"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 726.622450000000000000
          Top = 197.196970000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOS"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 840.008350000000000000
          Top = 197.196970000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSBASIPI"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 957.173780000000000000
          Top = 197.196970000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSVLRIPI"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 726.622450000000000000
          Top = 216.094620000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOS"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 840.008350000000000000
          Top = 216.094620000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSBASIPI"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 957.173780000000000000
          Top = 216.094620000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSVLRIPI"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 726.622450000000000000
          Top = 234.992270000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENT"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 840.008350000000000000
          Top = 234.992270000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTBASIPI"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 957.173780000000000000
          Top = 234.992270000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTVLRIPI"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 726.622450000000000000
          Top = 253.889920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 840.008350000000000000
          Top = 253.889920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 957.173780000000000000
          Top = 253.889920000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 726.622450000000000000
          Top = 272.787570000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 840.008350000000000000
          Top = 272.787570000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 957.173780000000000000
          Top = 272.787570000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 726.622450000000000000
          Top = 291.685220000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 840.008350000000000000
          Top = 291.685220000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 957.173780000000000000
          Top = 291.685220000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 726.622450000000000000
          Top = 310.582870000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_VLCON"]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 840.008350000000000000
          Top = 310.582870000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_BASIP"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 957.173780000000000000
          Top = 310.582870000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_VLRIP"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 726.622450000000000000
          Top = 329.480520000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_VLCON_IPI"> - <frxRelatorio."ENT_VLCON">)]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 840.008350000000000000
          Top = 329.480520000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_BASIP"> - <frxRelatorio."ENT_BASIP">)]')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 957.173780000000000000
          Top = 329.480520000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SAI_VLRIP"> - <frxRelatorio."ENT_VLRIP"> - <frx' +
              'Relatorio."IPIANT">)]')
          ParentFont = False
        end
        object frxRelatorioEMPRESA: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 839.055660000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa: [frxRelatorio."EMPRESA"]')
          ParentFont = False
        end
        object Shape4: TfrxShapeView
          Left = 11.338590000000000000
          Top = 359.055350000000000000
          Width = 580.535433070866000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo126: TfrxMemoView
          Left = 11.338590000000000000
          Top = 359.055350000000000000
          Width = 580.535433070000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE PIS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line43: TfrxLineView
          Left = 11.338590000000000000
          Top = 381.732493390000000000
          Height = 207.874150000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line44: TfrxLineView
          Left = 591.874015750000000000
          Top = 381.732493390000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line45: TfrxLineView
          Left = 120.944886770000000000
          Top = 381.732488500000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line47: TfrxLineView
          Left = 377.952755910000000000
          Top = 381.732283460000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line48: TfrxLineView
          Left = 11.338590000000000000
          Top = 400.630180000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo128: TfrxMemoView
          Left = 332.889822360000000000
          Top = 381.732530000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 524.850650000000000000
          Top = 381.732530000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. PIS')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 11.338590000000000000
          Top = 400.630180000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Saldo Anterior')
          ParentFont = False
        end
        object Line49: TfrxLineView
          Left = 11.338590000000000000
          Top = 419.527830000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo131: TfrxMemoView
          Left = 11.338590000000000000
          Top = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line50: TfrxLineView
          Left = 11.338590000000000000
          Top = 438.425480000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo132: TfrxMemoView
          Left = 11.338590000000000000
          Top = 438.425480000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line51: TfrxLineView
          Left = 11.338590000000000000
          Top = 457.323130000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo133: TfrxMemoView
          Left = 11.338590000000000000
          Top = 457.323130000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line52: TfrxLineView
          Left = 11.338590000000000000
          Top = 476.220780000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Line53: TfrxLineView
          Left = 11.338590000000000000
          Top = 495.118430000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Line54: TfrxLineView
          Left = 11.338590000000000000
          Top = 514.016080000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo136: TfrxMemoView
          Left = 11.338590000000000000
          Top = 476.220780000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line55: TfrxLineView
          Left = 11.338590000000000000
          Top = 532.913730000000000000
          Width = 580.535433070000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo137: TfrxMemoView
          Left = 11.338590000000000000
          Top = 495.118430000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line56: TfrxLineView
          Left = 11.338590000000000000
          Top = 551.811380000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo138: TfrxMemoView
          Left = 11.338590000000000000
          Top = 514.016080000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line57: TfrxLineView
          Left = 11.338590000000000000
          Top = 570.709030000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo139: TfrxMemoView
          Left = 11.338590000000000000
          Top = 532.913730000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line58: TfrxLineView
          Left = 11.338590000000000000
          Top = 589.606680000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo143: TfrxMemoView
          Left = 11.338590000000000000
          Top = 551.811380000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 11.338590000000000000
          Top = 570.709030000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 491.393940000000000000
          Top = 401.291590000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PISANT"]')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 276.196872360000000000
          Top = 420.189240000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSBASPIS"]')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 491.393940000000000000
          Top = 420.189240000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSTOTPIS"]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 276.196872360000000000
          Top = 439.086890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSBASPIS"]')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 491.393940000000000000
          Top = 439.086890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSTOTPIS"]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 276.196872360000000000
          Top = 457.984540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIBASPIS"]')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          Left = 491.393940000000000000
          Top = 457.984540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAITOTPIS"]')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          Left = 276.196872360000000000
          Top = 476.882190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_BASPIS"]')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 491.393940000000000000
          Top = 476.882190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_TOTPIS"]')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 276.196872360000000000
          Top = 495.779840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSBASPIS"]')
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Left = 491.393940000000000000
          Top = 495.779840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSTOTPIS"]')
          ParentFont = False
        end
        object Memo162: TfrxMemoView
          Left = 276.196872360000000000
          Top = 514.677490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSBASPIS"]')
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 491.393940000000000000
          Top = 514.677490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSTOTPIS"]')
          ParentFont = False
        end
        object Memo165: TfrxMemoView
          Left = 276.196872360000000000
          Top = 533.575140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTBASPIS"]')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 491.393940000000000000
          Top = 533.575140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTTOTPIS"]')
          ParentFont = False
        end
        object Memo168: TfrxMemoView
          Left = 276.196872360000000000
          Top = 552.472790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_BASPIS"]')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 491.393940000000000000
          Top = 552.472790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_TOTPIS"]')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 276.196872360000000000
          Top = 571.370440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_BASPIS"> - <frxRelatorio."ENT_BASPIS">)]')
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 491.393940000000000000
          Top = 571.370440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SAI_TOTPIS"> - <frxRelatorio."ENT_TOTPIS"> - <f' +
              'rxRelatorio."PISANT">)]')
          ParentFont = False
        end
        object Shape5: TfrxShapeView
          Left = 605.118430000000000000
          Top = 359.055350000000000000
          Width = 453.543600000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo127: TfrxMemoView
          Left = 605.118430000000000000
          Top = 359.055350000000000000
          Width = 453.543307090000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE COFINS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line46: TfrxLineView
          Left = 605.118430000000000000
          Top = 381.732493390000000000
          Height = 207.874150000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line59: TfrxLineView
          Left = 1058.662030000000000000
          Top = 381.732493390000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line60: TfrxLineView
          Left = 714.724726770000000000
          Top = 381.732488500000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line61: TfrxLineView
          Left = 886.693225830000000000
          Top = 381.732283460000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line62: TfrxLineView
          Left = 605.118430000000000000
          Top = 400.630180000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo134: TfrxMemoView
          Left = 835.669662360000000000
          Top = 381.732530000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base')
          ParentFont = False
        end
        object Memo135: TfrxMemoView
          Left = 990.630490000000000000
          Top = 381.732530000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. COFINS')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 605.118430000000000000
          Top = 400.630180000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Saldo Anterior')
          ParentFont = False
        end
        object Line63: TfrxLineView
          Left = 605.118430000000000000
          Top = 419.527830000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo141: TfrxMemoView
          Left = 605.118430000000000000
          Top = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line64: TfrxLineView
          Left = 605.118430000000000000
          Top = 438.425480000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo142: TfrxMemoView
          Left = 605.118430000000000000
          Top = 438.425480000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line65: TfrxLineView
          Left = 605.118430000000000000
          Top = 457.323130000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo146: TfrxMemoView
          Left = 605.118430000000000000
          Top = 457.323130000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line66: TfrxLineView
          Left = 605.118430000000000000
          Top = 476.220780000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Line67: TfrxLineView
          Left = 605.118430000000000000
          Top = 495.118430000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Line68: TfrxLineView
          Left = 605.118430000000000000
          Top = 514.016080000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo149: TfrxMemoView
          Left = 605.118430000000000000
          Top = 476.220780000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line69: TfrxLineView
          Left = 605.118430000000000000
          Top = 532.913730000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo152: TfrxMemoView
          Left = 605.118430000000000000
          Top = 495.118430000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line70: TfrxLineView
          Left = 605.118430000000000000
          Top = 551.811380000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo155: TfrxMemoView
          Left = 605.118430000000000000
          Top = 514.016080000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line71: TfrxLineView
          Left = 605.118430000000000000
          Top = 570.709030000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo158: TfrxMemoView
          Left = 605.118430000000000000
          Top = 532.913730000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line72: TfrxLineView
          Left = 605.118430000000000000
          Top = 589.606680000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo161: TfrxMemoView
          Left = 605.118430000000000000
          Top = 551.811380000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Memo164: TfrxMemoView
          Left = 605.118430000000000000
          Top = 570.709030000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Memo167: TfrxMemoView
          Left = 957.173780000000000000
          Top = 401.291590000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COFANT"]')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 778.976712360000000000
          Top = 420.189240000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSBASCOF"]')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 957.173780000000000000
          Top = 420.189240000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSTOTCOF"]')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 778.976712360000000000
          Top = 439.086890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSBASCOF"]')
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          Left = 957.173780000000000000
          Top = 439.086890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSTOTCOF"]')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 778.976712360000000000
          Top = 457.984540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIBASCOF"]')
          ParentFont = False
        end
        object Memo177: TfrxMemoView
          Left = 957.173780000000000000
          Top = 457.984540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAITOTCOF"]')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 778.976712360000000000
          Top = 476.882190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_BASCOF"]')
          ParentFont = False
        end
        object Memo179: TfrxMemoView
          Left = 957.173780000000000000
          Top = 476.882190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_TOTCOF"]')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 778.976712360000000000
          Top = 495.779840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSBASCOF"]')
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          Left = 957.173780000000000000
          Top = 495.779840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSTOTCOF"]')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 778.976712360000000000
          Top = 514.677490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSBASCOF"]')
          ParentFont = False
        end
        object Memo183: TfrxMemoView
          Left = 957.173780000000000000
          Top = 514.677490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSTOTCOF"]')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 778.976712360000000000
          Top = 533.575140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTBASCOF"]')
          ParentFont = False
        end
        object Memo185: TfrxMemoView
          Left = 957.173780000000000000
          Top = 533.575140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTTOTCOF"]')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          Left = 778.976712360000000000
          Top = 552.472790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_BASCOF"]')
          ParentFont = False
        end
        object Memo187: TfrxMemoView
          Left = 957.173780000000000000
          Top = 552.472790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_TOTCOF"]')
          ParentFont = False
        end
        object Memo188: TfrxMemoView
          Left = 778.976712360000000000
          Top = 571.370440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_BASCOF"> - <frxRelatorio."ENT_BASCOF">)]')
          ParentFont = False
        end
        object Memo189: TfrxMemoView
          Left = 957.173780000000000000
          Top = 571.370440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SAI_TOTCOF"> - <frxRelatorio."ENT_TOTCOF"> - <f' +
              'rxRelatorio."COFANT">)]')
          ParentFont = False
        end
        object Line145: TfrxLineView
          Left = 591.874015750000000000
          Top = 45.354360000000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line146: TfrxLineView
          Left = 517.338900000000000000
          Top = 45.354360000000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo194: TfrxMemoView
          Left = 434.645950000000000000
          Top = 45.354360000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base ICMS ST')
          ParentFont = False
        end
        object Memo209: TfrxMemoView
          Left = 521.693260000000000000
          Top = 45.354360000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. ICMS ST')
          ParentFont = False
        end
        object Memo256: TfrxMemoView
          Left = 434.645950000000000000
          Top = 83.905511810000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_PRODUTOSBAS_ST"]')
          ParentFont = False
        end
        object Memo271: TfrxMemoView
          Left = 434.645950000000000000
          Top = 102.803149606299200000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSBAS_ST"]')
          ParentFont = False
        end
        object Memo318: TfrxMemoView
          Left = 434.645950000000000000
          Top = 121.700787401574800000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIBAS_ST"]')
          ParentFont = False
        end
        object Memo328: TfrxMemoView
          Left = 434.645950000000000000
          Top = 140.598425196850400000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo350: TfrxMemoView
          Left = 434.645950000000000000
          Top = 159.496062992126000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo360: TfrxMemoView
          Left = 434.645950000000000000
          Top = 178.393700787401600000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAI_BCRET"]')
          ParentFont = False
        end
        object Memo379: TfrxMemoView
          Left = 434.645950000000000000
          Top = 197.291338582677200000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSBAS_ST"]')
          ParentFont = False
        end
        object Memo380: TfrxMemoView
          Left = 434.645950000000000000
          Top = 216.188976377952800000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSBAS_ST"]')
          ParentFont = False
        end
        object Memo381: TfrxMemoView
          Left = 434.645950000000000000
          Top = 235.086614173228300000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTBAS_ST"]')
          ParentFont = False
        end
        object Memo382: TfrxMemoView
          Left = 434.645950000000000000
          Top = 253.984251968503900000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo383: TfrxMemoView
          Left = 434.645950000000000000
          Top = 272.881889763779500000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo384: TfrxMemoView
          Left = 434.645950000000000000
          Top = 291.779527559055100000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo385: TfrxMemoView
          Left = 434.645950000000000000
          Top = 310.677165354330700000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENT_BCRET"]')
          ParentFont = False
        end
        object Memo386: TfrxMemoView
          Left = 434.645950000000000000
          Top = 329.574803149606300000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[(<frxRelatorio."SAI_BCRET"> - <frxRelatorio."ENT_BCRET">)]')
          ParentFont = False
        end
        object Memo387: TfrxMemoView
          Left = 521.575140000000000000
          Top = 65.007874015748030000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ST_ANT"]')
          ParentFont = False
        end
        object Memo388: TfrxMemoView
          Left = 521.575140000000000000
          Top = 83.905511811023620000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."VENDAS_PRODUTOSVLR_ST">]')
          ParentFont = False
        end
        object Memo389: TfrxMemoView
          Left = 521.575140000000000000
          Top = 102.803149606299200000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VENDAS_SERVICOSVLR_ST"]')
          ParentFont = False
        end
        object Memo390: TfrxMemoView
          Left = 521.575140000000000000
          Top = 121.700787401574800000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTSAIVLR_ST"]')
          ParentFont = False
        end
        object Memo391: TfrxMemoView
          Left = 521.575140000000000000
          Top = 140.598425196850400000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo392: TfrxMemoView
          Left = 521.575140000000000000
          Top = 159.496062992126000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo393: TfrxMemoView
          Left = 521.575140000000000000
          Top = 178.393700787401600000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."SAI_RETID">]')
          ParentFont = False
        end
        object Memo394: TfrxMemoView
          Left = 521.575140000000000000
          Top = 197.291338582677200000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_PRODUTOSVLR_ST"]')
          ParentFont = False
        end
        object Memo395: TfrxMemoView
          Left = 521.575140000000000000
          Top = 216.188976377952800000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COMPRA_SERVICOSVLR_ST"]')
          ParentFont = False
        end
        object Memo396: TfrxMemoView
          Left = 521.575140000000000000
          Top = 235.086614173228300000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."OUTENTVLR_ST"]')
          ParentFont = False
        end
        object Memo397: TfrxMemoView
          Left = 521.575140000000000000
          Top = 253.984251968503900000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo398: TfrxMemoView
          Left = 521.575140000000000000
          Top = 272.881889763779500000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo399: TfrxMemoView
          Left = 521.575140000000000000
          Top = 291.779527559055100000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo400: TfrxMemoView
          Left = 521.575140000000000000
          Top = 310.677165354330700000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ENT_RETID">]')
          ParentFont = False
        end
        object Memo401: TfrxMemoView
          Left = 521.575140000000000000
          Top = 329.574803149606300000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SAI_RETID"> - <frxRelatorio."ENT_RETID">) - <fr' +
              'xRelatorio."ST_ANT">]')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 65.247990000000000000
        Top = 18.897650000000000000
        Width = 1088.504640000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 179.452320000000000000
          Top = 3.779542200000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
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
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 307.842920000000000000
          Top = 18.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 971.338550940000000000
          Top = 11.338590000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
        end
        object Memo1: TfrxMemoView
          Left = 812.598950000000000000
          Top = 26.456710000000000000
          Width = 273.940260000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
        end
        object rllFiltroPeriodo: TfrxMemoView
          Align = baCenter
          Left = 307.842920000000000000
          Top = 34.015770000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Shape2: TfrxShapeView
          Top = 56.692950000000000000
          Width = 1084.725110000000000000
          Height = 3.779530000000000000
          Fill.BackColor = clSilver
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 627.401980000000000000
        Top = 820.158010000000000000
        Width = 1088.504640000000000000
        StartNewPage = True
        object Shape6: TfrxShapeView
          Left = 11.338590000000000000
          Top = 18.897650000000000000
          Width = 580.535433070866000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo190: TfrxMemoView
          Left = 11.338590000000000000
          Top = 18.897650000000000000
          Width = 580.535433070000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE ICMS / ICMS ST')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line73: TfrxLineView
          Left = 11.338590000000000000
          Top = 22.677143390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line74: TfrxLineView
          Left = 429.732283464566900000
          Top = 41.574803150000000000
          Height = 283.464566930000000000
          Color = clBlack
          Diagonal = True
        end
        object Line75: TfrxLineView
          Left = 120.944886770000000000
          Top = 41.574788500000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line76: TfrxLineView
          Left = 224.503937007874000000
          Top = 41.574793390000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line77: TfrxLineView
          Left = 327.685039370078700000
          Top = 41.574793390000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo191: TfrxMemoView
          Left = 156.472440944881900000
          Top = 41.574830000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Cont'#225'bil')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 244.535433070000000000
          Top = 41.574830000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base ICMS')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 362.834645669291300000
          Top = 41.574830000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. ICMS')
          ParentFont = False
        end
        object Line79: TfrxLineView
          Left = 11.338590000000000000
          Top = 79.370130000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo195: TfrxMemoView
          Left = 11.338590000000000000
          Top = 60.472480000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line80: TfrxLineView
          Left = 11.338590000000000000
          Top = 79.370130000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo196: TfrxMemoView
          Left = 11.338590000000000000
          Top = 79.370130000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line81: TfrxLineView
          Left = 11.338590000000000000
          Top = 98.267780000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo197: TfrxMemoView
          Left = 11.338590000000000000
          Top = 98.267780000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line82: TfrxLineView
          Left = 11.338590000000000000
          Top = 117.165430000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo198: TfrxMemoView
          Left = 11.338590000000000000
          Top = 117.165430000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Ajuste:')
          ParentFont = False
        end
        object Line83: TfrxLineView
          Left = 11.338590000000000000
          Top = 136.063080000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo199: TfrxMemoView
          Left = 11.338590000000000000
          Top = 136.063080000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Difal:')
          ParentFont = False
        end
        object Line84: TfrxLineView
          Left = 11.338590000000000000
          Top = 154.960730000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo200: TfrxMemoView
          Left = 11.338590000000000000
          Top = 154.960730000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line85: TfrxLineView
          Left = 11.338590000000000000
          Top = 173.858380000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo201: TfrxMemoView
          Left = 11.338590000000000000
          Top = 173.858380000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line86: TfrxLineView
          Left = 11.338590000000000000
          Top = 192.756030000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo202: TfrxMemoView
          Left = 11.338590000000000000
          Top = 192.756030000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line87: TfrxLineView
          Left = 11.338590000000000000
          Top = 211.653680000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo203: TfrxMemoView
          Left = 11.338590000000000000
          Top = 211.653680000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line88: TfrxLineView
          Left = 11.338590000000000000
          Top = 230.551330000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo204: TfrxMemoView
          Left = 11.338590000000000000
          Top = 230.551330000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Ajuste:')
          ParentFont = False
        end
        object Line89: TfrxLineView
          Left = 11.338590000000000000
          Top = 249.448980000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo205: TfrxMemoView
          Left = 11.338590000000000000
          Top = 249.448980000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Difal:')
          ParentFont = False
        end
        object Line90: TfrxLineView
          Left = 11.338590000000000000
          Top = 268.346630000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo206: TfrxMemoView
          Left = 11.338590000000000000
          Top = 268.346630000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos CAT158:')
          ParentFont = False
        end
        object Line91: TfrxLineView
          Left = 11.338590000000000000
          Top = 287.244280000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo207: TfrxMemoView
          Left = 11.338590000000000000
          Top = 287.244280000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Line92: TfrxLineView
          Left = 11.338590000000000000
          Top = 306.141930000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo208: TfrxMemoView
          Left = 11.338590000000000000
          Top = 306.141930000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Line93: TfrxLineView
          Left = 11.338590000000000000
          Top = 325.039580000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo210: TfrxMemoView
          Left = 126.992125980000000000
          Top = 61.133890000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo211: TfrxMemoView
          Left = 230.173228350000000000
          Top = 61.133890000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSBASICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo212: TfrxMemoView
          Left = 332.220472440000000000
          Top = 61.133890000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."VENDAS_PRODUTOSVLRICM"> + <frxRelatorio."VAL' +
              'ICM_ECF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo213: TfrxMemoView
          Left = 126.992125980000000000
          Top = 80.031540000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo214: TfrxMemoView
          Left = 230.173228350000000000
          Top = 80.031540000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSBASICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo215: TfrxMemoView
          Left = 332.220472440944900000
          Top = 80.031540000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSVLRICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo216: TfrxMemoView
          Left = 126.992125980000000000
          Top = 98.929190000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo217: TfrxMemoView
          Left = 230.173228350000000000
          Top = 98.929190000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIBASICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo218: TfrxMemoView
          Left = 332.220472440944900000
          Top = 98.929190000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIVLRICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo219: TfrxMemoView
          Left = 126.992125980000000000
          Top = 117.826840000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo220: TfrxMemoView
          Left = 230.173228350000000000
          Top = 117.826840000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo221: TfrxMemoView
          Left = 332.220472440944900000
          Top = 117.826840000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_DEBITO_AJUSTE_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo222: TfrxMemoView
          Left = 126.992125980000000000
          Top = 136.724490000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo223: TfrxMemoView
          Left = 230.173228350000000000
          Top = 136.724490000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo224: TfrxMemoView
          Left = 332.220472440944900000
          Top = 136.724490000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_DEBITO_DIFAL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo225: TfrxMemoView
          Left = 126.992125980000000000
          Top = 155.622140000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_VLCON">,rlbDetalhes)]')
          ParentFont = False
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo226: TfrxMemoView
          Left = 230.173228350000000000
          Top = 155.622140000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_BASIC">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo227: TfrxMemoView
          Left = 332.220472440000000000
          Top = 155.622140000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_VLRIC"> + <frxRelatorio."VALICM_ECF"> + ' +
              '<frxRelatorio."VLR_DEBITO_AJUSTE_ICMS"> + <frxRelatorio."VLR_DEB' +
              'ITO_DIFAL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Left = 126.992125980000000000
          Top = 174.519790000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo229: TfrxMemoView
          Left = 230.173228350000000000
          Top = 174.519790000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSBASICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo230: TfrxMemoView
          Left = 332.220472440944900000
          Top = 174.519790000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSVLRICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo231: TfrxMemoView
          Left = 126.992125980000000000
          Top = 193.417440000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Left = 230.173228350000000000
          Top = 193.417440000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSBASICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Left = 332.220472440944900000
          Top = 193.417440000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSVLRICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo234: TfrxMemoView
          Left = 126.992125980000000000
          Top = 212.315090000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo235: TfrxMemoView
          Left = 230.173228350000000000
          Top = 212.315090000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTBASICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo236: TfrxMemoView
          Left = 332.220472440944900000
          Top = 212.315090000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTVLRICM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Left = 126.992125980000000000
          Top = 231.212740000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo238: TfrxMemoView
          Left = 230.173228350000000000
          Top = 231.212740000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Left = 332.220472440944900000
          Top = 231.212740000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CREDITO_AJUSTE_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo240: TfrxMemoView
          Left = 126.992125980000000000
          Top = 250.110390000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo241: TfrxMemoView
          Left = 230.173228350000000000
          Top = 250.110390000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo242: TfrxMemoView
          Left = 332.220472440944900000
          Top = 250.110390000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CREDITO_DIFAL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo243: TfrxMemoView
          Left = 126.992125980000000000
          Top = 269.008040000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo244: TfrxMemoView
          Left = 230.173228350000000000
          Top = 269.008040000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo245: TfrxMemoView
          Left = 332.220472440944900000
          Top = 269.008040000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS_CAT158">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo246: TfrxMemoView
          Left = 126.992125980000000000
          Top = 287.905690000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_VLCON">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo247: TfrxMemoView
          Left = 230.173228350000000000
          Top = 287.905690000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_BASIC">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo248: TfrxMemoView
          Left = 332.220472440944900000
          Top = 287.905690000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."ENT_VLRIC"> + <frxRelatorio."VLR_CREDITO_AJU' +
              'STE_ICMS"> + <frxRelatorio."VLR_CREDITO_DIFAL"> + <frxRelatorio.' +
              '"VLR_CRED_ICMS_CAT158">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo249: TfrxMemoView
          Left = 126.992125980000000000
          Top = 306.803340000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_VLCON"> - <frxRelatorio."ENT_VLCON">,rlb' +
              'Detalhes)]')
          ParentFont = False
        end
        object Memo250: TfrxMemoView
          Left = 230.173228350000000000
          Top = 306.803340000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_BASIC"> - <frxRelatorio."ENT_BASIC">,rlb' +
              'Detalhes)]')
          ParentFont = False
        end
        object Memo251: TfrxMemoView
          Left = 332.220472440944900000
          Top = 306.803340000000000000
          Width = 94.488188976377950000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_VLRIC"> + <frxRelatorio."VALICM_ECF"> + ' +
              '<frxRelatorio."VLR_DEBITO_AJUSTE_ICMS"> + <frxRelatorio."VLR_DEB' +
              'ITO_DIFAL"> - <frxRelatorio."ENT_VLRIC"> - <frxRelatorio."VLR_CR' +
              'EDITO_AJUSTE_ICMS"> - <frxRelatorio."VLR_CREDITO_DIFAL"> - <frxR' +
              'elatorio."VLR_CRED_ICMS_CAT158">,rlbDetalhes)]')
          ParentFont = False
        end
        object Shape7: TfrxShapeView
          Left = 605.118430000000000000
          Top = 18.897650000000000000
          Width = 453.543600000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo252: TfrxMemoView
          Left = 605.118430000000000000
          Top = 18.897650000000000000
          Width = 453.543307090000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line94: TfrxLineView
          Left = 605.118430000000000000
          Top = 22.677143390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line95: TfrxLineView
          Left = 1058.662030000000000000
          Top = 22.677143390000000000
          Height = 302.362400000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line96: TfrxLineView
          Left = 714.724726770000000000
          Top = 41.574788500000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line97: TfrxLineView
          Left = 828.110553540000000000
          Top = 41.574793390000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line98: TfrxLineView
          Left = 941.496380310000000000
          Top = 41.574793390000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line99: TfrxLineView
          Left = 605.118430000000000000
          Top = 60.472480000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo253: TfrxMemoView
          Left = 760.079160000000000000
          Top = 41.574830000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Cont'#225'bil')
          ParentFont = False
        end
        object Memo254: TfrxMemoView
          Left = 896.142240000000000000
          Top = 41.574830000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base')
          ParentFont = False
        end
        object Memo255: TfrxMemoView
          Left = 990.630490000000000000
          Top = 41.574830000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. IPI')
          ParentFont = False
        end
        object Line100: TfrxLineView
          Left = 605.102362204724000000
          Top = 79.370130000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo257: TfrxMemoView
          Left = 605.118430000000000000
          Top = 60.472480000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line101: TfrxLineView
          Left = 605.118430000000000000
          Top = 79.370130000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo258: TfrxMemoView
          Left = 605.118430000000000000
          Top = 79.370130000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line102: TfrxLineView
          Left = 605.118430000000000000
          Top = 98.267780000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo259: TfrxMemoView
          Left = 605.118430000000000000
          Top = 98.267780000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line103: TfrxLineView
          Left = 605.118430000000000000
          Top = 117.165430000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo260: TfrxMemoView
          Left = 605.118430000000000000
          Top = 117.165430000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Ajuste:')
          ParentFont = False
        end
        object Line104: TfrxLineView
          Left = 605.118430000000000000
          Top = 136.063080000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo261: TfrxMemoView
          Left = 605.118430000000000000
          Top = 136.063080000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#233'bitos Difal:')
          ParentFont = False
        end
        object Line105: TfrxLineView
          Left = 605.118430000000000000
          Top = 154.960730000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo262: TfrxMemoView
          Left = 605.118430000000000000
          Top = 154.960730000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line106: TfrxLineView
          Left = 605.118430000000000000
          Top = 173.858380000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo263: TfrxMemoView
          Left = 605.118430000000000000
          Top = 173.858380000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line107: TfrxLineView
          Left = 605.118430000000000000
          Top = 192.756030000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo264: TfrxMemoView
          Left = 605.118430000000000000
          Top = 192.756030000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line108: TfrxLineView
          Left = 605.118430000000000000
          Top = 211.653680000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo265: TfrxMemoView
          Left = 605.118430000000000000
          Top = 211.653680000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line109: TfrxLineView
          Left = 605.118430000000000000
          Top = 230.551330000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo266: TfrxMemoView
          Left = 605.118430000000000000
          Top = 230.551330000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Ajuste:')
          ParentFont = False
        end
        object Line110: TfrxLineView
          Left = 605.118430000000000000
          Top = 249.448980000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo267: TfrxMemoView
          Left = 605.118430000000000000
          Top = 249.448980000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos Difal:')
          ParentFont = False
        end
        object Line111: TfrxLineView
          Left = 605.118430000000000000
          Top = 268.346630000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo268: TfrxMemoView
          Left = 605.118430000000000000
          Top = 268.346630000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cr'#233'ditos CAT158:')
          ParentFont = False
        end
        object Line112: TfrxLineView
          Left = 605.118430000000000000
          Top = 287.244280000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo269: TfrxMemoView
          Left = 605.118430000000000000
          Top = 287.244280000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Line113: TfrxLineView
          Left = 605.118430000000000000
          Top = 306.141930000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo270: TfrxMemoView
          Left = 605.118430000000000000
          Top = 306.141930000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Line114: TfrxLineView
          Left = 605.118430000000000000
          Top = 325.039580000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo272: TfrxMemoView
          Left = 726.622450000000000000
          Top = 61.133890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo273: TfrxMemoView
          Left = 840.008350000000000000
          Top = 61.133890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSBASIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo274: TfrxMemoView
          Left = 957.173780000000000000
          Top = 61.133890000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSVLRIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo275: TfrxMemoView
          Left = 726.622450000000000000
          Top = 80.031540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo276: TfrxMemoView
          Left = 840.008350000000000000
          Top = 80.031540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSBASIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo277: TfrxMemoView
          Left = 957.173780000000000000
          Top = 80.031540000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSVLRIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo278: TfrxMemoView
          Left = 726.622450000000000000
          Top = 98.929190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo279: TfrxMemoView
          Left = 840.008350000000000000
          Top = 98.929190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIBASIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo280: TfrxMemoView
          Left = 957.173780000000000000
          Top = 98.929190000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIVLRIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo281: TfrxMemoView
          Left = 726.622450000000000000
          Top = 117.826840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo282: TfrxMemoView
          Left = 840.008350000000000000
          Top = 117.826840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo283: TfrxMemoView
          Left = 957.173780000000000000
          Top = 117.826840000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo284: TfrxMemoView
          Left = 726.622450000000000000
          Top = 136.724490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo285: TfrxMemoView
          Left = 840.008350000000000000
          Top = 136.724490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo286: TfrxMemoView
          Left = 957.173780000000000000
          Top = 136.724490000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo287: TfrxMemoView
          Left = 726.622450000000000000
          Top = 155.622140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_VLCON_IPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo288: TfrxMemoView
          Left = 840.008350000000000000
          Top = 155.622140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_BASIP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo289: TfrxMemoView
          Left = 957.173780000000000000
          Top = 155.622140000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_VLRIP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo290: TfrxMemoView
          Left = 726.622450000000000000
          Top = 174.519790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo291: TfrxMemoView
          Left = 840.008350000000000000
          Top = 174.519790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSBASIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo292: TfrxMemoView
          Left = 957.173780000000000000
          Top = 174.519790000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSVLRIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo293: TfrxMemoView
          Left = 726.622450000000000000
          Top = 193.417440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo294: TfrxMemoView
          Left = 840.008350000000000000
          Top = 193.417440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSBASIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo295: TfrxMemoView
          Left = 957.173780000000000000
          Top = 193.417440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSVLRIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo296: TfrxMemoView
          Left = 726.622450000000000000
          Top = 212.315090000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo297: TfrxMemoView
          Left = 840.008350000000000000
          Top = 212.315090000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTBASIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo298: TfrxMemoView
          Left = 957.173780000000000000
          Top = 212.315090000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTVLRIPI">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo299: TfrxMemoView
          Left = 726.622450000000000000
          Top = 231.212740000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo300: TfrxMemoView
          Left = 840.008350000000000000
          Top = 231.212740000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo301: TfrxMemoView
          Left = 957.173780000000000000
          Top = 231.212740000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo302: TfrxMemoView
          Left = 726.622450000000000000
          Top = 250.110390000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo303: TfrxMemoView
          Left = 840.008350000000000000
          Top = 250.110390000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo304: TfrxMemoView
          Left = 957.173780000000000000
          Top = 250.110390000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo305: TfrxMemoView
          Left = 726.622450000000000000
          Top = 269.008040000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo306: TfrxMemoView
          Left = 840.008350000000000000
          Top = 269.008040000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo307: TfrxMemoView
          Left = 957.173780000000000000
          Top = 269.008040000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo308: TfrxMemoView
          Left = 726.622450000000000000
          Top = 287.905690000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_VLCON">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo309: TfrxMemoView
          Left = 840.008350000000000000
          Top = 287.905690000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_BASIP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo310: TfrxMemoView
          Left = 957.173780000000000000
          Top = 287.905690000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_VLRIP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo311: TfrxMemoView
          Left = 726.622450000000000000
          Top = 306.803340000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_VLCON_IPI"> - <frxRelatorio."ENT_VLCON">' +
              ',rlbDetalhes)]')
          ParentFont = False
        end
        object Memo312: TfrxMemoView
          Left = 840.008350000000000000
          Top = 306.803340000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_BASIP"> - <frxRelatorio."ENT_BASIP">,rlb' +
              'Detalhes)]')
          ParentFont = False
        end
        object Memo313: TfrxMemoView
          Left = 957.173780000000000000
          Top = 306.803340000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_VLRIP"> - <frxRelatorio."ENT_VLRIP"> - <' +
              'frxRelatorio."IPIANT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo314: TfrxMemoView
          Left = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Shape8: TfrxShapeView
          Left = 11.338590000000000000
          Top = 336.378170000000000000
          Width = 580.535433070866000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo315: TfrxMemoView
          Left = 11.338590000000000000
          Top = 336.378170000000000000
          Width = 580.535433070866000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE PIS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line115: TfrxLineView
          Left = 11.338590000000000000
          Top = 340.157663390000000000
          Height = 207.874150000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line116: TfrxLineView
          Left = 591.874015748031500000
          Top = 340.157663390000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line117: TfrxLineView
          Left = 120.944886770000000000
          Top = 359.055308500000000000
          Height = 188.976365750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line118: TfrxLineView
          Left = 377.952755905511800000
          Top = 359.055103460000000000
          Height = 188.976365750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line119: TfrxLineView
          Left = 11.338590000000000000
          Top = 377.953000000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo316: TfrxMemoView
          Left = 332.976377952755900000
          Top = 359.055350000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base')
          ParentFont = False
        end
        object Memo317: TfrxMemoView
          Left = 524.976377952755900000
          Top = 359.055350000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. PIS')
          ParentFont = False
        end
        object Line120: TfrxLineView
          Left = 11.338590000000000000
          Top = 396.850650000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo319: TfrxMemoView
          Left = 11.338590000000000000
          Top = 377.953000000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line121: TfrxLineView
          Left = 11.338590000000000000
          Top = 396.850650000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo320: TfrxMemoView
          Left = 11.338590000000000000
          Top = 396.850650000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line122: TfrxLineView
          Left = 11.338590000000000000
          Top = 415.748300000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo321: TfrxMemoView
          Left = 11.338590000000000000
          Top = 415.748300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line123: TfrxLineView
          Left = 11.338590000000000000
          Top = 434.645950000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Line124: TfrxLineView
          Left = 11.338590000000000000
          Top = 453.543600000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Line125: TfrxLineView
          Left = 11.338590000000000000
          Top = 472.441250000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo322: TfrxMemoView
          Left = 11.338590000000000000
          Top = 434.645950000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line126: TfrxLineView
          Left = 11.338590000000000000
          Top = 491.338900000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo323: TfrxMemoView
          Left = 11.338590000000000000
          Top = 453.543600000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line127: TfrxLineView
          Left = 11.338590000000000000
          Top = 510.236550000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo324: TfrxMemoView
          Left = 11.338590000000000000
          Top = 472.441250000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line128: TfrxLineView
          Left = 11.338590000000000000
          Top = 529.134200000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo325: TfrxMemoView
          Left = 11.338590000000000000
          Top = 491.338900000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line129: TfrxLineView
          Left = 11.338590000000000000
          Top = 548.031850000000000000
          Width = 580.535433070866000000
          Color = clBlack
          Diagonal = True
        end
        object Memo326: TfrxMemoView
          Left = 11.338590000000000000
          Top = 510.236550000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Memo327: TfrxMemoView
          Left = 11.338590000000000000
          Top = 529.134200000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Memo329: TfrxMemoView
          Left = 276.283464570000000000
          Top = 378.614410000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSBASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo330: TfrxMemoView
          Left = 491.338582677165400000
          Top = 378.614410000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSTOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo331: TfrxMemoView
          Left = 276.283464566929100000
          Top = 397.512060000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSBASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo332: TfrxMemoView
          Left = 491.338582677165400000
          Top = 397.512060000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSTOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo333: TfrxMemoView
          Left = 276.283464566929100000
          Top = 416.409710000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIBASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo334: TfrxMemoView
          Left = 491.338582677165400000
          Top = 416.409710000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAITOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo335: TfrxMemoView
          Left = 276.283464566929100000
          Top = 435.307360000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_BASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo336: TfrxMemoView
          Left = 491.338582677165400000
          Top = 435.307360000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_TOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo337: TfrxMemoView
          Left = 276.283464566929100000
          Top = 454.205010000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSBASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo338: TfrxMemoView
          Left = 491.338582677165400000
          Top = 454.205010000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSTOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo339: TfrxMemoView
          Left = 276.283464566929100000
          Top = 473.102660000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSBASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo340: TfrxMemoView
          Left = 491.338582677165400000
          Top = 473.102660000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSTOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo341: TfrxMemoView
          Left = 276.283464566929100000
          Top = 492.000310000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTBASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo342: TfrxMemoView
          Left = 491.338582677165400000
          Top = 492.000310000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTTOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo343: TfrxMemoView
          Left = 276.283464566929100000
          Top = 510.897960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_BASPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo344: TfrxMemoView
          Left = 491.338582677165400000
          Top = 510.897960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_TOTPIS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo345: TfrxMemoView
          Left = 276.283464566929100000
          Top = 529.795610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_BASPIS"> - <frxRelatorio."ENT_BASPIS">,r' +
              'lbDetalhes)]')
          ParentFont = False
        end
        object Memo346: TfrxMemoView
          Left = 491.338582677165400000
          Top = 529.795610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_TOTPIS"> - <frxRelatorio."ENT_TOTPIS"> -' +
              ' <frxRelatorio."PISANT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Shape9: TfrxShapeView
          Left = 605.118430000000000000
          Top = 336.378170000000000000
          Width = 453.543600000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo347: TfrxMemoView
          Left = 605.118430000000000000
          Top = 336.378170000000000000
          Width = 453.543307090000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO DE COFINS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line130: TfrxLineView
          Left = 605.118430000000000000
          Top = 340.157663390000000000
          Height = 207.874150000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line131: TfrxLineView
          Left = 1058.662030000000000000
          Top = 340.157663390000000000
          Height = 207.874015750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line132: TfrxLineView
          Left = 714.724726770000000000
          Top = 359.055308500000000000
          Height = 188.976365750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line133: TfrxLineView
          Left = 886.693225830000000000
          Top = 359.055103460000000000
          Height = 188.976365750000000000
          Color = clBlack
          Diagonal = True
        end
        object Line134: TfrxLineView
          Left = 605.118430000000000000
          Top = 377.953000000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo348: TfrxMemoView
          Left = 835.669662360000000000
          Top = 359.055350000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base')
          ParentFont = False
        end
        object Memo349: TfrxMemoView
          Left = 990.630490000000000000
          Top = 359.055350000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. COFINS')
          ParentFont = False
        end
        object Line135: TfrxLineView
          Left = 605.102362204724000000
          Top = 396.850650000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo351: TfrxMemoView
          Left = 605.118430000000000000
          Top = 377.953000000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Produtos:')
          ParentFont = False
        end
        object Line136: TfrxLineView
          Left = 605.118430000000000000
          Top = 396.850650000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo352: TfrxMemoView
          Left = 605.118430000000000000
          Top = 396.850650000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendas Servi'#231'os:')
          ParentFont = False
        end
        object Line137: TfrxLineView
          Left = 605.118430000000000000
          Top = 415.748300000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo353: TfrxMemoView
          Left = 605.118430000000000000
          Top = 415.748300000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Sa'#237'das:')
          ParentFont = False
        end
        object Line138: TfrxLineView
          Left = 605.118430000000000000
          Top = 434.645950000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Line139: TfrxLineView
          Left = 605.118430000000000000
          Top = 453.543600000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Line140: TfrxLineView
          Left = 605.118430000000000000
          Top = 472.441250000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo354: TfrxMemoView
          Left = 605.118430000000000000
          Top = 434.645950000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Sa'#237'da:')
          ParentFont = False
        end
        object Line141: TfrxLineView
          Left = 605.118430000000000000
          Top = 491.338900000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo355: TfrxMemoView
          Left = 605.118430000000000000
          Top = 453.543600000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Produtos:')
          ParentFont = False
        end
        object Line142: TfrxLineView
          Left = 605.118430000000000000
          Top = 510.236550000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo356: TfrxMemoView
          Left = 605.118430000000000000
          Top = 472.441250000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compras Servi'#231'os:')
          ParentFont = False
        end
        object Line143: TfrxLineView
          Left = 605.118430000000000000
          Top = 529.134200000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo357: TfrxMemoView
          Left = 605.118430000000000000
          Top = 491.338900000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Outras Entradas:')
          ParentFont = False
        end
        object Line144: TfrxLineView
          Left = 605.118430000000000000
          Top = 548.031850000000000000
          Width = 453.543307090000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo358: TfrxMemoView
          Left = 605.118430000000000000
          Top = 510.236550000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Entrada:')
          ParentFont = False
        end
        object Memo359: TfrxMemoView
          Left = 605.118430000000000000
          Top = 529.134200000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Memo361: TfrxMemoView
          Left = 778.976712360000000000
          Top = 378.614410000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSBASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo362: TfrxMemoView
          Left = 957.173780000000000000
          Top = 378.614410000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSTOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo363: TfrxMemoView
          Left = 778.976712360000000000
          Top = 397.512060000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSBASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo364: TfrxMemoView
          Left = 957.173780000000000000
          Top = 397.512060000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSTOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo365: TfrxMemoView
          Left = 778.976712360000000000
          Top = 416.409710000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIBASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo366: TfrxMemoView
          Left = 957.173780000000000000
          Top = 416.409710000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAITOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo367: TfrxMemoView
          Left = 778.976712360000000000
          Top = 435.307360000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_BASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo368: TfrxMemoView
          Left = 957.173780000000000000
          Top = 435.307360000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_TOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo369: TfrxMemoView
          Left = 778.976712360000000000
          Top = 454.205010000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSBASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo370: TfrxMemoView
          Left = 957.173780000000000000
          Top = 454.205010000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSTOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo371: TfrxMemoView
          Left = 778.976712360000000000
          Top = 473.102660000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSBASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo372: TfrxMemoView
          Left = 957.173780000000000000
          Top = 473.102660000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSTOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo373: TfrxMemoView
          Left = 778.976712360000000000
          Top = 492.000310000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTBASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo374: TfrxMemoView
          Left = 957.173780000000000000
          Top = 492.000310000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTTOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo375: TfrxMemoView
          Left = 778.976712360000000000
          Top = 510.897960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_BASCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo376: TfrxMemoView
          Left = 957.173780000000000000
          Top = 510.897960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_TOTCOF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo377: TfrxMemoView
          Left = 778.976712360000000000
          Top = 529.795610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_BASCOF"> - <frxRelatorio."ENT_BASCOF">,r' +
              'lbDetalhes)]')
          ParentFont = False
        end
        object Memo378: TfrxMemoView
          Left = 957.173780000000000000
          Top = 529.795610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_TOTCOF"> - <frxRelatorio."ENT_TOTCOF"> -' +
              ' <frxRelatorio."COFANT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line78: TfrxLineView
          Left = 11.338590000000000000
          Top = 60.472480000000000000
          Width = 580.535433070000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo402: TfrxMemoView
          Left = 521.574803150000000000
          Top = 41.574830000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. ICMS ST')
          ParentFont = False
        end
        object Memo403: TfrxMemoView
          Left = 521.574803150000000000
          Top = 61.133890000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSVLR_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo404: TfrxMemoView
          Left = 521.574803150000000000
          Top = 80.031540000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSVLR_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo405: TfrxMemoView
          Left = 521.574803150000000000
          Top = 98.929190000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIVLR_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo406: TfrxMemoView
          Left = 521.574803150000000000
          Top = 117.826840000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo407: TfrxMemoView
          Left = 521.574803150000000000
          Top = 136.724490000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo408: TfrxMemoView
          Left = 521.574803150000000000
          Top = 155.622140000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_RETID">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo409: TfrxMemoView
          Left = 521.574803150000000000
          Top = 174.519790000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSVLR_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo410: TfrxMemoView
          Left = 521.574803150000000000
          Top = 193.417440000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSVLR_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo411: TfrxMemoView
          Left = 521.574803150000000000
          Top = 212.315090000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTVLR_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo412: TfrxMemoView
          Left = 521.574803150000000000
          Top = 231.212740000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo413: TfrxMemoView
          Left = 521.574803150000000000
          Top = 250.110390000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo414: TfrxMemoView
          Left = 521.574803150000000000
          Top = 269.008040000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo415: TfrxMemoView
          Left = 521.574803150000000000
          Top = 287.905690000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_RETID">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo416: TfrxMemoView
          Left = 521.574803150000000000
          Top = 306.803340000000000000
          Width = 67.275590550000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_RETID"> - <frxRelatorio."ENT_RETID">,rlb' +
              'Detalhes)]')
          ParentFont = False
        end
        object Line147: TfrxLineView
          Left = 591.874015750000000000
          Top = 41.574803149606300000
          Height = 283.464566929133900000
          Color = clBlack
          Diagonal = True
        end
        object Line148: TfrxLineView
          Left = 517.417322834645700000
          Top = 41.574830000000000000
          Height = 283.464750000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo417: TfrxMemoView
          Left = 434.645669291338600000
          Top = 41.574830000000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Base ICMS ST')
          ParentFont = False
        end
        object Memo418: TfrxMemoView
          Left = 434.645669290000000000
          Top = 61.228346460000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_PRODUTOSBAS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo419: TfrxMemoView
          Left = 434.645669290000000000
          Top = 80.125984250000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VENDAS_SERVICOSBAS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo420: TfrxMemoView
          Left = 434.645669290000000000
          Top = 99.023622050000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTSAIBAS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo421: TfrxMemoView
          Left = 434.645669291338600000
          Top = 117.921259840000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo422: TfrxMemoView
          Left = 434.645669291338600000
          Top = 136.818897640000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo423: TfrxMemoView
          Left = 434.645669290000000000
          Top = 155.716535430000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SAI_BCRET">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo424: TfrxMemoView
          Left = 434.645669290000000000
          Top = 174.614173230000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_PRODUTOSBAS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo425: TfrxMemoView
          Left = 434.645669290000000000
          Top = 193.511811020000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."COMPRA_SERVICOSBAS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo426: TfrxMemoView
          Left = 434.645669290000000000
          Top = 212.409448820000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."OUTENTBAS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo427: TfrxMemoView
          Left = 434.645669291338600000
          Top = 231.307086610000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo428: TfrxMemoView
          Left = 434.645669291338600000
          Top = 250.204724410000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo429: TfrxMemoView
          Left = 434.645669291338600000
          Top = 269.102362200000000000
          Width = 79.370078740157480000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo430: TfrxMemoView
          Left = 434.645669290000000000
          Top = 288.000000000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ENT_BCRET">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo431: TfrxMemoView
          Left = 434.645669290000000000
          Top = 306.897637800000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SAI_BCRET"> - <frxRelatorio."ENT_BCRET">,rlb' +
              'Detalhes)]')
          ParentFont = False
        end
      end
    end
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
    Left = 984
    Top = 536
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 1032
    Top = 502
  end
end
