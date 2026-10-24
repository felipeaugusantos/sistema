inherited frmPedidoCompraLiberacao: TfrmPedidoCompraLiberacao
  Left = 270
  Top = 169
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = 'Libera'#231#227'o de Pedidos de Compra'
  ClientHeight = 423
  ClientWidth = 944
  Position = poMainFormCenter
  ExplicitWidth = 950
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 944
    ExplicitTop = 379
    ExplicitWidth = 944
    inherited FlwBotoes: TFlowPanel
      Width = 940
      ExplicitWidth = 940
      inherited btnPesquisar: TBitBtnLocked
        Width = 101
        ExplicitWidth = 101
      end
      object btnConfirma: TBitBtnLocked
        Left = 219
        Top = 0
        Width = 115
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnVencimentos: TBitBtnLocked
        Left = 334
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F8 ] Vencimentos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460FEEBF82E98E3593460FFF00FF00000000000000
          0000000000000000000000000000000000000000000000FF00FF93460F5DD270
          F7DAB793460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnVencimentosClick
      end
      object btnConsulta: TBitBtnLocked
        Left = 462
        Top = 0
        Width = 97
        Height = 22
        Caption = '[ F9 ] &Consultar'
        TabOrder = 4
        OnClick = btnConsultaClick
      end
      object btnDetalhes: TBitBtnLocked
        Left = 559
        Top = 0
        Width = 88
        Height = 22
        Caption = '[ F11 ] &Detalhes'
        TabOrder = 5
        OnClick = btnDetalhesClick
      end
      object btnOpcaoSelecao: TBitBtnLocked
        Left = 647
        Top = 0
        Width = 106
        Height = 22
        Caption = 'Op'#231#245'es de Sele'#231#227'o'
        PopupMenu = popOpSele
        TabOrder = 6
        OnClick = btnOpcaoSelecaoClick
      end
      object btnConsultarFornecedor: TBitBtnLocked
        Left = 753
        Top = 0
        Width = 112
        Height = 22
        Caption = 'Consultar Fornecedor'
        TabOrder = 7
        OnClick = btnConsultarFornecedorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 867
      Top = 2
      Width = 74
      ExplicitLeft = 867
      ExplicitTop = 2
      ExplicitWidth = 74
    end
  end
  inherited pnlStatus: TPanel
    Top = 407
    Width = 944
    ExplicitTop = 407
    ExplicitWidth = 944
    inherited pnlNomeForm: TPanel
      Left = 773
      ExplicitLeft = 773
    end
    inherited pnlInfo: TPanel
      Width = 773
      ExplicitWidth = 773
    end
  end
  inherited pnlHeader: TPanel
    Width = 944
    Visible = False
    ExplicitWidth = 944
  end
  inherited pnlTail: TPanel
    Top = 331
    Width = 944
    ExplicitTop = 331
    ExplicitWidth = 944
  end
  inherited dbgConsulta: TDBGridCitel
    Width = 944
    Height = 234
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PCG_DTAENT'
        Title.Alignment = taCenter
        Title.Caption = 'Data de Entrega'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAPED'
        Title.Caption = 'Data do Pedido'
        Width = 87
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PCG_NUMPED'
        Title.Alignment = taCenter
        Title.Caption = 'Pedido'
        Width = 118
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PCG_CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 47
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PCG_CODFOR'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFOR'
        Title.Caption = 'Nome Fornecedor'
        Width = 270
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODCMP'
        Title.Caption = 'Operador'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        Title.Caption = 'Nome Operador'
        Width = 170
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Width = 944
    ExplicitWidth = 944
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 56
    Top = 0
  end
  inherited qryConsulta: TUniQuery
    Left = 16
    Top = 136
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 48
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 96
    Top = 136
  end
  inherited dtsConsulta: TDataSource
    Left = 144
    Top = 136
  end
  object popOpSele: TPopupMenu
    Left = 660
    Top = 44
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = InverterSeleo1Click
    end
    object DesmarcarTodos1: TMenuItem
      Tag = 1
      Caption = 'Desmarcar Todos'
      OnClick = InverterSeleo1Click
    end
    object N1: TMenuItem
      Caption = '-'
      OnClick = InverterSeleo1Click
    end
    object InverterSeleo1: TMenuItem
      Tag = 2
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
