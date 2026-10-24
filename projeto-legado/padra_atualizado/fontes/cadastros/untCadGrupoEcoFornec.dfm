inherited frmCadGrupoEcoFornec: TfrmCadGrupoEcoFornec
  Left = 446
  Top = 399
  Width = 534
  Height = 132
  Caption = 'Cadastro de Grupo Econ'#244'mico de Fornecedores'
  Position = poScreenCenter
  ExplicitWidth = 534
  ExplicitHeight = 132
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 62
    Width = 528
    Height = 25
    ExplicitTop = 62
    ExplicitWidth = 528
    ExplicitHeight = 25
    DesignSize = (
      528
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 524
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 524
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      Width = 74
      Height = 20
      ExplicitLeft = 452
      ExplicitWidth = 74
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 87
    Width = 528
    ExplicitTop = 87
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 184
      Alignment = taRightJustify
      ExplicitLeft = 344
      ExplicitWidth = 184
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 62
    ExplicitWidth = 528
    ExplicitHeight = 62
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 30
    end
  end
  object pnlCadastro: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 62
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 17
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 23
      Top = 35
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object dbeCodGef: TDBEditFocus
      Left = 56
      Top = 8
      Width = 70
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'GEF_CODGEF'
      Enabled = False
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesGef: TDBEditFocus
      Tag = 99
      Left = 56
      Top = 31
      Width = 385
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GEF_DESGEF'
      MaxLength = 40
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
    Left = 365
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 0
  end
end
