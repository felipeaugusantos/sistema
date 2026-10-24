object frmPnlDadosPedCompra: TfrmPnlDadosPedCompra
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmPnlDadosPedCompra'
  ClientHeight = 317
  ClientWidth = 1156
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1156
    Height = 317
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnl2: TPanel
      Left = 0
      Top = 202
      Width = 1156
      Height = 115
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
      object shpRed: TShape
        Left = 8
        Top = 48
        Width = 17
        Height = 17
        Brush.Color = clRed
        Pen.Style = psClear
      end
      object Shape2: TShape
        Left = 211
        Top = 48
        Width = 17
        Height = 17
        Brush.Color = clBlue
        Pen.Style = psClear
      end
      object Shape3: TShape
        Left = 8
        Top = 65
        Width = 17
        Height = 17
        Brush.Color = clBlack
        Pen.Style = psClear
      end
      object Label1: TLabel
        Left = 29
        Top = 50
        Width = 170
        Height = 13
        Caption = 'Pedidos n'#227'o Entregues e em atraso'
      end
      object Label2: TLabel
        Left = 230
        Top = 50
        Width = 213
        Height = 13
        Caption = 'Pedidos Entregues Parcialmente e em atraso'
      end
      object Label3: TLabel
        Left = 29
        Top = 67
        Width = 173
        Height = 13
        Caption = 'Pedidos dentro do prazo de entrega'
      end
      object Shape1: TShape
        Left = 211
        Top = 66
        Width = 17
        Height = 17
        Brush.Color = clFuchsia
        Pen.Style = psClear
      end
      object Label9: TLabel
        Left = 230
        Top = 68
        Width = 162
        Height = 13
        Caption = 'Pedido com nova data de entrega'
      end
      object shpPreNota: TShape
        Left = 8
        Top = 83
        Width = 17
        Height = 17
        Brush.Color = 33023
        Pen.Style = psClear
      end
      object lblPreNota: TLabel
        Left = 31
        Top = 83
        Width = 99
        Height = 13
        Hint = 'A coluna '#39'Pr'#233'-Nota'#39' precisa estar vis'#237'vel no grid'
        Caption = 'Pedidos em pr'#233'-nota'
        ParentShowHint = False
        ShowHint = True
      end
      object chkAplPro: TCheckBox
        Left = 8
        Top = 2
        Width = 169
        Height = 17
        Caption = 'Imprimir Aplica'#231#227'o do Produto'
        TabOrder = 0
      end
      object btnGerarPDF: TBitBtnLocked
        Left = 132
        Top = 21
        Width = 109
        Height = 25
        Caption = '[ F8 ] - Gerar PDF'
        TabOrder = 2
        OnClick = btnGerarPDFClick
      end
      object btnEnviarEmail: TBitBtnLocked
        Left = 241
        Top = 21
        Width = 108
        Height = 25
        Caption = '[ F9 ] - Enviar email'
        TabOrder = 3
        OnClick = btnEnviarEmailClick
      end
      object btnBaixaPedido: TBitBtnLocked
        Left = 349
        Top = 21
        Width = 234
        Height = 25
        Caption = '[F10] Baixar Pedidos que n'#227'o ser'#227'o entregues'
        TabOrder = 4
        OnClick = btnBaixaPedidoClick
      end
      object btnItensPend: TBitBtnLocked
        Left = 583
        Top = 21
        Width = 160
        Height = 25
        Caption = '[F11] Mostrar itens pendentes'
        TabOrder = 5
        OnClick = btnItensPendClick
      end
      object btnGerarXLS: TBitBtnLocked
        Left = 8
        Top = 21
        Width = 124
        Height = 25
        Caption = '[ F7 ] - Gerar XLS'
        TabOrder = 1
        OnClick = btnGerarXLSClick
      end
      object btnConPedCmp: TBitBtnLocked
        Left = 743
        Top = 21
        Width = 189
        Height = 25
        Caption = '[F6] Consulta de Pedido De Compras'
        TabOrder = 6
        OnClick = btnConPedCmpClick
      end
      object btnExportacao: TBitBtnLocked
        Left = 743
        Top = 45
        Width = 189
        Height = 25
        Caption = '[F5] Op'#231#245'es de Exporta'#231#227'o'
        TabOrder = 7
        OnClick = btnExportacaoClick
      end
      object btnNovaDataEntrega: TBitBtnLocked
        Left = 450
        Top = 45
        Width = 154
        Height = 25
        Caption = '[ F4 ] Nova data de Entrega'
        TabOrder = 8
        OnClick = btnNovaDataEntregaClick
      end
      object btnLogDataAlterada: TBitBtnLocked
        Left = 604
        Top = 45
        Width = 139
        Height = 25
        Caption = '[Shift F5] Log Data Entrega'
        TabOrder = 9
        OnClick = btnLogDataAlteradaClick
      end
      object btnDesBaixaPed: TBitBtnLocked
        Left = 450
        Top = 69
        Width = 293
        Height = 25
        Caption = '[Shift F8] - Desfazer baixa de pedidos n'#227'o entregues '
        TabOrder = 10
        OnClick = btnDesBaixaPedClick
      end
      object btnNovaDataFaturamento: TBitBtnLocked
        Left = 743
        Top = 69
        Width = 189
        Height = 25
        Caption = '[ F12 ] Nova Data de Faturamento'
        TabOrder = 11
        OnClick = btnNovaDataFaturamentoClick
      end
      object btnLogDataFaturamento: TBitBtnLocked
        Left = 932
        Top = 69
        Width = 213
        Height = 25
        Caption = '[ Shift F12 ] Log Data de Faturamento'
        TabOrder = 12
        OnClick = btnLogDataFaturamentoClick
      end
    end
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 1156
      Height = 202
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 17
        Top = 83
        Width = 768
        Height = 105
        Caption = 'Email:'
        TabOrder = 0
        object Label4: TLabel
          Left = 7
          Top = 23
          Width = 71
          Height = 13
          Caption = 'Data do envio:'
        end
        object Label5: TLabel
          Left = 91
          Top = 23
          Width = 71
          Height = 13
          Caption = 'Hora do envio:'
        end
        object Label6: TLabel
          Left = 7
          Top = 61
          Width = 107
          Height = 13
          Caption = 'Nome do Destinat'#225'rio:'
        end
        object Label7: TLabel
          Left = 328
          Top = 61
          Width = 104
          Height = 13
          Caption = 'Email do Destinat'#225'rio:'
        end
        object Label8: TLabel
          Left = 172
          Top = 23
          Width = 50
          Height = 13
          Caption = 'Operador:'
        end
        object DBEditFocus1: TDBEditFocus
          Left = 7
          Top = 36
          Width = 82
          Height = 21
          DataField = 'PCG_DTAMAI'
          DataSource = dtsPedidos
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus2: TDBEditFocus
          Left = 91
          Top = 36
          Width = 79
          Height = 21
          DataField = 'PCG_HORMAI'
          DataSource = dtsPedidos
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus3: TDBEditFocus
          Left = 7
          Top = 75
          Width = 318
          Height = 21
          DataField = 'PCG_NOMMAI'
          DataSource = dtsPedidos
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus4: TDBEditFocus
          Left = 328
          Top = 75
          Width = 425
          Height = 21
          DataField = 'PCG_DESMAI'
          DataSource = dtsPedidos
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus5: TDBEditFocus
          Left = 172
          Top = 36
          Width = 581
          Height = 21
          DataField = 'PCG_NOPEMA'
          DataSource = dtsPedidos
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object dbeObservacoes: TDBMemo
        Left = 20
        Top = 11
        Width = 765
        Height = 66
        DataField = 'OBSMEMO'
        DataSource = dtsPedidos
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object dtsPedidos: TDataSource
    Left = 640
    Top = 32
  end
end
