inherited frmCadRennerIndustrialDinNfm: TfrmCadRennerIndustrialDinNfm
  Left = 123
  Top = 169
  Width = 610
  Height = 364
  Caption = 'Cadastro de Novas F'#243'rmulas - Renner Industrial'
  Ctl3D = False
  ExplicitWidth = 610
  ExplicitHeight = 364
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 292
    Width = 604
    ExplicitTop = 292
    ExplicitWidth = 604
    DesignSize = (
      604
      28)
    inherited btnSair: TBitBtnLocked
      Left = 527
      ExplicitLeft = 527
    end
    object btnAtivarNfm: TBitBtnLocked
      Left = 442
      Top = 4
      Width = 75
      Height = 20
      Caption = 'Ativar'
      TabOrder = 7
      OnClick = btnAtivarNfmClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 604
    Height = 292
    ExplicitWidth = 604
    ExplicitHeight = 292
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 596
      ExplicitHeight = 260
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 604
    Height = 292
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 32
      Top = 43
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 40
      Top = 67
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object Label3: TLabel
      Left = 137
      Top = 67
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label4: TLabel
      Left = 413
      Top = 67
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label5: TLabel
      Left = 16
      Top = 115
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 11
      Top = 91
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label7: TLabel
      Left = 189
      Top = 91
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label8: TLabel
      Left = 357
      Top = 91
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label55: TLabel
      Left = 352
      Top = 43
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object dbeCodigo: TDBEditFocus
      Left = 72
      Top = 40
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
      Top = 64
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
      Left = 181
      Top = 64
      Width = 223
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
      Left = 459
      Top = 64
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
      Top = 111
      Width = 276
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
      Top = 88
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
      Left = 251
      Top = 88
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
      Left = 403
      Top = 88
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
      Top = 150
      Width = 604
      Height = 142
      Align = alBottom
      Caption = 'Formula'#231#227'o'
      TabOrder = 9
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
        Left = 316
        Top = 19
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 06:'
      end
      object Label22: TLabel
        Left = 316
        Top = 43
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 07:'
      end
      object Label23: TLabel
        Left = 316
        Top = 67
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 08:'
      end
      object Label24: TLabel
        Left = 316
        Top = 91
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 09:'
      end
      object Label25: TLabel
        Left = 316
        Top = 115
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Colorante 10:'
      end
      object Label28: TLabel
        Left = 450
        Top = 115
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label29: TLabel
        Left = 450
        Top = 91
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label30: TLabel
        Left = 450
        Top = 67
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label31: TLabel
        Left = 450
        Top = 43
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label32: TLabel
        Left = 450
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
        Left = 384
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
        Left = 384
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
        Left = 384
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
        Left = 384
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
        Left = 384
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
        Left = 512
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
        Left = 512
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
        Left = 512
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
        Left = 512
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
        Left = 512
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
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 604
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Renner Industrial'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 10
    end
    object dbcAtivo: TDBCheckBox
      Left = 459
      Top = 114
      Width = 49
      Height = 17
      Caption = 'Ativa'
      TabOrder = 8
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 431
      Top = 40
      Width = 85
      Height = 20
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 320
    Width = 604
    ExplicitTop = 320
    ExplicitWidth = 604
    inherited pnlNomeForm: TPanel
      Left = 257
      ExplicitLeft = 257
    end
    inherited pnlInfo: TPanel
      Width = 257
      ExplicitWidth = 257
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 8
  end
end
