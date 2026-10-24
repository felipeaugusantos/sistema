inherited frmAltCepImpostacaoSfa: TfrmAltCepImpostacaoSfa
  Width = 720
  Height = 348
  Caption = 'Altera'#231#227'o de CEP'
  ExplicitWidth = 720
  ExplicitHeight = 348
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 277
    Width = 714
    inherited FlwBotoes: TFlowPanel
      Width = 710
    end
    inherited btnSair: TBitBtnLocked
      Left = 631
    end
  end
  inherited pnlStatus: TPanel
    Top = 303
    Width = 714
    inherited pnlNomeForm: TPanel
      Left = 543
    end
    inherited pnlInfo: TPanel
      Width = 543
    end
  end
  object grdCep: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 714
    Height = 254
    Align = alClient
    TabOrder = 2
    ExplicitLeft = -132
    ExplicitWidth = 846
    ExplicitHeight = 168
    object grdCepDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdCepDBTableViewCustomDrawCell
      DataController.DataSource = dtsCep
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object grdCepLevel: TcxGridLevel
      GridView = grdCepDBTableView
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 254
    Width = 714
    Height = 23
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = -132
    ExplicitTop = 168
    ExplicitWidth = 846
    object shpLegEditavel: TShape
      Left = 13
      Top = 6
      Width = 10
      Height = 10
      Brush.Color = clYellow
    end
    object lblLegEditavel: TLabel
      Left = 29
      Top = 4
      Width = 85
      Height = 14
      Caption = 'Campos edit'#225'veis'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1064
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1016
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 944
    Top = 48
  end
  object cdsCep: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 40
  end
  object dtsCep: TDataSource
    DataSet = cdsCep
    Left = 160
    Top = 40
  end
end
