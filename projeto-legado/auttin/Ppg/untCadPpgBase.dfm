inherited frmCadPpgBase: TfrmCadPpgBase
  Left = 369
  Top = 246
  Width = 639
  Height = 254
  Caption = 'Cadastro de Bases - PPG'
  Ctl3D = False
  ExplicitWidth = 639
  ExplicitHeight = 254
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 182
    Width = 633
    ExplicitTop = 182
    ExplicitWidth = 633
    DesignSize = (
      633
      28)
    inherited btnSair: TBitBtnLocked
      Left = 556
      ExplicitLeft = 556
    end
    object btnBasEmp: TBitBtnLocked
      Left = 442
      Top = 4
      Width = 109
      Height = 20
      Caption = 'Bases Por Empresas'
      TabOrder = 7
      OnClick = btnBasEmpClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 210
    Width = 633
    ExplicitTop = 210
    ExplicitWidth = 633
    inherited pnlNomeForm: TPanel
      Left = 286
      ExplicitLeft = 286
    end
    inherited pnlInfo: TPanel
      Width = 286
      ExplicitWidth = 286
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 633
    Height = 159
    ExplicitTop = 23
    ExplicitWidth = 633
    ExplicitHeight = 159
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 625
      ExplicitHeight = 127
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 23
    Width = 633
    Height = 159
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object btnRestPreco: TSpeedButton
      Left = 490
      Top = 56
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
    object Label1: TLabel
      Left = 36
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 50
      Top = 59
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label3: TLabel
      Left = 12
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label4: TLabel
      Left = 21
      Top = 107
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Esp.:'
    end
    object Label6: TLabel
      Left = 305
      Top = 107
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label7: TLabel
      Left = 10
      Top = 131
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Custo:'
    end
    object Label8: TLabel
      Left = 175
      Top = 131
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label5: TLabel
      Left = 159
      Top = 107
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label9: TLabel
      Left = 303
      Top = 131
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Venda:'
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 8
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 56
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 2
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDesBas: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 32
      Width = 409
      Height = 20
      CharCase = ecUpperCase
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
      Left = 80
      Top = 104
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipo: TDBEditFocus
      Tag = 99
      Left = 336
      Top = 104
      Width = 153
      Height = 20
      CharCase = ecUpperCase
      ReadOnly = True
      TabOrder = 6
      OnKeyPress = dbeTipoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePCusto: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 128
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePMargem: TDBEditFocus
      Tag = 99
      Left = 224
      Top = 128
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbalagem: TDBEditFocus
      Tag = 99
      Left = 224
      Top = 104
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePVenda: TDBEditFocus
      Tag = 99
      Left = 376
      Top = 128
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 127
      Top = 56
      Width = 362
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
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
    object dbeBasePo: TDBCheckBox
      Left = 80
      Top = 81
      Width = 89
      Height = 17
      Caption = 'Base em p'#243'?'
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dbeBasePoClick
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 633
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Cadastro de Bases - PPG'
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
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 8
  end
end
