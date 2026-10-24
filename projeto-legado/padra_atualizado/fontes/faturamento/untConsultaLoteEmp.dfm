inherited frmConsultaLoteEmp: TfrmConsultaLoteEmp
  Width = 831
  Height = 435
  Caption = 'Consulta de Lotes por Empresa'
  Position = poScreenCenter
  ExplicitWidth = 831
  ExplicitHeight = 435
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 363
    Width = 825
    ExplicitTop = 363
    ExplicitWidth = 825
    object shpLotBlo: TShape [0]
      Left = 9
      Top = 4
      Width = 32
      Height = 19
      Brush.Color = clRed
    end
    object lblLotBlo: TLabel [1]
      Left = 47
      Top = 7
      Width = 74
      Height = 14
      Caption = 'Lote bloqueado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 742
      ExplicitLeft = 742
    end
  end
  object cxgConsulta: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 825
    Height = 363
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgConsultaView: TcxGridDBBandedTableView
      OnKeyPress = cxgConsultaViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgConsultaViewCellDblClick
      OnCustomDrawCell = cxgConsultaViewCustomDrawCell
      DataController.DataSource = dtsConsula
      DataController.MultiThreadedOptions.Filtering = bTrue
      DataController.MultiThreadedOptions.Sorting = bFalse
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.000'
          Kind = skSum
          Position = spFooter
          Column = cxgConsultaLotSal
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.000'
          Kind = skSum
          Column = cxgConsultaLotSal
          DisplayText = 'Saldo Total'
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooterMultiSummaries = True
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      Bands = <
        item
          Caption = 'EMPRESA'
          Options.Moving = False
          Styles.Header = cxsTitulo1
          Width = 449
        end
        item
          Caption = 'LOTE'
          Options.Moving = False
          Styles.Header = cxsTitulo1
          Width = 347
        end>
      object cxgConsultaNomEmp: TcxGridDBBandedColumn
        Caption = 'Raz'#227'o Social'
        DataBinding.FieldName = 'NOMEMP'
        GroupIndex = 0
        Options.CellMerging = True
        Options.Moving = False
        Width = 248
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgConsultaFanEmp: TcxGridDBBandedColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'NOMFAN'
        Options.CellMerging = True
        Options.Moving = False
        Width = 211
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgConsultaDesIte: TcxGridDBBandedColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'DESITE'
        Options.CellMerging = True
        Options.Moving = False
        Width = 183
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgConsultaNumLot: TcxGridDBBandedColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Moving = False
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgConsultaLotSal: TcxGridDBBandedColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'LOTSAL'
        Options.Moving = False
        Width = 66
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgConsultaLOT_STATUS: TcxGridDBBandedColumn
        DataBinding.FieldName = 'LOT_STATUS'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxgConsultaLevel1: TcxGridLevel
      GridView = cxgConsultaView
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 825
    ExplicitTop = 391
    ExplicitWidth = 825
    inherited pnlNomeForm: TPanel
      Left = 654
      ExplicitLeft = 654
    end
    inherited pnlInfo: TPanel
      Width = 654
      ExplicitWidth = 654
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 480
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 184
  end
  object dtsConsula: TDataSource
    Left = 528
    Top = 184
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 576
    Top = 184
    PixelsPerInch = 96
    object cxsTitulo1: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
  end
end
