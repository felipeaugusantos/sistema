inherited frmEntradaAutomatizadaNotas: TfrmEntradaAutomatizadaNotas
  Width = 896
  Height = 492
  BorderStyle = bsSizeable
  Caption = 'Entrada de Mercadorias Automatizada'
  ExplicitWidth = 896
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 411
    Width = 880
    TabOrder = 1
    ExplicitTop = 411
    ExplicitWidth = 880
    inherited FlwBotoes: TFlowPanel
      Width = 876
      ExplicitWidth = 876
      inherited btnConfirma: TBitBtnLocked
        Width = 158
        Caption = '[ F10 ] &Carrega Nota'
        ModalResult = 7
        ExplicitWidth = 158
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 800
      Top = 2
      Caption = 'S&air'
      ExplicitLeft = 800
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 437
    Width = 880
    TabOrder = 2
    ExplicitTop = 437
    ExplicitWidth = 880
    inherited pnlNomeForm: TPanel
      Left = 709
      ExplicitLeft = 709
    end
    inherited pnlInfo: TPanel
      Width = 709
      ExplicitWidth = 709
    end
  end
  object cxgNotas: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 880
    Height = 411
    Align = alClient
    TabOrder = 0
    object cxvNotas: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvNotasB08_NNF: TcxGridDBColumn
        Caption = 'N'#250'mero da Nota'
        DataBinding.FieldName = 'B08_NNF'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxvNotasB07_SERIE: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'B07_SERIE'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object cxvNotasB09_DEMI: TcxGridDBColumn
        Caption = 'Emiss'#227'o'
        DataBinding.FieldName = 'B09_DEMI'
        HeaderAlignmentHorz = taCenter
      end
      object cxvNotasTOTNOT: TcxGridDBColumn
        Caption = 'Total de Produtos'
        DataBinding.FieldName = 'TOTNOT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Width = 102
      end
      object cxvNotasGER_CODFOR: TcxGridDBColumn
        Caption = 'C'#243'd.Fornecedor'
        DataBinding.FieldName = 'GER_CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 93
      end
      object cxvNotasFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 449
      end
    end
    object cxgNotasLevel1: TcxGridLevel
      GridView = cxvNotas
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 264
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 88
    Top = 112
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
