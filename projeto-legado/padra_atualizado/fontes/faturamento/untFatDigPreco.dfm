inherited frmFatDigPreco: TfrmFatDigPreco
  Width = 632
  Height = 165
  Caption = 'Estrat'#233'gia de pre'#231'o'
  ExplicitWidth = 632
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 94
    Width = 626
    TabOrder = 2
    ExplicitTop = 94
    ExplicitWidth = 626
    inherited FlwBotoes: TFlowPanel
      Width = 622
      ExplicitTop = 2
      ExplicitWidth = 622
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 546
      ExplicitLeft = 546
    end
  end
  inherited pnlStatus: TPanel
    Top = 120
    Width = 626
    ExplicitTop = 120
    ExplicitWidth = 626
    inherited pnlNomeForm: TPanel
      Left = 455
      ExplicitLeft = 455
    end
    inherited pnlInfo: TPanel
      Width = 455
      ExplicitWidth = 455
    end
  end
  object rdgPreco: TRadioGroup [3]
    Left = 0
    Top = 5
    Width = 618
    Height = 83
    Caption = 'Tipo Pre'#231'o'
    ItemIndex = 0
    Items.Strings = (
      'Carregar pre'#231'o de tabela atual sem desconto'
      
        'Carregar pre'#231'o de tabela atual com desconto em percentual pratic' +
        'ado no produto do documento original'
      'Carregar pre'#231'o praticado no documento original, sem desconto'
      
        'Carregar pre'#231'o praticado no documento original, com desconto em ' +
        'percentual praticado no produto do documento original')
    TabOrder = 0
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 144
  end
end
