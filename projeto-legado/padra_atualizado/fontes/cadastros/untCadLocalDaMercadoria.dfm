inherited frmCadLocalDaMercadoria: TfrmCadLocalDaMercadoria
  Width = 521
  Height = 149
  Caption = 'Controle de Coletas - Local da Mercadoria'
  ExplicitWidth = 521
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 76
    Width = 515
    TabOrder = 1
    ExplicitTop = 76
    ExplicitWidth = 515
    inherited FlwBotoes: TFlowPanel
      Width = 511
      ExplicitTop = 2
      ExplicitWidth = 511
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
      Left = 440
      Width = 67
      Height = 20
      ExplicitLeft = 440
      ExplicitWidth = 67
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 104
    Width = 515
    TabOrder = 2
    ExplicitTop = 104
    ExplicitWidth = 515
    inherited pnlNomeForm: TPanel
      Left = 168
      ExplicitLeft = 168
    end
    inherited pnlInfo: TPanel
      Width = 168
      ExplicitWidth = 168
    end
  end
  inherited pgcDados: TPageControl
    Width = 515
    Height = 76
    TabOrder = 3
    ExplicitWidth = 515
    ExplicitHeight = 76
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 507
      ExplicitHeight = 44
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 515
    Height = 76
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 16
      Top = 40
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 12
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LOC_CODLOC'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 36
      Width = 427
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LOC_DESCRI'
      DataSource = dtsTabela
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 65528
  end
  object dtsTabela: TDataSource
    Left = 175
    Top = 8
  end
end
