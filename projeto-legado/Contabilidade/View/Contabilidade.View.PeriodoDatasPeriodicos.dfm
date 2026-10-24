inherited frmPeriodoDatasPeriodicos: TfrmPeriodoDatasPeriodicos
  Width = 352
  Height = 371
  BorderIcons = [biSystemMenu]
  Caption = 'Informe'
  ExplicitWidth = 352
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 5
    Top = 11
    Width = 87
    Height = 14
    Caption = 'Data Lan'#231'amento:'
  end
  object Label2: TLabel [1]
    Left = 5
    Top = 39
    Width = 206
    Height = 14
    Caption = 'Quantidade de Per'#237'odos a Serem Gerados:'
  end
  object Label3: TLabel [2]
    Left = 5
    Top = 73
    Width = 67
    Height = 14
    Caption = 'Usar Dia Fixo:'
  end
  object Label4: TLabel [3]
    Left = 5
    Top = 112
    Width = 99
    Height = 14
    Caption = 'Periodicidade (Dias):'
  end
  inherited pnlBotoes: TPanel
    Top = 300
    Width = 346
    TabOrder = 4
    ExplicitTop = 300
    ExplicitWidth = 346
    inherited FlwBotoes: TFlowPanel
      Width = 342
      ExplicitWidth = 342
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 266
      ExplicitLeft = 266
    end
  end
  inherited pnlStatus: TPanel
    Top = 326
    Width = 346
    TabOrder = 5
    ExplicitTop = 326
    ExplicitWidth = 346
    inherited pnlNomeForm: TPanel
      Left = 175
      ExplicitLeft = 175
    end
    inherited pnlInfo: TPanel
      Width = 175
      ExplicitWidth = 175
    end
  end
  object edtDtaLanc: TcxDateEdit [6]
    Tag = 99
    Left = 215
    Top = 8
    TabOrder = 0
    Width = 121
  end
  object edtQtdPeriodos: TEditFocus [7]
    Tag = 99
    Left = 215
    Top = 36
    Width = 69
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 1
    Text = '001'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttInteiro
  end
  object rgDiaFixo: TRadioGroup [8]
    Tag = 99
    Left = 215
    Top = 65
    Width = 121
    Height = 37
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'N'#227'o'
      'Sim')
    TabOrder = 2
    TabStop = True
    OnClick = rgDiaFixoClick
    OnEnter = rgDiaFixoEnter
    OnExit = rgDiaFixoExit
  end
  object edtDias: TEditFocus [9]
    Tag = 99
    Left = 215
    Top = 109
    Width = 69
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 3
    Text = '001'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttInteiro
  end
  object Grid: TcxGrid [10]
    Left = 8
    Top = 143
    Width = 328
    Height = 151
    TabOrder = 6
    TabStop = False
    object GridTab: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDatas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object GridTabCODIGO: TcxGridDBColumn
        DataBinding.FieldName = 'CODIGO'
        Visible = False
        VisibleForCustomization = False
      end
      object GridTabDATA_: TcxGridDBColumn
        Caption = 'Data Lan'#231'amento'
        DataBinding.FieldName = 'DATA_'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 151
      end
    end
    object GridLevel1: TcxGridLevel
      GridView = GridTab
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 56
  end
  object cdsDatas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 8
    object cdsDatasCODIGO: TAutoIncField
      FieldName = 'CODIGO'
    end
    object cdsDatasDATA_: TDateField
      FieldName = 'DATA_'
    end
  end
  object dsDatas: TDataSource
    AutoEdit = False
    DataSet = cdsDatas
    Left = 464
    Top = 56
  end
end
