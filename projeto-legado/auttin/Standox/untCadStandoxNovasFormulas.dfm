inherited frmCadStandoxNovasFormulas: TfrmCadStandoxNovasFormulas
  Left = 184
  Top = 162
  Width = 632
  Height = 517
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Standox'
  ExplicitTop = -150
  ExplicitWidth = 632
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 14
  object Label38: TLabel [0]
    Left = 422
    Top = 88
    Width = 57
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Categoria:'
  end
  object Label74: TLabel [1]
    Left = 570
    Top = 62
    Width = 43
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Linha:'
  end
  inherited pnlBotoes: TPanel
    Top = 449
    Width = 626
    ExplicitTop = 449
    ExplicitWidth = 626
    inherited btnSair: TBitBtnLocked
      Left = 549
      TabOrder = 7
      ExplicitLeft = 549
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
  end
  inherited pnlStatus: TPanel
    Top = 477
    Width = 626
    ExplicitTop = 477
    ExplicitWidth = 626
    inherited pnlNomeForm: TPanel
      Left = 279
      ExplicitLeft = 279
    end
    inherited pnlInfo: TPanel
      Width = 279
      ExplicitWidth = 279
    end
  end
  inherited pgcDados: TPageControl
    Width = 626
    Height = 449
    ExplicitWidth = 626
    ExplicitHeight = 449
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 618
      ExplicitHeight = 417
    end
  end
  object pnlCentral: TPanel [5]
    Left = 0
    Top = 0
    Width = 626
    Height = 449
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 54
      Top = 40
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 54
      Top = 62
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 214
      Top = 40
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label39: TLabel
      Left = 54
      Top = 107
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Qualidade:'
    end
    object Label41: TLabel
      Left = 54
      Top = 130
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Montadora:'
    end
    object Label3: TLabel
      Left = 499
      Top = 107
      Width = 44
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Vers'#227'o:'
    end
    object Label5: TLabel
      Left = 54
      Top = 86
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ano inicial:'
    end
    object Label6: TLabel
      Left = 186
      Top = 86
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ano final:'
    end
    object Label27: TLabel
      Left = 326
      Top = 86
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Categoria:'
    end
    object Label40: TLabel
      Left = 355
      Top = 107
      Width = 36
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pa'#237's:'
    end
    object Label72: TLabel
      Left = 486
      Top = 86
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Variante:'
    end
    object Label28: TLabel
      Left = 4
      Top = 155
      Width = 107
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Acr'#233'sc. m'#227'o de obra:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 624
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Standox'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 14
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 36
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Left = 114
      Top = 58
      Width = 501
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Top = 180
      Width = 744
      Height = 263
      Caption = '     Bases      '
      TabOrder = 13
      object Label7: TLabel
        Left = 53
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 181
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label9: TLabel
        Left = 53
        Top = 50
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label11: TLabel
        Left = 53
        Top = 74
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label13: TLabel
        Left = 53
        Top = 98
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label15: TLabel
        Left = 53
        Top = 122
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label17: TLabel
        Left = 51
        Top = 146
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label19: TLabel
        Left = 51
        Top = 170
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label21: TLabel
        Left = 51
        Top = 194
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label10: TLabel
        Left = 181
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label12: TLabel
        Left = 181
        Top = 74
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label14: TLabel
        Left = 181
        Top = 98
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label16: TLabel
        Left = 181
        Top = 122
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label18: TLabel
        Left = 181
        Top = 146
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label20: TLabel
        Left = 181
        Top = 170
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label22: TLabel
        Left = 181
        Top = 194
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label42: TLabel
        Left = 53
        Top = 218
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label43: TLabel
        Left = 181
        Top = 218
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label45: TLabel
        Left = 53
        Top = 242
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label46: TLabel
        Left = 181
        Top = 242
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label48: TLabel
        Left = 315
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label49: TLabel
        Left = 443
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label51: TLabel
        Left = 315
        Top = 50
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label52: TLabel
        Left = 443
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label54: TLabel
        Left = 315
        Top = 74
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label55: TLabel
        Left = 443
        Top = 74
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label57: TLabel
        Left = 315
        Top = 98
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label58: TLabel
        Left = 443
        Top = 98
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label60: TLabel
        Left = 315
        Top = 122
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label61: TLabel
        Left = 443
        Top = 122
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label24: TLabel
        Left = 315
        Top = 146
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 16:'
      end
      object Label25: TLabel
        Left = 315
        Top = 170
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 17:'
      end
      object Label23: TLabel
        Left = 315
        Top = 194
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 18:'
      end
      object Label26: TLabel
        Left = 315
        Top = 218
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 19:'
      end
      object Label36: TLabel
        Left = 315
        Top = 242
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 20:'
      end
      object Label37: TLabel
        Left = 443
        Top = 146
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label63: TLabel
        Left = 443
        Top = 170
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label64: TLabel
        Left = 443
        Top = 194
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label65: TLabel
        Left = 443
        Top = 218
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label66: TLabel
        Left = 443
        Top = 242
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 113
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
        Left = 249
        Top = 22
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC01'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm02: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 46
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
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
        Left = 249
        Top = 46
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC02'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm03: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 70
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
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
        Left = 249
        Top = 70
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC03'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm04: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 94
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
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
      object dbeQtdC04: TDBEditFocus
        Tag = 99
        Left = 249
        Top = 94
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC04'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm05: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 118
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
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
        Left = 249
        Top = 118
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC05'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm06: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 142
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
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
        Left = 249
        Top = 142
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC06'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm07: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 166
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
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
      object dbeQtdC07: TDBEditFocus
        Tag = 99
        Left = 249
        Top = 166
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC07'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm08: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 190
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
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
        Left = 249
        Top = 190
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC08'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm09: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 214
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 16
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
        Left = 249
        Top = 214
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC09'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm10: TDBEditFocus
        Tag = 99
        Left = 113
        Top = 238
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
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
      object dbeQtdC10: TDBEditFocus
        Tag = 99
        Left = 249
        Top = 238
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC10'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm11: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 20
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
        Left = 511
        Top = 22
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC11'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm12: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 46
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 22
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
        Left = 511
        Top = 46
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC12'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm13: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 70
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
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
      object dbeQtdC13: TDBEditFocus
        Tag = 99
        Left = 511
        Top = 70
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC13'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 94
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 26
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
        Left = 511
        Top = 94
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC14'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 27
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm15: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 118
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 28
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
        Left = 511
        Top = 118
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC15'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 29
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm16: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 142
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB16'
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
      object dbeForm17: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 166
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB17'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 32
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
        Left = 375
        Top = 190
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB18'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 34
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
        Left = 375
        Top = 214
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB19'
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
      object dbeForm20: TDBEditFocus
        Tag = 99
        Left = 375
        Top = 237
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB20'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 38
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
        Left = 511
        Top = 142
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC16'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 31
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC17: TDBEditFocus
        Tag = 99
        Left = 511
        Top = 166
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC17'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 33
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC18: TDBEditFocus
        Tag = 99
        Left = 511
        Top = 190
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC18'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 35
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC19: TDBEditFocus
        Tag = 99
        Left = 511
        Top = 214
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC19'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 37
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC20: TDBEditFocus
        Tag = 99
        Left = 511
        Top = 238
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC20'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 39
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
      Left = 298
      Top = 36
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQualid: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 103
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_QUALID'
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
      Left = 114
      Top = 126
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_MONTAD'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbchkAtivo: TDBCheckBox
      Left = 547
      Top = 131
      Width = 48
      Height = 17
      Caption = 'Ativa'
      DataField = 'NFM_ATIVO_'
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeAnoFin: TDBEditFocus
      Tag = 99
      Left = 249
      Top = 80
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ANOFIN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCatego: TDBEditFocus
      Tag = 99
      Left = 386
      Top = 80
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CATEGO'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAnoIni: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 80
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ANOINI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeVarian: TDBEditFocus
      Tag = 99
      Left = 546
      Top = 80
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_VARIAN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePais: TDBEditFocus
      Tag = 99
      Left = 399
      Top = 103
      Width = 91
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_PAIS__'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVersao: TDBEditFocus
      Tag = 99
      Left = 546
      Top = 103
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_VERSAO'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 149
      Width = 91
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 24
  end
end
