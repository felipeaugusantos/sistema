inherited frmAnaliseEstoqueEmExcesso: TfrmAnaliseEstoqueEmExcesso
  Width = 806
  Height = 586
  BorderIcons = [biSystemMenu]
  Caption = 'Analise de Estoque em Excesso'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 806
  ExplicitHeight = 586
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 541
    Width = 800
    TabOrder = 3
    ExplicitTop = 541
    ExplicitWidth = 573
    inherited FlwBotoes: TFlowPanel
      Width = 796
      ExplicitWidth = 569
    end
  end
  inherited pnlStatus: TPanel
    Top = 541
    Width = 800
    TabOrder = 2
    ExplicitTop = 541
    ExplicitWidth = 573
    inherited pnlNomeForm: TPanel
      Left = 629
      TabOrder = 1
      ExplicitLeft = 402
    end
    inherited pnlInfo: TPanel
      Width = 629
      TabOrder = 0
      ExplicitWidth = 402
    end
  end
  inherited pgcDados: TPageControl
    Left = 632
    Top = 425
    Width = 165
    Height = 32
    Align = alNone
    TabOrder = 1
    ExplicitLeft = 632
    ExplicitTop = 425
    ExplicitWidth = 165
    ExplicitHeight = 32
    inherited tbsGeral: TTabSheet
      Caption = '1 - Filtros'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 157
    end
    object TabSheet1: TTabSheet
      Caption = '2 - Resultado'
      ImageIndex = 1
    end
  end
  object ntbPaginas: TNotebook [3]
    Left = 0
    Top = 0
    Width = 800
    Height = 541
    Align = alClient
    PageIndex = 1
    TabOrder = 0
    ExplicitWidth = 573
    object TPage
      Left = 0
      Top = 0
      Caption = 'Filtros'
      object pnlFiltros: TPanel
        Left = 0
        Top = 0
        Width = 800
        Height = 541
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = -4
        object lblLinhaGrupoIni: TLabel
          Left = 6
          Top = 4
          Width = 59
          Height = 14
          Caption = 'Linha/Grupo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblProduto: TLabel
          Left = 6
          Top = 114
          Width = 37
          Height = 14
          Caption = 'Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblFornecedor: TLabel
          Left = 6
          Top = 40
          Width = 56
          Height = 14
          Alignment = taRightJustify
          BiDiMode = bdRightToLeft
          Caption = 'Fornecedor'
          ParentBiDiMode = False
        end
        object lblMarca: TLabel
          Left = 6
          Top = 77
          Width = 30
          Height = 14
          Caption = 'Marca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEmpresa: TLabel
          Left = 6
          Top = 187
          Width = 42
          Height = 14
          Caption = 'Empresa'
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
          Top = 358
          Width = 158
          Height = 14
          Caption = 'M'#234's base para Vendas/Compras'
        end
        object Label2: TLabel
          Left = 170
          Top = 358
          Width = 151
          Height = 14
          Caption = 'Composi'#231#227'o do Pre'#231'o de Custo'
        end
        object Label6: TLabel
          Left = 277
          Top = 397
          Width = 48
          Height = 14
          Caption = 'Exibir por:'
        end
        object Label7: TLabel
          Left = 6
          Top = 397
          Width = 148
          Height = 14
          Caption = 'Op'#231#227'o de Pre'#231'o para Estoque:'
        end
        object Label8: TLabel
          Left = 6
          Top = 150
          Width = 91
          Height = 14
          Caption = 'Grupo de Compras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 6
          Top = 16
          Width = 62
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
          TabOrder = 0
          Text = ''
          OnExit = mskLinGruExit
          OnKeyPress = mskLinGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupo: TEditFocus
          Left = 71
          Top = 17
          Width = 492
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodPro: TEditFocus
          Tag = 99
          Left = 6
          Top = 127
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 6
          OnExit = edtCodProExit
          OnKeyPress = edtCodProKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesPro: TEditFocus
          Left = 71
          Top = 127
          Width = 492
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 6
          Top = 53
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 2
          OnExit = edtCodForExit
          OnKeyPress = edtCodForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtNomFor: TEditFocus
          Left = 71
          Top = 53
          Width = 492
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 6
          Top = 90
          Width = 63
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
          OnExit = edtCodMarExit
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMar: TEditFocus
          Left = 71
          Top = 90
          Width = 492
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmpresa: TEditFocus
          Tag = 99
          Left = 6
          Top = 201
          Width = 63
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
          MaxLength = 3
          ParentFont = False
          TabOrder = 9
          OnExit = edtCodEmpresaExit
          OnKeyPress = edtCodEmpresaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesEmpresa: TEditFocus
          Left = 71
          Top = 201
          Width = 492
          Height = 22
          TabStop = False
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
        object mskPeriodo: TMaskEditFocus
          Tag = 99
          Left = 6
          Top = 373
          Width = 158
          Height = 22
          EditMask = '99/9999;1;_'
          MaxLength = 7
          TabOrder = 13
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object cmbComCus: TComboBoxFocus
          Left = 170
          Top = 373
          Width = 393
          Height = 22
          Style = csDropDownList
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object GroupBox1: TGroupBox
          Left = 6
          Top = 439
          Width = 265
          Height = 66
          Caption = 'Dias de Cobertura do Estoque'
          TabOrder = 17
          object Label3: TLabel
            Left = 9
            Top = 17
            Width = 71
            Height = 14
            Caption = 'Nivel de Giro A'
          end
          object Label4: TLabel
            Left = 90
            Top = 17
            Width = 71
            Height = 14
            Caption = 'Nivel de Giro B'
          end
          object Label5: TLabel
            Left = 171
            Top = 17
            Width = 71
            Height = 14
            Caption = 'Nivel de Giro C'
          end
          object edtNivelA: TEditFocus
            Left = 9
            Top = 32
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object edtNivelB: TEditFocus
            Left = 90
            Top = 32
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 1
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object edtNivelC: TEditFocus
            Left = 171
            Top = 32
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 2
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
        end
        object rdgOpcGir: TRadioGroup
          Tag = 99
          Left = 277
          Top = 439
          Width = 286
          Height = 66
          Caption = 'Op'#231#227'o de Giro'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            '3 Meses'
            '6 Meses'
            '12 Meses')
          TabOrder = 18
        end
        object cmbSintetico: TComboBoxFocus
          Left = 277
          Top = 412
          Width = 286
          Height = 22
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 16
          Text = 'Linha'
          Items.Strings = (
            'Linha'
            'Linha/Grupo'
            'Fornecedor'
            'Marca'
            'Anal'#237'tico por Produto')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object cmbOpcPreEst: TComboBoxFocus
          Left = 6
          Top = 412
          Width = 265
          Height = 22
          ItemIndex = 2
          TabOrder = 15
          Text = 'Pre'#231'o de '#218'ltima Compra com Impostos de Entrada'
          Items.Strings = (
            'Pre'#231'o de Custo'
            'Pre'#231'o de '#218'ltima Compra'
            'Pre'#231'o de '#218'ltima Compra com Impostos de Entrada'
            'Pre'#231'o M'#233'dio de Compra')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnExibir: TBitBtnLocked
          Left = 6
          Top = 511
          Width = 148
          Height = 25
          Caption = '&Exibir Resultados'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000000000000000000000000000003C3C
            3CFF3C3C3CFF00000000000000003C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF00000000000000003C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF1E1E1E7E00000000000000003C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF0000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF1E1E
            1E7E0000000000000000000000003C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000
            00000000000000000000000000003C3C3CFF3C3C3CFF00000000000000003C3C
            3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000
            00003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E00000000000000000000
            00000000000000000000000000003C3C3CFF3C3C3CFF00000000000000000000
            00003C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000000000000000000000000000
            00000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000000000000000000000000000
            00000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
            3CFF3C3C3CFF1E1E1E7E00000000000000000000000000000000}
          TabOrder = 19
          OnClick = btnExibirClick
        end
        object edtGruCmp: TEditFocus
          Left = 6
          Top = 164
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 7
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
          Left = 71
          Top = 164
          Width = 492
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 20
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object gpbPedCompra: TGroupBox
          Left = 6
          Top = 229
          Width = 275
          Height = 115
          Caption = 'Produtos do Pedido de Compra'
          TabOrder = 11
          object Label9: TLabel
            Left = 39
            Top = 19
            Width = 69
            Height = 14
            Caption = 'N'#186' Documento'
          end
          object Label10: TLabel
            Left = 154
            Top = 19
            Width = 18
            Height = 14
            Caption = 'Esp'
          end
          object Label11: TLabel
            Left = 199
            Top = 19
            Width = 20
            Height = 14
            Caption = 'Emp'
          end
          object Label12: TLabel
            Left = 39
            Top = 63
            Width = 51
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Inicial'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 140
            Top = 63
            Width = 47
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtNumPcm: TEditFocus
            Tag = 99
            Left = 39
            Top = 35
            Width = 109
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 12
            TabOrder = 0
            OnKeyPress = edtNumPcmKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttNumerico
          end
          object edtEspPcm: TEditFocus
            Tag = 99
            Left = 154
            Top = 35
            Width = 39
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 2
            TabOrder = 1
            OnKeyPress = edtEspPcmKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfabetico
          end
          object edtEmpPcm: TEditFocus
            Tag = 99
            Left = 199
            Top = 35
            Width = 35
            Height = 22
            Alignment = taCenter
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 2
            OnKeyPress = edtEmpPcmKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object mskIniPcm: TMaskEditFocus
            Tag = 99
            Left = 39
            Top = 79
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999;1;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 3
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object mskFinPcm: TMaskEditFocus
            Tag = 99
            Left = 140
            Top = 79
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999;1;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 4
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
        end
        object gpbNFEntrada: TGroupBox
          Left = 288
          Top = 229
          Width = 275
          Height = 115
          Caption = 'Documentos de Entrada'
          TabOrder = 12
          object Label14: TLabel
            Left = 39
            Top = 19
            Width = 69
            Height = 14
            Caption = 'N'#186' Documento'
          end
          object Label15: TLabel
            Left = 154
            Top = 19
            Width = 18
            Height = 14
            Caption = 'Esp'
          end
          object Label16: TLabel
            Left = 199
            Top = 19
            Width = 20
            Height = 14
            Caption = 'Emp'
          end
          object Label17: TLabel
            Left = 39
            Top = 63
            Width = 51
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Inicial'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 140
            Top = 63
            Width = 47
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtNumNfe: TEditFocus
            Tag = 99
            Left = 39
            Top = 35
            Width = 109
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 12
            TabOrder = 0
            OnKeyPress = edtNumNfeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttNumerico
          end
          object edtEspNfe: TEditFocus
            Tag = 99
            Left = 154
            Top = 35
            Width = 39
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 2
            TabOrder = 1
            OnKeyPress = edtEspNfeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfabetico
          end
          object edtEmpNfe: TEditFocus
            Tag = 99
            Left = 199
            Top = 35
            Width = 35
            Height = 22
            Alignment = taCenter
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 2
            OnKeyPress = edtEmpNfeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object mskIniNfe: TMaskEditFocus
            Tag = 99
            Left = 39
            Top = 79
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999;1;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 3
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object mskFinNfe: TMaskEditFocus
            Tag = 99
            Left = 140
            Top = 79
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999;1;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 4
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Resultados'
      ExplicitWidth = 573
      object pnlGrid: TPanel
        Left = 0
        Top = 0
        Width = 800
        Height = 541
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 573
        object dbgDados: TcxGrid
          Left = 0
          Top = 0
          Width = 800
          Height = 516
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          ExplicitWidth = 573
          object dbgDadosDBBandedTableView: TcxGridDBBandedTableView
            OnMouseMove = dbgDadosDBBandedTableViewMouseMove
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = dbgDadosDBBandedTableViewCustomDrawCell
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colESTBRU
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colQTDITE
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colFATURA
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colCUMVEN
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colRESULT
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colEXCESS
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colSEMMOV
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colESTREA
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colESTOBJ
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colESTIDE
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colCUSCOM
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Column = colCOMEXC
              end>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir o filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracImmediately
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            Bands = <
              item
                Caption = 'Sint'#233'tico'
                FixedKind = fkLeft
                Options.HoldOwnColumnsOnly = True
                Options.Moving = False
                Width = 493
              end
              item
                Caption = 'Resultado'
                Width = 2341
              end>
            object colGRUPO: TcxGridDBBandedColumn
              DataBinding.FieldName = 'GRUPO'
              Options.Editing = False
              Width = 90
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object colDESGRU: TcxGridDBBandedColumn
              Caption = 'DESCRI'#199#195'O'
              DataBinding.FieldName = 'DESGRU'
              Width = 193
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object colSIGUNI: TcxGridDBBandedColumn
              Caption = 'UN.'
              DataBinding.FieldName = 'SIGUNI'
              Width = 33
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object colCODFAB: TcxGridDBBandedColumn
              Caption = 'C'#211'D. F'#193'BRICA'
              DataBinding.FieldName = 'CODFAB'
              Width = 109
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object colITECODITE: TcxGridDBBandedColumn
              Caption = 'COD. ITEM'
              DataBinding.FieldName = 'ITECODITE'
              Position.BandIndex = 0
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object colITEDESITE: TcxGridDBBandedColumn
              Caption = 'DESC. ITEM'
              DataBinding.FieldName = 'ITEDESITE'
              Position.BandIndex = 0
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object colDIAEST: TcxGridDBBandedColumn
              Caption = 'DIAS EST.'
              DataBinding.FieldName = 'DIAEST'
              Width = 68
              Position.BandIndex = 0
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object colQTDITE: TcxGridDBBandedColumn
              Caption = 'QTD.ITENS'
              DataBinding.FieldName = 'QTDITE'
              Options.Editing = False
              Width = 65
              Position.BandIndex = 1
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object colFATURA: TcxGridDBBandedColumn
              Caption = 'FATURAMENTO'
              DataBinding.FieldName = 'FATURA'
              Options.Editing = False
              Width = 92
              Position.BandIndex = 1
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object colQTDFAT: TcxGridDBBandedColumn
              Caption = 'QTD. ITENS FAT.'
              DataBinding.FieldName = 'QTDFAT'
              Width = 95
              Position.BandIndex = 1
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object colCUMVEN: TcxGridDBBandedColumn
              Caption = 'CUSTO MERC. VENDIDA'
              DataBinding.FieldName = 'CUMVEN'
              Options.Editing = False
              Width = 137
              Position.BandIndex = 1
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object colRESULT: TcxGridDBBandedColumn
              Caption = 'RESULTADO'
              DataBinding.FieldName = 'RESULT'
              Options.Editing = False
              Width = 73
              Position.BandIndex = 1
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object colMARKUP: TcxGridDBBandedColumn
              DataBinding.FieldName = 'MARKUP'
              Options.Editing = False
              Width = 58
              Position.BandIndex = 1
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
            object colMARGEM: TcxGridDBBandedColumn
              DataBinding.FieldName = 'MARGEM'
              Options.Editing = False
              Width = 56
              Position.BandIndex = 1
              Position.ColIndex = 6
              Position.RowIndex = 0
            end
            object colESTBRU: TcxGridDBBandedColumn
              Caption = 'ESTOQUE BRUTO'
              DataBinding.FieldName = 'ESTBRU'
              Options.Editing = False
              Width = 110
              Position.BandIndex = 1
              Position.ColIndex = 7
              Position.RowIndex = 0
            end
            object colEXCESS: TcxGridDBBandedColumn
              Caption = 'ESTOQUE EXCESSO'
              DataBinding.FieldName = 'EXCESS'
              Options.Editing = False
              Width = 123
              Position.BandIndex = 1
              Position.ColIndex = 8
              Position.RowIndex = 0
            end
            object colQTDEXC: TcxGridDBBandedColumn
              Caption = 'QTD. ITEM EXCESSO'
              DataBinding.FieldName = 'QTDEXC'
              Width = 117
              Position.BandIndex = 1
              Position.ColIndex = 9
              Position.RowIndex = 0
            end
            object colSEMMOV: TcxGridDBBandedColumn
              Caption = 'ESTOQUE SEM MOVIMENTO'
              DataBinding.FieldName = 'SEMMOV'
              Options.Editing = False
              Width = 155
              Position.BandIndex = 1
              Position.ColIndex = 10
              Position.RowIndex = 0
            end
            object colQTDSMO: TcxGridDBBandedColumn
              Caption = 'QTD. ITEM SEM MOVIMENTO'
              DataBinding.FieldName = 'QTDSMO'
              Width = 153
              Position.BandIndex = 1
              Position.ColIndex = 11
              Position.RowIndex = 0
            end
            object colESTREA: TcxGridDBBandedColumn
              Caption = 'ESTOQUE REAL'
              DataBinding.FieldName = 'ESTREA'
              Options.Editing = False
              Width = 96
              Position.BandIndex = 1
              Position.ColIndex = 12
              Position.RowIndex = 0
            end
            object colESTOBJ: TcxGridDBBandedColumn
              Caption = 'ESTOQUE OBJETIVO'
              DataBinding.FieldName = 'ESTOBJ'
              Options.Editing = False
              Width = 114
              Position.BandIndex = 1
              Position.ColIndex = 13
              Position.RowIndex = 0
            end
            object colQTDOBJ: TcxGridDBBandedColumn
              Caption = 'QTD. ITEM "OBJETIVO"'
              DataBinding.FieldName = 'QTDOBJ'
              Width = 132
              Position.BandIndex = 1
              Position.ColIndex = 14
              Position.RowIndex = 0
            end
            object colESTIDE: TcxGridDBBandedColumn
              Caption = 'ESTOQUE IDEAL'
              DataBinding.FieldName = 'ESTIDE'
              Options.Editing = False
              Width = 92
              Position.BandIndex = 1
              Position.ColIndex = 15
              Position.RowIndex = 0
            end
            object colCUSCOM: TcxGridDBBandedColumn
              Caption = 'CUSTO MERC.COMPRADA'
              DataBinding.FieldName = 'CUSCOM'
              Options.Editing = False
              Width = 142
              Position.BandIndex = 1
              Position.ColIndex = 16
              Position.RowIndex = 0
            end
            object colQTDCOM: TcxGridDBBandedColumn
              Caption = 'QTD. COMPRA'
              DataBinding.FieldName = 'QTDCOM'
              Width = 87
              Position.BandIndex = 1
              Position.ColIndex = 17
              Position.RowIndex = 0
            end
            object colCOMEXC: TcxGridDBBandedColumn
              Caption = 'COMPRAS EXCESSO'
              DataBinding.FieldName = 'COMEXC'
              Options.Editing = False
              Width = 122
              Position.BandIndex = 1
              Position.ColIndex = 18
              Position.RowIndex = 0
            end
            object colEXCCOM: TcxGridDBBandedColumn
              Caption = 'QTD. ITEM COMPRADOS EXCESSO'
              DataBinding.FieldName = 'EXCCOM'
              Width = 186
              Position.BandIndex = 1
              Position.ColIndex = 19
              Position.RowIndex = 0
            end
            object colREPRES: TcxGridDBBandedColumn
              Caption = '% EXCESSO DE COMPRA'
              DataBinding.FieldName = 'REPRES'
              Width = 135
              Position.BandIndex = 1
              Position.ColIndex = 20
              Position.RowIndex = 0
            end
            object colAGRUPA: TcxGridDBBandedColumn
              Caption = 'Item'
              DataBinding.FieldName = 'CODITE'
              Visible = False
              Position.BandIndex = 1
              Position.ColIndex = 21
              Position.RowIndex = 0
            end
          end
          object dbgDadosLevel1: TcxGridLevel
            GridView = dbgDadosDBBandedTableView
          end
        end
        object pnlButtom: TPanel
          Left = 0
          Top = 516
          Width = 800
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          ExplicitWidth = 573
          object btnVoltar: TBitBtnLocked
            Left = 0
            Top = 0
            Width = 290
            Height = 25
            Align = alClient
            Caption = '&Voltar'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000707071D0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000001E1E1E81292929B00707071D00000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000606061A2D2D2DBF3C3C3CFF1A1A1A7000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000181818663C3C3CFF2B2B2BB700000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000707071F3C3C3CFF373737EA00000000000000000000
              00003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000
              000000000000000000000707071F3C3C3CFF373737EA00000000000000000000
              00003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E00000000000000000000
              00000000000000000000181818663C3C3CFF2B2B2BB700000000000000000000
              00003C3C3CFF3C3C3CFF3C3C3CFF343434DF0C0C0C3300000000000000000000
              0000000000000C0C0C332D2D2DBF3C3C3CFF1A1A1A7000000000000000000000
              00003C3C3CFF3C3C3CFF333333D73C3C3CFF2D2D2DBF181818660707071F0707
              071F181818662D2D2DBF3C3C3CFF292929B00707071D00000000000000000000
              00003C3C3CFF1E1E1E7E0D0D0D39292929B03C3C3CFF3C3C3CFF3C3C3CFF3C3C
              3CFF3C3C3CFF3C3C3CFF292929B00D0D0D390000000000000000000000000000
              00001E1E1E7E00000000000000000707071D1A1A1A702B2B2BB7373737EA3737
              37EA2B2B2BB71A1A1A700707071D000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            TabOrder = 0
            OnClick = btnVoltarClick
            ExplicitWidth = 233
          end
          object btnExcel: TBitBtnLocked
            Left = 630
            Top = 0
            Width = 170
            Height = 25
            Align = alRight
            Caption = '&Exportar para Excel'
            TabOrder = 1
            OnClick = btnExcelClick
            ExplicitLeft = 403
          end
          object btnGeraTE: TBitBtnLocked
            Left = 290
            Top = 0
            Width = 170
            Height = 25
            Align = alRight
            Caption = '[ F4 ] Gerar Transf. de Estoque'
            TabOrder = 2
            OnClick = btnGeraTEClick
            ExplicitLeft = 233
          end
          object btnSelCampos: TBitBtnLocked
            Left = 460
            Top = 0
            Width = 170
            Height = 25
            Align = alRight
            Caption = '&Campos para Exporta'#231#227'o'
            TabOrder = 3
            OnClick = btnSelCamposClick
            ExplicitLeft = 466
            ExplicitTop = -4
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 104
  end
end
