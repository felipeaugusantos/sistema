inherited frmMostraDashboard: TfrmMostraDashboard
  Width = 789
  Height = 611
  BorderStyle = bsSizeable
  Caption = 'frmMostraDashboard'
  Position = poMainFormCenter
  ExplicitWidth = 789
  ExplicitHeight = 611
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 773
    ExplicitTop = 528
    ExplicitWidth = 773
    inherited FlwBotoes: TFlowPanel
      Width = 769
      ExplicitWidth = 769
    end
    inherited btnSair: TBitBtnLocked
      Left = 690
      ExplicitLeft = 690
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 773
    ExplicitTop = 556
    ExplicitWidth = 773
    inherited pnlNomeForm: TPanel
      Left = 602
      ExplicitLeft = 602
    end
    inherited pnlInfo: TPanel
      Width = 602
      ExplicitWidth = 602
    end
  end
  object TMSFNCWebBrowser: TTMSFNCWebBrowser [2]
    Left = 0
    Top = 0
    Width = 773
    Height = 528
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 2
    URL = 'https://dashboard.citelsoftware.com.br'
  end
end
