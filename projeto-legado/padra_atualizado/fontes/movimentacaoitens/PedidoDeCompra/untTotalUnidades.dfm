inherited frmTotalUnidades: TfrmTotalUnidades
  Width = 384
  Height = 402
  Caption = 'Total por Unidades'
  Position = poMainFormCenter
  ExplicitWidth = 384
  ExplicitHeight = 402
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 329
    Width = 378
    ExplicitTop = 329
    ExplicitWidth = 378
    inherited FlwBotoes: TFlowPanel
      Width = 374
      ExplicitWidth = 374
    end
    inherited btnSair: TBitBtnLocked
      Left = 298
      ExplicitLeft = 298
    end
  end
  inherited pnlStatus: TPanel
    Top = 357
    Width = 378
    ExplicitTop = 357
    ExplicitWidth = 378
    inherited pnlNomeForm: TPanel
      Left = 207
      ExplicitLeft = 207
    end
    inherited pnlInfo: TPanel
      Width = 207
      ExplicitWidth = 207
    end
  end
  object cxGrid1: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 378
    Height = 329
    Align = alClient
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsUnidades
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique Aqui para Filtrar'
      FilterRow.Visible = True
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'C'#243'd. Uni.'
        DataBinding.FieldName = 'UNI_CODUNI'
        MinWidth = 60
        Width = 60
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Sigla'
        DataBinding.FieldName = 'UNI_SIGUNI'
        MinWidth = 60
        Width = 60
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Kilo/Litro'
        DataBinding.FieldName = 'UNI_KILLIT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        OnGetDisplayText = cxGrid1DBTableView1Column3GetDisplayText
        MinWidth = 55
        Width = 55
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        Caption = 'Litros/Kilos'
        DataBinding.FieldName = 'KILLIT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        MinWidth = 91
        Width = 91
      end
      object cxGrid1DBTableView1Column5: TcxGridDBColumn
        Caption = 'Metragem'
        DataBinding.FieldName = 'METRAG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        MinWidth = 91
        Width = 91
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 420
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 48
  end
  object dtsUnidades: TDataSource
    Left = 108
    Top = 164
  end
end
