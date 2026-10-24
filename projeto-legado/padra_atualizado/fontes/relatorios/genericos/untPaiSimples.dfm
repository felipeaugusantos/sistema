inherited frmPaiSimples: TfrmPaiSimples
  Left = 33
  Top = 74
  Width = 775
  Height = 505
  VertScrollBar.Range = 19
  Caption = 'frmPaiSimples'
  OnClose = FormClose
  ExplicitWidth = 775
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 464
    Width = 769
    Height = 0
    Enabled = False
    TabOrder = 2
    Visible = False
    ExplicitTop = 464
    ExplicitWidth = 769
    ExplicitHeight = 0
    DesignSize = (
      769
      0)
    inherited btnSair: TBitBtnLocked
      Left = 691
      Top = -25
      ExplicitLeft = 691
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 464
    Width = 769
    ExplicitTop = 461
    ExplicitWidth = 769
    inherited pnlNomeForm: TPanel
      Left = 598
      ExplicitLeft = 598
    end
    inherited pnlInfo: TPanel
      Width = 598
      ExplicitWidth = 598
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 769
    Height = 464
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    ExplicitHeight = 461
    object tbsGeral: TTabSheet
      Caption = '1 - Geral'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 16
  end
end
