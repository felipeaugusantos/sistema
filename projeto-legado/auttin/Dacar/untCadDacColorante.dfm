inherited frmCadDacColorantes: TfrmCadDacColorantes
  Left = 405
  Top = 123
  VertScrollBar.Range = 0
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Colorantes - Dacar'
  ClientHeight = 150
  ClientWidth = 549
  ExplicitWidth = 555
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 549
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 106
    ExplicitWidth = 549
    inherited btnSair: TBitBtnLocked
      Left = 474
      ExplicitLeft = 474
    end
    inherited btnGravar: TBitBtnLocked
      Left = 75
      ExplicitLeft = 75
    end
    inherited btnCancela: TBitBtnLocked
      Left = 290
      ExplicitLeft = 290
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 218
      ExplicitLeft = 218
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 362
      ExplicitLeft = 362
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 147
      ExplicitLeft = 147
    end
  end
  inherited pgcDados: TPageControl
    Width = 549
    Height = 106
    Visible = False
    ExplicitWidth = 549
    ExplicitHeight = 106
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 541
      ExplicitHeight = 74
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 549
    Height = 106
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 53
      Top = 33
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 80
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
    end
    object Label3: TLabel
      Left = 158
      Top = 80
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label4: TLabel
      Left = 272
      Top = 80
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object Label8: TLabel
      Left = 17
      Top = 56
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
      Left = 518
      Top = 52
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
    object Label5: TLabel
      Left = 419
      Top = 80
      Width = 57
      Height = 14
      Caption = 'Embalagem:'
    end
    object dbeCodCol: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 29
      Width = 36
      Height = 22
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
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 76
      Width = 64
      Height = 22
      DataField = 'COL_PRECUS'
      TabOrder = 2
      OnExit = dbePreCusExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 201
      Top = 76
      Width = 64
      Height = 22
      DataField = 'COL_MARGEM'
      TabOrder = 3
      OnExit = dbeMargemExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 354
      Top = 76
      Width = 64
      Height = 22
      DataField = 'COL_PREVEN'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 547
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Colorantes - Dacar'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
    end
    object edtDesIte: TEditFocus
      Left = 162
      Top = 52
      Width = 351
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
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 52
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COL_CODITE'
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
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 477
      Top = 76
      Width = 64
      Height = 22
      DataField = 'DAC_EMBALA'
      TabOrder = 7
      OnChange = dbeEmbalaChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 134
    Width = 549
    TabOrder = 3
    ExplicitTop = 134
    ExplicitWidth = 549
    inherited pnlNomeForm: TPanel
      Left = 374
      Width = 175
      ExplicitLeft = 374
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 374
      ExplicitWidth = 374
    end
  end
end
