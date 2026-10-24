inherited frmListaPesquisaOpiniOne: TfrmListaPesquisaOpiniOne
  Width = 807
  Height = 438
  Caption = 'Suas Pesquisas OpiniOne'
  OnDestroy = FormDestroy
  ExplicitWidth = 807
  ExplicitHeight = 438
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 367
    Width = 801
    inherited FlwBotoes: TFlowPanel
      Width = 797
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 718
    end
  end
  inherited pnlStatus: TPanel
    Top = 393
    Width = 801
    inherited pnlNomeForm: TPanel
      Left = 630
    end
    inherited pnlInfo: TPanel
      Width = 630
    end
  end
  object cxgPesquisas: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 801
    Height = 367
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxgPesquisasTableView1: TcxGridDBTableViewCitel
      OnDblClick = cxgPesquisasTableView1DblClick
      OnKeyDown = cxgPesquisasTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgPesquisasTableView1CustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
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
      object MARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object CODIGO: TcxGridDBColumn
        Caption = 'C'#243'd. Pesq.'
        DataBinding.FieldName = 'CODIGO'
        Width = 63
      end
      object PESQUI: TcxGridDBColumn
        Caption = 'Pesquisa'
        DataBinding.FieldName = 'PESQUI'
        Width = 240
      end
      object DTAINI: TcxGridDBColumn
        Caption = 'Data In'#237'cio'
        DataBinding.FieldName = 'DTAINI'
        Width = 120
      end
      object DTAFIN: TcxGridDBColumn
        Caption = 'Data Fim'
        DataBinding.FieldName = 'DTAFIN'
        Width = 120
      end
      object HASH__: TcxGridDBColumn
        Caption = 'Hash'
        DataBinding.FieldName = 'HASH__'
        Width = 240
      end
    end
    object cxgPesquisasLevel1: TcxGridLevel
      GridView = cxgPesquisasTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 32
  end
end
