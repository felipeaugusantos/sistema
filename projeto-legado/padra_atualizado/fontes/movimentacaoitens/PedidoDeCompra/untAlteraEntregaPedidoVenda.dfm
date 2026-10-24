inherited frmAlteraEntregaPedidoVenda: TfrmAlteraEntregaPedidoVenda
  Height = 138
  Caption = 'Altera'#231#227'o da data de entrega do Pedido de Venda'
  ExplicitHeight = 138
  PixelsPerInch = 96
  TextHeight = 14
  object Label9: TLabel [0]
    Left = 87
    Top = 27
    Width = 179
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data de Entrega do Pedido de Venda:'
  end
  inherited pnlBotoes: TPanel
    Top = 67
    ExplicitTop = 67
  end
  inherited pnlStatus: TPanel
    Top = 93
    ExplicitTop = 93
  end
  object dbeENTVEN: TcxDBDateEdit [3]
    Tag = 99
    Left = 267
    Top = 23
    DataBinding.DataField = 'ENTVEN'
    TabOrder = 2
    Width = 90
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 64
  end
end
