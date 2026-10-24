inherited frmCadProFotoURL: TfrmCadProFotoURL
  Left = 254
  Top = 204
  Width = 808
  Height = 627
  Caption = 'Produto'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 808
  ExplicitHeight = 627
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 555
    Width = 802
    Height = 27
    ExplicitTop = 555
    ExplicitWidth = 802
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 721
      Height = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 723
      Top = 2
      Height = 23
      Align = alRight
      ExplicitLeft = 723
      ExplicitTop = 2
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 582
    Width = 802
    ExplicitTop = 582
    ExplicitWidth = 802
    inherited pnlNomeForm: TPanel
      Left = 631
      ExplicitLeft = 631
    end
    inherited pnlInfo: TPanel
      Width = 631
      ExplicitWidth = 631
    end
  end
  object pnlImage: TPanel [2]
    Left = 0
    Top = 0
    Width = 802
    Height = 555
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
  end
end
