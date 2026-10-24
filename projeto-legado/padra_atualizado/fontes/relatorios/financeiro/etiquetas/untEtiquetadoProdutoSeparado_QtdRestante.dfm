inherited frmEtiquetadoProdutoSeparado_QtdRestante: TfrmEtiquetadoProdutoSeparado_QtdRestante
  Width = 937
  Height = 569
  Caption = 
    'Etiqueta do Produto Separado / Etiqueta da Quantidade Restante d' +
    'a Embalagem Aberta'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 937
  ExplicitHeight = 569
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 931
    ExplicitTop = 496
    ExplicitWidth = 931
    inherited FlwBotoes: TFlowPanel
      Width = 927
      ExplicitWidth = 927
      object btnImprimir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 130
        Height = 22
        Caption = '[F10] &Imprimir'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
          8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
          8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
          8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 848
      ExplicitLeft = 848
    end
  end
  inherited pnlStatus: TPanel
    Top = 524
    Width = 931
    ExplicitTop = 524
    ExplicitWidth = 931
    inherited pnlNomeForm: TPanel
      Left = 760
      ExplicitLeft = 760
    end
    inherited pnlInfo: TPanel
      Width = 760
      ExplicitWidth = 760
    end
  end
  object pnlPedido: TPanel [2]
    Left = 0
    Top = 0
    Width = 931
    Height = 45
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 5
      Width = 32
      Height = 14
      Caption = 'Pedido'
    end
    object Label2: TLabel
      Left = 165
      Top = 5
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object edtNumPed: TEditFocus
      Left = 11
      Top = 18
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtEspPed: TEditFocus
      Left = 138
      Top = 18
      Width = 21
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      Text = 'PD'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object btnCarrega: TBitBtnLocked
      Left = 513
      Top = 17
      Width = 75
      Height = 22
      Caption = '&Carregar'
      TabOrder = 2
      OnClick = btnCarregaClick
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 165
      Top = 18
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 209
      Top = 18
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgDados: TcxGridCitel [3]
    Left = 0
    Top = 45
    Width = 931
    Height = 451
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
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
      object cxDadosColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'FDO_CODITE'
        Options.Editing = False
        Width = 52
      end
      object cxDadosCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. Fabricante'
        DataBinding.FieldName = 'ITE_CODFAB'
      end
      object cxDadosColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'FDO_DESCRI'
        Options.Editing = False
        Width = 184
      end
      object cxDadosColumn3: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'FDO_UNIDAD'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 48
      end
      object cxDadosColumn4: TcxGridDBColumn
        Caption = 'Qtd. Pedido'
        DataBinding.FieldName = 'FDO_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 87
      end
      object cxDadosQTDPED: TcxGridDBColumn
        Caption = 'Qtd. Etiqueta'
        DataBinding.FieldName = 'ITE_QTDETI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.MinValue = True
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '0'
        Properties.MaxLength = 99999
        Properties.MaxValue = 99999.000000000000000000
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle2
        Width = 67
      end
      object cxDadosQTDSEP: TcxGridDBColumn
        Caption = 'Qtd Separada'
        DataBinding.FieldName = 'FDO_QTDSEP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxDadosQTDFRA: TcxGridDBColumn
        Caption = 'Qtd. Fracionada'
        DataBinding.FieldName = 'FDO_QTDFRA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Properties.OnValidate = cxDadosQTDFRAPropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle2
        Width = 107
      end
      object cxDadosQTDPAC: TcxGridDBColumn
        Caption = 'Qtd. Pacote'
        DataBinding.FieldName = 'FDO_QTDPAC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Properties.OnValidate = cxDadosQTDPACPropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle2
        Width = 114
      end
      object cxDadosColumn8: TcxGridDBColumn
        Caption = 'Qtd. Nova Etiq Emb Aberta'
        DataBinding.FieldName = 'FDO_QTDRES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 134
      end
      object cxDadosColumn5: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica'
        DataBinding.FieldName = 'LOT_LOCFIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Options.Editing = False
        Width = 110
      end
      object cxDadosNUMLOTE: TcxGridDBColumn
        Caption = 'N'#250'm. Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
      end
      object cxDadosBARRAS: TcxGridDBColumn
        Caption = 'C'#243'd. Barras'
        DataBinding.FieldName = 'ITE_BARRAS'
      end
      object cxDadosMARCA: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
      end
      object cxDadosREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxDados
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 252
    Top = 172
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 128
  end
  object dtsDados: TDataSource
    Left = 456
    Top = 272
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 52
    Top = 4
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 16443110
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
  object cdsDadosEtiquetas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 548
    Top = 272
  end
end
