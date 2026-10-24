inherited frmSelPedidoRequisicao: TfrmSelPedidoRequisicao
  Width = 1024
  Height = 556
  BorderStyle = bsSizeable
  Caption = 'Selecione o Pedido de Compra que atender'#225' a requisi'#231#227'o '
  ExplicitWidth = 1024
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 475
    Width = 1008
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 469
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 927
      ExplicitWidth = 927
      inherited btnConfirma: TBitBtnLocked
        Width = 137
        ExplicitWidth = 137
      end
      object btnMarDes: TBitBtnLocked
        Left = 137
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ENTER] Marca / Desmarca'
        TabOrder = 1
        OnClick = btnMarDesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Align = alRight
      ExplicitLeft = 929
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 501
    Width = 1008
    TabOrder = 3
    ExplicitTop = 501
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxgPedidos: TcxGridCitel [3]
    Left = 0
    Top = 65
    Width = 1008
    Height = 410
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvPedidos: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvPedidosCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvPedidosDTAPED: TcxGridDBColumn
        Caption = 'Data Pedido'
        DataBinding.FieldName = 'DTAPED'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 65
      end
      object cxvPedidosDTAENT: TcxGridDBColumn
        Caption = 'Data Entrega'
        DataBinding.FieldName = 'DTAENT'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 90
      end
      object cxvPedidosNUMPED: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'NUMPED'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 80
      end
      object cxvPedidosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 50
      end
      object cxvPedidosEMPDES: TcxGridDBColumn
        Caption = 'Emp.Dest.'
        DataBinding.FieldName = 'EMPDES'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 55
      end
      object cxvPedidosCODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
      end
      object cxvPedidosNOMFOR: TcxGridDBColumn
        Caption = 'Nome Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 215
      end
      object cxvPedidosQTDITE: TcxGridDBColumn
        Caption = 'Qtd. Pedido'
        DataBinding.FieldName = 'QTDPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##,0.00;-#,##,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 73
      end
      object cxvPedidosQTDREQ: TcxGridDBColumn
        Caption = 'Qtd. Requisi'#231#227'o'
        DataBinding.FieldName = 'QTDREQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##,0.00;-#,##,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 85
      end
      object cxvPedidosQTDDIS: TcxGridDBColumn
        Caption = 'Qtd. Dispon'#237'vel'
        DataBinding.FieldName = 'QTDDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##,0.00;-#,##,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 85
      end
      object cxvPedidosAUTDET: TcxGridDBColumn
        DataBinding.FieldName = 'AUTDET'
        Visible = False
      end
      object cxvPedidosAUTREQ: TcxGridDBColumn
        DataBinding.FieldName = 'AUTREQ'
        Visible = False
      end
      object cxvPedidosDOCORI: TcxGridDBColumn
        Caption = 'Doc. Transfer'#234'ncia'
        DataBinding.FieldName = 'DOCORI'
        Options.Editing = False
        Width = 131
      end
      object cxvPedidosSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Options.Editing = False
        Width = 120
      end
      object cxvPedidosORDCOM: TcxGridDBColumn
        Caption = 'Ordem Compra no Fornecedor'
        DataBinding.FieldName = 'ORDCON'
        Options.Editing = False
        Width = 175
      end
      object cxvPedidosNOTENT: TcxGridDBColumn
        Caption = 'Nota de Entrada'
        DataBinding.FieldName = 'NOTENT'
        Options.Editing = False
        Width = 87
      end
    end
    object cxgPedidosLevel1: TcxGridLevel
      GridView = cxvPedidos
    end
  end
  object pnlCabec: TPanel [4]
    Left = 0
    Top = 0
    Width = 1008
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 16
      Width = 56
      Height = 14
      Caption = 'Requisi'#231#227'o:'
    end
    object Label2: TLabel
      Left = 135
      Top = 16
      Width = 70
      Height = 14
      Caption = 'Empresa Req.:'
    end
    object Label3: TLabel
      Left = 26
      Top = 40
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object Label4: TLabel
      Left = 525
      Top = 40
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object Label5: TLabel
      Left = 712
      Top = 40
      Width = 42
      Height = 14
      Caption = 'Unidade:'
    end
    object Label6: TLabel
      Left = 335
      Top = 16
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object DBEditFocus1: TDBEditFocus
      Left = 69
      Top = 9
      Width = 60
      Height = 22
      Color = 16768952
      DataField = 'CODREQ'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Left = 209
      Top = 9
      Width = 40
      Height = 22
      Color = 16768952
      DataField = 'CODEMP'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus3: TDBEditFocus
      Left = 135
      Top = 33
      Width = 370
      Height = 22
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus4: TDBEditFocus
      Left = 584
      Top = 33
      Width = 110
      Height = 22
      Color = 16768952
      DataField = 'REFERE'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus5: TDBEditFocus
      Left = 757
      Top = 33
      Width = 40
      Height = 22
      Color = 16768952
      DataField = 'SIGUNI'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus6: TDBEditFocus
      Left = 394
      Top = 9
      Width = 110
      Height = 22
      Color = 16768952
      DataField = 'QTDITE'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus7: TDBEditFocus
      Left = 69
      Top = 33
      Width = 60
      Height = 22
      Color = 16768952
      DataField = 'CODITE'
      DataSource = dtsRequisicao
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
    Top = 240
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 192
  end
  object dtsRequisicao: TDataSource
    Left = 704
    Top = 208
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 216
    Top = 176
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
