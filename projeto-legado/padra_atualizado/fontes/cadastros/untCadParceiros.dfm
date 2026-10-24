inherited frmCadParceiros: TfrmCadParceiros
  Left = 278
  Top = 339
  Width = 542
  Height = 142
  Caption = 'Cadastro de Parceiros'
  ExplicitWidth = 542
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 536
    Height = 25
    TabOrder = 1
    ExplicitTop = 72
    ExplicitWidth = 536
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 457
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 532
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 75
        ExplicitLeft = 74
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 149
        Width = 75
        ExplicitLeft = 149
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 224
        Width = 74
        ExplicitLeft = 224
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 298
        Width = 74
        ExplicitLeft = 298
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 372
        Width = 75
        ExplicitLeft = 372
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      Width = 75
      Height = 21
      Align = alRight
      ExplicitLeft = 458
      ExplicitWidth = 75
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 1344
    Top = 728
    Width = 73
    Height = 57
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitLeft = 1344
    ExplicitTop = 728
    ExplicitWidth = 73
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 25
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 536
    Height = 72
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 11
      Top = 14
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object lbl4: TLabel
      Left = 17
      Top = 38
      Width = 30
      Height = 14
      Caption = 'Nome:'
    end
    object dbeCodPar: TDBEditFocus
      Tag = 99
      Left = 51
      Top = 8
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PAR_CODPAR'
      DataSource = dtsCadPar
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNomPar: TDBEditFocus
      Tag = 99
      Left = 51
      Top = 32
      Width = 462
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PAR_NOMPAR'
      DataSource = dtsCadPar
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 536
    TabOrder = 2
    ExplicitTop = 97
    ExplicitWidth = 536
    inherited pnlNomeForm: TPanel
      Left = 368
      Width = 168
      ExplicitLeft = 368
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 552
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 8
  end
  object dtsCadPar: TDataSource
    Left = 400
    Top = 16
  end
end
