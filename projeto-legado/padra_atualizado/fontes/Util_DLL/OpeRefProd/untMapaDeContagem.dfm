inherited frmMapaDeContagens: TfrmMapaDeContagens
  Width = 1024
  Height = 592
  Caption = 'Mapa de Contagens'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 496
    Top = 292
    Width = 32
    Height = 14
    Caption = 'Label2'
  end
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1018
    ExplicitTop = 519
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object BitBtnLocked1: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 197
        Height = 25
        Caption = 'Imprimir Divergencia de Contagens'
        TabOrder = 0
        OnClick = BitBtnLocked1Click
      end
      object BitBtnLocked2: TBitBtnLocked
        Left = 197
        Top = 0
        Width = 197
        Height = 25
        Caption = 'Imprimir Localiza'#231#245'es Sem Contagem'
        TabOrder = 1
        OnClick = BitBtnLocked2Click
      end
      object btnAtualizaTela: TBitBtnLocked
        Left = 394
        Top = 0
        Width = 127
        Height = 25
        Caption = '[F5]Atualizar Tela'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000002000000070000000700000004000000070000000D0000000F0000
          000F0000000C0000000800000002000000010000000000000000000000000000
          000100000009072C1B95143829950000000E112F227D184732D21E5B40FF1E5C
          41FF184A34D3102F22910204031C000000050000000100000000000000000000
          0004020C0837146744FB2A7B5CFB06100C390C21185D37886AFF39CF9DFF24CA
          92FF23B481FF23966DFF22674CE70A1C14570000000800000001000000010000
          000C0C3E28BF1EB07DFF27B786FF1E523DBF000000161F533FBF5FC6A6FF6FE5
          C2FF59E0B7FF3BDAA8FF28B586FF2E8867FF0D251C650000000600000005051B
          125C1D805AFF28D59EFF28D59EFF2F9671FF0E241B5D07120D362F7D60FA3A8B
          6EFF53AB8EFF65CEADFF42DDADFF2BBA8BFF308062F6040A08220001010F1454
          38E026C592FF2AD7A0FF29D8A1FF2ACC98FF2B7357E101030216020504150409
          072014362A7545987CF95ECFAEFF2DDAA5FF3CAC88FF194434900B2A1C77479D
          7FFF88EDD0FF34DBA8FF2BDAA5FF83ECCFFF60B89CFF19413284000000060000
          000100000007194133815CB699FF30DDA9FF38C79BFF2A7258D4317E61EF3488
          6AFF358A6BFF38D7A7FF30DCA8FF419A7BFF378F70FF36896CF40205040F0000
          000000000002040A081E3F9475FF61E8C2FF50DFB6FF358C6DF2000000070000
          000F1D6749F24DDAB1FF43E2B3FF3F9675FF0205041900000007000000020000
          000000000001040B0820398E6DFF8DF1D8FF98EDD8FF3B997AFA000000000000
          00061E6047D46ECEB2FF8BF1D7FF59B092FF1237287600000005000000010000
          0001000000061138268157A98BFF9AF4DEFF98E1CFFF34856AD3000000000000
          00031642328C6FB8A0FFAAF6E5FF84DFC7FF3D8E6EF90E322275030C0823030C
          08230E3523833A8767FB82D3BCFFB4F9EAFF81CFBAFF2359478A000000000000
          0001030A0719419477F59ADAC9FFB5F8EAFF85D4BDFF54A386FF2D7B59FF2D7B
          59FF56A386FF94E5D0FFBCFAEDFFA5E5D5FF55B295F5050D0A18000000000000
          000000000002123026575CB096FFA6E5D5FFC7FCF2FFBEFBEEFFB8F9EBFFBAF9
          ECFFC1FBEFFFCBFDF3FFAAE7D9FF69C6AAFF173A2F5600000002000000000000
          000000000000000000020F29204450A78CE487D4BFFFB1EADCFFCEF9F1FFCEF9
          F1FFB2EADDFF8AD7C2FF53AB90E3122E26440000000200000000000000000000
          000000000000000000000000000103090710255B4A82399075C849B795FC49B8
          96FC3A9076C8255D4C810409070F000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000020000
          0002000000020000000100000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnAtualizaTelaClick
      end
      object BitBtnLocked3: TBitBtnLocked
        Left = 521
        Top = 0
        Width = 81
        Height = 25
        Caption = 'A'#231#245'es'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = BitBtnLocked3Click
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 938
    end
  end
  inherited pnlStatus: TPanel
    Top = 547
    Width = 1018
    ExplicitTop = 547
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
  object cxgProdutos: TcxGrid [3]
    Left = 0
    Top = 53
    Width = 1018
    Height = 423
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvProdutos: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvProdutosCustomDrawCell
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtto'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Bands = <
        item
          Caption = 'Produto'
          FixedKind = fkLeft
          Width = 381
        end
        item
          Caption = 'Contagens'
          HeaderAlignmentHorz = taLeftJustify
          Width = 64
        end
        item
          Caption = 'A Gravar'
          FixedKind = fkRight
        end>
      object cxvProdutosColumn1: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'BLD_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 56
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvProdutosColumn3: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 254
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvProdutoSALCON: TcxGridDBBandedColumn
        DataBinding.FieldName = 'BLD_EFECON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = ',0.000;-,0.000'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
        IsCaptionAssigned = True
      end
      object cxvProdutosColumn2: TcxGridDBBandedColumn
        Caption = 'Localiza'#231#227'o Fisica'
        DataBinding.FieldName = 'BLG_LOCFIS'
        Options.Editing = False
        Width = 71
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvProdutosStatus: TcxGridDBBandedColumn
        DataBinding.FieldName = 'BLG_STATUS'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvProdutosEmContagem: TcxGridDBBandedColumn
        DataBinding.FieldName = 'EM_CONTAGEM'
        Visible = False
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvProdutosColumn4: TcxGridDBBandedColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 27
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxgProdutosLevel1: TcxGridLevel
      GridView = cxvProdutos
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 53
    Align = alTop
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 425
      Top = 8
      Width = 87
      Height = 14
      Caption = 'Localiza'#231#227'o Inicial'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 721
      Top = 8
      Width = 83
      Height = 14
      Caption = 'Localiza'#231#227'o Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtLocIni: TEditFocus
      Tag = 99
      Left = 425
      Top = 25
      Width = 290
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFin: TEditFocus
      Tag = 99
      Left = 722
      Top = 25
      Width = 290
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgFiltro: TRadioGroup
      Left = 2
      Top = -1
      Width = 415
      Height = 48
      Caption = 'Filtro'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Contagem Finalizada'
        'Contagem Aberta')
      TabOrder = 2
      OnClick = rdgFiltroClick
    end
  end
  object GroupBox1: TGroupBox [5]
    Left = 0
    Top = 476
    Width = 1018
    Height = 43
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 4
    object Label3: TLabel
      Left = 30
      Top = 22
      Width = 99
      Height = 14
      Caption = 'Contagem Finalizada'
    end
    object Shape1: TShape
      Left = 12
      Top = 22
      Width = 14
      Height = 14
      Brush.Color = clMoneyGreen
    end
    object Shape2: TShape
      Left = 176
      Top = 22
      Width = 14
      Height = 14
      Brush.Color = clAqua
    end
    object Label4: TLabel
      Left = 194
      Top = 22
      Width = 65
      Height = 14
      Caption = 'Em Contagem'
    end
    object Shape3: TShape
      Left = 284
      Top = 23
      Width = 14
      Height = 14
      Brush.Color = 13499135
    end
    object Label5: TLabel
      Left = 302
      Top = 23
      Width = 111
      Height = 14
      Caption = 'Aguardando Contagem'
    end
    object Label7: TLabel
      Left = 442
      Top = 22
      Width = 113
      Height = 14
      Caption = 'Contagem Convergente'
    end
    object Shape4: TShape
      Left = 424
      Top = 22
      Width = 14
      Height = 14
      Brush.Color = 10025880
    end
    object Shape5: TShape
      Left = 572
      Top = 22
      Width = 14
      Height = 14
      Brush.Color = 4678655
    end
    object Label8: TLabel
      Left = 590
      Top = 22
      Width = 103
      Height = 14
      Caption = 'Contagem Divergente'
    end
  end
  object dtsProdutos: TDataSource
    Left = 656
    Top = 230
  end
  object mnuAcoes: TPopupMenu
    Left = 640
    Top = 368
    object mnuMarcar: TMenuItem
      Caption = '&Marcar Todos com Contagem Aberta'
      OnClick = mnuMarcarClick
    end
    object mnuDesmarcar: TMenuItem
      Caption = '&Desmarcar Todos com Contagem Aberta'
      OnClick = mnuDesmarcarClick
    end
    object mnuExcluir: TMenuItem
      Caption = '&Excluir Contagens Marcadas'
      OnClick = mnuExcluirClick
    end
  end
end
