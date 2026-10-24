inherited frmCadIrregFiscal: TfrmCadIrregFiscal
  Left = 177
  Top = 250
  Width = 536
  Height = 139
  Caption = 'Cadastro de Irregularidades Fiscais'
  ExplicitWidth = 536
  ExplicitHeight = 139
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 530
    Height = 25
    TabOrder = 1
    ExplicitTop = 69
    ExplicitWidth = 530
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 454
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 451
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
      Left = 456
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 453
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 530
    Height = 69
    Visible = False
    ExplicitWidth = 530
    ExplicitHeight = 69
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 522
      ExplicitHeight = 37
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 530
    Height = 69
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 25
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 9
      Top = 39
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeDesIrr: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 35
      Width = 440
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IRR_DESIRR'
      DataSource = dtsCadIrr
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIrr: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 13
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IRR_CODIRR'
      DataSource = dtsCadIrr
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
    Top = 94
    Width = 530
    TabOrder = 3
    ExplicitTop = 94
    ExplicitWidth = 530
    inherited pnlNomeForm: TPanel
      Left = 362
      Width = 168
      ExplicitLeft = 362
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 8
  end
  object dtsCadIrr: TDataSource
    Left = 376
  end
end
