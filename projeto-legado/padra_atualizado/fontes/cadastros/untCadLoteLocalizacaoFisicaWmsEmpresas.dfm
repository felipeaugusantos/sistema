inherited frmCadLoteLocalizacaoFisicaWmsEmpresas: TfrmCadLoteLocalizacaoFisicaWmsEmpresas
  Width = 1049
  Height = 300
  Caption = 'Lotes Sem Localiza'#231#227'o F'#237'sica'
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1049
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 229
    Width = 1043
    TabOrder = 1
    ExplicitTop = 229
    ExplicitWidth = 1043
    inherited FlwBotoes: TFlowPanel
      Width = 1039
      ExplicitWidth = 1039
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 960
      ExplicitLeft = 960
    end
  end
  inherited pnlStatus: TPanel
    Top = 255
    Width = 1043
    TabOrder = 2
    ExplicitTop = 255
    ExplicitWidth = 1043
    inherited pnlNomeForm: TPanel
      Left = 872
      ExplicitLeft = 872
    end
    inherited pnlInfo: TPanel
      Width = 872
      ExplicitWidth = 872
    end
  end
  object GridLoteEmpresas: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1043
    Height = 229
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object GridTabLoteEmpresas: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = GridTabLoteEmpresasEditKeyPress
      OnFocusedItemChanged = GridTabLoteEmpresasFocusedItemChanged
      DataController.DataSource = dsLoteEmpresas
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridTabLoteEmpresasLOT_CODITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'LOT_CODITE'
        Options.Editing = False
        Width = 91
      end
      object GridTabLoteEmpresasITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 274
      end
      object GridTabLoteEmpresasLOT_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'LOT_CODEMP'
        Options.Editing = False
      end
      object GridTabLoteEmpresasLOT_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        Options.Editing = False
        Width = 110
      end
      object GridTabLoteEmpresasLOT_LOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOT_LOCFIS'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.OnEditValueChanged = GridTabLoteEmpresasLOT_LOCFISPropertiesEditValueChanged
        Width = 113
      end
      object GridTabLoteEmpresasLOC_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOC_DESCRI'
        Options.Editing = False
        Width = 350
      end
    end
    object GridLoteEmpresasLevel1: TcxGridLevel
      GridView = GridTabLoteEmpresas
    end
  end
  object dsLoteEmpresas: TDataSource
    Left = 696
    Top = 16
  end
end
