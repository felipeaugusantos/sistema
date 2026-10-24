inherited frmAgruPedOrdProIndLotes: TfrmAgruPedOrdProIndLotes
  Width = 667
  Height = 364
  Caption = 'Sele'#231#227'o de Lotes Utilizados na Ordem de Produ'#231#227'o'
  ExplicitWidth = 667
  ExplicitHeight = 364
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 292
    Width = 661
    ExplicitTop = 292
    ExplicitWidth = 661
    inherited FlwBotoes: TFlowPanel
      Width = 580
      inherited btnConfirma: TBitBtnLocked
        Height = 23
        Align = alLeft
        ModalResult = 0
        ExplicitHeight = 23
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 582
      Top = 2
      Align = alRight
      ExplicitLeft = 582
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 320
    Width = 661
    ExplicitTop = 320
    ExplicitWidth = 661
    inherited pnlNomeForm: TPanel
      Left = 490
      ExplicitLeft = 490
    end
    inherited pnlInfo: TPanel
      Width = 490
      ExplicitWidth = 490
    end
  end
  object cxgLotes: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 661
    Height = 292
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLotesTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxGridCitel1TableViewNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 94
      end
      object cxGridCitel1TableViewLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o'
        DataBinding.FieldName = 'LOT_LOCFIS'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 79
      end
      object cxGridCitel1TableViewDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'LOC_DESCRI'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 180
      end
      object cxGridCitel1TableViewDTAVAL: TcxGridDBColumn
        Caption = 'Validade'
        DataBinding.FieldName = 'LOT_DTAVAL'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 79
      end
      object cxGridCitel1TableViewSALDOS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'LOT_SALDOS'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 103
      end
      object cxGridCitel1TableViewESTUTI: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ESTUTI'
        Options.Filtering = False
        Options.Sorting = False
        Width = 87
      end
    end
    object cxgLotesLevel: TcxGridLevel
      GridView = cxgLotesTableView
    end
  end
end
