inherited frmManCadCidadeSigep: TfrmManCadCidadeSigep
  Width = 769
  Height = 528
  Caption = 
    'Manuten'#231#227'o do Cadastro de Cidades - Configura'#231#245'es p/ Seguro Corr' +
    'eios'
  OnDestroy = FormDestroy
  ExplicitWidth = 769
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 457
    Width = 763
    TabOrder = 2
    ExplicitTop = 457
    ExplicitWidth = 763
    inherited FlwBotoes: TFlowPanel
      Width = 670
      ExplicitLeft = 350
      ExplicitWidth = 322
      inherited btnConfirma: TBitBtnLocked
        Width = 95
        Align = alLeft
        ModalResult = 0
        ExplicitWidth = 95
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 95
        Top = 0
        Width = 116
        Height = 22
        Align = alLeft
        Caption = '&Marcar Todos'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Tag = 1
        Left = 211
        Top = 0
        Width = 116
        Height = 22
        Align = alLeft
        Caption = '&Desmarcar Todos'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnMarcarTodosClick
      end
      object btnInverter: TBitBtnLocked
        Tag = 2
        Left = 327
        Top = 0
        Width = 116
        Height = 22
        Align = alLeft
        Caption = '&Inverter Todos'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 672
      Top = 2
      Width = 89
      Align = alRight
      ExplicitLeft = 672
      ExplicitTop = 2
      ExplicitWidth = 89
    end
  end
  inherited pnlStatus: TPanel
    Top = 483
    Width = 763
    TabOrder = 3
    ExplicitTop = 483
    ExplicitWidth = 763
    inherited pnlNomeForm: TPanel
      Left = 592
      ExplicitLeft = 592
    end
    inherited pnlInfo: TPanel
      Width = 592
      ExplicitWidth = 592
    end
  end
  object pnlTop: TPanel [3]
    Left = 0
    Top = 0
    Width = 763
    Height = 92
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 5
      Width = 33
      Height = 14
      Caption = 'Cidade'
    end
    object Label2: TLabel
      Left = 331
      Top = 5
      Width = 39
      Height = 14
      Caption = 'Estados'
    end
    object edtNomCid: TEditFocus
      Tag = 99
      Left = 11
      Top = 22
      Width = 313
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object clbEstados: TCheckListBox
      Left = 330
      Top = 22
      Width = 251
      Height = 66
      Columns = 7
      ItemHeight = 14
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SE'
        'SP'
        'TO')
      TabOrder = 1
    end
    object btnFiltrar: TBitBtnLocked
      Left = 587
      Top = 22
      Width = 117
      Height = 25
      Caption = 'Filtrar Cidades'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000030000000D000000190000001A0000
        000E000000030000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D112B4A8C1A4E9CF6194D9BF60F28
        478D0000000E0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000172762ABFFD6EDF7FF5DB1E5FF225C
        A5FF000000190000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000019255FA9FFC1E6F5FF56AEE3FF2058
        A3FF0000001B0000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000017235CA7FFABE2F6FF4DABE4FF1F56
        A2FF000000190000000000000000000000000000000000000000000000000000
        00000000000000000000000000020000001B225BA6FF8FD6F4FF45A5E1FF1E54
        A1FF0000001E0000000200000000000000000000000000000000000000000000
        00000000000000000005000102160F28498A225AA6FF77CAEEFF3BA0DEFF1E53
        A1FF081E3F8D0001021800000006000000010000000000000000000000000000
        000000000005040B112D22568DD03B81C4FF4E96D2FF4AA1D9FF3592D1FF2F7E
        C6FF2465B0FF113A76D202070E31000000070000000100000000000000000000
        0004060F18332F70AFEE569FD6FF7CC0E8FF93CFEFFF5BBFE9FF41ADDFFF3287
        CEFF3485D2FF3181C9FF1A5095EF030A14390000000500000000000000010000
        000B265D8FC962ACDDFF86CDEFFFC3EAF9FFA8E2F8FF6BCFF0FF47BAE6FF398F
        D4FF2F7ACBFF3C92DBFF368ACFFF17417BCD0000000F00000001000000030E23
        34534992CCFF8BD2F1FFBAE9F9FFE2F7FDFFAFE7F9FF72D4F2FF4ABFE8FF3F98
        D8FF2B73C8FF3486D2FF43A2E2FF2A70BAFF09182E5A00000005000000062252
        7AA96BB6E1FF99E1F7FFDFF7FDFFF5FCFFFFB1EBFBFF76D7F3FF4DC5EAFF47A2
        DEFF2A72C6FF2F7ACBFF44A2E4FF3891D4FF163C6CAE0000000A00000007357D
        B5EC91D5F2FFC5EFFBFFF1FCFEFFEBFAFDFFE4F9FDFFDFF8FDFFDAF7FDFFD5F6
        FDFFC7ECF9FFA1D1EEFF86CBF1FF4FADE5FF21599FEC0000000C000000053C8B
        C8FFF2FAFDFFB9C6E2FF6884C0FF3C64B1FF0F43A4FF1451ADFF1B60B8FF2471
        C1FF529CD6FF76BBE6FFAAE0F4FFC5F0FBFF2665B0FE0000000A000000021530
        455E468DC1F093C7E7FFC7E6F4FFE4F4FBFFE8F7FCFFF4FCFEFFEFFBFDFFD6F2
        FAFFCAEBF8FFA6D6EFFF71AFDCFF316FB0F10D233D6400000004000000000000
        000203070A111633476026577BA1316F9FCF3275AADE3885C4FF3681C2FF2D6C
        A5DE286298D11D4872A410284164020509150000000400000001}
      TabOrder = 2
      OnClick = btnFiltrarClick
    end
  end
  object pnlButton: TPanel [4]
    Left = 0
    Top = 429
    Width = 763
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label9: TLabel
      Left = 10
      Top = 7
      Width = 163
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor m'#237'n. p/ seguro dos correios:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 283
      Top = 7
      Width = 179
      Height = 14
      Alignment = taRightJustify
      Caption = '% declarado sobre o valor da venda:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtVrMSeg: TEditFocus
      Tag = 99
      Left = 177
      Top = 4
      Width = 92
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPerSeg: TEditFocus
      Tag = 99
      Left = 465
      Top = 4
      Width = 92
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object cxgCidades: TcxGridCitel [5]
    Left = 0
    Top = 92
    Width = 763
    Height = 337
    Align = alClient
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgCidadesTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
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
      OptionsView.GroupByBox = False
      OptionsView.GroupFooterMultiSummaries = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgCidadesTableViewColumn1: TcxGridDBColumn
        Caption = '  '
        DataBinding.FieldName = 'MARCA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 22
      end
      object cxgCidadesTableViewColumn2: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CID_CODCID'
        Options.Editing = False
        Options.Focusing = False
        Width = 58
      end
      object cxgCidadesTableViewColumn3: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        Options.Editing = False
        Options.Focusing = False
        Width = 267
      end
      object cxgCidadesTableViewColumn4: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CID_ESTADO'
        Options.Editing = False
        Options.Focusing = False
        Width = 27
      end
      object cxgCidadesTableViewColumn5: TcxGridDBColumn
        Caption = 'Valor m'#237'n. p/ seguro dos correios'
        DataBinding.FieldName = 'CID_VRMSEG'
        Options.Editing = False
        Options.Focusing = False
        Width = 169
      end
      object cxgCidadesTableViewColumn6: TcxGridDBColumn
        Caption = '% declarado sobre o valor da venda'
        DataBinding.FieldName = 'CID_PERSEG'
        Options.Editing = False
        Options.Focusing = False
        Width = 188
      end
    end
    object cxgCidadesLevel: TcxGridLevel
      GridView = cxgCidadesTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 720
    Top = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 280
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 280
  end
end
