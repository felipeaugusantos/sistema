inherited frmEntConferPreNota: TfrmEntConferPreNota
  Left = 195
  Top = 179
  Width = 1205
  Height = 710
  Caption = 'Confer'#234'ncia de Entrada de Mercadorias (Pr'#233'-Nota)'
  WindowState = wsMaximized
  ExplicitWidth = 1205
  ExplicitHeight = 710
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 300
    Width = 1189
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    Color = clYellow
    ParentColor = False
    ExplicitTop = 301
    ExplicitWidth = 1008
  end
  inherited pnlBotoes: TPanel
    Top = 604
    Width = 1189
    Height = 51
    ExplicitTop = 604
    ExplicitWidth = 1189
    ExplicitHeight = 51
    DesignSize = (
      1189
      51)
    inherited FlwBotoes: TFlowPanel
      Width = 1185
      Height = 47
      ExplicitWidth = 1185
      ExplicitHeight = 47
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 134
        ExplicitWidth = 134
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 134
        Width = 134
        ExplicitLeft = 134
        ExplicitWidth = 134
      end
      object btnConfirma: TBitBtnLocked
        Left = 268
        Top = 0
        Width = 134
        Height = 22
        Caption = 'Finaliza [F10]'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnQuantidade: TBitBtnLocked
        Left = 402
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F6] Quantidade'
        TabOrder = 3
        OnClick = btnQuantidadeClick
      end
      object btnQtdEti: TBitBtnLocked
        Left = 536
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F7] Qtd. Etiquetas '
        TabOrder = 4
        OnClick = btnQtdEtiClick
      end
      object btnEtiPro: TBitBtnLocked
        Left = 670
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F8] Etiq. Produtos'
        TabOrder = 5
        OnClick = btnEtiProClick
      end
      object btnCriticas: TBitBtnLocked
        Left = 804
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F9] Rel. Cr'#237'ticas'
        TabOrder = 6
        OnClick = btnCriticasClick
      end
      object btnBalanca: TBitBtnLocked
        Left = 938
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F4] Pesar Produto'
        TabOrder = 7
        Visible = False
        OnClick = btnBalancaClick
      end
      object btnAtualizar: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 134
        Height = 22
        Caption = '[F2] Atualizar'
        TabOrder = 8
        OnClick = btnAtualizarClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 134
        Top = 22
        Width = 134
        Height = 22
        Caption = '&Excluir Item'
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
        TabOrder = 9
        OnClick = btnExcluirClick
      end
      object btnDigCodBarLocFis: TBitBtnLocked
        Left = 268
        Top = 22
        Width = 134
        Height = 22
        Caption = '[F12] Digita'#231#227'o C'#243'd. Bar.'
        TabOrder = 10
        OnClick = btnDigCodBarLocFisClick
      end
      object btnCadSem: TBitBtnLocked
        Left = 402
        Top = 22
        Width = 134
        Height = 22
        Caption = '[F11] Cad.Semelhan'#231'a'
        TabOrder = 11
        OnClick = btnCadSemClick
      end
      object btnImpColetor: TBitBtnLocked
        Left = 536
        Top = 22
        Width = 134
        Height = 22
        Caption = '[ Alt + F9 ] Importar Coletor'
        TabOrder = 12
        OnClick = btnImpColetorClick
      end
      object btnExcluirItensIncons: TBitBtnLocked
        Left = 670
        Top = 22
        Width = 187
        Height = 22
        Caption = '&Excluir itens com inconsist'#234'ncias'
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
        TabOrder = 13
        WordWrap = True
        OnClick = btnExcluirItensInconsClick
      end
      object btnLimparConferencia: TBitBtnLocked
        Left = 857
        Top = 22
        Width = 132
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Limpar confer'#234'ncia'
        TabOrder = 14
        OnClick = btnLimparConferenciaClick
      end
      object btnLiberarEnderecamento: TBitBtnLocked
        Left = 989
        Top = 22
        Width = 147
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Liberar Endere'#231'amento'
        TabOrder = 15
        Visible = False
        OnClick = btnLiberarEnderecamentoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1104
      Top = 24
      Width = 82
      Caption = '&Cancelar'
      ExplicitLeft = 1104
      ExplicitTop = 24
      ExplicitWidth = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 1189
    ExplicitTop = 655
    ExplicitWidth = 1189
    inherited pnlNomeForm: TPanel
      Left = 1018
      ExplicitLeft = 1018
    end
    inherited pnlInfo: TPanel
      Width = 1018
      ExplicitWidth = 1018
    end
  end
  inherited pnlHeader: TPanel
    Width = 1189
    Height = 71
    ExplicitWidth = 1189
    ExplicitHeight = 71
    object lblNotEle: TLabel
      Left = 8
      Top = 14
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nota Eletr'#244'nica:'
    end
    object Label5: TLabel
      Left = 24
      Top = 38
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblCodCfr: TLabel
      Left = 578
      Top = 13
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conferente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblAgeRec: TLabel
      Left = 578
      Top = 34
      Width = 193
      Height = 14
      Caption = 'C'#243'digo do Plano de Recebimento: 00000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtNotEle: TEditFocus
      Left = 128
      Top = 6
      Width = 444
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
    object edtCodFor: TEditFocus
      Left = 87
      Top = 30
      Width = 485
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
    object btnNotEle: TBitBtnLocked
      Left = 86
      Top = 5
      Width = 41
      Height = 24
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
      TabOrder = 0
      OnClick = btnNotEleClick
      OnEnter = btnNotEleEnter
    end
    object chkMosEmb: TCheckBox
      Left = 88
      Top = 53
      Width = 484
      Height = 17
      Caption = 
        'Mostrar quantidade confererida em embalagens (Embalagem Principa' +
        'l de Compra) '
      TabOrder = 3
      OnClick = chkMosEmbClick
    end
    object edtCodCfr: TEditFocus
      Tag = 99
      Left = 634
      Top = 7
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCfr: TEditFocus
      Left = 684
      Top = 7
      Width = 122
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
  end
  inherited pnlTail: TPanel
    Top = 528
    Width = 1189
    Height = 76
    Enabled = False
    Visible = True
    ExplicitTop = 528
    ExplicitWidth = 1189
    ExplicitHeight = 76
    object Label2: TLabel
      Left = 414
      Top = 14
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 590
      Top = 13
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object Label1: TLabel
      Left = 414
      Top = 42
      Width = 105
      Height = 14
      Caption = 'Quantidade etiquetas:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 452
      Top = 6
      Width = 122
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 2
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
      Left = 653
      Top = 6
      Width = 87
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 3
      Text = '1,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 524
      Top = 34
      Width = 50
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 4
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object rdbCodFab: TRadioButton
      Left = 3
      Top = 40
      Width = 113
      Height = 14
      Caption = 'C'#243'digo da F'#225'brica'
      TabOrder = 1
      OnClick = rdbCodBarClick
    end
    object rdbCodBar: TRadioButton
      Left = 3
      Top = 12
      Width = 172
      Height = 14
      Caption = 'C'#243'digo de Barras'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbCodBarClick
    end
    object chkImprimeEtiqueta: TCheckBox
      Left = 582
      Top = 39
      Width = 158
      Height = 17
      Caption = 'Imprimir Etiqueta do Produto'
      TabOrder = 5
      OnClick = chkImprimeEtiquetaClick
    end
    object Panel1: TPanel
      Left = 112
      Top = 6
      Width = 293
      Height = 50
      BevelOuter = bvNone
      BorderStyle = bsSingle
      ParentColor = True
      TabOrder = 6
      object spbEtiqueta: TSpeedButton
        Left = 0
        Top = 0
        Width = 289
        Height = 21
        Align = alTop
        Caption = 'Pressione [ F1 ] Selecionar a etiqueta do produto'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = spbEtiquetaClick
      end
      object lblEtiqueta: TLabel
        Left = 0
        Top = 21
        Width = 289
        Height = 25
        Align = alClient
        Alignment = taCenter
        Caption = 'Etiqueta n'#227'o selecionada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 136
        ExplicitHeight = 14
      end
    end
    object pnlImgPro: TPanel
      Left = 893
      Top = 5
      Width = 107
      Height = 67
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 7
      object imgPro: TImage
        Left = 4
        Top = 4
        Width = 95
        Height = 55
        Align = alClient
        Center = True
        IncrementalDisplay = True
        Proportional = True
        Stretch = True
        OnDblClick = imgProDblClick
        ExplicitLeft = -52
        ExplicitTop = -36
      end
      object lblErrImg: TLabel
        Left = 4
        Top = 4
        Width = 95
        Height = 55
        Align = alClient
        Alignment = taCenter
        Caption = 
          'N'#227'o foi poss'#237'vel carregar a imagem do produto. Verifique o forma' +
          'to do arquivo!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
        ExplicitWidth = 94
        ExplicitHeight = 48
      end
    end
    object pnlLegendaConferencia: TPanel
      Left = 1029
      Top = 5
      Width = 428
      Height = 67
      BevelOuter = bvNone
      BorderWidth = 2
      Color = 16770261
      ParentBackground = False
      TabOrder = 8
      object lblLegNaoLocalizado: TLabel
        Left = 84
        Top = 32
        Width = 198
        Height = 14
        Caption = 'Quantidade conferida '#233' diferente da nota'
        Color = clBlack
        ParentColor = False
      end
      object shpRed: TShape
        Left = 51
        Top = 31
        Width = 17
        Height = 17
        Brush.Color = clRed
        Pen.Style = psClear
      end
      object lblConfOK: TLabel
        Left = 84
        Top = 11
        Width = 186
        Height = 14
        Caption = 'Quantidade conferida '#233' igual a da nota'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object shpConfOK: TShape
        Left = 52
        Top = 9
        Width = 16
        Height = 16
        Brush.Color = clGreen
        Pen.Color = clGreen
      end
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 111
    Width = 1189
    Height = 189
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 364
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAR_DESMAR'
        ReadOnly = True
        Title.Caption = 'Marca'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESUNI'
        Title.Caption = 'Unidade'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDEMB'
        Title.Alignment = taRightJustify
        Title.Caption = 'Embalagens'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_LOCFIS'
        Title.Caption = 'Localiza'#231#227'o F'#237'sica'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_LOCSUP'
        Title.Caption = 'Loc. Super Estoque'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_PESBRU'
        Title.Caption = 'Peso Bruto'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_PESLIQ'
        Title.Caption = 'Peso L'#237'quido'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_CPESOB'
        Title.Caption = 'Pesagem Obrigat'#243'ria'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 71
    Width = 1189
    ExplicitTop = 71
    ExplicitWidth = 1189
  end
  object pnlFicIns: TPanel [7]
    Left = 0
    Top = 400
    Width = 1189
    Height = 128
    Align = alBottom
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 7
    object Panel9: TPanel
      Left = 1
      Top = 1
      Width = 1187
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Ficha de Instru'#231#227'o para Confer'#234'ncia do Produto:'
      ParentColor = True
      TabOrder = 0
      object btnArquivosAnexos: TBitBtnLocked
        Left = 1060
        Top = 0
        Width = 127
        Height = 24
        Align = alRight
        Caption = '&Arquivos Anexos'
        TabOrder = 0
        Visible = False
        WordWrap = True
        OnClick = btnArquivosAnexosClick
      end
    end
    object dbeFicIns: TDBMemoFocus
      Left = 1
      Top = 25
      Width = 1187
      Height = 102
      Align = alClient
      BorderStyle = bsNone
      DataField = 'ITE_FICINS'
      DataSource = dtsConsulta
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlAplicacao: TPanel [8]
    Left = 0
    Top = 304
    Width = 1189
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object pnlAplica: TPanel
      Left = 0
      Top = 0
      Width = 1189
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object mmoAplica: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 1189
      Height = 76
      Align = alBottom
      BorderStyle = bsNone
      DataField = 'ITE_APLICA'
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 144
  end
  inherited qryConsulta: TUniQuery
    Left = 88
    Top = 144
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 144
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    AfterOpen = cdsConsultaAfterOpen
    AfterClose = cdsConsultaAfterClose
    AfterPost = cdsConsultaAfterPost
    AfterScroll = cdsConsultaAfterScroll
    Left = 236
    Top = 216
  end
  inherited dtsConsulta: TDataSource
    Left = 272
    Top = 148
  end
  object cdsCriticas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 192
    object cdsCriticasCODITE: TStringField
      FieldName = 'CODITE'
      Size = 30
    end
    object cdsCriticasDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsCriticasSIGUNI: TStringField
      FieldName = 'DESUNI'
      Size = 6
    end
    object cdsCriticasQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsCriticasQTDCON: TFloatField
      FieldName = 'QTDCON'
    end
    object cdsCriticasCODFAB: TStringField
      FieldName = 'CODFAB'
    end
    object cdsCriticasLOCFIS: TStringField
      FieldName = 'LOCFIS'
    end
    object cdsCriticasSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsCriticasQTDXML: TFloatField
      FieldName = 'QTDXML'
    end
  end
end
