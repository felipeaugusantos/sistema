inherited frmLogAlteracaoDataFatPedidoCompra: TfrmLogAlteracaoDataFatPedidoCompra
  Width = 452
  Height = 457
  Caption = 'Altera'#231#227'o de data de faturamento do pedido'
  Position = poMainFormCenter
  ExplicitWidth = 452
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 384
    Width = 446
    ExplicitTop = 384
    ExplicitWidth = 446
    inherited FlwBotoes: TFlowPanel
      Width = 442
      ExplicitWidth = 442
    end
    inherited btnSair: TBitBtnLocked
      Left = 363
      ExplicitLeft = 363
    end
  end
  inherited pnlStatus: TPanel
    Top = 412
    Width = 446
    ExplicitTop = 412
    ExplicitWidth = 446
    inherited pnlNomeForm: TPanel
      Left = 275
      ExplicitLeft = 275
    end
    inherited pnlInfo: TPanel
      Width = 275
      ExplicitWidth = 275
    end
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 37
    Width = 446
    Height = 277
    Align = alClient
    TabOrder = 2
    object cxDadosView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxDadosViewLogDta: TcxGridDBColumn
        Caption = 'Data Altera'#231#227'o'
        DataBinding.FieldName = 'LOGDTA'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 85
      end
      object cxDadosViewLogHor: TcxGridDBColumn
        Caption = 'Hora Altera'#231#227'o'
        DataBinding.FieldName = 'LOGHOR'
        PropertiesClassName = 'TcxTimeEditProperties'
        Width = 84
      end
      object cxDadosViewCodOpe: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'CODOPE'
        Width = 71
      end
      object cxDadosViewDtaAtu: TcxGridDBColumn
        Caption = 'Data Antiga'
        DataBinding.FieldName = 'DTAATU'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 87
      end
      object cxDadosViewDtaNov: TcxGridDBColumn
        Caption = 'Data Nova'
        DataBinding.FieldName = 'DTANOV'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 99
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxDadosView
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 446
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object dbTxtPedido: TDBText
      Left = 0
      Top = 0
      Width = 446
      Height = 17
      Align = alTop
      DataField = 'PEDIDO'
      DataSource = dtsDados
      ExplicitTop = -6
    end
    object dbTxtFornecedor: TDBText
      Left = 0
      Top = 17
      Width = 446
      Height = 17
      Align = alTop
      DataField = 'FORNEC'
      DataSource = dtsDados
      ExplicitLeft = 1
      ExplicitTop = 24
      ExplicitWidth = 65
    end
  end
  object pnlMotivo: TPanel [4]
    Left = 0
    Top = 314
    Width = 446
    Height = 70
    Align = alBottom
    TabOrder = 3
    object mmoMotivo: TDBMemo
      Left = 1
      Top = 17
      Width = 444
      Height = 52
      Align = alClient
      DataField = 'MOTIVO'
      DataSource = dtsDados
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object lblMotivo: TPanel
      Left = 1
      Top = 1
      Width = 444
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Motivo'
      TabOrder = 1
    end
  end
  object dtsDados: TDataSource
    Left = 340
    Top = 200
  end
end
