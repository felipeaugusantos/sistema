inherited frmFatLibReservaEstoqueOS: TfrmFatLibReservaEstoqueOS
  Width = 1050
  Height = 700
  Caption = 'Libera'#231#227'o de Reserva de Estoque Itens de Pedido de Venda - OS'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1050
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 655
    Width = 1044
    inherited FlwBotoes: TFlowPanel
      Width = 1040
      ExplicitWidth = 765
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 1044
    ExplicitTop = 460
    inherited pnlNomeForm: TPanel
      Left = 873
    end
    inherited pnlInfo: TPanel
      Width = 873
    end
  end
  inherited pgcDados: TPageControl
    Left = 683
    Top = 72
    Width = 78
    Height = 65
    Align = alNone
    ExplicitLeft = 683
    ExplicitTop = 72
    ExplicitWidth = 78
    ExplicitHeight = 65
    inherited tbsGeral: TTabSheet
      ExplicitLeft = -12
      ExplicitTop = -12
      ExplicitWidth = 70
      ExplicitHeight = 33
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1044
    Height = 655
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 8
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1044
      Height = 113
      Align = alTop
      TabOrder = 0
      object lblEmpresa: TLabel
        Left = 15
        Top = 7
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label1: TLabel
        Left = 25
        Top = 31
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label2: TLabel
        Left = 25
        Top = 55
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pedido:'
      end
      object Label3: TLabel
        Left = 276
        Top = 55
        Width = 103
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Inclus'#227'o Pedido:'
      end
      object Label4: TLabel
        Left = 467
        Top = 55
        Width = 6
        Height = 14
        Caption = 'a'
      end
      object Label5: TLabel
        Left = 42
        Top = 80
        Width = 18
        Height = 14
        Alignment = taRightJustify
        Caption = 'OS:'
      end
      object Label6: TLabel
        Left = 128
        Top = 80
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Emp. OS:'
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 62
        Top = 4
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
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
        TabOrder = 0
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtDesEmp: TEditFocus
        Left = 101
        Top = 4
        Width = 278
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
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
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 62
        Top = 28
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttInteiro
      end
      object edtNomCli: TEditFocus
        Left = 148
        Top = 28
        Width = 411
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 62
        Top = 52
        Width = 110
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 381
        Top = 52
        Width = 78
        Height = 22
        AutoSize = False
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 481
        Top = 52
        Width = 78
        Height = 22
        AutoSize = False
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 6
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtNumOS: TEditFocus
        Tag = 99
        Left = 62
        Top = 76
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtCodEOS: TEditFocus
        Tag = 99
        Left = 174
        Top = 76
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
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
        TabOrder = 8
        OnKeyPress = edtCodEOSKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtDesEOS: TEditFocus
        Left = 213
        Top = 76
        Width = 213
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnFiltrar: TBitBtnLocked
        Left = 485
        Top = 77
        Width = 74
        Height = 22
        Caption = 'Confirmar'
        TabOrder = 10
        OnClick = btnFiltrarClick
      end
    end
    object pnlButtons: TPanel
      Left = 0
      Top = 629
      Width = 1044
      Height = 26
      Align = alBottom
      Anchors = []
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      object FlwPnlButtons: TFlowPanel
        Left = 0
        Top = 0
        Width = 945
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object btnConfirmar: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 136
          Height = 22
          Caption = '[F10] Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
        end
        object btnSelecionarTodos: TBitBtnLocked
          Left = 136
          Top = 0
          Width = 136
          Height = 22
          Caption = '[F5] Selecionar Todos'
          TabOrder = 1
          OnClick = btnSelecionarTodosClick
        end
        object btnDesmarcarTodos: TBitBtnLocked
          Left = 272
          Top = 0
          Width = 136
          Height = 22
          Caption = '[F6] Desmarcar Todos'
          TabOrder = 2
          OnClick = btnDesmarcarTodosClick
        end
        object btnSelecionarItensPD: TBitBtnLocked
          Left = 408
          Top = 0
          Width = 225
          Height = 22
          Caption = '[F7] Selecionar todos os itens do pedido'
          TabOrder = 3
          OnClick = btnSelecionarItensPDClick
        end
        object btnExpandirTodos: TBitBtnLocked
          Left = 633
          Top = 0
          Width = 136
          Height = 22
          Caption = '[F8] Expandir Todos'
          TabOrder = 4
          OnClick = btnExpandirTodosClick
        end
      end
      object btnFechar: TBitBtnLocked
        AlignWithMargins = True
        Left = 959
        Top = 1
        Width = 82
        Height = 22
        Margins.Left = 14
        Margins.Top = 1
        Align = alRight
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        TabOrder = 1
        OnClick = btnSairClick
      end
    end
    object pnlBottom: TPanel
      Left = 0
      Top = 611
      Width = 1044
      Height = 18
      Align = alBottom
      Caption = '[ENTER] ou Duplo Clique -  Marca / Desmarca Item '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object cxGrid: TcxGridCitel
      Left = 0
      Top = 113
      Width = 1044
      Height = 498
      Align = alClient
      TabOrder = 3
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridTBV1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsPedidos
        DataController.DetailKeyFieldNames = 'AUTINC'
        DataController.Filter.Options = [fcoCaseInsensitive]
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
        OptionsView.GroupByBox = False
        Styles.ContentEven = cxStyle1
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridTBV1DTAENT: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DTAENT'
          Width = 80
        end
        object cxGridTBV1NUMPED: TcxGridDBColumn
          Caption = 'Pedido'
          DataBinding.FieldName = 'NUMPED'
          Width = 200
        end
        object cxGridTBV1CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Width = 60
        end
        object cxGridTBV1NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'NOMCLI'
          Width = 400
        end
        object cxGridTBV1NUMOSE: TcxGridDBColumn
          Caption = 'OS'
          DataBinding.FieldName = 'NUMOSE'
          Width = 80
        end
        object cxGridTBV1STATUS: TcxGridDBColumn
          Caption = 'Status OS'
          DataBinding.FieldName = 'STATUS'
          Width = 160
        end
      end
      object cxGridTBV2: TcxGridDBTableViewCitel
        OnKeyDown = cxGridTBV2KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGridTBV2CellDblClick
        OnCustomDrawCell = cxGridTBV2CustomDrawCell
        OnEditKeyPress = cxGridTBV2EditKeyPress
        DataController.DataSource = dtsItens
        DataController.DetailKeyFieldNames = 'SEQEQU'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'SEQFDO'
        DataController.MasterKeyFieldNames = 'AUTINC'
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
        Styles.ContentEven = cxStyle1
        Zebra = True
        Destaque = False
        CorZebra = cl3DLight
        object cxGridTBV2CODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 60
        end
        object cxGridTBV2DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 250
        end
        object cxGridTBV2QTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          Options.Editing = False
          Width = 70
        end
        object cxGridTBV2UNIDAD: TcxGridDBColumn
          Caption = 'UN'
          DataBinding.FieldName = 'UNIDAD'
          Options.Editing = False
          Width = 30
        end
        object cxGridTBV2DESMAR: TcxGridDBColumn
          Caption = 'Marca'
          DataBinding.FieldName = 'DESMAR'
          Options.Editing = False
          Width = 200
        end
        object cxGridTBV2REFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Width = 80
        end
        object cxGridTBV2CODFAB: TcxGridDBColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'CODFAB'
          Options.Editing = False
          Width = 80
        end
        object cxGridTBV2NUMLOT: TcxGridDBColumn
          Caption = 'Armaz'#233'm'
          DataBinding.FieldName = 'NUMLOT'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEditValueChanged = cxGridTBV2NUMLOTPropertiesEditValueChanged
          Width = 80
        end
        object cxGridTBV2REQUIS: TcxGridDBColumn
          Caption = 'Requisi'#231#227'o'
          DataBinding.FieldName = 'NUMREQ'
          Options.Editing = False
          Width = 80
        end
        object cxGridTBV2PEDCOM: TcxGridDBColumn
          Caption = 'Ped. Compra'
          DataBinding.FieldName = 'PEDCOM'
          Options.Editing = False
          Width = 80
        end
        object cxGridTBV2ENTMER: TcxGridDBColumn
          Caption = 'Entrada Mercadoria'
          DataBinding.FieldName = 'ENTMER'
          Options.Editing = False
          Width = 100
        end
        object cxGridTBV2QTDENT: TcxGridDBColumn
          Caption = 'Qtde. Ent.'
          DataBinding.FieldName = 'QTDENT'
          Options.Editing = False
          Width = 60
        end
        object cxGridTBV2MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'MARDES'
          Visible = False
          Options.Editing = False
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridTBV1
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridTBV2
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 312
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 184
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 368
    Top = 184
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = cl3DLight
    end
  end
  object dtsItens: TDataSource
    Left = 312
    Top = 240
  end
  object dtsPedidos: TDataSource
    Left = 256
    Top = 240
  end
end
