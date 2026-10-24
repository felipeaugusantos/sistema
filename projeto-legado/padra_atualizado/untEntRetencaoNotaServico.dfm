inherited frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico
  Width = 956
  Height = 650
  Caption = 'Reten'#231#245'es  Nota de Entrada'
  ExplicitWidth = 956
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 579
    Width = 950
    ExplicitTop = 579
    ExplicitWidth = 950
    inherited FlwBotoes: TFlowPanel
      Width = 946
      ExplicitWidth = 946
    end
    inherited btnSair: TBitBtnLocked
      Left = 870
      Visible = False
      ExplicitLeft = 870
    end
  end
  inherited pnlStatus: TPanel
    Top = 605
    Width = 950
    ExplicitTop = 605
    ExplicitWidth = 950
    inherited pnlNomeForm: TPanel
      Left = 779
      ExplicitLeft = 779
    end
    inherited pnlInfo: TPanel
      Width = 779
      ExplicitWidth = 779
    end
  end
  object pnlContainer: TPanel [2]
    Left = 0
    Top = 0
    Width = 950
    Height = 579
    Align = alClient
    Caption = 'pnlContainer'
    ParentColor = True
    TabOrder = 2
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 388
    Top = 224
  end
  object UniClientDataSet1: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 236
  end
end
