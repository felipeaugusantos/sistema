inherited frmCadFutNovasFormulasDin: TfrmCadFutNovasFormulasDin
  Left = 301
  Top = 216
  Width = 534
  Height = 354
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Futura'
  ExplicitWidth = 534
  ExplicitHeight = 354
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 286
    Width = 528
    ExplicitTop = 286
    ExplicitWidth = 528
    inherited btnSair: TBitBtnLocked
      Left = 451
      ExplicitLeft = 451
    end
  end
  inherited pnlStatus: TPanel
    Top = 314
    Width = 528
    ExplicitTop = 314
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 181
      ExplicitLeft = 181
    end
    inherited pnlInfo: TPanel
      Width = 181
      ExplicitWidth = 181
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 286
    ExplicitWidth = 528
    ExplicitHeight = 286
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 254
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 286
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 6
      Top = 34
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo Form.:'
    end
    object Label3: TLabel
      Left = 22
      Top = 58
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 22
      Top = 108
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 174
      Top = 58
      Width = 33
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base:'
    end
    object Label6: TLabel
      Left = 374
      Top = 58
      Width = 49
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object Label27: TLabel
      Left = 22
      Top = 83
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label28: TLabel
      Left = 1080
      Top = 106
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sub Produto:'
      Visible = False
    end
    object dbeCodNfm: TDBEditFocus
      Tag = 99
      Left = 82
      Top = 30
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
      Left = 82
      Top = 104
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 133
      Width = 526
      Height = 152
      Align = alBottom
      Caption = '     Colorantes      '
      TabOrder = 7
      object Label7: TLabel
        Left = 8
        Top = 27
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 120
        Top = 27
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
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
      object Label10: TLabel
        Left = 120
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label11: TLabel
        Left = 8
        Top = 73
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label12: TLabel
        Left = 120
        Top = 73
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
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
        Left = 120
        Top = 97
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label15: TLabel
        Left = 8
        Top = 121
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label16: TLabel
        Left = 120
        Top = 121
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label17: TLabel
        Left = 280
        Top = 27
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 392
        Top = 27
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label19: TLabel
        Left = 280
        Top = 50
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 392
        Top = 50
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label21: TLabel
        Left = 280
        Top = 73
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 392
        Top = 73
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label23: TLabel
        Left = 280
        Top = 97
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 392
        Top = 97
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label25: TLabel
        Left = 280
        Top = 121
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 392
        Top = 121
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label5: TLabel
        Left = 85
        Top = 0
        Width = 225
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Informar a quantidade sempre em litros'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 23
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM01'
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
        Left = 188
        Top = 23
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC01'
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
        Left = 68
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM02'
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
        Left = 188
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC02'
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
        Left = 68
        Top = 69
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM03'
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
        Left = 188
        Top = 69
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC03'
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
        Left = 68
        Top = 93
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM04'
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
        Left = 188
        Top = 93
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC04'
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
        Left = 68
        Top = 117
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM05'
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
        Left = 188
        Top = 117
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC05'
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
        Left = 340
        Top = 23
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM06'
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
        Left = 460
        Top = 23
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC06'
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
        Left = 340
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM07'
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
        Left = 460
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC07'
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
        Left = 340
        Top = 69
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM08'
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
        Left = 460
        Top = 69
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC08'
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
        Left = 340
        Top = 93
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM09'
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
        Left = 460
        Top = 93
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC09'
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
        Left = 340
        Top = 117
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM10'
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
        Left = 460
        Top = 117
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC10'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeCodPro: TDBEditFocus
      Tag = 99
      Left = 82
      Top = 54
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODPRO'
      TabOrder = 1
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 210
      Top = 54
      Width = 141
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESBAS'
      TabOrder = 2
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidad: TDBEditFocus
      Tag = 99
      Left = 426
      Top = 54
      Width = 45
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_UNIDAD'
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProd: TDBEditFocus
      Tag = 99
      Left = 82
      Top = 79
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_PRODUT'
      TabOrder = 4
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSProd: TDBEditFocus
      Tag = 99
      Left = 1156
      Top = 102
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_SPRODU'
      TabOrder = 5
      Visible = False
      OnKeyPress = dbeCodProKeyPress
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
      Width = 526
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Futura'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 8
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 504
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 512
    Top = 88
  end
end
