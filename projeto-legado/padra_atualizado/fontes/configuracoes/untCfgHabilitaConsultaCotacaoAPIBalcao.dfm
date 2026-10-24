inherited frmCfgHabilitaConsultaCotacaoAPIBalcao: TfrmCfgHabilitaConsultaCotacaoAPIBalcao
  Width = 400
  Height = 217
  Caption = 'Habilita Consulta API'
  OnDestroy = FormDestroy
  ExplicitWidth = 400
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 146
    Width = 394
    ExplicitTop = 146
    ExplicitWidth = 394
    inherited FlwBotoes: TFlowPanel
      Width = 390
      ExplicitWidth = 390
    end
    inherited btnSair: TBitBtnLocked
      Left = 314
      ExplicitLeft = 314
    end
  end
  inherited pnlStatus: TPanel
    Top = 172
    Width = 394
    ExplicitTop = 172
    ExplicitWidth = 394
    inherited pnlNomeForm: TPanel
      Left = 223
      ExplicitLeft = 223
    end
    inherited pnlInfo: TPanel
      Width = 223
      ExplicitWidth = 223
    end
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 394
    Height = 146
    Align = alClient
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'API_NOMAPI'
        Width = 201
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Habiltar'
        DataBinding.FieldName = 'API_HABILI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 73
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Balc'#227'o'
        DataBinding.FieldName = 'API_HABBAL'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object dtsDados: TDataSource
    Left = 368
    Top = 152
  end
end
