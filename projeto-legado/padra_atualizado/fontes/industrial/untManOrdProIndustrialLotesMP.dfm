inherited frmManOrdProIndustrialLotesMP: TfrmManOrdProIndustrialLotesMP
  Width = 676
  Height = 559
  Caption = 'Manuten'#231#227'o de lotes de mat'#233'ria prima'
  ExplicitWidth = 676
  ExplicitHeight = 559
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 488
    Width = 670
    ExplicitTop = 488
    ExplicitWidth = 670
    object shpAlterados: TShape [0]
      Left = 98
      Top = 6
      Width = 16
      Height = 16
      Brush.Color = clFuchsia
    end
    object Label1: TLabel [1]
      Left = 120
      Top = 8
      Width = 247
      Height = 14
      Caption = 'Registros alterados e ainda n'#227'o confirmados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 589
      ExplicitWidth = 666
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 591
      Top = 2
      Align = alRight
      ExplicitLeft = 587
    end
  end
  inherited pnlStatus: TPanel
    Top = 514
    Width = 670
    ExplicitTop = 514
    ExplicitWidth = 670
    inherited pnlNomeForm: TPanel
      Left = 499
      ExplicitLeft = 499
    end
    inherited pnlInfo: TPanel
      Width = 499
      ExplicitWidth = 499
    end
  end
  object cxgOrdLot: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 670
    Height = 488
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgOrdLotTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgOrdLotTableViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgOrdLotTableViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 62
      end
      object cxgOrdLotTableViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 431
      end
      object cxgOrdLotTableViewNEWLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NEW_NUMLOT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 142
      end
      object cxgOrdLotTableViewNUMLOT: TcxGridDBColumn
        DataBinding.FieldName = 'ODL_NUMLOT'
        Visible = False
      end
    end
    object cxgOrdLotLevel1: TcxGridLevel
      GridView = cxgOrdLotTableView
    end
  end
end
