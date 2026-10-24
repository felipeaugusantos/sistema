inherited frmCadGerNfm: TfrmCadGerNfm
  Left = 323
  Top = 179
  Width = 534
  Height = 430
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Novas F'#243'rmulas - General'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 359
    Width = 526
    DesignSize = (
      526
      28)
    inherited btnSair: TBitBtn
      Left = 451
    end
  end
  inherited pnlStatus: TPanel
    Top = 387
    Width = 526
    inherited pnlNomeForm: TPanel
      Left = 179
    end
    inherited pnlInfo: TPanel
      Width = 179
    end
  end
  inherited pgcDados: TPageControl
    Width = 526
    Height = 359
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 526
    Height = 359
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    object Label2: TLabel
      Left = 20
      Top = 35
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label1: TLabel
      Left = 129
      Top = 35
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Varia'#231#227'o:'
    end
    object Label3: TLabel
      Left = 4
      Top = 59
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label4: TLabel
      Left = 2
      Top = 83
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object Label5: TLabel
      Left = 4
      Top = 107
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano Inicial:'
    end
    object Label6: TLabel
      Left = 128
      Top = 107
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano Final:'
    end
    object Label8: TLabel
      Left = 249
      Top = 35
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vers'#227'o:'
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 526
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - General'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
    end
    object dbeCodigo: TDBEditFocus
      Left = 64
      Top = 32
      Width = 57
      Height = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVariac: TDBEditFocus
      Left = 184
      Top = 32
      Width = 57
      Height = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Left = 64
      Top = 56
      Width = 289
      Height = 20
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMon: TDBEditFocus
      Left = 64
      Top = 80
      Width = 57
      Height = 20
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAnoIni: TDBEditFocus
      Left = 64
      Top = 104
      Width = 57
      Height = 20
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAnoFin: TDBEditFocus
      Left = 184
      Top = 104
      Width = 57
      Height = 20
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVersao: TDBEditFocus
      Left = 296
      Top = 32
      Width = 57
      Height = 20
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus8: TEditFocus
      Left = 128
      Top = 80
      Width = 225
      Height = 20
      TabOrder = 5
      Text = 'edtDesMon'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object dbcNacional: TDBCheckBox
      Left = 248
      Top = 106
      Width = 65
      Height = 17
      Caption = 'Nacional'
      TabOrder = 8
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object gbFormula: TGroupBox
      Left = 8
      Top = 128
      Width = 513
      Height = 225
      Caption = 'F'#243'rmula'
      TabOrder = 10
      object Label7: TLabel
        Left = 12
        Top = 19
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label9: TLabel
        Left = 110
        Top = 19
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label10: TLabel
        Left = 12
        Top = 43
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label11: TLabel
        Left = 110
        Top = 43
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label12: TLabel
        Left = 12
        Top = 67
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label13: TLabel
        Left = 110
        Top = 67
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label14: TLabel
        Left = 12
        Top = 91
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label15: TLabel
        Left = 110
        Top = 91
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label16: TLabel
        Left = 12
        Top = 115
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label17: TLabel
        Left = 110
        Top = 115
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label18: TLabel
        Left = 12
        Top = 139
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label19: TLabel
        Left = 110
        Top = 139
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label20: TLabel
        Left = 12
        Top = 163
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label21: TLabel
        Left = 110
        Top = 163
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label22: TLabel
        Left = 12
        Top = 187
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label23: TLabel
        Left = 110
        Top = 187
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label24: TLabel
        Left = 244
        Top = 19
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label25: TLabel
        Left = 342
        Top = 19
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label26: TLabel
        Left = 244
        Top = 43
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label27: TLabel
        Left = 342
        Top = 43
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label28: TLabel
        Left = 244
        Top = 67
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label29: TLabel
        Left = 342
        Top = 67
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label30: TLabel
        Left = 244
        Top = 91
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label31: TLabel
        Left = 342
        Top = 91
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label32: TLabel
        Left = 244
        Top = 115
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label33: TLabel
        Left = 342
        Top = 115
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label34: TLabel
        Left = 244
        Top = 139
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label35: TLabel
        Left = 342
        Top = 139
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label36: TLabel
        Left = 244
        Top = 163
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base:'
      end
      object Label37: TLabel
        Left = 342
        Top = 163
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object DBEditFocus1: TDBEditFocus
        Left = 48
        Top = 16
        Width = 57
        Height = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus2: TDBEditFocus
        Left = 176
        Top = 16
        Width = 57
        Height = 20
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus3: TDBEditFocus
        Left = 48
        Top = 40
        Width = 57
        Height = 20
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus4: TDBEditFocus
        Left = 176
        Top = 40
        Width = 57
        Height = 20
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus5: TDBEditFocus
        Left = 48
        Top = 64
        Width = 57
        Height = 20
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus6: TDBEditFocus
        Left = 176
        Top = 64
        Width = 57
        Height = 20
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus7: TDBEditFocus
        Left = 48
        Top = 88
        Width = 57
        Height = 20
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus9: TDBEditFocus
        Left = 176
        Top = 88
        Width = 57
        Height = 20
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus10: TDBEditFocus
        Left = 48
        Top = 112
        Width = 57
        Height = 20
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus11: TDBEditFocus
        Left = 176
        Top = 112
        Width = 57
        Height = 20
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus12: TDBEditFocus
        Left = 48
        Top = 136
        Width = 57
        Height = 20
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus13: TDBEditFocus
        Left = 176
        Top = 136
        Width = 57
        Height = 20
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus14: TDBEditFocus
        Left = 48
        Top = 160
        Width = 57
        Height = 20
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus15: TDBEditFocus
        Left = 176
        Top = 160
        Width = 57
        Height = 20
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus16: TDBEditFocus
        Left = 48
        Top = 184
        Width = 57
        Height = 20
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus17: TDBEditFocus
        Left = 176
        Top = 184
        Width = 57
        Height = 20
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus18: TDBEditFocus
        Left = 280
        Top = 16
        Width = 57
        Height = 20
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus19: TDBEditFocus
        Left = 408
        Top = 16
        Width = 57
        Height = 20
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus20: TDBEditFocus
        Left = 280
        Top = 40
        Width = 57
        Height = 20
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus21: TDBEditFocus
        Left = 408
        Top = 40
        Width = 57
        Height = 20
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus22: TDBEditFocus
        Left = 280
        Top = 64
        Width = 57
        Height = 20
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus23: TDBEditFocus
        Left = 408
        Top = 64
        Width = 57
        Height = 20
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus24: TDBEditFocus
        Left = 280
        Top = 88
        Width = 57
        Height = 20
        TabOrder = 22
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus25: TDBEditFocus
        Left = 408
        Top = 88
        Width = 57
        Height = 20
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus26: TDBEditFocus
        Left = 280
        Top = 112
        Width = 57
        Height = 20
        TabOrder = 24
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus27: TDBEditFocus
        Left = 408
        Top = 112
        Width = 57
        Height = 20
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus28: TDBEditFocus
        Left = 280
        Top = 136
        Width = 57
        Height = 20
        TabOrder = 26
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus29: TDBEditFocus
        Left = 408
        Top = 136
        Width = 57
        Height = 20
        TabOrder = 27
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus30: TDBEditFocus
        Left = 280
        Top = 160
        Width = 57
        Height = 20
        TabOrder = 28
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus31: TDBEditFocus
        Left = 408
        Top = 160
        Width = 57
        Height = 20
        TabOrder = 29
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
    Left = 376
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
end
