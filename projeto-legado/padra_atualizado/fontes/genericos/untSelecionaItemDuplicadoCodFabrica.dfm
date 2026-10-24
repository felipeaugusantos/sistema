inherited frmSelecionaItemDuplicadoCodFabrica: TfrmSelecionaItemDuplicadoCodFabrica
  Width = 700
  Height = 407
  Caption = 'Seleciona'
  ExplicitWidth = 700
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 334
    Width = 694
    ExplicitTop = 334
    ExplicitWidth = 626
    inherited FlwBotoes: TFlowPanel
      Width = 690
      ExplicitTop = 2
      ExplicitWidth = 622
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 611
      ExplicitLeft = 543
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
      TabOrder = 2
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 362
    Width = 694
    ExplicitTop = 362
    ExplicitWidth = 626
    inherited pnlNomeForm: TPanel
      Left = 523
      ExplicitLeft = 455
    end
    inherited pnlInfo: TPanel
      Width = 523
      ExplicitWidth = 455
    end
  end
  object cxItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 694
    Height = 334
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 626
    object cxItensDB: TcxGridDBTableView
      OnDblClick = cxItensDBDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxItensCODITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'CODITE'
        Width = 50
      end
      object cxItensCODFAB: TcxGridDBColumn
        Caption = 'Cod. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Width = 70
      end
      object cxItensDESITE: TcxGridDBColumn
        Caption = 'Desc. Item'
        DataBinding.FieldName = 'DESITE'
        Width = 210
      end
      object cxItensCODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        Width = 70
      end
      object cxItensDESFOR: TcxGridDBColumn
        Caption = 'Desc. Fornecedor'
        DataBinding.FieldName = 'DESFOR'
        Width = 282
      end
    end
    object cxItensL: TcxGridLevel
      GridView = cxItensDB
    end
  end
  object dtsItens: TDataSource
    Left = 108
    Top = 208
  end
end
