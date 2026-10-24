inherited frmRelCat42v2: TfrmRelCat42v2
  Width = 535
  Height = 635
  Caption = 'CAT-42 Relat'#243'rio Ficha 3 Controle de Estoque'
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 535
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 560
    Width = 529
    Height = 30
    ExplicitTop = 560
    ExplicitWidth = 529
    ExplicitHeight = 30
    inherited btnSair: TBitBtn
      Left = 417
      Width = 110
      Height = 26
      TabOrder = 3
      ExplicitLeft = 417
      ExplicitWidth = 110
      ExplicitHeight = 26
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      Top = 2
      Height = 26
      Align = alLeft
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitHeight = 26
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 79
      Top = 2
      Height = 26
      Align = alLeft
      ExplicitLeft = 79
      ExplicitTop = 2
      ExplicitHeight = 26
    end
    object btnDeletarPeriodo: TBitBtnLocked
      Left = 156
      Top = 2
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '&Deletar Per'#237'odo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnDeletarPeriodoClick
    end
  end
  inherited pnlDados: TPanel
    Width = 529
    Height = 542
    ExplicitWidth = 529
    ExplicitHeight = 542
    object lblOperacao: TLabel [0]
      Left = 1
      Top = 519
      Width = 527
      Height = 14
      Align = alBottom
      Caption = 'descri'#231#227'o da operacao'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 113
    end
    inherited gpbDestino: TGroupBox
      Left = 735
      Top = 126
      ExplicitLeft = 735
      ExplicitTop = 126
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 533
      Width = 527
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 1
    end
    object pnlDadosSelecao: TPanel
      Left = 1
      Top = 1
      Width = 527
      Height = 323
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lblCodEmp: TLabel
        Left = 8
        Top = 115
        Width = 42
        Height = 14
        BiDiMode = bdRightToLeft
        Caption = 'Empresa'
        ParentBiDiMode = False
      end
      object lblCodProd: TLabel
        Left = 8
        Top = 153
        Width = 37
        Height = 14
        BiDiMode = bdRightToLeft
        Caption = 'Produto'
        ParentBiDiMode = False
      end
      object btnCriarTabelas: TSpeedButton
        Left = 404
        Top = 274
        Width = 75
        Height = 25
        Caption = 'Criar Tabelas'
        Visible = False
        OnClick = btnCriarTabelasClick
      end
      object lblUtilizarPrecoCompraCalcICMSSuportado: TLabel
        Left = 318
        Top = 286
        Width = 7
        Height = 14
        Caption = '?'
        DragCursor = crHandPoint
        Font.Charset = ANSI_CHARSET
        Font.Color = 16744448
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblUtilizarPrecoCompraCalcICMSSuportadoClick
      end
      object Label2: TLabel
        Left = 312
        Top = 286
        Width = 4
        Height = 14
        Caption = '('
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 327
        Top = 286
        Width = 4
        Height = 14
        Caption = ')'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 8
        Top = 130
        Width = 64
        Height = 22
        Hint = 'Empresa: '
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodEmpExit
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomEmp: TEditFocus
        Left = 74
        Top = 130
        Width = 444
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
      object edtCodPro: TEditFocus
        Tag = 99
        Left = 8
        Top = 167
        Width = 64
        Height = 22
        Hint = 'Produto: '
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 4
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
      object edtNomPro: TEditFocus
        Left = 74
        Top = 167
        Width = 444
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object gpbEnquadramento: TGroupBox
        Left = 164
        Top = 3
        Width = 354
        Height = 110
        Hint = 'Enquadramento: '
        Caption = 'Enquadramento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object chkSaidaConsumidor: TCheckBox
          Tag = 1
          AlignWithMargins = True
          Left = 7
          Top = 14
          Width = 225
          Height = 17
          Hint = 'Enquadramento'
          Margins.Top = 0
          Margins.Bottom = 0
          Caption = '1 - Sa'#237'da a Consumidor ou Usu'#225'rio Final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chkEnquadramentoClick
        end
        object chkFatorGerador: TCheckBox
          Tag = 2
          AlignWithMargins = True
          Left = 7
          Top = 29
          Width = 299
          Height = 17
          Hint = 'Enquadramento'
          Margins.Top = 0
          Margins.Bottom = 0
          Caption = '2 - Fato Gerador n'#227'o Realizado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = chkEnquadramentoClick
        end
        object chkSaidaSubsequente: TCheckBox
          Tag = 3
          AlignWithMargins = True
          Left = 7
          Top = 44
          Width = 322
          Height = 17
          Hint = 'Enquadramento'
          Margins.Top = 0
          Margins.Bottom = 0
          Caption = '3 - Sa'#237'da ou Sa'#237'da Subsequente com Isen'#231#227'o ou n'#227'o Incid'#234'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = chkEnquadramentoClick
        end
        object chkSaidaOutroEstado: TCheckBox
          Tag = 4
          AlignWithMargins = True
          Left = 7
          Top = 59
          Width = 299
          Height = 17
          Hint = 'Enquadramento'
          Margins.Top = 0
          Margins.Bottom = 0
          Caption = '4 - Sa'#237'da para Outro Estado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = chkEnquadramentoClick
        end
        object chkSaidaParaComercializacao: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 74
          Width = 319
          Height = 17
          Hint = 'Enquadramento'
          Margins.Top = 0
          Margins.Bottom = 0
          Caption = '0 - Sa'#237'da para Comercializa'#231#227'o Subsequente (Demais Sa'#237'das) '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = chkEnquadramentoClick
        end
        object chkTotalizarValorContabil: TCheckBox
          Tag = 55
          AlignWithMargins = True
          Left = 7
          Top = 89
          Width = 319
          Height = 17
          Hint = 'Enquadramento'
          Margins.Top = 0
          Margins.Bottom = 0
          Caption = 'Totalizar Valor Cont'#225'bil'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = chkEnquadramentoClick
        end
      end
      object gpbSelecionarTabelaInventario: TGroupBox
        Left = 164
        Top = 193
        Width = 354
        Height = 42
        Caption = 'Selecionar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        object btnEscolherTabela: TSpeedButton
          Left = 9
          Top = 15
          Width = 100
          Height = 22
          Hint = 'Tabela Invent'#225'rio'
          Caption = 'Tabela Invent'#225'rio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          OnClick = btnEscolherTabelaClick
        end
        object lblTabInventario: TLabel
          Left = 115
          Top = 19
          Width = 201
          Height = 14
          Hint = 'Tabela Invent'#225'rio: '
          HelpType = htKeyword
          AutoSize = False
          Caption = 'TABELA PADR'#195'O'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16744448
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object btnSugestao: TSpeedButton
          Left = 322
          Top = 15
          Width = 23
          Height = 22
          Hint = 'Sugest'#227'o para tabela de Invent'#225'rio'
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSugestaoClick
        end
      end
      object gpbValorIVANFX60Inventario: TGroupBox
        Left = 8
        Top = 193
        Width = 153
        Height = 42
        Caption = 'Valor IVA - NF X60 Invent'#225'rio'
        TabOrder = 6
        object Label5: TLabel
          Left = 8
          Top = 91
          Width = 3
          Height = 14
        end
        object edtValIva: TEditFocus
          Left = 7
          Top = 15
          Width = 57
          Height = 22
          Hint = 'Valor IVA - NF X60 Invent'#225'rio: '
          Alignment = taRightJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object chkCalcularST: TCheckBox
          Left = 71
          Top = 19
          Width = 73
          Height = 17
          Hint = 'Calcular ST: '
          Caption = 'Calcular ST'
          TabOrder = 1
        end
      end
      object gpbDataEntrada: TGroupBox
        Left = 8
        Top = 3
        Width = 153
        Height = 110
        Caption = 'Data Entrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblDtaInicial: TLabel
          Left = 7
          Top = 17
          Width = 26
          Height = 14
          BiDiMode = bdLeftToRight
          Caption = 'Inicial'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblDtaFinal: TLabel
          Left = 82
          Top = 17
          Width = 22
          Height = 14
          Caption = 'Final'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 7
          Top = 32
          Width = 65
          Height = 22
          Hint = 'Data Entrada Inicial: '
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          Text = '  /  /    '
          OnExit = mskDtaIniExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 82
          Top = 32
          Width = 65
          Height = 22
          Hint = 'Data Entrada Final: '
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  /  /    '
          OnExit = mskDtaFinExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
      object chkUtilizarConfigCfopCstEnquadramentos: TCheckBox
        Left = 8
        Top = 238
        Width = 368
        Height = 14
        Hint = 'Utilizar Configura'#231#227'o de CFOP/CST para os Enquadramentos: '
        Caption = 'Utilizar Configura'#231#227'o de CFOP/CST para os Enquadramentos'
        TabOrder = 8
        OnClick = chkUtilizarConfigCfopCstEnquadramentosClick
      end
      object chkSomaIcmsRetido: TCheckBox
        Left = 8
        Top = 254
        Width = 368
        Height = 14
        Hint = 'Somar Retido + ICMS Opera'#231#227'o Pr'#243'pria: '
        Caption = 'Somar Retido + ICMS Opera'#231#227'o Pr'#243'pria'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object chkConsiderarDataEmissaoEntradasTransferencia: TCheckBox
        Left = 8
        Top = 270
        Width = 368
        Height = 14
        Hint = 'Considerar Data de Emiss'#227'o para Entradas de Transfer'#234'ncias'
        Caption = 'Considerar Data de Emiss'#227'o para Entradas de Transfer'#234'ncias'
        TabOrder = 10
      end
      object chkUtilizarPrecoCompraCalcICMSSuportado: TCheckBox
        Left = 8
        Top = 286
        Width = 301
        Height = 14
        Caption = 'Utilizar o Pre'#231'o de Compra para Calcular o ICMS Suportado'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 11
        OnMouseMove = chkUtilizarPrecoCompraCalcICMSSuportadoMouseMove
      end
      object chkGerarComSaldoZero: TCheckBox
        Left = 8
        Top = 301
        Width = 368
        Height = 14
        Hint = 'Somar Retido + ICMS Opera'#231#227'o Pr'#243'pria: '
        Caption = 'Enviar Produtos com Saldo Final ZERO ?'
        TabOrder = 12
      end
    end
    object pnlInconsistencia: TPanel
      Left = 1
      Top = 324
      Width = 527
      Height = 195
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object gpbInconsistencias: TGroupBox
        Left = 146
        Top = 0
        Width = 372
        Height = 189
        Hint = 'Inconsist'#234'ncia(s): '
        Align = alClient
        Caption = 'Inconsist'#234'ncia(s)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object chkInvSemSaldoSemSubstTributSemMovtoMes: TCheckBox
          Tag = 1
          Left = 8
          Top = 20
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '1 - Inv. sem Saldo, sem Subst. Tribut'#225'ria e sem Movimento M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object chkInvSemSaldoComSubstTributSemMovtoMes: TCheckBox
          Tag = 2
          Left = 8
          Top = 36
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '2 - Inv. sem Saldo, com Subst. Tribut'#225'ria e sem Movimento M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object chkInvComSaldoSemSubstTributSemMovtoMes: TCheckBox
          Tag = 3
          Left = 8
          Top = 52
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '3 - Inv. com Saldo, sem Subst. Tribut'#225'ria e sem Movimento M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object chkInvComSaldoSemSubstTributComMovtoMes: TCheckBox
          Tag = 4
          Left = 8
          Top = 68
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '4 - Inv. com Saldo, sem Subst. Tribut'#225'ria e com Movimento M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object chkSaldoInicialQuantidadInicialNegativa: TCheckBox
          Tag = 6
          Left = 8
          Top = 100
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '6 - Saldo Inicial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object chkSldFinalQtFinalNegQtVendaMaiorCompra: TCheckBox
          Tag = 7
          Left = 8
          Top = 116
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '7 - Saldo Final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object chkNotasEntradaSemSubstituicaTributaria: TCheckBox
          Tag = 5
          Left = 8
          Top = 84
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '5 - Notas de Entrada e Transf. sem Subst. Tribut'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
        object pnlButtonInconsistencia: TPanel
          Left = 339
          Top = 16
          Width = 31
          Height = 171
          Align = alRight
          TabOrder = 8
          object spdMarcarDesmarcarTodos: TButton
            Left = 1
            Top = 1
            Width = 29
            Height = 27
            Hint = 'Marcar ou Desmarcar Todos'
            Align = alTop
            Caption = 'q'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Webdings'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            WordWrap = True
            OnClick = btnMarcarDesmarcarTodosClick
          end
        end
        object Button1: TButton
          Left = 258
          Top = 164
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 9
          Visible = False
          OnClick = Button1Click
        end
        object chkSaldoMovimentacao: TCheckBox
          Tag = 8
          Left = 8
          Top = 133
          Width = 325
          Height = 17
          Hint = 'Inconsist'#234'ncia(s): '
          Caption = '8 - Saldo Movimenta'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Visible = False
          OnClick = chkInvSemSaldoSemSubstTributSemMovtoMesClick
        end
      end
      object pnlApuracao: TPanel
        Left = 0
        Top = 0
        Width = 146
        Height = 189
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object gpbApuracao: TGroupBox
          Left = 8
          Top = 0
          Width = 138
          Height = 189
          Hint = 'Apura'#231#227'o: '
          Align = alClient
          Caption = 'Apura'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object gpbConsiderarInconsistencia: TGroupBox
            AlignWithMargins = True
            Left = 5
            Top = 42
            Width = 128
            Height = 142
            Hint = 'Considerar: '
            Align = alClient
            Caption = 'Considerar'
            TabOrder = 0
            object chkConsiderarInconsistenciaQuatro: TCheckBox
              Left = 7
              Top = 15
              Width = 109
              Height = 17
              Hint = 'Considerar'
              Caption = 'Inconsist'#234'ncia 4'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnClick = chkGerarApuracaoClick
            end
            object chkConsiderarInconsistenciaCincoEntradaSemSt: TCheckBox
              Left = 7
              Top = 37
              Width = 109
              Height = 41
              Hint = 'Considerar'
              Caption = 'Inconsist'#234'ncia 5 Entrada sem Subst. Tribut'#225'ria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              OnClick = chkGerarApuracaoClick
            end
            object chkConsiderarInconsistenciaCincoTransfSemSt: TCheckBox
              Left = 7
              Top = 81
              Width = 109
              Height = 41
              Hint = 'Considerar'
              Caption = 'Inconsist'#234'ncia 5 Transf. sem Subst. Tribut'#225'ria'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              WordWrap = True
              OnClick = chkGerarApuracaoClick
            end
          end
          object TPanel
            Left = 2
            Top = 16
            Width = 134
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object chkGerarApuracao: TCheckBox
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 128
              Height = 17
              Hint = 'Apura'#231#227'o Gerar: '
              Align = alTop
              Caption = 'Gerar'
              Checked = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              State = cbChecked
              TabOrder = 0
              OnClick = chkGerarApuracaoClick
            end
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 8
          Height = 189
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object Panel1: TPanel
        Left = 518
        Top = 0
        Width = 9
        Height = 189
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
      end
      object Panel2: TPanel
        Left = 0
        Top = 189
        Width = 527
        Height = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 590
    Width = 529
    ExplicitTop = 590
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 358
      ExplicitLeft = 358
    end
    inherited pnlInfo: TPanel
      Width = 358
      ExplicitWidth = 358
      inherited btnShowTrace: TSpeedButton
        Left = 356
        ExplicitLeft = 356
      end
      inherited btnHideTrace: TSpeedButton
        Left = 356
        ExplicitLeft = 356
      end
    end
  end
  object pnlInformacao: TPanel [3]
    Left = 0
    Top = 542
    Width = 529
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Color = 16744448
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    Visible = False
    object lblInformacao_1: TLabel
      Left = 0
      Top = 0
      Width = 529
      Height = 14
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = -1
    end
  end
  object pnlUtilizarPrecoCompraCalcICMSSuportado: TPanel [4]
    Left = 0
    Top = 604
    Width = 529
    Height = 251
    Alignment = taLeftJustify
    TabOrder = 4
    object Button2: TButton
      Left = 443
      Top = 220
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = Button2Click
    end
    object mmUtilizarPrecoCompraCalcICMSSuportado: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 521
      Height = 210
      Align = alTop
      BorderStyle = bsNone
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 704
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 672
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 640
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 608
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 576
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = cdsRelatorio
    Left = 608
    Top = 48
  end
  inherited frxGen: TfrxUserDataSet
    Left = 576
    Top = 48
  end
  inherited frxDesigner: TfrxDesigner
    Left = 768
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 800
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43521.637828240700000000
    ReportOptions.LastChange = 43521.637828240700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 488
    Top = 170
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
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
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 620.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 272.889920000000000000
        Top = 18.897650000000000000
        Width = 2286.615650000000000000
        Condition = 'frxRelatorio."CODITE"'
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 110.267780000000000000
          Width = 56.692950000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero '
            'de Ordem'
            ' (1)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 60.472480000000000000
          Top = 110.267780000000000000
          Width = 68.031540000000010000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data'
            '(2)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 128.504020000000000000
          Top = 110.267780000000000000
          Width = 268.346630000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Chave do'
            'Documento'
            'Fiscal'
            'Eletr'#244'nico'
            '(3)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 396.850650000000000000
          Top = 110.267780000000000000
          Width = 56.692950000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero de'
            'S'#233'rie de '
            'Fabrica'#231#227'o'
            'do ECF'
            '(4)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 453.543600000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Tipo do'
            'Documento'
            '(5)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 514.016080000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'S'#233'rie do'
            'Documento'
            '(6)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 574.488560000000000000
          Top = 110.267780000000000000
          Width = 75.590600000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero do'
            'Documento'
            '(7)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 650.079160000000000000
          Top = 110.267780000000000000
          Width = 64.252010000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'digo do'
            'Remetente ou'
            'Destinat'#225'rio'
            '(8)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 3.779527560000000000
          Top = 91.370130000000000000
          Width = 812.598950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dados Gerais')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 714.331170000000000000
          Top = 110.267780000000000000
          Width = 41.574830000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CFOP'
            '(9)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 755.906000000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero do'
            'Item no'
            'Documento'
            '(10)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Left = 816.378480000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade'
            '(11)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Align = baLeft
          Left = 876.850960000000000000
          Top = 110.267780000000000000
          Width = 86.929190000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Total do'
            'ICMS Suportado'
            'na Reten'#231#227'o ou'
            'Antecipa'#231#227'o por'
            'ST'
            '(12)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Left = 816.378477560000000000
          Top = 91.370130000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Entradas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 963.780150000000000000
          Top = 110.267780000000000000
          Width = 64.252010000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade'
            '(13)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 1028.032160000000000000
          Top = 144.385900000000000000
          Width = 64.252010000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor'
            'Unit'#225'rio do'
            'ICMS'
            'Suportado'
            '(14)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 1028.032160000000000000
          Top = 110.047310000000000000
          Width = 483.779840000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Valor Total do ICMS Suportado na Reten'#231#227'o ou Antecipa'#231#227'o por Sub' +
              'stitui'#231#227'o Tribut'#225'ria'
            '(apurado pela m'#233'dia ponderada m'#243'vel)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 963.780147560000000000
          Top = 91.370130000000000000
          Width = 729.449290000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'das')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 1092.284170000000000000
          Top = 144.283550000000000000
          Width = 75.590600000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da a'
            'Consumidor'
            'ou Usu'#225'rio'
            'Final - C'#243'digo'
            'Equadramento'
            'legal = 1'
            '(15)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Left = 1167.874770000000000000
          Top = 144.283550000000000000
          Width = 83.149660000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Fato Gerador'
            'N'#227'o Realizado -'
            'C'#243'digo'
            'Enquadramento'
            'Legal = 2'
            '(16)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 1251.024430000000000000
          Top = 144.283550000000000000
          Width = 83.149660000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da ou Sa'#237'da'
            'subsequente'
            'com Isen'#231#227'o ou'
            'N'#227'o Incid'#234'ncia -'
            'C'#243'digo'
            'Enquadramento'
            'Legal = 3'
            '(17)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Left = 1334.174090000000000000
          Top = 144.283550000000000000
          Width = 86.929190000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da para Outro'
            'Estado - C'#243'digo'
            'Enquadramento'
            'Legal = 4'
            '(18)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Left = 1421.103280000000000000
          Top = 144.283550000000000000
          Width = 90.708720000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da para'
            'Comercializa'#231#227'o'
            'Subsequente'
            '(Demais Sa'#237'das) -'
            'C'#243'digo'
            'Enquadramento'
            'Legal = 0'
            '(19)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Top = 144.283515830000000000
          Width = 90.708720000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS Efetivo'
            'na Sa'#237'da: a'
            'Consumidor'
            'ou Usu'#225'rio'
            'Final ou no'
            'caso de Sa'#237'da'
            'Subsequente'
            'Com Isen'#231#227'o'
            'ou N'#227'o Incid'#234'ncia'
            '(20)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Left = 1602.520720000000000000
          Top = 144.283550000000000000
          Width = 90.708720000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS Efetivo da'
            'Entrada, nas'
            'Demais Hip'#243'teses'
            '(21)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Left = 1693.229440000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade'
            '(22)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Left = 1783.938160000000000000
          Top = 174.519790000000000000
          Width = 120.944960000000000000
          Height = 98.267780000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Unit'#225'rio do'
            'Saldo'
            '(23)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Left = 1783.938160000000000000
          Top = 110.267780000000000000
          Width = 219.212740000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Total do ICMS Suportado na'
            'Reten'#231#227'o ou Antecipa'#231#227'o por'
            'Substitui'#231#227'o Tribut'#225'ria (m'#233'dia'
            'ponderada m'#243'vel)')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Left = 1904.883120000000000000
          Top = 174.519790000000000000
          Width = 98.267780000000000000
          Height = 98.267780000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Total do Saldo'
            '(24)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Align = baLeft
          Left = 2003.150900000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor do'
            'Ressarcimento'
            '(25)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Left = 2093.859620000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor do'
            'Complemento'
            '(26)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 2184.568340000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS - Cr'#233'dito'
            'da Opera'#231#227'o'
            'Pr'#243'pria'
            '(artigo 271 do '
            'RICMS)'
            '(27)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.338590000000000000
          Width = 2271.497530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'CONTROLE DE ESTOQUE - MERCADORIAS ENQUADRADAS NA SUBSTITUI'#199#195'O TR' +
              'IBUT'#193'RIA')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.236240000000000000
          Width = 2271.497530000000000000
          Height = 56.692950000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            
              'CONTRIBUINTE: [frxRelatorio."NOMEMP"]                           ' +
              '                                                                ' +
              '                                                                ' +
              '                                                                ' +
              '                 INSCRI'#199#195'O ESTADUAL: [frxRelatorio."IES"]'
            ''
            
              'M'#202'S E ANO DE REFER'#202'NCIA:  [MESANO]                              ' +
              '                                     MERCADORIA: [frxRelatorio."' +
              'MERCADORIA"]                                                    ' +
              '                                           UNIDADE: [frxRelatori' +
              'o."UNIDADE"]                                              AL'#205'QUO' +
              'TA: [frxRelatorio."ALIQUOTA"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Top = 110.267780000000000000
          Width = 181.417440000000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor de Confronto')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Top = 91.370130000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Left = 1693.229440000000000000
          Top = 91.370130000000000000
          Width = 309.921460000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Align = baLeft
          Left = 2003.150900000000000000
          Top = 91.370130000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Apura'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 313.700990000000000000
        Width = 2286.615650000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioCampo01: TfrxMemoView
          Left = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'Campo01'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo02: TfrxMemoView
          Align = baLeft
          Left = 60.472480000000000000
          Width = 68.031540000000010000
          Height = 18.897650000000000000
          DataField = 'Campo02'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo02"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo03: TfrxMemoView
          Align = baLeft
          Left = 128.504020000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DataField = 'Campo03'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."Campo03"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo04: TfrxMemoView
          Align = baLeft
          Left = 396.850650000000000000
          Width = 56.692950000000010000
          Height = 18.897650000000000000
          DataField = 'Campo04'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."Campo04"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo05: TfrxMemoView
          Align = baLeft
          Left = 453.543600000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo05'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo05"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo06: TfrxMemoView
          Align = baLeft
          Left = 514.016080000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo06'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo06"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo07: TfrxMemoView
          Align = baLeft
          Left = 574.488560000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'Campo07'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo07"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo08: TfrxMemoView
          Align = baLeft
          Left = 650.079160000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Campo08'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo08"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo09: TfrxMemoView
          Align = baLeft
          Left = 714.331170000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'Campo09'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo09"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo10: TfrxMemoView
          Align = baLeft
          Left = 755.906000000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo10'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo10"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo11: TfrxMemoView
          Align = baLeft
          Left = 816.378480000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo11'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo11"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo12: TfrxMemoView
          Align = baLeft
          Left = 876.850960000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'Campo12'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo12"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo13: TfrxMemoView
          Align = baLeft
          Left = 963.780150000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Campo13'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo13"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo14: TfrxMemoView
          Align = baLeft
          Left = 1028.032160000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Campo14'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo14"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo15: TfrxMemoView
          Align = baLeft
          Left = 1092.284170000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'Campo15'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo15"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo16: TfrxMemoView
          Align = baLeft
          Left = 1167.874770000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'Campo16'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo16"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo17: TfrxMemoView
          Align = baLeft
          Left = 1251.024430000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'Campo17'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo17"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo18: TfrxMemoView
          Align = baLeft
          Left = 1334.174090000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'Campo18'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo18"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo19: TfrxMemoView
          Align = baLeft
          Left = 1421.103280000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo19'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo19"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo20: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo20'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo20"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo21: TfrxMemoView
          Align = baLeft
          Left = 1602.520720000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo21'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo21"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo22: TfrxMemoView
          Align = baLeft
          Left = 1693.229440000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo22'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo22"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo23: TfrxMemoView
          Align = baLeft
          Left = 1783.938160000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'Campo23'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.8f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo23"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo24: TfrxMemoView
          Align = baLeft
          Left = 1904.883120000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'Campo24'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo24"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo25: TfrxMemoView
          Align = baLeft
          Left = 2003.150900000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo25'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo25"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo26: TfrxMemoView
          Align = baLeft
          Left = 2093.859620000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo26'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo26"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo27: TfrxMemoView
          Align = baLeft
          Left = 2184.568340000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo27'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo27"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 355.275820000000000000
        Width = 2286.615650000000000000
        object Memo40: TfrxMemoView
          Align = baLeft
          Left = 2003.150836540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo25">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Align = baLeft
          Left = 2093.859556540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo26">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Align = baLeft
          Left = 2184.568276540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo27">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 1904.883120000000000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 105.826840000000000000
        Top = 434.645950000000000000
        Width = 2286.615650000000000000
        object Memo44: TfrxMemoView
          Align = baLeft
          Left = 2003.150836540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo25">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Align = baLeft
          Left = 2093.859556540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo26">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Align = baLeft
          Left = 2184.568276540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo27">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 1904.883120000000000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object SubreportContabil: TfrxSubreport
          Left = 7.559060000000000000
          Top = 75.590600000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 620.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 2286.615650000000000000
        object Memo50: TfrxMemoView
          Left = 3.779530000000000000
          Width = 411.968770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Totalizador Valor Cont'#225'bil Sa'#237'da por Enquadramento')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 64.252010000000000000
        Width = 2286.615650000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo48: TfrxMemoView
          Left = 64.252010000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DataField = 'CFOP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CFOP"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 272.126160000000000000
          Width = 238.110390000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."VALORCONTABIL"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 177.637910000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Cont'#225'bil:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CFOP:')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 2286.615650000000000000
      end
    end
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 130
    object cdsRelatorioCampo01: TIntegerField
      FieldName = 'Campo01'
    end
    object cdsRelatorioCampo02: TDateField
      FieldName = 'Campo02'
    end
    object cdsRelatorioCampo03: TStringField
      FieldName = 'Campo03'
      Size = 44
    end
    object cdsRelatorioCampo04: TStringField
      FieldName = 'Campo04'
    end
    object cdsRelatorioCampo05: TStringField
      FieldName = 'Campo05'
    end
    object cdsRelatorioCampo06: TStringField
      FieldName = 'Campo06'
    end
    object cdsRelatorioCampo07: TStringField
      FieldName = 'Campo07'
    end
    object cdsRelatorioCampo08: TStringField
      FieldName = 'Campo08'
    end
    object cdsRelatorioCampo09: TStringField
      FieldName = 'Campo09'
    end
    object cdsRelatorioCampo10: TStringField
      FieldName = 'Campo10'
    end
    object cdsRelatorioCampo11: TFloatField
      FieldName = 'Campo11'
    end
    object cdsRelatorioCampo12: TFloatField
      FieldName = 'Campo12'
    end
    object cdsRelatorioCampo13: TFloatField
      FieldName = 'Campo13'
    end
    object cdsRelatorioCampo14: TFloatField
      FieldName = 'Campo14'
    end
    object cdsRelatorioCampo15: TFloatField
      FieldName = 'Campo15'
    end
    object cdsRelatorioCampo17: TFloatField
      FieldName = 'Campo17'
    end
    object cdsRelatorioCampo18: TFloatField
      FieldName = 'Campo18'
    end
    object cdsRelatorioCampo19: TFloatField
      FieldName = 'Campo19'
    end
    object cdsRelatorioCampo20: TFloatField
      FieldName = 'Campo20'
    end
    object cdsRelatorioCampo21: TFloatField
      FieldName = 'Campo21'
    end
    object cdsRelatorioCampo22: TFloatField
      FieldName = 'Campo22'
    end
    object cdsRelatorioCampo23: TFloatField
      FieldName = 'Campo23'
    end
    object cdsRelatorioCampo24: TFloatField
      FieldName = 'Campo24'
    end
    object cdsRelatorioCampo25: TFloatField
      FieldName = 'Campo25'
    end
    object cdsRelatorioCampo26: TFloatField
      FieldName = 'Campo26'
    end
    object cdsRelatorioCampo27: TFloatField
      FieldName = 'Campo27'
    end
    object cdsRelatorioCampo16: TFloatField
      FieldName = 'Campo16'
    end
    object cdsRelatorioMERCADORIA: TStringField
      FieldName = 'MERCADORIA'
      Size = 100
    end
    object cdsRelatorioCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsRelatorioUNIDADE: TStringField
      FieldName = 'UNIDADE'
    end
    object cdsRelatorioNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 100
    end
    object cdsRelatorioIES: TStringField
      FieldName = 'IES'
      Size = 100
    end
    object cdsRelatorioALIQUOTA: TFloatField
      FieldName = 'ALIQUOTA'
    end
    object cdsRelatorioINCVEN: TStringField
      FieldName = 'INCVEN'
    end
    object cdsRelatorioVALORCONTABIL: TFloatField
      FieldName = 'VALORCONTABIL'
    end
  end
  object TimerPnlInformacao: TTimer
    Enabled = False
    Interval = 600
    OnTimer = TimerPnlInformacaoTimer
    Left = 489
    Top = 89
  end
  object cdsRelContabil: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 130
    object FloatField19: TFloatField
      FieldName = 'VALORCONTABIL'
    end
    object cdsRelContabilCST: TStringField
      FieldName = 'ENQUADRAMENTO'
      Size = 30
    end
    object cdsRelContabilCFOP: TStringField
      FieldName = 'CFOP'
      Size = 30
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = cdsRelContabil
    BCDToCurrency = False
    Left = 265
    Top = 129
  end
end
