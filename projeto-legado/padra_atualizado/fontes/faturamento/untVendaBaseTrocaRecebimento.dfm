inherited frmVendaBaseTrocaRecebimento: TfrmVendaBaseTrocaRecebimento
  Width = 1076
  Height = 665
  Caption = 'Venda Base de Troca - Recebimento de Produtos'
  OnDestroy = FormDestroy
  ExplicitWidth = 1076
  ExplicitHeight = 665
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 594
    Width = 1070
    TabOrder = 3
    ExplicitTop = 594
    ExplicitWidth = 1070
    inherited FlwBotoes: TFlowPanel
      Width = 1066
      ExplicitWidth = 1066
      inherited btnConfirma: TBitBtnLocked
        Width = 147
        Caption = '&Fechamento '
        ExplicitWidth = 147
      end
      object btnEntradaSemVinculo: TBitBtnLocked
        Left = 147
        Top = 0
        Width = 166
        Height = 22
        Caption = '&Entrada Sem V'#237'nculo'
        TabOrder = 1
        OnClick = btnEntradaSemVinculoClick
      end
      object btnBaixarSemRecebimento: TBitBtnLocked
        Left = 313
        Top = 0
        Width = 155
        Height = 22
        Caption = '&Baixa Sem Recebimento'
        TabOrder = 2
        OnClick = btnBaixarSemRecebimentoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 987
      ExplicitLeft = 987
    end
  end
  inherited pnlStatus: TPanel
    Top = 620
    Width = 1070
    TabOrder = 4
    ExplicitTop = 620
    ExplicitWidth = 1070
    inherited pnlNomeForm: TPanel
      Left = 899
      ExplicitLeft = 899
    end
    inherited pnlInfo: TPanel
      Width = 899
      ExplicitWidth = 899
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 1070
    Height = 97
    Align = alTop
    TabOrder = 0
    object lblCodCliente: TLabel
      Left = 27
      Top = 16
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblPeriodo: TLabel
      Left = 23
      Top = 41
      Width = 39
      Height = 14
      Caption = 'Per'#237'odo:'
    end
    object Label7: TLabel
      Left = 143
      Top = 41
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label1: TLabel
      Left = 17
      Top = 65
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 68
      Top = 13
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 138
      Top = 13
      Width = 383
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 68
      Top = 37
      Width = 69
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 155
      Top = 37
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnPesquisar: TBitBtnLocked
      Left = 944
      Top = 66
      Width = 99
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 6
      OnClick = btnPesquisarClick
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 68
      Top = 61
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 138
      Top = 61
      Width = 383
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxGridPendencias: TcxGridCitel [3]
    Left = 0
    Top = 97
    Width = 1070
    Height = 456
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridPendenciasDBTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxGridPendenciasDBTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridPendenciasDBTableViewCustomDrawCell
      DataController.DataSource = dtsPendencias
      DataController.Filter.Options = [fcoCaseInsensitive]
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
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridPendenciasDBTableViewMARCADO: TcxGridDBColumn
        DataBinding.FieldName = 'MARCADO'
        Visible = False
      end
      object cxGridPendenciasDBTableViewDOCUMENTO: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUMENTO'
        Options.Editing = False
        Width = 165
      end
      object cxGridPendenciasDBTableViewPEN_DTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'PEN_DTAENT'
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridPendenciasDBTableViewPRODUTO: TcxGridDBColumn
        Caption = 'Produto Venda'
        DataBinding.FieldName = 'PRODUTO'
        Options.Editing = False
        Width = 515
      end
      object cxGridPendenciasDBTableViewPEN_TOTITE: TcxGridDBColumn
        Caption = 'Vlr. Total'
        DataBinding.FieldName = 'PEN_TOTITE'
        Options.Editing = False
        Width = 89
      end
      object cxGridPendenciasDBTableViewBTNINFPROD: TcxGridDBColumn
        Caption = 'Recebimento'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Buttons = <
          item
            Caption = 'Informar Produto'
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001B744558745469746C65004164643B506C75733B426172733B526962
              626F6E3B9506332F0000036349444154785E35927D6C535518C69F73EE6DEB64
              63A3AEFB60A3A36E33B8C56581E0D8707E21CC1A43A2A22304FE3001512A86C4
              E900132451FF503367420043B244364C483031465C248B4441C0980C45B4D065
              CDBA4ECAE82AAC5DBBDE8FF3E1BD27F1397973DE9C3CBFF7233964226FC2D543
              A53E0280443E3FD752525AB14323FA06685A3381E492F329C6ADF39954E2F8C9
              C3DBA6018858DE940A9C2C5870C1D51BB6FAF61DBB327860F81A1BFE25297FB8
              3127C7EFE4E5D5745E9EBB9991239766E481937FE4DE1818DB0DC0EB322EABBA
              B63FD5EB7D6CCBBE6F1B83FE9E67BA82E084C0E4123697CAE0D109BC94805B0C
              E7AFCC606A66EEECF75FBCBB753AFAEB2201A0BD3E7861B02914D8DBF34408A9
              AC0D2181D3672E23319D81AB950D016CEBED824E809A722FC62E4CE17A343130
              D4DF73507FB9FFAB551E9F6FCF93EB82B879BB088D52504A14FCC9CE4E95F79D
              B80CD396284A8179C7D3DD1144F29FEC5BE1D73E1BA6BEB2C09BEDCD955A7CCE
              44D1744C1687C9045C05EBFC686F0DAADCB08413D2098E89B4E1BC5779965687
              5ED585D03ACBFDA548E7197EFA711C776EDFC5FF12200A7075F4E85975D7D4FA
              F1F4A635A82C5F02A2956CD46D2EEB1D160B455BC19FEE5E0F4A885A45828071
              81137D1B61DB0C1E5D43E4C8CF5858E4D0A1810BBA5CB76DEEBDB768C1E604AE
              EA6B1F40D9121F0A265385BC0E5457530109404A8010E27805EEE60598CDA15B
              8699C8E7CD4784EEC3F2BA00767C340A4AA9327E79300CE1505BDEFF0E9AA681
              5082150DD5604CA26858282E1693D428E42F6666B3909068EF68C5E6171FC7E6
              17BA611A260C93A9029C713CF7FC3A3C1BEE404B5B2398E0989FCBA190FD774C
              CFA46243B11B4B77ADADF67BB236478E10500AA5D2121D5C48354D3A674108A1
              56114C201E4BB1D9F86FA70880FB1EDD3E34B0A229B4E7E1350FC2E22E2011BF
              16C3FCBD050557562DC3CA964608B8B4C4E49F4924A27F1F193F1DD9AF03B0FE
              1AFDE03D113EDC6431B1A96575089212B4AD6D555F581280D902398343308EC9
              EB49DC9A981A75E043000CA46D09005A49457059DB4BC78E77EDFCDAEAFDF892
              DC3B1295EF7C13977D4E444E45E52BCE5BE7AE338555E10FDF0650EE32B30E4B
              D24C0212A8F210EAAED3D01969BB3FD0BCDDE32BEB06D56AD5D09CCDDA66EE62
              EED6EF43A9AB2331008603ABCEFF019D3AAD15CCD8D2E00000000049454E44AE
              426082}
            Kind = bkText
            LeftAlignment = True
          end>
        Properties.MaxLength = 0
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = cxGridPendenciasDBTableViewBTNINFPRODPropertiesButtonClick
        Width = 106
      end
      object cxGridPendenciasDBTableViewPEN_TOTREC: TcxGridDBColumn
        Caption = 'Vlr. Tot. Rec.'
        DataBinding.FieldName = 'PEN_TOTREC'
        Options.Editing = False
        Width = 95
      end
    end
    object cxGridPendenciasLevel1: TcxGridLevel
      GridView = cxGridPendenciasDBTableView
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 553
    Width = 1070
    Height = 41
    Align = alBottom
    TabOrder = 2
    object lblVlrTotal: TLabel
      Left = 933
      Top = 14
      Width = 25
      Height = 14
      Caption = 'Total:'
    end
    object shpSepImp: TShape
      Left = 12
      Top = 8
      Width = 12
      Height = 12
      Brush.Color = clBlue
    end
    object lblSepImpJaImp: TLabel
      Left = 27
      Top = 6
      Width = 203
      Height = 14
      Caption = 'Produtos com itens vinculados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtTotRec: TCurrencyEditFocus
      Tag = 99
      Left = 964
      Top = 10
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 79
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 160
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 260
    Top = 176
  end
  object cdsPendencias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 632
    Top = 184
    object cdsPendenciasMARCADO: TStringField
      FieldName = 'MARCADO'
    end
    object cdsPendenciasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsPendenciasPEN_DTAENT: TDateField
      FieldName = 'PEN_DTAENT'
    end
    object cdsPendenciasPEN_HORENT: TDateTimeField
      FieldName = 'PEN_HORENT'
    end
    object cdsPendenciasPEN_NUMDOC: TStringField
      FieldName = 'PEN_NUMDOC'
    end
    object cdsPendenciasPEN_ESPDOC: TStringField
      FieldName = 'PEN_ESPDOC'
    end
    object cdsPendenciasPEN_CODEMP: TStringField
      FieldName = 'PEN_CODEMP'
    end
    object cdsPendenciasPEN_CODITE: TStringField
      FieldName = 'PEN_CODITE'
    end
    object cdsPendenciasPEN_STATUS: TStringField
      FieldName = 'PEN_STATUS'
    end
    object cdsPendenciasDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
    end
    object cdsPendenciasPRODUTO: TStringField
      DisplayWidth = 100
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cdsPendenciasPEN_TOTREC: TFloatField
      FieldName = 'PEN_TOTREC'
    end
    object cdsPendenciasPEN_TOTITE: TFloatField
      FieldName = 'PEN_TOTITE'
    end
  end
  object dtsPendencias: TDataSource
    DataSet = cdsPendencias
    Left = 560
    Top = 184
  end
end
