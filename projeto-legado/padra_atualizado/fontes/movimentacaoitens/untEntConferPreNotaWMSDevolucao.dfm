inherited frmEntConferPreNotaWMSDevolucao: TfrmEntConferPreNotaWMSDevolucao
  Width = 1024
  Height = 534
  Caption = 'Devolu'#231#227'o de mercadorias - Pr'#233' Nota'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 461
    Width = 1018
    TabOrder = 1
    ExplicitTop = 461
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 937
      ExplicitWidth = 937
      object btnEmitirDevolucao: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 211
        Height = 24
        Align = alLeft
        Caption = 'Efetuar Devolu'#231#227'o'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0001000000060000000A0000000B0000000B0000000B0000000B0000000B0000
          000C0000000C0000000C0000000B000000070000000200000000000000000000
          000680574CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB279
          68FFB37968FFB27967FFB17967FF7F5749BF0000000700000000000000000000
          0008B57D6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFAF5
          F1FFFBF5F1FFFAF4F1FFFAF4F0FFB27B68FF0000000B00000000000000000000
          0008B67F6DFFFCF8F5FFEFEEEEFFEFEEEEFFEFEFEFFFEFEEEEFFEFEFEFFFEFEF
          EFFFEFEFEFFFEFEFEFFFFBF5F2FFB47D6AFF0000000B00000000000000000000
          0008B8826FFFFCF9F6FFEFEEEEFFC69B8BFFC59A8AFFC59A89FFC49888FFC498
          87FFBA8B7AFFEFEFEFFFFBF7F3FFB67F6DFF0000000A00000000000000000000
          0007BA8473FFFDF9F8FFF0F0EFFFF8EEE9FFF8EFE8FFF8EEE8FFF7EEE8FFF8EE
          E8FFF7EEE8FFF1F0F0FFFCF8F5FFB88170FF0000000A00000000000000000000
          0007BB8776FFFDFBF9FFF3F2F1FFC89F8EFFC89E8DFFC79D8CFFC79C8BFFC69B
          8BFFBC8E7DFFF2F1F1FFFCF9F7FFB98473FF0000000900000000000000000000
          0006BD8A78FFFDFBFAFFF4F4F4FFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFF9F0
          EBFFF8F0EAFFF4F3F2FFFDFAF8FFBB8675FF0000000800000000000000000000
          0006BF8D7BFFFEFCFBFFF7F6F6FFCAA494FFCAA393FFC9A291FFC8A191FFC8A0
          8FFFBF9381FFF5F4F3FFFDFBF9FFBD8978FF0000000800000000000000000000
          0005C1907EFFFEFDFCFFF9F9F8FFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2
          EEFFF9F1EEFFF7F6F4FFFDFBFAFFBF8D7BFF0000000700000000000000000000
          0005C39381FFFEFDFDFFFCFBFAFFCEAA9AFFCEA998FFCDA797FFCCA595FFCBA5
          94FFC19786FFF8F8F6FFFEFCFBFFC18F7EFF0000000700000000000000000000
          0004C59684FFFEFEFEFFFDFBFBFFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4
          F1FFFAF4F0FFFAF8F7FFFEFDFCFFC39381FF0000000600000000000000000000
          0004C69887FFFFFEFEFFFEFDFCFFCEAA9AFFCEA998FFCDA797FFCCA595FFCBA5
          94FFC19786FFFBFAF7FFFEFDFDFFC59684FF0000000600000000000000000000
          0003C99B8AFFFFFEFEFFFEFDFCFFFEFCFCFFFDFCFBFFFDFCFAFFFDFBFAFFFCFA
          F9FFFCFAF8FFFCF9F8FFFFFEFEFFC79887FF0000000500000000000000000000
          0003CA9E8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFC99B8AFF0000000400000000000000000000
          00029B7F74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA9
          99FFCFA899FFCEA899FFCFA898FF997B71C00000000300000000}
        TabOrder = 0
        OnClick = btnEmitirDevolucaoClick
      end
      object btnLiberarEnderecamento: TBitBtnLocked
        Left = 211
        Top = 0
        Width = 211
        Height = 24
        Align = alLeft
        Caption = 'Liberar para Endere'#231'amento/Estoque'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000936E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6542B7000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C19369ECD09D70FFCE9C6DFFCC996AFFCB9668FFB9875BEC000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000080000
          000F000000130000001600000017000000110000000400000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF0C498EBF1165
          C6FF0F63C5FF0E61C4FF0D60C3FF09448BC80000001100000000552D12810000
          00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D4ABD1268C8FFA3DA
          FFFF59BCFFFF56BBFFFF53BAFFFF0E60C3FF0000001700000000A95A25FF552D
          12810000000000000000000000000000000000000000000000001369C9FFB5E1
          FFFF5BBDFFFF59BBFFFF56BAFFFF0F61C3FFAD5E2AFFAC5D28FFAA5B27FFAA59
          24FF2C1709420000000000000000000000000000000000000000146ACAFFC6E8
          FFFFB7E2FFFFA7DCFFFF97D5FFFF0F63C5FF0000001200000000AC5D28FF542D
          137E0000000000000000000000000000000000000000000000000F5097BF136A
          CAFF1368C9FF1267C7FF1065C6FF0C4A93C60000000A00000000552F157E0000
          0000936E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6542B7000000010000
          0003000000050000000700000008000000070000000200000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D4ABD000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnLiberarEnderecamentoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 489
    Width = 1018
    TabOrder = 2
    ExplicitTop = 489
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 49
    Width = 1018
    Height = 412
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'MASTER_KEY'
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
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgDadosDBTableViewCitelMARCA_: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARCA_'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgDadosDBTableViewCitelMARCA_PropertiesChange
        Options.Grouping = False
        Width = 28
      end
      object cxgDadosDBTableViewCitelCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 50
      end
      object cxgDadosDBTableViewCitelDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 190
      end
      object cxgDadosDBTableViewCitelQTDNFE: TcxGridDBColumn
        Caption = 'Qtde. Nfe'
        DataBinding.FieldName = 'QTDNFE'
        Options.Editing = False
        Options.Focusing = False
        Options.Grouping = False
        Width = 63
      end
      object cxgDadosDBTableViewCitelQTDCON: TcxGridDBColumn
        Caption = 'Qtde. Conferida'
        DataBinding.FieldName = 'QTDCON'
        Options.Editing = False
        Options.Focusing = False
        Options.Grouping = False
        Styles.Content = cxStyle1
        Width = 87
      end
      object cxgDadosDBTableViewCitelQTDDEV: TcxGridDBColumn
        Caption = 'Qtde. a Devolver'
        DataBinding.FieldName = 'QTDDEV'
        Options.Editing = False
        Options.Focusing = False
        Width = 88
      end
      object cxgDadosDBTableViewCitelQTDLIB: TcxGridDBColumn
        Caption = 'Qtde. a Liberar'
        DataBinding.FieldName = 'QTDLIB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.OnChange = cxgDadosDBTableViewCitelQTDLIBPropertiesChange
        Width = 88
      end
      object cxgDadosDBTableViewCitelIDEDIG: TcxGridDBColumn
        Caption = 'Seq. Conf.'
        DataBinding.FieldName = 'IDEDIG'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 73
      end
      object cxgDadosDBTableViewCitelDTAREC: TcxGridDBColumn
        Caption = 'Data Recebimento'
        DataBinding.FieldName = 'DTAREC'
        Options.Editing = False
        Options.Focusing = False
        Width = 98
      end
      object cxgDadosDBTableViewCitelNOMMOT: TcxGridDBColumn
        Caption = 'Motorista'
        DataBinding.FieldName = 'NOMMOT'
        Options.Editing = False
        Options.Focusing = False
        Width = 114
      end
      object cxgDadosDBTableViewCitelPLACA_: TcxGridDBColumn
        Caption = 'Placa'
        DataBinding.FieldName = 'PLACA_'
        Options.Editing = False
        Options.Focusing = False
        Width = 74
      end
      object cxgDadosDBTableViewCitelIDENTI: TcxGridDBColumn
        Caption = 'Identifica'#231#227'o'
        DataBinding.FieldName = 'IDENTI'
        Options.Editing = False
        Options.Focusing = False
        Width = 131
      end
      object cxgDadosQTDLDE: TcxGridDBColumn
        Caption = 'Qtd. Lib. Ender.'
        DataBinding.FieldName = 'QTDLDE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
      end
    end
    object cxgDadosDBTableViewItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditing = cxgDadosDBTableViewItensEditing
      DataController.DetailKeyFieldNames = 'DETAIL_KEY'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'PRIMARY_KEY'
      DataController.MasterKeyFieldNames = 'MASTER_KEY'
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
      object cxgDadosDBTableViewItensSELEC_: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'SELEC_'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgDadosDBTableViewItensSELEC_PropertiesChange
        Width = 28
      end
      object cxgDadosDBTableViewItensNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 82
      end
      object cxgDadosDBTableViewItensCLAFIS: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CLAFIS'
        Options.Editing = False
      end
      object cxgDadosDBTableViewItensNATOPE: TcxGridDBColumn
        Caption = 'Natureza da Opera'#231#227'o'
        DataBinding.FieldName = 'NATOPE'
        Options.Editing = False
        Width = 199
      end
      object cxgDadosDBTableViewItensESPDOC: TcxGridDBColumn
        Caption = 'Especie'
        DataBinding.FieldName = 'ESPDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 68
      end
      object cxgDadosDBTableViewItensSERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERIE_'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxgDadosDBTableViewItensFORNEC: TcxGridDBColumn
        Caption = 'Forncedor'
        DataBinding.FieldName = 'FORNEC'
        Options.Editing = False
        Options.Focusing = False
        Width = 199
      end
      object cxgDadosDBTableViewItensQTDITE: TcxGridDBColumn
        Caption = 'Qtde. Entrada'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 80
      end
      object cxgDadosDBTableViewItensUNITAR: TcxGridDBColumn
        Caption = 'Valor Un.'
        DataBinding.FieldName = 'UNITAR'
        Options.Editing = False
        Options.Focusing = False
        Width = 74
      end
      object cxgDadosDBTableViewItensQTDENV: TcxGridDBColumn
        Caption = 'Qtde. a Devolver'
        DataBinding.FieldName = 'QTDENV'
        Width = 95
      end
      object cxgDadosQTDCON: TcxGridDBColumn
        Caption = 'Qtd. Conferida'
        DataBinding.FieldName = 'QTDCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
      end
      object cxgDadosItemQTDLDE: TcxGridDBColumn
        Caption = 'Qtd. Lib. Ender.'
        DataBinding.FieldName = 'QTDLDE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
      end
    end
    object cxgDadosLevel: TcxGridLevel
      GridView = cxgDadosDBTableViewCitel
      object cxgDadosLevel1: TcxGridLevel
        GridView = cxgDadosDBTableViewItens
      end
    end
  end
  object pnlFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label5: TLabel
      Left = 10
      Top = 5
      Width = 127
      Height = 14
      Caption = 'Data de recebimento entre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 104
      Top = 25
      Width = 6
      Height = 14
      Caption = 'e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 10
      Top = 21
      Width = 88
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
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 116
      Top = 21
      Width = 88
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnAbreDados: TBitBtnLocked
      Left = 579
      Top = 21
      Width = 92
      Height = 22
      Caption = 'Filtrar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000020000
        000A000000160000001B000000170000000B0000000200000000000000010000
        00060000000B0000000F0000000C0000000600000001000000000000000F2616
        1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
        1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
        70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
        72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
        D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
        D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
        F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
        F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
        E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
        E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
        A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
        CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
        5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
        CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
        3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
        D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
        1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
        E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
        0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
        C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
        0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
        58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
        0000000000010000000400000006000000050000000200000000000000000000
        0001000000010000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      Layout = blGlyphRight
      Spacing = 6
      TabOrder = 2
      OnClick = btnAbreDadosClick
    end
    object pnlFilterFor: TPanel
      Left = 210
      Top = 4
      Width = 363
      Height = 39
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Label10: TLabel
        Left = 3
        Top = 1
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtFornecedor: TEditFocus
        Tag = 99
        Left = 3
        Top = 17
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        OnExit = edtFornecedorExit
        OnKeyPress = edtFornecedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesFornecedor: TEditFocus
        Left = 63
        Top = 17
        Width = 300
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
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 160
    Top = 300
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
