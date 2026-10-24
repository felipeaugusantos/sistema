inherited frmFatDefineLoteSeparacao: TfrmFatDefineLoteSeparacao
  Width = 820
  Height = 340
  Caption = 'Define Lote Para Separa'#231#227'o'
  ExplicitWidth = 820
  ExplicitHeight = 340
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 269
    Width = 814
    ExplicitTop = 269
    ExplicitWidth = 814
    inherited FlwBotoes: TFlowPanel
      Width = 810
      ExplicitWidth = 810
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 731
      ExplicitLeft = 731
    end
  end
  inherited pnlStatus: TPanel
    Top = 295
    Width = 814
    ExplicitTop = 295
    ExplicitWidth = 814
    inherited pnlNomeForm: TPanel
      Left = 643
      ExplicitLeft = 643
    end
    inherited pnlInfo: TPanel
      Width = 643
      ExplicitWidth = 643
    end
  end
  object cxgItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 814
    Height = 248
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensDBTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensDBTableViewCustomDrawCell
      DataController.DataSource = dtsItens
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 60
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 400
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgItensLOCFIS: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgItensNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.OnChange = cxgItensNUMLOTPropertiesChange
        Properties.OnValidate = cxgItensNUMLOTPropertiesValidate
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensDBTableView
    end
  end
  object pnlLegendas: TPanel [3]
    Left = 0
    Top = 248
    Width = 814
    Height = 21
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object shpEditavel: TShape
      Left = 13
      Top = 6
      Width = 10
      Height = 10
      Brush.Color = clYellow
    end
    object lblEditavel: TLabel
      Left = 27
      Top = 4
      Width = 85
      Height = 14
      Caption = 'Campos edit'#225'veis'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1000
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 952
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 880
    Top = 48
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 72
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItensNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#0.0000'
      EditFormat = '#0.0000'
    end
    object cdsItensLOCFIS: TStringField
      FieldName = 'LOCFIS'
    end
    object cdsItensNUMLOT: TStringField
      FieldName = 'NUMLOT'
      Size = 30
    end
    object cdsItensEMPITE: TStringField
      FieldName = 'EMPITE'
      Size = 3
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 152
    Top = 72
  end
end
