inherited frmFatMenuOutSaidas: TfrmFatMenuOutSaidas
  Left = 318
  Top = 302
  Width = 237
  Height = 163
  Caption = 'Outras Sa'#237'das para:'
  ExplicitWidth = 237
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 92
    Width = 231
    ExplicitTop = 92
    ExplicitWidth = 231
    inherited FlwBotoes: TFlowPanel
      Width = 150
      ExplicitWidth = 227
      ExplicitHeight = 22
      inherited btnConfirma: TBitBtnLocked
        Caption = 'Confirma'
        Kind = bkOK
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 152
      Top = 2
      Align = alRight
      Cancel = False
      ExplicitLeft = 151
      ExplicitTop = 1
    end
  end
  object rdgOpcao: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 231
    Height = 92
    Align = alClient
    ItemIndex = 0
    Items.Strings = (
      'Cliente'
      'Cliente (mais de um or'#231'amento/pedido)'
      'Fornecedor'
      'Conserto de Equipamento')
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
