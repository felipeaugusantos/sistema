inherited frmFatMenuOutEntradas: TfrmFatMenuOutEntradas
  Left = 318
  Top = 302
  Width = 237
  Height = 163
  Caption = 'Outras Entradas para:'
  ExplicitWidth = 237
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 90
    Width = 231
    ExplicitTop = 90
    ExplicitWidth = 231
    inherited btnSair: TBitBtnLocked
      Left = 151
      Cancel = False
      ExplicitLeft = 151
    end
    inherited btnConfirma: TBitBtnLocked
      Caption = 'Confirma'
      Kind = bkOK
    end
  end
  object rdgOpcao: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 231
    Height = 90
    Align = alClient
    ItemIndex = 0
    Items.Strings = (
      'Cliente'
      'Fornecedor')
    TabOrder = 2
    OnClick = rdgOpcaoClick
  end
  inherited pnlStatus: TPanel
    Top = 118
    Width = 231
    Visible = False
    ExplicitTop = 118
    ExplicitWidth = 231
    inherited pnlNomeForm: TPanel
      Left = 60
      ExplicitLeft = 60
    end
    inherited pnlInfo: TPanel
      Width = 60
      ExplicitWidth = 60
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 8
  end
end
