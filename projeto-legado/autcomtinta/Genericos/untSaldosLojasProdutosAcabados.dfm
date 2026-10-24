inherited frmSaldosLojasProdutosAcabados: TfrmSaldosLojasProdutosAcabados
  Width = 800
  Height = 500
  Caption = 'Saldo das Lojas'
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 794
    ExplicitTop = 427
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 794
    ExplicitTop = 455
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 544
      Width = 250
      ExplicitLeft = 544
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 544
      ExplicitWidth = 544
    end
  end
  object cxItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 427
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxItensTblv: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados pra exibir'
      OptionsView.GroupByBox = False
    end
    object cxItenslvl: TcxGridLevel
      GridView = cxItensTblv
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 88
  end
  object dtsItens: TDataSource
    Left = 192
    Top = 236
  end
end
