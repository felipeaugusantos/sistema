inherited frmFatDefineLoteEntregaFuturaFaltaProduto: TfrmFatDefineLoteEntregaFuturaFaltaProduto
  Width = 1133
  Height = 697
  BorderStyle = bsSingle
  Caption = 'Vendas de Entrega Futura - Falta de Produto'
  ExplicitWidth = 1133
  ExplicitHeight = 697
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 626
    Width = 1127
    TabOrder = 3
    ExplicitTop = 626
    ExplicitWidth = 1127
    inherited FlwBotoes: TFlowPanel
      Width = 1123
      ExplicitWidth = 1123
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1044
      Caption = '&Sair'
      ExplicitLeft = 1044
    end
  end
  inherited pnlStatus: TPanel
    Top = 652
    Width = 1127
    TabOrder = 4
    ExplicitTop = 652
    ExplicitWidth = 1127
    inherited pnlNomeForm: TPanel
      Left = 956
      ExplicitLeft = 956
    end
    inherited pnlInfo: TPanel
      Width = 956
      ExplicitWidth = 956
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 1127
    Height = 65
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblProduto: TLabel
      Left = 6
      Top = 10
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object lblCliente: TLabel
      Left = 11
      Top = 33
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 52
      Top = 7
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttInteiro
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 52
      Top = 30
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttInteiro
    end
    object edtNomCli: TEditFocus
      Left = 138
      Top = 30
      Width = 559
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16770261
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomPro: TEditFocus
      Left = 138
      Top = 7
      Width = 559
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16770261
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
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 585
    Width = 1127
    Height = 41
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblLegendaEnter: TLabel
      Left = 4
      Top = 6
      Width = 104
      Height = 14
      Caption = '* [ENTER] para alterar'
    end
    object lblLegendaSalDis: TLabel
      Left = 4
      Top = 23
      Width = 253
      Height = 14
      Caption = '** Seram listados apenas itens com saldo dispon'#237'vel.'
    end
  end
  object grdDocumentos: TcxGrid [4]
    Left = 0
    Top = 65
    Width = 1127
    Height = 520
    Align = alClient
    TabOrder = 1
    object grdDocumentosDBTableView: TcxGridDBTableView
      OnKeyDown = grdDocumentosDBTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdDocumentosCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 49
      end
      object grdDocumentosDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
      end
      object grdDocumentosREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
      end
      object grdDocumentosQTDPEN: TcxGridDBColumn
        Caption = 'Qtde. Pendente'
        DataBinding.FieldName = 'QTDPEN'
        Width = 93
      end
      object grdDocumentosDTAVEN: TcxGridDBColumn
        Caption = 'Dta. Venda'
        DataBinding.FieldName = 'DTAVEN'
      end
      object grdDocumentosCODCLI: TcxGridDBColumn
        DataBinding.FieldName = 'CODCLI'
        Visible = False
      end
      object grdDocumentosNOMCLI: TcxGridDBColumn
        DataBinding.FieldName = 'NOMCLI'
        Visible = False
      end
      object grdDocumentosCLIENT: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENT'
      end
      object grdDocumentosNUMDOC: TcxGridDBColumn
        DataBinding.FieldName = 'NUMDOC'
        Visible = False
      end
      object grdDocumentosESPDOC: TcxGridDBColumn
        DataBinding.FieldName = 'ESPDOC'
        Visible = False
      end
      object grdDocumentosCODEMP: TcxGridDBColumn
        DataBinding.FieldName = 'CODEMP'
        Visible = False
      end
      object grdDocumentosDOCVEN: TcxGridDBColumn
        Caption = 'Doc. Venda'
        DataBinding.FieldName = 'DOCVEN'
      end
      object grdDocumentosREQUIS: TcxGridDBColumn
        Caption = 'Requisi'#231#227'o'
        DataBinding.FieldName = 'REQUIS'
        Width = 67
      end
      object grdDocumentosNUMPED: TcxGridDBColumn
        DataBinding.FieldName = 'NUMPED'
        Visible = False
      end
      object grdDocumentosESPPED: TcxGridDBColumn
        DataBinding.FieldName = 'ESPPED'
        Visible = False
      end
      object grdDocumentosEMPPED: TcxGridDBColumn
        DataBinding.FieldName = 'EMPPED'
        Visible = False
      end
      object grdDocumentosPEDCOM: TcxGridDBColumn
        Caption = 'Ped. Compra'
        DataBinding.FieldName = 'PEDCOM'
      end
      object grdDocumentosNUMENT: TcxGridDBColumn
        DataBinding.FieldName = 'NUMENT'
        Visible = False
      end
      object grdDocumentosESPENT: TcxGridDBColumn
        DataBinding.FieldName = 'ESPENT'
        Visible = False
      end
      object grdDocumentosEMPENT: TcxGridDBColumn
        DataBinding.FieldName = 'EMPENT'
        Visible = False
      end
      object grdDocumentosDOCENT: TcxGridDBColumn
        Caption = 'Doc. Entrada'
        DataBinding.FieldName = 'DOCENT'
      end
    end
    object grdDocumentosLevel: TcxGridLevel
      GridView = grdDocumentosDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1096
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1096
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1080
    Top = 232
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 104
    object cdsDocumentosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsDocumentosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsDocumentosREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsDocumentosQTDPEN: TFloatField
      FieldName = 'QTDPEN'
      DisplayFormat = '#0.0000'
      EditFormat = '#0.0000'
    end
    object cdsDocumentosDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object cdsDocumentosCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsDocumentosNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsDocumentosCLIENT: TStringField
      FieldName = 'CLIENT'
      Size = 69
    end
    object cdsDocumentosNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsDocumentosESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsDocumentosCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsDocumentosDOCVEN: TStringField
      FieldName = 'DOCVEN'
      Size = 19
    end
    object cdsDocumentosREQUIS: TStringField
      FieldName = 'REQUIS'
      Size = 6
    end
    object cdsDocumentosNUMPED: TStringField
      FieldName = 'NUMPED'
      Size = 12
    end
    object cdsDocumentosESPPED: TStringField
      FieldName = 'ESPPED'
      Size = 2
    end
    object cdsDocumentosEMPPED: TStringField
      FieldName = 'EMPPED'
      Size = 3
    end
    object cdsDocumentosPEDCOM: TStringField
      FieldName = 'PEDCOM'
      Size = 19
    end
    object cdsDocumentosNUMENT: TStringField
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsDocumentosESPENT: TStringField
      FieldName = 'ESPENT'
      Size = 2
    end
    object cdsDocumentosEMPENT: TStringField
      FieldName = 'EMPENT'
      Size = 3
    end
    object cdsDocumentosDOCENT: TStringField
      FieldName = 'DOCENT'
      Size = 19
    end
    object cdsDocumentosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsDocumentosMOTFUT: TStringField
      FieldName = 'MOTFUT'
      Size = 1
    end
    object cdsDocumentosDTAFUT: TDateField
      FieldName = 'DTAFUT'
    end
    object cdsDocumentosCODUNI: TStringField
      FieldName = 'CODUNI'
      Size = 4
    end
    object cdsDocumentosNUMLOT: TStringField
      FieldName = 'NUMLOT'
    end
    object cdsDocumentosCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 64
    Top = 168
  end
end
