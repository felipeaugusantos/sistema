inherited frmBaixaReceber: TfrmBaixaReceber
  Width = 1267
  Height = 661
  Caption = 'Baixa de Contas a Receber'
  Position = poMainFormCenter
  ShowHint = True
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitWidth = 1267
  ExplicitHeight = 661
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 346
    Width = 1261
    TabOrder = 9
    ExplicitTop = 346
    ExplicitWidth = 1261
    DesignSize = (
      1261
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1257
      ExplicitWidth = 1257
    end
  end
  inherited pnlStatus: TPanel
    Top = 616
    Width = 1261
    TabOrder = 8
    ExplicitTop = 616
    ExplicitWidth = 1261
    inherited pnlNomeForm: TPanel
      Left = 1090
      ExplicitLeft = 1090
    end
    inherited pnlInfo: TPanel
      Width = 1090
      ExplicitWidth = 1090
      object shpMultSel: TShape
        Left = 1
        Top = 2
        Width = 17
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 244
    Width = 1261
    Height = 102
    ActivePage = nil
    TabOrder = 7
    TabStop = False
    ExplicitTop = 244
    ExplicitWidth = 1261
    ExplicitHeight = 102
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 1253
      ExplicitHeight = 92
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1261
    Height = 146
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 81
      Top = 12
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label20: TLabel
      Left = 71
      Top = 82
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label15: TLabel
      Left = 44
      Top = 36
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rede de Lojas:'
    end
    object Label8: TLabel
      Left = 66
      Top = 106
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblHistorico: TLabel
      Left = 71
      Top = 129
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 119
      Top = 9
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 192
      Top = 9
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomEmp: TEditFocus
      Left = 192
      Top = 78
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 119
      Top = 78
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 5
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
    object chkLimFil: TCheckBox
      Left = 509
      Top = 9
      Width = 164
      Height = 17
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 119
      Top = 32
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 2
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesRed: TEditFocus
      Left = 192
      Top = 32
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 25
      Top = 55
      Width = 551
      Height = 22
      TabOrder = 4
      ExplicitLeft = 25
      ExplicitTop = 55
      inherited lblEventos: TLabel
        Width = 87
        Height = 14
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 72
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 167
        Width = 313
        Height = 22
        Enabled = True
        ExplicitLeft = 167
        ExplicitWidth = 313
        ExplicitHeight = 22
      end
    end
    object edtCodven: TEditFocus
      Tag = 99
      Left = 119
      Top = 101
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      OnExit = edtCodvenExit
      OnKeyPress = edtCodvenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 192
      Top = 101
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object chkFiltrarFiliais: TCheckBox
      Left = 509
      Top = 32
      Width = 160
      Height = 17
      Caption = 'Filtrar duplicatas das filiais?'
      Enabled = False
      TabOrder = 3
      OnExit = chkFiltrarFiliaisExit
    end
    object edtHistorico: TEditFocus
      Tag = 99
      Left = 119
      Top = 124
      Width = 386
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 567
    Width = 1261
    Height = 49
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 6
    DesignSize = (
      1261
      49)
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 1257
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
    end
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 4
      Width = 1257
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'FlwPnlBotoesBaixa'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        1257
        43)
      object btnInformacaoCobranca: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F4 ] Inf. Cobran'#231'a'
        TabOrder = 0
        OnClick = btnInformacaoCobrancaClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 1
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 2
        OnClick = btnLocProxClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 375
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F7 ] Marcar todas'
        TabOrder = 3
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 500
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F8 ] Desmarcar todas'
        TabOrder = 4
        OnClick = btnDesmarcarTodasClick
      end
      object BtnSelecionadas: TBitBtnLocked
        Left = 625
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F9 ] Selecionadas'
        TabOrder = 5
        OnClick = BtnSelecionadasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 750
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 6
        OnClick = btnConfirmaClick
      end
      object btnImprimirRecibo: TBitBtnLocked
        Left = 875
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F10 ] Imprimir Recibo'
        TabOrder = 7
        TabStop = False
        Visible = False
        OnClick = btnImprimirReciboClick
      end
      object btnRecalculaJuros: TBitBtnLocked
        Left = 1000
        Top = 0
        Width = 125
        Height = 21
        Caption = '[ F11 ] Recalcula Juros'
        TabOrder = 8
        OnClick = btnRecalculaJurosClick
      end
      object btnAdiantamento: TBitBtnLocked
        Left = 1125
        Top = 0
        Width = 125
        Height = 21
        Caption = '[Ctrl+A] Adiantamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = btnAdiantamentoClick
      end
      object btnProdutos: TBitBtnLocked
        Left = 0
        Top = 21
        Width = 125
        Height = 21
        Caption = '[Ctrl+P] Produtos'
        TabOrder = 10
        OnClick = btnProdutosClick
      end
      object btnManutencao: TBitBtnLocked
        Left = 125
        Top = 21
        Width = 125
        Height = 21
        Caption = '[F12] C. Receber'
        TabOrder = 11
        OnClick = btnManutencaoClick
      end
      object btnDescontoGeral: TBitBtnLocked
        Left = 250
        Top = 21
        Width = 134
        Height = 21
        Caption = '[Alt+F12] Desconto Geral'
        TabOrder = 12
        OnClick = btnDescontoGeralClick
      end
      object btnDuplicataAgrupada: TBitBtnLocked
        Left = 384
        Top = 21
        Width = 162
        Height = 21
        Caption = '[Ctrl+D] Duplicatas Agrupadas'
        TabOrder = 13
        OnClick = btnDuplicataAgrupadaClick
      end
      object btnVisualizaDocumentoCompleto: TBitBtnLocked
        Left = 546
        Top = 21
        Width = 204
        Height = 21
        Caption = '[Ctrl+L] Visualizar Documento Completo'
        TabOrder = 14
        OnClick = btnVisualizaDocumentoCompletoClick
      end
      object btnEmailPix: TBitBtnLocked
        Left = 750
        Top = 21
        Width = 125
        Height = 21
        Caption = '[ Ctrl+E ] E-mail Pix'
        TabOrder = 15
        OnClick = btnEmailPixClick
      end
      object btnConfigurarGrid: TBitBtnLocked
        Left = 875
        Top = 21
        Width = 125
        Height = 21
        Anchors = [akRight, akBottom]
        Caption = 'Configurar'
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
        TabOrder = 16
        OnClick = btnConfigurarGridClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 1002
      Top = 25
      Width = 125
      Height = 21
      Anchors = [akLeft, akBottom]
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairBaixaClick
    end
  end
  object pnlTotais: TPanel [5]
    Left = 0
    Top = 392
    Width = 1261
    Height = 175
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object Label7: TLabel
      Left = 399
      Top = 28
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label10: TLabel
      Left = 391
      Top = 52
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Port:'
    end
    object Label12: TLabel
      Left = 389
      Top = 122
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso Nro:'
    end
    object Label11: TLabel
      Left = 387
      Top = 76
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ctr. Custos:'
    end
    object Label13: TLabel
      Left = 390
      Top = 99
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'M'#233'd.Pond.:'
    end
    object lblDespCob: TLabel
      Left = 390
      Top = 146
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Cob:'
      Visible = False
    end
    object lbl4: TLabel
      Left = 2
      Top = 2
      Width = 1257
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'INFORMA'#199#213'ES DA(S) DUPLICATA(S)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 189
    end
    object Label18: TLabel
      Left = 574
      Top = 123
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'COO:'
    end
    object edtCodPorBai: TEditFocus
      Left = 444
      Top = 24
      Width = 239
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
    object edtNomPorBai: TEditFocus
      Left = 444
      Top = 48
      Width = 239
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNosNumBai: TEditFocus
      Left = 444
      Top = 118
      Width = 124
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEveBai: TEditFocus
      Left = 444
      Top = 72
      Width = 239
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMedPond: TEditFocus
      Left = 444
      Top = 95
      Width = 203
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 5
      OnMouseLeave = edtMedPondMouseLeave
      OnMouseMove = edtMedPondMouseMove
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlInformativos: TPanel
      Left = 1114
      Top = 16
      Width = 145
      Height = 157
      Align = alRight
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 6
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 141
        Height = 12
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'INFORMATIVO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 32
        Top = 54
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Juros:'
      end
      object Label19: TLabel
        Left = 13
        Top = 77
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto:'
      end
      object edtJurosTotal: TEditFocus
        Left = 66
        Top = 50
        Width = 60
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtDescontoTotal: TEditFocus
        Left = 66
        Top = 73
        Width = 60
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
    object edtDespCob: TEditFocus
      Left = 444
      Top = 143
      Width = 239
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumCooRod: TEditFocus
      Left = 603
      Top = 118
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object btnMedPond: TBitBtnLocked
      Left = 650
      Top = 95
      Width = 34
      Height = 22
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000060000
        00090000000600000003000000070000000A0000000700000004000000070000
        000A0000000700000004000000080000000B00000008000000021E4982BD2664
        B2FF1B467FBE0000000D10593FBE167956FF0E573DBE0000000E7F5529BFB276
        39FF7F5328BF0000000F1A268ABF2435BFFF192589BF000000083170BCFF66BF
        FAFF2B69B7FF000000121B815BFF4AB994FF1A7E59FF00000013B47B3EFFEAA8
        67FFB4783DFF000000152A3AC2FF455EE8FF2939C0FF0000000B397AC3FF75C6
        FDFF3473BEFF00000011208662FF55C19EFF1F835FFF00000013B67E43FFEBAC
        6DFFB67E42FF000000142E3FC5FF5067EBFF2D3DC4FF0000000B4384C9FF85CF
        FFFF3E7EC5FF00000010288E6AFF62C9A9FF278C68FF00000012B98249FFEEB1
        74FFB88248FF000000133345C9FF5B73EFFF3243C8FF0000000B4B8AD0FFAEE0
        FFFF4786CBFF0000000F2F9572FF71D3B4FF2E926FFF00000011BC884FFFF0B6
        7BFFBB864DFF000000123B4CCDFF687FF2FF3949CBFF0000000A3C6B9CC1508F
        D2FF3A699BC10000000B369C79FF7FDABEFF349977FF0000000FC18C54FFF2BC
        85FFBF8A53FF000000114153CFFF758CF6FF3F50CEFF00000009000000040000
        000500000004000000073DA17FFF8CE0C7FF3C9F7DFF0000000EC3915BFFF5C1
        8DFFC28F58FF00000010465AD3FF8197F8FF4558D1FF00000009000000000000
        0000000000000000000642A684FFAFECDBFF40A482FF0000000DC79562FFF7C7
        93FFC69460FF0000000F4B5FD4FF8CA0FBFF4A5DD4FF00000008000000000000
        00000000000000000004337E65C145A988FF337D64C10000000ACA9B67FFF8CD
        9BFFC99965FF0000000D4F62D6FFADBCFDFF4D60D5FF00000007000000000000
        0000000000000000000100000003000000050000000300000006CDA06DFFF9D0
        A3FFCC9D6AFF0000000A3B4BA0C15065D7FF3B4AA0C100000005000000000000
        0000000000000000000000000000000000000000000000000005CFA372FFFBD5
        A9FFCEA270FF0000000700000004000000050000000400000001000000000000
        0000000000000000000000000000000000000000000000000005D2A878FFFCD8
        AEFFD1A776FF0000000500000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000004D4AB7BFFFDE4
        C5FFD3AA79FF0000000400000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000029D805EBFD5AD
        7EFF9E7F5DC00000000300000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000001000000020000
        0003000000020000000100000000000000000000000000000000}
      TabOrder = 0
      OnClick = btnMedPondClick
      OnMouseEnter = btnMedPondMouseEnter
      OnMouseLeave = btnMedPondMouseLeave
    end
    object pnlLegendas: TPanel
      Left = 988
      Top = 16
      Width = 126
      Height = 157
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 9
      DesignSize = (
        126
        157)
      object grpLegenda: TGroupBox
        Left = 0
        Top = 90
        Width = 123
        Height = 65
        Anchors = [akRight, akBottom]
        Caption = 'Legenda'
        TabOrder = 0
        object Shape1: TShape
          Left = 8
          Top = 16
          Width = 14
          Height = 14
        end
        object Label22: TLabel
          Left = 27
          Top = 16
          Width = 48
          Height = 14
          Caption = 'Marcados'
        end
        object Shape2: TShape
          Left = 8
          Top = 32
          Width = 14
          Height = 14
        end
        object Label24: TLabel
          Left = 27
          Top = 32
          Width = 67
          Height = 14
          Caption = 'Desmarcados'
        end
        object Label27: TLabel
          Left = 11
          Top = 16
          Width = 8
          Height = 14
          Caption = 'A'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label28: TLabel
          Left = 11
          Top = 32
          Width = 8
          Height = 14
          Caption = 'A'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Shape3: TShape
          Left = 8
          Top = 48
          Width = 14
          Height = 14
        end
        object Label29: TLabel
          Left = 27
          Top = 48
          Width = 75
          Height = 14
          Caption = 'Com Pix gerado'
        end
        object Label30: TLabel
          Left = 11
          Top = 48
          Width = 8
          Height = 14
          Caption = 'A'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
    end
    object pnlhistorico: TPanel
      Left = 689
      Top = 29
      Width = 293
      Height = 71
      BevelOuter = bvNone
      TabOrder = 10
      object Label14: TLabel
        Left = 3
        Top = 3
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object spbAmpliar: TSpeedButton
        Left = 264
        Top = 19
        Width = 23
        Height = 22
        Hint = 'Ampliar imagem'
        Flat = True
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
        ParentShowHint = False
        ShowHint = True
        OnClick = spbAmpliarClick
      end
      object edtHistor: TMemoFocus
        Left = 3
        Top = 19
        Width = 258
        Height = 46
        TabStop = False
        Color = 16768952
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object gpbGeral: TGroupBox
      Left = 4
      Top = 4
      Width = 369
      Height = 41
      Caption = ' Geral '
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 11
      object Label6: TLabel
        Left = 15
        Top = 16
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Tot. Duplicatas:'
      end
      object Label21: TLabel
        Left = 199
        Top = 17
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Duplicatas:'
      end
      object edtQtdDuplicatas: TEditFocus
        Left = 112
        Top = 13
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValorTotal: TEditFocus
        Left = 279
        Top = 13
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
    object gpbSelecionadas: TGroupBox
      Left = 4
      Top = 48
      Width = 369
      Height = 43
      Caption = ' Selecionadas '
      TabOrder = 12
      object Label9: TLabel
        Left = 6
        Top = 20
        Width = 106
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Dup. Recebendo:'
      end
      object Label23: TLabel
        Left = 200
        Top = 21
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr. Recebendo:'
      end
      object edtQtdSelecionadas: TEditFocus
        Left = 112
        Top = 16
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtTotalRecebido: TEditFocus
        Left = 279
        Top = 16
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
    object gpbFiltradas: TGroupBox
      Left = 4
      Top = 91
      Width = 368
      Height = 69
      Caption = ' Filtradas '
      TabOrder = 13
      object Label33: TLabel
        Left = 38
        Top = 24
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Dup. Filtro:'
      end
      object Label31: TLabel
        Left = 35
        Top = 45
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Vlr. Original:'
      end
      object Label32: TLabel
        Left = 213
        Top = 45
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Vlr. Corr.:'
      end
      object edtQtdDulSel: TEditFocus
        Left = 113
        Top = 16
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtTotVlrOrg: TEditFocus
        Left = 113
        Top = 41
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtTotVlrCorr: TEditFocus
        Left = 280
        Top = 41
        Width = 83
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
    end
  end
  object dbgDuplicatas: TcxGrid [6]
    Left = 0
    Top = 244
    Width = 1261
    Height = 102
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgDuplicatasDBTableView1: TcxGridDBTableView
      OnKeyDown = dbgDuplicatasDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgDuplicatasDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'CTR_VALSUJ'
          Column = dbgDuplicatasCTR_VALSUJ
          VisibleForCustomization = False
        end
        item
          Kind = skSum
          FieldName = 'CTR_VALCAL'
          Column = dbgDuplicatasCTR_VALCAL
        end>
      DataController.Summary.SummaryGroups = <>
      DataController.Summary.OnAfterSummary = dbgDuplicatasDBTableView1DataControllerSummaryAfterSummary
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      object dbgDuplicatasCTR_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTR_NUMDUP'
        Width = 144
      end
      object dbgDuplicatasCTR_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'CTR_ESPDOC'
        Width = 58
      end
      object dbgDuplicatasCTR_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cli.'
        DataBinding.FieldName = 'CTR_CODCLI'
        Width = 62
      end
      object dbgDuplicatasCTR_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CTR_NOMCLI'
        Width = 236
      end
      object dbgDuplicatasCTR_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CTR_CODEMP'
        Width = 30
      end
      object dbgDuplicatasCTR_DTACAD: TcxGridDBColumn
        Caption = 'Dt. Cadastro'
        DataBinding.FieldName = 'CTR_DTACAD'
        Width = 80
      end
      object dbgDuplicatasCTR_DTAVEN: TcxGridDBColumn
        Caption = 'Dt. Vencimento'
        DataBinding.FieldName = 'CTR_DTAVEN'
        Width = 80
      end
      object dbgDuplicatasCTR_VALSUJ: TcxGridDBColumn
        Caption = 'Vlr. Original'
        DataBinding.FieldName = 'CTR_VALDUP'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object dbgDuplicatasCTR_VALCAL: TcxGridDBColumn
        Caption = 'Vlr. Corrigido'
        DataBinding.FieldName = 'CTR_VALCAL'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object dbgDuplicatasCTR_MARDES: TcxGridDBColumn
        DataBinding.FieldName = 'CTR_MARDES'
        Visible = False
        Width = 20
      end
      object dbgDuplicatasCTR_VALJUR: TcxGridDBColumn
        DataBinding.FieldName = 'CTR_VALJUR'
        Visible = False
        Width = 20
      end
      object dbgDuplicatasCLI_C_G_C_: TcxGridDBColumn
        Caption = 'CNPJ/CPF'
        DataBinding.FieldName = 'CLI_C_G_C_'
        HeaderAlignmentHorz = taRightJustify
        Width = 106
      end
      object dbgDuplicatasCTR_TX_PIX: TcxGridDBColumn
        DataBinding.FieldName = 'CTR_TX_PIX'
        Visible = False
        VisibleForCustomization = False
      end
      object dbgDuplicatasDIASATRASO: TcxGridDBColumn
        Caption = 'Dias em atraso'
        DataBinding.FieldName = 'DIASATRASO'
        Width = 80
      end
    end
    object dbgDuplicatasLevel1: TcxGridLevel
      GridView = dbgDuplicatasDBTableView1
    end
  end
  object pnlEnvBan: TPanel [7]
    Left = 0
    Top = 346
    Width = 1261
    Height = 46
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object lbl1: TLabel
      Left = 2
      Top = 2
      Width = 1257
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'CONTROLE DE REMESSA BANC'#193'RIA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 187
    end
    object lbl2: TLabel
      Left = 44
      Top = 22
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Envio:'
    end
    object lbl3: TLabel
      Left = 220
      Top = 22
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Banco:'
    end
    object edtNomBan: TEditFocus
      Left = 340
      Top = 18
      Width = 302
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object btnLimparDadosRemessa: TBitBtnLocked
      Left = 648
      Top = 18
      Width = 143
      Height = 22
      Caption = '[F2] Cancelar Remessa'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF0955A10857A60557AA0655A70954A00954A0FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0872DD0362C3006CDB0877E711
        7DEA0877E70069DD005DC70654A50654A5FF00FFFF00FFFF00FFFF00FFFF00FF
        0F6BC90872DD3E99F591C4F9D6E9FDEEF7FFE4F1FFB0D4FB59A5F50570E5035A
        B70B5095FF00FFFF00FFFF00FF1278E0127CE870B4F9F6FAFEFFFFFFEEF6FDD3
        E6FBE2EEFDFFFFFFFFFFFFAED2FA0E78ED025AB60653A2FF00FFFF00FF1278E0
        6DB2F9FEFEFFE9F3FD1E7FF00D73ED1474EB066BE90C6FE889B9F4E6F0FDB0D5
        FA0970E60653A2FF00FF0B70D53695F4E8F3FEFFFFFF89BAF48FC0F92A86F110
        75EE1275EC1E79EC84B5F489BAF4FFFFFF58A5F5005EC70858AB137AE371B5FB
        FFFFFFB2D7FC278CF992C4FBDAEAFD318BF3388DF2D7E8FC87B8F50D71EAE6F0
        FDB3D7FB016BDE0858AB1F85ECA2CFFDFFFFFF419EFD3495FB298DF992C5FBE6
        F1FEE5F1FD88BCF71075EE0B70EBB4D2F8E6F3FF0E7BE9065AB02F8FF1B7DAFD
        FFFFFF419FFF3196FE3094FC469EFCF1F8FEF1F8FE3892F5187DF11378EF9FC9
        F7F0F8FF1A82EC055CB53693F0B8DAFEFFFFFF59ACFF3499FF55A9FEE8F3FF85
        BFFD83BDFCE7F2FE4498F61A7FF2D3E6FCD9EBFE117DE9095CB22689EDAFD6FD
        FFFFFFC3E1FF4AA4FFEDF6FF81C0FF3296FE2E93FC7BBAFDEBF5FE59A5F8E9F3
        FE99C9FA0773E10958ABFF00FF3994F0F1F8FFFBFDFF78BBFF61AFFF3499FF34
        99FF3398FF3095FD68B0FCF4FAFFF5FAFE49A0F7076ACEFF00FFFF00FF3994F0
        CDE6FFF6FAFFFBFDFFC1DFFF58ABFF43A0FF49A3FF84C1FEFBFDFFFFFFFF78B9
        F9137BE6076ACEFF00FFFF00FFFF00FF64ACF6D4EAFFF9FCFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFE7F3FE77B8FA1D85ED0D6DD0FF00FFFF00FFFF00FFFF00FF
        FF00FF459AF0A7D2FCD8ECFFE2F1FFE4F1FED1E7FE9DCDFD4DA2F7177FE8177F
        E8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3B94F061ABF665
        ADF7489EF42286EC127AE4FF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnLimparDadosRemessaClick
    end
    object edtDtaEnv: TEditFocus
      Tag = 99
      Left = 101
      Top = 18
      Width = 83
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBcoBol: TEditFocus
      Tag = 99
      Left = 260
      Top = 18
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object pnlCabecalho2: TPanel [8]
    Left = 0
    Top = 169
    Width = 1261
    Height = 75
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object Label2: TLabel
      Left = 15
      Top = 30
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo  Vencimento:'
    end
    object Label3: TLabel
      Left = 211
      Top = 32
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object Label4: TLabel
      Left = 331
      Top = 57
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso N'#250'mero:'
    end
    object Label5: TLabel
      Left = 72
      Top = 5
      Width = 44
      Height = 14
      Caption = 'Portador:'
    end
    object lblNumCoo: TLabel
      Left = 532
      Top = 57
      Width = 26
      Height = 14
      Caption = 'COO:'
    end
    object lblRomaneio: TLabel
      Left = 508
      Top = 5
      Width = 50
      Height = 14
      Caption = 'Romaneio:'
    end
    object Label26: TLabel
      Left = 26
      Top = 51
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo  Cadastro:'
    end
    object Label25: TLabel
      Left = 211
      Top = 57
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object edtNumCoo: TEditFocus
      Tag = 99
      Left = 559
      Top = 51
      Width = 77
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 9
      TipoTexto = ttInteiro
    end
    object edtNosNum: TEditFocus
      Tag = 99
      Left = 409
      Top = 51
      Width = 96
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortador: TEditFocus
      Left = 192
      Top = 1
      Width = 313
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
    object edtCodPortador: TEditFocus
      Tag = 99
      Left = 119
      Top = 1
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodPortadorExit
      OnKeyPress = edtCodPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 119
      Top = 24
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 3
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 220
      Top = 24
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      Width = 90
    end
    object btnCarrTitulos: TBitBtnLocked
      Left = 637
      Top = 51
      Width = 121
      Height = 22
      Align = alCustom
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 9
      OnClick = btnCarrTitulosClick
    end
    object edtRomaneio: TEditFocus
      Tag = 99
      Left = 559
      Top = 1
      Width = 77
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 2
      OnKeyPress = edtRomaneioKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object mskDtaCadIni: TcxDateEdit
      Tag = 99
      Left = 119
      Top = 49
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 5
      Width = 90
    end
    object mskDtaCadFin: TcxDateEdit
      Tag = 99
      Left = 220
      Top = 49
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 6
      Width = 90
    end
  end
  object pnlProjeto: TPanel [9]
    Left = 0
    Top = 146
    Width = 1261
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblProjeto: TLabel
      Left = 28
      Top = 6
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Projeto: '
    end
    object edtDesPrj: TEditFocus
      Left = 192
      Top = 1
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodPrj: TEditFocus
      Tag = 99
      Left = 119
      Top = 1
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodPrjExit
      OnKeyPress = edtCodPrjKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
    Top = 24
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
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
    Left = 536
    Top = 288
  end
end
