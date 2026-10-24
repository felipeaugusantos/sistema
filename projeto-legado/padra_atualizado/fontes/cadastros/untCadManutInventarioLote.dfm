inherited frmCadManutInventarioLote: TfrmCadManutInventarioLote
  Width = 1066
  Height = 556
  BorderStyle = bsSizeable
  Caption = 'Manuten'#231#227'o de Invent'#225'rio'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1066
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 475
    Width = 1050
    ExplicitTop = 475
    ExplicitWidth = 1050
    object shpAltera: TShape [0]
      Left = 175
      Top = 6
      Width = 16
      Height = 15
      Brush.Color = clGreen
    end
    object Label1: TLabel [1]
      Left = 197
      Top = 7
      Width = 165
      Height = 14
      Caption = 'Colunas que podem ser alteradas '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1046
      ExplicitWidth = 1046
      inherited btnConfirma: TBitBtnLocked
        Width = 121
        Caption = '[ F10 ] &Confirma'
        Visible = False
        ExplicitWidth = 121
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 967
      Caption = '&Sair'
      ExplicitLeft = 967
    end
    object btnAjustar: TBitBtnLocked
      Left = 379
      Top = 4
      Width = 158
      Height = 20
      Caption = '[ F4 ] Consultar valor / Ajustar '
      TabOrder = 2
      OnClick = btnAjustarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 501
    Width = 1050
    ExplicitTop = 501
    ExplicitWidth = 1050
    inherited pnlNomeForm: TPanel
      Left = 879
      ExplicitLeft = 879
    end
    inherited pnlInfo: TPanel
      Width = 879
      ExplicitWidth = 879
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1050
    Height = 475
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBBandedTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Lote'
          FixedKind = fkLeft
          Width = 352
        end
        item
          Caption = 'Dados gerais'
          Width = 1000
        end>
      Zebra = True
      Destaque = False
      DestacarRegistro = False
      CorZebra = 14210774
      object cxvItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'LOT_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 63
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensNUMLOT: TcxGridDBBandedColumn
        Caption = 'N'#250'mero Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        GroupSummaryAlignment = taCenter
        Options.Editing = False
        Width = 68
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do item'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 221
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensSTATUS: TcxGridDBBandedColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsEditFixedList
        Properties.Items.Strings = (
          'ATIVO'
          'INATIVO'
          'BLOQUEADO')
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensCODGRU: TcxGridDBBandedColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'ITE_CODGRU'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensCODABF: TcxGridDBBandedColumn
        Caption = 'Abr. Fiscal'
        DataBinding.FieldName = 'ITE_CODABF'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPREMED: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o M'#233'dio'
        DataBinding.FieldName = 'ITE_PREMED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvItensREFERE: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensSALDOS: TcxGridDBBandedColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'LOT_SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000;-0.000'
        OnCustomDrawCell = cxvItensSALDOSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensPRECOM: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Compra'
        DataBinding.FieldName = 'ITE_PRECOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensPRECUS: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Custo'
        DataBinding.FieldName = 'ITE_PRECUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensPREULT: TcxGridDBBandedColumn
        Caption = #218'ltimo Pre'#231'o'
        DataBinding.FieldName = 'ITE_PREULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvItensIMPULT: TcxGridDBBandedColumn
        Caption = #218'ltimo Pre'#231'o + Imp.'
        DataBinding.FieldName = 'ITE_IMPULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvItensSALBAL: TcxGridDBBandedColumn
        Caption = 'Saldo Balan'#231'o'
        DataBinding.FieldName = 'LOT_SALBAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 280
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 128
  end
end
