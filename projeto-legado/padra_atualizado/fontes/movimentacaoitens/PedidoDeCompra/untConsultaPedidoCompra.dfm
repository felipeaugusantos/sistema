inherited frmConsultaPedidoCompra: TfrmConsultaPedidoCompra
  Left = 298
  Top = 151
  Width = 794
  Height = 570
  Caption = 'Consulta - Pedido de Compra'
  Position = poDefault
  ExplicitWidth = 794
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Width = 778
    Height = 256
  end
  inherited pnlBotoes: TPanel
    Top = 479
    Width = 778
    ExplicitTop = 479
    ExplicitWidth = 778
    inherited btnSair: TBitBtnLocked
      Left = 625
      ExplicitLeft = 625
    end
  end
  inherited stbStatus: TStatusBar
    Top = 513
    Width = 778
    ExplicitTop = 513
    ExplicitWidth = 778
  end
  inherited Panel1: TPanel
    Top = 349
    Width = 778
    ExplicitTop = 349
    ExplicitWidth = 778
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 256
    Width = 778
    Height = 93
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 12
      Width = 57
      Height = 13
      Caption = 'Email: Data:'
    end
    object Label4: TLabel
      Left = 172
      Top = 12
      Width = 26
      Height = 13
      Caption = 'Hora:'
    end
    object Label5: TLabel
      Left = 18
      Top = 36
      Width = 47
      Height = 13
      Caption = 'Operador:'
    end
    object Label6: TLabel
      Left = 284
      Top = 36
      Width = 59
      Height = 13
      Caption = 'Destinat'#225'rio:'
    end
    object lbl1: TLabel
      Left = 303
      Top = 10
      Width = 40
      Height = 13
      Caption = 'Contato:'
    end
    object btnEnviarEmail: TBitBtn
      Left = 244
      Top = 59
      Width = 127
      Height = 25
      Caption = '[ F9 ] - Enviar email'
      TabOrder = 2
      OnClick = btnEnviarEmailClick
    end
    object btnBaixaPedido: TBitBtn
      Left = 371
      Top = 59
      Width = 235
      Height = 25
      Caption = '[F10] Baixar Pedidos que n'#227'o ser'#227'o entregues'
      TabOrder = 3
      OnClick = btnBaixaPedidoClick
    end
    object dbeDtaMai: TDBEdit
      Left = 68
      Top = 8
      Width = 97
      Height = 21
      DataField = 'PCG_DTAMAI'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
    end
    object dbeHorMai: TDBEdit
      Left = 204
      Top = 8
      Width = 73
      Height = 21
      DataField = 'PCG_HORMAI'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
    end
    object dbeOpeMai: TDBEdit
      Left = 68
      Top = 32
      Width = 209
      Height = 21
      DataField = 'PCG_OPEMAI'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
    end
    object dbeDesMai: TDBEdit
      Left = 347
      Top = 32
      Width = 285
      Height = 21
      DataField = 'PCG_DESMAI'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
    end
    object btnItensPend: TBitBtn
      Left = 606
      Top = 59
      Width = 160
      Height = 25
      Caption = '[F11] Mostrar itens pendentes'
      TabOrder = 4
      OnClick = btnItensPendClick
    end
    object btnGerPDF: TBitBtn
      Left = 117
      Top = 59
      Width = 127
      Height = 25
      Caption = '[ F8 ] - Gerar PDF'
      TabOrder = 1
      OnClick = btnGerPDFClick
    end
    object btnGerXLS: TBitBtn
      Left = 4
      Top = 59
      Width = 113
      Height = 25
      Caption = '[ F7 ] - Gerar XLS'
      TabOrder = 0
      OnClick = btnGerXLSClick
    end
    object dbeNomMai: TDBEdit
      Left = 347
      Top = 6
      Width = 285
      Height = 21
      DataField = 'PCG_NOMMAI'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
    end
  end
  inherited qryConsulta: TUniQuery
    AfterOpen = qryConsultaAfterOpen
  end
  inherited dtsConsulta: TDataSource
    Left = 520
  end
end
