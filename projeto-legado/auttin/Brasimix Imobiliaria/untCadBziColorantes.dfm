inherited frmCadBziColorantes: TfrmCadBziColorantes
  Left = 234
  Top = 201
  Width = 592
  Height = 176
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Colorantes - Brasimix Imobili'#225'ria'
  ExplicitWidth = 592
  ExplicitHeight = 176
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 108
    Width = 586
    ExplicitTop = 108
    ExplicitWidth = 586
  end
  inherited pgcDados: TPageControl
    Width = 586
    Height = 108
    ExplicitWidth = 586
    ExplicitHeight = 108
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 578
      ExplicitHeight = 76
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 586
    Height = 108
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 61
      Top = 39
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 20
      Top = 83
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
    end
    object Label3: TLabel
      Left = 224
      Top = 83
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label4: TLabel
      Left = 385
      Top = 83
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object Label8: TLabel
      Left = 28
      Top = 61
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item Colorante:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object btnRestPreco: TSpeedButton
      Left = 556
      Top = 53
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
    object dbeCodCol: TDBEditFocus
      Tag = 99
      Left = 101
      Top = 31
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_CODCOL'
      DataSource = dtsBziCadCol
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 101
      Top = 75
      Width = 84
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_PRECUS'
      DataSource = dtsBziCadCol
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 269
      Top = 75
      Width = 72
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_MARGEM'
      DataSource = dtsBziCadCol
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 469
      Top = 75
      Width = 84
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_PREVEN'
      DataSource = dtsBziCadCol
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 173
      Top = 53
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 101
      Top = 53
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_CODITE'
      DataSource = dtsBziCadCol
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 584
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Colorantes - Brasimix Imobili'#225'ria'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
    end
  end
  inherited pnlStatus: TPanel
    Top = 136
    Width = 586
    ExplicitTop = 136
    ExplicitWidth = 586
    inherited pnlNomeForm: TPanel
      Left = 239
      ExplicitLeft = 239
    end
    inherited pnlInfo: TPanel
      Width = 239
      ExplicitWidth = 239
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 16
  end
  object dtsBziCadCol: TDataSource
    Left = 536
    Top = 16
  end
end
