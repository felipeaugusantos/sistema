inherited frmCadEstruturas: TfrmCadEstruturas
  Left = 207
  Top = 209
  Width = 1024
  Height = 686
  Caption = 'Cadastro de Estruturas'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 686
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 615
    Width = 1018
    Height = 26
    ExplicitTop = 615
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 946
      Height = 22
      ExplicitWidth = 946
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] Gravar'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnApaga: TBitBtnLocked
        Left = 88
        Top = 0
        Width = 114
        Height = 22
        Align = alLeft
        Caption = '[ F2 ] Apaga Estrutura'
        TabOrder = 1
        OnClick = btnApagaClick
      end
      object btnEstrutura: TBitBtnLocked
        Left = 202
        Top = 0
        Width = 116
        Height = 22
        Align = alLeft
        Caption = '[ F3 ] Mostra Estrutura'
        TabOrder = 2
        OnClick = btnEstruturaClick
      end
      object btnEditar: TBitBtnLocked
        Left = 318
        Top = 0
        Width = 98
        Height = 22
        Align = alLeft
        Caption = '[ Enter ] Editar Item'
        TabOrder = 3
        OnClick = btnEditarClick
      end
      object btnComentario: TBitBtnLocked
        Left = 416
        Top = 0
        Width = 104
        Height = 22
        Align = alLeft
        Caption = '[ Insert ] Coment'#225'rio'
        TabOrder = 4
        OnClick = btnComentarioClick
      end
      object btnMoveCima: TBitBtnLocked
        Left = 520
        Top = 0
        Width = 97
        Height = 22
        Align = alLeft
        Caption = 'Move Item p/ Cima'
        TabOrder = 5
        OnClick = btnMoveCimaClick
      end
      object btnMoveBaixo: TBitBtnLocked
        Left = 617
        Top = 0
        Width = 97
        Height = 22
        Align = alLeft
        Caption = 'Move Item p/ Baixo'
        TabOrder = 6
        OnClick = btnMoveBaixoClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 714
        Top = 0
        Width = 75
        Height = 22
        Align = alLeft
        Caption = '[ F5 ] Imprimir'
        TabOrder = 7
        OnClick = btnImprimirClick
      end
      object btnExiEstrutura: TBitBtnLocked
        Left = 789
        Top = 0
        Width = 134
        Height = 22
        Align = alLeft
        Caption = '[ Alt + F8 ] Exibir Estrutura'
        TabOrder = 8
        Visible = False
        OnClick = btnExiEstruturaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 948
      Top = 2
      Width = 68
      Align = alRight
      ExplicitLeft = 948
      ExplicitTop = 2
      ExplicitWidth = 68
    end
  end
  inherited pnlStatus: TPanel
    Top = 641
    Width = 1018
    ExplicitTop = 641
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
  object pgcPagina: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 586
    ActivePage = tbsFases
    Align = alClient
    TabOrder = 3
    OnChanging = pgcPaginaChanging
    object tbsEstrutura: TTabSheet
      Caption = 'Estrutura'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlProdutos: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 85
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 9
          Width = 86
          Height = 14
          Caption = 'Produto Acabado:'
        end
        object Label5: TLabel
          Left = 39
          Top = 35
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Referencia:'
        end
        object Label10: TLabel
          Left = 249
          Top = 35
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object lblTipQtd: TLabel
          Left = 562
          Top = 35
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Quantidade: '
        end
        object Label23: TLabel
          Left = 348
          Top = 35
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cod. Fabrica:'
        end
        object edtDesProduto: TEditFocus
          Left = 171
          Top = 5
          Width = 604
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtProdutos: TEditFocus
          Tag = 99
          Left = 99
          Top = 5
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnExit = edtProdutosExit
          OnKeyPress = edtProdutosKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtReferencia: TEditFocus
          Left = 99
          Top = 31
          Width = 118
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtUnidade: TEditFocus
          Left = 292
          Top = 31
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object cbxTipQtd: TComboBoxFocus
          Tag = 99
          Left = 663
          Top = 31
          Width = 112
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'QUANTIDADE'
          OnChange = cbxTipQtdChange
          Items.Strings = (
            'QUANTIDADE'
            'PORCENTAGEM')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnLayouts: TBitBtnLocked
          Left = 99
          Top = 58
          Width = 234
          Height = 22
          Caption = 'Layouts Ord. Prod.'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000766E66B7A498
            8EFFA2978CFFA1958BFF9F948AFF9E9288FF9D9187FF9C9086FF9A8F85FF998D
            84FF988D83FF978C82FF968A81FF958980FF948980FF69625AB7A69A90FFF6F3
            EFFFF6F2EFFFF5F1EDFFF0ECE8FFE4E1DDFFDEDCD7FFDCDAD4FFDBD7D2FFDAD6
            D1FFD8D4CFFFD6D3CDFFD5D1CBFFD9D4CFFFEAE5DFFF938980FFA89B90FFF7F3
            F0FFF6F3F0FFF5F2EEFFEAE6E3FFB19C8CFF92745EFF90735DFF8D715BFF8C70
            59FF886D56FF866B54FF866A54FFA49181FFDAD6D0FF958980FFA89D92FFF7F4
            F1FFF2EFEDFFE6E2E0FFD6D3D0FF947861FFFFFFFFFFE8E4E0FFE6E2DDFFE5DF
            DBFFE2DCD6FFE0DAD4FFD2C8C0FF856953FFD8D3CDFF958B81FFAA9E93FFF8F5
            F2FFE9E5E4FFD19B6CFFCB9668FF967862FFFFFFFFFFC18752FFAF5F18FFAD5D
            16FFAB5A13FFBA7E49FFD3CAC1FF856A54FFDBD7D1FF978B82FFAB9F94FFF8F5
            F3FFE8E4E3FFD29D6EFFF0E4D8FF967A63FFFFFFFFFFB2641CFFF2B17BFFF0AE
            7AFFE6A16DFFAA5A13FFD4CAC2FF876B55FFDDD9D3FF988D83FFACA095FFF9F6
            F4FFEAE7E5FFD39E6FFFF2E8DFFF997B64FFFFFFFFFFC58C5DFFC38B5BFFC38A
            5AFFC28858FFC18858FFFFFFFFFF896D57FFDFDAD6FF998E84FFADA196FFF9F7
            F5FFECE8E8FFD4A071FFF6ECE4FFB39D8DFF987A65FFC68D5DFFFAF1E9FFFAF0
            E7FFF9EDE3FFC28858FF8C7058FFA79281FFE4E1DCFF9A8F85FFAEA397FFFAF7
            F6FFEEEBEAFFD6A172FFF9F1EAFFF6EDE5FFEFE6DDFFC79060FFFBF3EDFFFBF2
            ECFFFAF1E9FFC38A5BFFDEDBD6FFE8E4E1FFF0EBE7FF9B9086FFAFA397FFFAF7
            F7FFF0EEEDFFD7A374FFFAF5EFFFDBB28FFFD9B08EFFC79161FFC79060FFC68F
            5FFFC48C5DFFC48B5CFFECE9E5FFF4F0EBFFF4EFEBFF9D9187FFB0A599FFFAF8
            F7FFF2F0EEFFD8A475FFFCF7F3FFFBF4F0FFF9F3ECFFF6EDE6FFF4E9E0FFF1E6
            DCFFCC9668FFDEDCD8FFF3F0EBFFF4F1EDFFF4F0ECFF9E9288FFB1A69AFFFBF8
            F8FFF4F2F1FFD8A576FFFCF9F7FFDBB28FFFDBB28FFFDBB28FFFDBB28FFFF7ED
            E4FFD29C6DFFE7E2E0FFF6F2EFFFF5F1EDFFF4F1ECFFA09489FFB2A69AFFFBF9
            F8FFF6F4F3FFD9A678FFFDFDFBFFFDFBF8FFFCF8F4FFFBF6F1FFFAF4EDFFF8F1
            E9FFD39E6FFFE8E5E2FFF6F3EFFFF6F2EFFFF5F2EEFFA1958BFFB3A69BFFFBF9
            F9FFF8F6F5FFDAA678FFD9A678FFD8A477FFD8A476FFD7A274FFD6A274FFD5A0
            72FFD49F71FFEDEAE7FFF7F3F0FFF6F3EFFFF6F2EEFFA2978CFFB3A79BFFFBFA
            F9FFFAF8F8FFF8F6F5FFF7F5F4FFF6F3F2FFF4F2F1FFF3F0EFFFF1EFEDFFEFED
            EBFFF1EDEBFFF5F3F0FFF7F4F1FFF7F3F0FFF6F3EFFFA4978EFF857D74BDB3A7
            9BFFB3A69BFFB2A69AFFB1A599FFB1A499FFB0A398FFAEA397FFADA196FFACA0
            95FFAB9F94FFAA9E92FFA89D92FFA89B91FFA69A8FFF7A716ABD}
          TabOrder = 5
          OnClick = btnLayoutsClick
        end
        object edtCodFabrica: TEditFocus
          Left = 416
          Top = 31
          Width = 118
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlSubProdutos: TPanel
        Left = 0
        Top = 85
        Width = 1010
        Height = 82
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label2: TLabel
          Left = 30
          Top = 10
          Width = 65
          Height = 14
          Caption = 'Sub. Produto:'
        end
        object Label3: TLabel
          Left = 40
          Top = 33
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Referencia:'
        end
        object Label4: TLabel
          Left = 225
          Top = 33
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object Label7: TLabel
          Left = 315
          Top = 33
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'Destino:'
        end
        object shpESTPRE: TShape
          Left = 686
          Top = 10
          Width = 10
          Height = 52
          Brush.Color = clGreen
        end
        object lblFatorPrecoVenda: TLabel
          Left = 40
          Top = 57
          Width = 136
          Height = 14
          Caption = 'Fator sobre Pre'#231'o de Venda'
        end
        object rdgPrecos: TRadioGroup
          Left = 698
          Top = 0
          Width = 301
          Height = 63
          Caption = 'Exibir pre'#231'os'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Sem'
            'Custo'
            #218'ltima Compra'
            #218'ltima Compra + Impostos'
            'M'#233'dio'
            'Venda')
          TabOrder = 6
          OnClick = rdgPrecosClick
        end
        object edtDesSubProduto: TEditFocus
          Left = 171
          Top = 6
          Width = 509
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubProduto: TEditFocus
          Tag = 99
          Left = 99
          Top = 6
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtSubProdutoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtSubReferencia: TEditFocus
          Left = 99
          Top = 29
          Width = 118
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubUnidade: TEditFocus
          Left = 268
          Top = 29
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubDestino: TEditFocus
          Left = 356
          Top = 29
          Width = 324
          Height = 22
          Alignment = taLeftJustify
          Color = clWhite
          MaxLength = 30
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object cmbPreVen: TComboBox
          Left = 911
          Top = 34
          Width = 43
          Height = 22
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 5
          TabStop = False
          Text = '1'
          OnChange = cmbPreVenChange
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7')
        end
        object edtFatorPrecoVenda: TEditFocus
          Tag = 99
          Left = 181
          Top = 54
          Width = 81
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.000'
        end
      end
      object pnlQtdMadeira: TPanel
        Left = 0
        Top = 167
        Width = 1010
        Height = 60
        Align = alTop
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object Label13: TLabel
          Left = 205
          Top = 10
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comprim.:'
        end
        object Label16: TLabel
          Left = 375
          Top = 8
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Largura:'
        end
        object Label17: TLabel
          Left = 541
          Top = 8
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Espessura:'
        end
        object lblQtdMadeira: TLabel
          Left = 38
          Top = 10
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object Label19: TLabel
          Left = 36
          Top = 36
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Aparelhada:'
        end
        object ColorLabel2: TColorLabel
          Left = 118
          Top = 36
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label20: TLabel
          Left = 192
          Top = 36
          Width = 60
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr. Aparel.:'
        end
        object ColorLabel5: TColorLabel
          Left = 322
          Top = 36
          Width = 10
          Height = 14
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label21: TLabel
          Left = 373
          Top = 36
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Benefic.:'
        end
        object ColorLabel3: TColorLabel
          Left = 441
          Top = 36
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label22: TLabel
          Left = 530
          Top = 36
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr. Benefic.:'
        end
        object ColorLabel1: TColorLabel
          Left = 685
          Top = 36
          Width = 10
          Height = 14
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtComPec: TEditFocus
          Tag = 99
          Left = 253
          Top = 5
          Width = 88
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          Text = '0,00000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00000'
        end
        object edtLarPec: TEditFocus
          Tag = 99
          Left = 421
          Top = 4
          Width = 88
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          Text = '0,00000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00000'
        end
        object edtEspPec: TEditFocus
          Tag = 99
          Left = 598
          Top = 5
          Width = 97
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          Text = '0,00000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00000'
        end
        object edtQtdPec: TEditFocus
          Tag = 99
          Left = 99
          Top = 5
          Width = 88
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          Text = '0,00000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00000'
        end
        object edtAparel: TEditFocus
          Tag = 99
          Left = 99
          Top = 32
          Width = 15
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 4
          Text = 'N'
          OnChange = edtAparelChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
        object edtPerApa: TEditFocus
          Tag = 99
          Left = 253
          Top = 32
          Width = 67
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 5
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
        object edtBenefi: TEditFocus
          Tag = 99
          Left = 421
          Top = 32
          Width = 15
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 6
          Text = 'N'
          OnChange = edtBenefiChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
        object edtPerBen: TEditFocus
          Tag = 99
          Left = 598
          Top = 32
          Width = 83
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 7
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
      object pnlQuantidade: TPanel
        Left = 0
        Top = 227
        Width = 1010
        Height = 31
        Align = alTop
        ParentBackground = False
        ParentColor = True
        TabOrder = 3
        object lblQtdIte: TLabel
          Left = 40
          Top = 7
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object Label8: TLabel
          Left = 246
          Top = 7
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acumula na OP:'
        end
        object ColorLabel6: TColorLabel
          Left = 341
          Top = 8
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object edtSubQtdIte: TEditFocus
          Tag = 99
          Left = 99
          Top = 4
          Width = 88
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          TabOrder = 0
          Text = '0,000000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.000000'
        end
        object edtAcumOp: TEditFocus
          Tag = 99
          Left = 324
          Top = 4
          Width = 15
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = clWhite
          MaxLength = 30
          TabOrder = 1
          Text = 'S'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAdicionar: TBitBtnLocked
          Left = 470
          Top = 4
          Width = 111
          Height = 22
          Caption = '&Confirma'
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
          TabOrder = 2
          OnClick = btnAdicionarClick
        end
        object btnCancelaItem: TBitBtnLocked
          Left = 584
          Top = 4
          Width = 111
          Height = 22
          Caption = 'C&ancelar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnCancelaItemClick
        end
      end
      object cxgDados: TcxGridCitel
        Left = 0
        Top = 258
        Width = 1010
        Height = 299
        Align = alClient
        TabOrder = 4
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDadosTableView: TcxGridDBTableViewCitel
          OnKeyDown = cxgDados_TableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgDados_TableViewCustomDrawCell
          DataController.DataSource = dtsConsulta
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          OnColumnPosChanged = cxgDados_TableViewColumnPosChanged
          OnColumnSizeChanged = cxgDados_TableViewColumnSizeChanged
          Zebra = True
          Destaque = True
          CorZebra = clMoneyGreen
          object cxgDadosTableViewDMT_SEQUEN: TcxGridDBColumn
            Caption = 'Seq.'
            DataBinding.FieldName = 'DMT_SEQUEN'
            Width = 51
          end
          object cxgDadosTableViewDMT_ITESUB: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DMT_ITESUB'
          end
          object cxgDadosTableViewITE_CODFAB: TcxGridDBColumn
            Caption = 'C'#243'd. F'#225'brica'
            DataBinding.FieldName = 'ITE_CODFAB'
            Width = 91
          end
          object cxgDadosTableViewDMT_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DMT_DESCRI'
            Width = 217
          end
          object cxgDadosTableViewDMT_REFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'DMT_REFERE'
          end
          object cxgDadosTableViewUNI_SIGUNI: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNI_SIGUNI'
          end
          object cxgDadosTableViewDMT_QTDITE: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'DMT_QTDITE'
            Width = 93
          end
          object cxgDadosTableViewITE_DENSID: TcxGridDBColumn
            Caption = 'Densidade'
            DataBinding.FieldName = 'ITE_DENSID'
          end
          object cxgDadosTableViewMASSA: TcxGridDBColumn
            Caption = 'Massa'
            DataBinding.FieldName = 'MASSA'
          end
          object cxgDadosTableViewITE_PREVE1: TcxGridDBColumn
            Caption = 'Vr. Unit'#225'rio'
            DataBinding.FieldName = 'ITE_PREVE1'
          end
          object cxgDadosTableViewTOTITE: TcxGridDBColumn
            Caption = 'Total'
            DataBinding.FieldName = 'TOTITE'
          end
          object cxgDadosTableViewDMT_ACUMOP: TcxGridDBColumn
            Caption = 'Acum. na OP'
            DataBinding.FieldName = 'DMT_ACUMOP'
          end
          object cxgDadosTableViewDMT_DESPCA: TcxGridDBColumn
            Caption = 'Destino da Pe'#231'a'
            DataBinding.FieldName = 'DMT_DESPCA'
            Width = 91
          end
          object cxgDadosTableViewEstrur: TcxGridDBColumn
            DataBinding.FieldName = 'ESTRUR'
            Visible = False
          end
          object cxgDadosTableViewDMT_PRESUB: TcxGridDBColumn
            Caption = 'Fator Pre'#231'o de Venda'
            DataBinding.FieldName = 'DMT_PRESUB'
            Width = 111
          end
        end
        object cxgDadosLevel: TcxGridLevel
          GridView = cxgDadosTableView
        end
      end
    end
    object tbsEteMat: TTabSheet
      Caption = 'Especifica'#231#245'es T'#233'cnicas'
      ImageIndex = 1
      OnShow = tbsEteMatShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlTopEteMat: TPanel
        Left = 0
        Top = 56
        Width = 1010
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl23: TLabel
          Left = 395
          Top = 7
          Width = 64
          Height = 14
          Caption = 'Valor M'#225'ximo'
        end
        object Label6: TLabel
          Left = 320
          Top = 7
          Width = 60
          Height = 14
          Caption = 'Valor M'#237'nimo'
        end
        object Label9: TLabel
          Left = 7
          Top = 7
          Width = 68
          Height = 14
          Caption = 'Espec'#237'fica'#231#227'o'
        end
        object edtMaxEte: TEditFocus
          Tag = 99
          Left = 395
          Top = 24
          Width = 69
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
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.0000'
        end
        object btnAdicionaIteEmb: TBitBtnLocked
          Left = 470
          Top = 24
          Width = 74
          Height = 22
          Caption = '&Adicionar'
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
          TabOrder = 3
          OnClick = btnAdicionaIteEmbClick
        end
        object btnCancelaIteEmb: TBitBtnLocked
          Left = 544
          Top = 24
          Width = 74
          Height = 22
          Caption = 'C&ancelar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnCancelaIteEmbClick
        end
        object edtMinEte: TEditFocus
          Tag = 99
          Left = 320
          Top = 24
          Width = 69
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
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.0000'
        end
        object edtCodEte: TEditFocus
          Tag = 99
          Left = 7
          Top = 24
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = edtCodEteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesEte: TEditFocus
          Left = 59
          Top = 24
          Width = 255
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlAlClientEteMat: TPanel
        Left = 0
        Top = 113
        Width = 1010
        Height = 444
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object cxgEteMat: TcxGridCitel
          Left = 0
          Top = 0
          Width = 1010
          Height = 444
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgEteMatTableView: TcxGridDBTableViewCitel
            OnDblClick = cxgEteMatTableViewDblClick
            OnKeyDown = cxgEteMatTableViewKeyDown
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
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = True
            CorZebra = clMoneyGreen
            object cxgEteMatTableViewCODETE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'ETM_CODETE'
              Width = 70
            end
            object cxgEteMatTableViewDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'ETE_DESCRI'
              Width = 203
            end
            object cxgEteMatTableViewVALMIN: TcxGridDBColumn
              Caption = 'M'#237'nimo'
              DataBinding.FieldName = 'ETM_VALMIN'
              Width = 90
            end
            object cxgEteMatTableViewVALMAX: TcxGridDBColumn
              Caption = 'M'#225'ximo'
              DataBinding.FieldName = 'ETM_VALMAX'
              Width = 103
            end
          end
          object cxgEteMatLevel: TcxGridLevel
            GridView = cxgEteMatTableView
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Label11: TLabel
          Left = 9
          Top = 9
          Width = 86
          Height = 14
          Caption = 'Produto Acabado:'
        end
        object Label12: TLabel
          Left = 40
          Top = 32
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Referencia:'
        end
        object Label14: TLabel
          Left = 232
          Top = 32
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object Bevel1: TBevel
          Left = 0
          Top = 48
          Width = 1010
          Height = 8
          Align = alBottom
          Shape = bsBottomLine
        end
        object Label24: TLabel
          Left = 332
          Top = 33
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cod. Fabrica:'
        end
        object edtDesAcabado: TEditFocus
          Left = 170
          Top = 4
          Width = 515
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtProAcabado: TEditFocus
          Tag = 99
          Left = 99
          Top = 4
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnExit = edtProdutosExit
          OnKeyPress = edtProdutosKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtRefAcabado: TEditFocus
          Left = 99
          Top = 28
          Width = 118
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtUndAcabado: TEditFocus
          Left = 275
          Top = 28
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodFabAcabado: TEditFocus
          Left = 400
          Top = 28
          Width = 118
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsFases: TTabSheet
      Caption = 'Fases'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFases: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 557
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object cxgCadFas: TcxGrid
          Left = 1
          Top = 1
          Width = 632
          Height = 136
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgCadFasView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '< Sem fases para ordenar>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxgCadFasCODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'FAS_CODIGO'
              Options.Editing = False
              Width = 55
            end
            object cxgCadFasDESFAS: TcxGridDBColumn
              Caption = 'Descri'#231#227'o da Fase'
              DataBinding.FieldName = 'FAS_DESFAS'
              Options.Editing = False
              Width = 441
            end
            object cxgCadFasSEQUEN: TcxGridDBColumn
              Caption = 'Sequ'#234'ncia'
              DataBinding.FieldName = 'FAS_SEQUEN'
              Options.Editing = False
              SortIndex = 0
              SortOrder = soAscending
              Width = 70
            end
            object cxgCadFasUTILIZ: TcxGridDBColumn
              Caption = 'Utiliza'
              DataBinding.FieldName = 'FAS_UTILIZ'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.Alignment = taCenter
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              Width = 64
            end
          end
          object cxgCadFasLevel1: TcxGridLevel
            GridView = cxgCadFasView
          end
        end
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 586
    Width = 1018
    Height = 29
    Align = alBottom
    ParentColor = True
    TabOrder = 2
    object shpEstrutura: TShape
      Left = 8
      Top = 6
      Width = 16
      Height = 16
      Brush.Color = clRed
    end
    object Label15: TLabel
      Left = 32
      Top = 7
      Width = 66
      Height = 14
      Caption = 'Item Estrutura'
    end
    object pnlQtd: TPanel
      Left = 257
      Top = 2
      Width = 205
      Height = 27
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label18: TLabel
        Left = 32
        Top = 3
        Width = 86
        Height = 18
        Alignment = taRightJustify
        Caption = 'Quantidade:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbeQtdTotal: TDBEditFocus
        Left = 120
        Top = 2
        Width = 85
        Height = 22
        BiDiMode = bdRightToLeft
        Color = 16768952
        DataField = 'SUM_QTDITE'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlTotal: TPanel
      Left = 704
      Top = 2
      Width = 126
      Height = 27
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      Visible = False
      object lblTotal: TLabel
        Left = 1
        Top = 3
        Width = 39
        Height = 18
        Caption = 'Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object dbeTotal: TDBEditFocus
        Left = 42
        Top = 2
        Width = 84
        Height = 23
        BiDiMode = bdRightToLeft
        Color = 16768952
        DataField = 'SUM_TOTITE'
        DataSource = dtsConsulta
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 764
    Top = 192
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 732
    Top = 192
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 820
    Top = 204
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 876
    Top = 204
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 908
    Top = 204
    object cdsConsultaMAX_SEQGER: TAggregateField
      FieldName = 'MAX_SEQGER'
      Active = True
      DisplayName = ''
      Expression = 'MAX(DMT_SEQUEN)'
    end
    object cdsConsultaSUM_TOTITE: TAggregateField
      FieldName = 'SUM_TOTITE'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(TOTITE)'
    end
    object cdsConsultaSUM_QTDITE: TAggregateField
      FieldName = 'SUM_QTDITE'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(DMT_QTDITE)'
    end
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 940
    Top = 204
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 660
    Top = 369
  end
end
