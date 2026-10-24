inherited frmGrid: TfrmGrid
  Width = 510
  Height = 401
  BorderIcons = [biSystemMenu]
  Caption = 'frmGrid'
  Position = poScreenCenter
  ExplicitWidth = 510
  ExplicitHeight = 401
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 504
    ExplicitTop = 328
    ExplicitWidth = 504
    inherited FlwBotoes: TFlowPanel
      Width = 500
      ExplicitWidth = 500
    end
    inherited btnSair: TBitBtnLocked
      Left = 421
      ExplicitLeft = 421
    end
  end
  inherited pnlStatus: TPanel
    Top = 356
    Width = 504
    ExplicitTop = 356
    ExplicitWidth = 504
    inherited pnlNomeForm: TPanel
      Left = 406
      Width = 98
      ExplicitLeft = 333
      ExplicitWidth = 98
    end
    inherited pnlInfo: TPanel
      Width = 406
      ExplicitWidth = 333
    end
  end
  object grdInfo: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 504
    Height = 328
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdInfoDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdInfoDBTableViewCustomDrawCell
      DataController.DataSource = dsrInfo
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object grdInfoLevel1: TcxGridLevel
      GridView = grdInfoDBTableView
    end
  end
  object dsrInfo: TDataSource
    Left = 376
    Top = 176
  end
end
