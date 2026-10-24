inherited frmPgtOnlineEscolheTipoEnvioLink: TfrmPgtOnlineEscolheTipoEnvioLink
  Width = 614
  Height = 177
  Caption = 
    'Escolher a forma de Envio do Link de Pagamento ao Cliente Pagado' +
    'r.'
  ExplicitWidth = 614
  ExplicitHeight = 177
  PixelsPerInch = 96
  TextHeight = 14
  object lbOpcoesEnvio: TLabel [0]
    Left = 127
    Top = 21
    Width = 55
    Height = 14
    Caption = 'Enviar para'
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 608
    TabOrder = 2
    ExplicitTop = 106
    ExplicitWidth = 608
    inherited FlwBotoes: TFlowPanel
      Width = 604
      ExplicitWidth = 604
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 528
      ExplicitLeft = 528
    end
  end
  inherited pnlStatus: TPanel
    Top = 132
    Width = 608
    TabOrder = 3
    ExplicitTop = 132
    ExplicitWidth = 608
    inherited pnlNomeForm: TPanel
      Left = 437
      ExplicitLeft = 437
    end
    inherited pnlInfo: TPanel
      Width = 437
      ExplicitWidth = 437
    end
  end
  object rgOpcoes: TRadioGroup [3]
    Left = 8
    Top = 4
    Width = 113
    Height = 96
    Caption = 'Op'#231#245'es'
    ItemIndex = 0
    Items.Strings = (
      'E-Mail'
      'WhatsApp')
    TabOrder = 0
    OnClick = rgOpcoesClick
  end
  object cbOpcoesEnvio: TComboBox [4]
    Left = 127
    Top = 40
    Width = 473
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 1
    Visible = False
  end
end
