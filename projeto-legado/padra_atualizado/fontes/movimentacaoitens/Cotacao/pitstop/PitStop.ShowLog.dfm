inherited frmLogPitStop: TfrmLogPitStop
  Width = 932
  Height = 645
  Caption = 'Log Integra'#231#227'o Pit Stop'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 932
  ExplicitHeight = 645
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 572
    Width = 926
    inherited FlwBotoes: TFlowPanel
      Width = 922
    end
    inherited btnSair: TBitBtnLocked
      Left = 846
      Height = 19
      ExplicitLeft = 846
      ExplicitHeight = 19
    end
  end
  inherited pnlStatus: TPanel
    Top = 600
    Width = 926
    inherited pnlNomeForm: TPanel
      Left = 755
    end
    inherited pnlInfo: TPanel
      Width = 755
    end
  end
  object cxPitStopLog: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 926
    Height = 572
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = -3
    object cxgPitStopLog: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsLog
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgPitStopLogColumn1: TcxGridDBColumn
        Caption = 'Data/Hora'
        DataBinding.FieldName = 'LOG_DTAOCO'
        Width = 123
      end
      object cxgPitStopLogColumn2: TcxGridDBColumn
        Caption = 'Log'
        DataBinding.FieldName = 'LOG_RETAPI'
        PropertiesClassName = 'TcxMemoProperties'
        Width = 759
      end
    end
    object cxlLog: TcxGridLevel
      GridView = cxgPitStopLog
    end
  end
  object dtsLog: TDataSource
    Left = 224
    Top = 160
  end
end
