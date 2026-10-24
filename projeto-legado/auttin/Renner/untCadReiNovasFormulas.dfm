inherited frmCadReiNovasFormulas: TfrmCadReiNovasFormulas
  Left = 235
  Top = 298
  Width = 575
  Height = 298
  Hint = 'frmCadReiNovasFormulas'
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Renner Imobili'#225'ria'
  ExplicitWidth = 575
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 230
    Width = 569
    ExplicitTop = 183
    ExplicitWidth = 569
    inherited btnSair: TBitBtnLocked
      Left = 492
      ExplicitLeft = 492
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 569
    Height = 207
    ExplicitTop = 23
    ExplicitWidth = 569
    ExplicitHeight = 183
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 561
      ExplicitHeight = 151
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 23
    Width = 569
    Height = 207
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitTop = 0
    ExplicitHeight = 183
    object Label2: TLabel
      Left = 16
      Top = 52
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 12
      Top = 76
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label3: TLabel
      Left = 40
      Top = 100
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object Label4: TLabel
      Left = 154
      Top = 100
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label5: TLabel
      Left = 291
      Top = 20
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label6: TLabel
      Left = 426
      Top = 20
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label9: TLabel
      Left = 291
      Top = 68
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label8: TLabel
      Left = 426
      Top = 44
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label7: TLabel
      Left = 291
      Top = 44
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label16: TLabel
      Left = 426
      Top = 140
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label15: TLabel
      Left = 291
      Top = 140
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label14: TLabel
      Left = 426
      Top = 116
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label13: TLabel
      Left = 291
      Top = 116
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label12: TLabel
      Left = 426
      Top = 92
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label11: TLabel
      Left = 291
      Top = 92
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label10: TLabel
      Left = 426
      Top = 68
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label17: TLabel
      Left = 32
      Top = 28
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 48
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeRefere: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 72
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 96
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = dbeBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidade: TDBEditFocus
      Tag = 99
      Left = 200
      Top = 96
      Width = 73
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
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
    object dbeForm01: TDBEditFocus
      Tag = 99
      Left = 344
      Top = 16
      Width = 73
      Height = 22
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
    object dbeQtd01: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 16
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd03: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 64
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm03: TDBEditFocus
      Tag = 99
      Left = 344
      Top = 64
      Width = 73
      Height = 22
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
    object dbeQtd02: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 40
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm02: TDBEditFocus
      Tag = 99
      Left = 344
      Top = 40
      Width = 73
      Height = 22
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
    object dbeQtd06: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 136
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 15
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
      Top = 136
      Width = 73
      Height = 22
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
    object dbeQtd05: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 112
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm05: TDBEditFocus
      Tag = 99
      Left = 344
      Top = 112
      Width = 73
      Height = 22
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
    object dbeQtd04: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 88
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm04: TDBEditFocus
      Tag = 99
      Left = 344
      Top = 88
      Width = 73
      Height = 22
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
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 24
      Width = 73
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 569
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Cadastro de Novas F'#243'rmulas - Renner Imobili'#225'ria'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 521
  end
  inherited pnlStatus: TPanel
    Top = 258
    Width = 569
    ExplicitTop = 211
    ExplicitWidth = 569
    inherited pnlNomeForm: TPanel
      Left = 222
      ExplicitLeft = 222
    end
    inherited pnlInfo: TPanel
      Width = 222
      ExplicitWidth = 222
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 136
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 104
    Top = 144
  end
end
