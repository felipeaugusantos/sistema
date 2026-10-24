inherited frmCadCotAtuPrecos: TfrmCadCotAtuPrecos
  Width = 1127
  Height = 521
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Atualiza'#231#227'o de Pre'#231'os'
  ExplicitWidth = 1127
  ExplicitHeight = 521
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 477
    Width = 1127
    Visible = False
    ExplicitTop = 477
    ExplicitWidth = 1127
    inherited btnSair: TBitBtnLocked
      Left = 1044
      ExplicitLeft = 1044
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 1127
    Visible = False
    ExplicitTop = 505
    ExplicitWidth = 1127
    inherited pnlNomeForm: TPanel
      Left = 956
      ExplicitLeft = 956
    end
    inherited pnlInfo: TPanel
      Width = 956
      ExplicitWidth = 956
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 67
    Width = 1127
    Height = 318
    Align = alClient
    TabOrder = 2
    object cxgItensBandedFixa: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Bands = <
        item
          FixedKind = fkLeft
          Width = 168
        end>
    end
    object cxgItensDBBandedView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem pre'#231'os para atualizar>'
      OptionsView.GroupByBox = False
      Styles.ContentOdd = cxStyleZebra
      Bands = <
        item
          Caption = 'Informa'#231#245'es B'#225'sicas do Item'
          FixedKind = fkLeft
          Width = 347
        end
        item
          Caption = 'Informa'#231#245'es  Complementares'
          Width = 295
        end
        item
          Caption = 'Pre'#231'o de Compra'
          Width = 230
        end
        item
          Caption = 'Pre'#231'o de Custo'
          Width = 230
        end
        item
          Caption = 'Tabela 1'
          Width = 400
        end
        item
          Caption = 'Tabela 2'
          Width = 400
        end
        item
          Caption = 'Tabela 3'
          Width = 400
        end
        item
          Caption = 'Tabela 4'
          Width = 400
        end
        item
          Caption = 'Tabela 5'
          Width = 400
        end
        item
          Caption = 'Tabela 6'
          Width = 400
        end
        item
          Caption = 'Tabela 7'
          Width = 400
        end
        item
          Caption = 'Atualizar'
          FixedKind = fkRight
          Width = 240
        end>
      object CODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        OnCustomDrawCell = CODITECustomDrawCell
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn2: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        OnCustomDrawCell = CODITECustomDrawCell
        Options.Editing = False
        Width = 96
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn3: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        OnCustomDrawCell = CODITECustomDrawCell
        Options.Editing = False
        Width = 189
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn4: TcxGridDBBandedColumn
        Caption = 'Local. F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        OnCustomDrawCell = CODITECustomDrawCell
        Options.Editing = False
        Width = 93
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn5: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        OnCustomDrawCell = CODITECustomDrawCell
        Options.Editing = False
        Width = 47
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn6: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        OnCustomDrawCell = CODITECustomDrawCell
        Options.Editing = False
        Width = 83
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn7: TcxGridDBBandedColumn
        Caption = 'Cota'#231#227'o'
        DataBinding.FieldName = 'PRECOT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn8: TcxGridDBBandedColumn
        Caption = 'Atual'
        DataBinding.FieldName = 'PRECOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn9: TcxGridDBBandedColumn
        Caption = 'Novo'
        DataBinding.FieldName = 'NOVCUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn10: TcxGridDBBandedColumn
        Caption = 'Atual'
        DataBinding.FieldName = 'PRECUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn11: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object NOVVE1: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn13: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn14: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 5
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensATUPRE: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o'
        DataBinding.FieldName = 'ATUPRE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgItensATUPREPropertiesChange
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 66
        Position.BandIndex = 11
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn16: TcxGridDBBandedColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn17: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn18: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn19: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn20: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn21: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn22: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn23: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 7
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn24: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 7
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn25: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 8
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn26: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 8
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn27: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 8
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn28: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 9
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn29: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 9
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn30: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 9
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn31: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 10
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn32: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'NOVVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVVE1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 10
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn33: TcxGridDBBandedColumn
        Caption = 'Pr. Venda Atual'
        DataBinding.FieldName = 'PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 10
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn34: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 4
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn35: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 5
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn36: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 6
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn37: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 7
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn38: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 8
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn39: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 9
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn40: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFER7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
        Position.BandIndex = 10
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn15: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn41: TcxGridDBBandedColumn
        Caption = 'Diferen'#231'a (%)'
        DataBinding.FieldName = 'DIFCUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = CODITECustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object NOVBR1: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn46: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn49: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn52: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn55: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 8
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn59: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 9
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn61: TcxGridDBBandedColumn
        Caption = 'Nova Margem'
        DataBinding.FieldName = 'NOVBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = NOVBR1CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 100
        Position.BandIndex = 10
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object TIPALT: TcxGridDBBandedColumn
        Caption = 'Recalcular'
        DataBinding.FieldName = 'TIPALT'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.Alignment.Horz = taCenter
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Margem'
          'Pre'#231'o')
        Properties.OnChange = cxgItensATUPREPropertiesChange
        OnCustomDrawCell = TIPALTCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 11
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBBandedViewColumn1: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o j'#225' atualizado'
        DataBinding.FieldName = 'PJAATU'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 109
        Position.BandIndex = 11
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensDBBandedView
    end
  end
  object pnlComparativo: TPanel [3]
    Left = 0
    Top = 385
    Width = 1127
    Height = 92
    Align = alBottom
    BevelOuter = bvNone
    DockSite = True
    ParentColor = True
    TabOrder = 3
    object shp6: TShape
      Left = 631
      Top = 19
      Width = 14
      Height = 14
      Brush.Color = clGreen
    end
    object lbl7: TLabel
      Left = 649
      Top = 19
      Width = 234
      Height = 14
      Caption = 'Marcados para atualizar o Cadastro de Produtos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 631
      Top = 35
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Label1: TLabel
      Left = 649
      Top = 35
      Width = 113
      Height = 14
      Caption = 'Atualiza'#231#227'o de Margem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 649
      Top = 51
      Width = 103
      Height = 14
      Caption = 'Atualiza'#231#227'o de Pre'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape2: TShape
      Left = 631
      Top = 51
      Width = 14
      Height = 14
      Brush.Color = clBlue
    end
    object GroupBox1: TGroupBox
      Left = 11
      Top = 6
      Width = 350
      Height = 73
      Caption = 'Atualiza'#231#227'o de Pre'#231'os'
      TabOrder = 0
      object btnMarca: TBitBtnLocked
        Left = 11
        Top = 20
        Width = 161
        Height = 22
        Caption = '[ F5 ] Marca/Demarca'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnMarcaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 11
        Top = 41
        Width = 161
        Height = 22
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 173
        Top = 20
        Width = 161
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
      object btnAtuPre: TBitBtnLocked
        Left = 173
        Top = 41
        Width = 161
        Height = 22
        Caption = '[ F8 ] Atualiza Pre'#231'os'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnAtuPreClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 367
      Top = 6
      Width = 258
      Height = 73
      Caption = 'Tipo de C'#225'lculo'
      TabOrder = 1
      object btnRecalcPreco: TBitBtnLocked
        Left = 10
        Top = 20
        Width = 236
        Height = 22
        Caption = '[ F9 ] Recalcula Pre'#231'o de Venda para todos'
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnRecalcPrecoClick
      end
      object btnRecalcMargem: TBitBtnLocked
        Left = 10
        Top = 41
        Width = 236
        Height = 22
        Caption = '[ F11 ] Recalcula Margem para todos'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnRecalcMargemClick
      end
    end
    object btnDesPreAtu: TBitBtnLocked
      Left = 768
      Top = 47
      Width = 337
      Height = 22
      Caption = '[  F3 ] Desmarca todos os itens como "Pre'#231'o j'#225' atualizado"'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnDesPreAtuClick
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1127
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object chkAtuIpi: TCheckBox
      Left = 22
      Top = 26
      Width = 681
      Height = 17
      Caption = 
        'Utilizar os novos percentuais de IPI e Substitui'#231#227'o para o c'#225'lcu' +
        'lo do novo Pre'#231'o de Custo e atualiz'#225'-los no Cadastro de Produtos' +
        ' '
      TabOrder = 0
      OnClick = chkAtuIpiClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 344
    Top = 176
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 32
    Top = 152
    PixelsPerInch = 96
    object cxStyleZebra: TcxStyle
      AssignedValues = [svColor]
      Color = 15329769
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
