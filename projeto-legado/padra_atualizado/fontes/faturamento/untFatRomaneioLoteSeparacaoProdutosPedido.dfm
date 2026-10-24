inherited frmFatRomaneioLoteSeparacaoProdutosPedido: TfrmFatRomaneioLoteSeparacaoProdutosPedido
  Width = 1061
  Height = 417
  Caption = 'Produtos do Pedido do Lote de Separa'#231#227'o'
  WindowState = wsMaximized
  ExplicitWidth = 1061
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 344
    Width = 1055
    ExplicitTop = 344
    ExplicitWidth = 1055
    inherited FlwBotoes: TFlowPanel
      Width = 1051
      ExplicitWidth = 1051
    end
    inherited btnSair: TBitBtnLocked
      Left = 972
      ExplicitLeft = 972
    end
  end
  inherited pnlStatus: TPanel
    Top = 372
    Width = 1055
    ExplicitTop = 372
    ExplicitWidth = 1055
    inherited pnlNomeForm: TPanel
      Left = 884
      ExplicitLeft = 884
    end
    inherited pnlInfo: TPanel
      Width = 884
      ExplicitWidth = 884
    end
  end
  object cxgProdutos: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1055
    Height = 315
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgProdutosTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsProdutosPedido
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.CellHints = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgProdutosColCodigo: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 120
      end
      object cxgProdutosColCodigoFabrica: TcxGridDBColumn
        Caption = 'C'#243'd F'#225'brica'
        DataBinding.FieldName = 'FABRIC'
        Width = 120
      end
      object cxgProdutosColCodigoBarras: TcxGridDBColumn
        Caption = 'C'#243'd Barras'
        DataBinding.FieldName = 'CODBAR'
        Width = 120
      end
      object cxgProdutosColDescricao: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'DESCRI'
        Width = 250
      end
      object cxgProdutosColUnidade: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNIDAD'
        Width = 50
      end
      object cxgProdutosColLote: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Width = 100
      end
      object cxgProdutosColReferencia: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 200
      end
      object cxgProdutosColMarca: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Width = 150
      end
      object cxgProdutosColQuantidade: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 90
      end
      object cxgProdutosColPeso: TcxGridDBColumn
        Caption = 'Peso'
        DataBinding.FieldName = 'TOTPES'
        Width = 90
      end
      object cxgProdutosColVendedor: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VENDED'
        Width = 250
      end
    end
    object cxgProdutosLevel: TcxGridLevel
      GridView = cxgProdutosTableView
    end
  end
  object pnlTotalizador: TPanel [3]
    Left = 0
    Top = 315
    Width = 1055
    Height = 29
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 901
      Top = 7
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantidadeProdutos: TLabel
      Left = 9
      Top = 7
      Width = 126
      Height = 14
      Caption = 'lblQuantidadeProdutos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtPesoTotal: TDBEdit
      Left = 967
      Top = 4
      Width = 80
      Height = 22
      BiDiMode = bdRightToLeft
      Color = 16768952
      DataField = 'TOTALPESO'
      DataSource = dtsProdutosPedido
      ParentBiDiMode = False
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 104
  end
  object cdsMovPedido: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 128
  end
  object cdsProdutosPedido: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FABRIC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODBAR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'UNIDAD'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NUMLOT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'REFERE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DESMAR'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'QTDITE'
        DataType = ftInteger
      end
      item
        Name = 'TOTPES'
        DataType = ftFloat
      end
      item
        Name = 'VENDED'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 176
    object cdsProdutosPedidoCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsProdutosPedidoFABRIC: TStringField
      FieldName = 'FABRIC'
    end
    object cdsProdutosPedidoCODBAR: TStringField
      FieldName = 'CODBAR'
    end
    object cdsProdutosPedidoDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsProdutosPedidoUNIDAD: TStringField
      FieldName = 'UNIDAD'
    end
    object cdsProdutosPedidoNUMLOT: TStringField
      FieldName = 'NUMLOT'
    end
    object cdsProdutosPedidoREFERE: TStringField
      FieldName = 'REFERE'
      Size = 100
    end
    object cdsProdutosPedidoDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 100
    end
    object cdsProdutosPedidoQTDITE: TIntegerField
      FieldName = 'QTDITE'
    end
    object cdsProdutosPedidoTOTPES: TFloatField
      FieldName = 'TOTPES'
    end
    object cdsProdutosPedidoVENDED: TStringField
      FieldName = 'VENDED'
      Size = 200
    end
    object cdsProdutosPedidoTOTALPESO: TAggregateField
      FieldName = 'TOTALPESO'
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'SUM(TOTPES)'
    end
  end
  object dtsProdutosPedido: TDataSource
    DataSet = cdsProdutosPedido
    Left = 424
    Top = 176
  end
end
