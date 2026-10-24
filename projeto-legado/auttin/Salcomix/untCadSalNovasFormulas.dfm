inherited frmCadSalNovasFormulas: TfrmCadSalNovasFormulas
  Left = 338
  Top = 192
  Width = 805
  Height = 493
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Salcomix'
  ExplicitWidth = 805
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 420
    Width = 799
    ExplicitTop = 420
    ExplicitWidth = 799
    inherited FlwBotoes: TFlowPanel
      Width = 795
      ExplicitTop = 2
      ExplicitWidth = 795
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 719
      Height = 20
      ExplicitLeft = 719
      ExplicitHeight = 20
    end
    object btnAjustarVolume: TBitBtnLocked
      Left = 445
      Top = 2
      Width = 119
      Height = 20
      Hint = 'Clique aqui para ajustar o Volume para 1 Litro'
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
      TabOrder = 2
      OnClick = btnAjustarVolumeClick
    end
    object btnAtivarNfm: TBitBtnLocked
      Left = 564
      Top = 2
      Width = 75
      Height = 20
      Caption = 'Ativar'
      TabOrder = 3
      OnClick = btnAtivarNfmClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 448
    Width = 799
    ExplicitTop = 448
    ExplicitWidth = 799
    inherited pnlNomeForm: TPanel
      Left = 452
      ExplicitLeft = 452
    end
    inherited pnlInfo: TPanel
      Width = 452
      ExplicitWidth = 452
    end
  end
  inherited pgcDados: TPageControl
    Width = 799
    Height = 420
    ExplicitWidth = 799
    ExplicitHeight = 420
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 791
      ExplicitHeight = 388
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 799
    Height = 420
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 93
      Top = 47
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 93
      Top = 77
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 298
      Top = 47
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label5: TLabel
      Left = 565
      Top = 47
      Width = 29
      Height = 14
      Caption = 'Linha:'
    end
    object lblInformativo: TLabel
      Left = 400
      Top = 106
      Width = 282
      Height = 18
      Alignment = taRightJustify
      Caption = 'CADASTRAR A F'#211'RMULA PARA 1 LITRO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label65: TLabel
      Left = 9
      Top = 107
      Width = 141
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = ' Acr'#233'scimo m'#227'o de obra:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 156
      Top = 44
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 156
      Top = 74
      Width = 541
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 142
      Width = 797
      Height = 277
      Align = alBottom
      Caption = '     Bases      '
      TabOrder = 6
      object Label7: TLabel
        Left = 8
        Top = 31
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 165
        Top = 31
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label9: TLabel
        Left = 8
        Top = 53
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label10: TLabel
        Left = 165
        Top = 52
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label11: TLabel
        Left = 8
        Top = 75
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label12: TLabel
        Left = 165
        Top = 75
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label13: TLabel
        Left = 8
        Top = 97
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label14: TLabel
        Left = 165
        Top = 97
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label15: TLabel
        Left = 8
        Top = 119
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label16: TLabel
        Left = 165
        Top = 119
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label17: TLabel
        Left = 8
        Top = 140
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 165
        Top = 140
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label19: TLabel
        Left = 8
        Top = 162
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 165
        Top = 162
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label21: TLabel
        Left = 8
        Top = 184
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 165
        Top = 184
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label23: TLabel
        Left = 8
        Top = 206
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 165
        Top = 206
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label25: TLabel
        Left = 8
        Top = 228
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 165
        Top = 228
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label27: TLabel
        Left = 409
        Top = 31
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label28: TLabel
        Left = 409
        Top = 53
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label29: TLabel
        Left = 409
        Top = 75
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label30: TLabel
        Left = 409
        Top = 97
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label31: TLabel
        Left = 409
        Top = 119
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label32: TLabel
        Left = 409
        Top = 140
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 16:'
      end
      object Label33: TLabel
        Left = 409
        Top = 162
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 17:'
      end
      object Label34: TLabel
        Left = 409
        Top = 184
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 18:'
      end
      object Label35: TLabel
        Left = 409
        Top = 206
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 19:'
      end
      object Label36: TLabel
        Left = 409
        Top = 228
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 20:'
      end
      object Label37: TLabel
        Left = 561
        Top = 31
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label38: TLabel
        Left = 561
        Top = 53
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label39: TLabel
        Left = 561
        Top = 75
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label40: TLabel
        Left = 561
        Top = 97
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label41: TLabel
        Left = 561
        Top = 119
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label42: TLabel
        Left = 561
        Top = 140
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label43: TLabel
        Left = 561
        Top = 162
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label44: TLabel
        Left = 561
        Top = 184
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label45: TLabel
        Left = 561
        Top = 206
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label46: TLabel
        Left = 561
        Top = 228
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label3: TLabel
        Left = 682
        Top = 31
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label6: TLabel
        Left = 682
        Top = 53
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label47: TLabel
        Left = 682
        Top = 75
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label48: TLabel
        Left = 682
        Top = 97
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label49: TLabel
        Left = 682
        Top = 119
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label50: TLabel
        Left = 682
        Top = 140
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label51: TLabel
        Left = 682
        Top = 162
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label52: TLabel
        Left = 682
        Top = 183
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label53: TLabel
        Left = 682
        Top = 204
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label54: TLabel
        Left = 682
        Top = 226
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label55: TLabel
        Left = 291
        Top = 31
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label56: TLabel
        Left = 291
        Top = 53
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label57: TLabel
        Left = 291
        Top = 75
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label58: TLabel
        Left = 291
        Top = 97
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label59: TLabel
        Left = 291
        Top = 119
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label60: TLabel
        Left = 291
        Top = 140
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label61: TLabel
        Left = 291
        Top = 162
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label62: TLabel
        Left = 291
        Top = 184
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label63: TLabel
        Left = 291
        Top = 206
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label64: TLabel
        Left = 291
        Top = 228
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object lblVolumeTotal: TLabel
        Left = 718
        Top = 249
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
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 22
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB01'
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
        Left = 226
        Top = 22
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB01'
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
        Top = 44
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
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
        Left = 226
        Top = 44
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB02'
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
        Top = 66
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
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
        Left = 226
        Top = 66
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB03'
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
        Top = 88
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
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
        Left = 226
        Top = 88
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB04'
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
        Top = 110
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
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
        Left = 226
        Top = 110
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB05'
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
        Top = 132
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
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
        Left = 226
        Top = 132
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB06'
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
        Top = 154
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
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
        Left = 226
        Top = 154
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB07'
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
        Top = 176
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
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
        Left = 226
        Top = 176
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB08'
        TabOrder = 22
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
        Top = 198
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
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
        Left = 226
        Top = 198
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB09'
        TabOrder = 25
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
        Top = 220
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
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
        Left = 226
        Top = 220
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB10'
        TabOrder = 28
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
        Left = 472
        Top = 22
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        TabOrder = 30
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm12: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 44
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        TabOrder = 33
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm13: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 66
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
        TabOrder = 36
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 88
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        TabOrder = 39
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm15: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 110
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        TabOrder = 42
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm16: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 132
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB16'
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
        Left = 472
        Top = 154
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB17'
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
        Left = 472
        Top = 176
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB18'
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
        Left = 472
        Top = 198
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB19'
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
        Left = 472
        Top = 220
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB20'
        TabOrder = 57
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
        Left = 621
        Top = 22
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB11'
        TabOrder = 31
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC12: TDBEditFocus
        Tag = 99
        Left = 621
        Top = 44
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB12'
        TabOrder = 34
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC13: TDBEditFocus
        Tag = 99
        Left = 621
        Top = 66
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB13'
        TabOrder = 37
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC14: TDBEditFocus
        Tag = 99
        Left = 621
        Top = 88
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB14'
        TabOrder = 40
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC15: TDBEditFocus
        Tag = 99
        Left = 621
        Top = 110
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB15'
        TabOrder = 43
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC16: TDBEditFocus
        Tag = 99
        Left = 621
        Top = 132
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB16'
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
        Left = 621
        Top = 154
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB17'
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
        Left = 621
        Top = 176
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB18'
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
        Left = 621
        Top = 198
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB19'
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
        Left = 621
        Top = 220
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB20'
        TabOrder = 58
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
        Left = 733
        Top = 22
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD11'
        TabOrder = 32
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
        Left = 733
        Top = 44
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD12'
        TabOrder = 35
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
        Left = 733
        Top = 66
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD13'
        TabOrder = 38
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
        Left = 733
        Top = 88
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD14'
        TabOrder = 41
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
        Left = 733
        Top = 110
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD15'
        TabOrder = 44
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
        Left = 733
        Top = 132
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD16'
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
        Left = 733
        Top = 154
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD17'
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
        Left = 733
        Top = 176
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD18'
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
        Left = 733
        Top = 198
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD19'
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
        Left = 733
        Top = 220
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD20'
        TabOrder = 59
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
        Left = 340
        Top = 22
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD01'
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
        Left = 340
        Top = 44
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD02'
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
        Left = 340
        Top = 66
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD03'
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
        Left = 340
        Top = 88
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD04'
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
        Left = 340
        Top = 110
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD05'
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
        Left = 340
        Top = 132
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD06'
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
        Left = 340
        Top = 154
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD07'
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
        Left = 340
        Top = 176
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD08'
        TabOrder = 23
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
        Left = 340
        Top = 198
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD09'
        TabOrder = 26
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
        Left = 340
        Top = 220
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD10'
        TabOrder = 29
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
      Left = 385
      Top = 44
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha_: TDBComboBoxFocus
      Tag = 99
      Left = 600
      Top = 44
      Width = 89
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'NFM_LINHA_'
      Items.Strings = (
        'Salcomix'
        'S326'
        'S850'
        'S648'
        'S327'
        'S603'
        'S325'
        '525'
        '729')
      TabOrder = 1
      OnChange = dbeLinha_Change
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbchkAtivo: TDBCheckBox
      Left = 290
      Top = 109
      Width = 48
      Height = 17
      Caption = 'Ativa'
      DataField = 'NFM_ATIVO_'
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 156
      Top = 104
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 797
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Salcomix'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 760
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 760
    Top = 120
  end
end
