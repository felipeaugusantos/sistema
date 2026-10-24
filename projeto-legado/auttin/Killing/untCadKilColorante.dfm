inherited frmCadKilColorantes: TfrmCadKilColorantes
  Left = 262
  Top = 389
  VertScrollBar.Range = 0
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Colorantes - Killing'
  ClientHeight = 146
  ClientWidth = 514
  ExplicitWidth = 520
  ExplicitHeight = 170
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 102
    Width = 514
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 102
    ExplicitWidth = 514
    inherited btnSair: TBitBtnLocked
      Left = 439
      ExplicitLeft = 439
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
  inherited pnlStatus: TPanel
    Top = 130
    Width = 514
    TabOrder = 3
    ExplicitTop = 130
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 339
      Width = 175
      ExplicitLeft = 339
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 339
    end
  end
  inherited pgcDados: TPageControl
    Width = 514
    Height = 102
    Visible = False
    ExplicitWidth = 514
    ExplicitHeight = 102
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 506
      ExplicitHeight = 70
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 514
    Height = 102
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 53
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 59
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Custo:'
    end
    object Label3: TLabel
      Left = 174
      Top = 59
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label4: TLabel
      Left = 296
      Top = 59
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object Label8: TLabel
      Left = 18
      Top = 83
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
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbePreCus: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 52
      Width = 64
      Height = 22
      DataField = 'COL_PRECUS'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 217
      Top = 52
      Width = 64
      Height = 22
      DataField = 'COL_MARGEM'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbePreVen: TDBEditFocus
      Tag = 99
      Left = 378
      Top = 52
      Width = 64
      Height = 22
      DataField = 'COL_PREVEN'
      TabOrder = 3
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
      Width = 512
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Colorantes - Killing'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object edtDesIte: TEditFocus
      Left = 162
      Top = 75
      Width = 337
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
      Left = 91
      Top = 75
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
      TabOrder = 6
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
end
