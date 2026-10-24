inherited frmCadReducaoBCISS: TfrmCadReducaoBCISS
  Width = 616
  Height = 500
  Caption = 'Cadastro da Redu'#231#227'o de Base de C'#225'lculo do ISS'
  Position = poMainFormCenter
  ExplicitWidth = 616
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 610
    ExplicitTop = 314
    ExplicitWidth = 610
    inherited btnSair: TBitBtnLocked
      Left = 527
      ExplicitLeft = 527
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 610
    ExplicitTop = 342
    ExplicitWidth = 610
    inherited pnlNomeForm: TPanel
      Left = 439
      ExplicitLeft = 439
    end
    inherited pnlInfo: TPanel
      Width = 439
      ExplicitWidth = 439
    end
  end
  object cxGridReducao: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 610
    Height = 427
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 314
    object cxGridReducaoDBView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Insert.Enabled = False
      Navigator.Buttons.Append.Enabled = False
      Navigator.Buttons.Delete.Enabled = False
      Navigator.Buttons.Edit.Enabled = False
      Navigator.Buttons.Post.Enabled = False
      Navigator.Buttons.Cancel.Enabled = False
      FilterBox.Visible = fvNever
      FindPanel.InfoText = 'Digite um texto para busca...'
      DataController.DataSource = dtsReducaoBCISS
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Filter.AutoDataSetFilter = True
      DataController.MultiThreadedOptions.Sorting = bTrue
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.CheckBoxPosition = cbpIndicator
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.HeaderFilterButtonShowMode = fbmSmartTag
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridReducaoCLI_CODEMP: TcxGridDBColumn
        Caption = 'C'#243'd.Empresa'
        DataBinding.FieldName = 'CID_CODEMP'
        BestFitMaxWidth = 75
        MinWidth = 75
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 75
      end
      object cxGridReducaoCID_DESEMP: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CID_DESEMP'
        BestFitMaxWidth = 400
        MinWidth = 400
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 400
      end
      object cxGridReducaoREDISS: TcxGridDBColumn
        Caption = '% Redu'#231#227'o BC ISS'
        DataBinding.FieldName = 'CID_REDISS'
        BestFitMaxWidth = 100
        MinWidth = 100
        Options.ShowEditButtons = isebNever
        Width = 100
      end
    end
    object cxGridReducaoPrimeiroNivel: TcxGridLevel
      GridView = cxGridReducaoDBView
      Options.DetailTabsPosition = dtpLeft
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 88
    Top = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 60
    Top = 280
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 280
  end
  object cdsReducaoBCISS: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsReducaoBCISSIndex1'
        Fields = 'CID_CODEMP'
      end>
    IndexFieldNames = 'CID_CODEMP'
    Params = <>
    StoreDefs = True
    Left = 460
    Top = 76
    object cdsReducaoBCISSCID_CODEMP: TStringField
      FieldName = 'CID_CODEMP'
      Size = 3
    end
    object cdsReducaoBCISSCID_DESEMP: TStringField
      FieldName = 'CID_DESEMP'
      Size = 100
    end
    object cdsReducaoBCISSCID_REDISS: TFloatField
      FieldName = 'CID_REDISS'
      OnValidate = cdsReducaoBCISSCID_REDISSValidate
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object cdsReducaoBCISSCID_CODCID: TStringField
      FieldName = 'CID_CODCID'
      Size = 5
    end
  end
  object dtsReducaoBCISS: TDataSource
    DataSet = cdsReducaoBCISS
    Left = 432
    Top = 76
  end
end
