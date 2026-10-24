inherited frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico
  Width = 1030
  Height = 479
  Caption = 'Reten'#231#245'es  Nota de Entrada'
  ExplicitWidth = 1030
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 408
    Width = 1024
    ExplicitTop = 408
    ExplicitWidth = 795
    inherited FlwBotoes: TFlowPanel
      Width = 1020
      ExplicitWidth = 791
    end
    inherited btnSair: TBitBtnLocked
      Left = 944
      Visible = False
      ExplicitLeft = 715
    end
  end
  inherited pnlStatus: TPanel
    Top = 434
    Width = 1024
    ExplicitTop = 434
    ExplicitWidth = 795
    inherited pnlNomeForm: TPanel
      Left = 853
      ExplicitLeft = 624
    end
    inherited pnlInfo: TPanel
      Width = 853
      ExplicitWidth = 624
    end
  end
  object pnlContainer: TPanel [2]
    Left = 0
    Top = 0
    Width = 1024
    Height = 408
    Align = alClient
    Caption = 'pnlContainer'
    ParentColor = True
    TabOrder = 2
    ExplicitWidth = 795
  end
end
