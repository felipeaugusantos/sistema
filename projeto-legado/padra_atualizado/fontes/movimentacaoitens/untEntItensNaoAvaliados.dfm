inherited frmEntItensNaoAvaliados: TfrmEntItensNaoAvaliados
  Top = 180
  Width = 533
  Height = 434
  ActiveControl = memItens
  Caption = 'Itens n'#227'o avaliados'
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 363
    Width = 525
    inherited btnSair: TBitBtn
      Left = 444
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 525
    inherited pnlNomeForm: TPanel
      Left = 354
    end
    inherited pnlInfo: TPanel
      Width = 354
    end
  end
  object memItens: TMemo [2]
    Left = 0
    Top = 0
    Width = 525
    Height = 363
    Align = alClient
    ReadOnly = True
    TabOrder = 2
    OnKeyDown = memItensKeyDown
  end
end
