inherited frmGarantiaEnvCliente: TfrmGarantiaEnvCliente
  Left = 131
  Top = 130
  Width = 1059
  Height = 550
  BorderIcons = [biSystemMenu]
  Caption = 'Envio para o Cliente'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1059
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 477
    Width = 1053
    TabOrder = 2
    ExplicitTop = 477
    ExplicitWidth = 1053
    DesignSize = (
      1053
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1049
      ExplicitWidth = 1049
      object btnConfirmar: TBitBtnLocked
        Tag = 99
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnBaixaTotal: TBitBtnLocked
        Tag = 99
        Left = 110
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F8 ] Baixa Total'
        Enabled = False
        TabOrder = 1
        OnClick = btnBaixaTotalClick
      end
      object btnObs: TBitBtnLocked
        Tag = 99
        Left = 220
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F9 ] Observa'#231#245'es'
        Enabled = False
        TabOrder = 2
        OnClick = btnObsClick
      end
      object btnImprimirSep: TBitBtnLocked
        Left = 330
        Top = 0
        Width = 159
        Height = 22
        Caption = '[ Alt + F5 ] Separa'#231#227'o do Item'
        Enabled = False
        TabOrder = 3
        Visible = False
        OnClick = btnImprimirSepClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 968
      Width = 83
      ExplicitLeft = 968
      ExplicitWidth = 83
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 1053
    TabOrder = 3
    ExplicitTop = 505
    ExplicitWidth = 1053
    inherited pnlNomeForm: TPanel
      Left = 882
      ExplicitLeft = 882
    end
    inherited pnlInfo: TPanel
      Width = 882
      ExplicitWidth = 882
    end
  end
  object pnlObs: TPanel [2]
    Left = 0
    Top = 349
    Width = 1053
    Height = 128
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 4
    Visible = False
    object Label12: TLabel
      Left = 11
      Top = 9
      Width = 34
      Height = 14
      AutoSize = False
      Caption = 'Obs 1:'
    end
    object Label13: TLabel
      Left = 11
      Top = 33
      Width = 34
      Height = 14
      AutoSize = False
      Caption = 'Obs 2:'
    end
    object Label4: TLabel
      Left = 11
      Top = 57
      Width = 34
      Height = 14
      AutoSize = False
      Caption = 'Obs 3:'
    end
    object Label5: TLabel
      Left = 11
      Top = 81
      Width = 34
      Height = 14
      AutoSize = False
      Caption = 'Obs 4:'
    end
    object Label6: TLabel
      Left = 11
      Top = 105
      Width = 34
      Height = 14
      AutoSize = False
      Caption = 'Obs 5:'
    end
    object edtObsF_2: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 29
      Width = 731
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_2'
      DataSource = dtsProdutos
      Enabled = False
      MaxLength = 100
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtObsF_1: TDBEditFocus
      Left = 44
      Top = 5
      Width = 731
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_1'
      DataSource = dtsProdutos
      Enabled = False
      MaxLength = 100
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtObsF_4: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 77
      Width = 731
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_4'
      DataSource = dtsProdutos
      Enabled = False
      MaxLength = 100
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtObsF_3: TDBEditFocus
      Left = 44
      Top = 53
      Width = 731
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_3'
      DataSource = dtsProdutos
      Enabled = False
      MaxLength = 100
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtObsF_5: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 101
      Width = 731
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_5'
      DataSource = dtsProdutos
      Enabled = False
      MaxLength = 100
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 40
    Width = 1053
    Height = 288
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensDBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxgItensDBTableViewCitel1EditKeyDown
      DataController.DataSource = dtsProdutos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
    end
    object cxgItensDBBandedTableView1: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensDBBandedTableView1CustomDrawCell
      OnEditKeyDown = cxgItensDBBandedTableView1EditKeyDown
      DataController.DataSource = dtsProdutos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Garantia'
        end
        item
          Caption = 'Fornecedor'
        end
        item
          Caption = 'Devolvidas'
        end
        item
          Caption = 'Digitadas'
        end>
      object cxgItensDBTableViewCitel1DOCUMENTO: TcxGridDBBandedColumn
        Caption = 'Doc. Garantia'
        DataBinding.FieldName = 'DOCUMENTO'
        Options.Editing = False
        Width = 137
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1CODITE: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CODITE'
        MinWidth = 57
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 57
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1DESITE: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DESITE'
        MinWidth = 190
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 190
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1UNIDAD: TcxGridDBBandedColumn
        DataBinding.FieldName = 'UNIDAD'
        MinWidth = 55
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 55
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1REPOST: TcxGridDBBandedColumn
        DataBinding.FieldName = 'REPOST'
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDREQ: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDREQ'
        MinWidth = 65
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDRET: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDRET'
        HeaderAlignmentHorz = taCenter
        MinWidth = 65
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDREF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDREF'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDDEV: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDDEV'
        HeaderAlignmentHorz = taCenter
        MinWidth = 65
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 65
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDPRE: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDPRE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 65
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 65
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDDEV_1: TcxGridDBBandedColumn
        Caption = 'Devolver'
        DataBinding.FieldName = 'QTDDEV_1'
        HeaderAlignmentHorz = taCenter
        MinWidth = 69
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 69
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDPRE_1: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDPRE_1'
        HeaderAlignmentHorz = taCenter
        MinWidth = 65
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 65
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDBTableViewCitel1QTDCRE_1: TcxGridDBBandedColumn
        DataBinding.FieldName = 'QTDCRE_1'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxgItensDBTableViewCitel1QTDCRE_1PropertiesValidate
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDBTableView1Citel1Origem: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ORIGEM'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensDBBandedTableView1
    end
  end
  object pnlFiltrosPesq: TPanel [4]
    Left = 0
    Top = 0
    Width = 1053
    Height = 40
    Align = alTop
    Caption = 'pnlFiltrosPesq'
    ShowCaption = False
    TabOrder = 0
    object pnlRadioOpcaoCliente: TPanel
      Left = 1
      Top = 19
      Width = 1051
      Height = 20
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlRadioOpcaoCliente'
      Padding.Left = 8
      ShowCaption = False
      TabOrder = 0
      Visible = False
      object Label2: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 3
        Width = 72
        Height = 14
        Align = alLeft
        Caption = 'Tipo de cliente:'
        Layout = tlCenter
      end
      object rdbFavorecido: TRadioButton
        AlignWithMargins = True
        Left = 225
        Top = 5
        Width = 176
        Height = 12
        Margins.Top = 5
        Align = alLeft
        Caption = 'Cliente Favorecido da Garantia'
        TabOrder = 0
      end
      object RadioButton1: TRadioButton
        AlignWithMargins = True
        Left = 89
        Top = 5
        Width = 130
        Height = 12
        Margins.Top = 5
        Align = alLeft
        Caption = 'Cliente do Recebimento'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
    end
    object pnlFiltroCliente: TPanel
      Left = 1
      Top = 1
      Width = 1051
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 1
      object Label1: TLabel
        Left = 11
        Top = 13
        Width = 35
        Height = 14
        AutoSize = False
        Caption = 'Cliente:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 47
        Top = 9
        Width = 110
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 0
        OnExit = edtCodCliExit
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
        Left = 158
        Top = 9
        Width = 614
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = 16768952
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlLegenda: TPanel [5]
    Left = 0
    Top = 328
    Width = 1053
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlLegenda'
    ShowCaption = False
    TabOrder = 5
    object shpLegenda: TShape
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 14
      Height = 15
      Align = alLeft
      Brush.Color = 14745599
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 23
      Top = 3
      Width = 468
      Height = 15
      Align = alLeft
      Caption = 
        'Item n'#227'o reposto no recebimento e dispon'#237'vel para reposi'#231#227'o (dev' +
        'olver) ou cr'#233'dito.  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 14
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 649
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
    Top = 168
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsProdutosBeforePost
    Left = 679
    Top = 88
    object cdsProdutosCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsProdutosUNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'UNIDAD'
      Size = 15
    end
    object cdsProdutosQTDREQ: TFloatField
      DisplayLabel = 'Requisitado'
      FieldName = 'QTDREQ'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDRET: TFloatField
      DisplayLabel = 'Retornado'
      FieldName = 'QTDRET'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDREF: TFloatField
      DisplayLabel = 'Refugado'
      FieldName = 'QTDREF'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDDEV: TFloatField
      DisplayLabel = 'Devolvida'
      FieldName = 'QTDDEV'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDPRE: TFloatField
      DisplayLabel = 'Preju'#237'zo'
      FieldName = 'QTDPRE'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDDEV_1: TFloatField
      DisplayLabel = 'Devolvida'
      FieldName = 'QTDDEV_1'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDPRE_1: TFloatField
      DisplayLabel = 'Preju'#237'zo'
      FieldName = 'QTDPRE_1'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsProdutosNUMENT: TStringField
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsProdutosCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsProdutosCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsProdutosCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsProdutosDTADEV: TDateTimeField
      FieldName = 'DTADEV'
    end
    object cdsProdutosOBSF_1: TStringField
      FieldName = 'OBSF_1'
      Size = 70
    end
    object cdsProdutosOBSF_2: TStringField
      FieldName = 'OBSF_2'
      Size = 70
    end
    object cdsProdutosOBSF_3: TStringField
      FieldName = 'OBSF_3'
      Size = 70
    end
    object cdsProdutosOBSF_4: TStringField
      FieldName = 'OBSF_4'
      Size = 70
    end
    object cdsProdutosOBSF_5: TStringField
      FieldName = 'OBSF_5'
      Size = 70
    end
    object cdsProdutosREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsProdutosCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsProdutosUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsProdutosPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsProdutosINCORI: TStringField
      FieldName = 'INCORI'
    end
    object cdsProdutosTEMLOTE: TStringField
      FieldName = 'TEMLOTE'
      Size = 1
    end
    object cdsProdutosLOTEPRINCIPALVENDA: TStringField
      FieldName = 'LOTEPRINCIPALVENDA'
      Size = 100
    end
    object cdsProdutosSALREP: TFloatField
      DisplayLabel = 'Saldo'
      FieldName = 'SALREP'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosSALPRE: TFloatField
      FieldName = 'SALPRE'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
    end
    object cdsProdutosQTDCRE_1: TFloatField
      DefaultExpression = '0'
      DisplayLabel = 'Cr'#233'dito'
      FieldName = 'QTDCRE_1'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosUNICRD: TFloatField
      FieldName = 'UNICRD'
    end
    object cdsProdutosORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 1
    end
    object cdsProdutosREPOST: TStringField
      DisplayLabel = 'Reposi'#231#227'o'
      FieldName = 'REPOST'
      Size = 1
    end
    object cdsProdutosCODFAV: TStringField
      FieldName = 'CODFAV'
      Size = 8
    end
    object cdsProdutosINCGER: TStringField
      FieldName = 'INCGER'
    end
    object cdsProdutosINCGAG: TStringField
      FieldName = 'INCGAG'
    end
    object cdsProdutosNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsProdutosESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsProdutosLOCFIS: TStringField
      FieldName = 'LOCFIS'
      Size = 30
    end
    object cdsProdutosAGG_QTDDEV_1: TAggregateField
      FieldName = 'AGG_QTDDEV_1'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDDEV_1)'
    end
    object cdsProdutosAGG_QTDPRE_1: TAggregateField
      FieldName = 'AGG_QTDPRE_1'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDPRE_1)'
    end
    object cdsProdutosAGG_QTDCRE_1: TAggregateField
      FieldName = 'AGG_QTDCRE_1'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDCRE_1)'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    OnDataChange = dtsProdutosDataChange
    Left = 709
    Top = 88
  end
  object frxDBGarantiaEC: TfrxDBDataset
    UserName = 'frxDBGarantiaEC'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODITE=CODITE'
      'DESITE=DESITE'
      'UNIDAD=UNIDAD'
      'QTDREQ=QTDREQ'
      'QTDRET=QTDRET'
      'QTDREF=QTDREF'
      'QTDDEV=QTDDEV'
      'QTDPRE=QTDPRE'
      'QTDDEV_1=QTDDEV_1'
      'QTDPRE_1=QTDPRE_1'
      'AUTINC=AUTINC'
      'NUMENT=NUMENT'
      'CODVEN=CODVEN'
      'CODCLI=CODCLI'
      'CODFOR=CODFOR'
      'DTADEV=DTADEV'
      'OBSF_1=OBSF_1'
      'OBSF_2=OBSF_2'
      'OBSF_3=OBSF_3'
      'OBSF_4=OBSF_4'
      'OBSF_5=OBSF_5'
      'REFERE=REFERE'
      'CODFAB=CODFAB'
      'UNITAR=UNITAR'
      'PRECUS=PRECUS'
      'INCORI=INCORI'
      'TEMLOTE=TEMLOTE'
      'LOTEPRINCIPALVENDA=LOTEPRINCIPALVENDA'
      'SALREP=SALREP'
      'SALPRE=SALPRE'
      'DOCUMENTO=DOCUMENTO'
      'QTDCRE_1=QTDCRE_1'
      'UNICRD=UNICRD'
      'ORIGEM=ORIGEM'
      'REPOST=REPOST'
      'CODFAV=CODFAV'
      'INCGER=INCGER'
      'INCGAG=INCGAG'
      'NUMDOC=NUMDOC'
      'ESPDOC=ESPDOC'
      'LOCFIS=LOCFIS'
      'AGG_QTDDEV_1=AGG_QTDDEV_1'
      'AGG_QTDPRE_1=AGG_QTDPRE_1'
      'AGG_QTDCRE_1=AGG_QTDCRE_1')
    DataSource = dtsProdutos
    BCDToCurrency = False
    Left = 648
    Top = 120
  end
  object frxDocEnvCliJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40114.449667604200000000
    ReportOptions.LastChange = 40148.697066215300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbDetalheOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '   If <frxDBGarantiaEC."OBSF_1"> = '#39#39' Then'
      '        Child1.Visible := False'
      '   Else Child1.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_2"> = '#39#39' Then'
      '        Child2.Visible := False'
      '   Else Child2.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_3"> = '#39#39' Then'
      '        Child3.Visible := False'
      '   Else Child3.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_4"> = '#39#39' Then'
      '        Child4.Visible := False'
      '   Else Child4.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_5"> = '#39#39' Then'
      '        Child5.Visible := False'
      '   Else Child5.Visible := True;'
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 680
    Top = 120
    Datasets = <
      item
        DataSet = frxDBGarantiaEC
        DataSetName = 'frxDBGarantiaEC'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 47.244094490000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 151.181200000000000000
          Width = 415.748300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 173.858380000000000000
          Top = 15.118120000000000000
          Width = 370.393940000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENVIO PARA O CLIENTE')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 548.031850000000000000
          Top = 15.118120000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nro.: [NUMRET]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 128.504020000000000000
        Width = 718.110700000000000000
        object Shape1: TfrxShapeView
          Top = 29.574829999999990000
          Width = 718.110236220000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDoc: TfrxMemoView
          Left = 614.173618900000000000
          Top = 30.574829999999990000
          Width = 91.842519690000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Preju'#237'zo')
        end
        object rllTitHis: TfrxMemoView
          Left = 84.963760000000000000
          Top = 30.574829999999990000
          Width = 311.433073310000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object rllTitDta: TfrxMemoView
          Left = 5.669288900000000000
          Top = 30.708688270000010000
          Width = 69.165339690000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'Item')
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559059999999988000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Devolu'#231#227'o:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 139.842610000000000000
          Top = 7.559059999999988000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTADEV]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 445.984540000000000000
          Top = 7.559059999999988000
          Width = 268.346630000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total de Itens Enviados: [TOTQTD]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 517.795610000000000000
          Top = 30.236240000000010000
          Width = 91.842519690000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Devolver')
        end
        object Memo14: TfrxMemoView
          Left = 419.527830000000000000
          Top = 30.236240000000010000
          Width = 91.842519690000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Requisitado')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 476.220780000000000000
        Width = 718.110700000000000000
        object Memo10: TfrxMemoView
          Top = 64.252010000000150000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMFRM]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 7.559060000000000000
          Top = 34.795299999999880000
          Width = 313.700990000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Operador: [NOMOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 396.850650000000000000
          Top = 34.795300000000000000
          Width = 313.700990000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Cliente: [NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object rllData: TfrxMemoView
          Left = 604.724800000000000000
          Top = 64.252010000000150000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] - [Time]')
          ParentFont = False
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 204.094620000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'rlbDetalheOnAfterPrint'
        Child = frxDocEnvCliJ.Child1
        DataSet = frxDBGarantiaEC
        DataSetName = 'frxDBGarantiaEC'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 5.559060000000000000
          Top = 1.779529999999994000
          Width = 69.165354330000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBGarantiaEC."CODITE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 83.039428660000000000
          Top = 1.779529999999994000
          Width = 326.173394330000000000
          Height = 15.118120000000000000
          DataField = 'DESITE'
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."DESITE"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 615.953158660000000000
          Top = 1.779529999999994000
          Width = 91.842534330000000000
          Height = 15.118120000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDPRE_1"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 517.795610000000000000
          Top = 1.779529999999994000
          Width = 91.842534330000000000
          Height = 15.118120000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDDEV_1"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 419.527830000000000000
          Top = 1.779529999999994000
          Width = 91.842534330000000000
          Height = 15.118120000000000000
          DataField = 'QTDREQ'
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDREQ"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        Child = frxDocEnvCliJ.Child2
        object Memo15: TfrxMemoView
          Left = 83.149660000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Obs1:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 128.504020000000000000
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_1"]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        Child = frxDocEnvCliJ.Child3
        object Memo16: TfrxMemoView
          Left = 83.149660000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Obs2:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 128.504020000000000000
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_2"]')
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        Child = frxDocEnvCliJ.Child4
        object Memo17: TfrxMemoView
          Left = 83.149660000000000000
          Top = 0.000000000000056843
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Obs3:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 128.504020000000000000
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_3"]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 362.834880000000000000
        Width = 718.110700000000000000
        Child = frxDocEnvCliJ.Child5
        object Memo18: TfrxMemoView
          Left = 83.149660000000000000
          Top = 0.000000000000056843
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Obs4:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 128.504020000000000000
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_4"]')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 400.630180000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          Left = 83.149660000000000000
          Top = 0.000000000000056843
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Obs5:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 128.504020000000000000
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_5"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDocEnvCliM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40114.742711944400000000
    ReportOptions.LastChange = 40148.713597419000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '   If <frxDBGarantiaEC."OBSF_1"> = '#39#39' Then'
      '        Child1.Visible := False'
      '   Else Child1.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_2"> = '#39#39' Then'
      '        Child2.Visible := False'
      '   Else Child2.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_3"> = '#39#39' Then'
      '        Child3.Visible := False'
      '   Else Child3.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_4"> = '#39#39' Then'
      '        Child4.Visible := False'
      '   Else Child4.Visible := True;'
      ''
      '   If <frxDBGarantiaEC."OBSF_5"> = '#39#39' Then'
      '        Child5.Visible := False'
      '   Else Child5.Visible := True;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 712
    Top = 120
    Datasets = <
      item
        DataSet = frxDBGarantiaEC
        DataSetName = 'frxDBGarantiaEC'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 208.279865485920200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      LeftMargin = 5.079996719168790000
      RightMargin = 5.079996719168790000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE ENVIO PARA O CLIENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nro.: [NUMRET]')
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 102.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data de Devolucao:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[DTADEV]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Itens Enviados: [TOTQTD]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.ShadowColor = clNone
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            ' Item         ')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 34.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'Descricao')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Prejuizo')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Devolver')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Requisitado')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 748.800000000000000000
        OnAfterPrint = 'MasterData1OnAfterPrint'
        Child = frxDocEnvCliM.Child1
        DataSet = frxDBGarantiaEC
        DataSetName = 'frxDBGarantiaEC'
        RowCount = 0
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."DESITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDPRE_1"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDDEV_1"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDREQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 408.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.ShadowColor = clNone
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMFRM]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] - [Time]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Operador: [NOMOPE]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Cliente: [NOMCLI]')
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 748.800000000000000000
        Child = frxDocEnvCliM.Child2
        object DMPMemo21: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_1"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Obs1:')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 748.800000000000000000
        Child = frxDocEnvCliM.Child3
        object DMPMemo23: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Obs2:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_2"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 748.800000000000000000
        Child = frxDocEnvCliM.Child4
        object DMPMemo24: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Obs3:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_3"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 748.800000000000000000
        Child = frxDocEnvCliM.Child5
        object DMPMemo25: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Obs4:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_4"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 748.800000000000000000
        object DMPMemo26: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Obs5:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaEC."OBSF_5"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 616
    Top = 120
  end
  object frxDocSepItem_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43934.747672175900000000
    ReportOptions.LastChange = 45581.478397939810000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 744
    Top = 120
    Datasets = <
      item
        DataSet = frxDBGarantiaEC
        DataSetName = 'frxDBGarantiaEC'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 74.040731690000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 164.948253100000000000
          Top = 35.244094490000000000
          Width = 444.619422570000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baCenter
          Left = 112.889429560000000000
          Top = 18.133890000000000000
          Width = 492.331840880000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SEPARACAO DE GARANTIA')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = 170.078972045000000000
          Top = 1.118120000000000000
          Width = 377.952755910000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMFAN]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 548.031727960000000000
          Top = 1.118120000000000000
          Width = 30.379364050000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo5: TfrxMemoView
          Left = 112.889429560000000000
          Top = 35.244094490000000000
          Width = 51.023622050000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 671.895424840000000000
          Top = 1.118120000000000000
          Width = 45.524155100000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[HORENT]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo16: TfrxMemoView
          Left = 580.392156860000000000
          Top = 1.118120000000000000
          Width = 56.862745100000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DTAENT]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo17: TfrxMemoView
          Left = 638.562091500000000000
          Top = 1.118120000000000000
          Width = 30.406035100000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo21: TfrxMemoView
          Left = 164.948253100000000000
          Top = 52.997774840000000000
          Width = 444.619422570000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FAN_CLI]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 112.889429560000000000
          Top = 52.997774840000000000
          Width = 51.023622050000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fantasia:')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = cl3DLight
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 17.110295010000000000
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 1.338590000000000000
          Width = 48.394854970000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 337.576582220000000000
          Top = 0.858216250000000000
          Width = 380.598425200000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 218.111723590000000000
          Top = 1.338590000000000000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 166.748051830000000000
          Top = 1.338590000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 51.627450980000000000
          Top = 1.338590000000000000
          Width = 113.385826770000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 254.274509800000000000
          Top = 1.338590000000000000
          Width = 80.420998760000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCALIZA'#199#195'O')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 16.632868110000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        DataSet = frxDBGarantiaEC
        DataSetName = 'frxDBGarantiaEC'
        PrintChildIfInvisible = True
        PrintIfDetailEmpty = True
        RowCount = 0
        object Memo10: TfrxMemoView
          Align = baLeft
          Width = 48.394854970000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."CODITE"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 337.576582220000000000
          Width = 380.598425200000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."DESITE"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 166.748051830000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaEC."QTDDEV_1"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 218.111723590000000000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."UNIDAD"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 51.627450980000000000
          Width = 113.385826770000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxDBGarantiaEC."REFERE">)]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 254.274509800000000000
          Width = 80.420998760000000000
          Height = 15.118110240000000000
          DataField = 'LOCFIS'
          DataSet = frxDBGarantiaEC
          DataSetName = 'frxDBGarantiaEC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaEC."LOCFIS"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 4.234487780000000000
        Top = 234.330860000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 2.415742090000000000
        Top = 298.582870000000000000
        Width = 718.110700000000000000
      end
    end
  end
end
