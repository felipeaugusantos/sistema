inherited frmAltPrecoGlobal: TfrmAltPrecoGlobal
  Left = 214
  Top = 165
  Width = 1307
  Height = 716
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o Global de Pre'#231'os'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1307
  ExplicitHeight = 716
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Top = 462
    Width = 1291
    Height = 164
    TabOrder = 2
    Visible = False
    ExplicitTop = 462
    ExplicitWidth = 1291
    ExplicitHeight = 164
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1283
      ExplicitHeight = 132
    end
  end
  object pnlDadosAlt: TPanel [1]
    Left = 0
    Top = 462
    Width = 1291
    Height = 164
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object cxgTiposAlt: TcxGrid
      Left = 0
      Top = 0
      Width = 1041
      Height = 164
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvTiposAlt: TcxGridDBTableView
        OnKeyPress = cxvTiposAltKeyPress
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyPress = cxvTiposAltEditKeyPress
        DataController.DataSource = dtsAltGlo
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Filter.OnChanged = cxvTiposAltDataControllerFilterChanged
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.CellAutoHeight = True
        OptionsView.GroupByBox = False
        object cxvTiposAltALTERA: TcxGridDBColumn
          Caption = 'Alterar'
          DataBinding.FieldName = 'ITE_ALTERA'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          Properties.OnChange = cxvTiposAltALTERAPropertiesChange
          HeaderAlignmentHorz = taCenter
          Width = 54
        end
        object cxvTiposAltDESCAM: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Tipo de Altera'#231#227'o'
          DataBinding.FieldName = 'ITE_DESCAM'
          OnGetDisplayText = cxvTiposAltDESCAMGetDisplayText
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Styles.Content = cxsCorAzul
          Styles.OnGetContentStyle = cxvTiposAltDESCAMStylesGetContentStyle
          Width = 327
        end
        object cxvTiposAltVALCAM: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'ITE_VALCAM'
          OnGetDisplayText = cxvTiposAltVALCAMGetDisplayText
          OnGetProperties = cxvTiposAltVALCAMGetProperties
          HeaderAlignmentHorz = taCenter
          Styles.OnGetContentStyle = cxvTiposAltVALCAMStylesGetContentStyle
          Width = 439
        end
        object cxvTiposAltPROPER: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_PROPER'
          Visible = False
        end
        object cxvTiposAltNOMCAM: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_NOMCAM'
          Visible = False
        end
        object cxvTiposAltDESCRI: TcxGridDBColumn
          DataBinding.FieldName = 'ITE_DESCRI'
          Visible = False
        end
      end
      object cxgTiposAltLevel1: TcxGridLevel
        GridView = cxvTiposAlt
      end
    end
    object Panel2: TPanel
      Left = 1041
      Top = 0
      Width = 250
      Height = 164
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 25
        Top = 14
        Width = 208
        Height = 92
        TabOrder = 0
        object shpConsulta: TShape
          Left = 13
          Top = 10
          Width = 12
          Height = 14
          Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
          Brush.Color = 11206613
          ParentShowHint = False
          ShowHint = True
        end
        object Label15: TLabel
          Left = 31
          Top = 11
          Width = 158
          Height = 14
          Caption = 'Utilize [ ? ]  ou [ / ] para consultar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object shpLista: TShape
          Left = 13
          Top = 30
          Width = 12
          Height = 14
          Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
          Brush.Color = 10801663
          ParentShowHint = False
          ShowHint = True
        end
        object Label16: TLabel
          Left = 31
          Top = 31
          Width = 108
          Height = 14
          Caption = 'Possui lista de valores'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Shape3: TShape
          Left = 13
          Top = 64
          Width = 12
          Height = 14
          Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
          Brush.Color = clRed
          ParentShowHint = False
          ShowHint = True
        end
        object Label17: TLabel
          Left = 31
          Top = 65
          Width = 160
          Height = 14
          Caption = 'Informa'#231#245'es que ser'#227'o alteradas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
      object chkManterUltAlt: TCheckBox
        Left = 32
        Top = 112
        Width = 145
        Height = 17
        Caption = 'Manter '#250'ltimas altera'#231#245'es'
        TabOrder = 1
      end
    end
  end
  object pgbProgresso: TProgressBar [2]
    Left = 0
    Top = 650
    Width = 1291
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited pnlBotoes: TPanel [3]
    Top = 626
    Width = 1291
    TabOrder = 4
    ExplicitTop = 626
    ExplicitWidth = 1291
    DesignSize = (
      1291
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1287
      ExplicitWidth = 1287
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel [4]
    Top = 661
    Width = 1291
    TabOrder = 3
    ExplicitTop = 661
    ExplicitWidth = 1291
    inherited pnlNomeForm: TPanel
      Left = 1144
      Width = 147
      ExplicitLeft = 1144
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 1144
      ExplicitWidth = 1144
      object shpMultSel: TShape
        Left = 1126
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas desta tela possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 350
        ExplicitTop = -1
        ExplicitHeight = 14
      end
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 1291
    Height = 462
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object pnlFiltro1: TPanel
      Left = 2
      Top = 2
      Width = 1287
      Height = 159
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 31
        Top = 5
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label2: TLabel
        Left = 47
        Top = 27
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel
        Left = 327
        Top = 27
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label4: TLabel
        Left = 372
        Top = 93
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label6: TLabel
        Left = 66
        Top = 50
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label167: TLabel
        Left = 11
        Top = 70
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo de Produto:'
      end
      object Label14: TLabel
        Left = 327
        Top = 49
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo de Compra:'
      end
      object Label50: TLabel
        Left = 701
        Top = 65
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Incide PIS?:'
      end
      object ColorLabel2: TColorLabel
        Left = 810
        Top = 65
        Width = 99
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos '
        CorDestaque = clRed
      end
      object Label31: TLabel
        Left = 155
        Top = 139
        Width = 121
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#237'vel de Giro de Estoque:'
      end
      object lblMarIde: TLabel
        Left = 533
        Top = 96
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Margem Ideal:'
      end
      object lblTabPrc: TLabel
        Left = 35
        Top = 138
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tabela Pre'#231'o:'
      end
      object Label9: TLabel
        Left = 29
        Top = 94
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento:'
      end
      object lblCodGpr: TLabel
        Left = 336
        Top = 72
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Grupo de Pre'#231'o:'
      end
      object Label20: TLabel
        Left = 37
        Top = 115
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Composi'#231#227'o:'
      end
      object lblGiroEstoqueFornecedor: TLabel
        Left = 319
        Top = 139
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nvl. Giro de Fornec:'
      end
      object lblLocFis: TLabel
        Left = 353
        Top = 115
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Localiza'#231#227'o:'
      end
      object lblCSTORI: TLabel
        Left = 563
        Top = 7
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'CST Origem:'
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 101
        Top = 2
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = ''
        OnExit = mskLinGruExit
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 149
        Top = 2
        Width = 408
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Tag = 99
        Left = 101
        Top = 24
        Width = 221
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        OnKeyPress = edtDesIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRefere: TEditFocus
        Tag = 99
        Left = 385
        Top = 24
        Width = 307
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        OnKeyPress = edtRefereKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodUni: TEditFocus
        Tag = 99
        Left = 417
        Top = 90
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 18
        OnExit = edtCodUniExit
        OnKeyPress = edtCodUniKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 101
        Top = 46
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 7
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 149
        Top = 46
        Width = 172
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgTipAltFor: TRadioGroup
        Left = 698
        Top = 5
        Width = 249
        Height = 56
        Caption = 'Tipo de Altera'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Alterar Pre'#231'o de Venda'
          'Alterar Margem de Lucro')
        TabOrder = 4
        Visible = False
        OnClick = rdgTipAltForClick
      end
      object rdgTipAlt: TRadioGroup
        Left = 698
        Top = 0
        Width = 249
        Height = 61
        Caption = 'Tipo de Altera'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
          'Pre'#231'o de Custo, Alterando Margem de Lucro'
          'Pre'#231'o de Venda, Alterando Margem de Lucro')
        TabOrder = 3
        OnClick = rdgTipAltClick
      end
      object edtPrdGru: TEditFocus
        Tag = 99
        Left = 101
        Top = 68
        Width = 48
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 11
        OnExit = edtPrdGruExit
        OnKeyPress = edtPrdGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesPrdPro: TEditFocus
        Left = 149
        Top = 68
        Width = 172
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtGruCmp: TEditFocus
        Tag = 99
        Left = 417
        Top = 46
        Width = 69
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
        TabOrder = 9
        OnExit = edtGruCmpExit
        OnKeyPress = edtGruCmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesGruCmp: TEditFocus
        Left = 486
        Top = 46
        Width = 206
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtIncPis: TEditFocus
        Tag = 99
        Left = 759
        Top = 61
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 15
        Text = 'T'
        OnKeyPress = edtIncPisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfanumerico
      end
      object rdgEstMin: TRadioGroup
        Left = 697
        Top = 83
        Width = 250
        Height = 33
        Caption = 'Op'#231#227'o para Estoque M'#237'nimo'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Gerado'
          'Digitado'
          'Todos')
        TabOrder = 20
      end
      object cmbGiroEstoque: TComboBoxFocus
        Tag = 99
        Left = 276
        Top = 135
        Width = 39
        Height = 22
        Style = csDropDownList
        DropDownCount = 4
        ItemIndex = 0
        MaxLength = 1
        TabOrder = 22
        Items.Strings = (
          ''
          'A'
          'B'
          'C')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbxMarIde: TComboBoxFocus
        Left = 605
        Top = 90
        Width = 87
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 19
        Text = 'Nenhum'
        OnChange = cbxMarIdeChange
        Items.Strings = (
          'Nenhum'
          'Maior ou Igual'
          'Menor ou Igual'
          'Maior'
          'Menor'
          'Igual')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbxTabPrc: TComboBoxFocus
        Left = 101
        Top = 134
        Width = 48
        Height = 22
        Style = csDropDownList
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 101
        Top = 90
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnExit = edtCodDepExit
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesDep: TEditFocus
        Left = 149
        Top = 90
        Width = 172
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 17
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkPenRec: TCheckBox
        Left = 462
        Top = 134
        Width = 516
        Height = 22
        Caption = 
          'Exibir somente produtos com pend'#234'ncia de rec'#225'lculo de pre'#231'o devi' +
          'do '#224' altera'#231#227'o de abrevi'#231#227'o fiscal'
        TabOrder = 23
        WordWrap = True
      end
      object chkExiSal: TCheckBox
        Left = 975
        Top = 136
        Width = 258
        Height = 17
        Caption = 'Exibir Saldo na Tela de Confer'#234'ncia de Altera'#231#227'o?'
        TabOrder = 24
      end
      object edtCodGpr: TEditFocus
        Tag = 99
        Left = 417
        Top = 68
        Width = 69
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
        MaxLength = 6
        ParentFont = False
        TabOrder = 13
        OnExit = edtCodGprExit
        OnKeyPress = edtCodGprKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtDesGpr: TEditFocus
        Left = 486
        Top = 68
        Width = 206
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 14
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCom: TEditFocus
        Tag = 99
        Left = 101
        Top = 111
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        OnExit = edtCodComExit
        OnKeyPress = edtCodComKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesComp: TEditFocus
        Left = 149
        Top = 111
        Width = 172
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 26
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cmbGiroEstoqueFornecedor: TComboBoxFocus
        Tag = 99
        Left = 417
        Top = 135
        Width = 39
        Height = 22
        Style = csDropDownList
        DropDownCount = 4
        ItemIndex = 0
        MaxLength = 1
        TabOrder = 28
        Items.Strings = (
          ''
          'A'
          'B'
          'C')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtLocFis: TEditFocus
        Tag = 99
        Left = 417
        Top = 113
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 27
        OnKeyPress = edtLocFisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesLocFis: TEditFocus
        Left = 487
        Top = 113
        Width = 206
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 29
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cmbCSTORI: TComboBoxFocus
        Tag = 99
        Left = 629
        Top = 2
        Width = 63
        Height = 22
        Style = csDropDownList
        TabOrder = 1
        Items.Strings = (
          ''
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object pnlFiltro2: TPanel
      Left = 2
      Top = 206
      Width = 1287
      Height = 154
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Label8: TLabel
        Left = 40
        Top = 4
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label5: TLabel
        Left = 33
        Top = 26
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Fiscal:'
      end
      object Label7: TLabel
        Left = 3
        Top = 115
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Classifica'#231#227'o de IPI:'
      end
      object ColorLabel1: TColorLabel
        Left = 442
        Top = 115
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object Label13: TLabel
        Left = 369
        Top = 115
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo:'
      end
      object lbl50: TLabel
        Left = 233
        Top = 115
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo EX IPI:'
      end
      object Label18: TLabel
        Left = 47
        Top = 48
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Pis:'
      end
      object Label19: TLabel
        Left = 30
        Top = 70
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Cofins:'
      end
      object lblCest: TLabel
        Left = 3
        Top = 137
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Classifica'#231#227'o CEST:'
      end
      object Label22: TLabel
        Left = 547
        Top = 115
        Width = 98
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo para compra?:'
      end
      object ColorLabel3: TColorLabel
        Left = 691
        Top = 115
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object lblEstUFIcms: TLabel
        Left = 949
        Top = 91
        Width = 135
        Height = 14
        Caption = 'Estado da abrevia'#231#227'o ICMS:'
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 101
        Top = 0
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnExit = edtCodForExit
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 170
        Top = 0
        Width = 515
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object chkArrMai: TCheckBox
        Left = 698
        Top = 5
        Width = 159
        Height = 17
        Caption = 'Arredondar Casas Decimais'
        TabOrder = 2
        OnClick = chkArrMaiClick
      end
      object edtDecUni: TEditFocus
        Tag = 99
        Left = 865
        Top = 4
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 3
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object edtCodAbr: TEditFocus
        Tag = 99
        Left = 101
        Top = 22
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 4
        OnExit = edtCodAbrExit
        OnKeyPress = edtCodAbrKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesAbr: TEditFocus
        Left = 170
        Top = 22
        Width = 515
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtClaIPI: TEditFocus
        Tag = 99
        Left = 101
        Top = 111
        Width = 126
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 8
        OnExit = edtClaIPIExit
        OnKeyPress = edtClaIPIKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtStatus: TEditFocus
        Tag = 99
        Left = 397
        Top = 112
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 10
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtExcIpi: TEditFocus
        Tag = 99
        Left = 304
        Top = 112
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 9
        OnExit = edtExcIpiExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtAbfPis: TEditFocus
        Tag = 99
        Left = 101
        Top = 43
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 5
        OnExit = edtAbfPisExit
        OnKeyPress = edtAbfPisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesPis: TEditFocus
        Left = 170
        Top = 44
        Width = 515
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 14
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtAbfCof: TEditFocus
        Tag = 99
        Left = 101
        Top = 66
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 6
        OnExit = edtAbfCofExit
        OnKeyPress = edtAbfCofKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCof: TEditFocus
        Left = 170
        Top = 66
        Width = 515
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 15
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object GroupBox2: TGroupBox
        Left = 698
        Top = 28
        Width = 313
        Height = 53
        Caption = ' Desconsiderar Itens com Pre'#231'os Alterados: '
        TabOrder = 16
        object Label21: TLabel
          Left = 117
          Top = 26
          Width = 20
          Height = 14
          Alignment = taRightJustify
          Caption = 'At'#233':'
        end
        object MskDataFim: TMaskEditFocus
          Tag = 99
          Left = 145
          Top = 23
          Width = 71
          Height = 22
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object MskDataIni: TMaskEditFocus
          Tag = 99
          Left = 35
          Top = 23
          Width = 72
          Height = 22
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
      object edtCest: TEditFocus
        Tag = 99
        Left = 101
        Top = 132
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        NumbersOnly = True
        TabOrder = 12
        OnKeyPress = edtCestKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCestDesc: TEditFocus
        Left = 170
        Top = 132
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 17
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbxAtoDF: TCheckBox
        Left = 546
        Top = 135
        Width = 355
        Height = 17
        Caption = 
          'Pertence '#224' lista do Ato Declarat'#243'rio do Decreto 34063/12 do "DF"' +
          '?'
        TabOrder = 13
      end
      object edtStatusCompra: TEditFocus
        Tag = 99
        Left = 646
        Top = 111
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 11
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object pnlExpressao: TPanel
        AlignWithMargins = True
        Left = 6
        Top = 88
        Width = 749
        Height = 22
        BevelOuter = bvNone
        TabOrder = 18
      end
      object btnAddExpr: TBitBtnLocked
        Left = 762
        Top = 88
        Width = 28
        Height = 22
        Caption = '+'
        TabOrder = 19
        OnClick = btnAddExprClick
      end
      object btnVisualizarExpr: TBitBtnLocked
        Left = 791
        Top = 88
        Width = 65
        Height = 22
        Caption = 'Expandir'
        TabOrder = 20
        OnClick = btnVisualizarExprClick
      end
      object edtEstadoAbfICMS: TEditFocus
        Tag = 99
        Left = 1086
        Top = 87
        Width = 54
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlTabPre: TPanel
      Left = 2
      Top = 184
      Width = 1287
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label11: TLabel
        Left = 19
        Top = 6
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tabela de Pre'#231'o:'
      end
      object edtTabPre: TEditFocus
        Tag = 99
        Left = 101
        Top = 0
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        OnKeyPress = edtTabPreKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtNomTab: TEditFocus
        Left = 170
        Top = 0
        Width = 515
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    object pnlCadMon: TPanel
      Left = 2
      Top = 161
      Width = 1287
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lbl1: TLabel
        Left = 45
        Top = 4
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Montadora:'
      end
      object edtCodMon: TEditFocus
        Tag = 99
        Left = 101
        Top = 1
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodMonExit
        OnKeyPress = edtCodMonKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesMon: TEditFocus
        Left = 170
        Top = 1
        Width = 515
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    object pnlNotEnt: TPanel
      Left = 2
      Top = 360
      Width = 551
      Height = 100
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object Label12: TLabel
        Left = 19
        Top = 9
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nota de Entrada:'
      end
      object grpDadosNE: TGroupBox
        Left = 101
        Top = 1
        Width = 439
        Height = 97
        TabOrder = 0
        object lblDocumento: TLabel
          Left = 6
          Top = 23
          Width = 54
          Height = 14
          Caption = 'Documento'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEspecie: TLabel
          Left = 108
          Top = 23
          Width = 38
          Height = 14
          Caption = 'Esp'#233'cie'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblSerie: TLabel
          Left = 148
          Top = 23
          Width = 25
          Height = 14
          Caption = 'S'#233'rie'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEmpresa: TLabel
          Left = 179
          Top = 23
          Width = 42
          Height = 14
          Caption = 'Empresa'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblForNot: TLabel
          Left = 7
          Top = 60
          Width = 56
          Height = 14
          Caption = 'Fornecedor'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDtaFin: TLabel
          Left = 373
          Top = 60
          Width = 47
          Height = 14
          Caption = 'Data Final'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDtaIni: TLabel
          Left = 310
          Top = 60
          Width = 51
          Height = 14
          Caption = 'Data Inicial'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDocumento: TEditFocus
          Tag = 99
          Left = 6
          Top = 37
          Width = 100
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 12
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtEspecie: TEditFocus
          Left = 108
          Top = 37
          Width = 38
          Height = 21
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 2
          Text = 'NF'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtSerie: TEditFocus
          Left = 148
          Top = 37
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmpresa: TEditFocus
          Tag = 99
          Left = 179
          Top = 37
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 4
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
          Top = 37
          Width = 225
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkNotEnt: TCheckBox
          Tag = 99
          Left = 5
          Top = 8
          Width = 289
          Height = 17
          Caption = 'Informar nota de entrada para selecionar os produtos?'
          TabOrder = 0
          OnClick = chkNotEntClick
        end
        object edtForNot: TEditFocus
          Tag = 99
          Left = 6
          Top = 73
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnExit = edtForNotExit
          OnKeyPress = edtForNotKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesForNot: TEditFocus
          Left = 66
          Top = 73
          Width = 242
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskDtaEntFin: TMaskEditFocus
          Tag = 99
          Left = 373
          Top = 73
          Width = 61
          Height = 22
          Enabled = False
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 9
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaEntIni: TMaskEditFocus
          Tag = 99
          Left = 310
          Top = 73
          Width = 61
          Height = 22
          Enabled = False
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 8
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
    end
    object pnlTipAltNota: TPanel
      Left = 553
      Top = 360
      Width = 230
      Height = 100
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      Visible = False
      object Label35: TLabel
        Left = 3
        Top = 77
        Width = 156
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo no Pre'#231'o de Compra:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label42: TLabel
        Left = 210
        Top = 77
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object rdgTipAltNot: TRadioGroup
        Left = 0
        Top = 1
        Width = 161
        Height = 60
        Caption = 'Tipo de Altera'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Alterar Pre'#231'o de Venda'
          'Alterar Margem de Lucro')
        TabOrder = 0
        OnClick = rdgTipAltNotClick
      end
      object edtPerAcr: TEditFocus
        Tag = 99
        Left = 161
        Top = 71
        Width = 47
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#0.00'
      end
    end
    object pnlMovmentacaoEstoque: TPanel
      Left = 783
      Top = 360
      Width = 346
      Height = 100
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object Label23: TLabel
        Left = 9
        Top = 6
        Width = 253
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produtos sem movimenta'#231#227'o de estoque h'#225' mais de:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 318
        Top = 6
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Caption = 'dias'
      end
      object rdgTipoMovimentacaoEstoque: TRadioGroup
        Left = 6
        Top = 24
        Width = 139
        Height = 67
        Caption = 'Tipo de Movimenta'#231#227'o:'
        ItemIndex = 2
        Items.Strings = (
          'Sem Venda'
          'Sem Compra'
          'Ambos')
        TabOrder = 1
        OnClick = rdgTipAltNotClick
      end
      object edtDiasMovimentacao: TEditFocus
        Tag = 99
        Left = 265
        Top = 2
        Width = 47
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
        EditFormat = '#0.00'
      end
      object rdgEmpresaMovimentacaoEstoque: TRadioGroup
        Left = 151
        Top = 24
        Width = 186
        Height = 67
        Caption = 'Filtrar movimenta'#231#227'o na:'
        ItemIndex = 0
        Items.Strings = (
          'Empresa Atual'
          'Todas as Empresas')
        TabOrder = 2
        OnClick = rdgTipAltNotClick
      end
    end
  end
  object pnlBotoesEnt: TPanel [6]
    Left = 0
    Top = 626
    Width = 1291
    Height = 24
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 20
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairAlt: TBitBtnLocked
      Left = 1178
      Top = 2
      Width = 111
      Height = 20
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAltClick
    end
    object btnPrecoPautaFiscal: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 125
      Height = 20
      Align = alLeft
      Caption = '[F3] Pre'#231'o Pauta Fiscal'
      TabOrder = 2
      OnClick = btnPrecoPautaFiscalClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1008
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1008
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1000
    Top = 160
  end
  object cdsAltGlo: TUniClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    BeforePost = cdsAltGloBeforePost
    Left = 944
    Top = 56
    object cdsAltGloITE_DESCAM: TStringField
      FieldName = 'ITE_DESCAM'
      Size = 100
    end
    object cdsAltGloITE_VALCAM: TStringField
      FieldName = 'ITE_VALCAM'
      Size = 6000
    end
    object cdsAltGloITE_MASCAM: TStringField
      FieldName = 'ITE_MASCAM'
      Size = 15
    end
    object cdsAltGloITE_NOMCAM: TStringField
      FieldName = 'ITE_NOMCAM'
      Size = 15
    end
    object cdsAltGloITE_DESABR: TStringField
      FieldName = 'ITE_DESABR'
      Size = 15
    end
    object cdsAltGloITE_LIMCAM: TIntegerField
      FieldName = 'ITE_LIMCAM'
    end
    object cdsAltGloITE_TIPCAM: TStringField
      FieldName = 'ITE_TIPCAM'
      Size = 15
    end
    object cdsAltGloITE_ALTERA: TStringField
      FieldName = 'ITE_ALTERA'
      Size = 1
    end
    object cdsAltGloITE_PROPER: TStringField
      FieldName = 'ITE_PROPER'
      Size = 100
    end
    object cdsAltGloITE_DESCRI: TStringField
      FieldName = 'ITE_DESCRI'
      Size = 100
    end
  end
  object dtsAltGlo: TDataSource
    DataSet = cdsAltGlo
    OnDataChange = dtsAltGloDataChange
    Left = 976
    Top = 56
  end
  object dspIteGlo: TUniDataSetProvider
    Options = []
    Left = 944
    Top = 96
  end
  object cdsIteGlo: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ITE_DESITE'
    Params = <>
    ProviderName = 'dspIteGlo'
    Left = 976
    Top = 96
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 384
    Top = 488
    PixelsPerInch = 96
    object cxsCorAzul: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsCombo: TcxStyle
      AssignedValues = [svColor]
      Color = 10801663
    end
    object cxsAltera: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsConsulta: TcxStyle
      AssignedValues = [svColor]
      Color = 11206613
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 108
    Top = 491
    PixelsPerInch = 96
    object cxeString16: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 16
    end
    object cxeString20: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
    end
    object cxeString02: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 2
    end
    object cxeString03: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
      Properties.OnValidate = cxeString03PropertiesValidate
    end
    object cxeString05: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 5
    end
    object cxeString06: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 6
    end
    object cxeString07: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 7
    end
    object cxeString08: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 8
    end
    object cxeString10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
    end
    object cxeString25: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 25
    end
    object cxeString30: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 30
    end
    object cxeString50: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 50
    end
    object cxeString70: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 70
    end
    object cxeString80: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 80
    end
    object cxeString150: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 150
    end
    object cxeString255: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 255
    end
    object cxeLocFis: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeLocSup: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeTamLcf: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeLocSep: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeDate: TcxEditRepositoryDateItem
      Properties.OnValidate = cxeDatePropertiesValidate
    end
    object cxeInt03: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 3
      Properties.OnValidate = cxeMasIntPropertiesValidate
    end
    object cxeInt11: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 11
      Properties.OnValidate = cxeMasIntPropertiesValidate
    end
    object cmbSimNao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbIndRev: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbClaCRM: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbNivGir: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'A'
        'B'
        'C')
    end
    object cmbNivCri: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'X'
        'Y'
        'Z')
    end
    object cmbRspGar: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'L'
        'F')
    end
    object cmbFrePFU: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbEsMiDg: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeMemo: TcxEditRepositoryMemoItem
      Properties.CharCase = ecUpperCase
      Properties.ScrollBars = ssBoth
      Properties.VisibleLineCount = 5
    end
    object cxeMasFat: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeDecUni: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeDec05: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeDec06: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasVal: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasPer: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasPerPropertiesValidate
    end
    object cxeMasMar: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasMBr: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cxeMasInt: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasIntPropertiesValidate
    end
    object cmbTipPro: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeConsTam8: TcxEditRepositoryTextItem
      Properties.MaxLength = 8
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam6: TcxEditRepositoryTextItem
      Properties.MaxLength = 6
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam5: TcxEditRepositoryTextItem
      Properties.MaxLength = 5
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam3: TcxEditRepositoryTextItem
      Properties.MaxLength = 3
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTamLse: TcxEditRepositoryTextItem
      Properties.MaxLength = 6
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam4: TcxEditRepositoryTextItem
      Properties.MaxLength = 4
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam2: TcxEditRepositoryTextItem
      Properties.MaxLength = 2
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeClassfIPI: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeClassfIPIPropertiesValidate
    end
    object cxeConsTam7: TcxEditRepositoryTextItem
      Properties.MaxLength = 7
    end
    object cmbSimNaoFornecedor: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbPerVda: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALUE'
      Properties.ListColumns = <
        item
          FieldName = 'DESCRICAO'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsPermissaoVenda
    end
    object cmbCarEst: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'ITEM ESTRUTURA'
        'SUB-PRODUTOS')
    end
    object cxBtnMontadora: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = cxBtnMontadoraPropertiesButtonClick
    end
    object cmbTpEstM: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'D=DIGITADO'
        'N=NOVO'
        'S=SAZONAL'
        '')
    end
    object cxeInt06: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 6
    end
    object cxeDecQtd: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasFatPropertiesValidate
    end
    object cmbMltRca: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'VENDA'
        'COMPRA')
    end
    object cxeMmoAPE: TcxEditRepositoryMemoItem
      Properties.ScrollBars = ssBoth
      Properties.VisibleLineCount = 5
    end
    object cmbTipRet: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbCSTOriSel: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        ''
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
  end
  object dtsPermissaoVenda: TDataSource
    Left = 980
    Top = 204
  end
  object cdsPrecoPautaFiscal: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 239
    Top = 524
    object cdsPrecoPautaFiscalPPF_CODITE: TStringField
      FieldName = 'PPF_CODITE'
      Size = 5
    end
    object cdsPrecoPautaFiscalPPF_ESTADO: TStringField
      FieldName = 'PPF_ESTADO'
      Size = 2
    end
    object cdsPrecoPautaFiscalPPF_VLRPPF: TFloatField
      FieldName = 'PPF_VLRPPF'
    end
    object cdsPrecoPautaFiscalPPF_DTAINI: TDateField
      FieldName = 'PPF_DTAINI'
    end
    object cdsPrecoPautaFiscalPPF_DTAFIN: TDateField
      FieldName = 'PPF_DTAFIN'
    end
  end
end
