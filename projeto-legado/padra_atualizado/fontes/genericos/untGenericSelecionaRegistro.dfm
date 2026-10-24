inherited frmGenericSelecionaRegistro: TfrmGenericSelecionaRegistro
  Width = 636
  Height = 382
  Caption = 'frmGenericSelecionaRegistro'
  Position = poMainFormCenter
  ExplicitWidth = 636
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 309
    Width = 630
    ExplicitTop = 309
    ExplicitWidth = 630
    inherited FlwBotoes: TFlowPanel
      Width = 626
      ExplicitWidth = 626
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 143
        Height = 22
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 547
      ExplicitLeft = 547
    end
  end
  inherited pnlStatus: TPanel
    Top = 337
    Width = 630
    ExplicitTop = 337
    ExplicitWidth = 630
    inherited pnlNomeForm: TPanel
      Left = 459
      ExplicitLeft = 459
    end
    inherited pnlInfo: TPanel
      Width = 459
      ExplicitWidth = 459
    end
  end
  object cxDados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 630
    Height = 309
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
    Left = 304
    Top = 176
  end
end
