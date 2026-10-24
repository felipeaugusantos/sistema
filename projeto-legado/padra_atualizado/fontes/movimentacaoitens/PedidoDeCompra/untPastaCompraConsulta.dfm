inherited frmPastaCompraConsulta: TfrmPastaCompraConsulta
  Width = 1266
  Height = 553
  BorderStyle = bsSizeable
  Caption = 'Pasta de Compras'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1266
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 316
    Width = 1250
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Color = clYellow
    ParentColor = False
    ExplicitLeft = 2
    ExplicitTop = 323
    ExplicitWidth = 1008
  end
  inherited pnlBotoes: TPanel
    Top = 488
    Width = 1250
    TabOrder = 2
    ExplicitTop = 488
    ExplicitWidth = 1250
    inherited FlwBotoes: TFlowPanel
      Width = 1169
      ExplicitWidth = 1169
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        Visible = False
      end
      object btnPedComprasGerados: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 239
        Height = 22
        Align = alLeft
        Caption = '[ F8 ] Exibir pedidos de compras gerados'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000060000
          000A0000000A0000000A0000000A0000000B0000000B0000000B0000000B0000
          000B0000000B0000000B0000000B0000000B00000007000000027E5D52BDAF82
          72FFAF8272FFAE8172FFAE8072FFAE8071FFAE8071FFAE8070FFAD8070FFAD7F
          70FFAD7F70FFAC7F6FFFAC7F6FFFAD7E6FFF7C5B4FBE00000007B28577FFFCF8
          F6FFFCF8F5FFFBF7F6FFFBF7F5FFFBF7F5FFFBF7F5FFFBF6F4FFFBF6F4FFFBF6
          F3FFFBF6F3FFFBF6F3FFFAF5F2FFFAF5F2FFAE8072FF0000000AB5897AFFFCF9
          F7FFC59062FFC59062FFC58F61FFC58E60FFC48F60FFC58E60FFC48E5FFFC48D
          5FFFC48D5EFFC48C5EFFC48C5DFFFBF6F3FFB18475FF0000000AB68C7EFFFDFA
          F8FFCD9F75FFECD5B5FFE5C59CFFE5C49CFFE5C39BFFE4C49AFFE4C299FFE5C3
          9AFFE4C298FFE4C298FFC48E5FFFFBF7F5FFB28778FF00000009B98F81FFFDFB
          F9FFCEA178FFCEA177FFCEA077FFCDA077FFCEA077FFCEA077FFCDA076FFCDA0
          76FFCDA075FFCD9F75FFC69062FFFBF7F6FFB58A7CFF00000009BB9385FFFDFB
          FAFFF7F0EBFFF8EFEBFFF8F0EBFFF7EFEBFFF7EFEBFFF7F0EBFFF8EFEBFFF7EF
          EAFFF8EFEAFFF7EFEAFFF8EFEBFFFCF9F7FFB88E7FFF00000008BE9688FFFEFC
          FBFFCA9B6FFFCA9A6EFFCA996DFFCA996DFFCA986BFFC9976BFFC9966AFFC997
          6AFFC89569FFC99568FFC89568FFFCF9F8FFBA9183FF00000007C0998BFFFEFC
          FCFFD2A880FFF1E0C8FFE9CEAAFFE9CEA9FFE8CDA9FFE9CCA8FFE9CCA7FFE8CB
          A6FFE8CBA6FFE8CBA5FFCA976BFFFDFAF9FFBD9587FF00000007C29C8EFFFEFD
          FCFFD2A982FFD3A982FFD2AA82FFD2A981FFD2A881FFD2A881FFD2A981FFD1A8
          80FFD1A880FFD2A780FFCB9A6FFFFDFBFAFFC0978AFF00000006C49E91FFFEFE
          FDFFF9F0EDFFF8F1EDFFF9F0EDFFF9F0EDFFF8F1EDFFF8F0EDFFF8F1ECFFF8F0
          EDFFF8F0ECFFF8F0ECFFF8F0ECFFFDFCFBFFC29B8DFF00000006C6A093FFFFFE
          FEFFD1A77EFFD1A67DFFD1A67CFFD1A57BFFD0A57BFFCFA47AFFCFA379FFCFA2
          78FFCFA177FFCEA176FFCEA176FFFEFCFBFFC49E90FF00000005C7A396FFFFFE
          FEFFD6B18AFFF5E9D6FFEDD8B8FFEDD8B8FFEDD7B7FFECD7B6FFECD6B5FFECD5
          B5FFECD5B5FFECD4B3FFD0A479FFFEFDFCFFC5A093FF00000005C8A497FFFFFF
          FFFFD7B38DFFD7B38CFFD7B28CFFD8B18CFFD7B28BFFD7B28BFFD6B18AFFD7B1
          8AFFD6B18AFFD7B08AFFD1A77EFFFEFDFDFFC7A295FF00000004CAA699FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFFEFEFEFFC8A497FF00000003967C72BECAA7
          9AFFCAA79AFFCAA79AFFCAA79AFFCAA79AFFCAA699FFCAA699FFCAA699FFCAA6
          99FFCAA699FFCAA699FFCAA699FFCAA699FF967B70BF00000002}
        TabOrder = 1
        OnClick = btnPedComprasGeradosClick
      end
      object btnAnaCompras: TBitBtnLocked
        Left = 314
        Top = 0
        Width = 149
        Height = 22
        Align = alLeft
        Caption = '[ F9 ] An'#225'lise Compras'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
          00000000000100000004000000090000000D0000000F0000000F0000000C0000
          00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
          0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
          1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
          02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
          50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
          3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
          C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
          7CFFEFE6DFFFCDA67CFFCDA36EFFE4C693FFEFD9ABFFEAD2A8FFD4B284FFD0AE
          88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
          C9FFDDC1A8FFC99966FFE8C085FFE9C388FF8F4B24FFF1D8B1FFF3DDB8FFD6B3
          8AFFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
          F2FFC79873FFDEAB77FFEFCDABFFF1D2B5FF8F4524FFEDC99EFFF1D4B2FFECCF
          AEFFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
          FCFFBE875FFFEDCFB9FF682612FF8A3F22FF8C4024FF8F4225FF924427FFF1CE
          AEFFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
          F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FF8B3C23FFF1CEB6FFEBB78FFFE7BC
          9AFFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
          D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FF6A2213FFF1C8B2FFEBB08AFFCA8F
          6FFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
          A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88967FFCE9D
          84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
          4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
          F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
          020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
          A2FC62504B900404031000000002000000000000000000000000000000000000
          000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
          1F3E000000060000000100000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnAnaComprasClick
      end
      object btnExibirTodos: TBitBtnLocked
        Left = 463
        Top = 0
        Width = 216
        Height = 22
        Caption = '[ F7 ] Exibir itens de todos os fornecedores'
        TabOrder = 3
        OnClick = btnExibirTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1171
      Top = 2
      Align = alRight
      Caption = '&Sair'
      ExplicitLeft = 1171
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 472
    Width = 1250
    TabOrder = 3
    ExplicitTop = 472
    ExplicitWidth = 1250
    inherited pnlNomeForm: TPanel
      Left = 1079
      ExplicitLeft = 1079
    end
    inherited pnlInfo: TPanel
      Width = 1079
      ExplicitWidth = 1079
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1250
    Height = 83
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 4
      Top = 12
      Width = 115
      Height = 14
      Caption = 'Visualiza'#231#227'o Agrupada:'
    end
    object cmbAgrupador: TComboBoxFocus
      Tag = 99
      Left = 3
      Top = 25
      Width = 145
      Height = 22
      ItemIndex = 0
      TabOrder = 0
      Text = 'Fornecedor'
      OnChange = cmbAgrupadorChange
      Items.Strings = (
        'Fornecedor'
        'Fornecedor + Marca'
        'Fornecedor + Departamento')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object grbFiltros: TGroupBox
      Left = 164
      Top = -1
      Width = 1085
      Height = 82
      Caption = ' Filtros '
      TabOrder = 1
      object Label1: TLabel
        Left = 17
        Top = 35
        Width = 56
        Height = 14
        Caption = 'Comprador:'
      end
      object Label14: TLabel
        Left = 396
        Top = 58
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 432
        Top = 36
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 12
        Top = 58
        Width = 59
        Height = 14
        Caption = 'Fornecedor:'
      end
      object Label8: TLabel
        Left = 772
        Top = 34
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object lblEmpresas: TLabel
        Left = 789
        Top = 59
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCmp: TEditFocus
        Tag = 99
        Left = 76
        Top = 30
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
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesCmp: TEditFocus
        Left = 141
        Top = 30
        Width = 250
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 468
        Top = 53
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
        TabOrder = 4
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
        Left = 517
        Top = 53
        Width = 250
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 8
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
        Left = 468
        Top = 30
        Width = 48
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
        TabOrder = 3
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
        Left = 517
        Top = 30
        Width = 250
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 76
        Top = 53
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtFornecedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtDesFornecedor: TEditFocus
        Left = 141
        Top = 53
        Width = 250
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object chkConsProdSobEnc: TCheckBox
        Left = 75
        Top = 12
        Width = 308
        Height = 17
        Caption = 'Sugerir compras para produtos sob encomenda?'
        TabOrder = 0
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 842
        Top = 30
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 5
        Text = ''
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 891
        Top = 30
        Width = 182
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFilEmp: TEditFocus
        Tag = 99
        Left = 842
        Top = 53
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
        TabOrder = 6
        OnKeyPress = edtFilEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesFilEmp: TEditFocus
        Left = 891
        Top = 53
        Width = 182
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 12
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
  object cxgCompras: TcxGrid [4]
    Left = 0
    Top = 83
    Width = 1250
    Height = 233
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvCompras: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxvComprasCellDblClick
      OnCustomDrawCell = cxvComprasCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'VALCOM'
          Column = cxvComprasVALCOM
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'VALNET'
          Column = cxvComprasVALNET
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'MEDFIL'
          Column = cxvComprasMEDFIL
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skMax
          Position = spFooter
          FieldName = 'FILMIN'
          Column = cxvComprasFILMIN
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skMax
          Position = spFooter
          FieldName = 'LIMPED'
          Column = cxvComprasLIMPED
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'PEDMES'
          Column = cxvComprasPEDMES
        end
        item
          Kind = skSum
          Position = spFooter
          FieldName = 'SKURUP'
          Column = cxvComprasSKURUP
        end
        item
          Kind = skSum
          Position = spFooter
          FieldName = 'SKUPED'
          Column = cxvComprasSKUPED
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'DIAEST'
          Column = cxvComprasDIAEST
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'DIAPEN'
          Column = cxvComprasDIAPEN
        end
        item
          Kind = skMax
          Position = spFooter
          OnGetText = cxvComprasTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems10GetText
          FieldName = 'RUPTUR'
          Column = cxvComprasRUPTUR
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'PEDCOM'
          Column = cxvComprasPEDCOM
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'QTDCOM'
          Column = cxvComprasQTDCOM
        end
        item
          Kind = skMin
          Position = spFooter
          OnGetText = cxvComprasTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems13GetText
          FieldName = 'PREANT'
          Column = cxvComprasPREANT
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0;-,0'
          Kind = skCount
          Column = cxvComprasCODFOR
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvComprasVALNET
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvComprasVALCOM
        end
        item
          Format = '#,##0.'
          Kind = skSum
          Column = cxvComprasSKURUP
        end
        item
          Format = '#,##0.'
          Kind = skSum
          Column = cxvComprasSKUPED
        end
        item
          Format = '#,##0.'
          Kind = skSum
          Column = cxvComprasPEDMES
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '< Nenhum pedido encontrado > '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          Caption = 'Fornecedor'
          FixedKind = fkLeft
          Width = 286
        end
        item
          Caption = 'Agrupamento'
          Width = 174
        end
        item
          Caption = 'Valor da Compra'
          Width = 460
        end
        item
          Caption = 'Litragem'
        end
        item
          Caption = 'Limite de Compra'
          Width = 181
        end
        item
          Caption = 'SKUs'
          Width = 254
        end
        item
          Caption = 'Dias de Estoque / Pend'#234'ncias'
          Width = 560
        end>
      object cxvComprasCODFOR: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvComprasNOMFOR: TcxGridDBBandedColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'NOMFOR'
        SortIndex = 0
        SortOrder = soAscending
        Width = 192
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvComprasVALCOM: TcxGridDBBandedColumn
        Caption = 'Valor da Compra'
        DataBinding.FieldName = 'VALCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 86
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvComprasVALNET: TcxGridDBBandedColumn
        Caption = 'Valor Compra Net'
        DataBinding.FieldName = 'VALNET'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 92
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvComprasMEDFIL: TcxGridDBBandedColumn
        Caption = 'M'#233'dia Compra por Filial'
        DataBinding.FieldName = 'MEDFIL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 116
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvComprasFILMIN: TcxGridDBBandedColumn
        Caption = 'Filiais que atingem o m'#237'nimo'
        DataBinding.FieldName = 'FILMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 137
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvComprasSKURUP: TcxGridDBBandedColumn
        Caption = 'Em Ruptura sem Pend'#234'ncia'
        DataBinding.FieldName = 'SKURUP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 167
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvComprasSKUPED: TcxGridDBBandedColumn
        Caption = 'Em Ponto de Pedido'
        DataBinding.FieldName = 'SKUPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 130
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvComprasDIAEST: TcxGridDBBandedColumn
        Caption = 'Dias Estoque'
        DataBinding.FieldName = 'DIAEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 71
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvComprasDIAPEN: TcxGridDBBandedColumn
        Caption = 'Dias Est. Pend'#234'ncia '
        DataBinding.FieldName = 'DIAPEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 106
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvComprasRUPTUR: TcxGridDBBandedColumn
        Caption = 'Ruptura %'
        DataBinding.FieldName = 'RUPTUR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 62
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvComprasPEDCOM: TcxGridDBBandedColumn
        Caption = 'Valor Pend'#234'ncia'
        DataBinding.FieldName = 'PEDCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 86
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvComprasQTDCOM: TcxGridDBBandedColumn
        Caption = 'Qtd. Pedidos Pendentes'
        DataBinding.FieldName = 'QTDCOM'
        HeaderAlignmentHorz = taCenter
        Width = 123
        Position.BandIndex = 6
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvComprasPREANT: TcxGridDBBandedColumn
        Caption = 'Pedido Mais Antigo'
        DataBinding.FieldName = 'PREANT'
        HeaderAlignmentHorz = taCenter
        Width = 102
        Position.BandIndex = 6
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvComprasLIMPED: TcxGridDBBandedColumn
        Caption = 'Valor Limite'
        DataBinding.FieldName = 'LIMPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 71
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvComprasPEDMES: TcxGridDBBandedColumn
        Caption = 'Total Pedidos do M'#234's'
        DataBinding.FieldName = 'PEDMES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 110
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvComprasPASLIM: TcxGridDBBandedColumn
        DataBinding.FieldName = 'PASLIM'
        Visible = False
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvComprasAgrupamento: TcxGridDBBandedColumn
        Caption = 'Agrupamento'
        DataBinding.FieldName = 'AGRUPAMENTO'
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvComprasFORNEC: TcxGridDBBandedColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        Visible = False
        GroupIndex = 0
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvComprasDTAGER: TcxGridDBBandedColumn
        Caption = 'Dt. Gera'#231#227'o'
        DataBinding.FieldName = 'PRE_DTAGER'
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvComprasCONTAT: TcxGridDBBandedColumn
        Caption = 'Contato'
        DataBinding.FieldName = 'CONTAT'
        Width = 120
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvComprasVALMIN: TcxGridDBBandedColumn
        Caption = 'Valor M'#237'nimo'
        DataBinding.FieldName = 'VALMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvComprasLITRAG: TcxGridDBBandedColumn
        Caption = 'Litragem'
        DataBinding.FieldName = 'LITRAG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxgComprasLevel1: TcxGridLevel
      GridView = cxvCompras
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 319
    Width = 1250
    Height = 153
    Align = alBottom
    ParentColor = True
    TabOrder = 4
    object Panel4: TPanel
      Left = 387
      Top = 1
      Width = 862
      Height = 151
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label3: TLabel
        Left = 43
        Top = 21
        Width = 366
        Height = 14
        AutoSize = False
        Caption = 
          'Valor da Compra + Pedidos do M'#234's maior que o Limite mensal do fo' +
          'rnecedor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape1: TShape
        Left = 24
        Top = 21
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clRed
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object lblResPadResumo: TLabel
        Left = 24
        Top = 124
        Width = 152
        Height = 14
        Cursor = crHandPoint
        AutoSize = False
        Caption = 'Restaura padr'#227'o dos grids'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
        OnClick = lblResPadResumoClick
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 386
      Height = 151
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 386
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Resumo por Filiais'
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
      end
      object cxgFiliais: TcxGrid
        Left = 0
        Top = 24
        Width = 386
        Height = 127
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvFiliais: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = cxvFiliaisVALCOM
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = cxvFiliaisLITRAG
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle2
          object cxvFiliaisSIGEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'SIGEMP'
            HeaderAlignmentHorz = taCenter
            Width = 68
          end
          object cxvFiliaisCODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'CODEMP'
            Visible = False
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 66
          end
          object cxvFiliaisVALMIN: TcxGridDBColumn
            Caption = 'Valor Pedido M'#237'nimo'
            DataBinding.FieldName = 'VALMIN'
            HeaderAlignmentHorz = taCenter
            Width = 101
          end
          object cxvFiliaisVALCOM: TcxGridDBColumn
            Caption = 'Valor de Compra'
            DataBinding.FieldName = 'VALCOM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taCenter
            Width = 109
          end
          object cxvFiliaisLITRAG: TcxGridDBColumn
            Caption = 'Litragem'
            DataBinding.FieldName = 'LITRAG'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taCenter
            Width = 107
          end
          object cxvFiliaisNOMEMP: TcxGridDBColumn
            Caption = 'Nome da Empresa'
            DataBinding.FieldName = 'NOMEMP'
            Visible = False
            Width = 216
          end
        end
        object cxgFiliaisLevel1: TcxGridLevel
          GridView = cxvFiliais
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 616
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 192
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 688
    Top = 144
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 12189695
    end
  end
end
