inherited frmPesqCliVend: TfrmPesqCliVend
  Left = 412
  Top = 251
  Width = 627
  Height = 313
  Caption = 'Selecione o Vendedor do Cliente...'
  Position = poMainFormCenter
  ExplicitWidth = 627
  ExplicitHeight = 313
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 240
    Width = 621
    ExplicitTop = 240
    ExplicitWidth = 609
    inherited FlwBotoes: TFlowPanel
      Width = 617
    end
    inherited btnSair: TBitBtnLocked
      Left = 536
      ExplicitLeft = 524
    end
  end
  inherited pnlStatus: TPanel
    Top = 268
    Width = 621
    ExplicitTop = 268
    ExplicitWidth = 609
    inherited pnlNomeForm: TPanel
      Left = 450
      ExplicitLeft = 438
    end
    inherited pnlInfo: TPanel
      Width = 450
      ExplicitWidth = 438
    end
  end
  object dbgCliVen: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 621
    Height = 240
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 96
    ExplicitTop = 36
    ExplicitWidth = 498
    ExplicitHeight = 200
    object dbgCliVenDBTableViewCitel1: TcxGridDBTableViewCitel
      OnKeyDown = dbgCliVenDBTableViewCitel1KeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      OnCellDblClick = dbgCliVenDBTableViewCitel1CellDblClick
      DataController.DataSource = dtsConsCliVen
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object dbgCliVenDBTableViewCitel1CVE_CODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'CVE_CODVEN'
        BestFitMaxWidth = 61
        MinWidth = 61
        Width = 61
      end
      object dbgCliVenDBTableViewCitel1OPE_NOMOPE: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'OPE_NOMOPE'
        BestFitMaxWidth = 214
        MinWidth = 214
        Width = 214
      end
      object dbgCliVenDBTableViewCitel1MAR_DESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        BestFitMaxWidth = 158
        MinWidth = 158
        Width = 158
      end
      object dbgCliVenDBTableViewCitel1CVE_DTVGIN: TcxGridDBColumn
        Caption = 'In'#237'cio Vig.'
        DataBinding.FieldName = 'CVE_DTVGIN'
        BestFitMaxWidth = 80
        MinWidth = 80
        Width = 80
      end
      object dbgCliVenDBTableViewCitel1CVE_DTVGFN: TcxGridDBColumn
        Caption = 'Fim Vig.'
        DataBinding.FieldName = 'CVE_DTVGFN'
        BestFitMaxWidth = 80
        MinWidth = 80
        Width = 80
      end
    end
    object dbgCliVenLevel1: TcxGridLevel
      GridView = dbgCliVenDBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 44
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
    Top = 76
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 40
    Top = 132
  end
  object dtsConsCliVen: TDataSource
    Left = 40
    Top = 72
  end
end
