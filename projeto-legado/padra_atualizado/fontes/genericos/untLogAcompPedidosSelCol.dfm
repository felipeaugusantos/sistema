inherited frmLogAcompPedidosSelCol: TfrmLogAcompPedidosSelCol
  Width = 518
  Height = 249
  BorderIcons = [biSystemMenu]
  Caption = 'Log de Acompanhamento de Pedidos - Sele'#231#227'o de Colunas'
  Position = poScreenCenter
  ExplicitWidth = 518
  ExplicitHeight = 249
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 6
    Top = 8
    Width = 159
    Height = 14
    Caption = 'Selecione as colunas desejadas:'
  end
  inherited pnlBotoes: TPanel
    Top = 176
    Width = 512
    TabOrder = 1
    inherited btnSair: TBitBtnLocked
      Left = 429
    end
  end
  inherited pnlStatus: TPanel
    Top = 204
    Width = 512
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 341
    end
    inherited pnlInfo: TPanel
      Width = 341
    end
  end
  object clbCamposTela: TCheckListBox [4]
    Left = 6
    Top = 25
    Width = 500
    Height = 144
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = 4
    ItemHeight = 14
    TabOrder = 0
    ExplicitWidth = 493
    ExplicitHeight = 164
  end
end
