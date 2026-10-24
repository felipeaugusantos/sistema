inherited frmCadFrequenciaCRM: TfrmCadFrequenciaCRM
  Height = 146
  Caption = 'Cadastro de Frequ'#234'ncia'
  ExplicitHeight = 146
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 30
    Top = 17
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 14
    Top = 40
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 77
    Height = 25
    TabOrder = 1
    ExplicitTop = 77
    ExplicitHeight = 25
    inherited btnSair: TBitBtnLocked
      Left = 511
      Top = 2
      Height = 21
      Align = alRight
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      Top = 2
      Height = 21
      Align = alLeft
    end
    inherited btnGravar: TBitBtnLocked
      Left = 74
      Top = 2
      Height = 21
      Align = alLeft
    end
    inherited btnCancela: TBitBtnLocked
      Left = 146
      Top = 2
      Height = 21
      Align = alLeft
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 290
      Top = 2
      Height = 21
      Align = alLeft
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 362
      Top = 2
      Height = 21
      Align = alLeft
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 218
      Top = 2
      Height = 21
      Align = alLeft
    end
  end
  inherited pgcDados: TPageControl
    Left = 9128
    Top = 76
    Width = 13
    Height = 107
    Align = alNone
    TabOrder = 3
    ExplicitLeft = 9128
    ExplicitTop = 76
    ExplicitWidth = 13
    ExplicitHeight = 107
    inherited tbsGeral: TTabSheet
      ExplicitTop = 27
    end
  end
  inherited pnlStatus: TPanel
    Top = 102
    TabOrder = 2
    inherited pnlInfo: TPanel
    end
  end
  object dbeCodigo: TDBEditFocus [6]
    Tag = 50
    Left = 68
    Top = 12
    Width = 88
    Height = 22
    CharCase = ecUpperCase
    Color = 16770261
    DataField = 'CRF_CODIGO'
    DataSource = dtsSource
    Enabled = False
    ReadOnly = True
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeDescri: TDBEditFocus [7]
    Tag = 99
    Left = 68
    Top = 37
    Width = 381
    Height = 22
    CharCase = ecUpperCase
    DataField = 'CRF_DESCRI'
    DataSource = dtsSource
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dtsSource: TDataSource
    Left = 492
    Top = 16
  end
end
