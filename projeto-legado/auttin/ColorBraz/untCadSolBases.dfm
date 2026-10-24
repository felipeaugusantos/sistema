inherited frmCadSolBases: TfrmCadSolBases
  Left = 320
  Top = 261
  Width = 535
  Height = 233
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Bases - ColorBraz'
  ExplicitWidth = 535
  ExplicitHeight = 233
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 165
    Width = 529
    ExplicitTop = 165
    ExplicitWidth = 529
    inherited btnSair: TBitBtnLocked
      Left = 452
      ExplicitLeft = 452
    end
  end
  inherited pnlStatus: TPanel
    Top = 193
    Width = 529
    ExplicitTop = 193
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 182
      ExplicitLeft = 182
    end
    inherited pnlInfo: TPanel
      Width = 182
      ExplicitWidth = 182
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 165
    ExplicitWidth = 529
    ExplicitHeight = 165
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 133
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 165
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 44
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 38
      Top = 60
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label4: TLabel
      Left = 28
      Top = 84
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label5: TLabel
      Left = 58
      Top = 108
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label6: TLabel
      Left = 34
      Top = 132
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Custo:'
    end
    object Label7: TLabel
      Left = 191
      Top = 132
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label8: TLabel
      Left = 343
      Top = 132
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Venda:'
    end
    object btnRestPreco: TSpeedButton
      Left = 483
      Top = 80
      Width = 30
      Height = 22
      Hint = 'Restaura dados do produto'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnRestPrecoClick
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 32
      Width = 65
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
    object dbeUnid: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 56
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      OnExit = dbeUnidExit
      OnKeyPress = dbeUnidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidadDescri: TEditFocus
      Left = 152
      Top = 56
      Width = 273
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object dbeUnidUnid: TEditFocus
      Left = 424
      Top = 56
      Width = 57
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 80
      Width = 393
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 104
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 3
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIteDescri: TEditFocus
      Left = 152
      Top = 104
      Width = 329
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 128
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 240
      Top = 128
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 400
      Top = 128
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 529
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Bases - ColorBraz'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
    end
  end
end
