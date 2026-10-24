inherited frmFatDefineLotesPedidoWMS: TfrmFatDefineLotesPedidoWMS
  Left = 195
  Top = 179
  Width = 1113
  Height = 650
  Caption = 'Defini'#231#227'o de Lotes do Pedido'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1113
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 382
    Width = 1097
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Color = clWhite
    ParentColor = False
    ExplicitTop = 367
    ExplicitWidth = 784
  end
  inherited pnlBotoes: TPanel
    Top = 568
    Width = 1097
    Height = 27
    ExplicitTop = 568
    ExplicitWidth = 1097
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 996
      Height = 23
      ExplicitWidth = 996
      ExplicitHeight = 23
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 117
        Height = 23
        Align = alLeft
        ExplicitWidth = 117
        ExplicitHeight = 23
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 117
        Width = 103
        Height = 23
        Align = alLeft
        ExplicitLeft = 117
        ExplicitWidth = 103
        ExplicitHeight = 23
      end
      object btnConfirma: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 109
        Height = 23
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnConfigurar: TBitBtnLocked
        Left = 329
        Top = 0
        Width = 77
        Height = 23
        Align = alLeft
        Caption = '&Configurar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF108ABA1895C1066897FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF188CBA138FBD066A990982B213
          99CA1E9DC90B72A00A6D9A2B96BD2692BCFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF1D8FBA21A5D10999CE078ABC0EB7EB2FCBF61F90BB41B0D34CB4D4288E
          B6FF00FFFF00FFFF00FFFF00FF1073A01880AB35A1C96BD0EA37AFD423B8E60F
          CBFF23D0FF44C7ED5AB6D59CD8E677C0D80D72A1FF00FFFF00FFFF00FF45A7CB
          2F9CC539ACD77DE7FF74EAFF40DDFF15CFFF0DCCFF38D9FF5EE1FF63E5FF28BC
          E91C9DCE188EC0FF00FFFF00FF0878AF1190CB35B2E367D5F479EAFF56C6E141
          A5BD369EBA17B7E502C4FF01C1FE03C2FE03BAF205A0D8FF00FFFF00FF0D75A5
          1698D428A9E052CBF378B7C67F7E7E7F7E7E7F7E7E7F7E7E2DAACC00C5FF09C6
          FE0FC5FA0487BCFF00FFFF00FF0F79AA1598D51CA0DA40C1F07F7E7EE2DAD99E
          9F9F978B8BD8A4A17F7E7E3FD1F884EBFFA1EAFB2683ABFF00FFFF00FF0973A5
          0F86BF1597D32EB5EA7F7E7EE2D9D79D9E9E978B8BD1A1A07F7E7E62DCFA97E6
          F770BCD72F8FB4FF00FFFF00FFFF00FF056695108BC620AAE57F7E7EE2D9D79D
          9E9E978B8BD3A3A07F7E7E4AD8FC4DBBDE015E8EFF00FFFF00FFFF00FFFF00FF
          FF00FF086FA00576AC7F7E7EE6DDD99D9E9E978B8BD7A5A37F7E7E0F82B0117A
          A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7EDDDAD999
          9A9A968A8ACCA3A37F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF7F7E7E9E9E9E898989817E7E9689897F7E7EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7ED8D7D7B6
          B7B78F8C8C9F8F8F7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF7F7E7EDDDCDCE3E2E2AAAAAA8C87877F7E7EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7E7F
          7E7E7F7E7E7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnConfigurarClick
      end
      object btnSepAnd: TBitBtnLocked
        Left = 406
        Top = 0
        Width = 217
        Height = 23
        Align = alLeft
        Caption = 'Consultar &Separa'#231#227'o em Andamento'
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
        TabOrder = 4
        OnClick = btnSepAndClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 623
        Top = 0
        Width = 190
        Height = 23
        Align = alLeft
        Caption = 'S&aldo de estoque do produto'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 5
        OnClick = btnRelatorioClick
      end
      object btnRecalcularLocalizacoes: TBitBtnLocked
        Left = 813
        Top = 0
        Width = 148
        Height = 23
        Caption = 'Recalcular Localiza'#231#245'es'
        TabOrder = 6
        Visible = False
        OnClick = btnRecalcularLocalizacoesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 998
      Top = 2
      Width = 97
      Height = 23
      Align = alRight
      ExplicitLeft = 998
      ExplicitTop = 2
      ExplicitWidth = 97
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 595
    Width = 1097
    ExplicitTop = 595
    ExplicitWidth = 1097
    inherited pnlNomeForm: TPanel
      Left = 926
      ExplicitLeft = 926
    end
    inherited pnlInfo: TPanel
      Width = 926
      ExplicitWidth = 926
    end
  end
  inherited pnlHeader: TPanel
    Width = 1097
    Height = 0
    Visible = False
    ExplicitWidth = 1097
    ExplicitHeight = 0
  end
  inherited pnlTail: TPanel
    Top = 385
    Width = 1097
    Height = 0
    Enabled = False
    ExplicitTop = 385
    ExplicitWidth = 1097
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 81
    Width = 1097
    Height = 227
    Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnEnter = dbgConsultaEnter
    OnExit = dbgConsultaExit
    OnKeyPress = dbgConsultaKeyPress
    OnMouseMove = dbgConsultaMouseMove
    Columns = <
      item
        Expanded = False
        FieldName = 'FDO_CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODBAR'
        ReadOnly = True
        Title.Caption = 'C'#243'd. Barras'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        ReadOnly = True
        Title.Caption = 'C'#243'd. F'#225'brica'
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESTINO'
        ReadOnly = True
        Title.Caption = 'Destino'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 396
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SALDOS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo F'#237'sico'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo dipon'#237'vel'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TEM_MOVLOT'
        Title.Caption = ' '
        Width = 21
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMLOT'
        ReadOnly = True
        Title.Caption = 'Lote'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FDO_IDEPRO'
        Title.Caption = 'Situa'#231#227'o'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 0
    Width = 1097
    ExplicitTop = 0
    ExplicitWidth = 1097
  end
  object prgProgresso: TProgressBar [7]
    Left = 0
    Top = 556
    Width = 1097
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  object pnlInfWms: TPanel [8]
    Left = 0
    Top = 365
    Width = 1097
    Height = 17
    Align = alBottom
    BevelOuter = bvSpace
    Caption = 
      'Pressione [Enter] sobre o produto para informar os lotes e as qu' +
      'antidades dos mesmos'
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 7
  end
  object dbgLotes: TDBGridCitel [9]
    Left = 0
    Top = 385
    Width = 1097
    Height = 171
    Align = alBottom
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 8
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgLotesDrawColumnCell
    OnKeyPress = dbgLotesKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMLOT'
        Title.Caption = 'Lote'
        Width = 212
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCFIS'
        Title.Caption = 'Localiza'#231#227'o F'#237'sica'
        Width = 142
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PICKIN'
        Title.Alignment = taCenter
        Title.Caption = 'Picking?'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAVAL'
        Title.Alignment = taCenter
        Title.Caption = 'Data Validade'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Dispon'#237'vel'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 123
        Visible = True
      end>
  end
  object pnlLegenda: TPanel [10]
    Left = 0
    Top = 346
    Width = 1097
    Height = 19
    Align = alBottom
    BevelOuter = bvNone
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 9
    object shpLotesDefinidosPedido: TShape
      Left = 5
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = clYellow
    end
    object lblLotesDefinidosPedido: TLabel
      Left = 24
      Top = 3
      Width = 210
      Height = 14
      Caption = 'Lotes definidos obrigatoriamente no pedido.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpLegProdutoAcabado: TShape
      Left = 241
      Top = 3
      Width = 13
      Height = 13
      Brush.Color = 3329434
    end
    object lblLegProdutoAcabado: TLabel
      Left = 260
      Top = 2
      Width = 467
      Height = 14
      Caption = 
        'Produto Acabado - Informar a localiza'#231#227'o f'#237'sica para fazer impri' +
        'mir separa'#231#227'o (Produto sem lote)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlLegendaMovimentacaoProgramada: TPanel [11]
    Left = 0
    Top = 308
    Width = 1097
    Height = 19
    Align = alBottom
    BevelOuter = bvNone
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 10
    object Image: TImage
      Left = 5
      Top = 0
      Width = 16
      Height = 16
      Picture.Data = {
        07544269746D617036030000424D360300000000000036000000280000001000
        000010000000010018000000000000030000120B0000120B0000000000000000
        0000FF00FFFF00FFFF00FFFF00FFFF00FF8F8D8D919090989696969595929090
        8F8D8DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8F8D8D9B9A
        9ABEBEBFBFBEC0B6B6B4B7B3AFBAB2B2B8B0B09C98988F8D8DFF00FFFF00FFFF
        00FFFF00FFFF00FF999999B5B4B4D7D7D8B1AFABA8A699ABABA9A1A2AAAFA696
        A59993CAB7B6B7AAAA8D8C8CFF00FFFF00FFFF00FF8F8D8DB6B4B5E1DFE0ABA8
        A0D2D0BCFEF4D9DDCED1BDB7D7FFFFEBDEDDD59C9489CAAFAFB9AAAA8F8D8DFF
        00FFFF00FFABA5AB95BE9735883CDADDC3FFF7D8F6D5A6F3C690F3BC81F3CD9D
        FFFCE6F2F6F09B9084D6B6B79F9898FF00FF8F8D8D92A7913DB25642CE6D67AF
        64F9F6CEFFFAD5FBF1C8F7DAACF2C896F5D29EFFEDD3D8D7CEA9918AC7B0B0A3
        999A8A968920932E41D1695AE58A40CB6B83C079FEFFDDFEFFDDFDFAD5FFEDBE
        FCCC94F4BF89FFF9E2A39889D1B2B2A3999A20822616A52832C15042CD663DBF
        601D942F95C181C1BCAA84847CB1B29AAB977CDCAA75DACDD29897A0D3B2AEAC
        9F9F4588484C944F1CAB2F27B9435EA562CEE2C8D3E7B6C0C0AA54545641423F
        888676D2A97AC7BBCE8D8EA0D5B4B0AB9E9EA99EA8A4BCA40F991A11A92573B3
        77FFFFFFFFFFF7FFFFDFDBDBC067685FB7AD92FFDAA7FFF2CEABA093D2B3B5A2
        98998F8D8DBCBBBB32983803A312299731E5ECE3FFFFFFFFFFFBFFFFF0EDEDD6
        5D5C53AC9F8CDFDFC7B59F9BCCB3B3A29899FF00FFA39EA197BA980C9316009D
        0E41A046B0D1B2EEF5EFF8FBF8FFFFFEF2F2DACCD0B5B0A89CD9BABBA19999FF
        00FFFF00FF8F8D8DB3ADB290B8921E942600900900880B12821C2F8B3ED0E6CE
        EDEDE0BCB6A9D4B9BAB2A6A68F8D8DFF00FFFF00FFFF00FF949493AFACAFBDC9
        BDA0BCA18AAB8795AE89A9B89CC2C1B6C2B7B4D1BCBDB0A5A5949494FF00FFFF
        00FFFF00FFFF00FFFF00FF8F8D8DA09D9FBDB7BCCAC3C9C5C0C5C1BBBEBDB5B6
        B2ACAE9C9A9A8F8D8DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF8F8D8D8F8D8D9392929492928F8E8E8F8D8DFF00FFFF00FFFF00FFFF00FFFF
        00FF}
      Transparent = True
    end
    object Label1: TLabel
      Left = 26
      Top = 2
      Width = 784
      Height = 14
      Caption = 
        'Lotes com movimenta'#231#227'o programada em aberto para o Picking - Cas' +
        'o o Picking n'#227'o tenha saldo suficiente, realize o abastecimento ' +
        'antes de imprimir a separa'#231#227'o!'
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
    end
  end
  object Panel1: TPanel [12]
    Left = 0
    Top = 327
    Width = 1097
    Height = 19
    Align = alBottom
    BevelOuter = bvNone
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 12
    object shpLoteZerado: TShape
      Left = 5
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = 6184703
    end
    object lblLoteZerado: TLabel
      Left = 24
      Top = 3
      Width = 98
      Height = 14
      Caption = 'Lotes n'#227'o atendidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpSaldoInsuficiente: TShape
      Left = 241
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = 15991028
    end
    object lblSaldoInsuficiente: TLabel
      Left = 260
      Top = 3
      Width = 141
      Height = 14
      Caption = 'Lotes parcialmente atendidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpLoteBloqueado: TShape
      Left = 477
      Top = 4
      Width = 13
      Height = 13
      Brush.Color = 8036607
    end
    object lblLoteBloqueado: TLabel
      Left = 496
      Top = 3
      Width = 102
      Height = 14
      Caption = 'Lote(s) bloqueado(s)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlFiltroLote: TPanel [13]
    Left = 0
    Top = 40
    Width = 1097
    Height = 41
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 11
    object rdgFiltraSaldoLote: TRadioGroup
      Left = 10
      Top = 1
      Width = 559
      Height = 34
      Caption = 'Filtrar por:'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Lotes parcialmente atendidos'
        'Lotes n'#227'o atendidos')
      TabOrder = 0
      OnClick = rdgFiltraSaldoLoteClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 96
    Top = 136
  end
  inherited qryConsulta: TUniQuery
    Left = 144
    Top = 136
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 176
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    AfterScroll = cdsConsultaAfterScroll
    Left = 208
    Top = 136
  end
  inherited dtsConsulta: TDataSource
    OnDataChange = dtsConsultaDataChange
    Left = 240
    Top = 136
  end
  object frxSeparacaoWMS: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#65533'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 41995.664529386570000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Begin'
      'End.')
    OnUserFunction = frxSeparacaoWMSUserFunction
    Left = 304
    Top = 248
    Datasets = <
      item
        DataSet = frxPedido
        DataSetName = 'frxPedido'
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
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      Frame.Width = 2.000000000000000000
      object pgHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 236.220472440000000000
        Top = 18.897650000000000000
        Width = 737.008350000000000000
        object memo110: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Width = 483.840000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[<frxEmpresa."NOMEMP">]')
          ParentFont = False
        end
        object NROPG2: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 622.188000000000000000
          Top = 92.610000000000000000
          Width = 109.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
        end
        object memo111: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.134000000000000000
          Top = 88.074000000000000000
          Width = 735.588000000000000000
          Height = 3.780000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          WordWrap = False
        end
        object memo112: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 92.610000000000000000
          Width = 617.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'SEPARA'#199#195'O N'#186' [frxPedido."NUMDOC"] - [frxPedido."ESPDOC"]    [frx' +
              'Pedido."LOCSEP"]')
          ParentFont = False
          WordWrap = False
        end
        object memo113: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 108.864000000000000000
          Width = 83.914120000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          WordWrap = False
        end
        object memo114: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 122.472000000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fantasia:')
          ParentFont = False
          WordWrap = False
        end
        object memo115: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 136.080000000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          WordWrap = False
        end
        object memo116: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 149.688000000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          WordWrap = False
        end
        object memo117: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 163.296000000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          WordWrap = False
        end
        object memo118: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 498.960000000000000000
          Top = 108.864000000000000000
          Width = 49.140000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          WordWrap = False
        end
        object memo119: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 498.960000000000000000
          Top = 136.080000000000000000
          Width = 49.140000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
          WordWrap = False
        end
        object memo120: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 498.960000000000000000
          Top = 149.688000000000000000
          Width = 49.140000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C.E.P.:')
          ParentFont = False
          WordWrap = False
        end
        object memo121: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 498.960000000000000000
          Top = 163.296000000000000000
          Width = 49.140000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE/RG:')
          ParentFont = False
          WordWrap = False
        end
        object memo122: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 498.960000000000000000
          Top = 122.472000000000000000
          Width = 49.140000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
          WordWrap = False
        end
        object memo123: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 15.120000000000000000
          Width = 483.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxEmpresa."ENDERE">  + '#39', '#39' + <frxEmpresa."ENDNUM">  + '#39' '#39' + ' +
              '<frxEmpresa."BAIRRO">]')
          ParentFont = False
          WordWrap = False
        end
        object memo124: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944880000000000
          Top = 108.864000000000000000
          Width = 408.241410000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."NOMCLI">]')
          ParentFont = False
        end
        object memo125: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944880000000000
          Top = 122.472000000000000000
          Width = 408.241410000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."FANSOB">]')
          ParentFont = False
        end
        object memo126: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944880000000000
          Top = 136.080000000000000000
          Width = 408.241410000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."ENDERE">]')
          ParentFont = False
        end
        object memo127: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944880000000000
          Top = 149.688000000000000000
          Width = 408.241410000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."NOMCID">  + '#39'-'#39' + <frxPedido."ESTADO">]')
          ParentFont = False
        end
        object memo128: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 549.990000000000000000
          Top = 136.080000000000000000
          Width = 185.220000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."BAIRRO">]')
          ParentFont = False
        end
        object memo129: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 549.990000000000000000
          Top = 149.688000000000000000
          Width = 185.220000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FormatMaskText('#39'99999-999;0;_'#39' ,<frxPedido."C_E_P_">)]')
          ParentFont = False
        end
        object memo130: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 549.990000000000000000
          Top = 163.296000000000000000
          Width = 185.220000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."IESRGC">]')
          ParentFont = False
        end
        object memo131: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 549.990000000000000000
          Top = 122.472000000000000000
          Width = 185.220000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxPedido."FONE01">)]')
          ParentFont = False
        end
        object memo132: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 549.990000000000000000
          Top = 108.864000000000000000
          Width = 68.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."CODCLI">]')
          ParentFont = False
        end
        object memo133: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944880000000000
          Top = 163.296000000000000000
          Width = 408.241410000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCpfCgc(<frxPedido."CGCCLI">)]')
          ParentFont = False
        end
        object memo134: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 28.728000000000000000
          Width = 483.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxEmpresa."NOMCID">  + '#39' - '#39' + <frxEmpresa."ESTADO">  + '#39' - C' +
              'EP: '#39' + <frxEmpresa."C_E_P_">]')
          ParentFont = False
          WordWrap = False
        end
        object memo135: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 42.336000000000000000
          Width = 200.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '['#39'CNPJ: '#39' + fFormataCpfCgc(<frxEmpresa."C_G_C_">)]')
          ParentFont = False
          WordWrap = False
        end
        object memo136: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 69.552000000000010000
          Width = 200.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '['#39'Fone: '#39' + FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxEmpresa."FO' +
              'NE01">)]')
          ParentFont = False
          WordWrap = False
        end
        object memo137: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 458.136000000000000000
          Top = 42.336000000000000000
          Width = 263.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '['#39'IE: '#39' + <frxEmpresa."I_E_S_">]')
          ParentFont = False
          WordWrap = False
        end
        object memo138: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 458.136000000000000000
          Top = 69.552000000000010000
          Width = 262.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '['#39'Fax: '#39' + FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxEmpresa."F_A' +
              '_X_">)]')
          ParentFont = False
          WordWrap = False
        end
        object memo139: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.102000000000000000
          Top = 55.944000000000000000
          Width = 483.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxEmpresa."EMAIL_">]')
          ParentFont = False
        end
        object memo140: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 176.904000000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond.Pag:')
          ParentFont = False
          WordWrap = False
        end
        object memo141: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944880000000000
          Top = 176.904000000000000000
          Width = 640.440940000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF ( <frxPedido."CONPAG">  = '#39'01000'#39' , '#39'A VISTA'#39' , FormatMaskT' +
              'ext('#39'99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999;0;_'#39' ,<frxPedido."CONPAG' +
              '">)  )]')
          ParentFont = False
          WordWrap = False
        end
        object memo142: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944881889750000
          Top = 190.512000000000000000
          Width = 640.332940000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."CODCND">  + '#39' - '#39' + <frxPedido."DESCND">]')
          ParentFont = False
          WordWrap = False
        end
        object memo143: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 204.120000000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Form.Pag.:')
          ParentFont = False
          WordWrap = False
        end
        object memo144: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.440944881889750000
          Top = 204.120000000000000000
          Width = 640.332940000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."CODFPG">  + '#39' - '#39' + <frxPedido."DESFPG">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 219.212740000000000000
          Width = 85.047650000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Regi'#227'o Cliente:')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 88.497180000000000000
          Top = 219.212740000000000000
          Width = 640.332940000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              '[<frxPedido."CODREG">  + IIF(<frxPedido."CODREG"> <> '#39#39', '#39' - '#39', ' +
              #39#39') + <frxPedido."DESREG">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object headerItens: TfrxHeader
        FillType = ftBrush
        Height = 18.900000000000000000
        Top = 317.480520000000000000
        Width = 737.008350000000000000
        ReprintOnNewPage = True
        object mmoCorHeaderData: TfrxMemoView
          Align = baClient
          Width = 737.008350000000000000
          Height = 18.900000000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
        end
        object memo145: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 242.014000000000000000
          Width = 3.024000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object memo146: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 340.864000000000000000
          Width = 3.024000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object memo147: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 195.000000000000000000
          Top = 2.267999999999972000
          Width = 45.360470000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          WordWrap = False
        end
        object memo148: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 343.180000000000000000
          Top = 2.267999999999972000
          Width = 392.283550000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O / REFER'#202'NCIA')
          ParentFont = False
          WordWrap = False
        end
        object memo149: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 311.064000000000000000
          Top = 2.267999999999972000
          Width = 26.460940000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
        end
        object memo150: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 244.928000000000000000
          Top = 2.267999999999972000
          Width = 59.725880000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          WordWrap = False
        end
        object memo151: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 193.000000000000000000
          Width = 3.000000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object memo152: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.890000000000000000
          Top = 2.267999999999972000
          Width = 81.102350000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCALIZA'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object memo153: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 307.040000000000000000
          Width = 3.024000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 94.826840000000000000
          Top = 2.267999999999972000
          Width = 93.881880000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 89.047310000000000000
          Width = 3.000000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData: TfrxMasterData
        FillType = ftBrush
        Height = 14.360000000000000000
        Top = 359.055350000000000000
        Width = 737.008350000000000000
        Columns = 1
        ColumnWidth = 737.100000000000000000
        DataSet = frxPedido
        DataSetName = 'frxPedido'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 737.008350000000000000
          Height = 14.360000000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = cl3DLight
        end
        object memo154: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 244.928000000000000000
          Width = 59.725880000000000000
          Height = 13.986000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."QTDITE">]')
          ParentFont = False
        end
        object memo155: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 343.936000000000000000
          Width = 389.763760000000000000
          Height = 14.000000000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."DESITE">]')
          ParentFont = False
        end
        object memo156: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 195.000000000000000000
          Width = 45.360470000000000000
          Height = 13.986000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxPedido."CODITE">]')
          ParentFont = False
        end
        object memo157: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 311.000000000000000000
          Width = 26.460940000000000000
          Height = 13.986000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxPedido."SIGUNI">]')
          ParentFont = False
        end
        object memo158: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.890000000000000000
          Width = 81.102350000000000000
          Height = 14.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."LOCFIS">]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 94.826840000000000000
          Width = 93.881880000000000000
          Height = 14.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."NUMLOT">]')
          ParentFont = False
        end
      end
      object PageFooter: TfrxPageFooter
        FillType = ftBrush
        Height = 147.415770000000000000
        Top = 434.645950000000000000
        Width = 737.008350000000000000
        object memo159: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 0.961999999999079600
          Width = 735.588000000000000000
          Height = 4.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          WordWrap = False
        end
        object memo160: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 48.099999999999910000
          Width = 735.588000000000000000
          Height = 3.780000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          WordWrap = False
        end
        object memo161: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 52.100000000000030000
          Width = 68.040000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          WordWrap = False
        end
        object memo162: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 99.099999999999960000
          Width = 68.040000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Mensagem:')
          ParentFont = False
          WordWrap = False
        end
        object memo163: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 52.100000000000030000
          Width = 440.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."CODVEN">  + '#39' - '#39' + <frxPedido."NOMVEN">]')
          ParentFont = False
          WordWrap = False
        end
        object memo164: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 99.099999999999960000
          Width = 657.779530000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."MENEXP">]')
          ParentFont = False
        end
        object memo165: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 113.100000000000000000
          Width = 657.779530000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."MENEX2">]')
          ParentFont = False
        end
        object memo166: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 550.000000000000000000
          Top = 52.100000000000030000
          Width = 33.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data:')
          ParentFont = False
          WordWrap = False
        end
        object memo167: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 586.000000000000000000
          Top = 52.099999999999910000
          Width = 60.480000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."DTAENT">]')
          ParentFont = False
        end
        object memo168: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 685.000000000000000000
          Top = 52.099999999999910000
          Width = 49.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."HORENT">]')
          ParentFont = False
        end
        object memo169: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 650.000000000000000000
          Top = 52.100000000000030000
          Width = 32.886000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
          WordWrap = False
        end
        object memo170: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 447.174000000000000000
          Top = 32.536000000000000000
          Width = 83.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso L'#237'quido:')
          ParentFont = False
          WordWrap = False
        end
        object memo171: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.102000000000000000
          Top = 32.536000000000000000
          Width = 75.978000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Peso Bruto:')
          ParentFont = False
          WordWrap = False
        end
        object memo172: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 32.545999999999990000
          Width = 105.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Quantidade Total:')
          ParentFont = False
          WordWrap = False
        end
        object memo173: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 5.175999999999988000
          Width = 98.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
          WordWrap = False
        end
        object memo174: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 102.816000000000000000
          Top = 5.175999999999931000
          Width = 625.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxPedido."CODTRA">  + '#39' - '#39' + <frxPedido."NOMTRA">  + '#39'  FONE' +
              ': '#39' + FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxPedido."FONTRA">)' +
              ']')
          ParentFont = False
          WordWrap = False
        end
        object memo175: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 108.108000000000000000
          Top = 32.536000000000000000
          Width = 73.000000000000000000
          Height = 15.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[QTDTOT]')
          ParentFont = False
        end
        object memo176: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 325.836000000000000000
          Top = 32.535999999999490000
          Width = 90.720000000000000000
          Height = 15.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PESBRU">]')
          ParentFont = False
        end
        object memo177: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 532.980000000000000000
          Top = 32.535999999999490000
          Width = 90.720000000000000000
          Height = 15.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxPedido."PESLIQ">]')
          ParentFont = False
        end
        object memo178: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 67.100000000000030000
          Width = 68.040000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Digitador:')
          ParentFont = False
          WordWrap = False
        end
        object memo179: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 67.100000000000030000
          Width = 656.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."CODDIG">  + '#39' - '#39' + <frxPedido."NOMDIG">]')
          ParentFont = False
          WordWrap = False
        end
        object memo180: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 18.928000000000000000
          Width = 97.902000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Entrega:')
          ParentFont = False
          WordWrap = False
        end
        object memo181: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 102.816000000000000000
          Top = 18.928000000000000000
          Width = 626.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxPedido."ENDERE">  + '#39' - '#39' + <frxPedido."BAIRRO">  + '#39' - '#39' +' +
              ' <frxPedido."NOMCID">  + '#39' - '#39' + <frxPedido."ESTADO">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 128.606370000000000000
          Width = 68.040000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Local Sep.:')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 128.606370000000000000
          Width = 657.779530000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOCAIS_SEP]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 82.370129999999960000
          Width = 68.040000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Separador:')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 82.370129999999960000
          Width = 656.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxPedido."CODSEP">  + '#39' - '#39' + <frxPedido."NOMSEP">]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxPedido: TfrxDBDataset
    UserName = 'frxPedido'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 440
    Top = 248
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 380
    Top = 248
  end
  object frxSemSal: TfrxDBDataset
    UserName = 'frxSemSal'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 512
    Top = 248
  end
  object ImageList: TImageList
    Left = 640
    Top = 136
    Bitmap = {
      494C010101000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F8D8D00919090009896960096959500929090008F8D8D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F8D
      8D009B9A9A00BEBEBF00BFBEC000B6B6B400B7B3AF00BAB2B200B8B0B0009C98
      98008F8D8D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099999900B5B4
      B400D7D7D800B1AFAB00A8A69900ABABA900A1A2AA00AFA69600A5999300CAB7
      B600B7AAAA008D8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F8D8D00B6B4B500E1DF
      E000ABA8A000D2D0BC00FEF4D900DDCED100BDB7D700FFFFEB00DEDDD5009C94
      8900CAAFAF00B9AAAA008F8D8D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ABA5AB0095BE97003588
      3C00DADDC300FFF7D800F6D5A600F3C69000F3BC8100F3CD9D00FFFCE600F2F6
      F0009B908400D6B6B7009F989800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F8D8D0092A791003DB2560042CE
      6D0067AF6400F9F6CE00FFFAD500FBF1C800F7DAAC00F2C89600F5D29E00FFED
      D300D8D7CE00A9918A00C7B0B000A3999A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008A96890020932E0041D169005AE5
      8A0040CB6B0083C07900FEFFDD00FEFFDD00FDFAD500FFEDBE00FCCC9400F4BF
      8900FFF9E200A3988900D1B2B200A3999A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002082260016A5280032C1500042CD
      66003DBF60001D942F0095C18100C1BCAA0084847C00B1B29A00AB977C00DCAA
      7500DACDD2009897A000D3B2AE00AC9F9F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000458848004C944F001CAB2F0027B9
      43005EA56200CEE2C800D3E7B600C0C0AA005454560041423F0088867600D2A9
      7A00C7BBCE008D8EA000D5B4B000AB9E9E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A99EA800A4BCA4000F991A0011A9
      250073B37700FFFFFF00FFFFF700FFFFDF00DBDBC00067685F00B7AD9200FFDA
      A700FFF2CE00ABA09300D2B3B500A29899000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F8D8D00BCBBBB003298380003A3
      120029973100E5ECE300FFFFFF00FFFFFB00FFFFF000EDEDD6005D5C5300AC9F
      8C00DFDFC700B59F9B00CCB3B300A29899000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A39EA10097BA98000C93
      1600009D0E0041A04600B0D1B200EEF5EF00F8FBF800FFFFFE00F2F2DA00CCD0
      B500B0A89C00D9BABB00A1999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F8D8D00B3ADB20090B8
      92001E9426000090090000880B0012821C002F8B3E00D0E6CE00EDEDE000BCB6
      A900D4B9BA00B2A6A6008F8D8D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000094949300AFAC
      AF00BDC9BD00A0BCA1008AAB870095AE8900A9B89C00C2C1B600C2B7B400D1BC
      BD00B0A5A5009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F8D
      8D00A09D9F00BDB7BC00CAC3C900C5C0C500C1BBBE00BDB5B600B2ACAE009C9A
      9A008F8D8D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F8D8D008F8D8D0093929200949292008F8E8E008F8D8D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F81F000000000000E007000000000000
      C003000000000000800100000000000080010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080010000000000008001000000000000C003000000000000
      E007000000000000F81F00000000000000000000000000000000000000000000
      000000000000}
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 444
    Top = 100
  end
end
