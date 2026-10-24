inherited frmSelMontadoras: TfrmSelMontadoras
  Width = 465
  Height = 540
  Caption = 'Selecione as Montadoras'
  ExplicitWidth = 465
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 469
    Width = 459
    inherited FlwBotoes: TFlowPanel
      Width = 455
    end
    inherited btnSair: TBitBtnLocked
      Left = 379
    end
  end
  inherited pnlStatus: TPanel
    Top = 495
    Width = 459
    inherited pnlNomeForm: TPanel
      Left = 288
    end
    inherited pnlInfo: TPanel
      Width = 288
    end
  end
  object cxMontadora: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 459
    Height = 469
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 120
    ExplicitTop = 168
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxgMontadora: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgMontadoraCODMOM: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'MON_CODMON'
        MinWidth = 64
        Options.Editing = False
      end
      object cxgMontadoraDESCRI: TcxGridDBColumn
        Caption = 'Montadora'
        DataBinding.FieldName = 'MON_DESCRI'
        MinWidth = 342
        Options.Editing = False
        Width = 342
      end
      object cxgMontadoraMARCADA: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARCAD'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 29
      end
    end
    object cxlMontadora: TcxGridLevel
      GridView = cxgMontadora
    end
  end
  object dtsDados: TDataSource
    Left = 312
    Top = 216
  end
end
