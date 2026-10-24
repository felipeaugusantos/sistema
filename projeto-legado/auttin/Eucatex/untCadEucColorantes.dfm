inherited frmCadEucColorantes: TfrmCadEucColorantes
  Left = 242
  Top = 215
  Width = 534
  Height = 200
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Colorantes - Eucatex'
  ExplicitWidth = 534
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 132
    Width = 528
    ExplicitTop = 118
    ExplicitWidth = 528
    inherited btnSair: TBitBtnLocked
      Left = 451
      ExplicitLeft = 451
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 132
    ExplicitWidth = 528
    ExplicitHeight = 118
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 86
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 132
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 118
    object Label2: TLabel
      Left = 19
      Top = 36
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label3: TLabel
      Left = 46
      Top = 60
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label5: TLabel
      Left = 9
      Top = 84
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Custo'
    end
    object Label6: TLabel
      Left = 198
      Top = 84
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem'
    end
    object Label7: TLabel
      Left = 342
      Top = 84
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Venda'
    end
    object btnRestPreco: TSpeedButton
      Left = 482
      Top = 56
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
    object Label1: TLabel
      Left = 11
      Top = 108
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object dbeCodCol: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 32
      Width = 73
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
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 526
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Colorantes - Eucatex'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
    end
    object dbeIteCol: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 56
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      OnExit = dbeIteColExit
      OnKeyPress = dbeIteColKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 80
      Width = 73
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
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 240
      Top = 80
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 408
      Top = 80
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
    object edtDesIte: TEditFocus
      Left = 144
      Top = 56
      Width = 337
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 104
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
  end
  inherited pnlStatus: TPanel
    Top = 160
    Width = 528
    ExplicitTop = 146
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
end
