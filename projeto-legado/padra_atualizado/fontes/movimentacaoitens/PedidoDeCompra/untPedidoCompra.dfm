inherited frmPedidoDeCompra: TfrmPedidoDeCompra
  Left = 181
  Top = 189
  Width = 1366
  Height = 768
  Caption = 'Digita'#231#227'o de Pedido de Compra'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  ExplicitWidth = 1366
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 646
    Width = 1360
    Height = 50
    TabOrder = 3
    ExplicitTop = 646
    ExplicitWidth = 1360
    ExplicitHeight = 50
    DesignSize = (
      1360
      50)
    inherited FlwBotoes: TFlowPanel
      Width = 1356
      Height = 46
      ExplicitWidth = 1356
      ExplicitHeight = 46
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '[F10] Confirma'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnSimilares: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 70
        Height = 22
        Caption = '[F9] Similares'
        TabOrder = 1
        Visible = False
        OnClick = btnSimilaresClick
      end
      object btnSimGir: TBitBtnLocked
        Left = 147
        Top = 0
        Width = 118
        Height = 22
        Caption = '[Ctrl+F9] Similares Giro'
        TabOrder = 20
        Visible = False
        OnClick = btnSimGirClick
      end
      object btnEditarItem: TBitBtnLocked
        Left = 265
        Top = 0
        Width = 76
        Height = 22
        Caption = '[F8] Editar Item'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnEditarItemClick
      end
      object btnPedidosPend: TBitBtnLocked
        Left = 341
        Top = 0
        Width = 119
        Height = 22
        Caption = '[F7] Pedidos Pendentes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnClick = btnPedidosPendClick
      end
      object btnEstoque: TBitBtnLocked
        Left = 460
        Top = 0
        Width = 114
        Height = 22
        Caption = '[F6] Estoque das lojas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Visible = False
        OnClick = btnEstoqueClick
      end
      object btnLitragem: TBitBtnLocked
        Left = 574
        Top = 0
        Width = 70
        Height = 22
        Caption = '[F5] Litragem'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnLitragemClick
      end
      object btnLitragemPorUnidade: TBitBtnLocked
        Left = 644
        Top = 0
        Width = 97
        Height = 22
        Caption = '[ ALT+F5 ] Unidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnLitragemPorUnidadeClick
      end
      object btnApaga: TBitBtnLocked
        Left = 741
        Top = 0
        Width = 66
        Height = 22
        Caption = '[DEL] Apaga'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Visible = False
        OnClick = btnApagaClick
      end
      object btnGarantiaPend: TBitBtnLocked
        Left = 807
        Top = 0
        Width = 127
        Height = 22
        Caption = '[F4] Garantias Pendentes'
        TabOrder = 8
        Visible = False
        OnClick = btnGarantiaPendClick
      end
      object btnMaisInf: TBitBtnLocked
        Left = 934
        Top = 0
        Width = 134
        Height = 22
        Hint = 'Acessar o Cadastro de Forma'#231#227'o de Pre'#231'os do Fornecedor'
        Caption = '[Ctrl+F3] Mais Informa'#231#245'es'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = btnMaisInfClick
      end
      object btnResumoLoja: TBitBtnLocked
        Left = 1068
        Top = 0
        Width = 108
        Height = 22
        Caption = '[Alt+F2] Resumo Loja'
        TabOrder = 10
        Visible = False
        OnClick = btnResumoLojaClick
      end
      object btnEmbalagem: TBitBtnLocked
        Left = 1176
        Top = 0
        Width = 100
        Height = 22
        Caption = '[Alt+F7] Embalagem'
        TabOrder = 11
        Visible = False
        OnClick = btnEmbalagemClick
      end
      object btnTrocaPedido: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 146
        Height = 22
        Hint = 'Troca o Pedido da Requisi'#231#227'o'
        Caption = '[Ctrl+F4] Troca Ped. da Requ.'
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = btnTrocaPedidoClick
      end
      object btnAltTra: TBitBtnLocked
        Left = 146
        Top = 22
        Width = 86
        Height = 22
        Caption = 'Altera &Transfer'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = btnAltTraClick
      end
      object btnInfPedidoDeVendas: TBitBtnLocked
        Left = 232
        Top = 22
        Width = 178
        Height = 22
        Caption = '[Alt+F12]Vincular Pedido de Venda '
        NumGlyphs = 2
        TabOrder = 14
        OnClick = btnInfPedidoDeVendasClick
      end
      object btnTranEst: TBitBtnLocked
        Left = 410
        Top = 22
        Width = 146
        Height = 22
        Caption = '[Ctrl+F8] Transf. Pendentes'
        TabOrder = 15
        OnClick = btnTranEstClick
      end
      object btnDocSalRes: TBitBtnLocked
        Left = 556
        Top = 22
        Width = 167
        Height = 22
        Hint = 'Visualizar o documentos que reservam este item'
        Caption = '[Alt+F11] Doc. de Sal. Reservado'
        TabOrder = 16
        OnClick = btnDocSalResClick
      end
      object btnCotAbe: TBitBtnLocked
        Left = 723
        Top = 22
        Width = 138
        Height = 22
        Caption = '[Alt+F9] Cota'#231#245'es Abertas'
        TabOrder = 17
        OnClick = btnCotAbeClick
      end
      object btnAltTabPre: TBitBtnLocked
        Left = 861
        Top = 22
        Width = 159
        Height = 22
        Caption = '[Alt+F3] Altera Tabela de Pre'#231'os'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        OnClick = btnAltTabPreClick
      end
      object btnImporta: TBitBtnLocked
        Left = 1020
        Top = 22
        Width = 178
        Height = 22
        Caption = '[F12] Import./Consulta Requisi'#231#227'o'
        NumGlyphs = 2
        TabOrder = 19
        OnClick = btnImportaClick
      end
      object btnQuantidadeVendasPerdidas: TBitBtnLocked
        Left = 1198
        Top = 22
        Width = 150
        Height = 22
        Anchors = [akTop, akRight]
        Caption = 'Quantidade Vendas Perdidas'
        TabOrder = 21
        OnClick = btnQuantidadeVendasPerdidasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1278
      Top = 2
      Width = 76
      ExplicitLeft = 1278
      ExplicitTop = 2
      ExplicitWidth = 76
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1360
    TabOrder = 4
    ExplicitTop = 723
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 1189
      ExplicitLeft = 1189
    end
    inherited pnlInfo: TPanel
      Width = 1189
      ExplicitWidth = 1189
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 1360
    Height = 150
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 2
      Top = 57
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Entrega:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 33
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comprador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 21
      Top = 79
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cnd.Pgto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdCtn: TLabel
      Left = 666
      Top = 57
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Containers:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEdicao: TLabel
      Left = 641
      Top = 10
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'EDI'#199#195'O DO PED. Nro.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpDestino: TLabel
      Left = 661
      Top = 33
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 649
      Top = 81
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto Adicional:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 797
      Top = 81
      Width = 13
      Height = 14
      Caption = '% '
    end
    object lblDiaCom: TLabel
      Left = 448
      Top = 100
      Width = 72
      Height = 12
      Caption = 'DIAS COMPRA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label28: TLabel
      Left = 136
      Top = 56
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Faturam.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCreFor: TLabel
      Left = 41
      Top = 98
      Width = 239
      Height = 14
      Caption = 'Existem cr'#233'ditos em aberto para esse fornecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      Visible = False
      WordWrap = True
      OnClick = lblCreForClick
    end
    object lblTitDig: TLabel
      Left = 257
      Top = 33
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object lblLegQtdTra: TLabel
      Left = 1063
      Top = 33
      Width = 234
      Height = 14
      Caption = '(Qtd. Transferir (*)  em unidades de venda)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 1063
      Top = 46
      Width = 220
      Height = 14
      Caption = '(Qtd. Requis. (*)  em unidades de venda)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 1063
      Top = 60
      Width = 293
      Height = 14
      Caption = '([Shift + Seta] marca/desmarca para exclus'#227'o no grid)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodSolicitacaoVinculada: TLabel
      Left = 1021
      Top = 6
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cod. Solicita'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object chkPedInt: TCheckBox
      Left = 488
      Top = 20
      Width = 129
      Height = 14
      Caption = 'Pedido Entrepostado'
      TabOrder = 9
      OnClick = chkPedIntClick
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 70
      Top = 6
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
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
    object mskDtaPed: TMaskEditFocus
      Tag = 99
      Left = 70
      Top = 52
      Width = 63
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
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 70
      Top = 75
      Width = 541
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 6
      Text = ''
      OnExit = edtDesAdiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomFor: TEditFocus
      Left = 134
      Top = 6
      Width = 343
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkPedImp: TCheckBox
      Left = 488
      Top = 5
      Width = 129
      Height = 14
      Caption = 'Pedido de Importa'#231#227'o'
      TabOrder = 8
      OnClick = chkPedImpClick
      OnEnter = chkPedImpEnter
    end
    object edtQtdCtn: TEditFocus
      Tag = 99
      Left = 747
      Top = 53
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNumPed: TEditFocus
      Left = 747
      Top = 5
      Width = 86
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEmpDestino: TEditFocus
      Left = 747
      Top = 29
      Width = 46
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesAdi: TEditFocus
      Tag = 99
      Left = 747
      Top = 77
      Width = 46
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      OnEnter = edtDesAdiEnter
      OnExit = edtDesAdiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object mskDtaFat: TMaskEditFocus
      Tag = 99
      Left = 209
      Top = 52
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      OnEnter = mskDtaFatEnter
      OnExit = mskDtaFatExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNomCmp: TEditFocus
      Left = 134
      Top = 29
      Width = 113
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCmp: TEditFocus
      Tag = 99
      Left = 70
      Top = 29
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 1
      OnExit = edtCodCmpExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkPgAVis: TCheckBox
      Left = 305
      Top = 55
      Width = 119
      Height = 14
      Caption = 'Cnd. Pagto '#192' Vista'
      TabOrder = 5
      OnClick = chkPgAVisClick
      OnExit = edtDesAdiExit
    end
    object chkPedBon: TCheckBox
      Left = 488
      Top = 35
      Width = 129
      Height = 14
      Caption = 'Pedido de Bonifica'#231#227'o'
      TabOrder = 10
      OnClick = chkPedBonClick
    end
    object chkCnvEmb: TCheckBox
      Left = 1063
      Top = 94
      Width = 214
      Height = 16
      Caption = 'Converter de unidade para embalagem?'
      TabOrder = 17
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 305
      Top = 29
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 355
      Top = 29
      Width = 122
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnDtaEnt: TBitBtnLocked
      Left = 425
      Top = 51
      Width = 186
      Height = 22
      Caption = 'Altera &Data Entrega (todos produtos)'
      TabOrder = 23
      TabStop = False
      Visible = False
      OnClick = btnDtaEntClick
    end
    object chkSuspOrdem: TCheckBox
      Left = 1063
      Top = 77
      Width = 185
      Height = 17
      Caption = 'Suspender ordena'#231#227'o autom'#225'tica'
      TabOrder = 16
      OnClick = chkSuspOrdemClick
    end
    object chkPreDol: TCheckBox
      Left = 340
      Top = 99
      Width = 102
      Height = 14
      Caption = 'Pedido em D'#243'lar'
      TabOrder = 7
      OnClick = chkPreDolClick
    end
    object rdgDesPdi: TRadioGroup
      Left = 841
      Top = 98
      Width = 161
      Height = 43
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Descri'#231#227'o do Produto:'
      ItemIndex = 0
      Items.Strings = (
        'Desc.Principal do Produto'
        'Desc.do Fabricante')
      TabOrder = 14
      Visible = False
      StyleElements = []
      OnClick = rdgDesPdiClick
    end
    object rdgCodigoFabricaProduto: TRadioGroup
      Left = 41
      Top = 112
      Width = 579
      Height = 37
      Caption = 'C'#243'd.F'#225'brica do Produto:'
      Columns = 2
      Items.Strings = (
        'C'#243'd.F'#225'brica Principal do Produto'
        'C'#243'd.F'#225'brica de cada Fornecedor do Pedido de Compra')
      TabOrder = 24
      OnClick = rdgCodigoFabricaProdutoClick
    end
    object GroupBox1: TGroupBox
      Left = 841
      Top = 0
      Width = 171
      Height = 69
      Caption = 'Exibir / Ocultar na Tela'
      TabOrder = 25
      object lblExiApli: TLabel
        Left = 3
        Top = 13
        Width = 158
        Height = 14
        Cursor = crHandPoint
        Caption = 'Ocultar Aplica'#231#227'o do Produto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblExiApliClick
      end
      object lblOpcGir: TLabel
        Left = 3
        Top = 47
        Width = 131
        Height = 14
        Cursor = crHandPoint
        Caption = 'Mostrar op'#231#245'es do Giro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblOpcGirClick
      end
      object lblExiGiro: TLabel
        Left = 3
        Top = 30
        Width = 155
        Height = 14
        Cursor = crHandPoint
        Caption = 'Ocultar Informa'#231#245'es de Giro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblExiGiroClick
      end
    end
    object chkZeraST: TCheckBox
      Left = 845
      Top = 69
      Width = 212
      Height = 24
      Caption = 
        'N'#227'o Calcular Sub.Tributaria (Fornecedor sem conv'#234'nio/protocolo p' +
        'ara ICMS ST)'
      TabOrder = 26
      WordWrap = True
      OnClick = chkZeraSTClick
    end
    object chkPagamentoCartaoCredito: TCheckBox
      Left = 641
      Top = 99
      Width = 185
      Height = 17
      Caption = 'Pagamento com Cart'#227'o de Cr'#233'dito'
      TabOrder = 13
    end
    object edtCodSolicitacaoVinculada: TEditFocus
      Tag = 99
      Left = 1104
      Top = 3
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      OnKeyPress = edtCodSolicitacaoVinculadaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel4: TPanel [3]
    Left = 0
    Top = 669
    Width = 1360
    Height = 54
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblTotIpi: TLabel
      Left = 426
      Top = 6
      Width = 16
      Height = 14
      Alignment = taRightJustify
      Caption = 'IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 293
      Top = 6
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'PRODUT.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotGer: TLabel
      Left = 1205
      Top = 6
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'TOTAL:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblLitragem: TLabel
      Left = 175
      Top = 6
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'LIT./QUI.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotSubRod: TLabel
      Left = 529
      Top = 6
      Width = 19
      Height = 14
      Alignment = taRightJustify
      Caption = 'ST.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 6
      Top = 7
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'PESO BRUTO TOT:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 707
      Top = 6
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'FRETE:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 814
      Top = 6
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'DESP. ACE.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotDeson: TLabel
      Left = 1058
      Top = 6
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS DESON:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotDesPis: TLabel
      Left = 947
      Top = 6
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'DESC. PIS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 623
      Top = 6
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'FCP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeTotIte: TDBEdit
      Left = 343
      Top = 3
      Width = 81
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTITE'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
    end
    object dbeTotSub: TDBEdit
      Left = 549
      Top = 3
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTSUB'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
    end
    object dbeTotIpi: TDBEdit
      Left = 444
      Top = 3
      Width = 81
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTIPI'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
    end
    object dbeTotLit: TDBEdit
      Left = 223
      Top = 3
      Width = 68
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_LITROS'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
    end
    object dbeTotPes: TDBEdit
      Left = 102
      Top = 3
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_PESOIT'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
    end
    object edtTotFre: TEditFocus
      Left = 744
      Top = 3
      Width = 68
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
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
    object edtTotDes: TEditFocus
      Left = 877
      Top = 3
      Width = 68
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotGer: TEditFocus
      Left = 1246
      Top = 3
      Width = 98
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object dbdTotDeson: TDBEdit
      Left = 1129
      Top = 3
      Width = 73
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_VALICM'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
    end
    object dbeDESPIS: TDBEdit
      Left = 1003
      Top = 3
      Width = 53
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_DESPIS'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
    end
    object dbeSubFCP: TDBEdit
      Left = 650
      Top = 3
      Width = 54
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_SUBFCP'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
    end
    object lblTotCBS: TLabel
      Left = 414
      Top = 33
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'CBS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotIBS: TLabel
      Left = 527
      Top = 33
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'IBS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotIS: TLabel
      Left = 633
      Top = 33
      Width = 16
      Height = 14
      Alignment = taRightJustify
      Caption = 'IS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeTotCBS: TDBEdit
      Left = 446
      Top = 30
      Width = 81
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_VALCBS'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
    end
    object dbeTotIBS: TDBEdit
      Left = 551
      Top = 30
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_VALIBS'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
    end
    object dbeTotIS: TDBEdit
      Left = 652
      Top = 30
      Width = 54
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_VAL_IS'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
    end
  end
  object pnlRedimensiona: TPanel [4]
    Left = 0
    Top = 309
    Width = 1360
    Height = 337
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object splAplicacao: TSplitter
      Left = 0
      Top = 60
      Width = 1360
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Beveled = True
      Color = clYellow
      MinSize = 20
      ParentColor = False
      ResizeStyle = rsNone
      OnCanResize = splAplicacaoCanResize
      ExplicitLeft = 29
      ExplicitTop = 179
      ExplicitWidth = 1274
    end
    object pnlGrid: TPanel
      Left = 0
      Top = 0
      Width = 1360
      Height = 60
      Align = alClient
      ParentColor = True
      TabOrder = 0
      object cxgItens: TcxGrid
        Left = 1
        Top = 1
        Width = 1358
        Height = 35
        Align = alClient
        TabOrder = 0
        OnEnter = cxgItensEnter
        OnExit = cxgItensExit
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvItens: TcxGridDBTableView
          OnDblClick = cxvItensDblClick
          OnKeyDown = cxvItensKeyDown
          OnMouseUp = cxvItensMouseUp
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = cxvItensCellClick
          OnCustomDrawCell = cxvItensCustomDrawCell
          OnInitEdit = cxvItensInitEdit
          DataController.DataSource = dtsItensPedido
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = 'Quantidade = #0 itens '
              Kind = skCount
              Column = cxvItensNVLGIR
            end
            item
              Format = 'Total da Compra R$ #0.00'
              Kind = skSum
              FieldName = 'ITE_TOTGER'
              Column = cxvItensTOTITE
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = 'Quantidade total de itens = #0'
              Kind = skCount
              Column = cxvItensDESITE
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Column = cxvItensVALDAR
            end
            item
              Format = '#,##0.00;-0.00'
              Kind = skSum
              Column = cxvItensQTDREQ
            end
            item
              Format = '#,##0.00;-0.00'
              Kind = skSum
              Column = cxvItensQTDITE
            end
            item
              Format = '#,##0.00;-0.00'
              Kind = skSum
              Column = cxvItensQTDTRA
            end>
          DataController.Summary.SummaryGroups = <>
          DataController.OnCompare = cxvItensDataControllerCompare
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum item incluido>'
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle1
          OnColumnHeaderClick = cxvItensColumnHeaderClick
          object cxvItensQTDALT: TcxGridDBColumn
            Caption = 'Alterado'
            DataBinding.FieldName = 'ITE_QTDALT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderHint = 
              'Fica marcada se quantidade a comprar ou a transferir s'#227'o alterad' +
              'as'
            Options.Editing = False
            Width = 36
          end
          object cxvItensCORMED: TcxGridDBColumn
            Caption = 'Dif. M'#233'dia'
            DataBinding.FieldName = 'ITE_CORMED'
            PropertiesClassName = 'TcxColorComboBoxProperties'
            Properties.CustomColors = <
              item
                Color = clGreen
                Description = 'Verde'
              end
              item
                Color = clYellow
                Description = 'Amarelo'
              end
              item
                Color = clRed
                Description = 'Vermelho'
              end>
            Properties.ShowDescriptions = False
            Options.Editing = False
            Width = 40
          end
          object cxvItensNVLGIR: TcxGridDBColumn
            Caption = 'N'#237'vel de Giro'
            DataBinding.FieldName = 'ITE_NVLGIR'
            Visible = False
            GroupIndex = 0
            Options.Editing = False
          end
          object cxvItensPrinc: TcxGridDBColumn
            Caption = '*'
            DataBinding.FieldName = 'ITE_PRINCI'
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 20
          end
          object cxvItensNUMERO: TcxGridDBColumn
            Caption = 'N'#186
            DataBinding.ValueType = 'String'
            OnGetDisplayText = cxvItensNUMEROGetDisplayText
            Options.Editing = False
          end
          object cxvItensCODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 55
          end
          object cxvItensCODFAB: TcxGridDBColumn
            Caption = 'C'#243'd. F'#225'brica'
            DataBinding.FieldName = 'ITE_CODFAB'
            Visible = False
            Options.Editing = False
            Width = 83
          end
          object cxvItensDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Item'
            DataBinding.FieldName = 'ITE_DESITE'
            Options.Editing = False
            Width = 368
          end
          object cxvItensDESSIM: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Simplificada'
            DataBinding.FieldName = 'ITE_DESSIM'
            Options.Editing = False
            Width = 165
          end
          object cxvItensDTAULT: TcxGridDBColumn
            Caption = 'Data da '#218'ltima Compra'
            DataBinding.FieldName = 'ITE_DTAULT'
            Visible = False
            Options.Editing = False
            Width = 126
          end
          object cxvItensREFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'ITE_REFERE'
            Width = 131
          end
          object cxvItensDESMAR: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'ITE_DESMAR'
            Options.Editing = False
            Width = 128
          end
          object cxvItensTEMREQ: TcxGridDBColumn
            Caption = 'Req. Compra?'
            DataBinding.FieldName = 'ITE_QTDREQ'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Orientation = cxoLeft
            Visible = False
            OnGetDisplayText = cxvItensTEMREQGetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 75
          end
          object cxvItensQTDREQ: TcxGridDBColumn
            Caption = 'Qtd. Requis. (*)'
            DataBinding.FieldName = 'ITE_QTDREQ'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 85
          end
          object cxvItensQTDITE: TcxGridDBColumn
            Caption = 'Qtd. Comprar'
            DataBinding.FieldName = 'ITE_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            Properties.OnEditValueChanged = cxvItensQTDITEPropertiesEditValueChanged
            Properties.OnValidate = cxvItensQTDITEPropertiesValidate
            OnCustomDrawCell = cxvItensQTDITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            MinWidth = 72
            Options.Editing = False
            Width = 72
          end
          object cxvItensQTDTRA: TcxGridDBColumn
            Caption = 'Qtd. a Transferir para Rec. de Transferencia (*)'
            DataBinding.FieldName = 'ITE_QTDTRA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 237
          end
          object cxvItensSALDIS: TcxGridDBColumn
            Caption = 'Saldo Disp.'
            DataBinding.FieldName = 'ITE_SALDIS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxvItensSIGUNI: TcxGridDBColumn
            Caption = 'Uni.'
            DataBinding.FieldName = 'ITE_SIGUNI'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 29
          end
          object cxvItensLITROS: TcxGridDBColumn
            Caption = 'Litrag.'
            DataBinding.FieldName = 'ITE_LITROS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 49
          end
          object cxvItensUNITAR: TcxGridDBColumn
            Caption = 'Vr. Unit'#225'rio'
            DataBinding.FieldName = 'ITE_UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            Properties.OnEditValueChanged = cxvItensUNITARPropertiesEditValueChanged
            Properties.OnValidate = cxvItensUNITARPropertiesValidate
            OnCustomDrawCell = cxvItensUNITARCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 67
          end
          object cxvItensDIFPRE: TcxGridDBColumn
            Caption = '% Varia'#231#227'o Pr.Unit'
            DataBinding.FieldName = 'ITE_DIFPRE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderHint = 
              'Diferen'#231'a em Porcentagem do Pre'#231'o Unit'#225'rio  X Pre'#231'o '#218'ltima Compr' +
              'a.'
            Options.Editing = False
            Width = 100
          end
          object cxvItensTOTITE: TcxGridDBColumn
            Caption = 'Valor Total'
            DataBinding.FieldName = 'ITE_TOTITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 91
          end
          object cxvItensPERIPI: TcxGridDBColumn
            Caption = '% IPI'
            DataBinding.FieldName = 'ITE_PERIPI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 45
          end
          object cxvItensTOTIPI: TcxGridDBColumn
            Caption = 'Valor do IPI'
            DataBinding.FieldName = 'ITE_TOTIPI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
          end
          object cxvItensALQCBS: TcxGridDBColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'ITE_ALQCBS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 45
          end
          object cxvItensVALCBS: TcxGridDBColumn
            Caption = 'Valor CBS'
            DataBinding.FieldName = 'ITE_VALCBS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxvItensALQIBS: TcxGridDBColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'ITE_ALQIBS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 45
          end
          object cxvItensVALIBS: TcxGridDBColumn
            Caption = 'Valor IBS'
            DataBinding.FieldName = 'ITE_VALIBS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxvItensALQ_IS: TcxGridDBColumn
            Caption = '% IS'
            DataBinding.FieldName = 'ITE_ALQ_IS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 45
          end
          object cxvItensVAL_IS: TcxGridDBColumn
            Caption = 'Valor IS'
            DataBinding.FieldName = 'ITE_VAL_IS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxvItensPERSUB: TcxGridDBColumn
            Caption = '%Sub.'
            DataBinding.FieldName = 'ITE_PERSUB'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
          end
          object cxvItensTOTSUB: TcxGridDBColumn
            Caption = 'Valor Subst.'
            DataBinding.FieldName = 'ITE_TOTSUB'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxvItensVALICM: TcxGridDBColumn
            Caption = 'ICMS Deson.'
            DataBinding.FieldName = 'ITE_VALICM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#0.00;-#0.00'
            Options.Editing = False
            Width = 67
          end
          object cxvItensVALDAR: TcxGridDBColumn
            Caption = 'Valor DARE'
            DataBinding.FieldName = 'ITE_TOTDAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 80
          end
          object cxvItensUNIIMP: TcxGridDBColumn
            Caption = 'Unit'#225'rio c/ Imp.'
            DataBinding.FieldName = 'ITE_UNIIMP'
            HeaderAlignmentHorz = taRightJustify
            Width = 84
          end
          object cxvItensDESUNI: TcxGridDBColumn
            Caption = '%Desc.'
            DataBinding.FieldName = 'ITE_DESUNI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensDESUN2: TcxGridDBColumn
            Caption = '%Desc.2'
            DataBinding.FieldName = 'ITE_DESUN2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensDESUN3: TcxGridDBColumn
            Caption = '%Desc.3'
            DataBinding.FieldName = 'ITE_DESUN3'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensDESUN4: TcxGridDBColumn
            Caption = '%Desc.4'
            DataBinding.FieldName = 'ITE_DESUN4'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensDESUN5: TcxGridDBColumn
            Caption = '%Desc.5'
            DataBinding.FieldName = 'ITE_DESUN5'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensDESUN6: TcxGridDBColumn
            Caption = '%Desc.6'
            DataBinding.FieldName = 'ITE_DESUN6'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensUNILIQ: TcxGridDBColumn
            Caption = 'Unit. L'#237'quido'
            DataBinding.FieldName = 'ITE_UNILIQ'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Visible = False
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxvItensCLAIPI: TcxGridDBColumn
            Caption = 'NCM'
            DataBinding.FieldName = 'ITE_CLAIPI'
            Options.Editing = False
            Width = 151
          end
          object cxvItensCOSDIT: TcxGridDBColumn
            Caption = 'CST'
            DataBinding.FieldName = 'ITE_CODSIT'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 40
          end
          object cxvItensDIAEST: TcxGridDBColumn
            Caption = 'Dias Estoque'
            DataBinding.FieldName = 'ITE_DIAEST'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
          end
          object cxvItensDIASUG: TcxGridDBColumn
            Caption = 'Dias Estoq. Qtd. Comprada'
            DataBinding.FieldName = 'ITE_DIASUG'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 143
          end
          object cxvItensINCIRQ: TcxGridDBColumn
            DataBinding.FieldName = 'ITE_INCIRQ'
            Visible = False
          end
          object cxvItensDTAENT: TcxGridDBColumn
            Caption = 'Data Entrega'
            DataBinding.FieldName = 'ITE_DTAENT'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 70
          end
          object cxvItensBAINOT: TcxGridDBColumn
            Caption = 'Nota de Entrada'
            DataBinding.FieldName = 'ITE_BAINOT'
            Options.Editing = False
            Width = 120
          end
          object cxvItensCORSIT: TcxGridDBColumn
            Caption = 'Cor Situa'#231#227'o'
            DataBinding.FieldName = 'ITE_CORSIT'
            Visible = False
          end
          object cxvItensDESSIT: TcxGridDBColumn
            Caption = 'Situa'#231#227'o Produto'
            DataBinding.FieldName = 'ITE_DESSIT'
            Visible = False
          end
          object cxvItensPRAVAL: TcxGridDBColumn
            Caption = 'Prazo Validade(Meses)'
            DataBinding.FieldName = 'ITE_PRAVAL'
            Options.Editing = False
            Width = 132
          end
          object cxvItensFORPRI: TcxGridDBColumn
            Caption = 'Fornecedor Principal'
            DataBinding.FieldName = 'ITE_FORPRI'
            Visible = False
            Options.Editing = False
          end
          object cxvItensDEPART: TcxGridDBColumn
            Caption = 'Departamento'
            DataBinding.FieldName = 'ITE_DEPART'
            Visible = False
            Options.Editing = False
          end
          object cxvItensDESGRU: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Grupo/Linha'
            DataBinding.FieldName = 'ITE_DESGRU'
            Options.Editing = False
            Width = 64
          end
          object cxvItensTIPABS: TcxGridDBColumn
            Caption = 'Tipo Abastecimento'
            DataBinding.FieldName = 'ITE_TIPABS'
            OnGetDisplayText = cxvItensTIPABSGetDisplayText
            Options.Editing = False
          end
          object cxvItensVNOLCD: TcxGridDBColumn
            Caption = 'Venda Saldo Outra Loja/CD'
            DataBinding.FieldName = 'ITE_VNOLCD'
            OnGetDisplayText = cxvItensVNOLCDGetDisplayText
            Options.Editing = False
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxvItens
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 36
        Width = 1358
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object btnCfgGri: TBitBtnLocked
          Left = -1
          Top = 0
          Width = 148
          Height = 22
          Caption = 'Confi&gura colunas '
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
            00090000000E0000000F00000010000000100000001100000011000000110000
            00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
            4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
            ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
            6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
            9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
            71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
            64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
            75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
            B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
            78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
            BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
            7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
            BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
            7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
            C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
            84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
            C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
            87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
            D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
            8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
            97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
            8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
            AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
            91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
            F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
            95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
            FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
            6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
            93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
          TabOrder = 0
          OnClick = btnCfgGriClick
        end
      end
    end
    object pnlContainerGiroAplica: TPanel
      Left = 0
      Top = 63
      Width = 1360
      Height = 274
      Align = alBottom
      ParentColor = True
      TabOrder = 1
      object splGiro: TSplitter
        Left = 1
        Top = 60
        Width = 1358
        Height = 3
        Cursor = crVSplit
        Align = alTop
        AutoSnap = False
        Beveled = True
        Color = clYellow
        MinSize = 20
        ParentColor = False
        ResizeStyle = rsNone
        ExplicitTop = 56
        ExplicitWidth = 1284
      end
      object pnlAplicacao: TPanel
        Left = 1
        Top = 1
        Width = 1358
        Height = 59
        Align = alTop
        BevelOuter = bvNone
        DoubleBuffered = False
        ParentBackground = False
        ParentColor = True
        ParentDoubleBuffered = False
        TabOrder = 0
        object splVeiculos: TSplitter
          Left = 647
          Top = 18
          Height = 41
          Align = alRight
          Color = clYellow
          ParentColor = False
          ExplicitLeft = 516
          ExplicitTop = 24
          ExplicitHeight = 124
        end
        object pnlTitAplic: TPanel
          Left = 0
          Top = 0
          Width = 1358
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Aplica'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
        end
        object dbeAplica: TDBMemoFocus
          Left = 0
          Top = 18
          Width = 647
          Height = 41
          Align = alClient
          DataField = 'ITE_APLICA'
          DataSource = dtsItensPedido
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object cxVeiculoProduto: TcxGrid
          Left = 650
          Top = 18
          Width = 708
          Height = 41
          Align = alRight
          TabOrder = 2
          object cxVeiculoProdutoView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '< Sem dados para exibir >'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Styles.ContentEven = cxStyle1
            object cxVeiculosProdutoDESMAR: TcxGridDBColumn
              Caption = 'Marca'
              DataBinding.FieldName = 'MAR_DESMAR'
              HeaderAlignmentHorz = taCenter
              Width = 105
            end
            object cxVeiculosProdutoDESMOD: TcxGridDBColumn
              Caption = 'Modelo'
              DataBinding.FieldName = 'MOD_DESMOD'
              HeaderAlignmentHorz = taCenter
              Width = 124
            end
            object cxVeiculosProdutoANOINI: TcxGridDBColumn
              Caption = 'Ano Inicial'
              DataBinding.FieldName = 'MOD_ANOINI'
              HeaderAlignmentHorz = taCenter
              Width = 57
            end
            object cxVeiculosProdutoANOFIN: TcxGridDBColumn
              Caption = 'Ano Final'
              DataBinding.FieldName = 'MOD_ANOFIN'
              HeaderAlignmentHorz = taCenter
              Width = 51
            end
            object cxVeiculosProdutoCOMBUS: TcxGridDBColumn
              Caption = 'Combust'#237'vel'
              DataBinding.FieldName = 'MOD_COMBUS'
              HeaderAlignmentHorz = taCenter
              Width = 67
            end
            object cxVeiculosProdutoVALVUL: TcxGridDBColumn
              Caption = 'V'#225'lvula'
              DataBinding.FieldName = 'MOD_VALVUL'
              HeaderAlignmentHorz = taCenter
              Width = 42
            end
            object cxVeiculosProdutoCILIND: TcxGridDBColumn
              Caption = 'Cilindrada'
              DataBinding.FieldName = 'MOD_CILIND'
              HeaderAlignmentHorz = taCenter
              Width = 55
            end
            object cxVeiculosProdutoPOTENC: TcxGridDBColumn
              Caption = 'Pot'#234'ncia'
              DataBinding.FieldName = 'MOD_POTENC'
              HeaderAlignmentHorz = taCenter
              Width = 50
            end
            object cxVeiculoProdutoOBSERV: TcxGridDBColumn
              Caption = 'Observa'#231#245'es'
              DataBinding.FieldName = 'MOD_OBSERV'
              HeaderAlignmentHorz = taCenter
              Width = 140
            end
          end
          object cxVeiculoProdutoLevel1: TcxGridLevel
            GridView = cxVeiculoProdutoView
          end
        end
      end
      object pnlGiro: TPanel
        Left = 1
        Top = 63
        Width = 1358
        Height = 210
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
      end
    end
  end
  object pnlItensFixo: TPanel [5]
    Left = 0
    Top = 150
    Width = 1360
    Height = 159
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object pnlItens: TPanel
      Left = 0
      Top = 0
      Width = 1360
      Height = 159
      Align = alClient
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object pnlComum: TPanel
        Left = 1
        Top = 1
        Width = 1358
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label5: TLabel
          Left = 22
          Top = 18
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 169
          Top = 18
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 639
          Top = 18
          Width = 18
          Height = 14
          Alignment = taRightJustify
          Caption = 'Uni:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 4
          Top = 41
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 165
          Top = 41
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Unit'#225'rio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 965
          Top = 41
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 306
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = '%Des.1:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 390
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = '%Des.2:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 806
          Top = 41
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr.Unit'#225'rio L'#237'q.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object btnTodIte: TSpeedButton
          Left = 143
          Top = 14
          Width = 23
          Height = 21
          Hint = 'Consulta todos os Itens'
          Flat = True
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
          ParentShowHint = False
          ShowHint = True
          OnClick = btnTodIteClick
        end
        object lblEmpGir: TLabel
          Left = 1016
          Top = 9
          Width = 87
          Height = 14
          Caption = 'Empresas do giro:'
          Visible = False
        end
        object lblEmbala: TLabel
          Left = 752
          Top = 18
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Embalagem:'
        end
        object Label15: TLabel
          Left = 473
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = '%Des.3:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 556
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = '%Des.4:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label39: TLabel
          Left = 637
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = '%Des.5:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label40: TLabel
          Left = 717
          Top = 41
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = '%Des.6:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblOcultarDadosGeraisDoPedido: TLabel
          Left = 343
          Top = -1
          Width = 172
          Height = 14
          Cursor = crHandPoint
          Caption = 'Ocultar dados gerais do pedido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblOcultarDadosGeraisDoPedidoClick
        end
        object Label19: TLabel
          Left = 905
          Top = 8
          Width = 75
          Height = 28
          Alignment = taRightJustify
          Caption = 'Prazo Validade (Meses):'
          WordWrap = True
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 64
          Top = 14
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          OnKeyUp = edtCodIteKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 224
          Top = 14
          Width = 411
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 70
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodUni: TEditFocus
          Tag = 99
          Left = 657
          Top = 14
          Width = 45
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          OnExit = edtCodUniExit
          OnKeyPress = edtCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtQtdIte: TEditFocus
          Tag = 99
          Left = 64
          Top = 37
          Width = 78
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          OnEnter = edtQtdIteEnter
          OnExit = edtQtdIteExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtUnitar: TEditFocus
          Tag = 99
          Left = 224
          Top = 37
          Width = 78
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
        end
        object edtValTot: TEditFocus
          Tag = 99
          Left = 1023
          Top = 37
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object rdbCodIte: TRadioButton
          Left = 77
          Top = 0
          Width = 113
          Height = 14
          Caption = 'C'#243'digo do Item'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rdbCodIteClick
        end
        object rdbCodFab: TRadioButton
          Left = 229
          Top = 0
          Width = 113
          Height = 14
          Caption = 'C'#243'digo da F'#225'brica'
          TabOrder = 1
          OnClick = rdbCodFabClick
        end
        object edtSigUni: TEditFocus
          Left = 702
          Top = 14
          Width = 43
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesUni: TEditFocus
          Tag = 99
          Left = 350
          Top = 37
          Width = 36
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesUn2: TEditFocus
          Tag = 99
          Left = 434
          Top = 37
          Width = 36
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtUniLiq: TEditFocus
          Tag = 99
          Left = 880
          Top = 37
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object mmoEmpGir: TMemoFocus
          Left = 1107
          Top = 5
          Width = 169
          Height = 51
          TabStop = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 17
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object edtEmbala: TEditFocus
          Left = 811
          Top = 14
          Width = 86
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.0000'
        end
        object edtDesUn3: TEditFocus
          Tag = 99
          Left = 515
          Top = 37
          Width = 36
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesUn4: TEditFocus
          Tag = 99
          Left = 599
          Top = 37
          Width = 36
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesUn5: TEditFocus
          Tag = 99
          Left = 679
          Top = 37
          Width = 36
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDesUn6: TEditFocus
          Tag = 99
          Left = 762
          Top = 37
          Width = 36
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtPraval: TEditFocus
          Left = 983
          Top = 14
          Width = 28
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlPedNor: TPanel
        Left = 1
        Top = 61
        Width = 1358
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object lbl12: TLabel
          Left = 36
          Top = 5
          Width = 26
          Height = 14
          Alignment = taRightJustify
          Caption = '% IPI:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl13: TLabel
          Left = 180
          Top = 5
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor IPI:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblPerSub: TLabel
          Left = 312
          Top = 5
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = '% Sub:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTotSub: TLabel
          Left = 420
          Top = 5
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Sub:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblIcmDes: TLabel
          Left = 931
          Top = 5
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'ICMS Desonerado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lblDesPis: TLabel
          Left = 736
          Top = 5
          Width = 107
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto PIS/COFINS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object Label24: TLabel
          Left = 571
          Top = 5
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Sub FCP:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblValDar: TLabel
          Left = 1115
          Top = 5
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor DARE:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object edtPerIpi: TEditFocus
          Tag = 99
          Left = 64
          Top = 0
          Width = 78
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,####0.0000'
        end
        object edtTotIpi: TEditFocus
          Tag = 99
          Left = 224
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtTotSub: TEditFocus
          Tag = 99
          Left = 476
          Top = 0
          Width = 78
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtPerSub: TEditFocus
          Tag = 99
          Left = 350
          Top = 0
          Width = 59
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnEnter = edtPerSubEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#0.0000'
        end
        object edtIcmDes: TEditFocus
          Tag = 99
          Left = 1022
          Top = 0
          Width = 78
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesPis: TEditFocus
          Tag = 99
          Left = 845
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtSubFCP: TEditFocus
          Tag = 99
          Left = 646
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtValDar: TEditFocus
          Tag = 99
          Left = 1176
          Top = 0
          Width = 78
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          Visible = False
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
      object pnlImportacao: TPanel
        Left = 1
        Top = 85
        Width = 1358
        Height = 47
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object lbl4: TLabel
          Left = 8
          Top = 4
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = '% Imposto de Importa'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 197
          Top = 4
          Width = 139
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Imposto de Importa'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 467
          Top = 4
          Width = 26
          Height = 14
          Alignment = taRightJustify
          Caption = '% IPI:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl7: TLabel
          Left = 587
          Top = 4
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor do IPI:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl8: TLabel
          Left = 101
          Top = 27
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = '% PIS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl9: TLabel
          Left = 275
          Top = 27
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor do PIS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblPerCof: TLabel
          Left = 428
          Top = 27
          Width = 65
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = '% COFINS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl11: TLabel
          Left = 560
          Top = 28
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor do COFINS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtPerImp: TEditFocus
          Tag = 99
          Left = 135
          Top = 0
          Width = 55
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTotImp: TEditFocus
          Tag = 99
          Left = 339
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtPerIpiImp: TEditFocus
          Tag = 99
          Left = 495
          Top = 0
          Width = 55
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTotIpiImp: TEditFocus
          Tag = 99
          Left = 646
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtPerPis: TEditFocus
          Tag = 99
          Left = 135
          Top = 23
          Width = 55
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTotPis: TEditFocus
          Tag = 99
          Left = 339
          Top = 23
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtPerCof: TEditFocus
          Tag = 99
          Left = 495
          Top = 23
          Width = 55
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTotCof: TEditFocus
          Tag = 99
          Left = 646
          Top = 23
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
      end
      object pnlReforma: TPanel
        Left = 1
        Top = 132
        Width = 1358
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object lblAlqCbs: TLabel
          Left = 29
          Top = 5
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = '% CBS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblValCbs: TLabel
          Left = 167
          Top = 5
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor CBS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblAlqIbs: TLabel
          Left = 316
          Top = 5
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = '% IBS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblValIbs: TLabel
          Left = 419
          Top = 5
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor IBS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblAlq_Is: TLabel
          Left = 580
          Top = 5
          Width = 26
          Height = 14
          Alignment = taRightJustify
          Caption = '% IS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblVal_Is: TLabel
          Left = 676
          Top = 5
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor IS:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtAlqCbs: TEditFocus
          Tag = 99
          Left = 64
          Top = 0
          Width = 78
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtValCbs: TEditFocus
          Tag = 99
          Left = 224
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtAlqIbs: TEditFocus
          Tag = 99
          Left = 350
          Top = 0
          Width = 59
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtValIbs: TEditFocus
          Tag = 99
          Left = 476
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtAlq_Is: TEditFocus
          Tag = 99
          Left = 609
          Top = 0
          Width = 59
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtVal_Is: TEditFocus
          Tag = 99
          Left = 724
          Top = 0
          Width = 78
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
      end
      object pnlAdicionar: TPanel
        Left = 1
        Top = 131
        Width = 1358
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 4
        object btnInsPla: TSpeedButton
          Left = 424
          Top = -2
          Width = 29
          Height = 31
          Hint = 'Inserir itens de arquivo'
          Flat = True
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFC76414E5B582DE9F63D4863FCB6D1F
            C25708BF4E01C76414FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC96718F4DDC2F6
            E3CAF4E0C2F2D5B1F2CB9DC79E81A17360D98435CC6F20C55E0FC05204BD4C00
            BD4C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFCC6918FFE3BDFCE3C0F7DCBAF4DAB6FADCB1F0D4AD0525F7FEDCA9EECC9EEB
            C592EABA7FCC96629A664DD57622C55D0DBF5003BD4C00BD4C00FF00FFFF00FF
            FF00FFFF00FFFF00FFAF581B9898C6F8E3CAF4DDC1F3DABCF2D7B6F2D5B10525
            F7F0D0A6F4D1A1F2CF9DF3CF99EEC7930525F7FACE8BE9BC80E5B06DE0A35CBD
            4D00FF00FFFF00FFFF00FFFF00FFFF00FFBB5F1B1B3AEE2544EF5066E2586BDE
            8089D39396CA0525F7D5C0B1F0CFA6EFCCA1F0CC99EDC7980525F7EBC48EEFC5
            89EEC587EFCA8EBD4D00FF00FFFF00FFFF00FF0E90C90E90C9CA691AACA0BDB2
            B5DC828EDA6E7EDC4F65E13651E50525F70A2AF30525F71A39EB2441E5495CD3
            0525F77E7FB88B87B0B29F9EC2A38CBD4D00FF00FFFF00FF0E90C94AB8E34CBB
            E6C76516E3C6B1FAEBD8F6E2C9F7E1C4F4DDC2F3DCBF0525F7FFE6ACF2D4AFBB
            ADB6AFA4B57E82C10525F7364DD52440DD2440E10E2DEEBD4D00FF00FF0E90C9
            76DDF87FD3F269C9EDCA6614E6C9B5FAEEDDF7E5D1F6E2CCF6E1C7F4DDC20525
            F7F2D8B8F2D7B4F0D4ADF0D0A9EFCFA40525F7FFD993FACF91F0C78EE3BA88BD
            4D00FF00FF0E90C984E3FC99DDF787D5F3AF561B193AF22646F35069EA596FE6
            828EDD979CD70525F7D8C9C1F2D9B7F2D5B2F0D3ADF0D0A70525F7FCD498EEC9
            97EEC792F0CC96BD4D00FF00FF0E90C992EBFFB4E9FBA5E1F8BC5E18B0A7C7B5
            BBED8392E66F82E55068E73753EA0525F70C2DF40525F71B3AEE2442E94A5EDA
            0525F77F82C48C8BBCB4A4ABDCC0A0BD4D00FF00FF0E90C996EDFFC5EFFFBFEB
            FEC96616FFF0DDFCF6EEFFF4D9F8EADAF7E7D5F7E3D00525F7F6DEC5F4DDC0BC
            B5C5B1ABC48086CB0525F74E62D53A52DC2441E50F2EEFBD4D00FF00FF0E90C9
            96EDFFC7F0FFCBF0FFC76516FAEFE2FBF3EBFAEFE2F8EADAFFEED4F7E7D40525
            F7F6E2C9FBE2BDFCE1B8FFE2B2F2D7B40525F7F0D1ABF0D0A5F0CFA1E6C197BD
            4D00FF00FF0E90C996EDFFC6F0FFCBF0FFC55F11F8EADCFBF6EEFBF3EBFBF3EB
            FFFAEAF8EAD80525F7FFF0D3F6E3CAF4E0C2F7DEBCF2D8B80525F7FFDDAAF4D3
            A6F4D1A1FAD8A4BD4D00FF00FF0E90C996EDFFC6F0FFCBF0FFBF4F02CA691CCE
            762BD18039D78A48DE9857BF8E6F0525F7F0C695EFCFACF2D7B8F7DCBAF3DCBD
            0525F7FFE7BDF3DCB8F3D8B2F3DCB5BD4D00FF00FF0E90C996EDFFC6F0FFCBF0
            FFBD4B00BC4700BB4600BB4600BA4300BA4300BC4700BD4B00BA4300BA4300BA
            4300BA4300BA4300BA4300BA4300BA4300BA4300BA4300BD4D00FF00FF0E90C9
            96EDFFC6F0FFCBF0FFBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4B
            00BC4A00BC4A00BC4A00BC4700BC4700C04800BA4300BB4600BC4A00BD4C00BD
            4D00FF00FF0E90C996EDFFC6F0FFCBF0FFBD4C00BD4C00BD4C00BD4C00BD4C00
            BD4C00BD4C00BD4C00BD4C00BD4C00BD4D00BD4D00BD4D00BD4D00BD4C00BD4C
            00BD4C00BD4B00BD4B00FF00FF0E90C99DF0FFD1F6FFD0F2FFB5EDFF81E6FE6B
            E3FF6FE6FF76EAFF0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C966D1F064C1E55BBC
            E253BAE243B8E13AB7E23BBAE551CEF00E90C9FF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C9
            73CBEA91DCF092E1F68BE1F87DDEF86BDAF458D3F044C4E90E90C9FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0E90C967CEED6FDAF666DCF75FDAF85CD8F64BC9EB0E90C9
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C90E90C90E90C90E90C90E
            90C90E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnInsPlaClick
        end
        object lblDatEnt: TLabel
          Left = 156
          Top = 7
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Entrega:'
        end
        object lblDiaEnt: TLabel
          Left = 4
          Top = 7
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dias Entreg:'
        end
        object shpReqCompra: TShape
          Left = 684
          Top = 7
          Width = 14
          Height = 14
          Brush.Color = 612607
        end
        object lblRecCompraLegenda1: TLabel
          Left = 702
          Top = 2
          Width = 415
          Height = 14
          Caption = 
            'Produtos que ficar'#227'o ligados ao pedido de venda gerados pela req' +
            'uisi'#231#227'o de compra. '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblRecCompraLegenda2: TLabel
          Left = 702
          Top = 13
          Width = 555
          Height = 14
          Caption = 
            'Quando a mercadoria chegar e baixar o pedido de compra os vender' +
            'ores ser'#227'o notificados atrav'#233's de mensagem.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblLegendas: TLabel
          Left = 1190
          Top = 0
          Width = 86
          Height = 13
          Caption = 'Mostrar Legendas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblLegendasClick
        end
        object btnAdicionar: TBitBtnLocked
          Left = 284
          Top = 0
          Width = 69
          Height = 24
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
          Left = 353
          Top = 0
          Width = 71
          Height = 24
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
        object btnExcluir: TBitBtnLocked
          Left = 455
          Top = 1
          Width = 63
          Height = 23
          Caption = '&Excluir'
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
          TabOrder = 4
          Visible = False
          OnClick = btnExcluirClick
        end
        object mskDtaEnt: TMaskEditFocus
          Tag = 99
          Left = 224
          Top = 1
          Width = 61
          Height = 22
          CharCase = ecUpperCase
          EditMask = '99/99/9999'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtDiaEnt: TEditFocus
          Tag = 99
          Left = 64
          Top = 1
          Width = 78
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
        object btnCarregaPedidosVenda: TBitBtnLocked
          Left = 520
          Top = 1
          Width = 149
          Height = 23
          Caption = 'Carregar Prod. Vendidos'
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
          TabOrder = 5
          OnClick = btnCarregaPedidosVendaClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 760
    Top = 576
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 576
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 904
    Top = 528
  end
  object dtsItensPedido: TDataSource
    Left = 792
    Top = 576
  end
  object OpenFile: TOpenDialog
    DefaultExt = '.xls'
    Filter = 'Planilhas|*.xls; *xlsx;'
    InitialDir = 'C:\'
    Title = 'Selecione o arquivo'
    Left = 876
    Top = 396
  end
  object dtsItensGiro: TDataSource
    Left = 824
    Top = 576
  end
  object dtsItensMlj: TDataSource
    Left = 856
    Top = 576
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 1104
    Top = 552
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object popMaisInfo: TPopupMenu
    Left = 1009
    Top = 656
    object mnuFormacaodePrecos: TMenuItem
      Caption = 'Forma'#231#227'o de Pre'#231'os'
      ShortCut = 114
      OnClick = mnuFormacaodePrecosClick
    end
    object mnuPedidodeComprasGrid: TMenuItem
      Caption = 'Pedido De Compras(Grid) '
      ShortCut = 122
      OnClick = mnuPedidodeComprasGridClick
    end
    object mnuConsultadePedidodeCompras: TMenuItem
      Caption = 'Consulta de Pedido De Compras'
      ShortCut = 32885
      OnClick = mnuConsultadePedidodeComprasClick
    end
    object ComposicaodeCusto: TMenuItem
      Caption = 'Composi'#231#227'o do Custo        '
      ShortCut = 32887
      OnClick = ComposicaodeCustoClick
    end
    object mnuCompraAntiga: TMenuItem
      Caption = 'Compras do sistema anterior'
      ShortCut = 16451
      OnClick = mnuCompraAntigaClick
    end
    object mnuCadastrodeProdutos: TMenuItem
      Caption = 'Cadastro de Produtos'
      ShortCut = 16464
      OnClick = mnuCadastrodeProdutosClick
    end
    object mnuEntregasFuturasPendentes: TMenuItem
      Caption = 'Entregas Futuras Pendentes'
      ShortCut = 16454
      OnClick = mnuEntregasFuturasPendentesClick
    end
    object mnuPreparaesdeTEdoPedido: TMenuItem
      Caption = 'Prepara'#231#245'es de TE do Pedido'
      ShortCut = 16452
      OnClick = mnuPreparaesdeTEdoPedidoClick
    end
    object Lotesdoitem1: TMenuItem
      Caption = 'Lotes do item'
      ShortCut = 16460
      OnClick = Lotesdoitem1Click
    end
    object Kardex: TMenuItem
      Caption = 'Kardex'
      object mnAbrirKardex: TMenuItem
        Caption = 'Abrir "Kardex"'
        OnClick = mnAbrirKardexClick
      end
      object mnConfiguraKardex: TMenuItem
        Caption = 'Configura o relat'#243'rio chamado pelo bot'#227'o "Kardex"'
        OnClick = mnConfiguraKardexClick
      end
    end
    object mnuRelEmprestimos: TMenuItem
      Caption = 'Empr'#233'stimos'
      OnClick = mnuRelEmprestimosClick
    end
    object mnuVisImg: TMenuItem
      Caption = 'Visualizar Imagens'
      OnClick = mnuVisImgClick
    end
  end
  object tmrAtualizaRodape: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrAtualizaRodapeTimer
    Left = 288
    Top = 544
  end
end
