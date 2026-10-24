object frmPnlDadosEquLocacao: TfrmPnlDadosEquLocacao
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsNone
  ClientHeight = 235
  ClientWidth = 1024
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object cxGridNegociacaoDiarias: TcxGridCitel
    Tag = 99
    Left = 0
    Top = 0
    Width = 481
    Height = 235
    Align = alLeft
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsNegociacaoDiarias
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridDBTableViewCitel1QTDDIA: TcxGridDBColumn
        Caption = 'Quantidade de Dias'
        DataBinding.FieldName = 'QTDDIA'
        Width = 123
      end
      object cxGridDBTableViewCitel1VLRTOT: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'VLRTOT'
        Width = 110
      end
      object cxGridDBTableViewCitel1VLRDIA: TcxGridDBColumn
        Caption = 'Valor Calculado da Di'#225'ria'
        DataBinding.FieldName = 'VLRDIA'
        Width = 153
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableViewCitel1
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 481
    Top = 0
    Width = 10
    Height = 235
  end
  object cxGridContratoEqu: TcxGridCitel
    Tag = 99
    Left = 491
    Top = 0
    Width = 533
    Height = 235
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 497
    object cxGridDBTableViewCitel2: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsContratoEqu
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridDBTableViewCitelEQL_NROCON: TcxGridDBColumn
        Caption = 'N'#250'mero Contrato'
        DataBinding.FieldName = 'EQL_NROCON'
        Width = 150
      end
      object cxGridDBTableViewCitelEQL_DTAINI: TcxGridDBColumn
        Caption = 'Data Inicial'
        DataBinding.FieldName = 'EQL_DTAINI'
        Width = 90
      end
      object cxGridDBTableViewCitelEQL_HORINI: TcxGridDBColumn
        Caption = 'Hora Inicial'
        DataBinding.FieldName = 'EQL_HORINI'
        Width = 90
      end
      object cxGridDBTableViewCitelEQL_DTAFIN: TcxGridDBColumn
        Caption = 'Data Final'
        DataBinding.FieldName = 'EQL_DTAFIN'
        Width = 90
      end
      object cxGridDBTableViewCitelEQL_HORFIN: TcxGridDBColumn
        Caption = 'Hora Final'
        DataBinding.FieldName = 'EQL_HORFIN'
        Width = 90
      end
      object cxGridDBTableViewCitelEQL_STATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'EQL_STATUS'
      end
    end
    object cxGridLevel2: TcxGridLevel
      GridView = cxGridDBTableViewCitel2
    end
  end
  object dtsNegociacaoDiarias: TUniDataSource
    DataSet = cdsNegociacaoDiarias
    Left = 52
    Top = 161
  end
  object cdsNegociacaoDiarias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'QTDDIA'
        DataType = ftInteger
      end
      item
        Name = 'VLRTOT'
        DataType = ftFloat
      end
      item
        Name = 'VLRDIA'
        DataType = ftFloat
      end
      item
        Name = 'INDEX'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 164
    Top = 161
    object cdsNegociacaoDiariasQTDDIA: TIntegerField
      FieldName = 'QTDDIA'
    end
    object cdsNegociacaoDiariasVLRTOT: TFloatField
      FieldName = 'VLRTOT'
      DisplayFormat = '#,##0.00'
    end
    object cdsNegociacaoDiariasVLRDIA: TFloatField
      FieldName = 'VLRDIA'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsContratoEqu: TUniDataSource
    DataSet = cdsContratoEqu
    Left = 548
    Top = 153
  end
  object cdsContratoEqu: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 640
    Top = 152
    object cdsContratoEquEQL_NROCON: TStringField
      FieldName = 'EQL_NROCON'
    end
    object cdsContratoEquEQL_DTAINI: TDateField
      FieldName = 'EQL_DTAINI'
    end
    object cdsContratoEquEQL_HORINI: TTimeField
      FieldName = 'EQL_HORINI'
    end
    object cdsContratoEquEQL_DTAFIN: TDateTimeField
      FieldName = 'EQL_DTAFIN'
    end
    object cdsContratoEquEQL_HORFIN: TDateTimeField
      FieldName = 'EQL_HORFIN'
    end
    object cdsContratoEquEQL_STATUS: TStringField
      FieldName = 'EQL_STATUS'
    end
  end
end
