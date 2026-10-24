inherited frmMostraOrdProIndProd: TfrmMostraOrdProIndProd
  Width = 385
  Height = 600
  Caption = 'Ordens de produ'#231#227'o pendentes'
  Position = poScreenCenter
  ExplicitWidth = 385
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 379
    TabOrder = 2
    ExplicitTop = 528
    ExplicitWidth = 442
    inherited btnSair: TBitBtnLocked
      Left = 296
      ExplicitLeft = 359
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 379
    TabOrder = 3
    ExplicitTop = 556
    ExplicitWidth = 442
    inherited pnlNomeForm: TPanel
      Left = 208
      ExplicitLeft = 271
    end
    inherited pnlInfo: TPanel
      Width = 208
      ExplicitWidth = 271
    end
  end
  object cxgOrdProInd: TcxGridCitel [3]
    Left = 0
    Top = 61
    Width = 379
    Height = 467
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -1
    ExplicitTop = 59
    ExplicitWidth = 346
    object cxgOrdProIndTV1: TcxGridDBTableViewCitel
      OnKeyDown = cxgOrdProIndTV1KeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsOrdProInd
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
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
      OptionsView.ExpandButtonsForEmptyDetails = False
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgOrdProIndTV1DTACAD: TcxGridDBColumn
        Caption = 'Dt. Cad.'
        DataBinding.FieldName = 'ORD_DTACAD'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 99
      end
      object cxgOrdProIndTV1NUMOP: TcxGridDBColumn
        Caption = 'Num. OP.'
        DataBinding.FieldName = 'ORD_CODORD'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Width = 139
      end
      object cxgOrdProIndTV1QTD: TcxGridDBColumn
        Caption = 'Qtd.'
        DataBinding.FieldName = 'QTDPEN'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 103
      end
    end
    object cxgOrdProIndDBTVPed: TcxGridDBTableViewCitel
      OnKeyDown = cxgOrdProIndDBTVPedKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsPedOrdPro
      DataController.DetailKeyFieldNames = 'FDO_SEQOPI'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'FDO_SEQOPI'
      DataController.MasterKeyFieldNames = 'AUTOINCREM'
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
      OptionsView.ExpandButtonsForEmptyDetails = False
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgOrdProIndDBTVPedPEDIDO: TcxGridDBColumn
        Caption = 'Pedido de Venda'
        DataBinding.FieldName = 'PEDIDO'
        Width = 300
      end
    end
    object cxgOrdProIndLVL1: TcxGridLevel
      GridView = cxgOrdProIndTV1
      object cxgOrdProIndLVLPed: TcxGridLevel
        GridView = cxgOrdProIndDBTVPed
      end
    end
  end
  object pnlProduto: TPanel [4]
    Left = 0
    Top = 0
    Width = 379
    Height = 61
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 442
    object lblProduto: TLabel
      Left = 23
      Top = 10
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label1: TLabel
      Left = 320
      Top = 34
      Width = 16
      Height = 14
      Alignment = taRightJustify
      Caption = 'Un:'
    end
    object Label2: TLabel
      Left = 7
      Top = 34
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object edtNomPro: TEditFocus
      Left = 104
      Top = 7
      Width = 268
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 338
      Top = 31
      Width = 34
      Height = 22
      TabStop = False
      Alignment = taCenter
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtReferencia: TEditFocus
      Left = 64
      Top = 31
      Width = 250
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPro: TEditFocus
      Left = 64
      Top = 7
      Width = 40
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 240
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 168
  end
  object dtsOrdProInd: TDataSource
    Left = 216
    Top = 112
  end
  object dtsPedOrdPro: TDataSource
    Left = 280
    Top = 112
  end
end
