inherited frmDigMotivo: TfrmDigMotivo
  Height = 125
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitHeight = 125
  PixelsPerInch = 96
  TextHeight = 14
  object lblMotivo: TLabel [0]
    Left = 8
    Top = 8
    Width = 226
    Height = 14
    Caption = 'Motivo da baixar parcial da ordem de produ'#231#227'o'
  end
  inherited pnlBotoes: TPanel
    Top = 52
    ExplicitTop = 52
    inherited FlwBotoes: TFlowPanel
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Confirmar'
        OnClick = SpeedButton1Click
      end
    end
    inherited btnSair: TBitBtnLocked
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 80
    ExplicitTop = 80
  end
  object edtMotivo: TEdit [3]
    Left = 8
    Top = 24
    Width = 467
    Height = 22
    MaxLength = 70
    TabOrder = 2
  end
end
