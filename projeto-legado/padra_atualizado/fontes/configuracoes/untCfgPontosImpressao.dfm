inherited frmCfgPontosImpressao: TfrmCfgPontosImpressao
  Left = 299
  Top = 188
  Width = 904
  Height = 465
  BorderIcons = [biSystemMenu]
  Caption = 'Pontos de Impress'#227'o NFe'
  Position = poMainFormCenter
  ExplicitWidth = 904
  ExplicitHeight = 465
  PixelsPerInch = 96
  TextHeight = 14
  object dbgPonImp: TDBGridCitel [0]
    Left = 0
    Top = 116
    Width = 898
    Height = 274
    Align = alClient
    DataSource = dtsPonImp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgPonImpKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Empresa'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NOMPON'
        Title.Caption = 'Ponto de Impress'#227'o'
        Width = 236
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMIMP'
        Title.Caption = 'Impressora'
        Width = 203
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXPRES'
        Title.Caption = 'Condi'#231#227'o para impress'#227'o'
        Width = 203
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFESIM'
        Title.Caption = 'NFe Simp.'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMMAQ'
        Title.Caption = 'Nome da M'#225'quina'
        Width = 135
        Visible = True
      end>
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 898
    Height = 116
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label1: TLabel
      Left = 114
      Top = 18
      Width = 98
      Height = 14
      Caption = 'Ponto de Impress'#227'o:'
    end
    object Label2: TLabel
      Left = 58
      Top = 43
      Width = 154
      Height = 14
      Caption = 'Impressora (somente NFe Citel):'
    end
    object Label3: TLabel
      Left = 75
      Top = 68
      Width = 137
      Height = 14
      Caption = '** Condi'#231#227'o para Impress'#227'o:'
    end
    object Label21: TLabel
      Left = 108
      Top = 92
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'DANFE - Simplificada:'
    end
    object ColorLabel3: TColorLabel
      Left = 241
      Top = 92
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object btnSelImp: TSpeedButton
      Left = 667
      Top = 38
      Width = 27
      Height = 22
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
      ParentShowHint = False
      ShowHint = False
      Visible = False
      OnClick = btnSelImpClick
    end
    object Label5: TLabel
      Left = 365
      Top = 92
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome da M'#225'quina:'
    end
    object edtPonImp: TEditFocus
      Tag = 99
      Left = 215
      Top = 14
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnInserir: TBitBtnLocked
      Left = 691
      Top = 85
      Width = 75
      Height = 25
      Caption = '&Inserir'
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
      TabOrder = 5
      OnClick = btnInserirClick
    end
    object edtNomImp: TEditFocus
      Tag = 99
      Left = 215
      Top = 38
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 200
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtExpressao: TEditFocus
      Tag = 99
      Left = 215
      Top = 62
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 200
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNFeSim: TEditFocus
      Tag = 99
      Left = 215
      Top = 86
      Width = 21
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 3
      Text = 'N'
      OnExit = edtNFeSimExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object cmbNomMaq: TComboBoxFocus
      Left = 457
      Top = 86
      Width = 208
      Height = 22
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlBotoes: TPanel
    Top = 390
    Width = 898
    ExplicitTop = 390
    ExplicitWidth = 898
    inherited FlwBotoes: TFlowPanel
      Width = 894
      ExplicitWidth = 894
    end
  end
  inherited pnlStatus: TPanel
    Top = 420
    Width = 898
    ExplicitTop = 420
    ExplicitWidth = 898
    inherited pnlNomeForm: TPanel
      Left = 727
      ExplicitLeft = 727
    end
    inherited pnlInfo: TPanel
      Width = 727
      ExplicitWidth = 727
    end
  end
  inherited pgcDados: TPageControl
    Width = 651
    Height = 1
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitWidth = 651
    ExplicitHeight = 1
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 643
      ExplicitHeight = 428
    end
  end
  object pnlLabel: TPanel [5]
    Left = 0
    Top = 390
    Width = 898
    Height = 30
    Align = alBottom
    TabOrder = 5
    object Label4: TColorLabel
      Left = 1
      Top = 1
      Width = 896
      Height = 14
      Align = alBottom
      Caption = 
        ' ** Montar uma express'#227'o usando as vari'#225'veis do faturamento, est' +
        'a express'#227'o deve retornar um valor l'#243'gico (0 ou 1), por exemplo:'
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      StyleElements = [seBorder]
      CorDestaque = clRed
      ExplicitWidth = 637
    end
    object ColorLabel1: TColorLabel
      Left = 1
      Top = 15
      Width = 896
      Height = 14
      Align = alBottom
      Caption = 
        '     (strEntFat = '#39'S'#39') AND (strCodReg = '#39'00001'#39')  ... "Quando fo' +
        'r entrega na regi'#227'o '#39'00001'#39' deve imprimir neste ponto de impress' +
        #227'o".'
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      StyleElements = [seBorder]
      CorDestaque = clRed
      ExplicitWidth = 624
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 336
  end
  object dtsPonImp: TDataSource
    Left = 384
    Top = 336
  end
end
