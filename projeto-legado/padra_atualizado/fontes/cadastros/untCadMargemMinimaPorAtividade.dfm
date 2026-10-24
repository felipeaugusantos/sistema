inherited frmCadMargemMinimaPorAtividade: TfrmCadMargemMinimaPorAtividade
  Width = 900
  Height = 433
  Caption = 'Margem M'#237'nima por Atividade'
  Position = poMainFormCenter
  ExplicitWidth = 900
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 360
    Width = 894
    ExplicitTop = 360
    ExplicitWidth = 894
    inherited FlwBotoes: TFlowPanel
      Width = 890
      ExplicitWidth = 890
      object btnGravar: TBitBtnLocked
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 121
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ F10 ] Gravar'
        Enabled = False
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 814
      ExplicitLeft = 814
    end
  end
  inherited pnlStatus: TPanel
    Top = 388
    Width = 894
    ExplicitTop = 388
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 544
      Width = 350
      ExplicitLeft = 544
      ExplicitWidth = 350
    end
    inherited pnlInfo: TPanel
      Width = 544
      ExplicitWidth = 544
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 894
    Height = 38
    Align = alTop
    TabOrder = 2
    object lblEmpresa: TLabel
      Left = 28
      Top = 11
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 75
      Top = 8
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 123
      Top = 8
      Width = 292
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
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 328
    Width = 894
    Height = 32
    Align = alBottom
    TabOrder = 3
    object btnReplicarParaTodasAsAtividades: TBitBtnLocked
      AlignWithMargins = True
      Left = 651
      Top = 6
      Width = 236
      Height = 20
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alCustom
      Anchors = [akRight, akBottom]
      Caption = '[ F12 ] Replicar para todas as atividades'
      Enabled = False
      TabOrder = 0
      OnClick = btnReplicarParaTodasAsAtividadesClick
    end
  end
  object cxAtividades: TcxGridCitel [4]
    Left = 0
    Top = 38
    Width = 894
    Height = 290
    Align = alClient
    Enabled = False
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxAtividadesView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsAtividades
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftNull]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '< Sem dados para exibir >'
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxAtividadesViewCODATI: TcxGridDBColumn
        DataBinding.FieldName = 'CODATI'
        Options.Editing = False
        Width = 71
      end
      object cxAtividadesViewDESATI: TcxGridDBColumn
        DataBinding.FieldName = 'DESATI'
        Options.Editing = False
        Width = 250
      end
      object cxAtividadesViewMARMIN: TcxGridDBColumn
        Caption = 'Mar. Min. Vend. J'#250'nior'
        DataBinding.FieldName = 'MARMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
      object cxAtividadesViewMARMSG: TcxGridDBColumn
        Caption = 'Mar. Min. Sub. Gerente J'#250'nior'
        DataBinding.FieldName = 'MARMSG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
      object cxAtividadesViewMARMGE: TcxGridDBColumn
        Caption = 'Mar. Min. Gerente J'#250'nior'
        DataBinding.FieldName = 'MARMGE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
      object cxAtividadesViewMARMMV: TcxGridDBColumn
        Caption = 'Mar. Min. Vend. Master'
        DataBinding.FieldName = 'MARMMV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
      object cxAtividadesViewMARMMS: TcxGridDBColumn
        Caption = 'Mar. Min. Sub. Gerente Master'
        DataBinding.FieldName = 'MARMMS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
      object cxAtividadesViewMARMMG: TcxGridDBColumn
        Caption = 'Mar. Min. Gerente Master'
        DataBinding.FieldName = 'MARMMG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '% ,0.00;-% ,0.00'
        Width = 90
      end
    end
    object cxAtividadesLevel1: TcxGridLevel
      GridView = cxAtividadesView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 256
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 256
  end
  object cdsAtividades: TUniClientDataSet
    Aggregates = <>
    Params = <>
    OnNewRecord = cdsAtividadesNewRecord
    Left = 88
    Top = 256
    object cdsAtividadesAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsAtividadesCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsAtividadesCODATI: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODATI'
      Size = 3
    end
    object cdsAtividadesDESATI: TStringField
      DisplayLabel = 'Atividades'
      FieldName = 'DESATI'
      Size = 70
    end
    object cdsAtividadesMARMIN: TFloatField
      DisplayLabel = 'Desc. M'#225'x. Vend. J'#250'nior'
      FieldName = 'MARMIN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsAtividadesMARMSG: TFloatField
      DisplayLabel = 'Desc. M'#225'x. Sub. Gerente J'#250'nior'
      FieldName = 'MARMSG'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsAtividadesMARMGE: TFloatField
      DisplayLabel = 'Desc. M'#225'x. Gerente J'#250'nior'
      FieldName = 'MARMGE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsAtividadesMARMMV: TFloatField
      DisplayLabel = 'Desc. M'#225'x. Vend. Master'
      FieldName = 'MARMMV'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsAtividadesMARMMS: TFloatField
      DisplayLabel = 'Desc. M'#225'x. Sub. Gerente Master'
      FieldName = 'MARMMS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsAtividadesMARMMG: TFloatField
      DisplayLabel = 'Desc. M'#225'x. Gerente Master'
      FieldName = 'MARMMG'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dtsAtividades: TDataSource
    DataSet = cdsAtividades
    Left = 56
    Top = 256
  end
end
