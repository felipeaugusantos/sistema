object frmPnlDadosPedidoCompra: TfrmPnlDadosPedidoCompra
  Left = 0
  Top = 0
  Align = alBottom
  BorderStyle = bsNone
  Caption = 'frmPnlDadosPedidoCompra'
  ClientHeight = 54
  ClientWidth = 434
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancPedidoFilhote: TBitBtnLocked
    Left = 142
    Top = 15
    Width = 150
    Height = 25
    Caption = '[ F4 ] Cancela Pedido Filhote'
    TabOrder = 0
    OnClick = btnCancPedidoFilhoteClick
  end
  object dtsPedidos: TDataSource
    Left = 304
    Top = 16
  end
end
