inherited frmObservacaoGenerica: TfrmObservacaoGenerica
  Width = 473
  Height = 200
  Caption = 'Digite uma observa'#231#227'o para esta "TA"'
  ExplicitWidth = 473
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 127
    Width = 467
    ExplicitTop = 131
    ExplicitWidth = 467
    inherited btnSair: TBitBtnLocked
      Left = 384
      ExplicitLeft = 384
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 155
    Width = 467
    ExplicitTop = 159
    ExplicitWidth = 467
    inherited pnlNomeForm: TPanel
      Left = 296
      ExplicitLeft = 296
    end
    inherited pnlInfo: TPanel
      Width = 296
      ExplicitWidth = 296
    end
  end
  object mmoObservacao: TMemo [3]
    Left = 0
    Top = 0
    Width = 467
    Height = 127
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 131
  end
end
