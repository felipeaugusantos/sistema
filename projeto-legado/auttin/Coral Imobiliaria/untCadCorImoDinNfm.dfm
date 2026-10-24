inherited frmCadCorImoDinNfm: TfrmCadCorImoDinNfm
  Left = 123
  Top = 169
  Width = 546
  Height = 330
  Caption = 'Cadastro de Novas F'#243'rmulas'
  Ctl3D = False
  ExplicitWidth = 546
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 258
    Width = 540
    ExplicitTop = 258
    ExplicitWidth = 540
    DesignSize = (
      540
      28)
    inherited btnSair: TBitBtnLocked
      Left = 463
      ExplicitLeft = 463
    end
  end
  inherited pnlStatus: TPanel
    Top = 286
    Width = 540
    ExplicitTop = 286
    ExplicitWidth = 540
    inherited pnlNomeForm: TPanel
      Left = 193
      ExplicitLeft = 193
    end
    inherited pnlInfo: TPanel
      Width = 193
      ExplicitWidth = 193
    end
  end
  inherited pgcDados: TPageControl
    Width = 540
    Height = 258
    ExplicitWidth = 540
    ExplicitHeight = 258
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 532
      ExplicitHeight = 226
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 540
    Height = 258
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 32
      Top = 19
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 40
      Top = 43
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object Label3: TLabel
      Left = 132
      Top = 43
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label4: TLabel
      Left = 362
      Top = 43
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label5: TLabel
      Left = 16
      Top = 91
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 11
      Top = 67
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label7: TLabel
      Left = 138
      Top = 67
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label8: TLabel
      Left = 306
      Top = 67
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object dbeCodigo: TDBEditFocus
      Left = 72
      Top = 16
      Width = 98
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 40
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnKeyPress = dbeCodBasKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProd: TDBEditFocus
      Tag = 99
      Left = 176
      Top = 40
      Width = 177
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbeCodBasKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnid: TDBEditFocus
      Tag = 99
      Left = 408
      Top = 40
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnKeyPress = dbeCodBasKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 88
      Width = 225
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 64
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnExit = dbeEmbalaExit
      OnKeyPress = dbeEmbalaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEmb: TEditFocus
      Tag = 99
      Left = 200
      Top = 64
      Width = 97
      Height = 20
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUniEmb: TEditFocus
      Tag = 99
      Left = 352
      Top = 64
      Width = 57
      Height = 20
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 116
      Width = 540
      Height = 142
      Align = alBottom
      Caption = 'Formula'#231#227'o'
      TabOrder = 8
      object Label9: TLabel
        Left = 12
        Top = 19
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 01:'
      end
      object Label10: TLabel
        Left = 12
        Top = 43
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 02:'
      end
      object Label11: TLabel
        Left = 12
        Top = 67
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 03:'
      end
      object Label12: TLabel
        Left = 12
        Top = 91
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 04:'
      end
      object Label13: TLabel
        Left = 12
        Top = 115
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 05:'
      end
      object Label15: TLabel
        Left = 146
        Top = 19
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label16: TLabel
        Left = 146
        Top = 43
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label17: TLabel
        Left = 146
        Top = 67
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label18: TLabel
        Left = 146
        Top = 91
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label19: TLabel
        Left = 146
        Top = 115
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label21: TLabel
        Left = 276
        Top = 19
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 06:'
      end
      object Label22: TLabel
        Left = 276
        Top = 43
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 07:'
      end
      object Label23: TLabel
        Left = 276
        Top = 67
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 08:'
      end
      object Label24: TLabel
        Left = 276
        Top = 91
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 09:'
      end
      object Label25: TLabel
        Left = 276
        Top = 115
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 10:'
      end
      object Label28: TLabel
        Left = 410
        Top = 115
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label29: TLabel
        Left = 410
        Top = 91
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label30: TLabel
        Left = 410
        Top = 67
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label31: TLabel
        Left = 410
        Top = 43
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label32: TLabel
        Left = 410
        Top = 19
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 16
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm02: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 40
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm03: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 64
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm04: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 88
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm05: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 112
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeQtd01: TDBEditFocus
        Tag = 99
        Left = 208
        Top = 16
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd02: TDBEditFocus
        Tag = 99
        Left = 208
        Top = 40
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd03: TDBEditFocus
        Tag = 99
        Left = 208
        Top = 64
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd04: TDBEditFocus
        Tag = 99
        Left = 208
        Top = 88
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd05: TDBEditFocus
        Tag = 99
        Left = 208
        Top = 112
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
        Left = 344
        Top = 16
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm07: TDBEditFocus
        Tag = 99
        Left = 344
        Top = 40
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm08: TDBEditFocus
        Tag = 99
        Left = 344
        Top = 64
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm09: TDBEditFocus
        Tag = 99
        Left = 344
        Top = 88
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeForm10: TDBEditFocus
        Tag = 99
        Left = 344
        Top = 112
        Width = 57
        Height = 20
        CharCase = ecUpperCase
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
      object dbeQtd10: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 112
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtd09: TDBEditFocus
        Tag = 99
        Left = 472
        Top = 88
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 472
        Top = 64
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 472
        Top = 40
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 472
        Top = 16
        Width = 57
        Height = 20
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 8
  end
end
