inherited frmMsgGridGenerica: TfrmMsgGridGenerica
  Width = 610
  Height = 343
  Caption = 'Mensagem'
  ExplicitWidth = 610
  ExplicitHeight = 343
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 272
    Width = 604
    ExplicitTop = 272
    ExplicitWidth = 604
    inherited FlwBotoes: TFlowPanel
      Width = 600
      ExplicitWidth = 600
    end
    inherited btnSair: TBitBtnLocked
      Left = 521
      ExplicitLeft = 521
    end
  end
  inherited pnlStatus: TPanel
    Top = 298
    Width = 604
    ExplicitTop = 298
    ExplicitWidth = 604
    inherited pnlNomeForm: TPanel
      Left = 433
      ExplicitLeft = 433
    end
    inherited pnlInfo: TPanel
      Width = 433
      ExplicitWidth = 433
    end
  end
  object cxDados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 604
    Height = 272
    Align = alClient
    TabOrder = 2
    object cxgDados: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem Dados Para Exibir>'
      OptionsView.GroupByBox = False
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
    end
  end
  object dtsDados: TDataSource
    Left = 400
    Top = 112
  end
end
