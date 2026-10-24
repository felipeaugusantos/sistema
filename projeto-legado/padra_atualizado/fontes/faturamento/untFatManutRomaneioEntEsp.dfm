inherited frmFatManutRomaneioEntEsp: TfrmFatManutRomaneioEntEsp
  Width = 750
  Height = 800
  Caption = 'Pedidos com rota especial'
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 750
  ExplicitHeight = 800
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 250
    Width = 744
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 330
    ExplicitWidth = 868
  end
  inherited pnlBotoes: TPanel
    Top = 727
    Width = 744
    TabOrder = 4
    ExplicitTop = 727
    ExplicitWidth = 744
    inherited FlwBotoes: TFlowPanel
      Width = 740
      ExplicitWidth = 740
    end
    inherited btnSair: TBitBtnLocked
      Left = 664
      ExplicitLeft = 664
    end
  end
  inherited pnlStatus: TPanel
    Top = 755
    Width = 744
    TabOrder = 5
    ExplicitTop = 755
    ExplicitWidth = 744
    inherited pnlNomeForm: TPanel
      Left = 573
      ExplicitLeft = 573
    end
    inherited pnlInfo: TPanel
      Width = 573
      ExplicitWidth = 573
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 744
    Height = 30
    Align = alTop
    Constraints.MinHeight = 30
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 242
      Height = 14
      Caption = 'Resumo de produtos com entrega especial:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cxGrdResumo: TcxGridCitel [4]
    Left = 0
    Top = 30
    Width = 744
    Height = 220
    Align = alTop
    Constraints.MinHeight = 30
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrdResumoView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
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
      object cxGrdResumoViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'DET_CODITE'
        Width = 70
      end
      object cxGrdResumoViewDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DET_DESCRI'
        Width = 450
      end
      object cxGrdResumoViewQTDITE: TcxGridDBColumn
        Caption = 'Qtd. Total'
        DataBinding.FieldName = 'DET_QTDITE'
        Width = 90
      end
    end
    object cxGrdResumoLevel: TcxGridLevel
      GridView = cxGrdResumoView
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 255
    Width = 744
    Height = 30
    Align = alTop
    Constraints.MinHeight = 30
    ParentColor = True
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 170
      Height = 14
      Caption = 'Pedidos com entrega especial:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cxGrdPedidos: TcxGridCitel [6]
    Left = 0
    Top = 285
    Width = 744
    Height = 442
    Align = alClient
    Constraints.MinHeight = 30
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrdPedidosView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'GER_NUMDOC'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
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
      object cxGrdPedidosViewNUMDOC: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'GER_NUMDOC'
        Width = 150
      end
      object cxGrdPedidosViewDTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'GER_DTAENT'
        Width = 90
      end
      object cxGrdPedidosViewNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Width = 350
      end
    end
    object cxGrdPedItensView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DetailKeyFieldNames = 'GER_NUMDOC'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.MasterKeyFieldNames = 'GER_NUMDOC'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
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
      object cxGrdPedItensViewNUMDOC: TcxGridDBColumn
        DataBinding.FieldName = 'GER_NUMDOC'
        Visible = False
      end
      object cxGrdPedItensViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'DET_CODITE'
        Width = 70
      end
      object cxGrdPedItensViewDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DET_DESCRI'
        Width = 450
      end
      object cxGrdPedItensViewQTDITE: TcxGridDBColumn
        Caption = 'Qtd. Total'
        DataBinding.FieldName = 'DET_QTDITE'
        Width = 90
      end
    end
    object cxGrdPedidosLevel: TcxGridLevel
      GridView = cxGrdPedidosView
      object cxGrdPedItensLevel: TcxGridLevel
        GridView = cxGrdPedItensView
      end
    end
  end
end
