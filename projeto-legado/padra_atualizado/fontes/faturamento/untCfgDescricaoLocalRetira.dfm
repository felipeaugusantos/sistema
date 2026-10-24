inherited frmCfgDescricaoLocRet: TfrmCfgDescricaoLocRet
  Width = 342
  Height = 236
  Caption = 'Definir Descri'#231#227'o Local Retira'
  ExplicitWidth = 342
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 165
    Width = 336
    ExplicitTop = 165
    ExplicitWidth = 282
    inherited FlwBotoes: TFlowPanel
      Width = 332
      ExplicitWidth = 278
    end
    inherited btnSair: TBitBtnLocked
      Left = 253
      ExplicitLeft = 199
    end
  end
  inherited pnlStatus: TPanel
    Top = 191
    Width = 336
    ExplicitTop = 191
    ExplicitWidth = 282
    inherited pnlNomeForm: TPanel
      Left = 165
      ExplicitLeft = 111
    end
    inherited pnlInfo: TPanel
      Width = 165
      ExplicitWidth = 111
    end
  end
  object grdDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 336
    Height = 165
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 282
    object grdDadosTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosTBVLOCRET: TcxGridDBColumn
        Caption = 'Local de Retira'
        DataBinding.FieldName = 'LOCRET'
        MinWidth = 140
        Options.Editing = False
        Options.Filtering = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 140
      end
      object grdDadosTBVDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o para concatenar'
        DataBinding.FieldName = 'DESCRI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 10
        MinWidth = 170
        Options.Filtering = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 170
      end
    end
    object grdDadosLevel: TcxGridLevel
      GridView = grdDadosTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 160
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 96
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 32
  end
  object dtsDados: TDataSource
    Left = 232
    Top = 33
  end
end
