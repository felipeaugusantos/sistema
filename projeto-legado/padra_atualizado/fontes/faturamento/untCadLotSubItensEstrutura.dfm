inherited frmCadLotSubItensEstrutura: TfrmCadLotSubItensEstrutura
  Width = 791
  Height = 450
  Caption = 'Cadastro de Lotes Sub-Itens Estrutura'
  ExplicitWidth = 791
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 785
    ExplicitTop = 379
    ExplicitWidth = 785
    inherited FlwBotoes: TFlowPanel
      Width = 781
      ExplicitWidth = 781
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      ExplicitLeft = 705
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 785
    ExplicitTop = 405
    ExplicitWidth = 785
    inherited pnlNomeForm: TPanel
      Left = 614
      ExplicitLeft = 614
    end
    inherited pnlInfo: TPanel
      Width = 614
      ExplicitWidth = 614
    end
  end
  object cxgLotes: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 785
    Height = 379
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLotesTV: TcxGridDBTableViewCitel
      OnKeyPress = cxgLotesTVKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxgLotesTVEditKeyPress
      DataController.DataSource = DSLotes
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgLotesTVLOT_CODITE: TcxGridDBColumn
        DataBinding.FieldName = 'LOT_CODITE'
        Options.Editing = False
        Width = 61
      end
      object cxgLotesTVLOT_DESITE: TcxGridDBColumn
        DataBinding.FieldName = 'LOT_DESITE'
        Options.Editing = False
        Width = 315
      end
      object cxgLotesTVLOT_QTD: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'LOT_QTD'
        Options.Editing = False
      end
      object cxgLotesTVLOT_QTDPED: TcxGridDBColumn
        Caption = 'Quantidade Pedido'
        DataBinding.FieldName = 'LOT_QTDPED'
        Options.Editing = False
        Width = 100
      end
      object cxgLotesTVLOT_NUMLOT: TcxGridDBColumn
        DataBinding.FieldName = 'LOT_NUMLOT'
      end
      object cxgLotesTVLOT_SALDIS: TcxGridDBColumn
        Caption = 'Saldo dispon'#237'vel'
        DataBinding.FieldName = 'LOT_SALDIS'
        Options.Editing = False
        Width = 100
      end
    end
    object cxgLotesLevel1: TcxGridLevel
      GridView = cxgLotesTV
    end
  end
  object TLotes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = TLotesBeforePost
    Left = 312
    Top = 212
    object TLotesLOT_CODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'LOT_CODITE'
      Size = 5
    end
    object TLotesLOT_DESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'LOT_DESITE'
      Size = 70
    end
    object TLotesLOT_NUMLOT: TStringField
      DisplayLabel = 'Lote'
      FieldName = 'LOT_NUMLOT'
    end
    object TLotesLOT_SALDIS: TFloatField
      FieldName = 'LOT_SALDIS'
    end
    object TLotesLOT_CODEMP: TStringField
      FieldName = 'LOT_CODEMP'
      Size = 3
    end
    object TLotesLOT_CARREG: TStringField
      FieldName = 'LOT_CARREG'
      Size = 1
    end
    object TLotesLOT_QTD: TFloatField
      FieldName = 'LOT_QTD'
    end
    object TLotesLOT_QTDPED: TFloatField
      FieldName = 'LOT_QTDPED'
    end
  end
  object DSLotes: TDataSource
    DataSet = TLotes
    Left = 312
    Top = 264
  end
end
