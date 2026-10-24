inherited frmCadCargos: TfrmCadCargos
  Height = 145
  Caption = 'Cadastro de Cargos'
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 75
    Height = 25
    ExplicitTop = 75
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Height = 21
      ExplicitTop = 2
      inherited btnIncluir: TBitBtnLocked
        Width = 84
        ExplicitWidth = 84
      end
      inherited btnGravar: TBitBtnLocked
        Left = 84
        Width = 84
        ExplicitLeft = 84
        ExplicitWidth = 84
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 168
        Width = 84
        ExplicitLeft = 168
        ExplicitWidth = 84
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 252
        Width = 84
        ExplicitLeft = 252
        ExplicitWidth = 84
      end
      inherited btnCancela: TBitBtnLocked
        Left = 336
        Width = 84
        ExplicitLeft = 336
        ExplicitWidth = 84
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 420
        Width = 84
        ExplicitLeft = 420
        ExplicitWidth = 84
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 505
      Width = 72
      Height = 20
      ExplicitLeft = 505
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Height = 75
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 40
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 75
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 72
    object Label1: TLabel
      Left = 32
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 13
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CGO_CODCGO'
      DataSource = dtsCadCgo
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesCgo: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 36
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CGO_DESCGO'
      DataSource = dtsCadCgo
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
    Top = 100
    ExplicitTop = 100
    inherited pnlNomeForm: TPanel
      Left = 392
      Width = 193
      ExplicitLeft = 392
      ExplicitWidth = 193
    end
    inherited pnlInfo: TPanel
      Width = 392
    end
  end
  object dtsCadCgo: TDataSource
    Left = 344
  end
end
