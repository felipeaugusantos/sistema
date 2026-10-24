inherited frmConfirmaMultiploVenda: TfrmConfirmaMultiploVenda
  Width = 312
  Height = 140
  Caption = 'Confirma M'#250'ltiplo de Venda'
  ExplicitWidth = 312
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 306
    inherited FlwBotoes: TFlowPanel
      Width = 302
    end
    inherited btnSair: TBitBtnLocked
      Left = 223
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 306
    inherited pnlNomeForm: TPanel
      Left = 135
    end
    inherited pnlInfo: TPanel
      Width = 135
    end
  end
  object rdgMultVenda: TRadioGroup [3]
    Left = 0
    Top = 0
    Width = 306
    Height = 69
    Align = alClient
    ItemIndex = 0
    Items.Strings = (
      'Ajustar para o m'#250'ltiplo de venda'
      'Manter a quantidade informada')
    TabOrder = 3
    ExplicitLeft = 72
    ExplicitTop = 48
    ExplicitWidth = 185
    ExplicitHeight = 105
  end
end
