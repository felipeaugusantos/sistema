inherited frmCadReiBases: TfrmCadReiBases
  Left = 204
  Top = 243
  Width = 530
  Height = 223
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Bases - Renner Imobili'#225'ria'
  ExplicitWidth = 530
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 524
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 155
    ExplicitWidth = 524
    inherited btnSair: TBitBtnLocked
      Left = 446
      ExplicitLeft = 446
    end
    inherited btnGravar: TBitBtnLocked
      Left = 76
      ExplicitLeft = 76
    end
    inherited btnCancela: TBitBtnLocked
      Left = 294
      ExplicitLeft = 294
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 221
      ExplicitLeft = 221
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 367
      ExplicitLeft = 367
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 149
      ExplicitLeft = 149
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 524
    Height = 132
    Visible = False
    ExplicitTop = 23
    ExplicitWidth = 524
    ExplicitHeight = 132
    inherited tbsGeral: TTabSheet
      Font.Name = '$00FFDFB8'
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 516
      ExplicitHeight = 100
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 23
    Width = 524
    Height = 132
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 57
      Top = 11
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 43
      Top = 34
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 33
      Top = 57
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 102
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 189
      Top = 102
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 343
      Top = 102
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 35
      Top = 79
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item Base:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnRestPreco: TSpeedButton
      Left = 498
      Top = 75
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
    object edtDesIte: TEditFocus
      Left = 159
      Top = 75
      Width = 337
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 7
      Width = 66
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodUni: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 29
      Width = 36
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_UNIDAD'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = dbeCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 53
      Width = 409
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_DESCRI'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 98
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PRECUS'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
      Left = 232
      Top = 98
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_MARGEM'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
      Left = 425
      Top = 98
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PREVEN'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 75
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      DataSource = dtsCadReiBases
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesUni: TEditFocus
      Left = 124
      Top = 30
      Width = 293
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
    object edtSigUni: TEditFocus
      Left = 418
      Top = 30
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 524
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Cadastro de bases - Renner Imobili'#225'ria'
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
    Top = 183
    Width = 524
    TabOrder = 3
    ExplicitTop = 183
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 370
      Width = 154
      ExplicitLeft = 370
      ExplicitWidth = 154
    end
    inherited pnlInfo: TPanel
      Width = 370
      ExplicitWidth = 370
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 72
  end
  object dtsCadReiBases: TDataSource
    Left = 152
    Top = 24
  end
end
