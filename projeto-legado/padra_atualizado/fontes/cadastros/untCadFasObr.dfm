inherited frmCadFasObr: TfrmCadFasObr
  Width = 525
  Height = 133
  Caption = 'Cadastro de Fases da Obra'
  ExplicitWidth = 525
  ExplicitHeight = 133
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 63
    Width = 519
    Height = 25
    TabOrder = 1
    ExplicitTop = 63
    ExplicitWidth = 519
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 451
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 73
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 146
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 219
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 292
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        Height = 21
        Spacing = 2
        ExplicitLeft = 365
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 453
      Width = 64
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 446
      ExplicitWidth = 64
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Top = 5000
    Height = 0
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitTop = 5000
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 63
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblCodigo: TLabel
      Left = 21
      Top = 11
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object lblDescri: TLabel
      Left = 5
      Top = 36
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeDescri: TDBEditFocus
      Left = 58
      Top = 31
      Width = 447
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAS_DESCRI'
      DataSource = dtsFasObr
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dbeCodigo: TDBEditFocus [4]
    Left = 58
    Top = 8
    Width = 71
    Height = 22
    DataField = 'FAS_CODFAS'
    DataSource = dtsFasObr
    TabOrder = 4
    OnExit = dbeCodigoExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  inherited pnlStatus: TPanel
    Top = 88
    Width = 519
    TabOrder = 2
    ExplicitTop = 88
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 320
      Width = 199
      ExplicitLeft = 320
      ExplicitWidth = 199
    end
    inherited pnlInfo: TPanel
      Width = 320
      ExplicitWidth = 320
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 552
    Top = 528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 528
  end
  object dtsFasObr: TDataSource
    Left = 480
  end
end
