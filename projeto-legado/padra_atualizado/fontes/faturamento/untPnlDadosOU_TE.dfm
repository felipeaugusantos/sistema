object frmPnlDadosOU_TE: TfrmPnlDadosOU_TE
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmPnlDadosOU_TE'
  ClientHeight = 45
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 45
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 800
    object btnGerarPDF: TBitBtnLocked
      Left = 8
      Top = 10
      Width = 124
      Height = 25
      Caption = '[ F8 ] - Gerar PDF'
      TabOrder = 0
      OnClick = btnGerarPDFClick
    end
    object btnEnviarEmail: TBitBtnLocked
      Left = 132
      Top = 10
      Width = 124
      Height = 25
      Caption = '[ F9 ] - Enviar email'
      TabOrder = 1
      OnClick = btnEnviarEmailClick
    end
    object btnBaixaPedido: TBitBtnLocked
      Left = 256
      Top = 10
      Width = 234
      Height = 25
      Caption = '[F10] Baixar Pedidos que n'#227'o ser'#227'o entregues'
      TabOrder = 2
      OnClick = btnBaixaPedidoClick
    end
    object btnItensPend: TBitBtnLocked
      Left = 490
      Top = 10
      Width = 160
      Height = 25
      Caption = '[F11] Mostrar itens pendentes'
      TabOrder = 3
      OnClick = btnItensPendClick
    end
    object btnImpSep: TBitBtnLocked
      Left = 650
      Top = 10
      Width = 160
      Height = 25
      Caption = '[ F7 ] - Imprimir Separa'#231#227'o'
      TabOrder = 4
      OnClick = btnImpSepClick
    end
  end
end
