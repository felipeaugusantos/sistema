inherited frmRelEstItemsAbaixoMin: TfrmRelEstItemsAbaixoMin
  Left = 390
  Top = 130
  Width = 1029
  Height = 567
  Caption = 'Relat'#243'rio de Produtos com Saldo Abaixo do M'#237'nimo'
  ExplicitWidth = 1029
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 1023
    TabOrder = 2
    ExplicitTop = 496
    ExplicitWidth = 1023
    inherited FlwBotoes: TFlowPanel
      Width = 942
      ExplicitWidth = 942
      object btnGerOrc: TBitBtnLocked
        Left = 154
        Top = 0
        Width = 199
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Gerar Or'#231'amento/Pedido para T.E.'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
          055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
          305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
          30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
          3055577777555557F7F555000555555999555577755555577755}
        NumGlyphs = 2
        TabOrder = 2
        Visible = False
        OnClick = btnGerOrcClick
      end
      object btnAltOrc: TBitBtnLocked
        Left = 353
        Top = 0
        Width = 154
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Alterar Or'#231'amento/Pedido'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
          055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
          305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
          30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
          3055577777555557F7F555000555555999555577755555577755}
        NumGlyphs = 2
        TabOrder = 3
        Visible = False
        OnClick = btnAltOrcClick
      end
      object pgbProgresso: TcxProgressBar
        Left = 507
        Top = 0
        TabOrder = 4
        Visible = False
        Width = 429
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 944
      ExplicitLeft = 944
    end
  end
  inherited pnlStatus: TPanel
    Top = 522
    Width = 1023
    TabOrder = 3
    ExplicitTop = 522
    ExplicitWidth = 1023
    inherited pnlNomeForm: TPanel
      Left = 852
      ExplicitLeft = 852
    end
    inherited pnlInfo: TPanel
      Width = 852
      ExplicitWidth = 852
      inherited shpMultSel: TShape
        Left = 1
        ExplicitLeft = 1
      end
    end
  end
  inherited pnlDados: TPanel
    Top = 449
    Width = 1023
    Height = 47
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 449
    ExplicitWidth = 1023
    ExplicitHeight = 47
    inherited gpbDestino: TGroupBox
      Left = 746
      Top = 2
      Width = 280
      Height = 38
      ExplicitLeft = 746
      ExplicitTop = 2
      ExplicitWidth = 280
      ExplicitHeight = 38
      inherited ColorLabel1: TColorLabel
        Left = 31
        Top = 17
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 31
        ExplicitTop = 17
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 14
        ExplicitTop = 14
      end
    end
  end
  object pgcControl: TPageControl [3]
    Left = 0
    Top = 0
    Width = 1023
    Height = 449
    ActivePage = tbsFiltros1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object tbsFiltros1: TTabSheet
      Caption = '1 - Filtros dos produtos... '
      ExplicitWidth = 1014
      object cxGroupBox5: TcxGroupBox
        Left = 3
        Top = -3
        Caption = 'Filtros para os Produtos:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Height = 420
        Width = 722
        object Label9: TLabel
          Left = 39
          Top = 80
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
        object Label10: TLabel
          Left = 43
          Top = 103
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
        object Label11: TLabel
          Left = 68
          Top = 126
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
          Left = 7
          Top = 195
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
        object Label14: TLabel
          Left = 31
          Top = 172
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
        object Label1: TLabel
          Left = 45
          Top = 241
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 397
          Top = 220
          Width = 27
          Height = 14
          Caption = 'Unid.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 234
          Top = 241
          Width = 79
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acordo de Obj. :'
        end
        object lblEmpresa: TLabel
          Left = 56
          Top = 266
          Width = 48
          Height = 14
          Caption = 'Empresa.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label3: TLabel
          Left = 10
          Top = 149
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Produto.:'
        end
        object lblDescricao: TLabel
          Left = 49
          Top = 218
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblSitPro: TLabel
          Left = 3
          Top = 287
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o do Produto:'
        end
        object lblSitProExc: TLabel
          Left = 14
          Top = 311
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sit. Prod a excluir:'
        end
        object grpDadosNE: TGroupBox
          Left = 4
          Top = 15
          Width = 712
          Height = 51
          Caption = 'Dados da Nota de Entrada'
          TabOrder = 0
          TabStop = True
          object Label6: TLabel
            Left = 6
            Top = 12
            Width = 54
            Height = 14
            Caption = 'Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblEspecie: TLabel
            Left = 97
            Top = 12
            Width = 38
            Height = 14
            Caption = 'Esp'#233'cie'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblSerie: TLabel
            Left = 139
            Top = 12
            Width = 25
            Height = 14
            Caption = 'S'#233'rie'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblEmpresaNE: TLabel
            Left = 171
            Top = 12
            Width = 42
            Height = 14
            Caption = 'Empresa'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 376
            Top = 12
            Width = 56
            Height = 14
            Caption = 'Fornecedor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 580
            Top = 12
            Width = 51
            Height = 14
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
            Left = 645
            Top = 12
            Width = 47
            Height = 14
            Caption = 'Data Final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtDocumento: TEditFocus
            Left = 6
            Top = 26
            Width = 88
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 12
            ParentFont = False
            TabOrder = 0
            OnExit = edtDocumentoExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttNumerico
          end
          object edtEspecie: TEditFocus
            Tag = 99
            Left = 97
            Top = 26
            Width = 38
            Height = 21
            Alignment = taLeftJustify
            AutoSize = False
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 1
            Text = 'NF'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfabetico
          end
          object edtSerie: TEditFocus
            Left = 139
            Top = 26
            Width = 29
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
          object edtCodEmpresaNE: TEditFocus
            Tag = 99
            Left = 171
            Top = 26
            Width = 38
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 3
            OnExit = edtCodEmpresaNEExit
            OnKeyPress = edtCodEmpresaNEKeyPress
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesEmpresaNE: TEditFocus
            Left = 212
            Top = 26
            Width = 160
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            TabOrder = 4
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtForNot: TEditFocus
            Tag = 99
            Left = 376
            Top = 26
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
            OnExit = edtForNotExit
            OnKeyPress = edtForNotKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtDesForNot: TEditFocus
            Left = 436
            Top = 26
            Width = 142
            Height = 22
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            TabOrder = 6
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskDtaEntIni: TMaskEditFocus
            Tag = 99
            Left = 580
            Top = 26
            Width = 62
            Height = 22
            EditMask = '99/99/9999;1;_'
            MaxLength = 10
            TabOrder = 7
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object mskDtaEntFin: TMaskEditFocus
            Tag = 99
            Left = 645
            Top = 26
            Width = 62
            Height = 22
            EditMask = '99/99/9999;1;_'
            MaxLength = 10
            TabOrder = 8
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
        end
        object mskLinhaGrupo: TMaskEditFocus
          Tag = 99
          Left = 107
          Top = 77
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
          TabOrder = 1
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
          Left = 165
          Top = 77
          Width = 300
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
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
          Left = 107
          Top = 100
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
          Left = 165
          Top = 100
          Width = 300
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
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
          Left = 107
          Top = 123
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
          TabOrder = 5
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
          Left = 165
          Top = 123
          Width = 300
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesGruCmp: TEditFocus
          Left = 165
          Top = 192
          Width = 300
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
        object edtDesCodDep: TEditFocus
          Left = 165
          Top = 169
          Width = 300
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 10
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
          Left = 107
          Top = 169
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
          TabOrder = 9
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
        object edtRefere: TEditFocus
          Tag = 99
          Left = 107
          Top = 238
          Width = 123
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
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtUnidade: TEditFocus
          Tag = 99
          Left = 427
          Top = 215
          Width = 38
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
          MaxLength = 2
          ParentFont = False
          TabOrder = 14
          OnExit = edtUnidadeExit
          OnKeyPress = edtUnidadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAcoObj: TEditFocus
          Tag = 99
          Left = 315
          Top = 238
          Width = 150
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmpresa: TEditFocus
          Tag = 99
          Left = 107
          Top = 261
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 17
          Visible = False
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
          Left = 165
          Top = 261
          Width = 300
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 18
          Visible = False
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkInativoCompra: TCheckBox
          Left = 5
          Top = 330
          Width = 161
          Height = 14
          Hint = 'Incluir Inativos para Compra'
          Caption = 'Incluir Inativos para Compra'
          TabOrder = 23
        end
        object rdgStatus: TRadioGroup
          Left = 468
          Top = 261
          Width = 244
          Height = 33
          Caption = 'Status'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Ativos'
            'Inativos'
            'Todos')
          TabOrder = 33
        end
        object rdgEstMin: TRadioGroup
          Left = 4
          Top = 344
          Width = 458
          Height = 33
          Caption = 'Somente itens com Saldo'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Menor ou igual que o estoque m'#237'nimo'
            'Menor que o estoque m'#237'nimo')
          TabOrder = 26
          OnClick = rdgEstMinClick
        end
        object rdgCompraCentr: TRadioGroup
          Left = 4
          Top = 377
          Width = 458
          Height = 35
          Caption = 'Modalidade de compra'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Centralizado no CD.'
            'N'#227'o Centralizado no CD.'
            'Todos')
          TabOrder = 27
        end
        object rdgNecCompra: TRadioGroup
          Left = 468
          Top = 208
          Width = 244
          Height = 36
          Caption = 'Necessidade de Compra'
          Columns = 2
          ItemIndex = 1
          Items.Strings = (
            'Maior que zero'
            'Todos')
          TabOrder = 31
        end
        object GroupBox4: TcxGroupBox
          Left = 468
          Top = 296
          Caption = 'N'#237'vel de Giro'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.Shadow = True
          Style.IsFontAssigned = True
          TabOrder = 34
          Height = 36
          Width = 244
          object ColorLabel8: TColorLabel
            Left = 34
            Top = 15
            Width = 186
            Height = 14
            Caption = 'N'#237'vel (A)   N'#237'vel(B)   N'#237'vel (C)   (T)odos'
            CorDestaque = clRed
          end
          object edtGirEst: TEditFocus
            Tag = 99
            Left = 10
            Top = 12
            Width = 18
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            TabOrder = 0
            Text = 'T'
            OnExit = edtDestinoExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfabetico
          end
        end
        object rdgLocFis: TRadioGroup
          Left = 468
          Top = 70
          Width = 113
          Height = 65
          Caption = 'Localiza'#231#227'o F'#237'sica'
          ItemIndex = 2
          Items.Strings = (
            'Com Localiza'#231#227'o'
            'Sem Localiza'#231#227'o'
            'Todos')
          TabOrder = 28
        end
        object rdgSaldo: TRadioGroup
          Left = 468
          Top = 135
          Width = 113
          Height = 75
          Caption = 'Saldo Atual'
          ItemIndex = 2
          Items.Strings = (
            'Maior que zero'
            'Zero'
            'Todos'
            'Menor que zero')
          TabOrder = 30
        end
        object chkImpRef: TCheckBox
          Left = 181
          Top = 330
          Width = 125
          Height = 14
          Caption = 'Imprimir Refer'#234'ncia?'
          TabOrder = 24
        end
        object chkLinGru: TCheckBox
          Left = 337
          Top = 330
          Width = 125
          Height = 14
          Caption = 'Imprimir Linha/Grupo?'
          TabOrder = 25
        end
        object edtGruCmp: TEditFocus
          Tag = 99
          Left = 107
          Top = 192
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
          TabOrder = 11
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
        object edtPrdGru: TEditFocus
          Tag = 99
          Left = 107
          Top = 146
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 7
          OnExit = edtPrdGruExit
          OnKeyPress = edtPrdGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesPrdGru: TEditFocus
          Left = 164
          Top = 146
          Width = 301
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 8
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
          Left = 107
          Top = 215
          Width = 285
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
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkDesIte: TCheckBox
          Left = 478
          Top = 245
          Width = 216
          Height = 17
          Caption = 'Imprimir os dados em uma '#250'nica linha'
          TabOrder = 32
          OnClick = chkDesIteClick
        end
        object rdgLocFisProdSimilar: TRadioGroup
          Left = 582
          Top = 70
          Width = 130
          Height = 65
          Caption = 'Loc. F'#237'sica Prod. Similar'
          Enabled = False
          ItemIndex = 2
          Items.Strings = (
            'Com Localiza'#231#227'o'
            'Sem Localiza'#231#227'o'
            'Todos')
          TabOrder = 29
        end
        object rdgImpLis: TRadioGroup
          Left = 582
          Top = 135
          Width = 130
          Height = 65
          Caption = 'Imprime Lista'
          ItemIndex = 2
          Items.Strings = (
            'Sim'
            'N'#227'o'
            'Todos')
          TabOrder = 35
        end
        object edtDesSitPro: TEditFocus
          Left = 165
          Top = 284
          Width = 300
          Height = 22
          TabStop = False
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
        object edtCodSitPro: TEditFocus
          Tag = 99
          Left = 107
          Top = 284
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 19
          OnExit = edtCodSitProExit
          OnKeyPress = edtCodSitProKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtCodSitProExc: TEditFocus
          Tag = 99
          Left = 107
          Top = 307
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 21
          OnExit = edtCodSitProExcExit
          OnKeyPress = edtCodSitProExcKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesSitProExc: TEditFocus
          Left = 165
          Top = 307
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 22
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object pnlParamCompras: TPanel
          Left = 471
          Top = 338
          Width = 241
          Height = 69
          BevelOuter = bvNone
          TabOrder = 36
          object rdgTipAbs: TGroupBox
            Left = 0
            Top = 0
            Width = 241
            Height = 35
            Align = alTop
            Caption = 'Tipo de abastecimento'
            TabOrder = 0
            object chkTipAbaFabrica: TCheckBox
              Left = 8
              Top = 14
              Width = 68
              Height = 17
              Caption = 'F'#225'brica'
              TabOrder = 0
            end
            object chkTipAbaCD: TCheckBox
              Left = 86
              Top = 13
              Width = 68
              Height = 17
              Caption = 'CD'
              TabOrder = 1
            end
            object chkTipAbaAmbos: TCheckBox
              Left = 162
              Top = 12
              Width = 68
              Height = 17
              Caption = 'Ambos'
              TabOrder = 2
            end
          end
          object rdgPolEstTipVenda: TGroupBox
            Left = 0
            Top = 35
            Width = 241
            Height = 37
            Align = alTop
            Caption = 'Pol'#237'tica de estoque para venda'
            TabOrder = 1
            object chkPolEstLoja: TCheckBox
              Left = 8
              Top = 16
              Width = 68
              Height = 17
              Caption = 'Loja'
              TabOrder = 0
            end
            object chkPolEstFiliais: TCheckBox
              Left = 86
              Top = 16
              Width = 68
              Height = 17
              Caption = 'Filiais'
              TabOrder = 1
            end
          end
        end
      end
      object cxGroupBox4: TcxGroupBox
        Left = 723
        Top = -3
        Caption = 'Exibi'#231#227'o'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 1
        Height = 420
        Width = 292
        object GroupBox1: TGroupBox
          Left = 4
          Top = 15
          Width = 282
          Height = 191
          Caption = 'Imprimir Coluna'
          TabOrder = 0
          object lblBasGir: TLabel
            Left = 2
            Top = 133
            Width = 278
            Height = 14
            Align = alBottom
            Caption = 'Base para C'#225'lculo de vendas (M'#234's/Ano): '
            ExplicitWidth = 202
          end
          object lstBasGir: TCheckListBox
            Tag = 99
            Left = 2
            Top = 147
            Width = 278
            Height = 42
            OnClickCheck = lstBasGirClickCheck
            Align = alBottom
            Columns = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            ParentFont = False
            TabOrder = 2
          end
          object rdgVendas: TGroupBox
            Left = 2
            Top = 75
            Width = 278
            Height = 59
            Align = alTop
            Caption = 'Calcular Vendas Por'
            TabOrder = 1
            object lblSelMes: TLabel
              Left = 118
              Top = 29
              Width = 133
              Height = 28
              Cursor = crHandPoint
              Caption = 'Clique aqui para selecionar os meses'
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsUnderline]
              ParentFont = False
              WordWrap = True
              OnClick = lblSelMesClick
            end
            object lblQtdMesDia: TLabel
              Left = 117
              Top = 14
              Width = 76
              Height = 14
              Caption = 'Quantidade  de '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblMesDia: TLabel
              Left = 244
              Top = 14
              Width = 21
              Height = 14
              Caption = 'Dias'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object rdbCalcVendaPorDia: TRadioButton
              Left = 11
              Top = 12
              Width = 56
              Height = 17
              Caption = 'Dias'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = rdbCalcVendaPorDiaClick
            end
            object rdbCalcVendasPorMes: TRadioButton
              Left = 56
              Top = 12
              Width = 61
              Height = 17
              Caption = 'Meses'
              TabOrder = 1
              OnClick = rdbCalcVendasPorMesClick
            end
            object chkInfMes: TCheckBox
              Left = 14
              Top = 28
              Width = 97
              Height = 16
              Caption = 'Informar meses'
              Enabled = False
              TabOrder = 4
              OnClick = chkInfMesClick
            end
            object edtDias: TEditFocus
              Tag = 99
              Left = 198
              Top = 11
              Width = 40
              Height = 22
              Alignment = taRightJustify
              TabOrder = 2
              Text = '0'
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttInteiro
            end
            object cmbMeses: TComboBoxFocus
              Left = 198
              Top = 11
              Width = 40
              Height = 22
              Style = csOwnerDrawFixed
              ItemIndex = 0
              TabOrder = 3
              Text = '03'
              Items.Strings = (
                '03'
                '06'
                '12')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object GroupBox3: TGroupBox
            Left = 2
            Top = 16
            Width = 278
            Height = 59
            Align = alTop
            TabOrder = 0
            object rdbCompras: TRadioButton
              Left = 3
              Top = 4
              Width = 72
              Height = 17
              Caption = 'Compras'
              TabOrder = 0
              OnClick = rdbComprasClick
            end
            object rdbLocFis: TRadioButton
              Left = 3
              Top = 23
              Width = 163
              Height = 17
              Caption = 'Local. F'#237'sica / Super estoque'
              TabOrder = 3
              OnClick = rdbLocFisClick
            end
            object rdbQtdVen: TRadioButton
              Left = 89
              Top = 4
              Width = 60
              Height = 17
              Caption = 'Vendas'
              TabOrder = 1
              OnClick = rdbQtdVenClick
            end
            object rdbCodFab: TRadioButton
              Left = 167
              Top = 4
              Width = 98
              Height = 17
              Caption = 'C'#243'digo F'#225'brica'
              TabOrder = 2
              OnClick = rdbCodFabClick
            end
            object rdbEntFut: TRadioButton
              Left = 3
              Top = 39
              Width = 141
              Height = 17
              Caption = 'Entrega Futura Pendente'
              TabOrder = 4
              OnClick = rdbLocFisClick
            end
            object chkNivelGiro: TCheckBox
              Left = 167
              Top = 23
              Width = 98
              Height = 17
              Caption = 'N'#237'vel de giro'
              TabOrder = 5
            end
            object chkUltCompra: TCheckBox
              Left = 167
              Top = 39
              Width = 98
              Height = 17
              Caption = #218'ltima compra'
              TabOrder = 6
            end
          end
        end
        object rdgOrdem: TRadioGroup
          Left = 7
          Top = 212
          Width = 280
          Height = 119
          Caption = 'Ordem'
          ItemIndex = 0
          Items.Strings = (
            'Descri'#231#227'o do Produto'
            'Linha/Grupo'
            'Fornecedor'
            'Marca'
            'Localiza'#231#227'o F'#237'sica'
            'Grupo de Unidade + Loc. F'#237'sicao + Loc.Super Est.'
            'Unidade do Produto')
          TabOrder = 1
        end
        object chkImpSimilares: TCheckBox
          Left = 10
          Top = 333
          Width = 269
          Height = 25
          Caption = 
            'Listar os produtos similares com saldo de estoque na empresa de ' +
            'destino.'
          TabOrder = 2
          WordWrap = True
          OnClick = chkImpSimilaresClick
        end
      end
    end
    object tbsFiltros2: TTabSheet
      Caption = '2 - C'#225'lculo da quantidade...'
      ImageIndex = 1
      object cxGroupBox3: TcxGroupBox
        Left = 3
        Top = 3
        Caption = 'C'#225'lculo da Quantidade de Sugest'#227'o'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Height = 267
        Width = 509
        object chkSalResEmp: TCheckBox
          Left = 7
          Top = 15
          Width = 400
          Height = 17
          Caption = 
            'Descontar Saldo Reservado do Saldo da Empresa Destino(Pedido e G' +
            'arantia)'
          TabOrder = 0
        end
        object chkSalTransf: TCheckBox
          Left = 7
          Top = 32
          Width = 403
          Height = 16
          Caption = 
            'Considerar Pedidos de Transfer'#234'ncia no Saldo da Empresa de Desti' +
            'no  '
          TabOrder = 1
          WordWrap = True
        end
        object chkAdicOrdProduAberta: TCheckBox
          Left = 7
          Top = 63
          Width = 430
          Height = 17
          Caption = 
            'Subtrair da Necessidade de Compra a Quantidade em aberto na Orde' +
            'm de Produ'#231#227'o'
          TabOrder = 4
        end
        object grpEntFut: TcxGroupBox
          Left = 7
          Top = 94
          Caption = 'Considerar Entrega Futura Pendente'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.Shadow = True
          Style.IsFontAssigned = True
          TabOrder = 6
          Height = 35
          Width = 430
          object chkFaltaProduto: TCheckBox
            Left = 9
            Top = 14
            Width = 97
            Height = 17
            Caption = 'Falta de Produto'
            TabOrder = 0
            StyleElements = [seFont]
          end
          object chkPrevisaoEntrega: TCheckBox
            Left = 145
            Top = 14
            Width = 121
            Height = 17
            Caption = 'Previs'#227'o de Entrega'
            TabOrder = 1
            StyleElements = [seFont]
          end
          object chkAguardandoCliente: TCheckBox
            Left = 296
            Top = 14
            Width = 120
            Height = 17
            Caption = 'Aguardando Cliente'
            TabOrder = 2
            StyleElements = [seFont]
          end
        end
        object rdgCalMinMax: TRadioGroup
          Left = 7
          Top = 129
          Width = 161
          Height = 33
          Caption = 'Calcular pelo estoque'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'M'#237'nimo'
            'M'#225'ximo')
          TabOrder = 7
        end
        object rdgTipoMultiplo: TRadioGroup
          Left = 174
          Top = 129
          Width = 303
          Height = 33
          Caption = 'Considerar abastecimento com m'#250'ltiplo de'
          Columns = 3
          ItemIndex = 1
          Items.Strings = (
            'Compra'
            'N'#227'o Considerar'
            'Venda')
          TabOrder = 8
          OnEnter = rdgTipoMultiploEnter
          OnExit = rdgTipoMultiploExit
        end
        object rdgAnaEmp: TRadioGroup
          Left = 7
          Top = 166
          Width = 430
          Height = 33
          Caption = 'An'#225'lise das Empresas'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Cada empresa separadamente'
            'Todas as empresas juntas')
          TabOrder = 11
        end
        object chkPedCom: TCheckBox
          Left = 7
          Top = 47
          Width = 212
          Height = 17
          Caption = 'Considerar pedido de compra pendente'
          TabOrder = 2
        end
        object chkPedComGar: TCheckBox
          Left = 222
          Top = 47
          Width = 215
          Height = 17
          Caption = 'Considerar pedido de compra - Garantia'
          TabOrder = 3
        end
        object chkPontoExposicao: TCheckBox
          Left = 7
          Top = 79
          Width = 299
          Height = 17
          Caption = 'Utilizar regras de ponto de exposi'#231#227'o para Abastecimento'
          TabOrder = 5
          OnClick = chkPontoExposicaoClick
        end
        object rdgGirEst: TRadioGroup
          Left = 7
          Top = 203
          Width = 258
          Height = 50
          Caption = 'Giro de Estoque - Venda'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'N'#227'o visualizar'
            'Visualizar 3 meses'
            'Visualizar 6 meses'
            'Visualizar 12 meses')
          TabOrder = 9
          OnClick = rdgGirEstClick
        end
        object chkMesAtu: TCheckBox
          Left = 282
          Top = 218
          Width = 125
          Height = 17
          Caption = 'Considerar m'#234's atual'
          Enabled = False
          TabOrder = 10
        end
        object btnHlpImp: TBitBtnLocked
          Left = 303
          Top = 78
          Width = 24
          Height = 20
          Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta filtro.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000010000000800000010000000100000
            0008000000010000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
            0B60000000070000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
            27EA0000000E0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
            30EC0000000D0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
            1A51000000050000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000010000000600000011000000140000
            000A000000020000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000670503AA999532EFF4528
            187A000000070000000100000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
            4AF724150D490000000800000002000000000000000000000000000000000000
            0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
            9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
            000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
            AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
            00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
            76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
            000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
            70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
            000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
            C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
            0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
            77E570533B9A17100A2500000002000000000000000000000000000000000000
            0000000000000000000000000000000000010000000100000002000000030000
            0002000000020000000100000000000000000000000000000000}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          OnClick = btnHlpImpClick
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 513
        Top = 3
        Caption = 'Empresa CD'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 1
        Height = 267
        Width = 509
        object Label17: TLabel
          Left = 7
          Top = 16
          Width = 48
          Height = 14
          Caption = 'Empresa.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblPerGra: TLabel
          Left = 7
          Top = 178
          Width = 312
          Height = 14
          Caption = 'Pool de Abastecimento - Percentual de Abastecimento Gradativo:'
        end
        object edtEmpCD: TEditFocus
          Tag = 99
          Left = 56
          Top = 13
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 0
          OnExit = edtEmpCDExit
          OnKeyPress = edtEmpCDKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtEmpCDDes: TEditFocus
          Left = 114
          Top = 13
          Width = 381
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
        object chkLocFisCD: TCheckBox
          Left = 7
          Top = 35
          Width = 257
          Height = 17
          Hint = 'Incluir Inativos para Compra'
          Caption = 'Considerar Localiza'#231#227'o F'#237'sica da Empresa C.D.'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object chkSalRes: TCheckBox
          Left = 7
          Top = 67
          Width = 242
          Height = 14
          Caption = 'Descontar Saldo Reservado do Saldo do C.D.'
          TabOrder = 4
        end
        object chkLimSal: TCheckBox
          Left = 261
          Top = 67
          Width = 143
          Height = 14
          Caption = 'Limitar pelo saldo do C.D.'
          TabOrder = 5
          OnClick = chkLimSalClick
        end
        object rdgSaldoCD: TRadioGroup
          Left = 7
          Top = 227
          Width = 488
          Height = 32
          Caption = 'Saldo Atual do C.D.'
          Columns = 4
          ItemIndex = 2
          Items.Strings = (
            'Maior que zero'
            'Zero'
            'Todos'
            'Menor que zero')
          TabOrder = 9
        end
        object edtPerGra: TEditFocus
          Tag = 99
          Left = 325
          Top = 173
          Width = 61
          Height = 22
          Alignment = taRightJustify
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
        object GroupBox2: TGroupBox
          Left = 6
          Top = 82
          Width = 450
          Height = 90
          Caption = 'Estoque de seguran'#231'a do CD'
          TabOrder = 6
          object edtPerEam: TEditFocus
            Tag = 99
            Left = 351
            Top = 11
            Width = 61
            Height = 22
            Alignment = taRightJustify
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object rdbPerEam: TRadioButton
            Left = 7
            Top = 15
            Width = 344
            Height = 17
            Caption = 
              'Percentual do saldo que ficar'#225' obrigat'#243'riamente dispon'#237'vel no CD' +
              '.:'
            TabOrder = 0
            OnClick = rdbPerEamClick
          end
          object rdbDiaEst: TRadioButton
            Left = 7
            Top = 37
            Width = 329
            Height = 17
            Caption = 'Dias de estoque que ficar'#225' obrigatoriamente dispon'#237'vel no CD.:'
            TabOrder = 2
            OnClick = rdbDiaEstClick
          end
          object edtDiaEst: TEditFocus
            Tag = 99
            Left = 351
            Top = 33
            Width = 61
            Height = 22
            Alignment = taRightJustify
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object rdbSemEstSeg: TRadioButton
            Left = 287
            Top = 55
            Width = 178
            Height = 17
            Caption = 'Sem estoque de seguran'#231'a'
            TabOrder = 6
            OnClick = rdbSemEstSegClick
          end
          object btnHlpMediaVendas: TBitBtnLocked
            Left = 413
            Top = 33
            Width = 24
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000800000010000000100000
              0008000000010000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
              0B60000000070000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
              27EA0000000E0000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
              30EC0000000D0000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
              1A51000000050000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000600000011000000140000
              000A000000020000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000670503AA999532EFF4528
              187A000000070000000100000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
              4AF724150D490000000800000002000000000000000000000000000000000000
              0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
              9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
              000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
              AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
              00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
              76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
              000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
              70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
              000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
              C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
              0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
              77E570533B9A17100A2500000002000000000000000000000000000000000000
              0000000000000000000000000000000000010000000100000002000000030000
              0002000000020000000100000000000000000000000000000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            TabStop = False
            OnClick = btnHlpMediaVendasClick
          end
          object rdbMinSeg: TRadioButton
            Left = 7
            Top = 55
            Width = 258
            Height = 17
            Caption = 'Manter o estoque m'#237'nimo como seguran'#231'a do CD'
            TabOrder = 5
            OnClick = rdbMinSegClick
          end
          object rdbMaxSeg: TRadioButton
            Left = 7
            Top = 71
            Width = 258
            Height = 17
            Caption = 'Manter o estoque m'#225'ximo como seguran'#231'a do CD'
            TabOrder = 7
            OnClick = rdbMaxSegClick
          end
        end
        object chkCDNaoPodeAbastecer: TCheckBox
          Left = 6
          Top = 195
          Width = 475
          Height = 18
          Caption = 
            'Exibir apenas os '#237'tens que as filiais precisam, mas que o CD n'#227'o' +
            ' pode abastecer.'
          TabOrder = 8
          WordWrap = True
          OnClick = chkCDNaoPodeAbastecerClick
        end
        object chkDescMinMaxCD: TCheckBox
          Left = 7
          Top = 50
          Width = 370
          Height = 17
          Caption = 
            'Desconsiderar produtos com estoque m'#237'nimo e estoque m'#225'ximo zerad' +
            'o'
          TabOrder = 3
        end
        object chkConsidEstMinCD: TCheckBox
          Left = 6
          Top = 212
          Width = 475
          Height = 15
          Caption = 
            'Considerar estoque m'#237'nimo do CD para verificar se pode abastecer' +
            ' as filiais'
          TabOrder = 10
          Visible = False
          WordWrap = True
          OnClick = chkConsidEstMinCDClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 648
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 968
    Top = 360
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 640
    Top = 96
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 848
    Top = 360
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 928
    Top = 336
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 464
    Top = 477
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 464
    Top = 573
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 464
    Top = 525
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 968
    Top = 429
  end
  inherited frxGen: TfrxUserDataSet
    Left = 976
    Top = 525
  end
  inherited frxDesigner: TfrxDesigner
    Left = 464
    Top = 429
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 968
    Top = 477
  end
  object dlgExcel: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Planilha do Excel|*.xls'
    Left = 800
    Top = 352
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpRightBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    UseHintControlLookAndFeel = True
    Left = 104
    Top = 128
  end
  object cxHintStyleController1: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpRightBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    UseHintControlLookAndFeel = True
    Left = 112
    Top = 136
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45335.418989965300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rdbSaldMinOnBeforePrint(Sender: TfrxComponent);'
      'begin                                           '
      '  If (<frxRelatorio."CNV_ML"> > 0) Then'
      
        '    rdbSaldMin.Text := FormatFloat('#39'###,#0.00'#39', fArredondaMais(<' +
        'frxRelatorio."NECCOM">, True))  '
      '  Else'
      
        '    rdbSaldMin.Text := FormatFloat('#39'###,#0.00'#39', <frxRelatorio."N' +
        'ECCOM">);  '
      'end;'
      ''
      'procedure rlbDetalheOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Similares.Visible := False;                 '
      '  Similares.Visible := fFiltraSimilar(<frxRelatorio."CODITE">);'
      'end;'
      ''
      'begin        '
      '                                       '
      'end.          ')
    OnUserFunction = frxRelatorioJUserFunction
    Left = 960
    Top = 592
    Datasets = <
      item
        DataSet = frxSimilares
        DataSetName = 'frxSimilares'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaAOnBeforePrint'
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 56.692913385826770000
        ParentFont = False
        Top = 396.850650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalheOnBeforePrint'
        Child = frxRelatorioJ.Similares
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 56.692913385826770000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object rdbCodigo: TfrxMemoView
          Left = 3.000000000000000000
          Top = 2.881880000000024000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbRefere: TfrxMemoView
          Left = 44.574830000000000000
          Top = 2.440940000000012000
          Width = 58.204700000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbDesIteGru: TfrxMemoView
          Left = 135.283550000000000000
          Top = 2.440940000000012000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GRUPO"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbOrdPro: TfrxMemoView
          Left = 180.637910000000000000
          Top = 2.440940000000012000
          Width = 61.984230000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ORDPRO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbUn: TfrxMemoView
          Left = 244.889920000000000000
          Top = 2.440940000000012000
          Width = 16.629870000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMarca: TfrxMemoView
          Left = 264.543445000000000000
          Top = 2.440940000000012000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbEstMin: TfrxMemoView
          Left = 321.236395000000000000
          Top = 2.440940000000012000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTMIN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLDBText6: TfrxMemoView
          Left = 363.299475000000000000
          Top = 2.440940000000012000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTMAX"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllSalREALCD: TfrxMemoView
          Left = 409.606525000000000000
          Top = 2.440940000000012000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."REALCD"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLDBText23: TfrxMemoView
          Left = 456.519945000000000000
          Top = 2.440940000000012000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDCD"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbSaldo: TfrxMemoView
          Left = 504.874305000000000000
          Top = 2.440940000000012000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLDBText1: TfrxMemoView
          Left = 553.228665000000000000
          Top = 2.440940000000012000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDPEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbSaldMin: TfrxMemoView
          Left = 609.259844960000000000
          Top = 2.440940000000012000
          Width = 43.086611730000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rdbSaldMinOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '999.99')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbQtdVen: TfrxMemoView
          Left = 654.614173230000000000
          Top = 2.440940000000012000
          Width = 61.984251970000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbDescri: TfrxMemoView
          Left = 15.094465000000000000
          Top = 11.118119999999980000
          Width = 300.094620000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbUltFor: TfrxMemoView
          Left = 321.236395000000000000
          Top = 11.251956300000020000
          Width = 126.236240000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ULTFOR"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
          VAlign = vaCenter
        end
        object rllSaldEstMinCD: TfrxMemoView
          Left = 448.984214130000000000
          Top = 11.251956300000020000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CD_ESTMIN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllGiro: TfrxMemoView
          Left = 504.921226890000000000
          Top = 11.251956300000020000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NIVGIR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbPdCmpGar: TfrxMemoView
          Left = 553.299179650000000000
          Top = 11.251956300000020000
          Width = 54.425170000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDPEN_GAR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbPedVen: TfrxMemoView
          Left = 638.716915000000000000
          Top = 11.251956300000020000
          Width = 58.204724410000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PEDVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbEntFut: TfrxMemoView
          Left = 654.614173230000000000
          Top = 2.535435510000013000
          Width = 61.984251968503900000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ENTFUT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLDBText2: TfrxMemoView
          Left = 597.165740000000000000
          Top = 2.535435510000013000
          Width = 11.338585120000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LIMSAL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbLocFis: TfrxMemoView
          Left = 654.614173230000000000
          Top = 2.535435510000013000
          Width = 61.984251968503900000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbFabrica: TfrxMemoView
          Left = 654.614173230000000000
          Top = 2.535435510000013000
          Width = 61.984251968503900000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbRisco: TfrxMemoView
          Left = 654.614173230000000000
          Top = 2.535435510000013000
          Width = 61.984251968503900000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '____________')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbLocSup: TfrxMemoView
          Left = 638.740157480000000000
          Top = 11.338582677165330000
          Width = 58.204724410000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCSUP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes12: TfrxMemoView
          Left = 646.299212598425100000
          Top = 26.456692913385830000
          Width = 49.133858267716530000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes12"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes11: TfrxMemoView
          Left = 593.385826771653600000
          Top = 26.456692913385830000
          Width = 49.133858267716530000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes11"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes10: TfrxMemoView
          Left = 536.692913385826800000
          Top = 26.456692913385830000
          Width = 49.133858267716530000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes10"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes09: TfrxMemoView
          Left = 483.779527559055100000
          Top = 26.456692913385830000
          Width = 49.133858267716530000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes09"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes08: TfrxMemoView
          Left = 430.866141732283500000
          Top = 26.456692913385830000
          Width = 49.133858267716530000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes08"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes07: TfrxMemoView
          Left = 377.952755905512000000
          Top = 26.456692913385830000
          Width = 49.133858267716530000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes07"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes06: TfrxMemoView
          Left = 321.259842519685000000
          Top = 26.456692913385830000
          Width = 49.133858267716500000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes06"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes05: TfrxMemoView
          Left = 268.346456692913000000
          Top = 26.456692913385830000
          Width = 49.133858267716500000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes05"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes04: TfrxMemoView
          Left = 215.433070866142000000
          Top = 26.456692913385830000
          Width = 49.133858267716500000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes04"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes03: TfrxMemoView
          Left = 162.519685040000000000
          Top = 26.456692913385830000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes03"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes02: TfrxMemoView
          Left = 109.606299212598000000
          Top = 26.456692913385830000
          Width = 49.133858267716500000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes02"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMes01: TfrxMemoView
          Left = 56.692913385826800000
          Top = 26.456692913385830000
          Width = 49.133858267716500000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mes01"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rdbMesAtual: TfrxMemoView
          Left = 3.023622050000000000
          Top = 26.456692913385830000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."mesAtual"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 56.692913385826770000
        Top = 234.330860000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object shpTitulo: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 56.692913385826770000
          Fill.BackColor = clSilver
        end
        object rllCodigo: TfrxMemoView
          Left = 3.023655000000000000
          Top = 10.000000000000000000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllReferencia: TfrxMemoView
          Left = 44.598485000000000000
          Top = 9.559059999999988000
          Width = 58.204700000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllGrupoTit: TfrxMemoView
          Left = 135.307205000000000000
          Top = 9.559059999999988000
          Width = 35.527520000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'GRUPO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllOrdPro: TfrxMemoView
          Left = 180.661565000000000000
          Top = 9.559059999999988000
          Width = 61.984230000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'QTD EM PROD')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUni: TfrxMemoView
          Left = 244.913575000000000000
          Top = 9.559059999999988000
          Width = 16.629870000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMarcaTitulo: TfrxMemoView
          Left = 264.567100000000000000
          Top = 9.559059999999988000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEstMin: TfrxMemoView
          Left = 321.260050000000000000
          Top = 9.559059999999988000
          Width = 39.307050000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EST.MIN')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEstMax: TfrxMemoView
          Left = 363.323130000000000000
          Top = 9.559059999999988000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EST.MAX')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllSalCont: TfrxMemoView
          Left = 409.630180000000000000
          Top = 9.559059999999988000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DISP. CD')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllSalLimCD: TfrxMemoView
          Left = 456.543600000000000000
          Top = 9.559059999999988000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CD')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCodEmp: TfrxMemoView
          Left = 504.897960000000000000
          Top = 9.559059999999988000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ATUAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLabel2: TfrxMemoView
          Left = 553.252320000000000000
          Top = 9.559059999999988000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPRA')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLabel7: TfrxMemoView
          Left = 605.386210000000000000
          Top = 9.559059999999988000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'COMPRA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDias: TfrxMemoView
          Left = 654.614173230000000000
          Top = 9.653543310000004000
          Width = 61.984256850000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            #218'LT. 90 DIAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut2: TfrxMemoView
          Left = 654.614173230000000000
          Top = 9.716535429999994000
          Width = 61.984251970000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDescricao: TfrxMemoView
          Left = 15.118120000000000000
          Top = 21.015770000000000000
          Width = 58.204700000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllUltFor: TfrxMemoView
          Left = 321.260050000000000000
          Top = 21.149606299999990000
          Width = 99.779530000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #218'LTIMO FORNECEDOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEstMinCD: TfrxMemoView
          Left = 449.007869130000000000
          Top = 21.149606299999990000
          Width = 50.645640000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EST.MIN.CD')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllNivelGiro: TfrxMemoView
          Left = 504.944881890000000000
          Top = 21.149606299999990000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'GIRO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPdCmpGar: TfrxMemoView
          Left = 549.543304650000000000
          Top = 21.149606299999990000
          Width = 58.204700000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PD CMP GAR.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllPedVen: TfrxMemoView
          Left = 638.740570000000000000
          Top = 21.149606299999990000
          Width = 58.204700000000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PED.VEN.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLocFis: TfrxMemoView
          Left = 654.614173230000000000
          Top = 9.716535429999994000
          Width = 61.984251970000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCompras: TfrxMemoView
          Left = 654.614173230000000000
          Top = 9.716535429999994000
          Width = 61.984251970000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'COMPRAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLocSup: TfrxMemoView
          Left = 638.740157480000000000
          Top = 21.212598430000010000
          Width = 58.204700000000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC.SUP.EST')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllSal: TfrxMemoView
          Left = 409.763779530000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLabelSaldCdAlq: TfrxMemoView
          Left = 456.677199530000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllSaldo: TfrxMemoView
          Left = 505.031559530000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLabel6: TfrxMemoView
          Left = 553.385919530000000000
          Width = 43.086580000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object RLLabel5: TfrxMemoView
          Left = 605.519809530000000000
          Width = 46.866110000000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'NECESSID')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut1: TfrxMemoView
          Left = 654.771819530000000000
          Width = 61.984230000000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ENT.FUTURA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllQtdVen: TfrxMemoView
          Left = 654.638220000000000000
          Width = 61.984230000000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.VENDA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCodFab: TfrxMemoView
          Left = 654.614173230000000000
          Width = 61.984230000000000000
          Height = 15.102350000000000000
          Visible = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'COD.FABRICA')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes11: TfrxMemoView
          Left = 593.385826771653600000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 11')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes09: TfrxMemoView
          Left = 483.779527559055100000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 09')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes08: TfrxMemoView
          Left = 430.866141732283500000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 08')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes07: TfrxMemoView
          Left = 377.952755905512000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 07')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes06: TfrxMemoView
          Left = 321.259842519685000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 06')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes05: TfrxMemoView
          Left = 268.346456690000000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 05')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes04: TfrxMemoView
          Left = 215.433070866142000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 04')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes03: TfrxMemoView
          Left = 162.519685040000000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 03')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes02: TfrxMemoView
          Left = 109.606299210000000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 02')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes01: TfrxMemoView
          Left = 56.692913390000000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 01')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMesAtual: TfrxMemoView
          Left = 3.023622050000000000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's Atual')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes10: TfrxMemoView
          Left = 536.692913385826800000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 10')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllMes12: TfrxMemoView
          Left = 646.299212598425100000
          Top = 37.795275590000000000
          Width = 49.133858270000000000
          Height = 15.102350000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'M'#234's 12')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 154.929190000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 183.723285000000000000
          Top = 17.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 183.723285000000000000
          Top = 34.000000000000000000
          Width = 350.664130000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 587.679160000000000000
          Top = 12.661410000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 546.104330000000000000
          Top = 29.440940000000000000
          Width = 166.374830000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM: [Date] [Time]')
          ParentFont = False
        end
        object rllEmpresa: TfrxMemoView
          Top = 64.251968500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object rllGrupo: TfrxMemoView
          Top = 75.590600000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[GRUPO]')
          ParentFont = False
        end
        object rllMarcaOrd: TfrxMemoView
          Top = 86.929190000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[MARCAORD]')
          ParentFont = False
        end
        object rllDescri: TfrxMemoView
          Top = 98.267780000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DESCRI]')
          ParentFont = False
        end
        object rllLocFil: TfrxMemoView
          Top = 109.606370000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOCFIL]')
          ParentFont = False
        end
        object rllSalRes: TfrxMemoView
          Top = 120.944960000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SALRES]')
          ParentFont = False
        end
        object rllSitPro: TfrxMemoView
          Top = 132.283550000000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SITPRO]')
          ParentFont = False
        end
        object rllOrdem: TfrxMemoView
          Left = 359.055350000000000000
          Top = 64.251968500000000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object rllUnidade: TfrxMemoView
          Left = 359.055118110236000000
          Top = 75.590551181102400000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object rllRef: TfrxMemoView
          Left = 359.055350000000000000
          Top = 86.929133859999990000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
        end
        object rllGruCmpHeader: TfrxMemoView
          Left = 359.055350000000000000
          Top = 98.267716535433100000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[GRUCMP]')
          ParentFont = False
        end
        object rllSalEntFut: TfrxMemoView
          Left = 359.055350000000000000
          Top = 109.606299212598000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SALENTFUT]')
          ParentFont = False
        end
        object rllSitProExc: TfrxMemoView
          Left = 359.055350000000000000
          Top = 120.944881889764000000
          Width = 358.223190000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SITPROEXC]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897405910000000000
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODFOR"'
        ReprintOnNewPage = True
        object rllFornecedor: TfrxMemoView
          Left = 7.023655000000000000
          Top = 3.000000000000000000
          Width = 587.338900000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FORNEC"] ')
          ParentFont = False
        end
      end
      object Similares: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897650000000000000
        ParentFont = False
        Top = 476.220780000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'ChildFreteOnBeforePrint'
        PrintChildIfInvisible = True
        object childSimilares: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelatorioJ.qckSimilares
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897405910000000000
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."GRUPO"'
        ReprintOnNewPage = True
        object Memo11: TfrxMemoView
          Left = 25.700835000000000000
          Top = 3.000000000000000000
          Width = 564.661720000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Grupo: [frxRelatorio."GRUDES"] ')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxReportSummary
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 555.590910000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 165.013790000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 548.787260000000000000
          Top = 3.779530000000022000
          Width = 160.629560000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhe)]')
          ParentFont = False
        end
        object rllLimSal: TfrxMemoView
          Left = 168.037910000000000000
          Top = 3.913388269999985000
          Width = 387.401360000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '(**) Necessidade de compra limitada pelo Saldo do C.D.')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Diagonal = True
        end
      end
    end
    object qckSimilares: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 13.228346460000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Width = 257.008040000000000000
          Height = 12.850391260000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Similares:')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 56.692950000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxSimilares
        DataSetName = 'frxSimilares'
        RowCount = 0
        object Memo2: TfrxMemoView
          Left = 52.913420000000000000
          Top = 0.779530000000000000
          Width = 215.433158740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSimilares."ITE_DESITE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 272.126160000000000000
          Top = 0.779530000000000000
          Width = 83.149608740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSimilares."MAR_DESMAR"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 359.055350000000000000
          Top = 0.779530000000000000
          Width = 64.251958740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSimilares."ITE_REFERE"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 427.086890000000000000
          Top = 0.779530000000000000
          Width = 49.133838740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSimilares."ITE_SALDCD"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 480.000310000000000000
          Top = 0.779530000000000000
          Width = 75.590548740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSimilares."ITE_SALDOS"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000000000
          Width = 45.354308740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSimilares."ITE_CODITE"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 94.488250000000000000
        Width = 718.110700000000000000
        object Memo7: TfrxMemoView
          Left = 480.000310000000000000
          Top = 0.779530000000000000
          Width = 75.590548740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSimilares."ITE_SALDOS">,MasterData1)]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 427.086890000000000000
          Top = 0.779530000000000000
          Width = 49.133838740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSimilares."ITE_SALDCD">,MasterData1)]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 374.173470000000000000
          Top = 0.779530000000000000
          Width = 49.133838740000000000
          Height = 12.850391260000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
      end
    end
  end
  object frxSimilares: TfrxDBDataset
    UserName = 'frxSimilares'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 896
    Top = 432
  end
end
