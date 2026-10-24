inherited frmCadGenBases: TfrmCadGenBases
  Left = 276
  Top = 276
  Width = 534
  Height = 252
  Caption = 'Cadastro de Bases - General'
  ExplicitWidth = 534
  ExplicitHeight = 252
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 180
    Width = 528
    TabOrder = 2
    ExplicitTop = 180
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
    Top = 208
    Width = 528
    TabOrder = 3
    ExplicitTop = 208
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
    Height = 180
    TabOrder = 0
    ExplicitWidth = 528
    ExplicitHeight = 180
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 148
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 180
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Label2: TLabel
      Left = 36
      Top = 35
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label1: TLabel
      Left = 20
      Top = 59
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label4: TLabel
      Left = 144
      Top = 107
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Espec'#237'fico:'
    end
    object Label5: TLabel
      Left = 295
      Top = 107
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label6: TLabel
      Left = 41
      Top = 131
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Custo:'
    end
    object Label7: TLabel
      Left = 183
      Top = 131
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label8: TLabel
      Left = 318
      Top = 131
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Venda:'
    end
    object Label9: TLabel
      Left = 50
      Top = 83
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object btnRestPreco: TSpeedButton
      Left = 418
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
    object lblIpi: TLabel
      Left = 59
      Top = 155
      Width = 13
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ipi:'
    end
    object lblIcms: TLabel
      Left = 199
      Top = 155
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Icms:'
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 528
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Bases - General'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 32
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
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
      Left = 80
      Top = 56
      Width = 337
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_DESCRI'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesEsp: TDBEditFocus
      Tag = 99
      Left = 232
      Top = 104
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
      Left = 360
      Top = 104
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
      Left = 80
      Top = 128
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
      Left = 232
      Top = 128
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
      Left = 360
      Top = 128
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
      Left = 80
      Top = 80
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
      Left = 144
      Top = 80
      Width = 273
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object dbeIpi: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 152
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_I_P_I_'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIcms: TDBEditFocus
      Tag = 99
      Left = 232
      Top = 152
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      DataField = 'BAS_ICMS__'
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
end
