inherited frmCadBzaBases: TfrmCadBzaBases
  Left = 266
  Top = 465
  Width = 530
  Height = 175
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Bases - Brasimix Automotiva'
  ExplicitWidth = 530
  ExplicitHeight = 175
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 107
    Width = 524
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 107
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
  inherited pnlStatus: TPanel
    Top = 135
    Width = 524
    TabOrder = 3
    ExplicitTop = 135
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
  inherited pgcDados: TPageControl
    Width = 524
    Height = 107
    Visible = False
    ExplicitWidth = 524
    ExplicitHeight = 107
    inherited tbsGeral: TTabSheet
      Font.Name = '$00FFDFB8'
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 516
      ExplicitHeight = 75
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 524
    Height = 107
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 49
      Top = 38
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
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
      Top = 60
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
    object Label8: TLabel
      Left = 35
      Top = 82
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
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 31
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
      DataSource = dtsBzaCadBas
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
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 53
      Width = 409
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_DESBAS'
      DataSource = dtsBzaCadBas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 75
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      DataSource = dtsBzaCadBas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object pnlCabecalho: TPanel
      Left = 2
      Top = 2
      Width = 520
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Bases - Brasimix Automotiva'
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
  end
  object dtsBzaCadBas: TDataSource
    Left = 296
    Top = 16
  end
end
