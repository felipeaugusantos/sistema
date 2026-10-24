inherited frmGiroPromocao: TfrmGiroPromocao
  Width = 430
  Height = 461
  BorderIcons = [biSystemMenu]
  Caption = 'Giro - Item'
  Position = poScreenCenter
  ExplicitWidth = 430
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 388
    Width = 424
    ExplicitTop = 474
    ExplicitWidth = 518
    inherited FlwBotoes: TFlowPanel
      Width = 420
      ExplicitWidth = 514
    end
    inherited btnSair: TBitBtnLocked
      Left = 341
      ExplicitLeft = 435
    end
  end
  inherited pnlStatus: TPanel
    Top = 416
    Width = 424
    ExplicitTop = 502
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 253
      ExplicitLeft = 347
    end
    inherited pnlInfo: TPanel
      Width = 253
      ExplicitWidth = 347
    end
  end
  object cxGrid1: TcxGridCitel [2]
    Left = 0
    Top = 35
    Width = 424
    Height = 353
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 518
    ExplicitHeight = 439
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
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGrid1DBTableView1MES: TcxGridDBColumn
        Caption = 'M'#234's'
        DataBinding.FieldName = 'MES'
        Width = 80
      end
      object cxGrid1DBTableView1QTDPROC: TcxGridDBColumn
        Caption = 'Qtd. Vendida'
        DataBinding.FieldName = 'QTDVEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxGrid1DBTableView1QTDVEN: TcxGridDBColumn
        Caption = 'Qtd. Promo'#231#227'o'
        DataBinding.FieldName = 'QTDPROC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxGrid1DBTableView1QTDSEMPROMOC: TcxGridDBColumn
        Caption = 'Qtd. Sem Promo'#231#227'o'
        DataBinding.FieldName = 'QTDSEMPROMOC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 424
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Pitch = fpVariable
    Font.Style = []
    Padding.Left = 5
    Padding.Top = 3
    ParentFont = False
    TabOrder = 3
    ExplicitWidth = 518
    object Label1: TLabel
      Left = 5
      Top = 17
      Width = 419
      Height = 14
      Align = alTop
      Caption = 'Refer'#234'ncia: %s  Unidade: %s'
      ExplicitTop = 15
      ExplicitWidth = 189
    end
    object Label2: TLabel
      Left = 5
      Top = 3
      Width = 419
      Height = 14
      Align = alTop
      Caption = 'Produto: %s'
      ExplicitTop = 0
      ExplicitWidth = 77
    end
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 232
    Top = 256
  end
  object cdsDados: TUniClientDataSet
    PersistDataPacket.Data = {
      660000009619E0BD0100000018000000040000000000030000006600034D4553
      01004900000001000557494454480200020014000751544450524F4308000400
      000000000651544456454E08000400000000000C51544453454D50524F4D4F43
      08000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'MES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QTDPROC'
        DataType = ftFloat
      end
      item
        Name = 'QTDVEN'
        DataType = ftFloat
      end
      item
        Name = 'QTDSEMPROMOC'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 120
    object cdsDadosMES: TStringField
      FieldName = 'MES'
    end
    object cdsDadosQTDPROC: TFloatField
      FieldName = 'QTDPROC'
    end
    object cdsDadosQTDVEN: TFloatField
      FieldName = 'QTDVEN'
    end
    object cdsDadosQTDSEMPROMOC: TFloatField
      FieldName = 'QTDSEMPROMOC'
    end
  end
end
