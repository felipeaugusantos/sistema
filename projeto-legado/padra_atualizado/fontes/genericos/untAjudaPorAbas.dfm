inherited frmAjudaPorAbas: TfrmAjudaPorAbas
  Width = 800
  Height = 600
  Caption = 'Ajuda  - Configura'#231#227'o de Provedores de e-Mail'
  Color = clWhite
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 794
    ExplicitTop = 527
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object cxPageControl1: TcxPageControl [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 527
    Align = alClient
    TabOrder = 2
    Properties.CustomButtons.Buttons = <>
    Properties.Style = 5
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = ''
    ClientRectBottom = 527
    ClientRectRight = 794
    ClientRectTop = 0
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 360
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
    Top = 416
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 480
  end
end
