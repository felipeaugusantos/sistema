inherited frmFatConvOrcPedVendaCasada: TfrmFatConvOrcPedVendaCasada
  Width = 1096
  Height = 520
  Caption = 'Convers'#227'o de or'#231'amento em pedido de venda em modo venda casada'
  OnDestroy = FormDestroy
  ExplicitWidth = 1096
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 449
    Width = 1090
    TabOrder = 3
    ExplicitTop = 449
    ExplicitWidth = 1090
    inherited FlwBotoes: TFlowPanel
      Width = 1086
      ExplicitWidth = 1086
      inherited btnConfirma: TBitBtnLocked
        Width = 232
        Caption = '&Converte or'#231'amento em pedido de venda'
        ExplicitWidth = 232
      end
      object btnGeraPromoc: TBitBtnLocked
        Left = 232
        Top = 0
        Width = 313
        Height = 22
        Caption = '&Gera promo'#231#227'o e atualiza pre'#231'o de custo do or'#231'amento'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnGeraPromocClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1007
      ExplicitLeft = 1007
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 1090
    TabOrder = 4
    ExplicitTop = 475
    ExplicitWidth = 1090
    inherited pnlNomeForm: TPanel
      Left = 919
      ExplicitLeft = 919
    end
    inherited pnlInfo: TPanel
      Width = 919
      ExplicitWidth = 919
    end
  end
  object pnlInformacao: TPanel [2]
    Left = 0
    Top = 0
    Width = 1090
    Height = 73
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -6
    object lblNumOrc: TLabel
      Left = 14
      Top = 8
      Width = 96
      Height = 14
      Caption = 'N'#250'mero Or'#231'amento:'
    end
    object lblCliente: TLabel
      Left = 14
      Top = 33
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblEmpresa: TLabel
      Left = 230
      Top = 8
      Width = 29
      Height = 14
      Caption = 'Emp. :'
    end
    object lblDataEmissao: TLabel
      Left = 14
      Top = 55
      Width = 59
      Height = 14
      Caption = 'Dt. Emiss'#227'o:'
    end
    object lblValorContabil: TLabel
      Left = 176
      Top = 55
      Width = 58
      Height = 14
      Caption = 'Vr. Cont'#225'bil:'
    end
    object lblVendedor: TLabel
      Left = 376
      Top = 55
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object edtNumOrc: TEditFocus
      Left = 112
      Top = 5
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumOrcExit
      OnKeyPress = edtNumOrcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 424
    Width = 1090
    Height = 25
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblTotalVenda: TLabel
      Left = 727
      Top = 6
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Venda:'
    end
    object Label3: TLabel
      Left = 34
      Top = 6
      Width = 99
      Height = 13
      Caption = 'Campos Edit'#225'veis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape1: TShape
      Left = 8
      Top = 3
      Width = 20
      Height = 20
      Brush.Color = clYellow
    end
  end
  object grdProdutos: TcxGrid [4]
    Left = 0
    Top = 73
    Width = 1090
    Height = 351
    Align = alClient
    TabOrder = 1
    object grdProdutosDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsProdutos
      DataController.KeyFieldNames = 'AUTINC'
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdProdutosTEMPRO: TcxGridDBColumn
        Caption = 'Promo'#231#227'o'
        DataBinding.FieldName = 'TEMPRO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Width = 62
      end
      object grdProdutosTEMRQC: TcxGridDBColumn
        Caption = 'Rq. Compra'
        DataBinding.FieldName = 'TEMRQC'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Width = 68
      end
      object grdProdutosPRODUT: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'PRODUT'
        Options.Editing = False
        Width = 262
      end
      object grdProdutosDESTIN: TcxGridDBColumn
        Caption = 'Destino'
        DataBinding.FieldName = 'DESTIN'
        Options.Editing = False
      end
      object grdProdutosUNIDAD: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNIDAD'
        Options.Editing = False
        Width = 34
      end
      object grdProdutosTABPRE: TcxGridDBColumn
        Caption = 'TAB'
        DataBinding.FieldName = 'TABPRE'
        Options.Editing = False
        Width = 31
      end
      object grdProdutosQTDITE: TcxGridDBColumn
        Caption = 'Qtd'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
      end
      object grdProdutosUNITAR: TcxGridDBColumn
        Caption = 'Pr. Unit.'
        DataBinding.FieldName = 'UNITAR'
        Options.Editing = False
      end
      object grdProdutosTOTITE: TcxGridDBColumn
        Caption = 'Total'
        DataBinding.FieldName = 'TOTITE'
        Options.Editing = False
      end
      object grdProdutosSALDOS: TcxGridDBColumn
        Caption = 'Saldo F'#237'sico'
        DataBinding.FieldName = 'SALDOS'
        Options.Editing = False
        Width = 72
      end
      object grdProdutosSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDIS'
        Options.Editing = False
        Width = 93
      end
      object grdProdutosPRECOM: TcxGridDBColumn
        Caption = 'Pr. Ped. Compra'
        DataBinding.FieldName = 'PRECOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.ReadOnly = False
        Properties.OnValidate = grdProdutosPRECOMPropertiesValidate
        OnCustomDrawCell = grdProdutosPRECOMCustomDrawCell
        Width = 86
      end
      object grdProdutosCUSPRO: TcxGridDBColumn
        Caption = 'Pr. Custo Promo'#231#227'o'
        DataBinding.FieldName = 'CUSPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.OnValidate = grdProdutosCUSPROPropertiesValidate
        OnCustomDrawCell = grdProdutosCUSPROCustomDrawCell
        Width = 105
      end
    end
    object grdProdutosLevel: TcxGridLevel
      GridView = grdProdutosDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1136
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1104
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1072
    Top = 8
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 96
    object cdsProdutosTEMPRO: TBooleanField
      FieldName = 'TEMPRO'
    end
    object cdsProdutosTEMRQC: TBooleanField
      FieldName = 'TEMRQC'
    end
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 101
    end
    object cdsProdutosPRODUT: TStringField
      FieldName = 'PRODUT'
      Size = 107
    end
    object cdsProdutosENTRET: TStringField
      FieldName = 'ENTRET'
      Size = 1
    end
    object cdsProdutosENTFUT: TStringField
      FieldName = 'ENTFUT'
      Size = 1
    end
    object cdsProdutosMOTFUT: TStringField
      FieldName = 'MOTFUT'
      Size = 1
    end
    object cdsProdutosDESTIN: TStringField
      FieldName = 'DESTIN'
      Size = 10
    end
    object cdsProdutosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 4
    end
    object cdsProdutosTABPRE: TStringField
      FieldName = 'TABPRE'
      Size = 1
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#0.0000'
      EditFormat = '#0.0000'
    end
    object cdsProdutosUNITAR: TFloatField
      FieldName = 'UNITAR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTOTITE: TFloatField
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosSALDOS: TFloatField
      FieldName = 'SALDOS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosSALDIS: TFloatField
      FieldName = 'SALDIS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosPRECOM: TFloatField
      FieldName = 'PRECOM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosCUSPRO: TFloatField
      FieldName = 'CUSPRO'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 56
    Top = 152
  end
  object cdsReqCom: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 96
    object cdsReqComRCD_CODITE: TStringField
      FieldName = 'RCD_CODITE'
      Size = 5
    end
    object cdsReqComRCD_DESITE: TStringField
      FieldName = 'RCD_DESITE'
      Size = 70
    end
    object cdsReqComRCD_OBSERV: TStringField
      FieldName = 'RCD_OBSERV'
      Size = 255
    end
    object cdsReqComRCD_DOCPDV: TStringField
      FieldName = 'RCD_DOCPDV'
      Size = 12
    end
    object cdsReqComRCD_ESPPDV: TStringField
      FieldName = 'RCD_ESPPDV'
      Size = 2
    end
    object cdsReqComRCD_EMPPDV: TStringField
      FieldName = 'RCD_EMPPDV'
      Size = 3
    end
    object cdsReqComRCD_QTDITE: TFloatField
      FieldName = 'RCD_QTDITE'
    end
    object cdsReqComRCD_DTPREV: TDateField
      FieldName = 'RCD_DTPREV'
    end
    object cdsReqComITE_CODFOR: TStringField
      FieldName = 'ITE_CODFOR'
      Size = 8
    end
  end
end
