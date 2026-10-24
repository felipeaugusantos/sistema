inherited frmConsultaPedidoCompra: TfrmConsultaPedidoCompra
  Left = 175
  Top = 166
  Width = 794
  Height = 570
  Caption = 'Consulta - Pedido de Compra'
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Width = 786
    Height = 320
  end
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 786
    inherited btnSair: TBitBtn
      Left = 697
    end
  end
  inherited stbStatus: TStatusBar
    Top = 517
    Width = 786
  end
  inherited Panel1: TPanel
    Top = 353
    Width = 786
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 320
    Width = 786
    Height = 33
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object btnEnviarEmail: TBitBtn
      Left = 8
      Top = 3
      Width = 127
      Height = 25
      Caption = '[ F9 ] - Enviar email'
      TabOrder = 0
      OnClick = btnEnviarEmailClick
    end
    object btnBaixaPedido: TBitBtn
      Left = 142
      Top = 3
      Width = 235
      Height = 25
      Caption = '[F10] Baixar Pedidos que n'#227'o ser'#227'o entregues'
      TabOrder = 1
      OnClick = btnBaixaPedidoClick
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 520
  end
end
