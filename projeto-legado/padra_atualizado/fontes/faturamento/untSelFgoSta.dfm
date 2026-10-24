inherited frmSelFgoSta: TfrmSelFgoSta
  Width = 538
  Height = 496
  Caption = 'Status dos documentos'
  OnDestroy = FormDestroy
  ExplicitWidth = 538
  ExplicitHeight = 496
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 425
    Width = 532
    ExplicitTop = 425
    ExplicitWidth = 532
    inherited FlwBotoes: TFlowPanel
      Width = 528
      ExplicitWidth = 528
    end
    inherited btnSair: TBitBtnLocked
      Left = 449
      ExplicitLeft = 449
    end
  end
  inherited pnlStatus: TPanel
    Top = 451
    Width = 532
    ExplicitTop = 451
    ExplicitWidth = 532
    inherited pnlNomeForm: TPanel
      Left = 361
      ExplicitLeft = 361
    end
    inherited pnlInfo: TPanel
      Width = 361
      ExplicitWidth = 361
    end
  end
  object grdDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 532
    Height = 425
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosTvSELECI: TcxGridDBColumn
        Caption = 'Selecionado'
        DataBinding.FieldName = 'SELECI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
      end
      object grdDadosTvDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'STA_DESCRI'
        Width = 400
      end
    end
    object grdDadosLv: TcxGridLevel
      GridView = grdDadosTv
    end
  end
  object dtsDados: TDataSource
    Left = 264
    Top = 196
  end
end
