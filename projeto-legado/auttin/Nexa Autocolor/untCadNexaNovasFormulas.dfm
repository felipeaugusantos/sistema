inherited frmCadNexaNovasFormulas: TfrmCadNexaNovasFormulas
  Left = 288
  Top = 194
  Width = 654
  Height = 554
  Caption = 'Cadastro de Novas F'#243'rmulas - Nexa Autocolor'
  ExplicitWidth = 654
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 481
    Width = 648
    ExplicitTop = 481
    ExplicitWidth = 648
    inherited btnSair: TBitBtnLocked
      Left = 571
      ExplicitLeft = 571
    end
    inherited btnPesquisa: TBitBtnLocked
      Width = 81
      ExplicitWidth = 81
    end
    object btnAtivarNfm: TBitBtnLocked
      Left = 452
      Top = 4
      Width = 75
      Height = 20
      Caption = 'Ativar'
      TabOrder = 7
      OnClick = btnAtivarNfmClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 509
    Width = 648
    ExplicitTop = 509
    ExplicitWidth = 648
    inherited pnlNomeForm: TPanel
      Left = 301
      ExplicitLeft = 301
    end
    inherited pnlInfo: TPanel
      Width = 301
      ExplicitWidth = 301
    end
  end
  inherited pgcDados: TPageControl
    Width = 648
    Height = 481
    ExplicitWidth = 648
    ExplicitHeight = 481
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 640
      ExplicitHeight = 449
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 648
    Height = 481
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    object Label1: TLabel
      Left = 69
      Top = 37
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 53
      Top = 61
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 51
      Top = 110
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object Label4: TLabel
      Left = 62
      Top = 85
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Variante:'
    end
    object Label5: TLabel
      Left = 237
      Top = 87
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano In'#237'cio:'
    end
    object Label6: TLabel
      Left = 385
      Top = 110
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label7: TLabel
      Left = 67
      Top = 136
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo:'
    end
    object Label10: TLabel
      Left = 2
      Top = 166
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'Acr'#233'sc. m'#227'o de obra:'
    end
    object Label28: TLabel
      Left = 311
      Top = 38
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object dbeCodigo: TDBEditFocus
      Left = 113
      Top = 34
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 113
      Top = 58
      Width = 496
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMontadora: TDBEditFocus
      Tag = 99
      Left = 113
      Top = 107
      Width = 33
      Height = 20
      CharCase = ecUpperCase
      ReadOnly = True
      TabOrder = 4
      OnExit = dbeMontadoraExit
      OnKeyPress = dbeMontadoraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVariante: TDBEditFocus
      Tag = 99
      Left = 113
      Top = 82
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAnoInicio: TDBEditFocus
      Tag = 99
      Left = 295
      Top = 84
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipo: TDBEditFocus
      Tag = 99
      Left = 414
      Top = 107
      Width = 198
      Height = 20
      CharCase = ecUpperCase
      ReadOnly = True
      TabOrder = 6
      OnKeyPress = dbeTipoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVeiculo: TDBEditFocus
      Tag = 99
      Left = 113
      Top = 133
      Width = 258
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 12
      Top = 194
      Width = 629
      Height = 281
      Caption = ' Formula'#231#227'o 1 Litro '
      TabOrder = 9
      object Label9: TLabel
        Left = 180
        Top = 34
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl1: TLabel
        Left = 8
        Top = 34
        Width = 43
        Height = 14
        Caption = 'Base 01:'
      end
      object lbl2: TLabel
        Left = 8
        Top = 58
        Width = 43
        Height = 14
        Caption = 'Base 02:'
      end
      object lbl3: TLabel
        Left = 8
        Top = 82
        Width = 43
        Height = 14
        Caption = 'Base 03:'
      end
      object lbl4: TLabel
        Left = 8
        Top = 108
        Width = 43
        Height = 14
        Caption = 'Base 04:'
      end
      object lbl5: TLabel
        Left = 8
        Top = 130
        Width = 43
        Height = 14
        Caption = 'Base 05:'
      end
      object lbl6: TLabel
        Left = 8
        Top = 154
        Width = 43
        Height = 14
        Caption = 'Base 06:'
      end
      object lbl7: TLabel
        Left = 8
        Top = 178
        Width = 43
        Height = 14
        Caption = 'Base 07:'
      end
      object lbl8: TLabel
        Left = 8
        Top = 202
        Width = 43
        Height = 14
        Caption = 'Base 08:'
      end
      object lbl9: TLabel
        Left = 8
        Top = 226
        Width = 43
        Height = 14
        Caption = 'Base 09:'
      end
      object lbl10: TLabel
        Left = 8
        Top = 250
        Width = 43
        Height = 14
        Caption = 'Base 10:'
      end
      object lbl11: TLabel
        Left = 180
        Top = 58
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl12: TLabel
        Left = 180
        Top = 82
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl13: TLabel
        Left = 180
        Top = 108
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl14: TLabel
        Left = 180
        Top = 130
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl15: TLabel
        Left = 180
        Top = 154
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl16: TLabel
        Left = 180
        Top = 178
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl17: TLabel
        Left = 180
        Top = 202
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl18: TLabel
        Left = 180
        Top = 226
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl19: TLabel
        Left = 180
        Top = 250
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl20: TLabel
        Left = 494
        Top = 34
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl21: TLabel
        Left = 322
        Top = 34
        Width = 42
        Height = 14
        Caption = 'Base 11:'
      end
      object lbl22: TLabel
        Left = 322
        Top = 58
        Width = 43
        Height = 14
        Caption = 'Base 12:'
      end
      object lbl23: TLabel
        Left = 322
        Top = 82
        Width = 43
        Height = 14
        Caption = 'Base 13:'
      end
      object lbl24: TLabel
        Left = 322
        Top = 108
        Width = 43
        Height = 14
        Caption = 'Base 14:'
      end
      object lbl25: TLabel
        Left = 322
        Top = 130
        Width = 43
        Height = 14
        Caption = 'Base 15:'
      end
      object lbl26: TLabel
        Left = 322
        Top = 154
        Width = 43
        Height = 14
        Caption = 'Base 16:'
      end
      object lbl27: TLabel
        Left = 322
        Top = 178
        Width = 43
        Height = 14
        Caption = 'Base 17:'
      end
      object lbl28: TLabel
        Left = 322
        Top = 202
        Width = 43
        Height = 14
        Caption = 'Base 18:'
      end
      object lbl29: TLabel
        Left = 322
        Top = 226
        Width = 43
        Height = 14
        Caption = 'Base 19:'
      end
      object lbl30: TLabel
        Left = 322
        Top = 250
        Width = 43
        Height = 14
        Caption = 'Base 20:'
      end
      object lbl31: TLabel
        Left = 494
        Top = 58
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl32: TLabel
        Left = 494
        Top = 82
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl33: TLabel
        Left = 494
        Top = 108
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl34: TLabel
        Left = 494
        Top = 130
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl35: TLabel
        Left = 494
        Top = 154
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl36: TLabel
        Left = 494
        Top = 178
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl37: TLabel
        Left = 494
        Top = 202
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl38: TLabel
        Left = 494
        Top = 226
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lbl39: TLabel
        Left = 494
        Top = 250
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 32
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm02: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 56
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 2
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm03: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 80
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 4
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm04: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 104
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 6
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm05: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 128
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 8
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm06: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 152
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 10
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm07: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 176
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 12
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm08: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 200
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 14
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm09: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 224
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 16
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm10: TDBEditFocus
        Tag = 99
        Left = 53
        Top = 248
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 18
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd10: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 248
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 19
        OnKeyPress = dbeQtd10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd09: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 224
        Width = 60
        Height = 20
        HelpContext = 17
        CharCase = ecUpperCase
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd08: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 200
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd07: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 176
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd06: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 152
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd05: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 128
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd04: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 104
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd03: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 78
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd02: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 56
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd01: TDBEditFocus
        Tag = 99
        Left = 240
        Top = 32
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm11: TDBEditFocus
        Tag = 99
        Left = 367
        Top = 32
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 20
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
        Left = 367
        Top = 56
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 22
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
        Left = 367
        Top = 80
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 24
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
        Left = 367
        Top = 104
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 26
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
        Left = 367
        Top = 128
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 28
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
        Left = 367
        Top = 152
        Width = 121
        Height = 20
        CharCase = ecUpperCase
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
        Left = 367
        Top = 176
        Width = 121
        Height = 20
        CharCase = ecUpperCase
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
        Left = 367
        Top = 200
        Width = 121
        Height = 20
        CharCase = ecUpperCase
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
        Left = 367
        Top = 224
        Width = 121
        Height = 20
        CharCase = ecUpperCase
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
        Left = 367
        Top = 248
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 38
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd20: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 248
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 39
        OnKeyPress = dbeQtd10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd19: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 224
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 37
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd18: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 200
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 35
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd17: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 176
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 33
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd16: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 152
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 31
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd15: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 128
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 29
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd14: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 104
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 27
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd13: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 80
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd12: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 56
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd11: TDBEditFocus
        Tag = 99
        Left = 554
        Top = 32
        Width = 60
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object edtDescMon: TEditFocus
      Left = 153
      Top = 107
      Width = 218
      Height = 20
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 648
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - NEXA'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 648
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Cadastro de Novas F'#243'rmulas - Nexa Autocolor'
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
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 113
      Top = 162
      Width = 80
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbchkAtivo: TDBCheckBox
      Left = 223
      Top = 164
      Width = 97
      Height = 17
      Caption = 'Ativar'
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 388
      Top = 34
      Width = 85
      Height = 20
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 840
    Top = 120
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 48
  end
end
