inherited frmOpcPoupupRadio: TfrmOpcPoupupRadio
  Width = 197
  Height = 102
  Caption = 'Escolha'
  Position = poScreenCenter
  ExplicitWidth = 197
  ExplicitHeight = 102
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 29
    Width = 191
    ExplicitTop = 29
    ExplicitWidth = 191
    inherited FlwBotoes: TFlowPanel
      Width = 187
      ExplicitWidth = 187
      object BitBtnLocked1: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirmar'
        Kind = bkOK
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnSairClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 108
      ExplicitLeft = 108
    end
  end
  inherited pnlStatus: TPanel
    Top = 57
    Width = 191
    ExplicitTop = 57
    ExplicitWidth = 191
    inherited pnlNomeForm: TPanel
      Left = 20
      ExplicitLeft = 20
    end
    inherited pnlInfo: TPanel
      Width = 20
      ExplicitWidth = 20
    end
  end
  object rdgOpc: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 191
    Height = 29
    Align = alClient
    Caption = 'Op'#231#245'es:'
    TabOrder = 2
  end
end
