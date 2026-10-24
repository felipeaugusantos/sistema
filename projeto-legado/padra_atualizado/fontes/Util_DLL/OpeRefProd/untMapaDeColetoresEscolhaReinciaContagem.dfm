inherited frmMapaDeColetoresEscolhaReinciaContagem: TfrmMapaDeColetoresEscolhaReinciaContagem
  Width = 476
  Height = 165
  Caption = 'frmMapaDeColetoresEscolhaReinciaContagem'
  Position = poScreenCenter
  ExplicitWidth = 476
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 470
    Height = 27
    ExplicitTop = 96
    ExplicitWidth = 470
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 466
      Height = 23
      ExplicitWidth = 466
      ExplicitHeight = 23
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirma'
        Kind = bkOK
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 368
      Top = 2
      Width = 100
      ExplicitLeft = 368
      ExplicitTop = 2
      ExplicitWidth = 100
    end
  end
  inherited pnlStatus: TPanel
    Top = 120
    Width = 470
    ExplicitTop = 123
    ExplicitWidth = 470
    inherited pnlNomeForm: TPanel
      Left = 175
      Width = 295
      ExplicitLeft = 175
      ExplicitWidth = 295
    end
    inherited pnlInfo: TPanel
      Width = 175
      ExplicitWidth = 175
    end
  end
  object rdgOpcao: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 470
    Height = 93
    Align = alClient
    Caption = 'Escolha como deseja reiniciar a contagem da localiza'#231#227'o  %s'
    TabOrder = 2
    ExplicitTop = -4
  end
end
