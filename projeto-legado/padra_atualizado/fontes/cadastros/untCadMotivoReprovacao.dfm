inherited frmCadMotivoReprovacao: TfrmCadMotivoReprovacao
  Left = 319
  Top = 465
  Width = 535
  Height = 141
  Caption = 'Cadastro de Motivo de Reprova'#231#227'o'
  ExplicitWidth = 535
  ExplicitHeight = 141
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 71
    Width = 529
    Height = 25
    ExplicitTop = 71
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 525
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
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
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 73
      Height = 20
      ExplicitLeft = 446
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 71
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 68
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
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MRE_DESCRI'
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
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MRE_CODIGO'
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
    Width = 529
    ExplicitTop = 96
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 322
      Width = 207
      ExplicitLeft = 322
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 322
      ExplicitWidth = 322
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 0
  end
end
