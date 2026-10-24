inherited frmCadAdvBases: TfrmCadAdvBases
  Left = 329
  Top = 289
  Width = 532
  Height = 226
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Bases - Advance'
  ExplicitWidth = 532
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 158
    Width = 526
    TabOrder = 2
    ExplicitTop = 158
    ExplicitWidth = 526
    inherited btnSair: TBitBtnLocked
      Left = 449
      ExplicitLeft = 449
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 526
    Height = 158
    TabOrder = 0
    ExplicitWidth = 526
    ExplicitHeight = 158
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 518
      ExplicitHeight = 126
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 526
    Height = 158
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    object Label1: TLabel
      Left = 52
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 36
      Top = 60
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 66
      Top = 108
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label7: TLabel
      Left = 42
      Top = 132
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Custo:'
    end
    object Label8: TLabel
      Left = 167
      Top = 132
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label9: TLabel
      Left = 271
      Top = 132
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr. Venda:'
    end
    object btnRestPreco: TSpeedButton
      Left = 483
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
    object Label3: TLabel
      Left = 46
      Top = 84
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label4: TLabel
      Left = 387
      Top = 132
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'P.Esp:'
      Visible = False
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 526
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Bases - Advance'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 152
      Top = 104
      Width = 329
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
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
      Left = 96
      Top = 32
      Width = 81
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 56
      Width = 385
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_DESCRI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Left = 96
      Top = 104
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
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
      Left = 96
      Top = 128
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_PRECUS'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
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
      Top = 128
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_MARGEM'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 320
      Top = 128
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_PREVEN'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidade: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 80
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_UNIDAD'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnExit = dbeUnidadeExit
      OnKeyPress = dbeUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Tag = 99
      Left = 152
      Top = 80
      Width = 265
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 424
      Top = 80
      Width = 57
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object dbePesEsp: TDBEditFocus
      Tag = 99
      Left = 424
      Top = 128
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_PESESP'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 186
    Width = 526
    TabOrder = 3
    ExplicitTop = 186
    ExplicitWidth = 526
    inherited pnlNomeForm: TPanel
      Left = 179
      TabOrder = 1
      ExplicitLeft = 179
    end
    inherited pnlInfo: TPanel
      Width = 179
      TabOrder = 0
      ExplicitWidth = 179
    end
  end
end
