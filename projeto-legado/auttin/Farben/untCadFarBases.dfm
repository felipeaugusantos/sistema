inherited frmCadFarBases: TfrmCadFarBases
  Left = 312
  Top = 290
  Width = 541
  Height = 231
  Caption = 'Cadastro de Bases - Farben Automotiva'
  ExplicitWidth = 541
  ExplicitHeight = 231
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 159
    Width = 535
    ExplicitTop = 159
    ExplicitWidth = 535
    DesignSize = (
      535
      28)
    inherited btnSair: TBitBtnLocked
      Left = 458
      ExplicitLeft = 458
    end
  end
  inherited pgcDados: TPageControl
    Width = 535
    Height = 159
    ExplicitWidth = 535
    ExplicitHeight = 159
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 527
      ExplicitHeight = 127
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 535
    Height = 159
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 50
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 34
      Top = 60
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 32
      Top = 84
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Densidade:'
    end
    object Label4: TLabel
      Left = 36
      Top = 108
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item Base:'
    end
    object Label5: TLabel
      Left = 9
      Top = 132
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
    end
    object Label6: TLabel
      Left = 149
      Top = 132
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label7: TLabel
      Left = 254
      Top = 132
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object btnRestPreco: TSpeedButton
      Left = 395
      Top = 104
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
    object Label8: TLabel
      Left = 157
      Top = 84
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 56
      Width = 305
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
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 32
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 7
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 535
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Bases - Farben Automotiva'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 9
    end
    object dbeDensidad: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 80
      Width = 57
      Height = 22
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 104
      Width = 57
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
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 128
      Width = 57
      Height = 22
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 336
      Top = 128
      Width = 57
      Height = 22
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 144
      Top = 104
      Width = 249
      Height = 22
      Alignment = taLeftJustify
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
    end
    object edtMargem: TEditFocus
      Tag = 99
      Left = 192
      Top = 128
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 7
      OnExit = edtMargemExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 216
      Top = 80
      Width = 57
      Height = 22
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 187
    Width = 535
    ExplicitTop = 187
    ExplicitWidth = 535
    inherited pnlNomeForm: TPanel
      Left = 188
      ExplicitLeft = 188
    end
    inherited pnlInfo: TPanel
      Width = 188
      ExplicitWidth = 188
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 64
  end
end
