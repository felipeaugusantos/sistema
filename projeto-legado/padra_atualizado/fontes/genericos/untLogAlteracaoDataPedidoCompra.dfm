inherited frmLogAlteracaoDataPedidoCompra: TfrmLogAlteracaoDataPedidoCompra
  Width = 452
  Height = 457
  Caption = 'Altera'#231#227'o de data do pedido'
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
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 446
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
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
  object pnlMotivo: TPanel [3]
    Left = 0
    Top = 314
    Width = 446
    Height = 70
    Align = alBottom
    TabOrder = 2
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
  object pnlAlteracaoPorProduto: TPanel [4]
    Left = 0
    Top = 174
    Width = 446
    Height = 140
    Align = alBottom
    TabOrder = 4
    object cxLogItens: TcxGrid
      Left = 1
      Top = 17
      Width = 444
      Height = 122
      Align = alClient
      TabOrder = 0
      object cxLogItensView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxLogItensViewCellClick
        DataController.DataSource = dtsDadosItens
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxLogItensCodItem: TcxGridDBColumn
          Caption = 'C'#243'd. Item'
          DataBinding.FieldName = 'PCD_CODITE'
          Width = 75
        end
        object cxLogItensDesItem: TcxGridDBColumn
          Caption = 'Desc. Item'
          DataBinding.FieldName = 'PCD_DESITE'
          Width = 150
        end
        object cxLogItensDataAlteracao: TcxGridDBColumn
          Caption = 'Data Altera'#231#227'o'
          DataBinding.FieldName = 'LOGDTA'
          PropertiesClassName = 'TcxDateEditProperties'
          Width = 85
        end
        object cxLogItensHoraAlteracao: TcxGridDBColumn
          Caption = 'Hora Altera'#231#227'o'
          DataBinding.FieldName = 'LOGHOR'
          PropertiesClassName = 'TcxTimeEditProperties'
          Width = 84
        end
        object cxLogItensOperador: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'CODOPE'
          Width = 71
        end
        object cxLogItensDataAntiga: TcxGridDBColumn
          Caption = 'Data Antiga'
          DataBinding.FieldName = 'DTAATU'
          PropertiesClassName = 'TcxDateEditProperties'
          Width = 87
        end
        object cxLogItensDataNova: TcxGridDBColumn
          Caption = 'Data Nova'
          DataBinding.FieldName = 'DTANOV'
          PropertiesClassName = 'TcxDateEditProperties'
          Width = 99
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxLogItensView
      end
    end
    object pnlAlteracaoPorProdutoTitulo: TPanel
      Left = 1
      Top = 1
      Width = 444
      Height = 16
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Por Item:'
      TabOrder = 1
    end
  end
  object pnlAlteracaoPorPedido: TPanel [5]
    Left = 0
    Top = 37
    Width = 446
    Height = 137
    Align = alClient
    TabOrder = 5
    ExplicitTop = 45
    object pnlAlteracaoPorPedidoTitulo: TPanel
      Left = 1
      Top = 1
      Width = 444
      Height = 16
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Por Pedido:'
      TabOrder = 0
    end
    object cxGrid1: TcxGrid
      Left = 1
      Top = 17
      Width = 444
      Height = 119
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 37
      ExplicitWidth = 446
      ExplicitHeight = 137
      object cxDadosView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxDadosViewCellClick
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
  end
  object dtsDados: TDataSource
    Left = 340
    Top = 200
  end
  object dtsDadosItens: TDataSource
    Left = 148
    Top = 152
  end
end
