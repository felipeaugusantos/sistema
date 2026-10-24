inherited frmCadMazColorantes: TfrmCadMazColorantes
  Left = 306
  Top = 224
  Width = 538
  Height = 183
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Corantes - Maza'
  ExplicitWidth = 538
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 115
    Width = 532
    ExplicitTop = 115
    ExplicitWidth = 532
    inherited btnSair: TBitBtnLocked
      Left = 455
      ExplicitLeft = 455
    end
  end
  inherited pnlStatus: TPanel
    Top = 143
    Width = 532
    ExplicitTop = 143
    ExplicitWidth = 532
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
    end
  end
  inherited pgcDados: TPageControl
    Width = 532
    Height = 115
    ExplicitWidth = 532
    ExplicitHeight = 115
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 524
      ExplicitHeight = 83
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 532
    Height = 115
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    object Label1: TLabel
      Left = 28
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label6: TLabel
      Left = 42
      Top = 60
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label7: TLabel
      Left = 18
      Top = 84
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Custo:'
    end
    object Label8: TLabel
      Left = 135
      Top = 84
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label9: TLabel
      Left = 239
      Top = 84
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Venda:'
    end
    object btnRestPreco: TSpeedButton
      Left = 459
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
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 532
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Corantes - Maza'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 128
      Top = 56
      Width = 329
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 32
      Width = 81
      Height = 20
      CharCase = ecUpperCase
      DataField = 'COL_CODCOL'
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
      Left = 72
      Top = 56
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'COL_CODITE'
      TabOrder = 1
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
      Left = 72
      Top = 80
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'COL_PRECUS'
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
      Left = 176
      Top = 80
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'COL_MARGEM'
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
      Left = 288
      Top = 80
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'COL_PREVEN'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 32
  end
end
