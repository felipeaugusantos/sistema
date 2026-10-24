inherited frmCadMzaBases: TfrmCadMzaBases
  Left = 276
  Top = 276
  Width = 534
  Height = 275
  Caption = 'Cadastro de Bases - Maza Automotiva'
  ExplicitWidth = 534
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 203
    Width = 528
    TabOrder = 2
    ExplicitTop = 203
    ExplicitWidth = 528
    DesignSize = (
      528
      28)
    inherited btnSair: TBitBtnLocked
      Left = 451
      ExplicitLeft = 451
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 231
    Width = 528
    TabOrder = 3
    ExplicitTop = 231
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 181
      TabOrder = 1
      ExplicitLeft = 181
    end
    inherited pnlInfo: TPanel
      Width = 181
      TabOrder = 0
      ExplicitWidth = 181
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 203
    TabOrder = 0
    ExplicitWidth = 528
    ExplicitHeight = 203
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 520
      ExplicitHeight = 171
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 203
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Label2: TLabel
      Left = 47
      Top = 38
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label1: TLabel
      Left = 31
      Top = 62
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label4: TLabel
      Left = 4
      Top = 158
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Espec'#237'fico:'
    end
    object Label5: TLabel
      Left = 306
      Top = 158
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label6: TLabel
      Left = 52
      Top = 182
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Custo:'
    end
    object Label7: TLabel
      Left = 194
      Top = 182
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label8: TLabel
      Left = 329
      Top = 182
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Venda:'
    end
    object Label9: TLabel
      Left = 61
      Top = 110
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object btnRestPreco: TSpeedButton
      Left = 429
      Top = 80
      Width = 23
      Height = 20
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
    object lblLinha: TLabel
      Left = 54
      Top = 134
      Width = 29
      Height = 14
      Caption = 'Linha:'
    end
    object Label3: TLabel
      Left = 53
      Top = 86
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Efeito:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 32
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
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
      Left = 91
      Top = 56
      Width = 337
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesEsp: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 152
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_PESESP'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 371
      Top = 152
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_EMBALA'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCusto: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 176
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_PRECUS'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 241
      Top = 176
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_MARGEM'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVenda: TDBEditFocus
      Tag = 99
      Left = 371
      Top = 176
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_PREVEN'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeItem: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 104
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      TabOrder = 3
      OnKeyPress = dbeItemKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 155
      Top = 104
      Width = 273
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha_: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 128
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_LINHA_'
      TabOrder = 4
      OnKeyPress = dbeLinha_KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesLinha_: TEditFocus
      Left = 155
      Top = 128
      Width = 273
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeEfeito: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 80
      Width = 337
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_EFEITO'
      TabOrder = 2
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
      Width = 528
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Bases - Maza Automotiva'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 12
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 16
  end
end
