inherited frmFatMostraProdSimilar: TfrmFatMostraProdSimilar
  Left = 282
  Top = 185
  Width = 1256
  Height = 340
  HorzScrollBar.Range = 581
  VertScrollBar.Range = 73
  Caption = 'Produtos Similares'
  Position = poMainFormCenter
  ExplicitLeft = -382
  ExplicitWidth = 1256
  ExplicitHeight = 340
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 267
    Width = 1250
    TabOrder = 4
    ExplicitTop = 267
    ExplicitWidth = 1250
    inherited FlwBotoes: TFlowPanel
      Width = 1246
      ExplicitWidth = 1246
    end
    inherited btnSair: TBitBtnLocked
      Left = 557
      ExplicitLeft = 557
    end
  end
  inherited pnlStatus: TPanel
    Top = 295
    Width = 1250
    TabOrder = 2
    ExplicitTop = 295
    ExplicitWidth = 1250
    inherited pnlNomeForm: TPanel
      Left = 1066
      Width = 184
      ExplicitLeft = 1066
      ExplicitWidth = 184
    end
    inherited pnlInfo: TPanel
      Width = 1066
      ExplicitWidth = 1066
    end
  end
  inherited pgcDados: TPageControl
    Top = 37
    Width = 1250
    Height = 230
    TabOrder = 1
    Visible = False
    ExplicitTop = 37
    ExplicitWidth = 1250
    ExplicitHeight = 230
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1242
      ExplicitHeight = 198
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1250
    Height = 37
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 29
      Top = 13
      Width = 22
      Height = 14
      Caption = 'Item:'
    end
    object edtItem: TEditFocus
      Left = 53
      Top = 6
      Width = 612
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBotoesMostra: TPanel [4]
    Left = 0
    Top = 267
    Width = 1250
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      1250
      28)
    object Label2: TLabel
      Left = 506
      Top = 6
      Width = 126
      Height = 16
      Caption = 'Pre'#231'o Promocional:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblPrePro: TLabel
      Left = 638
      Top = 5
      Width = 28
      Height = 17
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnFechar: TBitBtnLocked
      Left = 1168
      Top = 4
      Width = 77
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
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
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object pnlPromo: TPanel
      Left = 1
      Top = 1
      Width = 69
      Height = 26
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 1
      Visible = False
      object shpPromo: TShape
        Left = 3
        Top = 8
        Width = 10
        Height = 10
        Brush.Color = clTeal
      end
      object Label6: TLabel
        Left = 15
        Top = 7
        Width = 48
        Height = 14
        Caption = 'Promo'#231#227'o'
      end
    end
    object btnMostraEstoque: TBitBtnLocked
      Left = 98
      Top = 3
      Width = 182
      Height = 19
      Caption = '[ F6 ] Estoque das Lojas'
      TabOrder = 2
      OnClick = btnMostraEstoqueClick
    end
    object btnCfgGri: TBitBtnLocked
      Left = 1072
      Top = 4
      Width = 91
      Height = 21
      Caption = 'Confi&gurar'
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
      OnClick = btnCfgGriClick
    end
  end
  object cxgItens: TcxGridCitel [5]
    Left = 0
    Top = 37
    Width = 1250
    Height = 230
    Align = alClient
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgItensTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensTableViewCustomDrawCell
      DataController.DataSource = dtsProSim
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object ITE_CODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Width = 60
      end
      object ITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 164
      end
      object ITE_REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
        Width = 78
      end
      object UNI_SIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Width = 28
      end
      object MAR_DESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Width = 97
      end
      object ITE_CODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
        Width = 75
      end
      object ITE_SALDOS: TcxGridDBColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'ITE_SALDOS'
        HeaderAlignmentHorz = taRightJustify
      end
      object ITE_SALDIS: TcxGridDBColumn
        Caption = 'Estoq. Dispon'#237'vel'
        DataBinding.FieldName = 'ITE_SALDIS'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object ITE_PRECUS: TcxGridDBColumn
        Caption = 'Custo'
        DataBinding.FieldName = 'ITE_PRECUS'
        HeaderAlignmentHorz = taRightJustify
        Width = 55
      end
      object ITE_PREVEN: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda'
        DataBinding.FieldName = 'ITE_PREVEN'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
      object ITE_MARBR1: TcxGridDBColumn
        Caption = '%Margem'
        DataBinding.FieldName = 'ITE_MARBR1'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object ITE_PROMOC: TcxGridDBColumn
        Caption = 'Promo'#231#227'o'
        DataBinding.FieldName = 'ITE_PROMOC'
        Visible = False
      end
      object ITE_PREPRO: TcxGridDBColumn
        Caption = 'Pre'#231'o Promo'#231#227'o'
        DataBinding.FieldName = 'ITE_PREPRO'
        Visible = False
      end
      object ITE_SITUAC: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'ITE_SITUAC'
        Options.AutoWidthSizable = False
      end
      object ITE_ESTMIN: TcxGridDBColumn
        Caption = 'Est. M'#237'nimo'
        DataBinding.FieldName = 'ITE_ESTMIN'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object ITE_ESTMAX: TcxGridDBColumn
        Caption = 'Est. M'#225'ximo'
        DataBinding.FieldName = 'ITE_ESTMAX'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 152
  end
  object dtsProSim: TDataSource
    Left = 432
    Top = 192
  end
end
