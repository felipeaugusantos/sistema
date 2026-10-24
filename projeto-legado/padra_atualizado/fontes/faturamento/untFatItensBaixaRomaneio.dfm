inherited frmFatItensBaixaRomaneio: TfrmFatItensBaixaRomaneio
  Width = 700
  Height = 389
  BorderIcons = [biSystemMenu]
  Caption = 'Itens do Documento'
  Position = poMainFormCenter
  ExplicitWidth = 700
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 694
    ExplicitTop = 316
    ExplicitWidth = 694
    inherited FlwBotoes: TFlowPanel
      Width = 690
      ExplicitWidth = 690
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnRestaurarTudo: TBitBtnLocked
        Left = 90
        Top = 0
        Width = 195
        Height = 22
        Caption = '[ F9 ] Restaurar Qtd. de Todos os Itens'
        TabOrder = 1
        OnClick = btnRestaurarTudoClick
      end
      object btnRestaurarItem: TBitBtnLocked
        Left = 285
        Top = 0
        Width = 170
        Height = 22
        Caption = '[ F8 ] Restaurar Qtd. do Item'
        TabOrder = 2
        OnClick = btnRestaurarItemClick
      end
      object btnItemNaoEntregue: TBitBtnLocked
        Left = 455
        Top = 0
        Width = 135
        Height = 22
        Caption = '[ DEL ] Item N'#227'o Entregue'
        TabOrder = 3
        OnClick = btnItemNaoEntregueClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 602
      Top = 2
      Width = 90
      ExplicitLeft = 602
      ExplicitTop = 2
      ExplicitWidth = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 694
    ExplicitTop = 344
    ExplicitWidth = 694
    inherited pnlNomeForm: TPanel
      Left = 523
      ExplicitLeft = 523
    end
    inherited pnlInfo: TPanel
      Width = 523
      ExplicitWidth = 523
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 694
    Height = 60
    Align = alTop
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 30
      Top = 35
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtNumDoc: TEditFocus
      Left = 67
      Top = 8
      Width = 126
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 67
      Top = 31
      Width = 460
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 60
    Width = 694
    Height = 256
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensDBTableViewCitel1: TcxGridDBTableViewCitel
      OnKeyDown = cxgItensDBTableViewCitel1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensDBTableViewCitel1CustomDrawCell
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object DET_CODITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'DET_CODITE'
        Options.Editing = False
        Width = 65
      end
      object DET_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DET_DESCRI'
        Options.Editing = False
        Width = 374
      end
      object DET_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'DET_NUMLOT'
        Options.Editing = False
        Width = 101
      end
      object DET_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'DET_QTDITE'
        Options.Editing = False
      end
      object DET_QTDBAI: TcxGridDBColumn
        Caption = 'Qtd. Entregue'
        DataBinding.FieldName = 'DET_QTDBAI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '#,##0.0000;-0.0000'
        Properties.OnEditValueChanged = DET_QTDBAIPropertiesEditValueChanged
        Width = 73
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensDBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1280
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 616
    Top = 8
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 188
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 412
    Top = 188
  end
end
