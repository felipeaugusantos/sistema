inherited frmFatRomaneioPedPendentes: TfrmFatRomaneioPedPendentes
  Width = 1000
  Height = 700
  BorderStyle = bsSingle
  Caption = 'Romaneio - Pedidos de Venda n'#227'o faturados'
  OnDestroy = FormDestroy
  ExplicitWidth = 1000
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 627
    Width = 994
    TabOrder = 2
    ExplicitTop = 627
    ExplicitWidth = 994
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 990
      object btnMarcaTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[F6] Marcar Todos'
        TabOrder = 0
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 110
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F7] Desmarcar Todos'
        TabOrder = 1
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 911
      ExplicitLeft = 911
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 994
    TabOrder = 3
    ExplicitTop = 655
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 823
      ExplicitLeft = 823
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 823
    end
  end
  object cxgPedidos: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 994
    Height = 586
    Align = alClient
    TabOrder = 0
    object cxgPedidosView: TcxGridDBTableViewCitel
      OnKeyUp = cxgPedidosViewKeyUp
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgPedidosViewCellDblClick
      OnCustomDrawCell = cxgPedidosViewCustomDrawCell
      DataController.DataSource = dtsConsul
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgPedidosViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgPedidosViewDTENTR: TcxGridDBColumn
        Caption = 'Dt. Entrega'
        DataBinding.FieldName = 'FDO_DTENTR'
        Width = 80
      end
      object cxgPedidosViewNUMDOC: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'FGO_NUMDOC'
        Width = 100
      end
      object cxgPedidosViewCODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'FGO_CODEMP'
        Width = 35
      end
      object cxgPedidosViewCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'FGO_CODCLI'
        Width = 70
      end
      object cxgPedidosViewNOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Width = 150
      end
      object cxgPedidosViewCODVEN: TcxGridDBColumn
        Caption = 'Ven.'
        DataBinding.FieldName = 'FGO_CODVEN'
        Width = 35
      end
      object cxgPedidosViewNOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        Width = 150
      end
      object cxgPedidosViewESTADO: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CID_ESTADO'
        Width = 35
      end
      object cxgPedidosViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Prod.'
        DataBinding.FieldName = 'FDO_CODITE'
        Width = 70
      end
      object cxgPedidosViewDESITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 150
      end
      object cxgPedidosViewUNIDAD: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'FDO_UNIDAD'
        Width = 35
      end
      object cxgPedidosViewENTRET: TcxGridDBColumn
        Caption = 'E/R'
        DataBinding.FieldName = 'FDO_ENTRET'
        Width = 50
      end
      object cxgPedidosViewQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'FDO_QTDITE'
        Width = 70
      end
      object cxgPedidosViewTOTPES: TcxGridDBColumn
        Caption = 'Peso Total'
        DataBinding.FieldName = 'FDO_TOTPES'
        Width = 70
      end
    end
    object cxgPedidosLevel: TcxGridLevel
      GridView = cxgPedidosView
    end
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 586
    Width = 994
    Height = 41
    Align = alBottom
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      994
      41)
    object Label1: TLabel
      Left = 508
      Top = 13
      Width = 131
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Produtos Selecionados:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 732
      Top = 13
      Width = 137
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Peso Total Selecionados:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotQuant: TEditFocus
      Left = 642
      Top = 10
      Width = 70
      Height = 22
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotPeso: TEditFocus
      Left = 872
      Top = 10
      Width = 100
      Height = 22
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsConsul: TDataSource
    Left = 440
    Top = 336
  end
end
