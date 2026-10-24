inherited frmNotaFiscalImportValoresDiverg: TfrmNotaFiscalImportValoresDiverg
  Width = 676
  Height = 357
  Caption = 'Valores Divergentes'
  OnDestroy = FormDestroy
  ExplicitWidth = 676
  ExplicitHeight = 357
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 286
    Width = 670
    ExplicitTop = 286
    ExplicitWidth = 670
    inherited FlwBotoes: TFlowPanel
      Width = 666
      ExplicitWidth = 666
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 587
      Caption = '&Fechar'
      ExplicitLeft = 587
    end
  end
  inherited pnlStatus: TPanel
    Top = 312
    Width = 670
    ExplicitTop = 312
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
  object cxGrid: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 670
    Height = 286
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    object cxGridTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxGridTBVVLR_DI
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxGridTBVVLR_NF
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridTBVCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        Width = 65
      end
      object cxGridTBVDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 339
      end
      object cxGridTBVUNIDAD: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNIDAD'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 33
      end
      object cxGridTBVVLR_DI: TcxGridDBColumn
        Caption = 'DI'
        DataBinding.FieldName = 'VLR_DI'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 100
      end
      object cxGridTBVVLR_NF: TcxGridDBColumn
        Caption = 'Sistema'
        DataBinding.FieldName = 'VLR_NF'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 100
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 72
  end
  object dtsGrid: TDataSource
    Left = 400
    Top = 72
  end
end
