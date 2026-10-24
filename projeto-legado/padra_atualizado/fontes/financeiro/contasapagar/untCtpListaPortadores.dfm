inherited frmCtpListaPortadores: TfrmCtpListaPortadores
  Width = 621
  Height = 355
  Caption = 'Portadores'
  Position = poMainFormCenter
  ExplicitWidth = 621
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 282
    Width = 615
    ExplicitTop = 282
    ExplicitWidth = 615
    inherited FlwBotoes: TFlowPanel
      Width = 611
      ExplicitWidth = 611
    end
    inherited btnSair: TBitBtnLocked
      Left = 532
      ExplicitLeft = 532
    end
  end
  inherited pnlStatus: TPanel
    Top = 310
    Width = 615
    ExplicitTop = 310
    ExplicitWidth = 615
    inherited pnlNomeForm: TPanel
      Left = 444
      ExplicitLeft = 444
    end
    inherited pnlInfo: TPanel
      Width = 444
      ExplicitWidth = 444
    end
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 615
    Height = 282
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDados: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxDadosCellClick
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object colCodPor: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'FCTB_CODPOR'
        Options.Editing = False
        Width = 75
      end
      object colNomPor: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'FCTB_NOMPOR'
        Options.Editing = False
        Width = 324
      end
      object colValor: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'FCTB_VALLAN'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 135
      end
      object colCheques: TcxGridDBColumn
        Caption = 'Cheques'
        DataBinding.FieldName = 'CHEQUES'
        Width = 73
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxDados
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 824
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 104
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 576
    Top = 80
  end
  object qryDados: TAureliusDataset
    FieldDefs = <>
    IncludeUnmappedObjects = False
    SubpropsDepth = 0
    SyncSubprops = False
    RecordCountMode = Default
    Left = 576
    Top = 144
    object qryDadosFCTB_CODPOR: TStringField
      FieldName = 'FCTB_CODPOR'
      Size = 5
    end
    object qryDadosFCTB_NOMPOR: TStringField
      FieldKind = fkCalculated
      FieldName = 'FCTB_NOMPOR'
      Size = 40
      Calculated = True
    end
    object qryDadosFCTB_VALLAN: TFloatField
      FieldName = 'FCTB_VALLAN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDadosCheques: TStringField
      FieldName = 'CHEQUES'
      Size = 3
    end
    object qryDadosFCTB_SEQLAN: TStringField
      FieldName = 'FCTB_SEQLAN'
      Size = 13
    end
    object qryDadosFCTB_CREDEB: TStringField
      FieldName = 'FCTB_CREDEB'
      Size = 1
    end
    object qryDadosFCTB_DTALAN: TDateTimeField
      FieldName = 'FCTB_DTALAN'
    end
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 112
    object cdsDadosFCTB_CODPOR: TStringField
      FieldName = 'FCTB_CODPOR'
      Size = 5
    end
    object cdsDadosFCTB_NOMPOR: TStringField
      FieldKind = fkCalculated
      FieldName = 'FCTB_NOMPOR'
      OnGetText = cdsDadosFCTB_NOMPORGetText
      Size = 40
      Calculated = True
    end
    object cdsDadosFCTB_VALLAN: TFloatField
      FieldName = 'FCTB_VALLAN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDadosCHEQUES: TStringField
      FieldName = 'CHEQUES'
      OnGetText = cdsDadosCHEQUESGetText
      Size = 3
    end
    object cdsDadosFCTB_SEQLAN: TStringField
      FieldName = 'FCTB_SEQLAN'
      Size = 13
    end
    object cdsDadosFCTB_CREDEB: TStringField
      FieldName = 'FCTB_CREDEB'
      Size = 1
    end
  end
end
