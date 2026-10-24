inherited frmSelecionaItens: TfrmSelecionaItens
  Width = 429
  Height = 380
  Caption = 'Selecionar Itens'
  ExplicitWidth = 429
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 308
    Width = 423
    ExplicitTop = 308
    ExplicitWidth = 423
    inherited btnSair: TBitBtnLocked
      Left = 340
      ExplicitLeft = 340
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 105
      Height = 22
      Caption = 'Confirma'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object cxgridItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 423
    Height = 308
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgridItensDBTableView1: TcxGridDBTableView
      OnKeyDown = cxgridItensDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgridItensDBTableView1CellDblClick
      DataController.DataSource = dsAux
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxgridItensDBTableView1Column1: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'CODITE'
        Width = 100
      end
      object cxgridItensDBTableView1Column2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Width = 300
      end
    end
    object cxgridItensLevel1: TcxGridLevel
      GridView = cxgridItensDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 336
    Width = 423
    ExplicitTop = 336
    ExplicitWidth = 423
    inherited pnlNomeForm: TPanel
      Left = 252
      ExplicitLeft = 252
    end
    inherited pnlInfo: TPanel
      Width = 252
      ExplicitWidth = 252
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 944
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 824
    Top = 192
  end
  object dsAux: TDataSource
    Left = 352
    Top = 72
  end
end
