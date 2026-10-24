inherited frmDigLoteIndividual: TfrmDigLoteIndividual
  Width = 504
  Height = 500
  Caption = 'Armaz'#233'm Individual por Unidade'
  ExplicitWidth = 504
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 498
    TabOrder = 1
    ExplicitTop = 429
    ExplicitWidth = 498
    inherited FlwBotoes: TFlowPanel
      Width = 417
      ExplicitWidth = 494
      inherited btnConfirma: TBitBtnLocked
        Width = 116
        Caption = 'Confirma [F10]'
        ModalResult = 0
        ExplicitWidth = 116
      end
      object btnCadLot: TBitBtnLocked
        Left = 116
        Top = 0
        Width = 116
        Height = 22
        Caption = 'Cad. Lote R'#225'pido [F3]'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnCadLotClick
      end
      object btnLimpar: TBitBtnLocked
        Left = 232
        Top = 0
        Width = 116
        Height = 22
        Caption = 'Limpar [F4]'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnLimparClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 419
      Top = 2
      Align = alRight
      ExplicitLeft = 415
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 498
    TabOrder = 2
    ExplicitTop = 455
    ExplicitWidth = 498
    inherited pnlNomeForm: TPanel
      Left = 327
      ExplicitLeft = 327
    end
    inherited pnlInfo: TPanel
      Width = 327
      ExplicitWidth = 327
    end
  end
  object cxgLotes: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 498
    Height = 429
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLotesTV: TcxGridDBTableViewCitel
      OnKeyPress = cxgLotesTVKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxgLotesTVEditKeyPress
      OnEditKeyUp = cxgLotesTVEditKeyUp
      DataController.DataSource = dtsLotes
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgLotesTVITEM: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'ITEM'
        Options.Editing = False
        Options.Focusing = False
        Width = 64
      end
      object cxgLotesTVNUMLOT: TcxGridDBColumn
        Caption = 'Armaz'#233'm'
        DataBinding.FieldName = 'NUMLOT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Options.Grouping = False
        Width = 431
      end
    end
    object cxgLotesLvl: TcxGridLevel
      GridView = cxgLotesTV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 120
  end
  object dtsLotes: TDataSource
    Left = 408
    Top = 232
  end
end
