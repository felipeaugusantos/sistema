inherited frmApuracaoLucroRealIrpjCsllManRecolhimento: TfrmApuracaoLucroRealIrpjCsllManRecolhimento
  Width = 967
  Height = 377
  Caption = 'Manuten'#231#227'o Recolhimento'
  ExplicitWidth = 967
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 306
    Width = 961
    TabOrder = 1
    ExplicitTop = 306
    ExplicitWidth = 961
    inherited FlwBotoes: TFlowPanel
      Width = 957
      ExplicitWidth = 957
    end
    inherited btnSair: TBitBtnLocked
      Left = 881
      ExplicitLeft = 881
    end
  end
  inherited pnlStatus: TPanel
    Top = 332
    Width = 961
    TabOrder = 2
    ExplicitTop = 332
    ExplicitWidth = 961
    inherited pnlNomeForm: TPanel
      Left = 790
      ExplicitLeft = 790
    end
    inherited pnlInfo: TPanel
      Width = 790
      ExplicitWidth = 790
    end
  end
  object GridCitel: TcxGridCitel [2]
    Left = 0
    Top = 25
    Width = 961
    Height = 281
    Align = alClient
    TabOrder = 0
    object GridCitelTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridCitelTableViewSELECIONADO: TcxGridDBColumn
        Caption = 'Selecionado?'
        DataBinding.FieldName = 'SELECIONADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Width = 81
      end
      object GridCitelTableViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        VisibleForCustomization = False
      end
      object GridCitelTableViewCON_DTALAN: TcxGridDBColumn
        Caption = 'Data Lancto'
        DataBinding.FieldName = 'CON_DTALAN'
        Options.Editing = False
        Width = 99
      end
      object GridCitelTableViewCON_VALLAN: TcxGridDBColumn
        Caption = 'Valor Lancto'
        DataBinding.FieldName = 'CON_VALLAN'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Options.Editing = False
        Width = 109
      end
      object GridCitelTableViewCON_HISTOR: TcxGridDBColumn
        Caption = 'Hist'#243'rico'
        DataBinding.FieldName = 'CON_HISTOR'
        Options.Editing = False
        Width = 523
      end
      object GridCitelTableViewTIPO: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'TIPO'
        Options.Editing = False
        Width = 110
      end
    end
    object GridCitelLevel1: TcxGridLevel
      GridView = GridCitelTableView
    end
  end
  object pnlInformativo: TPanel [3]
    Left = 0
    Top = 0
    Width = 961
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Selecione os lan'#231'amentos que N'#195'O ser'#227'o considerados'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object dsDados: TDataSource
    Left = 504
    Top = 56
  end
end
