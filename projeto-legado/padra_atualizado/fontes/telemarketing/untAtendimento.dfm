inherited frmAtendimento: TfrmAtendimento
  Left = 278
  Top = 171
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Atendimento'
  Position = poScreenCenter
  OnClose = FormClose
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter: TSplitter [0]
    Left = 0
    Top = 362
    Width = 1008
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Color = clNavy
    ParentColor = False
    ExplicitTop = 357
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object lblTitulo: TLabel
      Left = 28
      Top = 14
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 374
      Top = 14
      Width = 39
      Height = 14
      Caption = 'Per'#237'odo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 485
      Top = 14
      Width = 6
      Height = 14
      Caption = 'a'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 79
      Top = 10
      Width = 64
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
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 143
      Top = 10
      Width = 221
      Height = 22
      Alignment = taLeftJustify
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 415
      Top = 10
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
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
      Left = 497
      Top = 10
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlBotoes: TPanel
    Top = 495
    Width = 1008
    Height = 50
    ExplicitTop = 495
    ExplicitWidth = 1008
    ExplicitHeight = 50
    object Panel6: TPanel [0]
      Left = 2
      Top = 2
      Width = 1004
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
    end
    inherited FlwBotoes: TFlowPanel
      Top = 3
      Width = 1004
      Height = 45
      Align = alBottom
      ExplicitTop = 3
      ExplicitWidth = 1004
      ExplicitHeight = 45
      object btnResFin: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F6 ] Resumo Financeiro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnResFinClick
      end
      object btnVenCli: TBitBtnLocked
        Left = 168
        Top = 0
        Width = 171
        Height = 23
        Caption = '[ F7 ] Vendas Cliente'
        TabOrder = 1
        OnClick = btnVenCliClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 339
        Top = 0
        Width = 161
        Height = 22
        Caption = '[ F9 ] Relat'#243'rio'
        TabOrder = 2
        OnClick = btnRelatorioClick
      end
      object btnAcompEntrega: TBitBtnLocked
        Left = 500
        Top = 0
        Width = 206
        Height = 22
        Caption = '[ F10 ] Acompanhamento da Entrega'
        TabOrder = 3
        OnClick = btnAcompEntregaClick
      end
      object btnNiverDia: TBitBtnLocked
        Left = 706
        Top = 0
        Width = 200
        Height = 22
        Caption = '[ F12 ] Aniversariantes do Dia'
        TabOrder = 4
        OnClick = btnNiverDiaClick
      end
      object btnBaixar: TBitBtnLocked
        Left = 906
        Top = 0
        Width = 97
        Height = 22
        Caption = '[Enter] Baixar'
        TabOrder = 5
        OnClick = btnBaixarClick
      end
      object btnCadCli: TBitBtnLocked
        Left = 0
        Top = 23
        Width = 168
        Height = 22
        Caption = '[Alt + F2] Cadastro de  Clientes'
        TabOrder = 6
        OnClick = btnCadCliClick
      end
      object btnOrcVen: TBitBtnLocked
        Left = 168
        Top = 23
        Width = 171
        Height = 22
        Caption = '[Alt + F3] Or'#231'amento de Venda'
        TabOrder = 7
        OnClick = btnOrcVenClick
      end
      object btnPedVen: TBitBtnLocked
        Left = 339
        Top = 23
        Width = 161
        Height = 22
        Caption = '[Alt + F5] Pedido de Venda'
        TabOrder = 8
        OnClick = btnPedVenClick
      end
      object btnInsAten: TBitBtnLocked
        Left = 500
        Top = 23
        Width = 206
        Height = 22
        Caption = '[ Insert ] Insere um novo Atendimento'
        TabOrder = 9
        OnClick = btnInsAtenClick
      end
      object btnInfLigacao: TBitBtnLocked
        Tag = 1
        Left = 706
        Top = 23
        Width = 200
        Height = 22
        Caption = '[Ctrl + Enter] Hist'#243'rico Atendimento'
        TabOrder = 10
        OnClick = btnBaixarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 908
      Top = 26
      Width = 98
      Align = alRight
      ExplicitLeft = 908
      ExplicitTop = 26
      ExplicitWidth = 98
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Left = 372
      Width = 465
      ExplicitLeft = 372
      ExplicitWidth = 465
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 372
      Height = 16
      Align = alLeft
      BevelInner = bvLowered
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object lblLegenda: TLabel
        Left = 17
        Top = 2
        Width = 332
        Height = 14
        Align = alLeft
        Caption = 
          'Cliente possui or'#231'amentos e pedidos que ainda n'#227'o foram faturado' +
          's.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object shpLegenda: TShape
        Left = 2
        Top = 2
        Width = 15
        Height = 12
        Align = alLeft
        Brush.Color = clBlue
        Pen.Color = clBlue
        ExplicitLeft = 3
      end
    end
  end
  object dbgAtendimento: TcxGridCitel [5]
    Left = 0
    Top = 41
    Width = 1008
    Height = 291
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgAtendimentoDBView: TcxGridDBTableViewCitel
      OnKeyDown = dbgAgendamentoKeyDown
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Insert.Enabled = False
      Navigator.Buttons.Append.Enabled = False
      Navigator.Buttons.Delete.Enabled = False
      Navigator.Buttons.Edit.Enabled = False
      Navigator.Buttons.Post.Enabled = False
      Navigator.Buttons.Cancel.Enabled = False
      FilterBox.Visible = fvNever
      FindPanel.InfoText = 'Digite um texto para busca...'
      OnCustomDrawCell = dbgAtendimentoDBViewCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Filter.AutoDataSetFilter = True
      DataController.MultiThreadedOptions.Filtering = bTrue
      DataController.MultiThreadedOptions.Sorting = bTrue
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CheckBoxPosition = cbpIndicator
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.HeaderFilterButtonShowMode = fbmSmartTag
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridAtendimentoCLI_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CLI_CODCLI'
        BestFitMaxWidth = 59
        MinWidth = 59
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 59
      end
      object cxGridAtendimentoCLI_NOMCLI: TcxGridDBColumn
        Caption = 'Nome do Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        BestFitMaxWidth = 155
        MinWidth = 155
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 155
      end
      object cxGridAtendimentoCLI_FANSOB: TcxGridDBColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'CLI_FANSOB'
        BestFitMaxWidth = 155
        MinWidth = 155
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoATI_DESATI: TcxGridDBColumn
        Caption = 'Atividade'
        DataBinding.FieldName = 'ATI_DESATI'
        BestFitMaxWidth = 155
        MinWidth = 155
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoCLI_C_G_C_: TcxGridDBColumn
        Caption = 'CNPJ/CPF'
        DataBinding.FieldName = 'CLI_C_G_C_'
        BestFitMaxWidth = 100
        MinWidth = 100
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoCLI_FONE01: TcxGridDBColumn
        Caption = 'Telefone'
        DataBinding.FieldName = 'CLI_FONE01'
        BestFitMaxWidth = 85
        MinWidth = 85
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoAGE_DTAAGE: TcxGridDBColumn
        Caption = 'Pr'#243'x. Agenda'
        DataBinding.FieldName = 'AGE_DTAAGE'
        BestFitMaxWidth = 70
        MinWidth = 70
        Options.Editing = False
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoCLI_CONTAT: TcxGridDBColumn
        Caption = 'Contato'
        DataBinding.FieldName = 'CLI_CONTAT'
        BestFitMaxWidth = 90
        MinWidth = 90
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoCID_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        BestFitMaxWidth = 110
        MinWidth = 110
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoCID_ESTADO: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CID_ESTADO'
        BestFitMaxWidth = 22
        MinWidth = 22
        Options.ShowEditButtons = isebNever
        Width = 22
      end
      object cxGridAtendimentoAGE_DTABAI: TcxGridDBColumn
        Caption = #218'ltimo Contato'
        DataBinding.FieldName = 'AGE_DTABAI'
        BestFitMaxWidth = 71
        MinWidth = 71
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoCLI_EMAIL_: TcxGridDBColumn
        Caption = 'E-mail'
        DataBinding.FieldName = 'CLI_EMAIL_'
        BestFitMaxWidth = 70
        MinWidth = 70
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoORCAME: TcxGridDBColumn
        DataBinding.FieldName = 'ORCAME'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bFalse
      end
      object cxGridAtendimentoREG_DESREG: TcxGridDBColumn
        Caption = 'Descri'#231#227'o da Regi'#227'o'
        DataBinding.FieldName = 'REG_DESREG'
        BestFitMaxWidth = 110
        MinWidth = 110
        Options.ShowEditButtons = isebNever
      end
      object cxGridAtendimentoSUB_DESSUB: TcxGridDBColumn
        Caption = 'Descri'#231#227'o da Sub-Regi'#227'o'
        DataBinding.FieldName = 'SUB_DESSUB'
        BestFitMaxWidth = 110
        MinWidth = 110
        Options.ShowEditButtons = isebNever
      end
    end
    object dbgAtendimentoPrimeiroNivel: TcxGridLevel
      GridView = dbgAtendimentoDBView
      Options.DetailTabsPosition = dtpLeft
    end
  end
  object pgcObservacoes: TPageControl [6]
    Left = 0
    Top = 365
    Width = 1008
    Height = 130
    ActivePage = tbsHistLigacoes
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Style = tsFlatButtons
    TabOrder = 5
    OnChange = pgcObservacoesChange
    object tbsObsCliente: TTabSheet
      Caption = '1-Observa'#231#245'es Cliente'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlObsCli: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 98
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object dbmObsCli: TDBMemoFocus
          Left = 0
          Top = 14
          Width = 1000
          Height = 84
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          DataField = 'CLI_OBSERV'
          DataSource = dtsConsulta
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Observa'#231#245'es do Cliente'
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
        end
      end
    end
    object tbsObsCredito: TTabSheet
      Caption = '2-Observa'#231#245'es de Cr'#233'dito'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlObsCre: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 98
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object dbmObsCre: TDBMemoFocus
          Left = 0
          Top = 14
          Width = 1000
          Height = 84
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          DataField = 'CLI_OBSCON'
          DataSource = dtsConsulta
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Observa'#231#245'es da Consulta de Cr'#233'dito'
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
        end
      end
    end
    object tbsHistLigacoes: TTabSheet
      Caption = '3-Hist'#243'rico de Liga'#231#245'es'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlUltLig: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 98
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Hist'#243'rico de Liga'#231#245'es'
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
        end
        object memHisLig: TMemoFocus
          Left = 0
          Top = 14
          Width = 1000
          Height = 84
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
  end
  object pnlConfigColun: TPanel [7]
    Left = 0
    Top = 332
    Width = 1008
    Height = 30
    Align = alBottom
    TabOrder = 6
    object btnCfgGri: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 148
      Height = 22
      Caption = 'Confi&gura colunas '
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
        00090000000E0000000F00000010000000100000001100000011000000110000
        00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
        4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
        ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
        6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
        9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
        71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
        64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
        75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
        B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
        78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
        BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
        7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
        BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
        7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
        C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
        84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
        C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
        87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
        D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
        8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
        97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
        8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
        AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
        91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
        F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
        95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
        FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
        6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
        93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
      TabOrder = 0
      OnClick = btnCfgGriClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 512
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 136
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      ' ')
    Constraints = <>
    Left = 544
    Top = 144
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 576
    Top = 144
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    AfterInsert = cdsConsultaAfterInsert
    AfterScroll = cdsConsultaAfterScroll
    Left = 608
    Top = 144
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 640
    Top = 144
  end
  object popOrcamento: TPopupMenu
    Left = 868
    Top = 220
    object mnuFatOrcamento: TMenuItem
      Caption = 'Or'#231'amento'
      Hint = 'frmFatVendas - OR'
    end
  end
  object popPedido: TPopupMenu
    Left = 868
    Top = 172
    object mnuFatPedido: TMenuItem
      Caption = 'Pedido'
      Hint = 'frmFatVendas - PD'
    end
  end
end
