inherited frmEntConferencia: TfrmEntConferencia
  Left = 195
  Top = 179
  Width = 1024
  Height = 608
  BorderIcons = [biSystemMenu]
  Caption = 'Confer'#234'ncia de Entrada de Mercadorias'
  ExplicitTop = -55
  ExplicitWidth = 1024
  ExplicitHeight = 608
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 226
    Width = 1008
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    Color = clYellow
    ParentColor = False
    StyleElements = []
    ExplicitTop = 301
  end
  inherited pnlBotoes: TPanel
    Top = 439
    Width = 1008
    Height = 49
    ExplicitTop = 439
    ExplicitWidth = 1008
    ExplicitHeight = 49
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      Height = 45
      ExplicitWidth = 1004
      ExplicitHeight = 45
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 125
        ExplicitWidth = 125
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 125
        Width = 125
        ExplicitLeft = 125
        ExplicitWidth = 125
      end
      object btnConfirma: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 125
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
        Left = 375
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F6] Quantidade'
        TabOrder = 3
        OnClick = btnQuantidadeClick
      end
      object btnQtdEti: TBitBtnLocked
        Left = 500
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F7] Qtd. Etiquetas '
        TabOrder = 4
        OnClick = btnQtdEtiClick
      end
      object btnEtiPro: TBitBtnLocked
        Left = 625
        Top = 0
        Width = 134
        Height = 22
        Caption = 'Etiq. Produtos'
        TabOrder = 10
        OnClick = btnEtiProClick
      end
      object btnImpColetor: TBitBtnLocked
        Left = 759
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F8] Import. Coletor'
        TabOrder = 5
        OnClick = btnImpColetorClick
      end
      object btnCriticas: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 125
        Height = 22
        Caption = '[F9] Rel. Cr'#237'ticas'
        TabOrder = 6
        OnClick = btnCriticasClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 125
        Top = 22
        Width = 127
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
        TabOrder = 7
        OnClick = btnExcluirClick
      end
      object btnDigCodBarLocFis: TBitBtnLocked
        Left = 252
        Top = 22
        Width = 125
        Height = 22
        Caption = '[F12] Digita'#231#227'o C'#243'd. Bar.'
        TabOrder = 8
        OnClick = btnDigCodBarLocFisClick
      end
      object btnCadSem: TBitBtnLocked
        Left = 377
        Top = 22
        Width = 125
        Height = 22
        Caption = '[F11] Cad.Semelhan'#231'a'
        TabOrder = 9
        OnClick = btnCadSemClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 877
      Top = 24
      Width = 127
      Caption = 'Sair'
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
      ExplicitLeft = 877
      ExplicitTop = 24
      ExplicitWidth = 127
    end
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 1008
    ExplicitTop = 553
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  inherited pnlHeader: TPanel
    Width = 1008
    Height = 41
    ExplicitWidth = 1008
    ExplicitHeight = 41
    object lblTipoDoc: TLabel
      Left = 7
      Top = 13
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido de Compra:'
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 105
      Top = 9
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnEnter = edtNumPedEnter
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtLisPed: TEditFocus
      Left = 194
      Top = 9
      Width = 557
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
  end
  inherited pnlTail: TPanel
    Top = 358
    Width = 1008
    Height = 81
    Visible = True
    ExplicitTop = 358
    ExplicitWidth = 1008
    ExplicitHeight = 81
    object chkSintQtd: TCheckBox
      Left = 538
      Top = 58
      Width = 203
      Height = 17
      Caption = '&Sintetizar as quantidades conferidas'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkSintQtdClick
    end
    object pnlContagem: TPanel
      Left = 0
      Top = 0
      Width = 532
      Height = 81
      Align = alLeft
      BevelOuter = bvNone
      Enabled = False
      ParentColor = True
      TabOrder = 2
      object Label2: TLabel
        Left = 6
        Top = 59
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object Label3: TLabel
        Left = 211
        Top = 59
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblQtdEti: TLabel
        Left = 353
        Top = 59
        Width = 105
        Height = 14
        Caption = 'Quantidade etiquetas:'
      end
      object rdbCodBar: TRadioButton
        Left = 4
        Top = 12
        Width = 106
        Height = 14
        Caption = 'C'#243'digo de Barras'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbCodBarClick
      end
      object rdbCodFab: TRadioButton
        Left = 4
        Top = 29
        Width = 107
        Height = 14
        Caption = 'C'#243'digo da F'#225'brica'
        TabOrder = 1
        OnClick = rdbCodBarClick
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 44
        Top = 55
        Width = 163
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
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
        Left = 273
        Top = 55
        Width = 73
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
        Left = 461
        Top = 55
        Width = 52
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
      object Panel1: TPanel
        Left = 116
        Top = 2
        Width = 293
        Height = 50
        BevelOuter = bvNone
        BorderStyle = bsSingle
        ParentColor = True
        TabOrder = 5
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
    end
    object chkImprimeEtiqueta: TCheckBox
      Left = 538
      Top = 39
      Width = 154
      Height = 17
      Caption = 'Imprimir Etiqueta do Produto'
      TabOrder = 0
      OnClick = chkImprimeEtiquetaClick
    end
    object pnlImgPro: TPanel
      Left = 747
      Top = 5
      Width = 107
      Height = 67
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 3
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
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 81
    Width = 1008
    Height = 145
    TabStop = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESUNI'
        Title.Caption = 'Unidade'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDUNI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant. de Embal.'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDEMB'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant. na Embal.'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade Total'
        Width = 103
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 41
    Width = 1008
    ExplicitTop = 41
    ExplicitWidth = 1008
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  object mmoAjuda: TMemo [7]
    Left = 0
    Top = 488
    Width = 1008
    Height = 65
    TabStop = False
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      
        'Para que o pedido esteja dispon'#237'vel '#224' Entrada de Mercadorias ser' +
        #225' necess'#225'rio finaliz'#225'-lo (Finaliza[F10]).'
      ''
      
        'Saindo da tela de confer'#234'ncia sem finalizar (bot'#227'o Sair) a conta' +
        'gem "parcial" n'#227'o ser'#225' perdida, podendo ser retomada posteriorme' +
        'nte.'
      
        'Nesse caso o pedido n'#227'o estar'#225' dispon'#237'vel '#224' Entrada de Mercadori' +
        'as at'#233' que seja finalizado.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    StyleElements = []
  end
  object pnlFicIns: TPanel [8]
    Left = 0
    Top = 230
    Width = 1008
    Height = 128
    Align = alBottom
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 7
    object Panel9: TPanel
      Left = 1
      Top = 1
      Width = 1006
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Ficha de Instru'#231#227'o para Confer'#234'ncia do Produto:'
      ParentColor = True
      TabOrder = 0
      object btnArquivosAnexos: TBitBtnLocked
        Left = 879
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
      Width = 1006
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 124
    Top = 228
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 168
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 136
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 144
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    AfterClose = cdsConsultaAfterClose
    AfterPost = cdsConsultaAfterPost
    AfterScroll = cdsConsultaAfterScroll
    Left = 212
    Top = 120
    object cdsConsultaITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
    end
    object cdsConsultaITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
    end
    object cdsConsultaITE_CODBAR: TStringField
      FieldName = 'ITE_CODBAR'
    end
    object cdsConsultaITE_REFERE: TStringField
      FieldName = 'ITE_REFERE'
    end
    object cdsConsultaITE_DESUNI: TStringField
      FieldName = 'ITE_DESUNI'
    end
    object cdsConsultaITE_QTDCON: TFloatField
      FieldName = 'ITE_QTDCON'
    end
    object cdsConsultaITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 50
    end
    object cdsConsultaITE_LOCFIS: TStringField
      FieldName = 'ITE_LOCFIS'
      Size = 50
    end
    object cdsConsultaITE_SALDOS: TFloatField
      FieldName = 'ITE_SALDOS'
    end
    object cdsConsultaPCG_CODEMP: TStringField
      FieldName = 'PCG_CODEMP'
      Size = 3
    end
    object cdsConsultaITE_EMBALA: TFloatField
      FieldName = 'ITE_EMBALA'
    end
    object cdsConsultaITE_QTDEMB: TFloatField
      FieldName = 'ITE_QTDEMB'
    end
    object cdsConsultaITE_QTDUNI: TFloatField
      FieldName = 'ITE_QTDUNI'
    end
    object cdsConsultaAUTOINCPCC: TStringField
      FieldName = 'AUTOINCPCC'
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Size = 1000
    end
    object cdsConsultaITE_FICINS: TMemoField
      FieldName = 'ITE_FICINS'
      BlobType = ftMemo
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 328
    Top = 108
  end
  object cdsCriticas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 140
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
    object cdsCriticasREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39693.439363055600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 16
    Top = 136
    Datasets = <
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 748.800000000000100000
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        RowCount = 0
        object frxdbCriticasCODITE: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasDESITE: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDITE: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasQTDCON: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDCON"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 255.000000000000000000
        Width = 748.800000000000100000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 153.000000000000000000
        Width = 748.800000000000100000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd. Pedido')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd. Confer.')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 748.800000000000100000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PEDIDO]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39988.499461076390000000
    ReportOptions.LastChange = 39988.499461076390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 48
    Top = 136
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxdbCriticas: TfrxDBDataset
    UserName = 'frxdbCriticas'
    CloseDataSource = False
    DataSet = cdsCriticas
    BCDToCurrency = False
    Left = 80
    Top = 136
  end
  object opdArqCol: TOpenDialog
    Left = 272
    Top = 220
  end
end
