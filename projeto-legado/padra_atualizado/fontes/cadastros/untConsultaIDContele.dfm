inherited frmConsultaIDContele: TfrmConsultaIDContele
  Width = 498
  Height = 359
  Caption = 'Contele'
  OnDestroy = FormDestroy
  ExplicitWidth = 498
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 288
    Width = 492
    ExplicitTop = 288
    ExplicitWidth = 492
    inherited FlwBotoes: TFlowPanel
      Width = 488
      ExplicitWidth = 488
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 409
      ExplicitLeft = 409
    end
  end
  inherited pnlStatus: TPanel
    Top = 314
    Width = 492
    ExplicitTop = 314
    ExplicitWidth = 492
    inherited pnlNomeForm: TPanel
      Left = 321
      ExplicitLeft = 321
    end
    inherited pnlInfo: TPanel
      Width = 321
      ExplicitWidth = 321
    end
  end
  object cxgPesquisas: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 492
    Height = 288
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
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
      object DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRICAO'
        Width = 225
      end
      object IDCONT: TcxGridDBColumn
        Caption = 'ID Contele'
        DataBinding.FieldName = 'ID'
        Width = 249
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
