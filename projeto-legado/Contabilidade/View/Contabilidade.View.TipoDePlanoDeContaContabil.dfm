inherited frmTipoDePlanoDeContaContabil: TfrmTipoDePlanoDeContaContabil
  Width = 529
  Height = 142
  Caption = 'Tipo de Plano de Contas Cont'#225'bil'
  ExplicitWidth = 529
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 72
    Width = 523
    Height = 25
    ExplicitTop = 72
    ExplicitWidth = 523
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 448
      Height = 21
      ExplicitWidth = 448
      ExplicitHeight = 21
      inherited btnCancela: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 363
        Width = 75
        ExplicitLeft = 363
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      Width = 71
      Height = 21
      Align = alRight
      ExplicitLeft = 450
      ExplicitWidth = 71
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 523
    ExplicitTop = 97
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 280
      Width = 243
      ExplicitLeft = 280
      ExplicitWidth = 243
    end
    inherited pnlInfo: TPanel
      Width = 280
      ExplicitWidth = 280
    end
  end
  inherited pgcDados: TPageControl
    Width = 523
    Height = 72
    TabOrder = 3
    ExplicitWidth = 523
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 515
      ExplicitHeight = 40
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 72
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 39
      Top = 18
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 424
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ACO_DESCRI'
      DataSource = dtsTipPla
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ACO_CODIGO'
      DataSource = dtsTipPla
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 0
  end
  object dtsTipPla: TDataSource
    Left = 252
  end
end
