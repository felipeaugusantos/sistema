inherited frmFatExpedicao: TfrmFatExpedicao
  Left = 161
  Top = 210
  Width = 1600
  Height = 815
  Caption = 'Expedi'#231#227'o'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitLeft = -431
  ExplicitWidth = 1600
  ExplicitHeight = 815
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 678
    Width = 1594
    Height = 92
    BevelOuter = bvRaised
    Color = 16770261
    ExplicitTop = 678
    ExplicitWidth = 1594
    ExplicitHeight = 92
    object Panel3: TPanel [0]
      Left = 2
      Top = 2
      Width = 1590
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1590
      Height = 88
      Align = alBottom
      TabOrder = 1
      ExplicitWidth = 1590
      ExplicitHeight = 88
      object btnBuscar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 66
        Height = 22
        Caption = '[F3] Buscar'
        TabOrder = 0
        OnClick = btnBuscarClick
      end
      object btnLimparBusca: TBitBtnLocked
        Left = 66
        Top = 0
        Width = 95
        Height = 22
        Caption = '[F4] Limpar Busca'
        TabOrder = 1
        OnClick = btnLimparBuscaClick
      end
      object btnConsProduto: TBitBtnLocked
        Left = 161
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F5] Consulta Produtos'
        TabOrder = 2
        OnClick = btnConsProdutoClick
      end
      object btnImpSep: TBitBtnLocked
        Left = 278
        Top = 0
        Width = 132
        Height = 22
        Caption = '[F6] Imprimir Separa'#231#227'o'
        TabOrder = 3
        OnClick = btnImpSepClick
      end
      object btnMensagemExpedicao: TBitBtnLocked
        Left = 410
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ALT+F6] Editar Msg Exp.'
        TabOrder = 4
        OnClick = btnMensagemExpedicaoClick
      end
      object btnRecarrPed: TBitBtnLocked
        Left = 542
        Top = 0
        Width = 132
        Height = 22
        Caption = '[F7] Atualizar Documentos'
        TabOrder = 5
        OnClick = btnRecarrPedClick
      end
      object btnConfirmaCupons: TBitBtnLocked
        Left = 674
        Top = 0
        Width = 123
        Height = 22
        Caption = '[F8] Confirmar Cupons'
        TabOrder = 6
        OnClick = btnConfirmaCuponsClick
      end
      object btnCliObs: TBitBtnLocked
        Left = 797
        Top = 0
        Width = 106
        Height = 22
        Caption = '[Alt+F8] Obs. Cliente'
        TabOrder = 7
        OnClick = btnCliObsClick
      end
      object btnOpeDes: TBitBtnLocked
        Left = 903
        Top = 0
        Width = 109
        Height = 22
        Caption = '[F2] Oper. Designado'
        TabOrder = 8
        OnClick = btnOpeDesClick
      end
      object btnLegenda: TBitBtnLocked
        Left = 1012
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ALT+F1] Legenda'
        TabOrder = 9
        OnClick = btnLegendaClick
      end
      object btnSeparacao: TBitBtnLocked
        Left = 1112
        Top = 0
        Width = 46
        Height = 22
        Caption = 'Sep'
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
          000000000000000000000000000000000000000000000000000000000000001E
          1E1E1E1E1E000000000000000000000000000000000000000000000000000000
          0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
          000000000000000000000000000000000000000000000000000000001E1E1E3C
          3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000000000
          0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
          000000000000000000000000000000000000000000000000001E1E1E3C3C3C3C
          3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000
          0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
          000000000000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000
          0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
          1E0000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000
          1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C1E1E1E0000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        NumGlyphs = 2
        TabOrder = 10
        Visible = False
        OnClick = btnSeparacaoClick
      end
      object btnExpedicao: TBitBtnLocked
        Left = 1158
        Top = 0
        Width = 46
        Height = 22
        Caption = 'Exp'
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
          000000000000000000000000000000000000000000000000000000000000001E
          1E1E1E1E1E000000000000000000000000000000000000000000000000000000
          0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
          000000000000000000000000000000000000000000000000000000001E1E1E3C
          3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000000000
          0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
          000000000000000000000000000000000000000000000000001E1E1E3C3C3C3C
          3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000
          0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
          000000000000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000
          0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
          1E0000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000
          1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C1E1E1E0000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        NumGlyphs = 2
        TabOrder = 11
        Visible = False
        OnClick = btnExpedicaoClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 1204
        Top = 0
        Width = 103
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 12
        OnClick = btnConfirmaClick
      end
      object btnFaturarExpedidos: TBitBtnLocked
        Left = 1307
        Top = 0
        Width = 123
        Height = 22
        Caption = '[F11] Faturar Expedidos'
        TabOrder = 13
        OnClick = btnFaturarExpedidosClick
      end
      object btnFaturarOndaSeparacao: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 182
        Height = 22
        Caption = '[Alt+F10] Faturar Onda Separa'#231#227'o'
        TabOrder = 14
        OnClick = btnFaturarOndaSeparacaoClick
      end
      object btnExpFatAutTodos: TBitBtnLocked
        Left = 182
        Top = 22
        Width = 130
        Height = 22
        Caption = '[Ctrl+F10] Faturar Todos'
        TabOrder = 15
        OnClick = btnExpFatAutTodosClick
      end
      object btnDesmExpedidos: TBitBtnLocked
        Left = 312
        Top = 22
        Width = 145
        Height = 22
        Caption = '[F1] Desmembrar Expedidos'
        TabOrder = 16
        OnClick = btnDesmExpedidosClick
      end
      object btnCortarProdutosPedido: TBitBtnLocked
        Left = 457
        Top = 22
        Width = 137
        Height = 22
        Caption = 'Cortar Produtos do Pedido'
        TabOrder = 17
        OnClick = btnCortarProdutosPedidoClick
      end
      object btnFeriados: TBitBtnLocked
        Left = 594
        Top = 22
        Width = 131
        Height = 22
        Caption = '[F12] Feriados Municipal'
        TabOrder = 18
        OnClick = btnFeriadosClick
      end
      object btnBuscaNFe_Estoque: TBitBtnLocked
        Left = 725
        Top = 22
        Width = 193
        Height = 22
        Caption = '[F9] Buscar NFe / Buscar Estoque'
        TabOrder = 19
        OnClick = btnBuscaNFe_EstoqueClick
      end
      object btnConPedPen: TBitBtnLocked
        Left = 918
        Top = 22
        Width = 138
        Height = 22
        Caption = '[ALT+F12] Ped. Pendentes'
        TabOrder = 20
        Visible = False
        OnClick = btnConPedPenClick
      end
      object btnEntFutCD: TBitBtnLocked
        Left = 1056
        Top = 22
        Width = 131
        Height = 22
        Caption = '[Ctrl+E] Ent.Fut.pelo CD'
        TabOrder = 21
        OnClick = btnEntFutCDClick
      end
      object btnCfgExp: TBitBtnLocked
        Left = 1187
        Top = 22
        Width = 89
        Height = 22
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
        TabOrder = 22
        OnClick = btnCfgExpClick
      end
      object btnAltEmpFat: TBitBtnLocked
        Left = 1276
        Top = 22
        Width = 133
        Height = 22
        Caption = '[Ctrl+F2] Alterar Emp. Fat.'
        TabOrder = 23
        Visible = False
        OnClick = btnAltEmpFatClick
      end
      object btnRevEmpFat: TBitBtnLocked
        Left = 1409
        Top = 22
        Width = 148
        Height = 22
        Caption = '[Ctrl+F3] Reverter Emp. Fat.'
        TabOrder = 24
        Visible = False
        OnClick = btnRevEmpFatClick
      end
      object btnSituacaoItens: TBitBtnLocked
        Left = 0
        Top = 44
        Width = 144
        Height = 22
        Caption = '[Ctrl+F4] Situa'#231#227'o dos itens'
        TabOrder = 25
        OnClick = btnSituacaoItensClick
      end
      object btnDefinirSeparadorConferente: TBitBtnLocked
        Left = 144
        Top = 44
        Width = 236
        Height = 22
        Caption = 'Definir separador e conferente para o coletor'
        TabOrder = 26
        OnClick = btnDefinirSeparadorConferenteClick
      end
      object btnAlterarDataEntrega: TBitBtnLocked
        Left = 380
        Top = 44
        Width = 133
        Height = 22
        Caption = 'Alterar data de entrega'
        TabOrder = 27
        OnClick = btnAlterarDataEntregaClick
      end
      object btnMulSep: TBitBtnLocked
        Left = 513
        Top = 44
        Width = 272
        Height = 22
        Caption = '[Ctrl+F5] Separa'#231#227'o por Lote de Pedidos - Romaneio'
        TabOrder = 28
        OnClick = btnMulSepClick
      end
      object btnExibirProdutos: TBitBtnLocked
        Left = 785
        Top = 44
        Width = 121
        Height = 22
        Caption = '[Alt+F5] Exibir Produtos'
        TabOrder = 29
        OnClick = btnExibirProdutosClick
      end
      object btnFrete: TBitBtnLocked
        Left = 906
        Top = 44
        Width = 76
        Height = 22
        Caption = '[Alt+F7] Frete'
        TabOrder = 30
        OnClick = btnFreteClick
      end
      object btnBaixarPedidoNaoEntregue: TBitBtnLocked
        Left = 982
        Top = 44
        Width = 192
        Height = 22
        Caption = 'Baixar Pedido que n'#227'o ser'#225' entregue'
        TabOrder = 31
        OnClick = btnBaixarPedidoNaoEntregueClick
      end
      object btnRobSep: TBitBtnLocked
        Left = 1174
        Top = 44
        Width = 170
        Height = 22
        Caption = 'Suspender Rob'#244' de Separa'#231#227'o'
        TabOrder = 32
        OnClick = btnRobSepClick
      end
      object btnImpOrdemProducao: TBitBtnLocked
        Left = 1344
        Top = 44
        Width = 114
        Height = 22
        Caption = '[Alt+F9] Imprimir O.P.'
        TabOrder = 33
        OnClick = btnImpOrdemProducaoClick
      end
      object btnDesmembrarPed: TBitBtnLocked
        Left = 1458
        Top = 44
        Width = 120
        Height = 22
        Caption = 'Desmembrar Pedido'
        TabOrder = 34
        OnClick = btnDesmembrarPedClick
      end
      object btnAltSitPed: TBitBtnLocked
        Left = 0
        Top = 66
        Width = 144
        Height = 22
        Caption = 'Alterar Situa'#231#227'o do Pedido'
        TabOrder = 35
        OnClick = btnAltSitPedClick
      end
      object btnAltLotImpSep: TBitBtnLocked
        Left = 144
        Top = 66
        Width = 289
        Height = 22
        Caption = '[Ctrl+F6] Alterar Lote Definido na Impress'#227'o de Separa'#231#227'o'
        TabOrder = 36
        OnClick = btnAltLotImpSepClick
      end
      object btnConsultaPed: TBitBtnLocked
        Left = 433
        Top = 66
        Width = 149
        Height = 22
        Caption = '[Ctrl+F7] Consultar Pedido'
        TabOrder = 37
        OnClick = btnConsultaPedClick
      end
      object btnReimprimeDocumento: TBitBtnLocked
        Left = 582
        Top = 66
        Width = 113
        Height = 22
        Caption = 'Imprime Documentos'
        TabOrder = 38
        OnClick = btnReimprimeDocumentoClick
      end
      object btnFechar: TBitBtnLocked
        AlignWithMargins = True
        Left = 695
        Top = 66
        Width = 59
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Sair'
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
        TabOrder = 39
        OnClick = btnSairClick
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 1532
      Top = 42
      Width = 59
      Height = 7
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alRight
      TabOrder = 2
      Visible = False
      ExplicitLeft = 1532
      ExplicitTop = 42
      ExplicitWidth = 59
      ExplicitHeight = 7
    end
  end
  inherited pnlStatus: TPanel
    Top = 770
    Width = 1594
    ExplicitTop = 770
    ExplicitWidth = 1594
    inherited pnlNomeForm: TPanel
      Left = 1423
      ExplicitLeft = 1423
    end
    inherited pnlInfo: TPanel
      Left = 171
      Width = 1252
      ExplicitLeft = 171
      ExplicitWidth = 1252
    end
    inherited pnlBotoesTrace: TPanel
      Left = 171
      ExplicitLeft = 171
    end
    object pnlOperador: TPanel
      Left = 0
      Top = 0
      Width = 171
      Height = 16
      Align = alLeft
      BevelInner = bvLowered
      ParentBackground = False
      PopupMenu = mnuAuxiliar
      TabOrder = 3
    end
  end
  object pgcExpedicao: TPageControl [2]
    Left = 0
    Top = 317
    Width = 1594
    Height = 361
    ActivePage = tbsDados
    Align = alBottom
    MultiLine = True
    Style = tsButtons
    TabOrder = 2
    OnChange = pgcExpedicaoChange
    object tbsDados: TTabSheet
      Caption = 'Dados do documento'
      object pnlDadosAdc: TPanel
        Left = 0
        Top = 24
        Width = 1586
        Height = 305
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object pnlMenExp: TPanel
          Left = 1
          Top = 242
          Width = 1584
          Height = 62
          Align = alBottom
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object pnlMenExp2: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 508
            Height = 54
            Align = alLeft
            Alignment = taLeftJustify
            BevelOuter = bvNone
            TabOrder = 0
            object dbtxtMENEXP: TDBText
              AlignWithMargins = True
              Left = 78
              Top = 3
              Width = 99
              Height = 17
              AutoSize = True
              DataField = 'MENEXP'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object dbtxtMENEXP2: TDBText
              AlignWithMargins = True
              Left = 78
              Top = 16
              Width = 108
              Height = 17
              AutoSize = True
              DataField = 'MENEX2'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object dbtxtMENEXP3: TDBText
              AlignWithMargins = True
              Left = 78
              Top = 29
              Width = 108
              Height = 17
              AutoSize = True
              DataField = 'MENEX3'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object dbtxtMENEXP4: TDBText
              AlignWithMargins = True
              Left = 78
              Top = 42
              Width = 108
              Height = 17
              AutoSize = True
              DataField = 'MENEX4'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl5: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 2
              Width = 72
              Height = 17
              Alignment = taRightJustify
              Caption = 'Men.Exp:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -15
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlResumoExpedicao: TPanel
            Left = 924
            Top = 1
            Width = 334
            Height = 60
            Align = alRight
            TabOrder = 1
            object Label15: TLabel
              Left = 10
              Top = 2
              Width = 147
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total dos documentos:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblResumoVlTotal: TLabel
              Left = 202
              Top = 2
              Width = 129
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'R$ 9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblResumoQtdTotal: TLabel
              Left = 156
              Top = 2
              Width = 47
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblResumoQtdNaoSep: TLabel
              Left = 156
              Top = 16
              Width = 47
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblResumoVlNaoSep: TLabel
              Left = 202
              Top = 16
              Width = 129
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'R$ 9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label19: TLabel
              Left = 10
              Top = 16
              Width = 147
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total docs. n'#227'o sep.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label22: TLabel
              Left = 17
              Top = 29
              Width = 140
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total docs. em sep.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblResumoVlSep: TLabel
              Left = 202
              Top = 29
              Width = 129
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'R$ 9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblResumoQtdSep: TLabel
              Left = 156
              Top = 29
              Width = 47
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblResumoQtdFat: TLabel
              Left = 156
              Top = 42
              Width = 47
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblResumoVlFat: TLabel
              Left = 202
              Top = 42
              Width = 129
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'R$ 9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 3
              Top = 42
              Width = 154
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total docs. a faturar:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlTotSel: TPanel
            Left = 1258
            Top = 1
            Width = 325
            Height = 60
            Align = alRight
            TabOrder = 2
            object lbl_TotProdExp: TLabel
              Left = 34
              Top = 6
              Width = 196
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total de Produtos Expedidos:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lblTotProdExp: TLabel
              Left = 226
              Top = 6
              Width = 93
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object lblTotProdNotExp: TLabel
              Left = 226
              Top = 22
              Width = 93
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object lbl_TotProdNotExp: TLabel
              Left = 6
              Top = 22
              Width = 224
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total de Produtos N'#195'O Expedidos:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lbl_TotProd: TLabel
              Left = 34
              Top = 37
              Width = 196
              Height = 14
              Alignment = taRightJustify
              Caption = 'Total de Produtos do Pedido:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lblTotProd: TLabel
              Left = 226
              Top = 37
              Width = 93
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
          end
          object pnlOriEnt: TPanel
            Left = 515
            Top = 1
            Width = 409
            Height = 60
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 3
            object lblOrientacoes: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 182
              Height = 57
              Align = alLeft
              AutoSize = False
              Caption = 'Orienta'#231#245'es Entrega:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -15
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 49
              ExplicitTop = 0
              ExplicitHeight = 54
            end
            object lblOriEnt: TLabel
              AlignWithMargins = True
              Left = 191
              Top = 4
              Width = 215
              Height = 56
              Margins.Top = 4
              Align = alClient
              AutoSize = False
              BiDiMode = bdLeftToRight
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              Transparent = True
              WordWrap = True
              ExplicitTop = 5
              ExplicitHeight = 52
            end
          end
        end
        object Panel1: TPanel
          Left = 1
          Top = 23
          Width = 1047
          Height = 219
          Align = alClient
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label1: TLabel
            Left = 44
            Top = 23
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'CIDADE:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText1: TDBText
            Left = 95
            Top = 23
            Width = 346
            Height = 17
            DataField = 'NOMCID'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 443
            Top = 23
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'ESTADO:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText2: TDBText
            Left = 495
            Top = 23
            Width = 57
            Height = 17
            DataField = 'ESTADO'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbtPeso: TDBText
            Left = 95
            Top = 38
            Width = 89
            Height = 17
            Alignment = taRightJustify
            DataField = 'PESBRU'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblPeso: TLabel
            Left = 58
            Top = 38
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'PESO:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 37
            Top = 53
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'MENSAG.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtxtMEN001: TDBText
            Left = 95
            Top = 53
            Width = 538
            Height = 17
            DataField = 'MEN001'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbtxtMEN002: TDBText
            Left = 95
            Top = 68
            Width = 533
            Height = 17
            DataField = 'MEN002'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblPrevis: TLabel
            Left = 620
            Top = 53
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'PREVIS.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtxtPrevis: TDBText
            Left = 679
            Top = 53
            Width = 76
            Height = 17
            Alignment = taRightJustify
            DataField = 'PREVIS'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblTitCND: TLabel
            Left = 23
            Top = 8
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'COND.PAG.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCONPAG: TDBText
            Left = 95
            Top = 8
            Width = 315
            Height = 17
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblTitFPG: TLabel
            Left = 415
            Top = 8
            Width = 77
            Height = 14
            Alignment = taRightJustify
            Caption = 'FORMA PAG.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblCODFPG: TDBText
            Left = 495
            Top = 8
            Width = 30
            Height = 17
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblDESFPG: TLabel
            Left = 529
            Top = 8
            Width = 242
            Height = 17
            AutoSize = False
            Caption = '....'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblIteExp: TLabel
            Left = 636
            Top = 85
            Width = 112
            Height = 14
            Caption = 'Expedidos total.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object shpIteExp: TShape
            Left = 621
            Top = 87
            Width = 13
            Height = 12
            Brush.Color = clPurple
          end
          object lblOrdPro: TLabel
            Left = 641
            Top = 8
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'O.P.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtxtOrdPro: TDBText
            Left = 679
            Top = 8
            Width = 76
            Height = 17
            DataField = 'ORDPRO'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl6: TLabel
            Left = 553
            Top = 137
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'ORI.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label13: TLabel
            Left = 591
            Top = 137
            Width = 168
            Height = 14
            Caption = '(S)ite (P)ocket (B)alc'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTotExp: TLabel
            Left = 637
            Top = 100
            Width = 126
            Height = 14
            Caption = 'Expedidos parcial.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object shpTotExp: TShape
            Left = 621
            Top = 102
            Width = 13
            Height = 12
            Brush.Color = 16744448
          end
          object lblFeriado: TLabel
            Left = 657
            Top = 68
            Width = 91
            Height = 14
            Alignment = taCenter
            Caption = 'F E R I A D O'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object shpGarantia: TShape
            Left = 621
            Top = 118
            Width = 13
            Height = 12
            Hint = 
              'Quando a coluna destino estiver com o fundo azul, significa que ' +
              #233' pedido referente a garantia'
            Brush.Color = 16744448
            ParentShowHint = False
            ShowHint = True
          end
          object lblGarantia: TLabel
            Left = 639
            Top = 117
            Width = 150
            Height = 14
            Hint = 
              'Quando a coluna destino estiver com o fundo azul, significa que ' +
              #233' pedido referente a garantia'
            Caption = 'Pedido referente a garantia'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object lblTipoAtendimentoC: TLabel
            Left = 23
            Top = 185
            Width = 140
            Height = 14
            Caption = 'TIPO DE ATENDIMENTO:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTipoAtendimentoD: TLabel
            Left = 165
            Top = 184
            Width = 336
            Height = 14
            Caption = '00000 - XXXXXXXXX.XXXXXXXXX.XXXXXXXXX.XXXXXXXXX.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblGuiche: TLabel
            Left = 443
            Top = 53
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'GUICH'#202':'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object lblNumGuiche: TLabel
            Left = 495
            Top = 53
            Width = 84
            Height = 14
            Caption = 'lblNumGuiche'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object dbeFatTot: TDBText
            Left = 762
            Top = 8
            Width = 238
            Height = 17
            Alignment = taCenter
            DataField = 'FATTOT'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblPedTransf: TLabel
            Left = 816
            Top = 53
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'PED.TRANSF.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblReqCompra: TLabel
            Left = 816
            Top = 69
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'REQ. COMPRA:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbeReqCompra: TDBText
            Left = 902
            Top = 69
            Width = 84
            Height = 14
            AutoSize = True
            DataField = 'REQCOM'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbePedTransf: TDBText
            Left = 902
            Top = 53
            Width = 84
            Height = 14
            AutoSize = True
            DataField = 'PEDTRF'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 837
            Top = 84
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = 'VENDEDOR:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblVendedor: TLabel
            Left = 902
            Top = 84
            Width = 77
            Height = 14
            Caption = 'lblVendedor'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 823
            Top = 100
            Width = 77
            Height = 14
            Alignment = taRightJustify
            Caption = 'CONFERENTE:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblConferente: TLabel
            Left = 902
            Top = 100
            Width = 140
            Height = 14
            AutoSize = False
            Caption = 'lblConferente'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object lblLocArmDesc: TLabel
            Left = 809
            Top = 115
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'LOCAL ARMAZ.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblLocArm: TLabel
            Left = 902
            Top = 115
            Width = 63
            Height = 14
            Caption = 'lblLocArm'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblPesoTotal: TLabel
            Left = 310
            Top = 38
            Width = 182
            Height = 14
            Alignment = taRightJustify
            Caption = '(PESO Total) Selecionados:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object lblPesoTotalV: TLabel
            Left = 495
            Top = 38
            Width = 93
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '9.999.999,999'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object lblVolumeTotal: TLabel
            Left = 704
            Top = 38
            Width = 196
            Height = 14
            Alignment = taRightJustify
            Caption = '(Volume Total) Selecionados:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object lblVolumeTotalV: TLabel
            Left = 902
            Top = 38
            Width = 93
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '999.999,9999'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object dbeTotFre: TDBText
            Left = 897
            Top = 23
            Width = 89
            Height = 17
            Alignment = taRightJustify
            DataField = 'TOTFRE'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblTotFre: TLabel
            Left = 816
            Top = 23
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'VALOR FRETE:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblRobSep: TLabel
            Left = 23
            Top = 201
            Width = 189
            Height = 14
            HelpType = htKeyword
            Caption = 'ROB'#212' DE SEPARA'#199#195'O SUSPENSO!'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblFreCot: TLabel
            Left = 809
            Top = 38
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'FRETE COTADO:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object dbeFreCot: TDBText
            Left = 897
            Top = 38
            Width = 89
            Height = 17
            Alignment = taRightJustify
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object lblFreSug: TLabel
            Left = 795
            Top = 53
            Width = 105
            Height = 14
            Alignment = taRightJustify
            Caption = 'FRETE SUGERIDO:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object dbeFreSug: TDBText
            Left = 897
            Top = 53
            Width = 89
            Height = 17
            Alignment = taRightJustify
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object pnlSepImp: TPanel
            Left = 18
            Top = 82
            Width = 532
            Height = 102
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object Label5: TLabel
              Left = 19
              Top = 1
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'OBSERV.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblOBSEXP: TDBText
              Left = 81
              Top = -1
              Width = 452
              Height = 15
              DataField = 'OBSEXP'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblNomSep: TLabel
              Left = 311
              Top = 55
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'SEPARADOR:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object dbtxtNomSep: TDBText
              Left = 387
              Top = 55
              Width = 137
              Height = 17
              DataField = 'NOMSEP'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblDtaImpSep: TLabel
              Left = 290
              Top = 37
              Width = 91
              Height = 14
              Alignment = taRightJustify
              Caption = 'SEP.IMPRESSA:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object dbtxtDtImSe: TDBText
              Left = 387
              Top = 37
              Width = 71
              Height = 17
              DataField = 'DTIMSE'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbtxtHrImSe: TDBText
              Left = 460
              Top = 37
              Width = 61
              Height = 17
              DataField = 'HRIMSE'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblDtaBaiSep: TLabel
              Left = 290
              Top = 20
              Width = 91
              Height = 14
              Alignment = taRightJustify
              Caption = 'SEP.BAIXADA.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object dbtxtDtBxSe: TDBText
              Left = 387
              Top = 20
              Width = 71
              Height = 17
              DataField = 'DTBXSE'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbtxtHrBxSe: TDBText
              Left = 461
              Top = 20
              Width = 61
              Height = 17
              DataField = 'HRBXSE'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpSepNaoImp: TShape
              Left = 5
              Top = 16
              Width = 12
              Height = 12
              Brush.Color = clBlack
            end
            object lblSepImpNaoImp: TLabel
              Left = 20
              Top = 15
              Width = 161
              Height = 14
              Caption = 'Separa'#231#227'o n'#227'o impressa.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpSepImp: TShape
              Left = 5
              Top = 30
              Width = 12
              Height = 12
              Brush.Color = clBlue
            end
            object lblSepImpJaImp: TLabel
              Left = 20
              Top = 29
              Width = 154
              Height = 14
              Caption = 'Separa'#231#227'o j'#225' impressa.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpAltSepImp: TShape
              Left = 5
              Top = 45
              Width = 12
              Height = 12
              Brush.Color = clRed
            end
            object lblSepImpExpNaoImp: TLabel
              Left = 20
              Top = 44
              Width = 238
              Height = 14
              Caption = 'Alterado com Separa'#231#227'o j'#225' impressa'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpDocDev: TShape
              Left = 5
              Top = 59
              Width = 12
              Height = 12
              Brush.Color = 33023
            end
            object lblSepDocumentoDevolucao: TLabel
              Left = 20
              Top = 58
              Width = 154
              Height = 14
              Caption = 'Documento de Devolu'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpSepReimp: TShape
              Left = 5
              Top = 74
              Width = 12
              Height = 12
              Brush.Color = clGreen
            end
            object lblSepImpExpJaImp: TLabel
              Left = 20
              Top = 73
              Width = 343
              Height = 14
              Caption = 'Separa'#231#227'o j'#225' reimpressa ap'#243's altera'#231#227'o do pedido.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpLibSep: TShape
              Left = 5
              Top = 89
              Width = 12
              Height = 12
              Brush.Color = clGray
            end
            object lblLibSep: TLabel
              Left = 20
              Top = 88
              Width = 252
              Height = 14
              Caption = 'Impress'#227'o da Separa'#231#227'o n'#227'o liberada.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
          end
          object pnlLegFat: TPanel
            Left = 551
            Top = 159
            Width = 255
            Height = 37
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            object Label7: TLabel
              Left = 2
              Top = -4
              Width = 35
              Height = 14
              Alignment = taRightJustify
              Caption = 'FAT.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 39
              Top = -2
              Width = 227
              Height = 59
              AutoSize = False
              Caption = 
                '(P): Parcialmente (A): Autom.'#13'(T): N'#227'o Faturado'#13'(R): Reposi'#231#227'o j' +
                #225' Faturado'
              Color = 16770261
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
            end
          end
          object pnlDocumentosSelecionados: TPanel
            Left = 805
            Top = 128
            Width = 206
            Height = 91
            BevelOuter = bvNone
            TabOrder = 2
            object Label3: TLabel
              Left = 15
              Top = 2
              Width = 84
              Height = 14
              Caption = 'DOCS.SELEC.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label12: TLabel
              Left = 15
              Top = 16
              Width = 84
              Height = 14
              Alignment = taRightJustify
              Caption = 'VL.CONT.TOT:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblValorContabilTotalSelecionados: TLabel
              Left = 103
              Top = 15
              Width = 103
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 22
              Top = 30
              Width = 77
              Height = 14
              Alignment = taRightJustify
              Caption = 'PESO TOTAL:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblPesoTotalSelecionados: TLabel
              Left = 103
              Top = 30
              Width = 103
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label18: TLabel
              Left = 15
              Top = 44
              Width = 84
              Height = 14
              Alignment = taRightJustify
              Caption = 'VOLUM.TOTAL:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblVolumeTotalSelecionados: TLabel
              Left = 103
              Top = 44
              Width = 103
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblDocsSelecionados: TLabel
              Left = 105
              Top = 2
              Width = 101
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '99999'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label17: TLabel
              Left = 15
              Top = 73
              Width = 84
              Height = 14
              Alignment = taRightJustify
              Caption = 'VALOR TOTAL:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblValorTotalSelecionado: TLabel
              Left = 103
              Top = 73
              Width = 103
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblCubTotal: TLabel
              Left = 1
              Top = 59
              Width = 98
              Height = 14
              Alignment = taRightJustify
              Caption = 'CUBAGEM TOTAL:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lblVlrCubSelecionados: TLabel
              Left = 103
              Top = 60
              Width = 103
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '9.999.999,99'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
          end
        end
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 1584
          Height = 22
          Align = alTop
          ParentColor = True
          TabOrder = 2
          object lbl1: TLabel
            Left = 37
            Top = 3
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'REGI'#195'O.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtxtDESREG: TDBText
            Left = 95
            Top = 3
            Width = 300
            Height = 17
            DataField = 'DESREG'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl2: TLabel
            Left = 380
            Top = 3
            Width = 112
            Height = 14
            Alignment = taRightJustify
            Caption = 'VLR. M'#205'NIMO FAT:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbtxtMINFAT: TDBText
            Left = 495
            Top = 3
            Width = 80
            Height = 14
            Alignment = taRightJustify
            DataField = 'MINFAT'
            DataSource = dtsPedidos
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
        end
        object pnlFeriados: TPanel
          Left = 1048
          Top = 23
          Width = 537
          Height = 219
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 3
          object dbgFeriados: TDBGridCitel
            Left = 0
            Top = 21
            Width = 537
            Height = 198
            Align = alClient
            DataSource = dtsFeriados
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'FCI_DTAFER'
                Title.Caption = 'Data'
                Width = 89
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FCI_DESCRI'
                Title.Caption = 'Descri'#231#227'o'
                Width = 341
                Visible = True
              end>
          end
          object pnlTopFer: TPanel
            Left = 0
            Top = 0
            Width = 537
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblFeriados: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 3
              Width = 140
              Height = 18
              Margins.Left = 0
              Align = alLeft
              Caption = 'FERIADOS MUNICIPAIS:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              WordWrap = True
              ExplicitHeight = 14
            end
            object dbtCidFer: TDBText
              AlignWithMargins = True
              Left = 146
              Top = 3
              Width = 388
              Height = 15
              Align = alClient
              DataField = 'ENDDOC'
              DataSource = dtsPedidos
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Courier New'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
              ExplicitLeft = 36
              ExplicitTop = 16
              ExplicitWidth = 397
              ExplicitHeight = 11
            end
          end
        end
      end
      object pnlLegendEmpVen: TPanel
        Left = 0
        Top = 0
        Width = 1586
        Height = 24
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object shpVenOutEmp: TShape
          Left = 26
          Top = 7
          Width = 12
          Height = 12
          Brush.Color = clYellow
        end
        object lbl3: TLabel
          Left = 42
          Top = 5
          Width = 203
          Height = 14
          Caption = 'Vendedores de outras empresas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object shpVenEmp: TShape
          Left = 251
          Top = 7
          Width = 12
          Height = 12
          Brush.Color = clLime
        end
        object lbl4: TLabel
          Left = 268
          Top = 5
          Width = 189
          Height = 14
          Caption = 'Vendedores da mesma empresa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tbsDuplicatas: TTabSheet
      Caption = 'Duplicatas baixadas do pedido'
      ImageIndex = 1
      object pnlDuplicatas: TPanel
        Left = 0
        Top = 0
        Width = 1586
        Height = 329
        Align = alClient
        Caption = 'pnlDuplicatas'
        ParentColor = True
        TabOrder = 0
        object cxgPagamentos: TcxGrid
          Left = 1
          Top = 1
          Width = 1584
          Height = 327
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgPagamentosDBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            FilterBox.Visible = fvNever
            DataController.DataSource = dtsDuplic
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'CTR_VALREC'
                Column = cxgPagamentosDBTableView1Column2
                DisplayText = '#,##0.00'
              end
              item
                Kind = skSum
                FieldName = 'CTR_DINHEI'
                Column = cxgPagamentosDBTableView1Column5
                DisplayText = '#,##0.00'
              end
              item
                Kind = skSum
                FieldName = 'CTR_CHQAVI'
                Column = cxgPagamentosDBTableView1Column6
                DisplayText = '#,##0.00'
              end
              item
                Kind = skSum
                FieldName = 'CTR_CHQPRE'
                Column = cxgPagamentosDBTableView1Column7
                DisplayText = '#,##0.00'
              end
              item
                Kind = skSum
                FieldName = 'CTR_CARTAO'
                Column = cxgPagamentosDBTableView1Column8
                DisplayText = '#,##0.00'
              end
              item
                Kind = skSum
                FieldName = 'CTR_ORDPAG'
                Column = cxgPagamentosDBTableView1Column9
                DisplayText = '#,##0.00'
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = ' '
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object cxgPagamentosDBTableView1Column1: TcxGridDBColumn
              Caption = 'Duplicata'
              DataBinding.FieldName = 'CTR_NUMDUP'
              Width = 147
            end
            object cxgPagamentosDBTableView1Column4: TcxGridDBColumn
              Caption = 'Data Pagamento'
              DataBinding.FieldName = 'CTR_DTAREC'
              Width = 85
            end
            object cxgPagamentosDBTableView1Column2: TcxGridDBColumn
              Caption = 'Valor Recebido'
              DataBinding.FieldName = 'CTR_VALREC'
              HeaderAlignmentHorz = taRightJustify
              Width = 87
            end
            object cxgPagamentosDBTableView1Column5: TcxGridDBColumn
              Caption = 'Dinheiro'
              DataBinding.FieldName = 'CTR_DINHEI'
              HeaderAlignmentHorz = taRightJustify
              Width = 87
            end
            object cxgPagamentosDBTableView1Column6: TcxGridDBColumn
              Caption = 'Cheque a vista'
              DataBinding.FieldName = 'CTR_CHQAVI'
              HeaderAlignmentHorz = taRightJustify
              Width = 87
            end
            object cxgPagamentosDBTableView1Column7: TcxGridDBColumn
              Caption = 'Cheque a prazo'
              DataBinding.FieldName = 'CTR_CHQPRE'
              HeaderAlignmentHorz = taRightJustify
              Width = 87
            end
            object cxgPagamentosDBTableView1Column8: TcxGridDBColumn
              Caption = 'Cart'#227'o'
              DataBinding.FieldName = 'CTR_CARTAO'
              HeaderAlignmentHorz = taRightJustify
              Width = 73
            end
            object cxgPagamentosDBTableView1Column9: TcxGridDBColumn
              Caption = 'Ordem Pagto'
              DataBinding.FieldName = 'CTR_ORDPAG'
              HeaderAlignmentHorz = taRightJustify
              Width = 87
            end
          end
          object cxgPagamentosLevel1: TcxGridLevel
            GridView = cxgPagamentosDBTableView1
          end
        end
      end
    end
    object tbsAdiantamentos: TTabSheet
      Caption = 'Adiantamentos do pedido'
      ImageIndex = 2
      object dbgAdiantamentos: TDBGridCitel
        Left = 0
        Top = 0
        Width = 1586
        Height = 329
        Align = alClient
        DataSource = dtsAdiantamentos
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgAdiantamentosDrawColumnCell
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DTALAN'
            Title.Alignment = taCenter
            Title.Caption = 'Data'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 59
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'HORLAN'
            Title.Alignment = taCenter
            Title.Caption = 'Hora'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 49
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'EMPLAN'
            Title.Alignment = taCenter
            Title.Caption = 'Emp.'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 30
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'OPELAN'
            Title.Alignment = taCenter
            Title.Caption = 'Ope.'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 32
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'SEQCON'
            Title.Alignment = taCenter
            Title.Caption = 'Seq. Baixa'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 59
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TIPLAN'
            Title.Alignment = taCenter
            Title.Caption = 'C/D'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 23
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALDIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Dinheiro'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALCHV'
            Title.Alignment = taRightJustify
            Title.Caption = 'Cheque (Vista)'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALCHP'
            Title.Alignment = taRightJustify
            Title.Caption = 'Cheque (Pr'#233')'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALCAR'
            Title.Alignment = taRightJustify
            Title.Caption = 'Cart'#227'o'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALORD'
            Title.Alignment = taRightJustify
            Title.Caption = 'Ordem Pagto'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Financiamento'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 77
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALCRE'
            Title.Alignment = taRightJustify
            Title.Caption = 'Cr'#233'ditos'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALLAN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Total'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SALFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Saldo Final'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 80
            Visible = True
          end>
      end
    end
    object tbsPedidosVinculados: TTabSheet
      Caption = 'Pedidos vinculados'
      ImageIndex = 3
      object grdPedidosVinculados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1586
        Height = 329
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdPedidosVinculadosDBTableViewCitel1: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdPedidosVinculadosDBTableViewCitel1CustomDrawCell
          DataController.DataSource = dtsPedidosVinculados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdPedidosVinculadosFGO_DTAENT: TcxGridDBColumn
            Caption = 'Data Emis.'
            DataBinding.FieldName = 'FGO_DTAENT'
          end
          object grdPedidosVinculadosFGO_NUMDOC: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'NUMDOC'
            Width = 120
          end
          object grdPedidosVinculadosVALDOC: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'VALDOC'
            Width = 70
          end
          object grdPedidosVinculadosFGO_VLRCON: TcxGridDBColumn
            Caption = 'Vr. Cont'#225'bil'
            DataBinding.FieldName = 'FGO_VLRCON'
            Width = 70
          end
          object grdPedidosVinculadosENTRET: TcxGridDBColumn
            Caption = 'Destino'
            DataBinding.FieldName = 'ENTRET'
            Width = 100
          end
          object grdPedidosVinculadosEMPITE: TcxGridDBColumn
            Caption = 'Emp. Destino'
            DataBinding.FieldName = 'EMPITE'
            Width = 68
          end
          object grdPedidosVinculadosFGO_DTAFAT: TcxGridDBColumn
            Caption = 'Data Fat.'
            DataBinding.FieldName = 'FGO_DTAFAT'
          end
          object grdPedidosVinculadosFGO_NUMFAT: TcxGridDBColumn
            Caption = 'Documento Fat.'
            DataBinding.FieldName = 'NUMFAT'
            Width = 120
          end
        end
        object grdPedidosVinculadosLevel1: TcxGridLevel
          GridView = grdPedidosVinculadosDBTableViewCitel1
        end
      end
    end
  end
  object pnlFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 1594
    Height = 219
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 3
    ParentColor = True
    TabOrder = 3
    object pnlDiversos: TPanel
      Left = 3
      Top = 3
      Width = 1588
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      ShowCaption = False
      TabOrder = 0
      object pnlLateral: TPanel
        Left = 1386
        Top = 0
        Width = 202
        Height = 55
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 3
        object pnlFilSitFin: TPanel
          Left = 0
          Top = 27
          Width = 202
          Height = 28
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label11: TLabel
            Left = 57
            Top = 7
            Width = 98
            Height = 14
            Caption = 'Situa'#231#227'o Financeira:'
          end
          object cmbSitFin: TcxImageComboBox
            Left = 158
            Top = 2
            EditValue = False
            Properties.Images = imglSitFin
            Properties.Items = <
              item
                ImageIndex = 0
              end
              item
                ImageIndex = 1
                Value = True
              end
              item
                ImageIndex = 2
                Value = False
              end>
            TabOrder = 0
            OnClick = cmbSitFinClick
            Width = 40
          end
        end
        object pnlCliLoj: TPanel
          Left = 0
          Top = 5
          Width = 202
          Height = 22
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object Label9: TLabel
            Left = 67
            Top = 4
            Width = 72
            Height = 14
            Caption = 'Cliente na loja?'
          end
          object cmbCliLoj: TComboBoxFocus
            Tag = 99
            Left = 145
            Top = 0
            Width = 53
            Height = 22
            Style = csDropDownList
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = 'Todos'
            OnClick = cmbCliLojClick
            Items.Strings = (
              'Todos'
              'Sim'
              'N'#227'o')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
      object rdgTipoDocumento: TRadioGroup
        Left = 353
        Top = 0
        Width = 325
        Height = 55
        Align = alLeft
        Caption = 'Selecione o Tipo de Documento:'
        Columns = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 3
        Items.Strings = (
          'Vendas'
          'Transfer'#234'ncias'
          'Devolu'#231#245'es'
          'Garantias')
        Constraints.MaxWidth = 700
        ParentFont = False
        TabOrder = 0
        OnClick = rdgTipoDocumentoClick
      end
      object rdgTipoMov: TRadioGroup
        Left = 678
        Top = 0
        Width = 189
        Height = 55
        Align = alLeft
        Caption = 'Selecione o Tipo de Movimento:'
        Columns = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 2
        Items.Strings = (
          'Retira'
          'Ent.Imediata'
          'Todos'
          'Urgente')
        ParentFont = False
        TabOrder = 1
        OnClick = rdgTipoMovClick
      end
      object grbLocSep: TGroupBox
        Left = 929
        Top = 0
        Width = 131
        Height = 55
        Align = alLeft
        Caption = 'Local de Separa'#231#227'o:'
        TabOrder = 2
        Visible = False
        object cmbLocSep: TComboBoxFocus
          Tag = 99
          Left = 7
          Top = 17
          Width = 120
          Height = 22
          TabOrder = 0
          OnClick = rdgTipoDocumentoClick
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object rdgFiltroPeriodo: TRadioGroup
        Left = 867
        Top = 0
        Width = 62
        Height = 55
        Align = alLeft
        Caption = 'Per'#237'odo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Hoje')
        ParentFont = False
        TabOrder = 4
        OnClick = rdgTipoMovClick
      end
      object gpbTipoExpedicao: TGroupBox
        Left = 1060
        Top = 0
        Width = 205
        Height = 55
        Align = alLeft
        Caption = 'Expedi'#231#227'o:'
        TabOrder = 5
        object rdbExpedicaoParcial: TRadioButton
          Left = 6
          Top = 14
          Width = 135
          Height = 18
          Caption = 'Expedidos Parcialmente'
          TabOrder = 0
          OnClick = gpbTipoExpedicaoClick
        end
        object rdbSemExpedicao: TRadioButton
          Left = 6
          Top = 31
          Width = 94
          Height = 18
          Caption = 'N'#227'o Expedidos'
          TabOrder = 1
          OnClick = gpbTipoExpedicaoClick
        end
        object rdbTodos: TRadioButton
          Left = 142
          Top = 14
          Width = 50
          Height = 18
          Caption = 'Todos'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = gpbTipoExpedicaoClick
        end
      end
      object grbLocRet: TGroupBox
        Left = 1265
        Top = 0
        Width = 213
        Height = 55
        Align = alLeft
        Caption = 'Selecione o Local de Retira'
        Constraints.MaxWidth = 380
        TabOrder = 6
        object lstLocRet: TcxCheckListBox
          Left = 2
          Top = 16
          Width = 209
          Height = 37
          Align = alClient
          Columns = 2
          Items = <
            item
              Text = 'Retira Expedi'#231#227'o'
            end
            item
              Text = 'Retira Balc'#227'o'
            end
            item
              Text = 'Retira Balc'#227'o 2'
            end>
          ParentColor = True
          ParentShowHint = False
          ShowHint = False
          Style.BorderStyle = cbsNone
          StyleFocused.BorderStyle = cbsNone
          StyleHot.BorderStyle = cbsNone
          TabOrder = 0
          OnClickCheck = lstLocRetClickCheck
        end
      end
      object rdgTipoConferencia: TRadioGroup
        Left = 0
        Top = 0
        Width = 353
        Height = 55
        Align = alLeft
        Caption = 'Selecione o Tipo de Confer'#234'ncia'
        Columns = 3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 3
        Items.Strings = (
          'Totalmente Conferidos'
          'Parc. e N'#227'o Conferidos'
          'Parcialmente Conferidos'
          'N'#227'o Conferidos'
          'Todos')
        Constraints.MaxWidth = 600
        ParentFont = False
        TabOrder = 8
        OnClick = rdgTipoConferenciaClick
      end
      object rdgFiltroDataColeta: TRadioGroup
        Left = 1478
        Top = 0
        Width = 236
        Height = 55
        Align = alLeft
        Caption = 'Data de Coleta'
        Columns = 3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 4
        Items.Strings = (
          'Atrasados'
          'Hoje'
          'Futuros'
          'Agendados'
          'Todos')
        ParentFont = False
        TabOrder = 7
        OnClick = rdgFiltroDataColetaClick
      end
    end
    object pnlStatusPedido: TPanel
      Left = 3
      Top = 58
      Width = 1588
      Height = 161
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lblExibirFiltroStatusPedidos: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 1582
        Height = 14
        Cursor = crHandPoint
        Margins.Top = 5
        Align = alTop
        Caption = 'Clique aqui para ocultar o filtro de Status dos Pedidos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        Layout = tlBottom
        OnClick = lblExibirFiltroStatusPedidosClick
        ExplicitWidth = 257
      end
      object grbStatusPedido: TGroupBox
        Left = 0
        Top = 19
        Width = 1588
        Height = 142
        Align = alClient
        TabOrder = 0
        object lstStatusPedido: TcxCheckListBox
          AlignWithMargins = True
          Left = 5
          Top = 19
          Width = 1578
          Height = 118
          Align = alClient
          AllowDblClickToggle = False
          AutoComplete = False
          Columns = 6
          EditValueFormat = cvfCaptions
          Items = <>
          ParentColor = True
          ParentShowHint = False
          ScrollWidth = -1
          ShowHint = False
          Style.BorderStyle = cbsNone
          Style.HotTrack = True
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = True
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.BorderStyle = cbsNone
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.BorderStyle = cbsNone
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 0
          OnClickCheck = lstStatusPedidoClickCheck
        end
      end
    end
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 219
    Width = 1594
    Height = 98
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 4
    object pnlTotDocs: TPanel
      Left = 0
      Top = 76
      Width = 1594
      Height = 22
      Align = alBottom
      ParentColor = True
      TabOrder = 0
      object Label14: TLabel
        AlignWithMargins = True
        Left = 1384
        Top = 4
        Width = 140
        Height = 17
        Align = alRight
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total de Documentos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = 14
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 819
        ExplicitTop = 2
      end
      object lblTotDocs: TLabel
        AlignWithMargins = True
        Left = 1530
        Top = 4
        Width = 48
        Height = 17
        Margins.Right = 15
        Align = alRight
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = 964
      end
      object lblOcultarExibirPainelInformacoes: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 231
        Height = 14
        Cursor = crHandPoint
        Margins.Top = 5
        Caption = 'Clique aqui para ocultar o Painel de Informa'#231#245'es'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        Layout = tlBottom
        OnClick = lblOcultarExibirPainelInformacoesClick
      end
    end
    object dbgPedidos: TDBGridCitel
      Left = 0
      Top = 0
      Width = 1594
      Height = 76
      Align = alClient
      DataSource = dtsPedidos
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnCellClick = dbgPedidosCellClick
      OnDrawColumnCell = dbgPedidosDrawColumnCell
      OnDblClick = dbgPedidosDblClick
      OnKeyDown = dbgPedidosKeyDown
      OnKeyPress = dbgPedidosKeyPress
      OnKeyUp = dbgPedidosKeyUp
      OnTitleClick = dbgPedidosTitleClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CODVEN'
          Title.Alignment = taCenter
          Title.Caption = 'Vend.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMOPE'
          Title.Caption = 'Nome do Vendedor'
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DEPVEN'
          Title.Caption = 'Dep.Vend.'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ENTRET'
          Title.Alignment = taCenter
          Title.Caption = 'Destino'
          Width = 120
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DTAENT'
          Title.Alignment = taCenter
          Title.Caption = 'Data Emis.'
          Width = 57
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'HORENT'
          Title.Alignment = taCenter
          Title.Caption = 'Hora Emis.'
          Width = 54
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DOCUME'
          Title.Alignment = taCenter
          Title.Caption = 'Documento'
          Width = 130
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DOCFAT'
          Title.Alignment = taCenter
          Title.Caption = 'Faturamento'
          Width = 130
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'KITEST'
          Title.Alignment = taCenter
          Title.Caption = 'Kit Estrutura'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CODCLI'
          Title.Caption = 'C'#243'd.Cli.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCLI'
          Title.Caption = 'Cliente'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CATEGO'
          Title.Caption = 'Categoria'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DESREG'
          Title.Caption = 'Regi'#227'o'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NOMTRA'
          Title.Caption = 'Transportadora'
          Width = 78
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALDOC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Cont'#225'bil'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCID'
          Title.Caption = 'Cidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTADO'
          Title.Caption = 'UF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERE'
          Title.Caption = 'Endere'#231'o'
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Title.Caption = 'Bairro'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C_E_P_'
          Title.Caption = 'CEP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFO'
          Title.Caption = 'Telefone'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPFRE'
          ReadOnly = False
          Title.Caption = 'Tipo de Frete'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ORIPED'
          Title.Caption = 'Ori.'
          Width = 25
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DTAROT'
          Title.Caption = 'Data Carga'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESREG2'
          Title.Caption = 'Regi'#227'o End.Rota'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SEQROT'
          Title.Caption = 'Seq. Rota'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VLRMIN'
          Title.Caption = 'Rota Valor M'#237'nino'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TIPOPE'
          Title.Caption = 'Tip. Ope.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ROMDOC'
          Title.Caption = 'Nr'#186'. Lote'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ROMDES'
          Title.Caption = 'Descr. Lote'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTALIC'
          Title.Caption = 'Data/Hora Libera'#231#227'o Comercial'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTALIB'
          Title.Caption = 'Data/Hora Libera'#231#227'o Financeira'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TURENT'
          Title.Caption = 'Turno'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SEQSEP'
          Title.Caption = 'Seq. Separa'#231#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESFPG'
          Title.Caption = 'Forma Pag.'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'FANSOB'
          Title.Caption = 'Cliente - Nome Fantasia'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'QTDITE'
          Title.Caption = 'Qtd. Total Itens'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SITADT'
          Title.Caption = 'Adiantamento'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NUMCMP'
          Title.Caption = 'Ped.Compra Cliente'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PESBRU'
          Title.Alignment = taRightJustify
          Title.Caption = 'Peso'
          Width = 66
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VOLUME'
          Title.Alignment = taRightJustify
          Title.Caption = 'Volume'
          Width = 65
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ESPECI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Esp'#233'cie'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'SEPIMP'
          Title.Caption = 'Ord.Sep.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESLAR'
          Title.Caption = 'Local Armaz.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODLAR'
          Title.Caption = 'C'#243'd. Local Armaz.'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'EPFTGE'
          Title.Caption = 'Emp. Fat. Regime'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMROM'
          Title.Caption = 'Romaneio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMPROM'
          Title.Caption = 'Emp. Romaneio'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PERSEP'
          Title.Caption = 'Perc. Separa'#231#227'o (%)'
          Width = 104
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PERCOF'
          Title.Caption = 'Perc. Conferido (%)'
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJCPF'
          Title.Caption = 'CNPJ/CPF'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'INSEST'
          Title.Caption = 'Insc. Estadual'
          Visible = False
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 132
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 132
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 116
  end
  object imglNFeSta: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 10485816
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000101011A0102016C020402A6030603C4030603C40204
          02A60102016C0101011A00000000000000000000000000000000000000000000
          0000000000000202014D050502BF0D1E07E31C6D0DF52BC320FD2BC320FD1C6D
          0DF50D1E07E3050502BF0202014D000000000000000000000000000000000000
          00000202014D070903CD207410F632D121FF31B620FF31D120FF31D120FF31D1
          20FF31D120FF1D720EF6070903CD0202014D0000000000000000000000000101
          011A050502BF267016F632C821FF31B220FFE6E6E6FF31B220FF31C820FF31C8
          20FF31C820FF31C820FF1E6F0EF6050502BF0101011A00000000000000000202
          016C0D200DE335C024FF31AD20FFDEDEDEFFE2E2E2FFE6E6E6FF31AD20FF31BE
          20FF31BE20FF31BE20FF31BE20FF0D1F08E30202016C00000000000000000404
          02A72A6922F532AE21FFD5D5D5FFDADADAFFDEDEDEFFE2E2E2FFE6E6E6FF31A8
          20FF31B420FF31B420FF31B420FF206210F5040402A700000000000000000606
          03C44FB73FFDA9D7A2FFD5D5D5FFEBEBEBFF31A520FFDEDEDEFFE2E2E2FFE6E6
          E6FF31A320FF31AA20FF31AA20FF2B9E26FD060603C400000000000000000606
          03C452BA41FD4BB33AFFF8F8F8FF3CA82BFF32A221FF319F20FFDEDEDEFFE2E2
          E2FFE6E6E6FF319E20FF31A120FF2C9A2AFD060603C400000000000000000404
          02A735712CF556BE45FF4DB53CFF56BE45FF50B93FFF46AF35FF3CA42BFFE2E2
          E2FFE3E3E3FFE7E7E7FF359E24FF236322F5040402A700000000000000000202
          016C11240EE363CB52FF5DC54CFF5DC54CFF5DC54CFF5DC54CFF5DC54CFF53BB
          42FFFFFFFFFFA7E29EFF61C950FF10220DE30202016C00000000000000000101
          011A050505BF3D7D35F667CF56FF66CE55FF66CE55FF66CE55FF66CE55FF66CE
          55FF59C148FF61C950FF3B7C32F6050504BF0101011A00000000000000000000
          00000202014D070A07CD3E8036F672DA61FF6ED65DFF6ED65DFF6ED65DFF6ED6
          5DFF71D960FF3D7F35F6070A07CD0202014D0000000000000000000000000000
          0000000000000202014D050505BF12240EE3397933F56ACC59FD6ACC58FD3978
          33F512240EE3050505BF0202014D000000000000000000000000000000000000
          000000000000000000000101011A0202016C040402A6060603C4060603C40404
          02A60202016C0101011A00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000F00F0000E0070000C00300008001000080010000800100008001
          000080010000800100008001000080010000C0030000E0070000F00F0000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000202025C1717
          16D87C7C78F981817BFA81817BFA81817BFA81817CFA81817CFA81817CFA8181
          7DFA81817DFA81817DFA81817DFA7D7D79F9191918D90202025D11110FD69494
          8AFF95958BFF95958BFF95958BFF95958BFF95958BFF95958BFF95958BFF9595
          8BFF95958BFF95958BFF95958BFF95958BFF95958BFF111111D676766CFFB0B0
          A6FFBABAB0FFBCBCB2FFBCBCB2FFC4C4BBFFC2C2B9FFBCBCB2FFBCBCB2FFC2C2
          B9FFC4C4BBFFBCBCB2FFBCBCB2FFBABAB0FFB0B0A6FF7A7A70FF717167FFBFBF
          B5FFC0C0B6FFC0C0B6FFC7C7BFFF8D8D86FF969690FFC5C5BCFFC5C5BCFF9696
          90FF8D8D86FFC7C7BFFFC0C0B6FFC0C0B6FFBFBFB5FF74746AFF707066FFC3C3
          B9FFC3C3B9FFC7C7BEFF838381FF3F3F35FF3F3F35FF8D8D86FF8D8D86FF3F3F
          35FF3F3F35FF838381FFC7C7BEFFC3C3B9FFC3C3B9FF74746AFF717167FFC7C7
          BDFFC7C7BDFFC4C4BCFF808078FF45453BFF45453BFF45453BFF45453BFF4545
          3BFF45453BFF808078FFC4C4BCFFC7C7BDFFC7C7BDFF74746AFF717167FFCBCB
          C1FFCBCBC1FFCBCBC1FFC9C9BFFF81817CFF4A4A40FF4A4A40FF4A4A40FF4A4A
          40FF81817CFFC9C9BFFFCBCBC1FFCBCBC1FFCBCBC1FF75756BFF717167FFCECE
          C4FFCECEC4FFCECEC4FFCECEC6FF818180FF4F4F45FF4F4F45FF4F4F45FF4F4F
          45FF818180FFCECEC6FFCECEC4FFCECEC4FFCECEC4FF75756BFF727268FFD2D2
          C8FFD2D2C8FFCECEC6FF81817BFF55554BFF55554BFF55554BFF55554BFF5555
          4BFF55554BFF81817BFFCECEC6FFD2D2C8FFD2D2C8FF76766CFF727268FFD6D6
          CCFFD6D6CCFFD2D2C8FF818180FF5A5A50FF5A5A50FF818181FF818181FF5A5A
          50FF5A5A50FF818180FFD2D2C8FFD6D6CCFFD6D6CCFF76766CFF75756BFFDADA
          D0FFD9D9CFFFD9D9CFFFD5D5CBFF818181FF848481FFD5D5CDFFD5D5CDFF8484
          81FF818181FFD5D5CBFFD9D9CFFFD9D9CFFFDADAD0FF79796FFF6F6F65FFE6E6
          E0FFE3E3DAFFE1E1D8FFE1E1D8FFDDDDD4FFDDDDD4FFE1E1D8FFE1E1D8FFDDDD
          D4FFDDDDD4FFE1E1D8FFE1E1D8FFE3E3DAFFE7E7E1FF717167FF090908CCBFBF
          B8FFF4F4F1FFF6F6F4FFF6F6F4FFF6F6F4FFF6F6F4FFF6F6F4FFF6F6F4FFF6F6
          F4FFF6F6F4FFF6F6F4FFF6F6F4FFF4F4F1FFBFBFB9FF090908CC0101013C0707
          06C773736AFF818178FF818178FF818178FF818178FF818178FF818178FF8181
          78FF818178FF818178FF818178FF73736AFF070706C70101013C000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000FFFF
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000101010E0101012001010130010101310101
          0122010101100000000000000000000000000000000000000000000000000000
          0000000000000101011F0202026C090603C62D1B06E876420BF97C400BFA2C1A
          06E90B0703CE0202027C01010126000000000000000000000000000000000000
          00000101012F040403AA78400BFAC4730BFFD87E0BFFE0810BFFE7810BFFE181
          0BFFCB760BFF7B480BFB050504B90101013C0000000000000000000000000101
          010C040402B2A55F0BFFC2710BFFCB750BFFC88123FFD4C1ACFFD4C2AEFFD081
          26FFD67E0BFFC9740BFFA45E0BFF060502BA0101011000000000000000000202
          014B944C0BFEB3670BFFBA6C0BFFC2710BFFC18F5FFFFFFFFFFFFFFFFFFFC794
          66FFCF790BFFC8730BFFBC6C0BFF8F490BFE02020145000000000101010A1D11
          04DCA15C0BFFA8610BFFB2670BFFBB6D0BFFB87722FFDACAB9FFDBCDBCFFBD7B
          25FFC3720BFFBF6F0BFFB86A0BFFAA630BFF160E04D900000000010101258B51
          0BFF98570BFFA15D0BFFAA620BFFB2670BFFB96C0BFFBC6D0BFFBE6E0BFFBD6E
          0BFFB96C0BFFB3680BFFAE630BFFA65F0BFF8B500BFF01010117020201529459
          14FF9D6017FF9F6017FFA76618FFAF6B1CFFB4701CFFAF8149FFB08145FFB76F
          16FFB57019FFB16D19FFA55F0EFF9D590BFF94550BFF0202014B02020175A46D
          29FFA76F29FFA66D29FFA66C28FFAA6F26FFAD8158FFFDFDFDFFFEFEFEFFA981
          4DFFAC6E21FFA76A20FFA66D27FFA66A23FFA2661EFF020201720202014CA46F
          2BFFAF7834FFAE7834FFAE7733FFAD7733FFBC9F81FFFFFFFFFFFFFFFFFFB899
          81FFAA722EFFA9722DFFA8702BFFA8702BFFA5702BFF0202014B01010117A06A
          27FFB7813CFFB6803BFFB5803AFFB57F3AFFBEA284FFFFFFFFFFFFFFFFFFBB9D
          81FFB17B37FFB17B36FFB07A36FFAF7A35FFA6702CFF01010117000000001E13
          0ADDBE8140FFBE813FFFBD8140FFBC813FFFC2A687FFFFFFFFFFFFFFFFFFBFA1
          81FFB9813EFFB9813DFFB8813CFFB8813DFF24190BDF00000000000000000101
          0133A7722DFDC68340FFC58341FFC48241FFC2A281FFFFFFFFFFFFFFFFFFBC9A
          7EFFC18140FFC08140FFC08140FFAD7833FD0101013200000000000000000000
          000003030395C89058FFCC8F53FFCC8F50FFC28D5BFFCABFB2FFC8BDB0FFBE87
          52FFC88847FFC88948FFCF9458FF0303038E0000000000000000000000000000
          00000000000002020271AD875DFBD8A36DFFD49D66FFD29B63FFD19961FFD29A
          62FFD59E65FFA57F4EFA02020265000000000000000000000000000000000000
          0000000000000000000001010121040404AC564A3BEBCDAF82FDC29E7AFC3D33
          27E50303039F0101011E00000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00F81F0000E0070000C0030000800100008001000000010000000000000000
          00000000000000000000000000008001000080010000C0030000E0070000F00F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000001010111020202760C0C0CC0343433DF444240E41B1B
          1AD20303039D0101013800000000000000000000000000000000000000000000
          0000000000000202025B9A988FF4B1BDEAFF6781DDFF356FD7FF2D6DD5FF4E77
          D9FF889BE3FFE9EBF0FF040404A4010101060000000000000000000000000000
          00000202027AF0EFF1FF5379DCFF0B3CD0FF0B58E3FF0B6FF0FF0B72F2FF0B63
          E8FF0B43D5FF194ECFFFB5C5EFFF171614CD0101011200000000000000000202
          0246EEF2F1FF4164D7FF0B44DCFF0B81FFFF0B85FFFF0B8DFFFF0B91FFFF0B87
          FFFF0B81FFFF0B67EFFF0B38CCFFAFC0EEFF040404A600000000000000000C0C
          0CC2818BE5FF0B49DFFF0B8CFFFF94CAFFFF8DCDFFFF0B8BFFFF0B89FFFF55AC
          FFFFC1DEFFFF339FFFFF0B6AF0FF2854D7FFDFE3EDFF020202470101013BDADB
          EAFF245DE1FF0B74FAFF41A5FFFFFFFFFFFFFFFFFFFF6CCCFFFF29B2FFFFEDF8
          FFFFFFFFFFFF8BCBFFFF0B82FFFF0B50E3FF90A0E5FF0303039603030399A4BA
          EAFF0B66F1FF0B94FFFF0B8FFFFF6BC7FFFFFFFFFFFFFFFFFFFFF6FEFFFFFFFF
          FFFFA8E7FFFF0F9BFFFF0B95FFFF0B75F9FF5681EAFF161614CD0B0B0BBF92AE
          EDFF0B75FBFF0BA7FFFF0BA9FFFF0B9DFFFF86DEFFFFFFFFFFFFFFFFFFFFCDFB
          FFFF0BAAFFFF0B9FFFFF0BABFFFF0B81FFFF3A81F1FF373634E00303039DA2BB
          EEFF0B72FCFF0BA3FFFF0BA9FFFF5ACEFFFFF8FDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF87E1FFFF0BB0FFFF0BA9FFFF0B81FFFF5185F1FF171715CE0101013FD4D8
          E8FF1B76F9FF0B8FFFFF43BAFFFFFFFFFFFFFFFFFFFF81E8FFFF37DAFFFFF4FD
          FFFFFFFFFFFF81D5FFFF0B9FFFFF0B76FEFF82A2EDFF03030399000000001111
          10C87997F1FF0B78FFFF0BAFFFFFA8DFFFFFA8EBFFFF0BBBFFFF0BB7FFFF5ED3
          FFFFCDEFFFFF37BCFFFF0B8CFFFF1E73F9FFD9DFE3FF0202024B000000000202
          024DEDE7DDFF347FF7FF0B81FFFF0BAAFFFF0BAFFFFF0BB6FFFF0BBAFFFF0BB1
          FFFF0BACFFFF0B96FFFF0B6DFFFFA0B7E5FF050505AB00000000000000000000
          000003030381E4DBD7FF3E81F3FF0B80FFFF0B8FFFFF0B9FFFFF0BA1FFFF0B97
          FFFF0B81FFFF0B79FDFF9DB2DFFF24231FD70101011800000000000000000000
          00000000000002020265D6CAB7FC8EA9DDFF4C8BF0FF2889FBFF1E87FBFF3B89
          F5FF7196E5FFD1CED3FF070606B20101010E0000000000000000000000000000
          000000000000000000000101011803030382131212CB494748E85B585AED2B29
          29DC050404A80202024200000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000F00F0000E0030000C00100008001000080000000000000000000
          00000000000000000000000000008000000080010000C0010000E0030000F00F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000001010104010101140101012A0101012A0101
          0115010101040000000000000000000000000000000000000000000000000000
          0000000000000101010301010246050505B50A0A40EF13138FFE101091FE0808
          3EEE020205B50101024801010105000000000000000000000000000000000000
          0000010101080303038F161682FC0B0B8FFF0B0B92FF0B0B95FF0B0B99FF0B0B
          9CFF0B0BA0FF0B0B87FB0202038E0101010A0000000000000000000000000101
          010303030390101096FF0B0B96FF0B0B99FF0B0B9CFF0B0B9FFF0B0BA3FF0B0B
          A6FF0B0BA9FF0B0BADFF0B0BAFFE0202038E0101010400000000000000000202
          0243151592FC0B0B9FFF0F0FA0FF3D3DAFFF0B0BA6FF0B0BAAFF0B0BADFF0B0B
          AFFF3D3DBBFF0F0FB5FF0B0BBAFF0B0B9EFB0101024400000000010101020505
          05B40B0BA8FF0B0BABFF3939B6FFF8F8FCFF6868C5FF0B0BB4FF0B0BB7FF6868
          C9FFF8F8FCFF3939C6FF0B0BC4FF0B0BC7FF020204B2010101030101010D0A0A
          65F30B0BB4FF0B0BB7FF0B0BB8FF6161CAFFF8F8FCFF6868CCFF6868CDFFF8F8
          FCFF6161D2FF0B0BCAFF0B0BCDFF0B0BD0FF070753ED01010111010101251818
          C2FF0B0BC1FF0B0BC3FF0B0BC5FF0B0BC6FF6161D1FFF8F8FCFFF8F8FCFF6161
          D6FF0C0CD1FF0F0FD5FF0F0FD7FF0E0ED9FF1111CFFE01010123010101252929
          D0FF2323D0FF1919D0FF1111D0FF0C0CD0FF6868D7FFF8F8FCFFF8F8FCFF7373
          DCFF2525DDFF2626E0FF2626E2FF2626E3FF2929D9FE010101220101010B2020
          80F44141DFFF4141E0FF4040E0FF8181E1FFF9F9FDFF8181E3FF8181E3FFF9F9
          FDFF8181E5FF4040E8FF4141EBFF4141ECFF1C1C63EE0101010E010101010505
          05B46060EBFF6060EBFF7B7BE7FFFAFAFDFF8C8CE9FF5F5FEEFF5F5FEEFF8C8C
          EAFFFAFAFDFF7B7BEBFF6060F2FF6060F3FF040404AF01010102000000000101
          013F6E6ED9FD8080F4FF7F7FF0FF8A8AEEFF7F7FF4FF8080F6FF8080F6FF7F7F
          F5FF8A8AF0FF7F7FF4FF8080F8FF6565CCFB0101013D00000000000000000101
          01010303038D9393F9FF9494FAFF9494FAFF9494FAFF9494FAFF9494FAFF9494
          FBFF9494FBFF9494FBFF9393FBFF030303870101010100000000000000000000
          0000010101030303038D9D9DE3FDAFAFFDFFAFAFFDFFAFAFFDFFAFAFFDFFAFAF
          FDFFAFAFFDFF9797D9FC03030387010101040000000000000000000000000000
          000000000000000000000101013D040406B2656593F4BBBBFEFFBBBBFEFF5A5A
          83F2040405AF0101013B01010101000000000000000000000000000000000000
          0000000000000000000000000000000000000101010801010121010101210101
          0108000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00F81F0000E0070000C0030000800100008001000000000000000000000000
          00000000000000000000000000008001000080010000C0030000F0070000FC3F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000101
          012E02020252020202610202026C0202026D0202027902020278020202780202
          02790202026E0202026E02020262020202530101012F00000000000000000101
          012402020242020202480303038F27496BF30F71BFFF0B6AC5FF0B6BC5FF1975
          BEFF17232FE2020202700202024C020202420101012400000000000000000000
          000000000000020303980B6DC4FF0B71C4FF0C74C5FF0B72C3FF0B72C3FF0B73
          C5FF0B72C5FF0B6EC4FF0102025B000000000000000000000000000000000000
          0000020608BA0C75C5FF0F77C7FF0F78C8FF0B76C6FF2981D0FF1D81CEFF0C77
          C6FF0F77C8FF0E78C7FF0D74C6FF0102026B0000000000000000000000000102
          026F0F76C7FF0E79C7FF1079CAFF0F7AC9FF0B71C7FFFFFFFFFFE7F4FCFF0B72
          C6FF107CCBFF107ACAFF107AC9FF0E78C9FF0101012500000000000000000F65
          ADFB107BCAFF0F7BCBFF117ECBFF117FCDFF0B7BCCFF549BDCFF3E90D8FF0B7C
          CCFF1180CEFF117FCDFF117CCCFF0F7CCBFF040608B80000000001020245107D
          CBFF117ECCFF1080CEFF1280CFFF1281D0FF0B7FCFFF5BA1DFFF348CD7FF0D81
          CFFF1281CFFF1281CEFF1281CDFF107FCDFF1180D1FF000000000202027A117D
          CDFF1281CDFF1181D0FF1381D0FF1381D1FF0B7DCFFFD5E9F7FF91C4EAFF0B81
          D1FF1381D3FF1381D2FF1181D1FF1281CEFF1081D2FF01010131030303871180
          CEFF1181D1FF1381D1FF1481D4FF1481D5FF0B81D3FFE1EEF8FFA3CEEFFF0B81
          D3FF1381D6FF1481D5FF1281D2FF1281D2FF1581D4FF0101013F020202721181
          D0FF1281D3FF1481D3FF1381D5FF1582D8FF0B81D4FFF1F7FBFFBCDCF2FF0B81
          D6FF1483D7FF1581D6FF1381D6FF1281D3FF1F86D9FF0101012A01010135298D
          DAFF1281D2FF1581D7FF1483D9FF1685DAFF0B81D8FFFFFFFEFFD4E7F7FF0B81
          D9FF1686DBFF1684DAFF1582D8FF1181D5FF2A93E1FF0000000000000000193D
          57EA0E81D4FF1483D7FF1686DBFF1788DBFF0B81DAFFFFFFFFFFDCEBF6FF0B82
          DBFF178ADCFF1586DCFF1584D9FF1683D7FF0303039E00000000000000000202
          02483D9FE3FF0F81D8FF1788DBFF168BDFFF128ADFFF4AA3E4FF3F9EE3FF138D
          E0FF188DE0FF1689DEFF0D81D9FF4DADE9FF0101010C00000000000000000000
          00000303038345A7E6FF0E83DCFF148ADEFF1890E3FF148FE3FF1591E5FF1791
          E4FF148CE0FF1188DDFF59B7ECFF0101013B0000000000000000000000000000
          0000000000000202025F5BBCF1FF42AAE9FF128DE2FF1491E5FF1594E6FF1A94
          E5FF4FB3ECFF1D3B4CE60101012A000000000000000000000000000000000000
          000000000000000000000101010202020266040405AD090F12CA080D10C60303
          039F0202024C0000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF008001000080010000E0070000C00300008001000080010000000100000000
          00000000000000000000000100008001000080010000C0030000E0070000F01F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000001010101010101340202027D0303039B0303039B0202
          02780101012F0000000000000000000000000000000000000000000000000000
          00000000000001010136060609C9191966FF252582FF2A2A8EFF2A2A8EFF2525
          81FF1A1A65FF060608C30101012A000000000000000000000000000000000000
          0000010102520C0C3BF52A2A90FF3737ADFF39399FFF3B3B98FF3B3B98FF4040
          A1FF3737ABFF2C2C8FFF0C0C3BF5010102400000000000000000000000000101
          02460E0E3FF630309CFF3C3CB6FF373799FF030303930202024F0202024F0303
          03851D1D3BE83F3FA3FF31319AFF0D0D3CF40101013C00000000010101030808
          10D72C2C95FF3C3CB5FF4545BFFF4242B6FF0A0A1BDA01010115000000000000
          000001010115060609B94141A3FF2E2E96FF07070BCE000000000202024B1E1E
          75FF3737B1FF4040ADFF4C4CC4FF5656D1FF4848B2FF0A0A1DDA010101150000
          000000000000010101151B1B39E83737AAFF202076FF0101013C0303039C2929
          8FFF2D2D97FF040404A62E2E64F55454C0FF6767E2FF5555C2FF0A0A1DDA0101
          011500000000000000000202027B3B3B9FFF2B2B8FFF03030393050507B93838
          B0FF2A2A81FF010101280202024435356AF56262CFFF7878F4FF5E5ECDFF0B0B
          1DDA0101011500000000010101373A3A94FF30309AFF040406B106060EC83D3D
          BBFF2A2A80FF0000000000000000020202444A4A70F58181DBFF8181F7FF5656
          C5FF0A0A1CDA010101150101012038388FFF31319DFF06060CC0040404A03939
          B1FF33339DFF02020260000000000000000002020244515170F58181D8FF8383
          EEFF5757BBFF0A0A18DA0202027B37379DFF2D2D93FF03030393020202683333
          A4FF4343BDFF07070ECD000000000000000000000000020202444D4D6DF57575
          CFFF7979E4FF5C5CCFFF252584FF4040B7FF2C2C91FF02020260010101051111
          38EA3F3FBEFF32329BFF02020273000000000000000000000000020202444545
          6AF56666D4FF6161DAFF5454D4FF4242BEFF121234E800000000000000000202
          02663A3AA4FF4141C1FF34349BFF060609C10101013E01010103010101030202
          027E5F5FAFFF5454D4FF4747CDFF35359FFF0202026000000000000000000000
          00000303039A4040ACFF4242C2FF3F3FB5FF2D2D8BFF222273FF232377FF3333
          9AFF4545C4FF4343C1FF3939A6FF040404A20000000000000000000000000000
          0000000000000202027420205AF44343B0FF4444BFFF3F3FBDFF4040BEFF4242
          BEFF3C3CADFF202058F402020271000000000000000000000000000000000000
          00000000000000000000010101150202027306060BC00A0A13CD090913CD0606
          0AC0020202710101011300000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00F01F0000E0070000C00300008001000000C1000000600000003000000010
          0000180000000C0000000E0000000701000080010000C0030000E0070000F00F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000001010101010101010000
          0000000000000000000000000000000000000000000000000000000000000101
          010201010113010101250101013801020249010202550102025B0102025C0102
          02560102024B0101013C01010128010101160101010400000000000000000101
          010201010114050D13BC204D63EA235870EE20566EEE1F556EEF1A526BEF1651
          69EF144B62ED13485EEC081E29D7010101340101010400000000000000000000
          0000020202485493A8F579F0FEFF69EFFEFF5CEBFCFF50E7F9FF44E3F7FF38E0
          F4FF30DDF2FF27D9EFFF409FB6FA020608A90000000000000000000000000000
          00000202026588DCF0FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          0000020202658CDEF1FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          0000020202658EDFF2FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          0000020202658EDFF3FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          000001010131437D95F291F1FDFF82F2FEFF7CEFFCFF71EBFAFF63E8F8FF56E5
          F6FF48E1F3FF39DCF1FF328BA4F80203048F0000000000000000000000000000
          000000000000030505993F83A9FA2A7194F70C2532D50B2531D50B2430D50923
          2FD5256785F72A6F92FA04090BB20101010E0000000000000000000000000000
          00000000000002020250C5C8C7FD232424DC0000000000000000000000000000
          0000363737E38C8F8DF702020240000000000000000000000000000000000000
          0000000000000202024FCDCECEFD2B2C2BE10000000000000000000000000101
          0101333534E56A6D6CF30101013F000000000000000000000000000000000000
          00000000000001010131A0A1A1F6464747E90202024000000000000000000202
          0241444847EC383B3AE60101011F000000000000000000000000000000000000
          000000000000010101064D4D4DE6DBDEDDFF3F4040E8222222DB212121DA3B3D
          3BE8B7BBB9FF212323DC00000000000000000000000000000000000000000000
          00000000000000000000020202404A4E4CE7A9ACABFBC5C8C7FFC5C8C7FF8487
          86F7292B2AE10101013200000000000000000000000000000000000000000000
          00000000000000000000000000000101010A0202025D0303038C030303860202
          0251010101060000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FE7F00008001000080010000C0030000C0030000C0030000C0030000C003
          0000C0030000E0030000E3C70000E3870000E1870000E00F0000F00F0000F81F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000005052EBA1E22
          A6FB1F249BF8191E97F8141994F8121791F811148EF810128BF80F1187F80D10
          85F80C0E82F8090C7FF80B0D7CF80C0D7BF8090A7EFB030326C320269EF6314C
          EEFF1934E4FF142DE0FF172CDAFF1528D5FF1223CFFF1D2BD6FF1D27D2FF1017
          C1FF1014BDFF0E12B9FF080BB5FF090BAFFF0C0DB9FF0A0B7AF706072BB52D40
          DBFF071FE4FF6675D1FFABAFD0FFA9AED9FFB3B7E0FF9C9FC7FF9A9CC4FFB4B6
          DCFFACAED3FFAFB0CBFF7375BAFF0707A4FF0C0EABFF040426C101010242262C
          B0FB1733EAFF7F88D7FFF9F5D9FFF8F6EAFFFFFFFBFF6D6D61FF626257FFFFFF
          F9FFFAFAEFFFFBFBE2FF8D8FC5FF070AB5FF0E1093FF01010251010101050505
          21AA2C3FDEFF2940E8FFD6D8E5FFFAF9F2FFFDFDFEFFD5D5D7FFD2D2D3FFFDFD
          FEFFFAFAF5FFE1E2E5FF3033BCFF0B10B5FF050522B90101010C000000000101
          0241222BA2F51632EDFF7883E8FFFFFFF7FFFFFFFFFFBCBCBCFFB5B5B5FFFFFF
          FFFFFFFFFCFF9094D5FF0710C0FF12158DF80101024E00000000000000000000
          0000040422AB3345DEFF4E62F5FFEDEEFCFFFFFFFFFF8C8C8CFF818181FFFFFF
          FFFFEAEBFEFF333ADFFF131CC0FF050522B70101010200000000000000000000
          00000101023A3136AEF99EA2FDFFCFCFFFFFFFFFFFFF787878FF666666FFFFFF
          FFFFA7A7FFFF2829FEFF1A1CA5FD010102490000000000000000000000000000
          00000101010304041DA38182E7FFBDBCFFFFFBFBFFFF575753FF494944FFF6F6
          FEFF7070FFFF3334E2FF040421B2010101070000000000000000000000000000
          000000000000010102362F30A0F3B2B4FEFFDFDFFFFF787872FF737367FFC0C0
          FCFF5F60FEFF20229BF701010241000000000000000000000000000000000000
          000000000000010101040202199D8285E5FFC9C8FFFFE6E6EFFFE6E6EDFF9696
          FFFF5456E3FF03041EAA01010108000000000000000000000000000000000000
          00000000000000000000010102372C309AF1BEC0FEFFD7D7FFFFC9C8FFFF8E8F
          FFFF282A9FF60101024500000000000000000000000000000000000000000000
          000000000000000000000000000002031A9E8C90E5FFCCCCFFFFB5B4FFFF7B7E
          E4FF040422AE0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000101012A2F31A0F3D6D8FFFFCCCDFFFF3336
          ABF8010102390000000000000000000000000000000000000000000000000000
          000000000000000000000000000001010103020215949397E8FF9A9FE9FF0303
          1EA5010101040000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000010101260E0F64DB131474E40101
          0132000000000000000000000000000000000000000000000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000080010000C0010000C003
          0000C0030000E0070000E0070000F00F0000F81F0000F81F0000F81F0000FC3F
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000020202590202027602020276020202590000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000505056FE8E8E8FFE8E8E8FF0505056F0000000000000000000000000101
          3099010152CC010152CC010152CC010152CC010152CC01013099000000000000
          000007070769FBFBFBFF494949B4020202350000000000000000000000000101
          62CC5F5FF7FF5F5FF7FF5F5FF7FF5F5FF7FF5F5FF7FF010162CC000000000000
          000008080867FBFBFBFF08080867000000000000000000000000000000000101
          3D9901016CCC02026CCD040476DC050579E0040476DB01013D99000000000101
          010E0606066CDFDFDFFF0606066C010107330000000000000000000000000000
          0000000000000202032C15151590EAEAEAFF0606066C00000000000000000202
          02686F6F6FDDC1C1C1FF6F6F6FDD010160CC0000000000000000010101060101
          0119020202430C0C0C7E878787E7E0E0E0FF0202027500000000010119660101
          60CC010160CC010160CC010160CC010160CC0202027702020277020202771717
          1791454545B9BDBDBDF3B7B7B7FFD7D7D7FF0202027800000000010164C62D2D
          B7F24343DCFF4343DCFF4343DCFF4343DCFFDCDCDCFFDCDCDCFFDCDCDCFFD9D9
          D9FFD5D5D5FFD2D2D2FFB7B7B7FFD5D5D5FF0404047700000000020268BB4A4A
          D7FF3B3BD1FF3B3BD1FF3B3BD1FF3B3BD1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1
          D1FFD2D2D2FFD2D2D2FFBEBEBEFFDDDDDDFF0707077500000000020268B27777
          F2FF5F5FECFF5F5FECFF5F5FECFF5F5FECFFECECECFFECECECFFECECECFFEBEB
          EBFFE8E8E8FFE5E5E5FFCACACAFFEBEBEBFF0B0B0B7200000000020268AC5F5F
          D0EA8D8DFCFF8D8DFCFF8D8DFCFF8D8DFCFFFCFCFCFFFCFCFCFFFCFCFCFFF9F9
          F9FFF5F5F5FFF1F1F1FFD3D3D3FFF3F3F3FF0F0F0F6E0000000001011B560202
          68AB020268AB020268AB020268AB020268AB1212126B1212126B1212126B2929
          29875D5D5DB3DBDBDBF2DCDCDCFFF8F8F8FF1212126B00000000000000000000
          0000000000000000000000000000000000000000000000000000010101050202
          02170808083D1E1E1E75AEAEAEE6FDFDFDFF1414146800000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000040404292E2E2E8BFFFFFFFF1515156600000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000010101040D0D0D4D151515660D0D0D4D00000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFFF0000C3FF0000C3800000C3800000C780000083E10000830100000001
          00000001000000010000000100000001000000010000FF010000FFE10000FFE1
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000391E0399150B025C0000000000000000000000000000
          0000020202590202027602020276020202590000000000000000000000000000
          000000000000000000006C3C09CC6C3C09CC170D035C00000000000000000000
          00000505056FE8E8E8FFE8E8E8FF0505056F000000000000000043280A997545
          10CC754510CC754510CC754510CCFFC539FF754510CC190F045C000000000000
          000007070769FBFBFBFF494949B40202023500000000000000007D4E17CCFFE3
          92FFFFD56BFFFFD15EFFFFD15EFFFFD15EFFFFD874FF7D4E17CC000000000000
          000008080867FBFBFBFF080808670000000000000000000000004C3111998757
          1ECC87571ECC88571FCD936023DCFFE597FF935F23DB1C12075C000000000101
          010E0606066CDFDFDFFF0606066C010107330000000000000000000000000000
          0000000000000303022CAB7532E9E1A55DFF322311A200000000000000000202
          02686F6F6FDDC1C1C1FF6F6F6FDD010160CC0000000000000000010101060101
          0119020202430C0C0C7ECBA06AF8E3C8A5FF0202027500000000010119660101
          60CC010160CC010160CC010160CC010160CC0202027702020277020202771717
          1791454545B9BDBDBDF3B7B7B7FFD7D7D7FF0202027800000000010164C62D2D
          B7F24343DCFF4343DCFF4343DCFF4343DCFFDCDCDCFFDCDCDCFFDCDCDCFFD9D9
          D9FFD5D5D5FFD2D2D2FFB7B7B7FFD5D5D5FF0404047700000000020268BB4A4A
          D7FF3B3BD1FF3B3BD1FF3B3BD1FF3B3BD1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1
          D1FFD2D2D2FFD2D2D2FFBEBEBEFFDDDDDDFF0707077500000000020268B27777
          F2FF5F5FECFF5F5FECFF5F5FECFF5F5FECFFECECECFFECECECFFECECECFFEBEB
          EBFFE8E8E8FFE5E5E5FFCACACAFFEBEBEBFF0B0B0B7200000000020268AC5F5F
          D0EA8D8DFCFF8D8DFCFF8D8DFCFF8D8DFCFFFCFCFCFFFCFCFCFFFCFCFCFFF9F9
          F9FFF5F5F5FFF1F1F1FFD3D3D3FFF3F3F3FF0F0F0F6E0000000001011B560202
          68AB020268AB020268AB020268AB020268AB1212126B1212126B1212126B2929
          29875D5D5DB3DBDBDBF2DCDCDCFFF8F8F8FF1212126B00000000000000000000
          0000000000000000000000000000000000000000000000000000010101050202
          02170808083D1E1E1E75AEAEAEE6FDFDFDFF1414146800000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000040404292E2E2E8BFFFFFFFF1515156600000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000010101040D0D0D4D151515660D0D0D4D00000000}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00FFF30000C3F10000C3000000C3000000C700000083E10000830100000001
          00000001000000010000000100000001000000010000FF010000FFE10000FFE1
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848281FF8A83
          7EFF252423FF141413FF2E2C2BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF2F2E2BFF111010FF252422FFFFFFFFFF4F4E4DFF9B93
          8CFF131211FF5D5C5CFF0A0A09FFB2A69CFFB5AAA0FFC1B7B0FFC8BFB9FFBFB5
          AEFFB9AFA7FFC1B8B1FF0D0C0CFF5D5D5CFF131211FFB2A69CFF4F4E4DFFBAB0
          A7FF504C49FF0E0D0DFF6B6662FFBCB2AAFF7D7467FF7E7769FF7E766AFF7A71
          64FF766D60FF766E61FF4D4740FF0F0E0DFF403A31FF695F52FFAFA8A3FFBEB4
          ACFFC1B7B0FFC5BCB6FFCAC0BBFFC5BDB7FF215D12FF245F14FF235E14FF215C
          12FF205A11FF205710FF1E540EFF1D530DFF1B520BFF1A510BFFAEA6A0FF1E1D
          1CFF3D3A38FF85807CFFAAA39EFFC3BAB3FF097508FF097609FF097609FF0A72
          08FF0A6C06FF0C6204FF0D5802FF0E5201FF0E5201FF0E5201FFC7BEB8FF4D4D
          4CFF191919FF181716FF595552FFC0B6AFFF087E0BFF07880CFF07870CFF0783
          0CFF087C0AFF0A7108FF0B6505FF0D5702FF0E5201FF0E5201FFC9C0BBFFA19B
          97FF1F1F1FFF151514FF181716FFBBB1A9FF08850CFF07950EFF07950EFF0791
          0EFF06890DFF087E0AFF0A7007FF0C6104FF0E5401FF0E5201FFFFFFFFFFBAB2
          ACFF8D8885FF1F1F1FFF161615FFB7ABA3FF088B0CFF09A210FF09A110FF089B
          0FFF07930EFF07880CFF097909FF0B6806FF0D5802FF0E5201FFFFFFFFFFFFFF
          FFFFBEB4ADFFA89F99FF9F978FFFB3A79DFF098F0DFF0AAD11FF0AAC11FF09A3
          10FF08980FFF068C0DFF087E0AFF0A6C07FF0D5B03FF0E5201FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF098F0DFF0AB011FF0AAF11FF09A4
          10FF08990FFF068D0DFF087E0BFF0A6D07FF0D5B03FF0E5201FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Mask.Data = {
          7E000000424D7E000000000000003E0000002800000010000000100000000100
          010000000000400000000000000000000000020000000000000000000000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000245799001F63CC001256CC001154CC000744CC000034CC000438CC000E
          44CC001953CC002563CC00235599000000000000000000000000000000000000
          00003B2B0C77CAC1B8D2AF9F8FBFBFB4A9C8D6D0CBDBB2A79BBDB1A295BEAFA0
          90BFAF9F8EC0C8BEB4D23B2B0C77000000000000000000000000000000000000
          00003A2B0E70CAC1B8D288A6B1E39BB7C2E7BDD0D8EF81A0AFE27897A4E37796
          A1E3819FAAE3C8BEB4D23A2B0E70000000000000000000000000000000000000
          00003A2C0F6CCAC1B8D272A9C4F688B7CEF7B0D0DFFA659DB8F65991ABF65890
          AAF6679EB8F6C8BEB4D23A2C0F6C000000000000000000000000000000000000
          00003A2C0F6AD6CFC9DCAF9F8FBFBFB4A9C8D6D0CBDBB2A79BBDB1A295BEAFA0
          90BFAF9F8EC0D5CDC6DC3A2C0F6A000000000000000000000000000000000000
          00001D1608353A2C1069C6BBAFD2BFB4A9C8D6D0CBDBB2A79BBDB1A295BEAFA0
          90BFC7BBAFD33A2C10691D160835000000000000000000000000000000000000
          0000000000001D160834392C1067D0C8C0D7D6D0CBDBB2A79BBDB1A295BEC6BB
          AFD2392C10671D16083400000000000000000000000000000000000000000000
          000000000000000000001D160833392C1165D6D0CBDBB2A79BBDC8BDB3D1392C
          11651D1608330000000000000000000000000000000000000000000000000000
          000000000000000000001C160832382B1163D6D0CBDBB2A79BBDC8BDB3D1382B
          11631C1608320000000000000000000000000000000000000000000000000000
          0000000000001C160931382B1162D0C8C0D7CB9886F0AC4725FFB27961DFC6BB
          AFD2382B11621C16093100000000000000000000000000000000000000000000
          00001C150930382B1160C6BBAFD2C7917BE1BD6F55FF9C9497F9AA5941FEBC7B
          63DFC7BBAFD3382B11601C150930000000000000000000000000000000000000
          0000382B125FD6CFC9DCCD947BDFD28268FFC8B3B0FE999498FB918C90FBBB61
          48FEC88369E0D5CDC6DC382B125F000000000000000000000000000000000000
          0000372A125DCAC1B8D2EB8563FFD6714FFFBC5836FFAC4725FFB14624FFC851
          2FFFE25F3DFFC8BEB4D2372A125D000000000000000000000000000000000000
          0000362A125CCAC1B8D2AF9F8FBFBFB4A9C8D6D0CBDBB2A79BBDB1A295BEAFA0
          90BFAF9F8EC0C8BEB4D2362A125C000000000000000000000000000000000000
          0000362A125BCAC1B8D2AF9F8FBFBFB4A9C8D6D0CBDBB2A79BBDB1A295BEAFA0
          90BFAF9F8EC0C8BEB4D2362A125B000000000000000000000000000000000000
          00000D3F679009437FC6013578CC003276CC002266CC001256CC021659CB0523
          62C80A346FC50E437BC10D3D6590000000000000000000000000}
      end>
  end
  object dtsPedidos: TDataSource
    Left = 632
    Top = 84
  end
  object dtsDuplic: TDataSource
    Left = 236
    Top = 380
  end
  object dtsAdiantamentos: TDataSource
    Left = 336
    Top = 400
  end
  object imglSitFin: TImageList
    Left = 772
    Top = 136
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFEFF7FFFF0000
      FFFFC7E3C1FF0000FFFF83C1C0FF0000FFFFC183C07F0000FFFFE007803F0000
      FFFFF00F801F0000FFFFF81F800F0000FFFFF81F04070000FFFFF00F06030000
      FFFFE0078F000000FFFFC183FFC00000FFFF83C1FFE00000FFFFC7E3FFF10000
      FFFFEFF7FFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object popSeparacao: TPopupMenu
    Left = 243
    Top = 584
    object mnuLimparSeparacao: TMenuItem
      Caption = '[ALT + F2] Limpar Separa'#231#227'o'
      OnClick = mnuLimparSeparacaoClick
    end
    object mnuRemanejarSeparador: TMenuItem
      Caption = '[ALT + F3] Remanejar Separador'
      OnClick = mnuRemanejarSeparadorClick
    end
    object mnuLimparSeparacaoRomaneio: TMenuItem
      Caption = '[ALT + F4] Limpar Separa'#231#227'o do Lote de Romaneio'
      OnClick = mnuLimparSeparacaoRomaneioClick
    end
    object mnuGuardarItensSep: TMenuItem
      Caption = '[CTRL + F8] Guardar Itens Separados'
      OnClick = mnuGuardarItensSepClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuVerSeparacoes: TMenuItem
      Caption = '[ALT + F11] Ver Separa'#231#245'es'
      OnClick = mnuVerSeparacoesClick
    end
  end
  object tmrTmpRte: TTimer
    Enabled = False
    OnTimer = tmrTmpRteTimer
    Left = 59
    Top = 86
  end
  object tmrTmpIan: TTimer
    Enabled = False
    OnTimer = tmrTmpIanTimer
    Left = 113
    Top = 86
  end
  object popExpedicao: TPopupMenu
    Left = 315
    Top = 584
    object mnuDesfazerExpedicaoDesteDocumento: TMenuItem
      Caption = 'Desfazer expedi'#231#227'o deste documento'
      OnClick = mnuDesfazerExpedicaoDesteDocumentoClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente: TMenuItem
      Caption = 'Desfazer expedi'#231#227'o de documento j'#225' baixado totalmente'
      OnClick = mnuDesfazerExpedicaoDeDocumentoJaBaixadoTotalmenteClick
    end
  end
  object imglSeqDmp: TImageList
    Left = 835
    Top = 139
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008FB9
      AA005E9A820041866A00367C5F0012644100105D3D00306C5200356E55004D7C
      68007A9B8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000278A
      63004EBB98003CBB90002FB586002FBF8D002DBD8B0027AE7D0024A87800209A
      6C000D5535000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000050A5
      850057C09F006CDBBC0065DAB70045CBA00039C6970037C495003AC3960036A4
      7E0034765B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000075B69D003B9F7C0068CEB1006AD1B4004BC59E0042BD950028846300669C
      8700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084B2A20050947C004E907A005F9A
      850071A392006D9F8E003D8B730040768E00386E8700367F67006FA1900070A3
      910055927C0044826B00407E6700749D8E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003C9477006EC6AB0052B7950046B0
      8D0047AF8C0079B5A100487591007DA4CD00588BC100315F81007EBAA60047AF
      8C003AA17E0035987500379878001C6D50000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000070B39D005EB59A0084D4BD0065CB
      AB0080CFB50086BFAD00567EB000BDE0F5008BC2EB00345E970084BAAD0079CB
      B10055BC9B005DB89C003991730057937E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4D4C90062AC940087D0
      BB00AEDDD000416992005C80B000CAE8F60094C6E900375D95004A6C8B00ACDA
      CD0078C7AF00559C8600A9C6BD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D79
      94007D96B800255696004F7CB100517CAF002C508800325D98001E3F79007C95
      B5003C6A85000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B6C1D1007097
      C300A7D2F400326BAE006C9ED1005C8CC10076A5D3005385BE0021478400A5CE
      F0004676B000A9B3C40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B85AB0094B8
      D800B4DAF70079A2CE004B84C1004686C8003477BE004374AD0085A2C300B6DA
      F6005C8FC5005F779D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002D57900085A7
      CA005D88B5007291B8006D86AB0000000000000000007B93B800A7BFD700618B
      B7003A679E00234A800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003563A0004879
      B3006197D0004E87C6002754900000000000000000003563A0004879B3006197
      D0004E87C6002754900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B1C4DC005583
      BC003A72B300507EB400A1B5D0000000000000000000B1C4DC005583BC003A72
      B300507EB400A1B5D00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFE00700000000
      FFFFE00700000000FFFFE00700000000FFFFF00F00000000FFFF000000000000
      FFFF000000000000FFFF000000000000FFFF800100000000FFFFE00700000000
      FFFFC00300000000FFFFC00300000000FFFFC18300000000FFFFC18300000000
      FFFFC18300000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object dtsPedidosVinculados: TDataSource
    Left = 472
    Top = 408
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -19
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -19
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    HintHidePause = 5000
    Left = 704
    Top = 160
  end
  object tmrBuscar: TTimer
    Enabled = False
    OnTimer = tmrBuscarTimer
    Left = 167
    Top = 86
  end
  object dtsFeriados: TUniDataSource
    DataSet = cdsFeriados
    Left = 1160
    Top = 547
  end
  object cdsFeriados: TUniClientDataSet
    PersistDataPacket.Data = {
      4C0000009619E0BD0100000018000000020000000000030000004C000A464349
      5F44544146455204000600000000000A4643495F444553435249010049000000
      01000557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    AfterOpen = cdsFeriadosAfterOpen
    Left = 1136
    Top = 547
    object cdsFeriadosFCI_DTAFER: TDateField
      FieldName = 'FCI_DTAFER'
    end
    object cdsFeriadosFCI_DESCRI: TStringField
      DisplayWidth = 100
      FieldName = 'FCI_DESCRI'
      Size = 100
    end
  end
end
