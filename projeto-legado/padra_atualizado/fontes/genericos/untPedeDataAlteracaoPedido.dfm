inherited frmPedeDataAlteracaoPedido: TfrmPedeDataAlteracaoPedido
  Height = 346
  Caption = 'Nova data de entrega do pedido'
  ExplicitHeight = 346
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 275
    ExplicitTop = 275
  end
  inherited pnlStatus: TPanel
    Top = 301
    ExplicitTop = 301
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblFornecedor: TLabel
      Left = 0
      Top = 14
      Width = 483
      Height = 14
      Align = alTop
      Caption = 'Fornecedor:'
      ExplicitWidth = 59
    end
    object lblPedido: TLabel
      Left = 0
      Top = 0
      Width = 483
      Height = 14
      Align = alTop
      Caption = 'Pedido:'
      ExplicitWidth = 35
    end
  end
  object gbPorPedido: TGroupBox [3]
    Left = 0
    Top = 31
    Width = 483
    Height = 120
    Align = alTop
    Caption = 'Por Pedido:'
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Top = 25
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nova Data:'
    end
    object Label2: TLabel
      Left = 31
      Top = 50
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object mmoMotivo: TMemo
      Tag = 99
      Left = 69
      Top = 50
      Width = 404
      Height = 63
      CharCase = ecUpperCase
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object mskDtaEntPed: TMaskEditFocus
      Tag = 99
      Left = 71
      Top = 20
      Width = 62
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = mskDtaEntPedExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object gbPorItem: TGroupBox [4]
    Left = 0
    Top = 151
    Width = 483
    Height = 124
    Align = alClient
    Caption = 'Por Item:'
    Padding.Left = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 4
    object cxgItensPedidoCompra: TcxGridCitel
      Left = 7
      Top = 16
      Width = 469
      Height = 101
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvItensPedidoCompra: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnGrouping = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridClmCodItem: TcxGridDBColumn
          Caption = 'Cod. Item'
          DataBinding.FieldName = 'PCD_CODITE'
          Options.Editing = False
          Width = 52
        end
        object cxGridClmDescricao: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'PCD_DESITE'
          Options.Editing = False
          Width = 140
        end
        object cxGridClmMarca: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'MAR_DESMAR'
          Options.Editing = False
          Width = 70
        end
        object cxGridClmCodFabrica: TcxGridDBColumn
          Caption = 'Cod. F'#225'brica'
          DataBinding.FieldName = 'ITE_CODITF'
          Options.Editing = False
          Width = 67
        end
        object cxGridClmDataEntregaAtual: TcxGridDBColumn
          Caption = 'Dt. Ent. Atual'
          DataBinding.FieldName = 'PCD_DTAENT'
          Options.Editing = False
          Width = 68
        end
        object cxGridClmDataEntregaNova: TcxGridDBColumn
          Caption = 'Dt. Ent. Nova'
          DataBinding.FieldName = 'NOVA_DATA_ENTREGA'
          PropertiesClassName = 'TcxDateEditProperties'
          Width = 70
        end
      end
      object cxgItensPedidoCompraLevel1: TcxGridLevel
        GridView = cxvItensPedidoCompra
      end
    end
  end
end
