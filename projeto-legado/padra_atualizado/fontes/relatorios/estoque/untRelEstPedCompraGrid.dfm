inherited frmRelEstPedCompraGrid: TfrmRelEstPedCompraGrid
  Left = 206
  Top = 304
  Width = 1024
  Height = 768
  BorderStyle = bsSingle
  Caption = 'Pedidos de Compra em Aberto'
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 711
    Width = 1018
    ExplicitTop = 711
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      TabOrder = 2
      ExplicitLeft = 938
    end
    object btnReqCom: TBitBtnLocked
      Left = 258
      Top = 3
      Width = 215
      Height = 22
      Caption = '[ F6 ] &Requisi'#231#245'es de Compra'
      TabOrder = 1
      OnClick = btnReqComClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlTail: TPanel [2]
    Left = 0
    Top = 669
    Width = 1018
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Label2: TLabel
      Left = 123
      Top = 7
      Width = 66
      Height = 14
      Caption = 'Cota'#231#227'o (CO)'
    end
    object Shape2: TShape
      Left = 104
      Top = 7
      Width = 18
      Height = 14
      Brush.Color = clRed
      Pen.Style = psClear
    end
    object Label1: TLabel
      Left = 27
      Top = 7
      Width = 56
      Height = 14
      Caption = 'Pedido (PD)'
    end
    object Shape1: TShape
      Left = 8
      Top = 7
      Width = 18
      Height = 14
      Brush.Color = clBlue
      Pen.Style = psClear
    end
    object Shape3: TShape
      Left = 211
      Top = 7
      Width = 18
      Height = 14
      Brush.Color = clFuchsia
      Pen.Style = psClear
    end
    object Label3: TLabel
      Left = 230
      Top = 7
      Width = 171
      Height = 14
      Caption = 'Pedido de Compra de Garantia (GF)'
    end
  end
  object cxgPedCompra: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 536
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvPedCompra: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvPedCompraCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvPedCompraTIPDOC: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'TIPDOC'
        Width = 45
      end
      object cxvPedCompraPCD_NUMPED: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'PCD_NUMPED'
        Width = 90
      end
      object cxvPedCompraPCD_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'PCD_CODEMP'
        Width = 40
      end
      object cxvPedCompraPCD_CODFOR: TcxGridDBColumn
        Caption = 'Cod.Fornec.'
        DataBinding.FieldName = 'PCD_CODFOR'
        Width = 80
      end
      object cxvPedCompraFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 219
      end
      object cxvPedCompraPCG_DTAPED: TcxGridDBColumn
        Caption = 'Emiss'#227'o'
        DataBinding.FieldName = 'PCG_DTAPED'
        Width = 90
      end
      object cxvPedCompraLOG_DTAATU: TcxGridDBColumn
        Caption = 'Prev. Entrega Original'
        DataBinding.FieldName = 'LOG_DTAATU'
        PropertiesClassName = 'TcxDateEditProperties'
        MinWidth = 120
        Width = 120
      end
      object cxvPedCompraPCD_DTAENT: TcxGridDBColumn
        Caption = 'Prev. Entrega'
        DataBinding.FieldName = 'PCD_DTAENT'
        Width = 90
      end
      object cxvPedCompraPCD_QTDITE: TcxGridDBColumn
        Caption = 'Qtde. a Entregar'
        DataBinding.FieldName = 'PCD_QTDITE'
        Width = 90
      end
      object cxvPedCompraUNI_SIGUNI: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Width = 35
      end
      object cxvPedCompraPCD_EMBALA: TcxGridDBColumn
        Caption = 'Qtd. Emb.'
        DataBinding.FieldName = 'PCD_EMBALA'
        Width = 65
      end
      object cxvPedCompraUNITAR: TcxGridDBColumn
        Caption = 'Valor Unit'#225'rio'
        DataBinding.FieldName = 'UNITAR'
        Width = 85
      end
      object cxvPedCompraPGC_COMPRA: TcxGridDBColumn
        Caption = 'Comprador'
        DataBinding.FieldName = 'PGC_COMPRA'
        Width = 150
      end
      object cxvPedCompraQTDCON: TcxGridDBColumn
        Caption = 'Qtde. Conferida'
        DataBinding.FieldName = 'QTDCON'
        Width = 95
      end
      object cxvPedCompraQTDREQ: TcxGridDBColumn
        Caption = 'Qtd. Reserv. Requisi'#231#245'es'
        DataBinding.FieldName = 'QTDREQ'
        Width = 130
      end
      object cxvPedCompraMotivoAlteracaoDataEntrega: TcxGridDBColumn
        Caption = 'Motivo Alt. Dta. Entrega'
        DataBinding.FieldName = 'motivoAlteracao'
        Width = 120
      end
    end
    object cxgPedCompraLevel: TcxGridLevel
      GridView = cxvPedCompra
    end
  end
  object pnlObservacao: TPanel [4]
    Left = 0
    Top = 536
    Width = 1018
    Height = 133
    Align = alBottom
    TabOrder = 4
    object lblObservacao: TLabel
      Left = 1
      Top = 1
      Width = 1016
      Height = 14
      Align = alTop
      Caption = 'Observa'#231#227'o'
      ExplicitWidth = 60
    end
    object memObserv: TMemo
      Tag = 99
      AlignWithMargins = True
      Left = 4
      Top = 18
      Width = 1010
      Height = 111
      Align = alClient
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1500
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 56
  end
  object dtsConsulta: TDataSource
    Left = 424
    Top = 56
  end
end
