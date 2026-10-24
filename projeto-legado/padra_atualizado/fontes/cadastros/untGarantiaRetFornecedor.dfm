inherited frmGarantiaRetFornecedor: TfrmGarantiaRetFornecedor
  Left = 208
  Top = 105
  Width = 1253
  Height = 637
  Caption = 'Retorno do Fornecedor'
  Position = poMainFormCenter
  ExplicitWidth = 1253
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 564
    Width = 1247
    TabOrder = 3
    ExplicitTop = 564
    ExplicitWidth = 1247
    DesignSize = (
      1247
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1243
      ExplicitWidth = 1243
      object btnConfirmar: TBitBtnLocked
        Tag = 99
        Left = 0
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F10 ] Confirmar Retorno'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarcaDesmarcaItem: TBitBtnLocked
        Left = 130
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F5] Marca/Desmarca Item'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnMarcaDesmarcaItemClick
      end
      object btnMarcaDesmarcaTodos: TBitBtnLocked
        Left = 280
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F6] Marca/Desmarca Todos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnMarcaDesmarcaTodosClick
      end
      object btnRetornoTotal: TBitBtnLocked
        Left = 430
        Top = 0
        Width = 130
        Height = 22
        Caption = '[F8] Retorno Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnRetornoTotalClick
      end
      object btnRefugoTotal: TBitBtnLocked
        Left = 560
        Top = 0
        Width = 130
        Height = 22
        BiDiMode = bdLeftToRight
        Caption = '[F9] Refugo Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnRefugoTotalClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1165
      Width = 80
      ExplicitLeft = 1165
      ExplicitWidth = 80
    end
  end
  inherited pnlStatus: TPanel
    Top = 592
    Width = 1247
    TabOrder = 2
    ExplicitTop = 592
    ExplicitWidth = 1247
    inherited pnlNomeForm: TPanel
      Left = 1076
      ExplicitLeft = 1076
    end
    inherited pnlInfo: TPanel
      Width = 1076
      ExplicitWidth = 1076
    end
  end
  object pnlFornecedor: TPanel [2]
    Left = 0
    Top = 0
    Width = 1247
    Height = 65
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 33
      Width = 1245
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 11
        Top = 8
        Width = 56
        Height = 14
        AutoSize = False
        Caption = 'Fornecedor:'
      end
      object Label2: TLabel
        Left = 804
        Top = 8
        Width = 39
        Height = 14
        AutoSize = False
        Caption = 'Per'#237'odo:'
      end
      object Label3: TLabel
        Left = 918
        Top = 8
        Width = 10
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = #224
      end
      object edtNomFor: TEditFocus
        Left = 142
        Top = 4
        Width = 654
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = 16768952
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 71
        Top = 4
        Width = 68
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 1
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
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 844
        Top = 4
        Width = 69
        Height = 22
        AutoSize = False
        EditMask = '!99/99/9999;1;'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
        OnExit = mskDtaIniExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 932
        Top = 4
        Width = 70
        Height = 22
        AutoSize = False
        EditMask = '!99/99/9999;1;'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
        OnExit = mskDtaFinExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object pnlSelXML: TPanel
      Left = 1
      Top = 1
      Width = 1245
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      Visible = False
      object Label4: TLabel
        Left = 10
        Top = 8
        Width = 216
        Height = 14
        Caption = 'Documento de Retorno do Fornecedor(XML):'
      end
      object btnNotEle: TBitBtnLocked
        Left = 226
        Top = 5
        Width = 41
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
          300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
          330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
          333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
          339977FF777777773377000BFB03333333337773FF733333333F333000333333
          3300333777333333337733333333333333003333333333333377333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnNotEleClick
      end
      object edtNotEle: TEditFocus
        Left = 267
        Top = 5
        Width = 529
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
  end
  object pnlObs: TPanel [3]
    Left = 0
    Top = 412
    Width = 1247
    Height = 152
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 1
    object lblObs_01: TLabel
      Left = 11
      Top = 9
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs 1:'
    end
    object lblObs_02: TLabel
      Left = 11
      Top = 33
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs 2:'
    end
    object lblObs_03: TLabel
      Left = 11
      Top = 57
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs 3:'
    end
    object lblObs_04: TLabel
      Left = 11
      Top = 81
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs 4:'
    end
    object lblObs_05: TLabel
      Left = 11
      Top = 105
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs 5:'
    end
    object lblMotivo: TLabel
      Left = 9
      Top = 129
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object dbeObsF_2: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 29
      Width = 955
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_2'
      DataSource = dtsProdutos
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeObsF_1: TDBEditFocus
      Left = 44
      Top = 5
      Width = 955
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_1'
      DataSource = dtsProdutos
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeObsF_4: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 77
      Width = 955
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_4'
      DataSource = dtsProdutos
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeObsF_3: TDBEditFocus
      Left = 44
      Top = 53
      Width = 955
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_3'
      DataSource = dtsProdutos
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeObsF_5: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 101
      Width = 955
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OBSF_5'
      DataSource = dtsProdutos
      Enabled = False
      TabOrder = 4
      OnExit = dbeObsF_5Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMotivo: TDBEditFocus
      Tag = 99
      Left = 44
      Top = 125
      Width = 955
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'MOTIVO'
      DataSource = dtsProdutos
      Enabled = False
      TabOrder = 5
      OnExit = dbeMotivoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 65
    Width = 1247
    Height = 347
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 4
    object splSeparador: TSplitter
      Left = 1
      Top = 161
      Width = 1245
      Height = 4
      Cursor = crVSplit
      Align = alTop
      Color = clYellow
      ParentColor = False
      Visible = False
      ExplicitLeft = -23
      ExplicitTop = 167
    end
    object dbgProduto: TcxGridCitel
      Left = 1
      Top = 165
      Width = 1245
      Height = 159
      Align = alClient
      TabOrder = 0
      OnEnter = dbgProdutoEnter
      LookAndFeel.ScrollbarMode = sbmClassic
      object TcxGridDBBandedTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        Bands = <
          item
          end>
        Zebra = False
        Destaque = False
        DestacarRegistro = False
        CorZebra = clMoneyGreen
      end
      object dbgProdutoDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
        OnKeyDown = dbgProdutoDBBandedTableViewCitel1KeyDown
        OnKeyPress = dbgProdutoDBBandedTableViewCitel1KeyPress
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgProdutoDBBandedTableViewCitel1CustomDrawCell
        DataController.DataSource = dtsProdutos
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Bands = <
          item
          end
          item
            Caption = 'Digitado'
          end
          item
          end>
        Zebra = False
        Destaque = False
        DestacarRegistro = False
        CorZebra = clMoneyGreen
        object dbgProdutoViewSELECIONADO: TcxGridDBBandedColumn
          DataBinding.FieldName = 'SELECIONADO'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object dbgProdutoViewNUMENV: TcxGridDBBandedColumn
          Caption = 'N'#186' do Envio'
          DataBinding.FieldName = 'NUMENV'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object dbgProdutoViewNUMPED: TcxGridDBBandedColumn
          Caption = 'N'#186' do Pedido'
          DataBinding.FieldName = 'NUMPED'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object dbgProdutoViewNUMENT: TcxGridDBBandedColumn
          Caption = 'N'#186' Garantia'
          DataBinding.FieldName = 'NUMENT'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object dbgProdutoViewCODITE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 70
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object dbgProdutoViewDESITE: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 300
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object dbgProdutoViewUNIDAD: TcxGridDBBandedColumn
          DataBinding.FieldName = 'UNIDAD'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object dbgProdutoViewREFERE: TcxGridDBBandedColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object dbgProdutoViewQTDREQ: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDREQ'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object dbgProdutoViewQTDRET: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDRET'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object dbgProdutoViewQTDREF: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDREF'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object dbgProdutoViewQTDRET_1: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDRET_1'
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object dbgProdutoViewQTDREF_1: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDREF_1'
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object dbgProdutoViewCODFAB: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CODFAB'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ReadOnly = True
          Properties.OnButtonClick = dbgProdutoViewCODFABPropertiesButtonClick
          OnGetProperties = dbgProdutoViewCODFABGetProperties
          Options.ShowEditButtons = isebAlways
          Width = 70
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object dbgProdutoDBBandedTableViewDET_UNITAR: TcxGridDBBandedColumn
          Caption = 'Vr. Unit. Envio Forn.'
          DataBinding.FieldName = 'DET_UNITAR'
          Options.Editing = False
          Width = 100
          Position.BandIndex = 0
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object dbgProdutoViewCodBAr: TcxGridDBBandedColumn
          Caption = 'C'#243'd. Barras'
          DataBinding.FieldName = 'CODBAR'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object dbgProdutoViewBaremb: TcxGridDBBandedColumn
          Caption = 'C'#243'd. Embalagem'
          DataBinding.FieldName = 'BAREMB'
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object dbgProdutoViewQTDSKU: TcxGridDBBandedColumn
          DataBinding.FieldName = 'QTDSKU'
          Visible = False
          Options.Editing = False
          Position.BandIndex = 0
          Position.ColIndex = 14
          Position.RowIndex = 0
        end
      end
      object dbgProdutoLevel1: TcxGridLevel
        GridView = dbgProdutoDBBandedTableViewCitel1
      end
    end
    object pnlSubGridProdutos: TPanel
      Left = 1
      Top = 324
      Width = 1245
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlSubGridProdutos'
      ShowCaption = False
      TabOrder = 2
      object btnConfiguraDadosAtuais: TBitBtnLocked
        Left = 1215
        Top = 0
        Width = 30
        Height = 22
        Align = alRight
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
        TabOrder = 0
        OnClick = btnConfiguraDadosAtuaisClick
      end
    end
    object pnlItensNfe: TPanel
      Left = 1
      Top = 1
      Width = 1245
      Height = 160
      Align = alTop
      Caption = 'pnlItensNfe'
      TabOrder = 1
      Visible = False
      object cxItens: TcxGridCitel
        Left = 1
        Top = 1
        Width = 1243
        Height = 142
        Align = alClient
        TabOrder = 0
        Visible = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvItens: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxvItensCustomDrawCell
          DataController.DataSource = dtsitensNf
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
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxvItensITE_CODITE: TcxGridDBColumn
            Caption = 'C'#243'd. Item'
            DataBinding.FieldName = 'ITE_CODITE'
            Options.Editing = False
            Width = 59
          end
          object cxvItensITE_DESITE: TcxGridDBColumn
            Caption = 'Desri'#231#227'o do Item'
            DataBinding.FieldName = 'ITE_DESITE'
            Options.Editing = False
            Width = 410
          end
          object cxvItensITE_QTDXML: TcxGridDBColumn
            Caption = 'Qtd. NFE'
            DataBinding.FieldName = 'ITE_QTDXML'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
          end
          object cxvItensITE_QTDRET: TcxGridDBColumn
            Caption = 'Retorno'
            DataBinding.FieldName = 'ITE_QTDRET'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            VisibleForEditForm = bTrue
            Width = 100
          end
          object cxvItensITE_QTDREF: TcxGridDBColumn
            Caption = 'Refugo'
            DataBinding.FieldName = 'ITE_QTDREF'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            VisibleForEditForm = bTrue
            Width = 100
          end
          object cxvItensDIVERGENTE: TcxGridDBColumn
            DataBinding.FieldName = 'DIVERGENTE'
            Visible = False
          end
        end
        object cxlItens: TcxGridLevel
          GridView = cxvItens
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 143
        Width = 1243
        Height = 16
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Shape1: TShape
          Left = 3
          Top = 2
          Width = 14
          Height = 14
          Brush.Color = clMoneyGreen
        end
        object Label5: TLabel
          Left = 23
          Top = 1
          Width = 153
          Height = 14
          Caption = 'Itens com distribui'#231#227'o conclu'#237'da'
        end
        object Shape2: TShape
          Left = 195
          Top = 2
          Width = 14
          Height = 14
          Brush.Color = 9234160
        end
        object Label6: TLabel
          Left = 215
          Top = 2
          Width = 164
          Height = 14
          Caption = 'Itens com distribui'#231#227'o divergentes'
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 633
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 112
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'UNIDAD'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'QTDREQ'
        DataType = ftFloat
      end
      item
        Name = 'QTDRET'
        DataType = ftFloat
      end
      item
        Name = 'QTDRET_1'
        DataType = ftFloat
      end
      item
        Name = 'QTDREF_1'
        DataType = ftFloat
      end
      item
        Name = 'QTDREF'
        DataType = ftFloat
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'OBSF_1'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'OBSF_2'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'OBSF_3'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'OBSF_4'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'OBSF_5'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODVEN'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CODCLI'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'CODFOR'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'REFERE'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'MOTIVO'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'NUMENV'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'ITEFRA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMPED'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'NUMENT'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'INCGAE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VALITE'
        DataType = ftCurrency
      end
      item
        Name = 'VALUNT'
        DataType = ftCurrency
      end
      item
        Name = 'INCGAG'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SELECIONADO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODFAB'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CODBAR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QTDSKU'
        DataType = ftInteger
      end
      item
        Name = 'BAREMB'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'INCDET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DET_UNITAR'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsProdutosBeforePost
    AfterPost = cdsProdutosAfterPost
    AfterCancel = cdsProdutosAfterCancel
    AfterScroll = cdsProdutosAfterScroll
    Left = 663
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
      DisplayLabel = 'Enviado'
      FieldName = 'QTDREQ'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDRET: TFloatField
      DisplayLabel = 'Retorno'
      FieldName = 'QTDRET'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDRET_1: TFloatField
      DisplayLabel = 'Retorno'
      FieldName = 'QTDRET_1'
      OnValidate = cdsProdutosQTDRET_1Validate
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDREF_1: TFloatField
      DisplayLabel = 'Refugo'
      FieldName = 'QTDREF_1'
      OnValidate = cdsProdutosQTDREF_1Validate
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosQTDREF: TFloatField
      DisplayLabel = 'Refugo'
      FieldName = 'QTDREF'
      DisplayFormat = '#,##0.00'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
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
    object cdsProdutosREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsProdutosMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 70
    end
    object cdsProdutosNUMENV: TStringField
      DisplayWidth = 16
      FieldName = 'NUMENV'
      Size = 16
    end
    object cdsProdutosITEFRA: TStringField
      FieldName = 'ITEFRA'
      Size = 1
    end
    object cdsProdutosNUMPED: TStringField
      FieldName = 'NUMPED'
      Size = 16
    end
    object cdsProdutosNUMENT: TStringField
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsProdutosINCGAE: TStringField
      FieldName = 'INCGAE'
    end
    object cdsProdutosVALITE: TCurrencyField
      FieldName = 'VALITE'
    end
    object cdsProdutosVALUNT: TCurrencyField
      FieldName = 'VALUNT'
    end
    object cdsProdutosINCGAG: TStringField
      FieldName = 'INCGAG'
    end
    object cdsProdutosSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsProdutosCODFAB: TStringField
      DisplayLabel = 'C'#243'd. F'#225'brica'
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsProdutosINCDET: TStringField
      FieldName = 'INCDET'
    end
    object cdsProdutosDET_UNITAR: TCurrencyField
      DefaultExpression = '0'
      FieldName = 'DET_UNITAR'
      DisplayFormat = '#0.00'
    end
    object cdsProdutosCODBAR: TStringField
      FieldName = 'CODBAR'
    end
    object cdsProdutosBAREMB: TStringField
      FieldName = 'BAREMB'
    end
    object cdsProdutosQTDSKU: TIntegerField
      FieldName = 'QTDSKU'
    end
    object cdsProdutosAGG_QTDRET_1: TAggregateField
      FieldName = 'AGG_QTDRET_1'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDRET_1)'
    end
    object cdsProdutosAGG_QTDREF_1: TAggregateField
      FieldName = 'AGG_QTDREF_1'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDREF_1)'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    OnDataChange = dtsProdutosDataChange
    Left = 693
    Top = 88
  end
  object frxDBGarantiaRF: TfrxDBDataset
    UserName = 'frxDBGarantiaRF'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODITE=CODITE'
      'DESITE=DESITE'
      'UNIDAD=UNIDAD'
      'QTDREQ=QTDREQ'
      'QTDRET=QTDRET'
      'QTDRET_1=QTDRET_1'
      'QTDREF_1=QTDREF_1'
      'QTDREF=QTDREF'
      'AUTINC=AUTINC'
      'OBSF_1=OBSF_1'
      'OBSF_2=OBSF_2'
      'OBSF_3=OBSF_3'
      'OBSF_4=OBSF_4'
      'OBSF_5=OBSF_5'
      'NUMENT=NUMENT'
      'CODVEN=CODVEN'
      'CODCLI=CODCLI'
      'CODFOR=CODFOR'
      'REFERE=REFERE'
      'MOTIVO=MOTIVO'
      'NUMENV=NUMENV'
      'VALITE=VALITE'
      'ITEFRA=ITEFRA'
      'AGG_QTDRET_1=AGG_QTDRET_1'
      'AGG_QTDREF_1=AGG_QTDREF_1')
    DataSource = dtsProdutos
    BCDToCurrency = False
    Left = 632
    Top = 128
  end
  object frxDocRetornoJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40114.449667604200000000
    ReportOptions.LastChange = 40148.499110000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbDetalheOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '   If <frxDBGarantiaRF."OBSF_1"> = '#39#39' Then'
      '        Child1.Visible := False'
      '   Else Child1.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_2"> = '#39#39' Then'
      '        Child2.Visible := False'
      '   Else Child2.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_3"> = '#39#39' Then'
      '        Child3.Visible := False'
      '   Else Child3.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_4"> = '#39#39' Then'
      '        Child4.Visible := False'
      '   Else Child4.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_5"> = '#39#39' Then'
      '        Child5.Visible := False'
      '   Else Child5.Visible := True;'
      ''
      
        '   if ((BAIXAR = '#39'S'#39') And (<frxDBGarantiaRF."MOTIVO"> <> '#39#39')) Th' +
        'en'
      '     Child1.Visible := True;       '
      'end;'
      '  '
      'procedure rllNomRelOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '    rllNomRel.Text := '#39'CONTROLE DE BAIXA DE FORNECEDOR'#39
      '  Else'
      
        '    rllNomRel.Text := '#39'CONTROLE DE RETORNO DE FORNECEDOR'#39';      ' +
        '  '
      'end;'
      ''
      'procedure Memo12OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '    Memo12.Text := '#39'Baixa'#39
      '  Else'
      '    Memo12.Text := '#39'Retorno'#39';          '
      'end;'
      ''
      'procedure rlbCabecalhoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo3.Visible := (BAIXAR = '#39'N'#39');  '
      'end;'
      ''
      'procedure Memo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then  '
      '    Memo1.Text := '#39'Data da Baixa: '#39
      '  Else              '
      '    Memo1.Text := '#39'Data de Retorno: '#39';      '
      '  '
      'end;'
      ''
      'procedure Memo4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '    Memo4.Text := '#39'Total de Itens Baixados: [TOTQTD]'#39'  '
      '  Else'
      '    Memo4.Text := '#39'Total de Itens Retornados: [TOTQTD]'#39';    '
      'end;'
      ''
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '  Begin'
      '    Memo15.Text := '#39'MOT:'#39';           '
      '    Memo20.Text := '#39'[frxDBGarantiaRF."MOTIVO"]'#39';      '
      '  end;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 664
    Top = 128
    Datasets = <
      item
        DataSet = frxDBGarantiaRF
        DataSetName = 'frxDBGarantiaRF'
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
        Height = 39.685034490000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbCabecalhoOnBeforePrint'
        Stretched = True
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 120.944960000000000000
          Width = 476.220780000000000000
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
          Left = 194.645795000000000000
          Top = 15.118120000000000000
          Width = 328.819110000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'rllNomRelOnBeforePrint'
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE RETORNO DO FORNECEDOR')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 524.354670000000000000
          Top = 15.118120000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
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
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        object Shape1: TfrxShapeView
          Top = 29.574829999999990000
          Width = 718.110236220000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDoc: TfrxMemoView
          Left = 614.173618900000000000
          Top = 30.574830000000000000
          Width = 91.842519690000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Refugo')
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
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'Item')
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559059999999988000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Retorno:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 117.165430000000000000
          Top = 7.559060000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 445.984540000000000000
          Top = 7.559060000000000000
          Width = 268.346630000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo4OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total de Itens Retornados: [TOTQTD]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 517.795610000000000000
          Top = 30.236240000000010000
          Width = 91.842519690000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Retorno')
        end
        object Memo14: TfrxMemoView
          Left = 419.527830000000000000
          Top = 30.236240000000010000
          Width = 91.842519690000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo12OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Enviado')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 468.661720000000000000
        Width = 718.110700000000000000
        object Memo10: TfrxMemoView
          Top = 64.252010000000150000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
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
            'Fornecedor: [NOMFOR]')
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
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'rlbDetalheOnAfterPrint'
        Child = frxDocRetornoJ.Child1
        DataSet = frxDBGarantiaRF
        DataSetName = 'frxDBGarantiaRF'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 5.559060000000000000
          Top = 1.779529999999994000
          Width = 69.165354330000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBGarantiaRF."CODITE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 83.039428660000000000
          Top = 1.779530000000000000
          Width = 326.173394330000000000
          Height = 15.118120000000000000
          DataField = 'DESITE'
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaRF."DESITE"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 615.953158660000000000
          Top = 1.779530000000000000
          Width = 91.842534330000000000
          Height = 15.118120000000000000
          DataField = 'QTDREF_1'
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
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
            '[frxDBGarantiaRF."QTDREF_1"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 517.795610000000000000
          Top = 1.779530000000000000
          Width = 91.842534330000000000
          Height = 15.118120000000000000
          DataField = 'QTDRET_1'
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
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
            '[frxDBGarantiaRF."QTDRET_1"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 419.527830000000000000
          Top = 1.779530000000000000
          Width = 91.842534330000000000
          Height = 15.118120000000000000
          DataField = 'QTDREQ'
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
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
            '[frxDBGarantiaRF."QTDREQ"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        Child = frxDocRetornoJ.Child2
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
            '[frxDBGarantiaRF."OBSF_1"]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 279.685220000000000000
        Width = 718.110700000000000000
        Child = frxDocRetornoJ.Child3
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
            '[frxDBGarantiaRF."OBSF_2"]')
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 317.480520000000000000
        Width = 718.110700000000000000
        Child = frxDocRetornoJ.Child4
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
          Top = 0.000000000000056843
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaRF."OBSF_3"]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        Child = frxDocRetornoJ.Child5
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
          Top = 0.000000000000056843
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaRF."OBSF_4"]')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 393.071120000000000000
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
          Top = 0.000000000000056843
          Width = 585.827150000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGarantiaRF."OBSF_5"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDocRetornoM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40114.742711944400000000
    ReportOptions.LastChange = 42129.748395277780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '   If (<frxDBGarantiaRF."OBSF_1"> = '#39#39') Then'
      '        Child1.Visible := False'
      '   Else Child1.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_2"> = '#39#39' Then'
      '        Child2.Visible := False'
      '   Else Child2.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_3"> = '#39#39' Then'
      '        Child3.Visible := False'
      '   Else Child3.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_4"> = '#39#39' Then'
      '        Child4.Visible := False'
      '   Else Child4.Visible := True;'
      ''
      '   If <frxDBGarantiaRF."OBSF_5"> = '#39#39' Then'
      '        Child5.Visible := False'
      '   Else Child5.Visible := True;'
      ''
      
        '   if ((BAIXAR = '#39'S'#39') And (<frxDBGarantiaRF."MOTIVO"> <> '#39#39')) Th' +
        'en'
      '     Child1.Visible := True;  '
      '     '
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '    DMPMemo2.Text := '#39'CONTROLE DE BAIXA DE FORNECEDOR'#39
      '  Else'
      '    DMPMemo2.Text := '#39'CONTROLE DE RETORNO DE FORNECEDOR'#39';'
      '                                 '
      'end;'
      ''
      'procedure DMPMemo17OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '    DMPMemo17.Text := '#39'Baixa'#39
      '  Else'
      '    DMPMemo17.Text := '#39'Retorno'#39';'
      '      '
      'end;'
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo3.Visible := (BAIXAR = '#39'N'#39');  '
      'end;'
      ''
      'procedure DMPMemo4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then  '
      '    DMPMemo4.Text := '#39'Data da Baixa: '#39
      '  Else              '
      '    DMPMemo4.Text := '#39'Data de Retorno: '#39';        '
      'end;'
      ''
      'procedure DMPMemo6OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '    DMPMemo6.Text := '#39'Total de Itens Baixados: [TOTQTD]'#39'  '
      '  Else'
      
        '    DMPMemo6.Text := '#39'Total de Itens Retornados: [TOTQTD]'#39';     ' +
        ' '
      'end;'
      ''
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if BAIXAR = '#39'S'#39' Then'
      '  Begin'
      '    DMPMemo22.Text := '#39'MOT:'#39';           '
      '    DMPMemo21.Text := '#39'[frxDBGarantiaRF."MOTIVO"]'#39';      '
      '  end;            '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 696
    Top = 128
    Datasets = <
      item
        DataSet = frxDBGarantiaRF
        DataSetName = 'frxDBGarantiaRF'
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
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        Stretched = True
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 96.000000000000000000
          Width = 556.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo2OnBeforePrint'
          StretchMode = smMaxHeight
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTROLE DE RETORNO DO FORNECEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
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
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo4OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data de Retorno:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo6OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Itens Retornados: [TOTQTD]')
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
            'Refugo')
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
            'Retorno')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo17OnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Enviado')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 748.800000000000000000
        OnAfterPrint = 'MasterData1OnAfterPrint'
        Child = frxDocRetornoM.Child1
        DataSet = frxDBGarantiaRF
        DataSetName = 'frxDBGarantiaRF'
        RowCount = 0
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaRF."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaRF."DESITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaRF."QTDREF_1"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaRF."QTDRET_1"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBGarantiaRF
          DataSetName = 'frxDBGarantiaRF'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBGarantiaRF."QTDREQ"]')
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
            'Fornecedor: [NOMFOR]')
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 748.800000000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        Child = frxDocRetornoM.Child2
        object DMPMemo21: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBGarantiaRF."OBSF_1"]')
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
        Child = frxDocRetornoM.Child3
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
            '[frxDBGarantiaRF."OBSF_2"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 748.800000000000000000
        Child = frxDocRetornoM.Child4
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
            '[frxDBGarantiaRF."OBSF_3"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 748.800000000000000000
        Child = frxDocRetornoM.Child5
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
            '[frxDBGarantiaRF."OBSF_4"]')
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
            '[frxDBGarantiaRF."OBSF_5"]')
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
    Left = 600
    Top = 128
  end
  object dtsitensNf: TDataSource
    Left = 1160
    Top = 80
  end
  object cxEditRepository1: TcxEditRepository
    Left = 496
    Top = 105
    PixelsPerInch = 96
    object cxEditButtonItemVisible: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
    end
    object cxEditButtonItemInvisible: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
    end
  end
end
