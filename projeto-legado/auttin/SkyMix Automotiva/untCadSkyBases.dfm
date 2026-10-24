inherited frmCadSkyBases: TfrmCadSkyBases
  Left = 318
  Top = 263
  Width = 535
  Height = 257
  Caption = 'Cadastro de Bases - Skymix'
  ExplicitWidth = 535
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 185
    Width = 529
    ExplicitTop = 185
    ExplicitWidth = 529
    inherited btnSair: TBitBtnLocked
      Left = 452
      ExplicitLeft = 452
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 529
    Height = 162
    ExplicitTop = 23
    ExplicitWidth = 529
    ExplicitHeight = 162
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 130
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 23
    Width = 529
    Height = 162
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 28
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 34
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 10
      Top = 58
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Densidade:'
    end
    object Label4: TLabel
      Left = 151
      Top = 58
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label6: TLabel
      Left = 42
      Top = 82
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object btnRestPreco: TSpeedButton
      Left = 459
      Top = 78
      Width = 23
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
    object Label7: TLabel
      Left = 18
      Top = 106
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Custo:'
    end
    object Label8: TLabel
      Left = 159
      Top = 106
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label9: TLabel
      Left = 311
      Top = 106
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Venda:'
    end
    object Label5: TLabel
      Left = 24
      Top = 130
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = '% ICMS:'
    end
    object Label10: TLabel
      Left = 171
      Top = 130
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = '%: IPI:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 6
      Width = 81
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
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 30
      Width = 385
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
    object dbeDensidade: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 54
      Width = 73
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
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 216
      Top = 54
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 78
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 4
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TEditFocus
      Tag = 99
      Left = 120
      Top = 78
      Width = 337
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 102
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 208
      Top = 102
      Width = 97
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
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 368
      Top = 102
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtPorIcms: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 126
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
    object edtPorIpi: TDBEditFocus
      Tag = 99
      Left = 208
      Top = 126
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 10
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
    Width = 529
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Cadastro de Bases - Skymix'
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
  end
  inherited pnlStatus: TPanel
    Top = 213
    Width = 529
    ExplicitTop = 213
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 24
  end
end
