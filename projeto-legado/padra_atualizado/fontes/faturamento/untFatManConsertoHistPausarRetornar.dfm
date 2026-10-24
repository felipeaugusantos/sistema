inherited frmFatManConsertoHistPausarRetornar: TfrmFatManConsertoHistPausarRetornar
  Width = 624
  Height = 341
  Caption = 'Hist'#243'rico Pausar/Retornar Obs. T'#233'cnicas O.S'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 624
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 268
    Width = 618
    inherited FlwBotoes: TFlowPanel
      Width = 614
    end
    inherited btnSair: TBitBtnLocked
      Left = 535
    end
  end
  inherited pnlStatus: TPanel
    Top = 296
    Width = 618
    inherited pnlNomeForm: TPanel
      Left = 447
    end
    inherited pnlInfo: TPanel
      Width = 447
    end
  end
  object cxgrid: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 618
    Height = 268
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -475
    ExplicitTop = -121
    ExplicitWidth = 958
    ExplicitHeight = 354
    object cxgridTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridTBVDESCRI: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'DESCRI'
        Width = 239
      end
      object cxGridTBVDTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DTAENT'
        Width = 96
      end
      object cxGridTBVHORENT: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'HORENT'
        Width = 55
      end
      object cxGridTBVNOMOPE: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'NOMOPE'
        Width = 208
      end
    end
    object cxgridLevel1: TcxGridLevel
      GridView = cxgridTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 32
  end
  object dsGrid: TDataSource
    Left = 456
    Top = 32
  end
end
