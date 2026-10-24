inherited frmConsultaFatPedOrc: TfrmConsultaFatPedOrc
  Left = 161
  Top = 112
  Caption = 'Consulta de Pedido / Or'#231'amento'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 312
  end
  inherited Panel1: TPanel
    object shpFatPar: TShape [7]
      Left = 524
      Top = 105
      Width = 12
      Height = 12
      Brush.Color = clRed
    end
    object lblOrdPro: TLabel [8]
      Left = 540
      Top = 105
      Width = 110
      Height = 13
      Caption = 'Faturados parcialmente'
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 312
    Width = 780
    Height = 34
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object btnEnviarEmail: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 128
      Height = 25
      Caption = '[ F9 ] - Enviar email'
      TabOrder = 0
      OnClick = btnEnviarEmailClick
    end
    object btnGerarPDF: TBitBtnLocked
      Left = 136
      Top = 3
      Width = 124
      Height = 25
      Caption = '[ F8 ] - Gerar PDF'
      TabOrder = 1
      OnClick = btnGerarPDFClick
    end
    object btnBaixaPedido: TBitBtnLocked
      Left = 260
      Top = 3
      Width = 234
      Height = 25
      Caption = '[F10] Baixar Pedidos que n'#227'o ser'#227'o entregues'
      TabOrder = 2
      OnClick = btnBaixaPedidoClick
    end
    object btnItensPend: TBitBtnLocked
      Left = 494
      Top = 3
      Width = 160
      Height = 25
      Caption = '[F11] Mostrar itens pendentes'
      TabOrder = 3
      OnClick = btnItensPendClick
    end
  end
end
