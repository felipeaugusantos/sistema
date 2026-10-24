inherited frmAbfIcmDetalheAliquotaCargaMedia: TfrmAbfIcmDetalheAliquotaCargaMedia
  Width = 1035
  Height = 538
  BorderStyle = bsSizeable
  Caption = ''
  WindowState = wsMaximized
  ExplicitWidth = 1035
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 457
    Width = 1019
    ExplicitTop = 457
    ExplicitWidth = 1019
    inherited FlwBotoes: TFlowPanel
      Width = 1015
      ExplicitWidth = 1015
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      ExplicitLeft = 939
    end
  end
  inherited pnlStatus: TPanel
    Top = 483
    Width = 1019
    ExplicitTop = 483
    ExplicitWidth = 1019
    inherited pnlNomeForm: TPanel
      Left = 848
      ExplicitLeft = 848
    end
    inherited pnlInfo: TPanel
      Width = 848
      ExplicitWidth = 848
    end
  end
  object cxGrid1: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1019
    Height = 457
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrid1DBTableView1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
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
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para Exibir>'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGrid1DBTableView1Column9: TcxGridDBColumn
        Caption = 'Perfil'
        DataBinding.FieldName = 'PERFIL'
        Width = 347
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'Perfil'
        DataBinding.FieldName = 'PERFIL'
        Visible = False
        GroupIndex = 0
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'UNIFED'
        HeaderAlignmentHorz = taCenter
        Width = 24
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = '%Base ST'
        DataBinding.FieldName = 'BASEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        Caption = '%Alq Int.'
        DataBinding.FieldName = 'ALQINT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxGrid1DBTableView1Column5: TcxGridDBColumn
        Caption = '%Red Empresa'
        DataBinding.FieldName = 'REDEMP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxGrid1DBTableView1Column6: TcxGridDBColumn
        Caption = '%Alq. Carga Liq.'
        DataBinding.FieldName = 'CARLIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 108
      end
      object cxGrid1DBTableView1Column7: TcxGridDBColumn
        Caption = 'IVA'
        DataBinding.FieldName = 'ALQIVA'
        HeaderAlignmentHorz = taRightJustify
        Width = 69
      end
      object cxGrid1DBTableView1Column8: TcxGridDBColumn
        Caption = 'Forma Calculo'
        DataBinding.FieldName = 'FORCAL'
        Width = 109
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 576
    Top = 144
  end
  object cdsDados: TUniClientDataSet
    PersistDataPacket.Data = {
      CE0000009619E0BD010000001800000009000000000003000000CE0006504552
      46494C010049000000010005574944544802000200640006554E494645440100
      49000000010005574944544802000200140006414C51494E5408000400000000
      0006524544454D500800040000000000064341524C4951080004000000000006
      414C51495641080004000000000006464F5243414C0100490000000100055749
      445448020002001400064241534553540800040000000000034B455901004900
      000001000557494454480200020064000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PERFIL'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'UNIFED'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ALQINT'
        DataType = ftFloat
      end
      item
        Name = 'REDEMP'
        DataType = ftFloat
      end
      item
        Name = 'CARLIQ'
        DataType = ftFloat
      end
      item
        Name = 'ALQIVA'
        DataType = ftFloat
      end
      item
        Name = 'FORCAL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BASEST'
        DataType = ftFloat
      end
      item
        Name = 'KEY'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 344
    Top = 212
    object cdsDadosPERFIL: TStringField
      DisplayWidth = 100
      FieldName = 'PERFIL'
      Size = 100
    end
    object cdsDadosUNIFED: TStringField
      FieldName = 'UNIFED'
    end
    object cdsDadosALQINT: TFloatField
      FieldName = 'ALQINT'
    end
    object cdsDadosREDEMP: TFloatField
      FieldName = 'REDEMP'
    end
    object cdsDadosCARLIQ: TFloatField
      FieldName = 'CARLIQ'
    end
    object cdsDadosALQIVA: TFloatField
      FieldName = 'ALQIVA'
    end
    object cdsDadosFORCAL: TStringField
      FieldName = 'FORCAL'
    end
    object cdsDadosBASEST: TFloatField
      FieldName = 'BASEST'
    end
    object cdsDadosKEY: TStringField
      FieldName = 'KEY'
      Size = 100
    end
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 468
    Top = 280
  end
end
