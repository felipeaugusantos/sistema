inherited frmCadFaixaPrzMed: TfrmCadFaixaPrzMed
  Width = 532
  Height = 139
  Caption = 'Cadastro de Faixas de Prazo M'#233'dio de Venda do Vendedor'
  OnDestroy = FormDestroy
  ExplicitWidth = 532
  ExplicitHeight = 139
  PixelsPerInch = 96
  TextHeight = 14
  object lblPrzMedIni: TLabel [0]
    Left = 138
    Top = 25
    Width = 64
    Height = 14
    Caption = 'Prz. M'#233'd. Ini.:'
  end
  object lblPrzMedFin: TLabel [1]
    Left = 258
    Top = 25
    Width = 68
    Height = 14
    Caption = 'Prz. M'#233'd. Fin.:'
  end
  object lblPrzMedMax: TLabel [2]
    Left = 383
    Top = 25
    Width = 74
    Height = 14
    Caption = 'Prz. M'#233'd. Max.:'
  end
  object lblCodigo: TLabel [3]
    Left = 18
    Top = 26
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
  end
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 526
    Height = 25
    TabOrder = 3
    ExplicitTop = 69
    ExplicitWidth = 526
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 522
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 522
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      Width = 70
      Height = 19
      ExplicitLeft = 441
      ExplicitWidth = 70
      ExplicitHeight = 19
    end
  end
  inherited pgcDados: TPageControl
    Left = 1000
    Top = 128
    Width = 112
    Height = 59
    Align = alNone
    TabOrder = 5
    ExplicitLeft = 1000
    ExplicitTop = 128
    ExplicitWidth = 112
    ExplicitHeight = 59
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 104
      ExplicitHeight = 27
    end
  end
  inherited pnlStatus: TPanel
    Top = 94
    Width = 526
    TabOrder = 4
    ExplicitTop = 94
    ExplicitWidth = 526
    inherited pnlNomeForm: TPanel
      Left = 352
      Width = 174
      ExplicitLeft = 352
      ExplicitWidth = 174
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  object dbeCodIni: TDBEditFocus [8]
    Tag = 99
    Left = 206
    Top = 22
    Width = 47
    Height = 22
    DataField = 'PRZ_MEDINI'
    MaxLength = 3
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object dbeCodFin: TDBEditFocus [9]
    Tag = 99
    Left = 330
    Top = 22
    Width = 47
    Height = 22
    DataField = 'PRZ_MEDFIN'
    MaxLength = 3
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object dbeCodMax: TDBEditFocus [10]
    Tag = 99
    Left = 461
    Top = 22
    Width = 47
    Height = 22
    DataField = 'PRZ_MEDMAX'
    MaxLength = 3
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object dbeCodigo: TDBEditFocus [11]
    Tag = 99
    Left = 57
    Top = 22
    Width = 76
    Height = 22
    TabStop = False
    Color = 16770261
    DataField = 'PRZ_CODIGO'
    MaxLength = 3
    ReadOnly = True
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
end
