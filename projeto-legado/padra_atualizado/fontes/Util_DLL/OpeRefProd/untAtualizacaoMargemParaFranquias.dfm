inherited frmAtualizacaoMargemParaFranquias: TfrmAtualizacaoMargemParaFranquias
  Width = 1024
  Height = 507
  Caption = 'Atualiza'#231#227'o de Margem para Franquias'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 434
    Width = 1018
    TabOrder = 2
    ExplicitTop = 434
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnExport: TSpeedButton
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Exportar'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000004C543C81000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000097A776FF4C543C810000000000000000000000000000
          00007E4C69B7AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000097A7
          76FF97A776FF97A776FF97A776FF97A776FF4C543C8100000000000000000000
          0000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000097A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF4B533A7E000000000000
          0000AF6A93FFAF6A93FF000000000000000000000000000000000000000097A7
          76FF97A776FF97A776FF97A776FF97A776FF4B533A7E00000000000000000000
          0000AF6A93FFAF6A93FF00000000000000000000000000000000000000000000
          0000000000000000000097A776FF4B533A7E0000000000000000000000000000
          0000AF6A93FFAF6A93FF00000000000000000000000000000000000000000000
          000000000000000000004B533A7E000000000000000000000000000000000000
          0000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000000000000000000000000
          0000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000000000000000000000000
          0000AF6A93FFAF6A93FF00000000000000000000000000000000000000000000
          00000000000000000000AF6A93FFAF6A93FF0000000000000000000000000000
          0000AF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FF00000000AF6A93FFAF6A93FF0000000000000000000000000000
          0000AF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000
          0000AF6A93FF00000000AF6A93FFAF6A93FF0000000000000000000000000000
          0000AF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000
          0000AF6A93FF00000000AF6A93FFAF6A93FF0000000000000000000000000000
          0000824F6DBDAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FF00000000AF6A93FF824F6DBD0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        OnClick = btnExportClick
      end
      object BtnImport: TSpeedButton
        Left = 90
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Importar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF000000000000000000000000000000000000
          0000848484FF0000000000000000000000000000000000000000000000000000
          00000000000000000000848484FF000000000000000000000000000000000000
          0000000000000000000000000000000000003827174DB8824DFF3827174D0000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
          174D000000000000000000000000000000000000000000000000000000000000
          000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFF3827174D0000000000000000000000000000000000000000000000000000
          0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
          4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
          00003827174DB8824DFFB8824DFF3827174DB8824DFFB8824DFFB8824DFF3827
          174DB8824DFFB8824DFF3827174D000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        OnClick = BtnImportClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 462
    Width = 1018
    TabOrder = 3
    ExplicitTop = 462
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
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 101
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label14: TLabel
      Left = 463
      Top = 31
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 23
      Top = 77
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
    object Label9: TLabel
      Left = 20
      Top = 54
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 500
      Top = 8
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 439
      Top = 54
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Compras.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 8
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Produto.:'
    end
    object Label2: TLabel
      Left = 30
      Top = 31
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o.:'
    end
    object Label3: TLabel
      Left = 447
      Top = 78
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regime Tribut'#225'rio.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 539
      Top = 28
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
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
    object edtDesCodDep: TEditFocus
      Left = 597
      Top = 28
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Tag = 99
      Left = 87
      Top = 74
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
      TabOrder = 3
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
      Left = 145
      Top = 74
      Width = 291
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 87
      Top = 51
      Width = 57
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 145
      Top = 51
      Width = 291
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Tag = 99
      Left = 539
      Top = 5
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 4
      OnExit = edtMarcaExit
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 597
      Top = 5
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Left = 539
      Top = 51
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 597
      Top = 51
      Width = 300
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 87
      Top = 5
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte2: TEditFocus
      Left = 145
      Top = 5
      Width = 291
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 87
      Top = 28
      Width = 349
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object grpFiltrosDiv: TGroupBox
      Left = 538
      Top = 74
      Width = 295
      Height = 22
      TabOrder = 7
      object chkSimples: TCheckBox
        Left = 5
        Top = 4
        Width = 119
        Height = 15
        Hint = #201' preciso clicar no bot'#227'o Pesquisar para utilizar este filtro.'
        Caption = 'Simples Nacional'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 0
      end
      object chkPresumido: TCheckBox
        Left = 114
        Top = 4
        Width = 100
        Height = 15
        Hint = #201' preciso clicar no bot'#227'o Pesquisar para utilizar este filtro.'
        Caption = 'Lucro Presumido'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 1
      end
      object chkReal: TCheckBox
        Left = 220
        Top = 4
        Width = 100
        Height = 15
        Hint = #201' preciso clicar no bot'#227'o Pesquisar para utilizar este filtro.'
        Caption = 'Lucro Real'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object btnFiltar: TBitBtnLocked
      Left = 834
      Top = 75
      Width = 65
      Height = 22
      Caption = '&Filtrar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000004A220966AC5116F07B380FAB0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00004D230A69B85617FFBB5617FFAE4F16F30000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000004D24
        0A69BC5819FFBB5718FFB95318FC401D08570000000000000000000000000000
        000000000000281406368A4315B7B3571AF0B35818F0854012B466300E89BD59
        19FFBC5919FFBA5719FC401E0857000000000000000000000000000000000000
        00005A2D0F78C05F1FFFC06021FFCD8250FFCD824FFFBE5D1FFFBE5A1BFFBD5A
        19FFBB5819FC401E095700000000000000000000000000000000000000003018
        083FC0601FFCCD804CFFF7EAE2FFFFFFFFFFFFFFFFFFF7EAE2FFCA7A46FFBC5A
        1BFF622F0D84000000000000000000000000000000000000000000000000944B
        18C3C36929FFF6E9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E8DFFFC063
        23FF854012B4000000000000000000000000000000000000000000000000B75D
        20F0D18958FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF84
        54FFAD541AEA000000000000000000000000000000000000000000000000B85E
        20F0D18A59FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD085
        55FFAE541AEA000000000000000000000000000000000000000000000000964D
        1BC3C5692BFFF7EBE2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E8DFFFC164
        26FF854214B40000000000000000000000000000000000000000000000003019
        093FC36525FFCF844FFFF7EBE2FFFFFFFFFFFFFFFFFFF7EBE2FFCD804CFFBF5E
        1FFF361B08480000000000000000000000000000000000000000000000000000
        00005E31127BC36625FFC46726FFCF8551FFCF8350FFC46523FFC16020FF5D2E
        0F7B000000000000000000000000000000000000000000000000000000000000
        0000000000003019093F874518B1AD591EE4AD591EE4864517B13018083F0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 8
      OnClick = btnFiltarClick
    end
  end
  object cxgDados: TcxGridCitel [3]
    Left = 0
    Top = 101
    Width = 1018
    Height = 316
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 102
    object cxvDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvPRODUTO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'PRODUTO'
        Visible = False
        GroupIndex = 0
      end
      object cxvITE_CODEMP: TcxGridDBColumn
        Caption = 'Empresa Matriz'
        DataBinding.FieldName = 'ITE_CODEMP'
      end
      object cxvITE_REGTRI: TcxGridDBColumn
        Caption = 'Regime Tributario'
        DataBinding.FieldName = 'COD_REGTRI'
        Width = 116
      end
      object cxvITE_MARBR1: TcxGridDBColumn
        Caption = 'Margem Bruta 1'
        DataBinding.FieldName = 'ITE_MARBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1'
        DataBinding.FieldName = 'ITE_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_MARBR2: TcxGridDBColumn
        Caption = 'Margem Bruta 2'
        DataBinding.FieldName = 'ITE_MARBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2'
        DataBinding.FieldName = 'ITE_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_MARBR3: TcxGridDBColumn
        Caption = 'Margem Bruta 3'
        DataBinding.FieldName = 'ITE_MARBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3'
        DataBinding.FieldName = 'ITE_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_MARBR4: TcxGridDBColumn
        Caption = 'Margem Bruta 4'
        DataBinding.FieldName = 'ITE_MARBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4'
        DataBinding.FieldName = 'ITE_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_MARBR5: TcxGridDBColumn
        Caption = 'Margem Bruta 5'
        DataBinding.FieldName = 'ITE_MARBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5'
        DataBinding.FieldName = 'ITE_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_MARBR6: TcxGridDBColumn
        Caption = 'Margem Bruta 6'
        DataBinding.FieldName = 'ITE_MARBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6'
        DataBinding.FieldName = 'ITE_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_MARBR7: TcxGridDBColumn
        Caption = 'Margem Bruta 7'
        DataBinding.FieldName = 'ITE_MARBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvITE_PREVE7: TcxGridDBColumn
        Caption = 'IPre'#231'o Venda 7'
        DataBinding.FieldName = 'ITE_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
    end
    object cxldados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object prgTela: TProgressBar [4]
    Left = 0
    Top = 417
    Width = 1018
    Height = 17
    Align = alBottom
    TabOrder = 4
    Visible = False
  end
  object dtsDados: TDataSource
    Left = 496
    Top = 240
  end
  object opDialog: TOpenDialog
    Filter = 'XLS|*.xls|csv|*.csv|xlsx|*.xlsx'
    Left = 272
    Top = 264
  end
end
