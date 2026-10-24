inherited frmCadPromocoes: TfrmCadPromocoes
  Left = 291
  Top = 146
  Width = 1024
  Height = 768
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Promo'#231#227'o de Produtos para Venda'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    BevelInner = bvNone
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 1
    TabOrder = 1
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 939
      Height = 25
      ExplicitTop = 2
      ExplicitWidth = 939
      ExplicitHeight = 25
      inherited btnIncluir: TBitBtnLocked
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnGravar: TBitBtnLocked
        Left = 78
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 78
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 156
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 156
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 234
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 234
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnCancela: TBitBtnLocked
        Left = 312
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 312
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 390
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 390
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      object btnHeranca: TBitBtnLocked
        Left = 468
        Top = 0
        Width = 116
        Height = 25
        Align = alLeft
        Caption = '&Heran'#231'a de Promo'#231#227'o'
        Enabled = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
      object btnEstrutura: TBitBtnLocked
        Left = 584
        Top = 0
        Width = 70
        Height = 25
        Align = alLeft
        Caption = 'Estrutu&ra'
        TabOrder = 7
        OnClick = btnEstruturaClick
      end
      object btnComposicaoPrecoCusto: TBitBtnLocked
        Left = 654
        Top = 0
        Width = 158
        Height = 25
        Align = alLeft
        Caption = 'Composi'#231#227'o do Pre'#231'o de Custo'
        Enabled = False
        TabOrder = 8
        OnClick = btnComposicaoPrecoCustoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 941
      Width = 75
      Height = 25
      Align = alRight
      ExplicitLeft = 941
      ExplicitWidth = 75
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 2
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 671
      TabOrder = 1
      ExplicitLeft = 671
    end
    inherited pnlInfo: TPanel
      Width = 671
      TabOrder = 0
      ExplicitWidth = 671
    end
  end
  inherited pgcDados: TPageControl
    Width = 1018
    Height = 695
    ActivePage = tbsItens
    TabOrder = 0
    OnChange = pgcDadosChange
    ExplicitWidth = 1018
    ExplicitHeight = 695
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 663
      object pnlGeral: TPanel
        Left = 0
        Top = 0
        Width = 662
        Height = 663
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlCabecalho: TPanel
          Left = 0
          Top = 0
          Width = 662
          Height = 441
          Align = alTop
          BevelEdges = []
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label1: TLabel
            Left = 11
            Top = 6
            Width = 39
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo:'
          end
          object Label2: TLabel
            Left = 21
            Top = 393
            Width = 46
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Validade:'
          end
          object Label3: TLabel
            Left = 168
            Top = 392
            Width = 6
            Height = 14
            Alignment = taRightJustify
            Caption = 'a'
          end
          object lblQtdLimPro: TLabel
            Left = 11
            Top = 370
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtde.Limite:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblQtdMinPro: TLabel
            Left = 144
            Top = 370
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd.M'#237'nima:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblValorMinimoProdutos: TLabel
            Left = 26
            Top = 347
            Width = 170
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor m'#237'nimo do total dos produtos:'
          end
          object gpbEntFut: TGroupBox
            Left = 364
            Top = 243
            Width = 290
            Height = 60
            TabOrder = 13
            object chkAguCli: TCheckBox
              Left = 24
              Top = 11
              Width = 117
              Height = 17
              Caption = 'Aguardando cliente'
              TabOrder = 0
              OnClick = chkAguCliClick
            end
            object chkPrevis: TCheckBox
              Left = 24
              Top = 26
              Width = 117
              Height = 17
              Caption = 'Previs'#227'o'
              TabOrder = 1
              OnClick = chkAguCliClick
            end
            object chkFalPro: TCheckBox
              Left = 24
              Top = 41
              Width = 117
              Height = 17
              Caption = 'Falta de produto'
              TabOrder = 2
              OnClick = chkAguCliClick
            end
          end
          object dbeCodPro: TDBEditFocus
            Tag = 99
            Left = 53
            Top = 2
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_CODPRO'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesPro: TDBEditFocus
            Tag = 99
            Left = 124
            Top = 2
            Width = 427
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_DESPRO'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaIni: TDBEditFocus
            Tag = 99
            Left = 70
            Top = 390
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_DTAINI'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 20
            OnEnter = dbeDtaIniEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaFin: TDBEditFocus
            Tag = 99
            Left = 202
            Top = 390
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_DTAFIN'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 21
            OnEnter = dbeDtaFinEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object rdgPreDes: TRadioGroup
            Left = 11
            Top = 27
            Width = 347
            Height = 241
            Caption = 'Promo'#231#227'o por:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Pre'#231'o'
              '% Desconto'
              'Pre'#231'o com Desconto Adicional sobre Pre'#231'o de Compra'
              'Pre'#231'o por quantidade coletiva'
              '% Desconto com Desc. Adicional sobre Pre'#231'o de Compra'
              '% Desconto por quantidade coletiva'
              'Estoque remanescente dos produtos com atualiza'#231#227'o de pre'#231'os'
              'Negocia'#231#227'o especial com fornecedor atrav'#233's de ped. de comp.'
              'Promo'#231#227'o Composta por Kit'
              'Pre'#231'o por quantidade m'#237'nima escalonada'
              '% Desconto por quantidade m'#237'nima escalonada')
            ParentFont = False
            TabOrder = 3
            OnClick = rdgPreDesClick
          end
          object chkEntFut: TCheckBox
            Left = 370
            Top = 237
            Width = 147
            Height = 16
            Caption = 'Permite entrega futura?'
            TabOrder = 12
            WordWrap = True
            OnClick = chkEntFutClick
          end
          object btnHlpPro: TBitBtnLocked
            Left = 333
            Top = 40
            Width = 21
            Height = 19
            Hint = 'Clique aqui para mais informa'#231#245'es sobre a promo'#231#227'o selecionada!'
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
            OnClick = btnHlpProClick
          end
          object dbeQtdLim: TDBEditFocus
            Tag = 99
            Left = 70
            Top = 367
            Width = 70
            Height = 22
            DataField = 'PRO_QTDLIM'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 18
            OnEnter = dbeDtaIniEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeQtdMin: TDBEditFocus
            Tag = 99
            Left = 202
            Top = 367
            Width = 70
            Height = 22
            DataField = 'PRO_QTDMIN'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 19
            OnEnter = dbeDtaIniEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object chkEntIme: TCheckBox
            Left = 370
            Top = 221
            Width = 173
            Height = 16
            Caption = 'Permite entrega imediata?'
            TabOrder = 11
            WordWrap = True
          end
          object rdgComPro: TRadioGroup
            Left = 364
            Top = 30
            Width = 290
            Height = 60
            Caption = 'Considerar Comiss'#227'o'
            ItemIndex = 0
            Items.Strings = (
              'Informada nesta promo'#231#227'o'
              'Definida nas configura'#231#245'es do sistema')
            TabOrder = 5
            OnClick = rdgComProClick
          end
          object btnHlpCom: TBitBtnLocked
            Left = 632
            Top = 40
            Width = 19
            Height = 19
            Hint = 'Clique aqui para mais informa'#231#245'es sobre a promo'#231#227'o selecionada!'
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
            TabOrder = 6
            TabStop = False
            OnClick = btnHlpComClick
          end
          object chkSomaCompraPend: TDBCheckBox
            Left = 11
            Top = 274
            Width = 347
            Height = 25
            Caption = 
              'Somar Pedidos de Compra em aberto no saldo dispon'#237'vel para calcu' +
              'lar o estoque remanescente.'
            DataField = 'PRO_COMSAL'
            DataSource = dtsCadPromocoes
            TabOrder = 14
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object rdgQtdLim: TRadioGroup
            Left = 364
            Top = 96
            Width = 290
            Height = 60
            Caption = 'Aplicar quantidade limite desta promo'#231#227'o'
            ItemIndex = 0
            Items.Strings = (
              'Para cada empresa participante da promo'#231#227'o'
              'Para todas as empresas participantes da promo'#231#227'o')
            TabOrder = 7
          end
          object btnHlpQtdLim: TBitBtnLocked
            Left = 632
            Top = 106
            Width = 19
            Height = 21
            Hint = 'Clique aqui para mais informa'#231#245'es sobre a op'#231#227'o selecionada!'
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
            TabOrder = 8
            TabStop = False
            OnClick = btnHlpQtdLimClick
          end
          object chkEcommerce: TCheckBox
            Left = 554
            Top = -2
            Width = 100
            Height = 36
            Alignment = taLeftJustify
            BiDiMode = bdLeftToRight
            Caption = 'Promo'#231#227'o para e-commerce'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 2
            WordWrap = True
            OnClick = chkEcommerceClick
          end
          object chkPromocaoRestritaClientesNaoConsumidor: TDBCheckBox
            Left = 11
            Top = 304
            Width = 347
            Height = 14
            Caption = 'Promo'#231#227'o restrita a clientes n'#227'o consumidor.'
            DataField = 'PRO_RESNCO'
            DataSource = dtsCadPromocoes
            TabOrder = 15
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object gpbTabloid: TGroupBox
            Left = 364
            Top = 305
            Width = 292
            Height = 67
            Caption = 'Tabloid:'
            TabOrder = 22
            object lblTabloid: TLabel
              Left = 8
              Top = 30
              Width = 275
              Height = 28
              Alignment = taCenter
              Caption = 
                'A promo'#231#227'o em Tabloid ter'#225' prefer'#234'ncia sobre uma promo'#231#227'o do mes' +
                'mo produto, dentro da mesma vig'#234'ncia.'
              Font.Charset = ANSI_CHARSET
              Font.Color = cl3DDkShadow
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object chkTabloid: TDBCheckBox
              Left = 16
              Top = 15
              Width = 137
              Height = 14
              Alignment = taLeftJustify
              BiDiMode = bdLeftToRight
              Caption = 'Promo'#231#227'o em Tabloid?'
              DataField = 'PRO_TABLOI'
              DataSource = dtsCadPromocoes
              ParentBiDiMode = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              WordWrap = True
              OnClick = chkTabloidClick
            end
          end
          object chkTraPro: TDBCheckBox
            Left = 11
            Top = 324
            Width = 347
            Height = 14
            Caption = 'Utilizar pre'#231'o da promo'#231#227'o para trava de pre'#231'o m'#237'nimo exigido?'
            DataField = 'PRO_TRAPRO'
            DataSource = dtsCadPromocoes
            TabOrder = 16
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object rdgUtilizarLimitePorClienteOuVenda: TRadioGroup
            Left = 364
            Top = 163
            Width = 290
            Height = 53
            Items.Strings = (
              'Limitar por Cliente'
              'Limitar por Venda')
            TabOrder = 10
          end
          object chkUtilizarLimitePorClienteOuVenda: TCheckBox
            Left = 370
            Top = 158
            Width = 191
            Height = 16
            Caption = 'Utilizar limite por Cliente ou Venda'
            TabOrder = 9
            WordWrap = True
            OnClick = chkUtilizarLimitePorClienteOuVendaClick
          end
          object dbeVlrMinProd: TDBEditFocus
            Tag = 99
            Left = 202
            Top = 344
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_VLRMIN'
            DataSource = dtsCadPromocoes
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 17
            OnEnter = dbeDtaIniEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object rdgConsideraVlrMin: TRadioGroup
            Left = 365
            Top = 378
            Width = 292
            Height = 55
            Caption = 'Considerar valor m'#237'nimo'
            Items.Strings = (
              'De todos os itens da venda'
              'Apenas dos itens desta promo'#231#227'o')
            TabOrder = 23
          end
        end
        object pnlTabelas: TPanel
          Left = 0
          Top = 441
          Width = 662
          Height = 76
          Align = alTop
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object lblTabPreco: TLabel
            Left = 11
            Top = 2
            Width = 295
            Height = 14
            Caption = 'Esta promo'#231#227'o se aplica para as seguintes tabelas de pre'#231'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblLegCondicoes: TLabel
            Left = 488
            Top = 19
            Width = 167
            Height = 45
            Alignment = taCenter
            Caption = 
              'Esta promo'#231#227'o possui '#13#10'condi'#231#245'es de pagamento.'#13#10'O prazo m'#233'dio se' +
              'r'#225' ignorado.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object clbTabPre: TCheckListBox
            Left = 11
            Top = 19
            Width = 464
            Height = 49
            OnClickCheck = clbTabPreClickCheck
            Columns = 3
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            Items.Strings = (
              'Tabela de Pre'#231'o 1'
              'Tabela de Pre'#231'o 2'
              'Tabela de Pre'#231'o 3'
              'Tabela de Pre'#231'o 4'
              'Tabela de Pre'#231'o 5'
              'Tabela de Pre'#231'o 6'
              'Tabela de Pre'#231'o 7')
            Style = lbOwnerDrawFixed
            TabOrder = 0
            OnDrawItem = clbTabPreDrawItem
            OnExit = clbTabPreExit
            OnKeyDown = clbTabPreKeyDown
          end
        end
        object pnlTrazerPrecoSugestao: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 520
          Width = 656
          Height = 45
          Align = alTop
          BevelOuter = bvNone
          BorderWidth = 3
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object rdgProPre: TcxDBRadioGroup
            Left = 3
            Top = 3
            Align = alLeft
            Caption = 'Trazer pre'#231'o de sugest'#227'o no faturamento'
            DataBinding.DataField = 'PRO_PROPRE'
            DataBinding.DataSource = dtsCadPromocoes
            Properties.Columns = 2
            Properties.Items = <
              item
                Caption = 'Pre'#231'o de Promo'#231#227'o'
                Value = '1'
              end
              item
                Caption = 'Pre'#231'o de Tabela'
                Value = '2'
              end>
            TabOrder = 0
            Height = 39
            Width = 352
          end
        end
      end
      object pnlEmpresa: TPanel
        Left = 662
        Top = 0
        Width = 348
        Height = 663
        Align = alRight
        Alignment = taRightJustify
        ParentColor = True
        TabOrder = 1
        object Label16: TLabel
          Left = 1
          Top = 1
          Width = 346
          Height = 14
          Align = alTop
          Alignment = taCenter
          Caption = 'Empresas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 56
        end
        object clbEmpresa: TCheckListBox
          Left = 1
          Top = 15
          Width = 346
          Height = 625
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          TabOrder = 0
          OnExit = clbEmpresaExit
          OnKeyDown = clbEmpresaKeyDown
        end
        object pnlSelecao: TPanel
          Left = 1
          Top = 640
          Width = 346
          Height = 22
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object lblOpSele: TLabel
            Left = 5
            Top = 6
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblOpSeleClick
          end
        end
      end
    end
    object tbsItens: TTabSheet
      Caption = '&2 - Itens da Promo'#231#227'o'
      ImageIndex = 2
      object pnlBotoesExtra: TFlowPanel
        Left = 0
        Top = 635
        Width = 1010
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 0
        object btnImportarItensPedidoCompra: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = '[ F3 ] Importar Produtos de Ped. Compra'
          Enabled = False
          TabOrder = 0
          OnClick = btnImportarItensPedidoCompraClick
        end
      end
      object pnlInformacoesItens: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 450
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object pnlDadosItem: TPanel
          Left = 1
          Top = 1
          Width = 763
          Height = 448
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label4: TLabel
            Left = 356
            Top = 30
            Width = 85
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Produto:'
          end
          object Label5: TLabel
            Left = 18
            Top = 358
            Width = 65
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda:'
          end
          object Label7: TLabel
            Left = 15
            Top = 312
            Width = 71
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Pre'#231'o Custo:'
          end
          object Label9: TLabel
            Left = 20
            Top = 30
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Linha / Grupo:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 383
            Top = 53
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
          object Label11: TLabel
            Left = 55
            Top = 53
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
          object lblDescricao: TLabel
            Left = 7
            Top = 99
            Width = 81
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o Inicial:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 32
            Top = 122
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'Refer'#234'ncia:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 10
            Top = 192
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo Unidade:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 10
            Top = 145
            Width = 77
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o Final:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 198
            Top = 312
            Width = 121
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss. Vend. Interno:'
          end
          object Label14: TLabel
            Left = 180
            Top = 335
            Width = 139
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss. Repres. Ext. Loja:'
          end
          object Label15: TLabel
            Left = 30
            Top = 213
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtde.Limite:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl1: TLabel
            Left = 395
            Top = 312
            Width = 109
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Prz M'#233'd. Cond. Pagto.:'
          end
          object Label17: TLabel
            Left = 21
            Top = 380
            Width = 62
            Height = 14
            Alignment = taRightJustify
            Caption = '% Desconto:'
          end
          object lbl2: TLabel
            Left = 161
            Top = 213
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd.M'#237'nima:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl8: TLabel
            Left = 167
            Top = 358
            Width = 152
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss. Repres. Ext. Distrib.:'
          end
          object Bevel1: TBevel
            Left = 6
            Top = 251
            Width = 734
            Height = 2
            Shape = bsTopLine
          end
          object shpPreCus: TShape
            Left = 160
            Top = 308
            Width = 5
            Height = 22
            Brush.Color = clGreen
          end
          object lblPeriodoVig: TLabel
            Left = 47
            Top = 6
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Per'#237'odo:'
          end
          object lblAte: TLabel
            Left = 165
            Top = 6
            Width = 18
            Height = 14
            Alignment = taCenter
            AutoSize = False
            Caption = 'at'#233
          end
          object Label21: TLabel
            Left = 397
            Top = 6
            Width = 270
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '% Estoque Dispon'#237'vel que ser'#225' colocado em promo'#231#227'o:'
          end
          object Label22: TLabel
            Left = 15
            Top = 288
            Width = 71
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'P.Custo Cad.:'
          end
          object Label23: TLabel
            Left = 165
            Top = 288
            Width = 560
            Height = 14
            Caption = 
              '** Quando n'#227'o for informado o pre'#231'o de custo da promo'#231#227'o, ser'#225' u' +
              'tilizado o pre'#231'o de custo do cadastro do produto'
          end
          object lblTipoPeriodo: TLabel
            Left = 264
            Top = 6
            Width = 90
            Height = 14
            Caption = '( UL.ALT.PRE'#199'O )'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object lblDepart: TLabel
            Left = 18
            Top = 76
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
          object Label35: TLabel
            Left = 374
            Top = 122
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto Ativo:'
          end
          object Label36: TLabel
            Left = 276
            Top = 192
            Width = 165
            Height = 14
            Alignment = taRightJustify
            Caption = 'Incluir Saldo Zerado ou Negativo?:'
          end
          object Label37: TLabel
            Left = 388
            Top = 137
            Width = 53
            Height = 28
            Alignment = taRightJustify
            Caption = 'Ativo para Compras:'
            WordWrap = True
          end
          object Label39: TLabel
            Left = 376
            Top = 98
            Width = 65
            Height = 14
            Alignment = taRightJustify
            Caption = 'Imprime Lista:'
          end
          object Label41: TLabel
            Left = 354
            Top = 76
            Width = 88
            Height = 14
            Alignment = taRightJustify
            Caption = 'Grupo de Compra:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label42: TLabel
            Left = 7
            Top = 168
            Width = 80
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o Prod.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblCliVen: TLabel
            Left = 313
            Top = 213
            Width = 128
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtde. Limite Cliente/Venda:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblMarBru: TLabel
            Left = 13
            Top = 334
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Bruta:'
          end
          object btnInsPla: TBitBtnLocked
            Left = 586
            Top = 331
            Width = 127
            Height = 22
            Hint = 'Importar produtos'
            Caption = 'Importar de Planilha'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
              84FF848484FF848484FF848484FF848484FF848484FF848484FF000000000000
              00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
              76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF97A776FFFFFF
              FFFFFFFFFFFFC1CAADFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FFFFFFFFFFC1CAADFFFFFFFFFF97A776FFFFFFFFFF97A776FF97A776FF97A7
              76FF97A776FFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FFC1CAADFFFFFFFFFFC1CAADFF97A776FFFFFFFFFF97A776FF97A776FFC1CA
              ADFFFFFFFFFFC1CAADFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FFFFFFFFFFC1CAADFFFFFFFFFF97A776FFFFFFFFFF97A776FF97A776FFFFFF
              FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FF97A776FFC1CA
              ADFFFFFFFFFFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF848484FF0000000097A7
              76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
              76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
              00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
              84FF848484FF848484FF848484FF848484FF848484FF848484FF}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 40
            OnClick = btnInsPlaClick
          end
          object edtCodIte: TEditFocus
            Tag = 99
            Left = 444
            Top = 26
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 4
            OnEnter = edtCodIteEnter
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
          object edtDesIte: TEditFocus
            Left = 515
            Top = 26
            Width = 220
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 24
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtPreVen: TEditFocus
            Tag = 99
            Left = 89
            Top = 354
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 31
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtPreCus: TEditFocus
            Tag = 99
            Left = 89
            Top = 308
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 29
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object mskLinhaGrupo: TMaskEditFocus
            Tag = 99
            Left = 90
            Top = 26
            Width = 70
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
            TabOrder = 3
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
            Left = 161
            Top = 26
            Width = 190
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 23
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
            Left = 444
            Top = 49
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 6
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
            Left = 515
            Top = 49
            Width = 220
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 26
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
            Left = 90
            Top = 49
            Width = 70
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
            Left = 161
            Top = 49
            Width = 190
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 25
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDescriIni: TEditFocus
            Tag = 99
            Left = 90
            Top = 95
            Width = 261
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
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtRefere: TEditFocus
            Tag = 99
            Left = 90
            Top = 118
            Width = 261
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
            TabOrder = 11
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
            Left = 90
            Top = 187
            Width = 36
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
            TabOrder = 16
            OnKeyPress = edtUnidadeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDescriFin: TEditFocus
            Tag = 99
            Left = 90
            Top = 141
            Width = 261
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
          object edtComVar: TEditFocus
            Tag = 99
            Left = 321
            Top = 308
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 33
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtComAta: TEditFocus
            Tag = 99
            Left = 321
            Top = 331
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 34
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtQtdLim: TEditFocus
            Tag = 99
            Left = 90
            Top = 210
            Width = 65
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 18
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = ',0.00'
          end
          object edtPrzMed: TEditFocus
            Tag = 99
            Left = 506
            Top = 308
            Width = 63
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 37
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtPerDes: TEditFocus
            Tag = 99
            Left = 89
            Top = 377
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 32
            OnExit = edtPerDesExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtQtdMin: TEditFocus
            Tag = 99
            Left = 218
            Top = 210
            Width = 65
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 19
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = ',0.00'
          end
          object btnConfirmar: TBitBtnLocked
            Left = 585
            Top = 308
            Width = 74
            Height = 22
            Caption = 'C&onfirma'
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
            TabOrder = 38
            OnClick = btnConfirmarClick
          end
          object btnCancelaItem: TBitBtnLocked
            Left = 661
            Top = 307
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
            TabOrder = 39
            OnClick = btnCancelaItemClick
          end
          object edtComDis: TEditFocus
            Tag = 99
            Left = 321
            Top = 354
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 35
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object btnAtuCom: TBitBtnLocked
            Left = 7
            Top = 401
            Width = 215
            Height = 22
            Caption = 'Atualizar Comiss'#227'o do Cad. Produtos'
            TabOrder = 42
            Visible = False
            OnClick = btnAtuComClick
          end
          object btnDigAtu: TBitBtnLocked
            Left = 225
            Top = 401
            Width = 215
            Height = 22
            Caption = 'Digitar Comiss'#227'o para Todos os Produtos'
            TabOrder = 43
            Visible = False
            OnClick = btnDigAtuClick
          end
          object btnAtuPerVrl: TBitBtnLocked
            Left = 443
            Top = 401
            Width = 215
            Height = 22
            Caption = 'Digitar Pr. Venda para Todos os Produtos'
            TabOrder = 44
            Visible = False
            OnClick = btnAtuPerVrlClick
          end
          object gpbDesAdi: TGroupBox
            Left = 8
            Top = 254
            Width = 726
            Height = 29
            Enabled = False
            TabOrder = 27
            Visible = False
            object Label19: TLabel
              Left = 16
              Top = 7
              Width = 210
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto adicional sobre pre'#231'o de compra:'
            end
            object Label20: TLabel
              Left = 357
              Top = 7
              Width = 207
              Height = 14
              Alignment = taRightJustify
              Caption = 'Gerar pre'#231'o de venda com base na tabela:'
            end
            object edtDesAdi: TEditFocus
              Tag = 99
              Left = 240
              Top = 4
              Width = 77
              Height = 22
              Alignment = taRightJustify
              TabOrder = 0
              Text = '0,00'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object cmbTabPre: TComboBoxFocus
              Tag = 99
              Left = 578
              Top = 4
              Width = 41
              Height = 22
              Style = csDropDownList
              TabOrder = 1
              OnEnter = cmbTabPreEnter
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object dbeDtaInicial: TMaskEditFocus
            Tag = 99
            Left = 90
            Top = 3
            Width = 70
            Height = 22
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object dbeDtaFinal: TMaskEditFocus
            Tag = 99
            Left = 188
            Top = 3
            Width = 70
            Height = 22
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtPerEst: TEditFocus
            Tag = 99
            Left = 673
            Top = 3
            Width = 62
            Height = 22
            Alignment = taRightJustify
            TabOrder = 2
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
          object edtPreCusCad: TEditFocus
            Tag = 99
            Left = 89
            Top = 285
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16770261
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ReadOnly = True
            ShowHint = False
            TabOrder = 28
            NormalColor = clWindow
            FocusColor = 16770261
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object btnInsPlaHelp: TBitBtnLocked
            Left = 713
            Top = 331
            Width = 21
            Height = 22
            Hint = 'Clique aqui para mais informa'#231#245'es sobre a promo'#231#227'o selecionada!'
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
            TabOrder = 41
            TabStop = False
            OnClick = btnInsPlaHelpClick
          end
          object cbxProdAtv: TComboBox
            Left = 444
            Top = 118
            Width = 70
            Height = 22
            Style = csDropDownList
            ItemIndex = 2
            TabOrder = 12
            Text = 'Todos'
            OnKeyDown = cbxCategoriaKeyDown
            Items.Strings = (
              'Sim'
              'N'#227'o'
              'Todos')
          end
          object cbxSldZero: TComboBox
            Left = 444
            Top = 187
            Width = 70
            Height = 22
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 17
            Text = 'Sim'
            OnKeyDown = cbxCategoriaKeyDown
            Items.Strings = (
              'Sim'
              'N'#227'o')
          end
          object cbxProAtvComp: TComboBox
            Left = 444
            Top = 141
            Width = 70
            Height = 22
            Style = csDropDownList
            ItemIndex = 2
            TabOrder = 14
            Text = 'Todos'
            OnKeyDown = cbxCategoriaKeyDown
            Items.Strings = (
              'Sim'
              'N'#227'o'
              'Todos')
          end
          object cbxImpList: TComboBox
            Left = 444
            Top = 95
            Width = 70
            Height = 22
            Style = csDropDownList
            ItemIndex = 2
            TabOrder = 10
            Text = 'Todos'
            OnKeyDown = cbxCategoriaKeyDown
            Items.Strings = (
              'Sim'
              'N'#227'o'
              'Todos')
          end
          object ckbSaldoZero: TCheckBox
            Left = 242
            Top = 234
            Width = 272
            Height = 14
            BiDiMode = bdRightToLeft
            Caption = 'Produtos nunca movimentados com saldo positivo'
            ParentBiDiMode = False
            TabOrder = 21
            OnClick = ckbSaldoZeroClick
          end
          object Panel3: TPanel
            Left = 516
            Top = 96
            Width = 219
            Height = 153
            BevelKind = bkSoft
            BevelOuter = bvSpace
            BevelWidth = 2
            BorderWidth = 1
            TabOrder = 22
            object Label38: TLabel
              Left = 2
              Top = 88
              Width = 39
              Height = 14
              Alignment = taRightJustify
              Caption = 'Per'#237'odo:'
            end
            object Label40: TLabel
              Left = 115
              Top = 88
              Width = 18
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'at'#233
            end
            object rdgGiroEstoq: TRadioGroup
              Left = 3
              Top = 3
              Width = 209
              Height = 79
              Align = alTop
              Caption = 'Giro do Estoque'
              ItemIndex = 0
              Items.Strings = (
                'N'#227'o considerar giro no filtro'
                'Sem Giro de Compras'
                'Sem Giro de Vendas'
                'Sem Giro de Compras e Vendas')
              TabOrder = 0
              OnClick = rdgGiroEstoqClick
            end
            object mskDtaGiroIni: TMaskEditFocus
              Tag = 99
              Left = 42
              Top = 84
              Width = 70
              Height = 22
              Enabled = False
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object mskDtaGiroFim: TMaskEditFocus
              Tag = 99
              Left = 136
              Top = 84
              Width = 70
              Height = 22
              Enabled = False
              EditMask = '99/99/9999;1;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 2
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object chkQtdLimiteSalDis: TCheckBox
              Left = 6
              Top = 109
              Width = 187
              Height = 14
              BiDiMode = bdLeftToRight
              Caption = 'Qtd. Limite = Saldo Dispon'#237'vel'
              Enabled = False
              ParentBiDiMode = False
              TabOrder = 3
            end
            object chkQtdMinimaSalDis: TCheckBox
              Left = 6
              Top = 125
              Width = 187
              Height = 14
              BiDiMode = bdLeftToRight
              Caption = 'Qtd. M'#237'nima = Saldo Dispon'#237'vel'
              Enabled = False
              ParentBiDiMode = False
              TabOrder = 4
            end
          end
          object edtCodDep: TEditFocus
            Tag = 99
            Left = 90
            Top = 72
            Width = 70
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
            TabOrder = 7
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
          object edtDesDep: TEditFocus
            Left = 161
            Top = 72
            Width = 190
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 46
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
            Left = 444
            Top = 72
            Width = 70
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
            TabOrder = 8
            OnExit = edtGruCmpExit
            OnKeyPress = edtGruCmpKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
          object edtDesCmp: TEditFocus
            Left = 515
            Top = 72
            Width = 220
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 47
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesPro: TEditFocus
            Tag = 99
            Left = 90
            Top = 164
            Width = 261
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
          object edtCliVen: TEditFocus
            Tag = 99
            Left = 444
            Top = 210
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 20
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = ',0.00'
          end
          object edtMarBru: TEditFocus
            Tag = 99
            Left = 89
            Top = 331
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 30
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object btnMargemProdutos: TBitBtnLocked
            Left = 7
            Top = 424
            Width = 215
            Height = 22
            Caption = 'Digitar Margem para Todos os Produtos'
            TabOrder = 45
            Visible = False
            OnClick = btnMargemProdutosClick
          end
          object ckbPrecoFixoParaTmqImo: TCheckBox
            Left = 167
            Top = 381
            Width = 234
            Height = 14
            BiDiMode = bdLeftToRight
            Caption = 'Pre'#231'o fixo para tinta de m'#225'quina (Imobili'#225'ria)'
            Enabled = False
            ParentBiDiMode = False
            TabOrder = 36
          end
        end
        object pnlRight: TPanel
          Left = 764
          Top = 1
          Width = 245
          Height = 448
          Align = alRight
          BevelOuter = bvNone
          Enabled = False
          ParentColor = True
          TabOrder = 1
          object pnlPrecos: TPanel
            Left = 0
            Top = 0
            Width = 245
            Height = 448
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pnlPrecos'
            ShowCaption = False
            TabOrder = 0
            object Label18: TLabel
              Left = 91
              Top = 10
              Width = 71
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Custo real:'
            end
            object lblMarg04: TLabel
              Left = 49
              Top = 170
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 4:'
            end
            object lblMarg01: TLabel
              Left = 49
              Top = 32
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 1:'
            end
            object lblMarg05: TLabel
              Left = 49
              Top = 216
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 5:'
            end
            object lblMarg02: TLabel
              Left = 49
              Top = 78
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 2:'
            end
            object lblMarg06: TLabel
              Left = 49
              Top = 262
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 6:'
            end
            object lblMarg03: TLabel
              Left = 49
              Top = 124
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 3:'
            end
            object lblMarg07: TLabel
              Left = 49
              Top = 308
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '% Margem L'#237'quida 7:'
            end
            object lblProm01: TLabel
              Left = 49
              Top = 55
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 1:'
            end
            object lblProm02: TLabel
              Left = 49
              Top = 101
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 2:'
            end
            object lblProm03: TLabel
              Left = 49
              Top = 147
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 3:'
            end
            object lblProm04: TLabel
              Left = 49
              Top = 193
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 4:'
            end
            object lblProm05: TLabel
              Left = 49
              Top = 239
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 5:'
            end
            object lblProm06: TLabel
              Left = 49
              Top = 285
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 6:'
            end
            object lblProm07: TLabel
              Left = 49
              Top = 331
              Width = 113
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Pr. Promoc'#227'o 7:'
            end
            object edtCusRea: TEditFocus
              Left = 168
              Top = 6
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
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
            object edtMarg04: TEditFocus
              Left = 168
              Top = 167
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtMarg01: TEditFocus
              Left = 168
              Top = 29
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtMarg05: TEditFocus
              Left = 168
              Top = 213
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtMarg02: TEditFocus
              Left = 168
              Top = 75
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
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
            object edtMarg06: TEditFocus
              Left = 168
              Top = 259
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 11
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtMarg03: TEditFocus
              Left = 168
              Top = 121
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtMarg07: TEditFocus
              Left = 168
              Top = 305
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 13
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtProm01: TEditFocus
              Left = 168
              Top = 52
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
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
            object edtProm02: TEditFocus
              Left = 168
              Top = 98
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
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
            object edtProm03: TEditFocus
              Left = 168
              Top = 144
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
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
            object edtProm04: TEditFocus
              Left = 168
              Top = 190
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtProm05: TEditFocus
              Left = 168
              Top = 236
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtProm06: TEditFocus
              Left = 168
              Top = 282
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 12
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtProm07: TEditFocus
              Left = 168
              Top = 328
              Width = 70
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 14
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
        end
        object pnlPrecoVendaReal: TPanel
          Left = 772
          Top = 257
          Width = 379
          Height = 179
          Align = alCustom
          BevelOuter = bvNone
          TabOrder = 2
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 379
            Height = 133
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object cxvFiltros: TcxVerticalGrid
              Left = 0
              Top = 0
              Width = 379
              Height = 96
              Margins.Left = 6
              Align = alTop
              LayoutStyle = ulsBandsView
              LookAndFeel.Kind = lfUltraFlat
              OptionsView.AutoScaleBands = False
              OptionsView.GridLineColor = clSilver
              OptionsView.RowHeaderWidth = 129
              OptionsView.RowHeight = 22
              OptionsView.ValueWidth = 250
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.GoToNextCellOnTab = True
              OptionsBehavior.RowTracking = False
              TabOrder = 0
              TabStop = False
              Version = 1
              object cxvFiltrosCabecalho: TcxCategoryRow
                Properties.Caption = 'Filtros para Calcular'
                Properties.HeaderAlignmentHorz = taCenter
                ID = 0
                ParentID = -1
                Index = 0
                Version = 1
              end
              object cxvFiltrosCodAbf: TcxEditorRow
                Properties.Caption = 'C'#243'digo Abr. Fiscal'
                Properties.EditPropertiesClassName = 'TcxTextEditProperties'
                Properties.EditProperties.CharCase = ecUpperCase
                Properties.EditProperties.MaxLength = 3
                Properties.EditProperties.ValidateOnEnter = True
                Properties.EditProperties.ValidationOptions = [evoShowErrorIcon]
                Properties.EditProperties.OnValidate = cxvFiltrosCodAbfEditPropertiesValidate
                Properties.DataBinding.ValueType = 'String'
                Properties.Value = ''
                ID = 1
                ParentID = -1
                Index = 1
                Version = 1
              end
              object cxvFiltrosPerAbf: TcxEditorRow
                Properties.Caption = 'Perfil Abr. Fiscal'
                Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
                Properties.EditProperties.ImmediatePost = True
                Properties.EditProperties.ImmediateUpdateText = True
                Properties.EditProperties.Items.Strings = (
                  'NCO - SAIDAS NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)'
                  'CCO - SAIDAS CONTRIBUINTE CONSUMIDOR'
                  'CNC - SAIDAS CONTRIBUINTE NAO CONSUMIDOR'
                  'SNA - SAIDAS SIMPLES NACIONAL'
                  'CTA - SAIDAS CONSTRUTORA / NAO CONTRIBUINTE COM INSC.ESTADUAL'
                  'PRU - SAIDAS PRODUTOR RURAL'
                  'IND - SAIDAS INDUSTRIA'
                  'TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS')
                Properties.DataBinding.ValueType = 'String'
                Properties.Value = ''
                ID = 2
                ParentID = -1
                Index = 2
                Version = 1
              end
              object cxvFiltrosEstado: TcxEditorRow
                Properties.Caption = 'Estado'
                Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
                Properties.EditProperties.CharCase = ecUpperCase
                Properties.EditProperties.ValidationOptions = [evoShowErrorIcon]
                Properties.DataBinding.ValueType = 'String'
                Properties.Value = Null
                ID = 3
                ParentID = -1
                Index = 3
                Version = 1
              end
            end
            object btnSimular: TBitBtnLocked
              Left = 291
              Top = 96
              Width = 88
              Height = 37
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alRight
              Caption = 'Simular'
              TabOrder = 1
              OnClick = btnSimularClick
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 133
            Width = 379
            Height = 46
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Label44: TLabel
              Left = 90
              Top = 0
              Width = 43
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor ST:'
            end
            object Label45: TLabel
              Left = 92
              Top = 17
              Width = 41
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor IPI:'
            end
            object Label46: TLabel
              Left = 31
              Top = 34
              Width = 102
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor Total de Venda:'
            end
            object lblValorST: TLabel
              Left = 177
              Top = 0
              Width = 21
              Height = 14
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblValorIPI: TLabel
              Left = 177
              Top = 17
              Width = 21
              Height = 14
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblValorTotalVenda: TLabel
              Left = 177
              Top = 34
              Width = 21
              Height = 14
              Alignment = taRightJustify
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
      object cxgItens: TcxGridCitel
        Left = 0
        Top = 450
        Width = 1010
        Height = 185
        Align = alClient
        TabOrder = 2
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensTableView: TcxGridDBBandedTableViewCitel
          OnKeyDown = cxgItensTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxgItensTableViewCellDblClick
          DataController.DataSource = dtsCadPro
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
          Bands = <
            item
              Caption = 'Produto'
              FixedKind = fkLeft
              Styles.Header = cxStyleTitulosColunas
            end
            item
            end
            item
              Caption = 'Promo'#231#227'o'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 1'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 2'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 3'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 4'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 5'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 6'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 7'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Valores do cadastro de produtos'
              Styles.Header = cxStyleTitulosColunas
            end
            item
              Caption = 'Comiss'#227'o'
              Styles.Header = cxStyleTitulosColunas
            end>
          Zebra = True
          Destaque = False
          DestacarRegistro = False
          CorZebra = clMoneyGreen
          object cxgItensIPR_CODITE: TcxGridDBBandedColumn
            Caption = 'C'#243'd. item'
            DataBinding.FieldName = 'IPR_CODITE'
            Styles.Header = cxStyleTitulosColunas
            Width = 70
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensITE_CODFAB: TcxGridDBBandedColumn
            Caption = 'C'#243'd. fab.'
            DataBinding.FieldName = 'ITE_CODFAB'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensITE_DESITE: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            Styles.Header = cxStyleTitulosColunas
            Width = 260
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensUNI_SIGUNI: TcxGridDBBandedColumn
            Caption = 'Un'
            DataBinding.FieldName = 'UNI_SIGUNI'
            Styles.Header = cxStyleTitulosColunas
            Width = 60
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensMAR_DESMAR: TcxGridDBBandedColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'MAR_DESMAR'
            Styles.Header = cxStyleTitulosColunas
            Width = 120
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensITE_SALDOS: TcxGridDBBandedColumn
            AlternateCaption = 'Saldo F'#237'sico'
            Caption = 'Saldo Fisico'
            DataBinding.FieldName = 'ITE_SALFIS'
            Styles.Header = cxStyleTitulosColunas
            Width = 74
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensITE_SALDIS: TcxGridDBBandedColumn
            Caption = 'Saldo Dispon'#237'vel'
            DataBinding.FieldName = 'ITE_SALDIS'
            Styles.Header = cxStyleTitulosColunas
            Width = 104
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_QTDLIM: TcxGridDBBandedColumn
            Caption = 'Qtd. limite'
            DataBinding.FieldName = 'IPR_QTDLIM'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_QTDMIN: TcxGridDBBandedColumn
            Caption = 'Qtd. M'#237'nima'
            DataBinding.FieldName = 'IPR_QTDMIN'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRZMED: TcxGridDBBandedColumn
            Caption = 'Prazo m'#233'dio'
            DataBinding.FieldName = 'IPR_PRZMED'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_PERDES: TcxGridDBBandedColumn
            Caption = '% Desconto'
            DataBinding.FieldName = 'IPR_PERDES'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSREA: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSREA'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBRU: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBRU'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLIQ: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLIQ'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVEN: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVEN'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_VENIMP: TcxGridDBBandedColumn
            Caption = 'Pr. Promo + Imp'
            DataBinding.FieldName = 'IPR_VENIMP'
            Styles.Header = cxStyleTitulosColunas
            Width = 105
            Position.BandIndex = 3
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS1: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE1: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR1: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ1: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE1: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS2: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE2: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR2: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ2: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE2: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS3: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE3: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR3: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ3: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE3: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS4: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE4: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR4: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ4: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE4: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS5: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE5: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR5: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ5: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE5: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS6: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE6: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR6: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ6: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE6: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPR_PRECUS7: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPR_PRECUS7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_CUSRE7: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPR_CUSRE7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARBR7: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPR_MARBR7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_MARLQ7: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPR_MARLQ7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_PREVE7: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPR_PREVE7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensITE_PRECUS: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'ITE_PRECUS'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_BOCCAI: TcxGridDBBandedColumn
            Caption = 'Boca de Caixa'
            DataBinding.FieldName = 'IPR_BOCCAI'
            Styles.Header = cxStyleTitulosColunas
            Width = 85
            Position.BandIndex = 11
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_ICMSAI: TcxGridDBBandedColumn
            Caption = 'Icms de Sa'#237'da'
            DataBinding.FieldName = 'IPR_ICMSAI'
            Styles.Header = cxStyleTitulosColunas
            Width = 90
            Position.BandIndex = 11
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPR_IMPFED: TcxGridDBBandedColumn
            Caption = 'Imp. Federais'
            DataBinding.FieldName = 'IPR_IMPFED'
            Styles.Header = cxStyleTitulosColunas
            Width = 88
            Position.BandIndex = 11
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPR_DESOPE: TcxGridDBBandedColumn
            Caption = 'Desp. Operacionais'
            DataBinding.FieldName = 'IPR_DESOPE'
            Styles.Header = cxStyleTitulosColunas
            Width = 118
            Position.BandIndex = 11
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensITE_CUSREA: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'ITE_CUSREA'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR1: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 1'
            DataBinding.FieldName = 'ITE_MARBR1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ1: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 1'
            DataBinding.FieldName = 'ITE_MARLQ1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE1: TcxGridDBBandedColumn
            Caption = 'Pr. venda 1'
            DataBinding.FieldName = 'ITE_PREVE1'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR2: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 2'
            DataBinding.FieldName = 'ITE_MARBR2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ2: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 2'
            DataBinding.FieldName = 'ITE_MARLQ2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE2: TcxGridDBBandedColumn
            Caption = 'Pr. venda 2'
            DataBinding.FieldName = 'ITE_PREVE2'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR3: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 3'
            DataBinding.FieldName = 'ITE_MARBR3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 12
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ3: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 3'
            DataBinding.FieldName = 'ITE_MARLQ3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 13
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE3: TcxGridDBBandedColumn
            Caption = 'Pr. venda 3'
            DataBinding.FieldName = 'ITE_PREVE3'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 14
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR4: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 4'
            DataBinding.FieldName = 'ITE_MARBR4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 15
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ4: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 4'
            DataBinding.FieldName = 'ITE_MARLQ4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 16
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE4: TcxGridDBBandedColumn
            Caption = 'Pr. venda 4'
            DataBinding.FieldName = 'ITE_PREVE4'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 17
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR5: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 5'
            DataBinding.FieldName = 'ITE_MARBR5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 18
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ5: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 5'
            DataBinding.FieldName = 'ITE_MARLQ5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 19
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE5: TcxGridDBBandedColumn
            Caption = 'Pr. venda 5'
            DataBinding.FieldName = 'ITE_PREVE5'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 20
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR6: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 6'
            DataBinding.FieldName = 'ITE_MARBR6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 21
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ6: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 6'
            DataBinding.FieldName = 'ITE_MARLQ6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 22
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE6: TcxGridDBBandedColumn
            Caption = 'Pr. venda 6'
            DataBinding.FieldName = 'ITE_PREVE6'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 23
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR7: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 7'
            DataBinding.FieldName = 'ITE_MARBR7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 24
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ7: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 7'
            DataBinding.FieldName = 'ITE_MARLQ7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 25
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE7: TcxGridDBBandedColumn
            Caption = 'Pr. venda 7'
            DataBinding.FieldName = 'ITE_PREVE7'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 26
            Position.RowIndex = 0
          end
          object cxgItensITE_PREMED: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o M'#233'dio'
            DataBinding.FieldName = 'ITE_PREMED'
            Styles.Header = cxStyleTitulosColunas
            Width = 74
            Position.BandIndex = 11
            Position.ColIndex = 27
            Position.RowIndex = 0
          end
          object cxgItensITE_PREULT: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o '#218'lt.Compra'
            DataBinding.FieldName = 'ITE_PREULT'
            Styles.Header = cxStyleTitulosColunas
            Width = 103
            Position.BandIndex = 11
            Position.ColIndex = 28
            Position.RowIndex = 0
          end
          object cxgItensITE_IMPULT: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o '#218'lt.Compra+Imp.'
            DataBinding.FieldName = 'ITE_IMPULT'
            Styles.Header = cxStyleTitulosColunas
            Width = 138
            Position.BandIndex = 11
            Position.ColIndex = 29
            Position.RowIndex = 0
          end
          object cxgItensIPR_COMVAR: TcxGridDBBandedColumn
            Caption = 'Com. V.I.'
            DataBinding.FieldName = 'IPR_COMVAR'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 12
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPR_COMATA: TcxGridDBBandedColumn
            Caption = 'Com. V.E.'
            DataBinding.FieldName = 'IPR_COMATA'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 12
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPR_COMDIS: TcxGridDBBandedColumn
            Caption = 'Com. dist.'
            DataBinding.FieldName = 'IPR_COMDIS'
            Styles.Header = cxStyleTitulosColunas
            Width = 80
            Position.BandIndex = 12
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
        end
        object cxgItenslevel: TcxGridLevel
          GridView = cxgItensTableView
        end
      end
    end
    object tsKitParaPromocao: TTabSheet
      Caption = '2 - Kits Para Promo'#231#227'o'
      ImageIndex = 3
      object Panel1: TPanel
        Left = 0
        Top = 139
        Width = 1010
        Height = 110
        Align = alTop
        TabOrder = 2
        object Label24: TLabel
          Left = 37
          Top = 23
          Width = 104
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo Gatilho:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label25: TLabel
          Left = 418
          Top = 23
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 544
          Top = 23
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd.M'#237'nima:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 668
          Top = 23
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = '% Desconto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 13
          Top = 51
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo Beneficiado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 419
          Top = 51
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label31: TLabel
          Left = 669
          Top = 51
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = '% Desconto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label32: TLabel
          Left = 58
          Top = 80
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Brinde:'
        end
        object Label33: TLabel
          Left = 541
          Top = 80
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
        object Label34: TLabel
          Left = 544
          Top = 51
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd.M'#237'nima:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtGrupoGatilhoParaKit: TMaskEditFocus
          Tag = 99
          Left = 146
          Top = 20
          Width = 69
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
          OnExit = edtGrupoGatilhoParaKitExit
          OnKeyPress = edtGrupoGatilhoParaKitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtGrupoGatilhoDescParaKit: TEditFocus
          Left = 217
          Top = 20
          Width = 193
          Height = 22
          TabStop = False
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
        object edtUnidadeGatilhoParaKit: TEditFocus
          Tag = 99
          Left = 500
          Top = 20
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 2
          OnKeyPress = edtUnidadeGatilhoParaKitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtQuantidadeGatilhoParaKit: TEditFocus
          Tag = 99
          Left = 600
          Top = 20
          Width = 64
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = ',0.00'
        end
        object edtPercentualDescontoGatilhoParaKit: TEditFocus
          Tag = 99
          Left = 733
          Top = 20
          Width = 64
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = ',0.00'
        end
        object btnAdicionarGatilho: TBitBtnLocked
          Left = 673
          Top = 76
          Width = 124
          Height = 22
          Caption = '&Adicionar Produtos'
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
          TabOrder = 11
          OnClick = btnAdicionarGatilhoClick
        end
        object edtGrupoBeneficiadoParaKit: TMaskEditFocus
          Tag = 99
          Left = 146
          Top = 48
          Width = 70
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
          TabOrder = 5
          Text = ''
          OnExit = edtGrupoGatilhoParaKitExit
          OnKeyPress = edtGrupoGatilhoParaKitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtGrupoBeneficiadoDescParaKit: TEditFocus
          Left = 217
          Top = 48
          Width = 194
          Height = 22
          TabStop = False
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
        object edtUnidadeBeneficiadoParaKit: TEditFocus
          Tag = 99
          Left = 500
          Top = 48
          Width = 36
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 6
          OnKeyPress = edtUnidadeGatilhoParaKitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPercentualDescontoBeneficiadoParaKit: TEditFocus
          Tag = 99
          Left = 733
          Top = 48
          Width = 65
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = ',0.00'
        end
        object edtBrindeParaKit: TEditFocus
          Tag = 99
          Left = 146
          Top = 76
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 9
          OnExit = edtBrindeParaKitExit
          OnKeyPress = edtBrindeParaKitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtBrindeDescParaKit: TEditFocus
          Left = 217
          Top = 76
          Width = 318
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 13
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtQuantidadeBrindeParaKit: TEditFocus
          Tag = 99
          Left = 600
          Top = 76
          Width = 64
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = ',0.00'
        end
        object edtQuantidadeBeneficiadoParaKit: TEditFocus
          Tag = 99
          Left = 600
          Top = 48
          Width = 64
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = ',0.00'
        end
      end
      object grdKitProdutoGatilho: TcxGridCitel
        Left = 0
        Top = 249
        Width = 1010
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdDBKitProdutoGatilho: TcxGridDBBandedTableViewCitel
          OnKeyDown = grdDBKitProdutoGatilhoKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsProdutoGatilho
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Bands = <
            item
              Caption = 'Produtos Gatilhos'
              Width = 687
            end>
          Zebra = True
          Destaque = True
          DestacarRegistro = True
          CorZebra = clMoneyGreen
          object DET_DESGRU: TcxGridDBBandedColumn
            Caption = 'Linha/Grupo'
            DataBinding.FieldName = 'DET_DESGRU'
            Options.Focusing = False
            Width = 377
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object DET_CODUNI: TcxGridDBBandedColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'DET_CODUNI'
            Options.Focusing = False
            Width = 115
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object DET_QTDGRU: TcxGridDBBandedColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'DET_QTDGRU'
            Options.Focusing = False
            Width = 92
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object DET_PERDES: TcxGridDBBandedColumn
            Caption = '% Desconto'
            DataBinding.FieldName = 'DET_PERDES'
            Options.Focusing = False
            Width = 72
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = grdDBKitProdutoGatilho
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 49
        Align = alTop
        TabOrder = 0
        object Label30: TLabel
          Left = 21
          Top = 15
          Width = 82
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o do Kit:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDescricaoKit: TEditFocus
          Tag = 99
          Left = 107
          Top = 12
          Width = 306
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
          MaxLength = 100
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtUnidadeGatilhoParaKitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAdicionarKit: TBitBtnLocked
          Left = 419
          Top = 12
          Width = 109
          Height = 22
          Caption = '&Adicionar Kit'
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
          TabOrder = 1
          OnClick = btnAdicionarKitClick
        end
      end
      object grdKit: TcxGridCitel
        Left = 0
        Top = 49
        Width = 1010
        Height = 90
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdDBKit: TcxGridDBBandedTableViewCitel
          OnKeyDown = grdDBKitKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsKits
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Bands = <
            item
              Caption = 'kits Para Promo'#231#227'o'
              Width = 687
            end>
          Zebra = True
          Destaque = True
          DestacarRegistro = True
          CorZebra = clMoneyGreen
          object KIT_DESCRI: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'KIT_DESCRI'
            Options.Focusing = False
            Width = 377
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
        end
        object cxGridLevel3: TcxGridLevel
          GridView = grdDBKit
        end
      end
      object grdKitBrinde: TcxGridCitel
        Left = 0
        Top = 489
        Width = 1010
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdDBKitBrinde: TcxGridDBBandedTableViewCitel
          OnKeyDown = grdDBKitBrindeKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsBrinde
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Bands = <
            item
              Caption = 'Brindes'
              Width = 687
            end>
          Zebra = True
          Destaque = True
          DestacarRegistro = True
          CorZebra = clMoneyGreen
          object cxGridDBBandedColumn1: TcxGridDBBandedColumn
            Caption = 'Brinde'
            DataBinding.FieldName = 'BRI_DESITE'
            Options.Focusing = False
            Width = 377
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn2: TcxGridDBBandedColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'BRI_QTDBRI'
            Options.Focusing = False
            Width = 115
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = grdDBKitBrinde
        end
      end
      object cxGridCitel2: TcxGridCitel
        Left = 0
        Top = 369
        Width = 1010
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 5
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBBandedTableViewCitel2: TcxGridDBBandedTableViewCitel
          OnKeyDown = grdDBKitProdutoBeneficiadoKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsProdutoBeneficiado
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Bands = <
            item
              Caption = 'Produtos Beneficiados'
              Width = 687
            end>
          Zebra = True
          Destaque = True
          DestacarRegistro = True
          CorZebra = clMoneyGreen
          object cxGridDBBandedColumn3: TcxGridDBBandedColumn
            Caption = 'Linha/Grupo'
            DataBinding.FieldName = 'DET_DESGRU'
            Options.Focusing = False
            Width = 394
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn5: TcxGridDBBandedColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'DET_CODUNI'
            Options.Focusing = False
            Width = 117
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableViewCitel2Column1: TcxGridDBBandedColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'DET_QTDGRU'
            Width = 83
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn6: TcxGridDBBandedColumn
            Caption = '% Desconto'
            DataBinding.FieldName = 'DET_PERDES'
            Options.Focusing = False
            Width = 93
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
        end
        object cxGridLevel4: TcxGridLevel
          GridView = cxGridDBBandedTableViewCitel2
        end
      end
    end
    object tbsClientes: TTabSheet
      Caption = '&3- Clientes da Promo'#231#227'o'
      ImageIndex = 1
      object cxgClientes: TcxGridCitel
        Left = 0
        Top = 226
        Width = 1010
        Height = 412
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgClientesDBTableView1: TcxGridDBTableViewCitel
          OnKeyDown = cxgClientesDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsProCli
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = True
          CorZebra = clMoneyGreen
          object cxgClientesDBTableView1Column1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'PRO_CODCLI'
            Width = 66
          end
          object cxgClientesDBTableView1Column2: TcxGridDBColumn
            Caption = 'Nome do Cliente'
            DataBinding.FieldName = 'PRO_NOMCLI'
            Width = 250
          end
          object cxgClientesDBTableView1Column5: TcxGridDBColumn
            Caption = 'CNPJ / CPF'
            DataBinding.FieldName = 'PRO_CPFMAS'
          end
          object cxgClientesDBTableView1Column4: TcxGridDBColumn
            Caption = 'Cidade / Estado'
            DataBinding.FieldName = 'PRO_CIDEST'
            Width = 206
          end
          object cxgClientesDBTableView1Column3: TcxGridDBColumn
            Caption = 'Atividade'
            DataBinding.FieldName = 'PRO_ATIVID'
            Width = 150
          end
          object cxgClientesDBTableView1Column6: TcxGridDBColumn
            Caption = 'Categoria'
            DataBinding.FieldName = 'PRO_CATEGO'
            Width = 90
          end
        end
        object cxgClientesLevel1: TcxGridLevel
          GridView = cxgClientesDBTableView1
        end
      end
      object pnlPesqCli: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 226
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl3: TLabel
          Left = 56
          Top = 17
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl4: TLabel
          Left = 43
          Top = 40
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 55
          Top = 63
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 500
          Top = 63
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl7: TLabel
          Left = 3
          Top = 202
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
        end
        object lblCategoria: TLabel
          Left = 352
          Top = 202
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Categoria:'
        end
        object lbl9: TLabel
          Left = 55
          Top = 86
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regi'#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl10: TLabel
          Left = 32
          Top = 109
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sub-Regi'#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl11: TLabel
          Left = 19
          Top = 132
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Rede de Lojas:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl12: TLabel
          Left = 6
          Top = 155
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Canal de Acesso:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label43: TLabel
          Left = 41
          Top = 178
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 94
          Top = 13
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentShowHint = False
          ShowHint = True
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
          Left = 160
          Top = 13
          Width = 443
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodAti: TEditFocus
          Tag = 99
          Left = 94
          Top = 36
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnExit = edtCodAtiExit
          OnKeyPress = edtCodAtiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesAti: TEditFocus
          Left = 160
          Top = 36
          Width = 443
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
        object edtCodCid: TEditFocus
          Tag = 99
          Left = 94
          Top = 59
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnExit = edtCodCidExit
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCid: TEditFocus
          Left = 160
          Top = 59
          Width = 285
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
        object edtEstado: TEditFocus
          Tag = 99
          Left = 538
          Top = 59
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtCgcCpf: TEditFocus
          Tag = 99
          Left = 94
          Top = 198
          Width = 35
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          Text = '1'
          OnChange = edtCgcCpfChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 1
          TipoTexto = ttNumerico
        end
        object edtNuCnPj: TMaskEditFocus
          Left = 131
          Top = 198
          Width = 208
          Height = 22
          ReadOnly = True
          TabOrder = 18
          Text = ''
          OnEnter = edtNuCnPjEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnIncCli: TBitBtnLocked
          Left = 451
          Top = 198
          Width = 74
          Height = 22
          Caption = 'C&onfirmar'
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
          TabOrder = 20
          OnClick = btnIncCliClick
        end
        object btnCancelCli: TBitBtnLocked
          Left = 529
          Top = 198
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
          TabOrder = 21
          OnClick = btnCancelCliClick
        end
        object cbxCategoria: TComboBox
          Left = 406
          Top = 198
          Width = 39
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 19
          OnKeyDown = cbxCategoriaKeyDown
        end
        object edtCodReg: TEditFocus
          Tag = 99
          Left = 94
          Top = 82
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnExit = edtCodRegExit
          OnKeyPress = edtCodRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesReg: TEditFocus
          Left = 160
          Top = 82
          Width = 443
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
        object edtCodSub: TEditFocus
          Tag = 99
          Left = 94
          Top = 105
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnExit = edtCodSubExit
          OnKeyPress = edtCodSubKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesSub: TEditFocus
          Left = 160
          Top = 105
          Width = 443
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodRed: TEditFocus
          Tag = 99
          Left = 94
          Top = 128
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
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
          Left = 160
          Top = 128
          Width = 443
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 12
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodCac: TEditFocus
          Tag = 99
          Left = 94
          Top = 151
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          OnExit = edtCodCacExit
          OnKeyPress = edtCodCacKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCac: TEditFocus
          Left = 160
          Top = 151
          Width = 443
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 14
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodVen: TEditFocus
          Tag = 99
          Left = 94
          Top = 174
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentShowHint = False
          PopupMenu = frmPai.mnuAuxiliar
          ShowHint = True
          TabOrder = 15
          OnExit = edtCodVenExit
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtNomVen: TEditFocus
          Left = 160
          Top = 174
          Width = 443
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 16
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object rdgTipoCliente: TRadioGroup
          Left = 609
          Top = 17
          Width = 185
          Height = 64
          Enabled = False
          Items.Strings = (
            'Pessoa Jur'#237'dica'
            'Pessoa F'#237'sica')
          TabOrder = 22
        end
        object ckbTipoCliente: TCheckBox
          Left = 609
          Top = 12
          Width = 143
          Height = 17
          Caption = 'Definir por Tipo de Cliente'
          TabOrder = 23
          OnClick = ckbTipoClienteClick
        end
      end
      object pnlImportarClientesDaPromocao: TPanel
        Left = 0
        Top = 638
        Width = 1010
        Height = 25
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object btnImportarClientesDaPromocao: TBitBtnLocked
          Left = 0
          Top = 1
          Width = 177
          Height = 25
          Caption = 'Importar Clientes'
          Enabled = False
          TabOrder = 0
          OnClick = btnImportarClientesDaPromocaoClick
        end
      end
    end
    object tbsCondPagto: TTabSheet
      Caption = '&4 - Condi'#231#245'es de Pagto.'
      ImageIndex = 3
      object pnlCndPag: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 73
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblCndPag: TLabel
          Left = 99
          Top = 16
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cond. Pagto:'
        end
        object ColorLabel2: TColorLabel
          Left = 202
          Top = 41
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
        object lblJurRem: TLabel
          Left = 10
          Top = 41
          Width = 148
          Height = 14
          Alignment = taRightJustify
          Caption = 'Aplicar Juros Remanescentes:'
        end
        object edtCodCnd: TEditFocus
          Tag = 99
          Left = 162
          Top = 13
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnExit = edtCodCndExit
          OnKeyPress = edtCodCndKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object btnIncCndPag: TBitBtnLocked
          Left = 523
          Top = 38
          Width = 74
          Height = 22
          Caption = 'C&onfirmar'
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
          OnClick = btnIncCndPagClick
        end
        object btnCancelCndPag: TBitBtnLocked
          Left = 601
          Top = 38
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
          TabOrder = 3
          OnClick = btnCancelCndPagClick
        end
        object edtDesCnd: TEditFocus
          Left = 232
          Top = 13
          Width = 443
          Height = 22
          HelpType = htKeyword
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtJurRem: TEditFocus
          Tag = 99
          Left = 162
          Top = 38
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 1
          Text = 'S'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
      end
      object FlowPanel1: TFlowPanel
        Left = 0
        Top = 635
        Width = 1010
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 2
        object btnIncluirTodasCndPag: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Incluir todas as condi'#231#245'es de pagamento'
          Enabled = False
          TabOrder = 0
          OnClick = btnIncluirTodasCndPagClick
        end
        object btnExcluirTodasCndPag: TBitBtnLocked
          Left = 218
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Excluir todas as condi'#231#245'es de pagamento'
          Enabled = False
          TabOrder = 1
          OnClick = btnExcluirTodasCndPagClick
        end
      end
      object cxgCndPag: TcxGridCitel
        Left = 0
        Top = 73
        Width = 1010
        Height = 562
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCndPagTableView: TcxGridDBTableViewCitel
          OnKeyDown = cxgCndPagTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxgCndPagTableViewCellDblClick
          DataController.DataSource = dtsCndPag
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgCndPagTableViewCODCND: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODCND'
          end
          object cxgCndPagTableViewDESCND: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCND'
            Width = 280
          end
          object cxgCndPagTableViewCNDPAG: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CNDPAG'
            Width = 400
          end
          object cxgCndPagTableViewJURREM: TcxGridDBColumn
            Caption = 
              'Aplicar Juros Remanescentes sobre os dias que ultrapassarem o pr' +
              'azo m'#233'dio'
            DataBinding.FieldName = 'JURREM'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 210
          end
        end
        object cxgCndPagLevel: TcxGridLevel
          GridView = cxgCndPagTableView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 964
    Top = 484
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 932
    Top = 484
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 932
    Top = 388
  end
  object dtsCadPro: TDataSource
    Left = 964
    Top = 452
  end
  object dtsCadPromocoes: TDataSource
    OnStateChange = dtsCadPromocoesStateChange
    OnDataChange = dtsCadPromocoesDataChange
    Left = 932
    Top = 516
  end
  object cdsCndPag: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 964
    Top = 553
    object cdsCndPagCODCND: TStringField
      FieldName = 'CODCND'
      Size = 10
    end
    object cdsCndPagCNDPAG: TStringField
      FieldName = 'CNDPAG'
      Size = 100
    end
    object cdsCndPagDESCND: TStringField
      FieldName = 'DESCND'
      Size = 50
    end
    object cdsCndPagJURREM: TStringField
      FieldName = 'JURREM'
      Size = 1
    end
  end
  object qryProCli: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 964
    Top = 388
  end
  object dspProCli: TUniDataSetProvider
    DataSet = qryProCli
    Options = []
    Left = 788
    Top = 324
  end
  object cdsProCli: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PRO_NOMCLI'
    Params = <>
    ProviderName = 'dspProCli'
    OnCalcFields = cdsProCliCalcFields
    Left = 836
    Top = 324
    object cdsProCliPRO_CODCLI: TStringField
      FieldName = 'PRO_CODCLI'
    end
    object cdsProCliPRO_SEQGER: TStringField
      FieldName = 'PRO_SEQGER'
    end
    object cdsProCliPRO_NOMCLI: TStringField
      FieldName = 'PRO_NOMCLI'
      ProviderFlags = []
    end
    object cdsProCliPRO_ATIVID: TStringField
      FieldName = 'PRO_ATIVID'
      Size = 70
    end
    object cdsProCliPRO_CIDEST: TStringField
      FieldName = 'PRO_CIDEST'
      Size = 40
    end
    object cdsProCliPRO_CGCCPF: TStringField
      FieldName = 'PRO_CGCCPF'
      Size = 18
    end
    object cdsProCliPRO_CPFMAS: TStringField
      FieldKind = fkCalculated
      FieldName = 'PRO_CPFMAS'
      Size = 18
      Calculated = True
    end
    object cdsProCliPRO_CATEGO: TStringField
      FieldName = 'PRO_CATEGO'
      Size = 1
    end
  end
  object dtsProCli: TDataSource
    DataSet = cdsProCli
    Left = 932
    Top = 452
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 1044
    Top = 260
    PixelsPerInch = 96
    object cxStyleTitulosColunas: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object OpenFile: TOpenDialog
    DefaultExt = '.xls'
    Filter = 'Excel (*.xls)|*.xls|Excel 2007+ (*.xlsx)|*.xlsx'
    Title = 'Selecione o arquivo'
    Left = 960
    Top = 594
  end
  object dtsCndPag: TDataSource
    DataSet = cdsCndPag
    Left = 928
    Top = 552
  end
  object dtsProdutoGatilho: TDataSource
    Left = 954
    Top = 99
  end
  object dtsProdutoBeneficiado: TDataSource
    Left = 954
    Top = 147
  end
  object dtsBrinde: TDataSource
    Left = 954
    Top = 195
  end
  object dtsKits: TDataSource
    Left = 954
    Top = 43
  end
  object popOpSele: TPopupMenu
    Left = 687
    Top = 96
    object mnuMarcaTodos: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = mnuMarcaTodosClick
    end
    object mnuDesmarcaTodos: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = mnuDesmarcaTodosClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuInverterSelecao: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = mnuInverterSelecaoClick
    end
  end
end
