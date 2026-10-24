inherited frmWebBrowser: TfrmWebBrowser
  Width = 1024
  Height = 768
  Caption = 'Browser'
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 723
    Width = 1018
    Height = 0
    Visible = False
    ExplicitTop = 723
    ExplicitWidth = 1018
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      Top = -25
      ExplicitLeft = 938
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object webBrowser: TTMSFNCWebBrowser [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 723
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    ParentDoubleBuffered = False
    StyleElements = []
    DoubleBuffered = True
    TabOrder = 2
    URL = 'about:blank'
    OnNavigateComplete = webBrowserNavigateComplete
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 152
    Top = 568
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 464
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 512
  end
  object Timer: TTimer
    Interval = 5000
    Left = 152
    Top = 416
  end
end
