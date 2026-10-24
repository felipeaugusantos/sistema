inherited frmFatMostraComboProdVenda: TfrmFatMostraComboProdVenda
  Width = 1024
  Height = 684
  Caption = 'Combo de Produtos de Venda'
  ExplicitLeft = -235
  ExplicitWidth = 1024
  ExplicitHeight = 684
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 613
    Width = 1018
    ExplicitTop = 613
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      inherited btnConfirma: TBitBtnLocked
        Width = 121
        Caption = '[ F10 ] &Confirma'
        ExplicitWidth = 121
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 639
    Width = 1018
    ExplicitTop = 639
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
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 10
    Align = alTop
    TabOrder = 3
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 10
    Width = 1018
    Height = 290
    Align = alClient
    TabOrder = 4
    object cxgProCom: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1016
      Height = 288
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgProComView: TcxGridDBBandedTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataModeController.GridMode = True
        DataController.DataSource = dtsProCom
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'PRODUTOS DA COMPOSI'#199#195'O DO COMBO DE VENDA'
            Styles.Header = cxStyle2
            Width = 994
          end>
        Zebra = True
        Destaque = True
        DestacarRegistro = True
        CorZebra = clMoneyGreen
        object MARDES: TcxGridDBBandedColumn
          Caption = 'Sele'#231#227'o'
          DataBinding.FieldName = 'MARDES'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          HeaderAlignmentHorz = taCenter
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 64
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object CODITE: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 54
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object DESITE: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 312
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object REFERE: TcxGridDBBandedColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 178
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object SIGUNI: TcxGridDBBandedColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 43
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgProComNUMLOT: TcxGridDBBandedColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'NUMLOT'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 109
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object QTDITE: TcxGridDBBandedColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 74
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object SITUAC: TcxGridDBBandedColumn
          Caption = 'Situa'#231#227'o'
          DataBinding.FieldName = 'SITUAC'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 73
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object PREVEN: TcxGridDBBandedColumn
          Caption = 'Pre'#231'o de Venda'
          DataBinding.FieldName = 'PREVEN'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 103
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
      end
      object cxgProComLevel: TcxGridLevel
        GridView = cxgProComView
      end
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 583
    Width = 1018
    Height = 30
    Align = alBottom
    TabOrder = 5
    object Label1: TLabel
      Left = 5
      Top = 6
      Width = 243
      Height = 14
      Caption = '[ F3 ] Alternar entre Grids(Combo/Similares)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel4: TPanel [6]
    Left = 0
    Top = 300
    Width = 1018
    Height = 40
    Align = alBottom
    TabOrder = 6
    object btnTroCom: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 283
      Height = 38
      Align = alLeft
      Caption = '[ F4 ] Realiza Troca entre Combo/Similar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Glyph.Data = {
        36100000424D3610000000000000360000002800000020000000200000000100
        2000000000000010000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000010000000300000004000000040000000200000001000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0002000000050000000B000000100000000F0000000800000002000000010000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000100000001000000040000
        000800000012130A053D5F321ABF985830FF0000001000000004000000010000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000010000000100000002000000060000000D0503
        022044261591925938F9C39466FF9A5A33FF0000001600000006000000010000
        0001000000010000000100000001000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000100000002000000040000000A000000132A180E617F4A
        2CE2B6845BFFD9B17FFFDBB682FF9D5E37FF0000001A0000000B000000060000
        0005000000050000000400000003000000020000000100000001000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00010000000100000003000000070000000F130B0737673D24BDAB7650FFD4AC
        7EFFDDB785FFDBB581FFDDB887FF9E613BFF0000002400000019000000160000
        001400000013000000100000000D000000090000000500000003000000010000
        0001000000000000000000000000000000000000000000000000000000000000
        0001000000050000000B0402011A4C2F1D8E9F6945F9CBA276FFE0BD8DFFDDBA
        88FFDDB986FFDCB885FFDEBC8BFFA1653EFF8E5835E7925532FF925531FF804A
        2AE6734226D45F351FB542251586120A0638000000120000000C000000060000
        0003000000010000000100000000000000000000000000000000000000010000
        00050000000E2D1D125A8B5B3AE1C2956DFFE0C092FFE1C08FFFDFBD8CFFDFBC
        8BFFDEBC8AFFDEBB89FFDFBF90FFD4AE80FFD8B384FFDFBD8CFFDEBC8BFFD5AF
        80FFCEA679FFC29468FFAF7B53FF995F39FF6D3F24CA331E116D000000130000
        000B000000050000000200000001000000000000000000000000000000020000
        0009714B31B5BB8F6DFFE3CAA9FFE5C99DFFE1C292FFE1C191FFE1C091FFE0BF
        90FFE0BF8FFFE0BE8DFFE0BD8CFFDFBE8DFFDFBD8CFFDEBB89FFDEBA88FFDDBB
        88FFDDBA87FFDEBA89FFDDBB88FFDDBA89FFC89C70FFA67048FF774629D41C10
        09450000000E0000000600000002000000010000000000000000000000020000
        0008755239B2C29978FFEBDBC6FFF4E7D0FFEEDCB8FFEAD3AAFFEAD2A7FFE9D1
        A6FFE8CEA2FFE7CC9FFFE5C79AFFE3C395FFE0BF8FFFE0BE8DFFE0BD8DFFDFBD
        8CFFDFBC8AFFDEBC8AFFDEBB88FFDDBA87FFDFBA89FFDFBB8BFFC59A6DFF9C62
        3DFC3B2316750000000F00000006000000020000000100000000000000010000
        00040000000D302218569A6F4FDED5B89DFFF4ECD8FFF3E7CEFFEDDAB6FFEBD5
        ACFFEBD5ABFFEBD3ABFFECD7B1FFF1E2C5FFF6ECD7FFF6EBD7FFF4E8D4FFF4E6
        CFFFF2E2C9FFEEDBBCFFE9CFABFFE2C395FFDFBC8BFFDEBB89FFDFBD8CFFD7B0
        83FFA46E48FF452B1A810000000E000000050000000100000000000000000000
        0003000000080000000F0706051E553D2B87B78A68F8E3CDB6FFF7EEDCFFF2E4
        C8FFEEDAB4FFECD7AFFFEDDBB6FFC09572FFC09269FFBA885FFFB7855CFFB988
        61FFC29774FFD0AD8EFFE2CAB0FFF2E4CEFFECD8B7FFE3C598FFE0BE8DFFDFBE
        8DFFDBB98BFFA56F49FF301F135F0000000A0000000300000000000000010000
        000401030310154733AC05100C380000001516100B327D5A40B7C9A383FFEFE2
        CFFFF6EDD9FFF0E2C2FFF0DEBDFFB38059FF271D15490202011702020115251C
        1343302319535B422E8C9C704DE2BE916CFFE1C9AFFFF1DFC5FFE7CCA2FFE1C0
        90FFE1C091FFD3AD81FF925F3DE8040302170000000500000001000000010000
        000713322765358568FF28795CFB113829930705041D0000001434271C59A077
        57E0D8BBA0FFF7EDDDFFF7EDD8FFB6845EFF0000001200000008000000050000
        0006000000080000000B00000010302318539A704EDDD5B598FFF0E0C4FFE6CB
        A1FFE1C394FFE4C698FFB98A64FF3B271A690000000900000002000000020000
        0009286851C062BA9FFF4EC8A2FF379C7BFF1F6147E5112C225F0000000F0403
        02165A433186BD9572F8E6D4BEFFB98963FF0000000D00000004000000010000
        0001000000020000000300000005000000090B08062197704FD5DEC5AAFFEDD9
        B8FFE4C698FFE4C89AFFD4B289FF7C553AC20000000C00000003000000030000
        000B348468EC76D6BBFF3CC297FF43C49CFF45BA95FF2B795DFF000000360000
        00080000000A19130E2E836448B7BD8E67FF0000000900000002000000010000
        000100000002000000020000000200000003000000092D22194DBF946FFFF0DF
        C2FFE5C99DFFE5C99CFFE3C59CFFA1724EEC0000000D00000003000000020000
        000A399374FF84E0C6FF41C59BFF3CC398FF4ECAA5FF277657FF000000190000
        0006000000030000000500000008000000070000000400000001000000010000
        000400000007000000080000000500000004000000060907051BBD8F69FFF2E2
        C7FFE8CEA4FFE6CB9FFFE9D2AAFFB4825BFF0000000D00000003000000020000
        0009368A6CEC84DCC4FF4ECCA6FF3DC49AFF4ECBA5FF2C8263FF081C144C0000
        0008000000030000000200000002000000020000000100000001000000020000
        0008348669FF093420B9020A0630000000090000000821191237C0946FFFEEE2
        CEFFF3E7CFFFECD8B5FFE7D2ADFFAB7F5BEC0000000C00000003000000020000
        00072B7058BF82D1BAFF66D6B7FF3FC79CFF47C9A1FF41AD8AFF1A5B40D8040D
        0929000000070000000400000002000000010000000100000001000000030000
        000A35896BFF5BB396FF175C3FF80727188A070504160000000D3B2D215AA982
        61E2DBC1A5FFF4E9D6FFE5D0B7FF8A694CC00000000900000002000000010000
        000416372B6260B499FF89E3CCFF4DCEA8FF41C89FFF4BCCA6FF389D7CFF1A64
        45E9092117550000000A00000007000000050000000400000003000000060000
        000C368C6DFF7DDDC3FF4AC59EFF30906EFF124C32DF051810570000000F0C0D
        0B20604A368AC19C7CF8CDA98BFF433225630000000600000001000000000000
        00020104030D378D6FE68DD7C3FF76DEC3FF45CBA4FF41C9A1FF4DCEA8FF47B5
        94FF277F5FFF1A6245E60F382888092017510717113C01040313010403150818
        1241378E70FF75DBBEFF3EC49AFF46C79FFF47BB96FF267B5CFF0E3E29B7030B
        082F0000000E332D28467A5C44A90403020E0000000300000001000000000000
        000100000004133127554AA687FF9FE6D3FF76DFC3FF4ACEA7FF42CBA2FF49CD
        A6FF55D0AEFF4ABB98FF389B7AFF2C8666FF247959FF217152FF237354FF287D
        5EFF3FA080FF54CFAAFF3EC59BFF3EC49BFF40C59DFF4ACAA4FF40AC88FF206C
        4EF80C3021870307051A00000009000000050000000200000000000000000000
        000000000002000000051C4638754FAB8EFF9CE2D1FF89E4CDFF56D4B0FF43CC
        A4FF44CBA3FF49CDA7FF50D0ABFF54D1AEFF57D1B0FF59D2B0FF58D2AFFF57D1
        AEFF57D1AEFF56D1ADFF40C79EFF3FC69DFF3FC69DFF3FC69CFF45C89FFF4EC9
        A4FF3A9E7CFF1B5D42DF081D1451000000070000000300000001000000000000
        0000000000000000000200000004193F326947A588FC87D2BDFFA4EBDBFF7FE1
        C8FF55D3B0FF4ED1ACFF56D4B1FF5CD6B5FF60D8B7FF67DABCFF67D9BCFF66D9
        BBFF66D9BBFF5FD6B6FF5AD4B2FF53D0ADFF4BCCA6FF40C89EFF40C79EFF40C7
        9EFF49CAA4FF51C2A1FF3A8D6FFF164A35B10000000400000001000000000000
        0000000000000000000000000001000000040C1F1936338067CB5BB498FF97D8
        C7FFC2F3E9FFB6F1E4FFA1EBDAFF8DE7D1FF82E4CCFF77E1C7FF71DFC3FF7AE1
        C7FF83E3CCFF78E0C6FF70DEC2FF70DDC2FF70DDC2FF6CDBBFFF5DD5B3FF4DCD
        A8FF66D8B6FF88DAC3FF57A98EFF25604BAE0000000400000001000000000000
        000000000000000000000000000000000001000000020000000416382D5C3079
        61BF4DAB8CFF75C2ABFF98D6C5FFB1E5D8FFB9EADEFFCDF6EEFFCDF6EEFFB9E9
        DEFFB0E4D6FFB3F0E3FF7AE3CAFF7AE3CAFF7AE3CAFF7AE3C9FF8CE7D2FFB0ED
        DEFF7BC2ACFF348065DB0F281F4C000000050000000200000001000000000000
        0000000000000000000000000000000000000000000100000001000000020000
        0003081310221C483A722A6A54A8338268CE368A6EDA40A180FF3FA080FF3588
        6DDA3E9F7EFFB9F3E7FF84E7D1FF84E7D1FF8CE9D4FFAEF0E2FF9DD8C7FF4C9F
        83F71C4939800104030C00000003000000010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000010000000200000003000000030000000400000004000000050000
        00073FA181FFC0F4EAFF8FEBD8FFAAF1E1FFB6E9DEFF68B69EFF2A6B54B10712
        0F23000000040000000200000001000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000001000000010000000100000001000000020000
        000440A483FFCCF8F0FFC1F4EAFF8ACCB9FF3A8C71DD122D244C000000040000
        0002000000010000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        000342A686FFADE0D3FF53AA8EF7205041810104030A00000002000000010000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000243A887FF2E745DB209151224000000020000000100000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000010000000100000001000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      TabOrder = 0
      OnClick = btnTroComClick
      ExplicitLeft = 0
      ExplicitTop = 2
      ExplicitHeight = 37
    end
    object btnInverterSelecao: TBitBtnLocked
      AlignWithMargins = True
      Left = 285
      Top = 2
      Width = 114
      Height = 36
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = '[F5] Inverter sele'#231#227'o'
      TabOrder = 1
      OnClick = btnInverterSelecaoClick
      ExplicitLeft = 287
      ExplicitTop = 10
      ExplicitHeight = 20
    end
    object btnMarcarTodos: TBitBtnLocked
      AlignWithMargins = True
      Left = 401
      Top = 2
      Width = 114
      Height = 36
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = '[F6] Marcar todos'
      TabOrder = 2
      OnClick = btnMarcarTodosClick
      ExplicitLeft = 501
      ExplicitTop = 4
    end
    object btnDesmarcarTodos: TBitBtnLocked
      AlignWithMargins = True
      Left = 517
      Top = 2
      Width = 114
      Height = 36
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = '[F7] Desmarcar todos'
      TabOrder = 3
      OnClick = btnDesmarcarTodosClick
      ExplicitLeft = 633
      ExplicitTop = 0
    end
  end
  object Panel5: TPanel [7]
    Left = 0
    Top = 340
    Width = 1018
    Height = 243
    Align = alBottom
    TabOrder = 7
    object cxgProSim: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1016
      Height = 241
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgProSimView: TcxGridDBBandedTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsProSim
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Styles.Header = cxStyle1
        Bands = <
          item
            Caption = 
              'PRODUTOS QUE PODEM SER TROCADOS PELO PRODUTO DA COMPOSI'#199#195'O DO CO' +
              'MBO DE VENDA'
            Styles.Header = cxStyle2
            Width = 991
          end>
        Zebra = True
        Destaque = True
        DestacarRegistro = True
        CorZebra = clMoneyGreen
        object cxGridDBBandedColumn2: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 78
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn3: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 372
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn4: TcxGridDBBandedColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 239
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn5: TcxGridDBBandedColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 59
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgProSimNUMLOT: TcxGridDBBandedColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'NUMLOT'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle1
          Width = 109
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn6: TcxGridDBBandedColumn
          Caption = 'Pre'#231'o de Venda'
          DataBinding.FieldName = 'PREVEN'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Width = 134
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object cxgProSimLevel: TcxGridLevel
        GridView = cxgProSimView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 120
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 512
    Top = 80
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
    end
  end
  object dtsProCom: TDataSource
    Left = 408
    Top = 137
  end
  object dtsProSim: TDataSource
    Left = 376
    Top = 449
  end
end
