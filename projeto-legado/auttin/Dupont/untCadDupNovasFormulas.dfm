inherited frmCadDupNovasFormulas: TfrmCadDupNovasFormulas
  Left = 184
  Top = 162
  Width = 757
  Height = 572
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Dupont'
  ExplicitWidth = 757
  ExplicitHeight = 572
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 504
    Width = 751
    TabOrder = 3
    ExplicitTop = 504
    ExplicitWidth = 751
    inherited btnSair: TBitBtnLocked
      Left = 674
      TabOrder = 8
      ExplicitLeft = 674
    end
    inherited btnGravar: TBitBtnLocked
      Left = 76
      ExplicitLeft = 76
    end
    inherited btnCancela: TBitBtnLocked
      Left = 292
      TabOrder = 4
      ExplicitLeft = 292
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 220
      TabOrder = 3
      ExplicitLeft = 220
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 364
      ExplicitLeft = 364
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 148
      ExplicitLeft = 148
    end
    object btnAtivarNfm: TBitBtnLocked
      Left = 436
      Top = 4
      Width = 75
      Height = 20
      Caption = 'Ativar'
      TabOrder = 6
      OnClick = btnAtivarNfmClick
    end
    object btnAjustarVolume: TBitBtnLocked
      Left = 511
      Top = 4
      Width = 119
      Height = 20
      Hint = 'Clique aqui para ajustar o Volume para 900 ml'
      Caption = '&Ajustar Volume'
      Enabled = False
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnAjustarVolumeClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 532
    Width = 751
    TabOrder = 2
    ExplicitTop = 532
    ExplicitWidth = 751
    inherited pnlNomeForm: TPanel
      Left = 404
      TabOrder = 1
      ExplicitLeft = 404
    end
    inherited pnlInfo: TPanel
      Width = 404
      TabOrder = 0
      ExplicitWidth = 404
    end
  end
  inherited pgcDados: TPageControl
    Width = 751
    Height = 504
    TabOrder = 0
    ExplicitWidth = 751
    ExplicitHeight = 504
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 743
      ExplicitHeight = 472
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 751
    Height = 504
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 8
      Top = 62
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 168
      Top = 40
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label3: TLabel
      Left = 8
      Top = 435
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Diluente:'
    end
    object Label5: TLabel
      Left = 152
      Top = 435
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object Label6: TLabel
      Left = 8
      Top = 459
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Catalisador'
    end
    object Label27: TLabel
      Left = 152
      Top = 459
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object Label38: TLabel
      Left = 8
      Top = 84
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Linha:'
    end
    object Label39: TLabel
      Left = 164
      Top = 84
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Qualidade:'
    end
    object Label40: TLabel
      Left = 328
      Top = 84
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Alternativa:'
    end
    object Label41: TLabel
      Left = 8
      Top = 107
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Montadora:'
    end
    object Label72: TLabel
      Left = 510
      Top = 447
      Width = 230
      Height = 15
      Caption = 'Cadastrar a f'#243'rmula no volume de 900ml'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVolumeTotal: TLabel
      Left = 736
      Top = 423
      Width = 4
      Height = 16
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label73: TLabel
      Left = 8
      Top = 134
      Width = 121
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Acr'#233'scimo m'#227'o de obra:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 749
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Dupont'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 36
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 58
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 162
      Width = 744
      Height = 263
      Caption = '     Bases      '
      TabOrder = 10
      object Label7: TLabel
        Left = 8
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 136
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label9: TLabel
        Left = 8
        Top = 50
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label11: TLabel
        Left = 8
        Top = 74
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label13: TLabel
        Left = 8
        Top = 98
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label15: TLabel
        Left = 8
        Top = 122
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label17: TLabel
        Left = 6
        Top = 146
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label19: TLabel
        Left = 6
        Top = 170
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label21: TLabel
        Left = 6
        Top = 194
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label10: TLabel
        Left = 136
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label12: TLabel
        Left = 136
        Top = 74
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label14: TLabel
        Left = 136
        Top = 98
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label16: TLabel
        Left = 136
        Top = 122
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label28: TLabel
        Left = 248
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label29: TLabel
        Left = 248
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label30: TLabel
        Left = 248
        Top = 74
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label31: TLabel
        Left = 248
        Top = 98
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label32: TLabel
        Left = 248
        Top = 122
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label18: TLabel
        Left = 136
        Top = 146
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label20: TLabel
        Left = 136
        Top = 170
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label22: TLabel
        Left = 136
        Top = 194
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label33: TLabel
        Left = 247
        Top = 146
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label34: TLabel
        Left = 247
        Top = 170
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label35: TLabel
        Left = 247
        Top = 194
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label42: TLabel
        Left = 8
        Top = 218
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label43: TLabel
        Left = 136
        Top = 218
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label44: TLabel
        Left = 248
        Top = 218
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label45: TLabel
        Left = 8
        Top = 242
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label46: TLabel
        Left = 136
        Top = 242
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label47: TLabel
        Left = 248
        Top = 242
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label48: TLabel
        Left = 376
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label49: TLabel
        Left = 504
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label50: TLabel
        Left = 616
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label51: TLabel
        Left = 376
        Top = 50
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label52: TLabel
        Left = 504
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label53: TLabel
        Left = 616
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label54: TLabel
        Left = 376
        Top = 74
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label55: TLabel
        Left = 504
        Top = 74
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label56: TLabel
        Left = 616
        Top = 74
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label57: TLabel
        Left = 376
        Top = 98
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label58: TLabel
        Left = 504
        Top = 98
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label59: TLabel
        Left = 616
        Top = 98
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label60: TLabel
        Left = 376
        Top = 122
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label61: TLabel
        Left = 504
        Top = 122
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label62: TLabel
        Left = 616
        Top = 122
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label24: TLabel
        Left = 376
        Top = 146
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 16:'
      end
      object Label25: TLabel
        Left = 376
        Top = 170
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 17:'
      end
      object Label23: TLabel
        Left = 376
        Top = 194
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 18:'
      end
      object Label26: TLabel
        Left = 376
        Top = 218
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 19:'
      end
      object Label36: TLabel
        Left = 376
        Top = 242
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 20:'
      end
      object Label37: TLabel
        Left = 504
        Top = 146
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label63: TLabel
        Left = 504
        Top = 170
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label64: TLabel
        Left = 504
        Top = 194
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label65: TLabel
        Left = 504
        Top = 218
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label66: TLabel
        Left = 504
        Top = 242
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label67: TLabel
        Left = 616
        Top = 146
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label68: TLabel
        Left = 616
        Top = 170
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label69: TLabel
        Left = 616
        Top = 194
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object Label70: TLabel
        Left = 616
        Top = 218
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object label71: TLabel
        Left = 616
        Top = 242
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilul.:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB01'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC01: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 22
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC01'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm02: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 46
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC02: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 46
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC02'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm03: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 70
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC03: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 70
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC03'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm04: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 94
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC04: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 94
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC04'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm05: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 118
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 12
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC05: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 118
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC05'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm06: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 142
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC06: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 142
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC06'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 16
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm07: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 166
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 18
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC07: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 166
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC07'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm08: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 190
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 21
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC08: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 190
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC08'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 22
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD01: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 22
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD01'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD02: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 46
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD02'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD03: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 70
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD03'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD04: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 94
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD04'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD05: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 118
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD05'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD06: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 142
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD06'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD07: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 166
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD07'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 20
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD08: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 190
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD08'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 23
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm09: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 214
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 24
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC09: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 214
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC09'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 25
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD09: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 214
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD09'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 26
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm10: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 238
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 27
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC10: TDBEditFocus
        Tag = 99
        Left = 204
        Top = 238
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC10'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 28
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD10: TDBEditFocus
        Tag = 99
        Left = 316
        Top = 238
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD10'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 29
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm11: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 30
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC11: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 22
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC11'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 31
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD11: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 22
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD11'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 32
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm12: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 46
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 33
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC12: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 46
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC12'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 34
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD12: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 46
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD12'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 35
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm13: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 70
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 36
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC13: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 70
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC13'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 37
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD13: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 70
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD13'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 38
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 94
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 39
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC14: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 94
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC14'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 40
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD14: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 94
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD14'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 41
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm15: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 118
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 42
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC15: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 118
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC15'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 43
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD15: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 118
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD15'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 44
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm16: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 142
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB16'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 45
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm17: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 166
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB17'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 48
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm18: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 190
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB18'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 51
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm19: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 214
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB19'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 54
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm20: TDBEditFocus
        Tag = 99
        Left = 436
        Top = 237
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB20'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 57
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC16: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 142
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC16'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 46
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC17: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 166
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC17'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 49
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC18: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 190
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC18'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 52
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC19: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 214
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC19'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 55
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC20: TDBEditFocus
        Tag = 99
        Left = 572
        Top = 238
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC20'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 58
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD16: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 142
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD16'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 47
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD17: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 166
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD17'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 50
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD18: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 190
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD18'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 53
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD19: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 214
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD19'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 56
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD20: TDBEditFocus
        Tag = 99
        Left = 679
        Top = 238
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD20'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 59
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 252
      Top = 36
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodDil: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 431
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODDIL'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdDil: TDBEditFocus
      Tag = 99
      Left = 220
      Top = 431
      Width = 45
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_QTDDIL'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCat: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 455
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODCAT'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdCat: TDBEditFocus
      Tag = 99
      Left = 220
      Top = 455
      Width = 45
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_QTDCAT'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQualid: TDBEditFocus
      Tag = 99
      Left = 224
      Top = 80
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_QUALID'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAltern: TDBEditFocus
      Tag = 99
      Left = 388
      Top = 80
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ALTERN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMontad: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 103
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_MONTAD'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha_: TDBComboBoxFocus
      Left = 68
      Top = 80
      Width = 98
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'NFM_LINHA_'
      Items.Strings = (
        'CHROMA'
        'DUXONE'
        'IMRON'
        'NASON'
        'CORMAX')
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object grbCatalise: TGroupBox
      Left = 463
      Top = 28
      Width = 282
      Height = 106
      Caption = 'Catalise'
      TabOrder = 1
      object dbeCatali: TDBMemoFocus
        Left = 4
        Top = 15
        Width = 273
        Height = 87
        DataField = 'NFM_CATALI'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 135
      Top = 126
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 40
  end
end
