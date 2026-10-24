inherited frmInformarPedidoVendaItens: TfrmInformarPedidoVendaItens
  Width = 954
  Height = 432
  BorderStyle = bsSingle
  Caption = 'Informar Pedido de Venda dos Itens'
  OnDestroy = FormDestroy
  ExplicitWidth = 954
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 360
    Width = 948
    Caption = 'Pressione F5 para copiar o pedido de venda para todos os itens.'
    ExplicitTop = 360
    ExplicitWidth = 948
    inherited FlwBotoes: TFlowPanel
      Width = 287
      Align = alLeft
      ExplicitTop = 2
      ExplicitWidth = 287
    end
    inherited btnSair: TBitBtnLocked
      Left = 865
      ExplicitLeft = 865
    end
  end
  inherited pnlStatus: TPanel
    Top = 388
    Width = 948
    ExplicitTop = 388
    ExplicitWidth = 948
    inherited pnlNomeForm: TPanel
      Left = 777
      ExplicitLeft = 777
    end
    inherited pnlInfo: TPanel
      Width = 777
      ExplicitWidth = 777
    end
  end
  object cxItems: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 948
    Height = 351
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxItemsTblVw: TcxGridDBTableView
      OnKeyDown = cxItemsTblVwKeyDown
      OnKeyPress = cxItemsTblVwKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxItemsTblVwEditKeyPress
      DataController.DataSource = dtsItens
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxItemsCodite: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
      end
      object cxItemsDescri: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 212
      end
      object cxItemsUnidad: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'ITE_SIGUNI'
        Options.Editing = False
      end
      object cxItemsQuanti: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
        Options.Editing = False
      end
      object cxItemsVlrUni: TcxGridDBColumn
        Caption = 'Valor Unit'#225'rio'
        DataBinding.FieldName = 'ITE_UNITAR'
        Options.Editing = False
        Width = 86
      end
      object cxItemsVrTotal: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'ITE_TOTITE'
        Options.Editing = False
        Width = 81
      end
      object cxItemsEMPPED: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'ITE_EMPPED'
        Options.Editing = False
      end
      object cxItemsPedVen: TcxGridDBColumn
        Caption = 'Pedido de Venda'
        DataBinding.FieldName = 'ITE_PEDVEN'
        Width = 113
      end
      object cxItemsESPECI: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ITE_ESPPVE'
        Options.Editing = False
      end
      object cxItemsDtaEnt: TcxGridDBColumn
        Caption = 'Data de Entrega'
        DataBinding.FieldName = 'ITE_PEDDTA'
        Options.Editing = False
        Width = 103
      end
    end
    object cxItemsLvl: TcxGridLevel
      GridView = cxItemsTblVw
    end
  end
  object pgbProgress: TProgressBar [4]
    Left = 0
    Top = 351
    Width = 948
    Height = 9
    Align = alBottom
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 728
    Top = 168
  end
  object dtsItens: TDataSource
    Left = 656
    Top = 64
  end
end
