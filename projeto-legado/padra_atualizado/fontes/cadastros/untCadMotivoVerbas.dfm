inherited frmCadMotivoVerbas: TfrmCadMotivoVerbas
  Left = 379
  Top = 272
  Width = 539
  Height = 141
  Caption = 'Motivo para Verbas'
  ExplicitWidth = 539
  ExplicitHeight = 141
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 533
    Height = 22
    BevelInner = bvNone
    TabOrder = 1
    ExplicitTop = 74
    ExplicitWidth = 533
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 531
      Height = 20
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 531
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 76
        ExplicitLeft = 370
        ExplicitWidth = 76
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 447
      Top = 1
      Width = 74
      Height = 20
      ExplicitLeft = 447
      ExplicitTop = 1
      ExplicitWidth = 74
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 533
    Height = 74
    TabOrder = 3
    Visible = False
    ExplicitWidth = 533
    ExplicitHeight = 74
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 525
      ExplicitHeight = 42
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 74
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDesMot: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 33
      Width = 456
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_DESMOT'
      DataSource = dtsTabela
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VBA_CODMOT'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 96
    Width = 533
    TabOrder = 2
    ExplicitTop = 96
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 352
      Width = 181
      ExplicitLeft = 352
      ExplicitWidth = 181
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 8
  end
  object dtsTabela: TDataSource
    Left = 352
  end
end
