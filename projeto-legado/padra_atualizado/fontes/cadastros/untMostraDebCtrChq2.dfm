inherited frmMostraDebCtrChq2: TfrmMostraDebCtrChq2
  Left = 186
  Top = 85
  Width = 1025
  Height = 768
  Caption = 'Contas a Receber/Cadastro de Cheques'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1025
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 491
    Width = 1019
    ExplicitTop = 491
    ExplicitWidth = 1019
    inherited FlwBotoes: TFlowPanel
      Width = 1015
      ExplicitWidth = 1015
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1019
    ExplicitTop = 723
    ExplicitWidth = 1019
    inherited pnlNomeForm: TPanel
      Left = 848
      ExplicitLeft = 848
    end
    inherited pnlInfo: TPanel
      Width = 848
      ExplicitWidth = 848
    end
  end
  inherited pgcDados: TPageControl
    Height = 417
    Align = alNone
    ExplicitHeight = 417
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 385
    end
  end
  object pnlBotoesMostra: TPanel [3]
    Left = 0
    Top = 694
    Width = 1019
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clSilver
    ParentBackground = False
    TabOrder = 3
    StyleElements = [seFont, seBorder]
    object lbl2: TLabel
      Left = 28
      Top = 7
      Width = 123
      Height = 15
      Caption = 'Documentos vencidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object lbl3: TLabel
      Left = 182
      Top = 7
      Width = 149
      Height = 15
      Caption = 'Documentos selecionados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object shp3: TShape
      Left = 164
      Top = 9
      Width = 12
      Height = 12
      Brush.Color = clBlue
    end
    object shp2: TShape
      Left = 10
      Top = 9
      Width = 12
      Height = 12
      Brush.Color = clRed
    end
    object Label10: TLabel
      Left = 354
      Top = 7
      Width = 8
      Height = 15
      Caption = 'A'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 502
      Top = 7
      Width = 8
      Height = 15
      Caption = 'B'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 369
      Top = 7
      Width = 115
      Height = 15
      Caption = 'Documentos Abertos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object Label13: TLabel
      Left = 516
      Top = 7
      Width = 125
      Height = 15
      Caption = 'Documentos Baixados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object btnFechar: TBitBtnLocked
      Left = 940
      Top = 2
      Width = 77
      Height = 25
      Align = alRight
      Caption = '&Fechar'
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
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object pnlDebCtr: TPanel [4]
    Left = 0
    Top = 0
    Width = 1019
    Height = 491
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object pnlTitCtr: TPanel
      Left = 1
      Top = 1
      Width = 1017
      Height = 24
      Align = alTop
      Caption = 'Contas a Receber'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnlRodapeCR: TPanel
      Left = 1
      Top = 268
      Width = 1017
      Height = 222
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblDupOri: TLabel
        Left = 555
        Top = 4
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object lblJurRec: TLabel
        Left = 400
        Top = 26
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object lblCorDif: TLabel
        Left = 695
        Top = 6
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label1: TLabel
        Left = 5
        Top = 4
        Width = 194
        Height = 14
        Caption = 'Dup. Vencidas em aberto (Vl. Corrigido):'
      end
      object Label2: TLabel
        Left = 127
        Top = 26
        Width = 72
        Height = 14
        Caption = 'Dup. '#224' Vencer:'
      end
      object Label3: TLabel
        Left = 50
        Top = 47
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label9: TLabel
        Left = 31
        Top = 138
        Width = 65
        Height = 14
        Caption = 'Recebido em:'
      end
      object lblDupCor: TLabel
        Left = 555
        Top = 27
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label5: TLabel
        Left = 883
        Top = 3
        Width = 128
        Height = 14
        Caption = 'MARCAR / DESMARCAR '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 303
        Top = 4
        Width = 124
        Height = 14
        Caption = 'Dup. Vencidas em aberto:'
      end
      object Label15: TLabel
        Left = 5
        Top = 91
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico da Baixa:'
      end
      object Label16: TLabel
        Left = 823
        Top = 3
        Width = 57
        Height = 14
        Caption = '[ ESPA'#199'O ]'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtDupOri: TEditFocus
        Left = 584
        Top = 1
        Width = 90
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clWindow
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtJurRec: TEditFocus
        Left = 430
        Top = 24
        Width = 89
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clWindow
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtCorDif: TEditFocus
        Left = 726
        Top = 1
        Width = 90
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clWindow
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTotVencido: TEditFocus
        Left = 205
        Top = 1
        Width = 89
        Height = 22
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
        TipoTexto = ttAlfanumerico
      end
      object edtTotVencer: TEditFocus
        Left = 205
        Top = 24
        Width = 89
        Height = 22
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
        TipoTexto = ttAlfanumerico
      end
      object dbeHist01: TDBMemoFocus
        Left = 101
        Top = 47
        Width = 715
        Height = 43
        DataField = 'CTR_HIST99'
        DataSource = dtsTemporaria2
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object dbeRecebi: TDBEditFocus
        Left = 101
        Top = 135
        Width = 715
        Height = 22
        DataField = 'RECEBI'
        DataSource = dtsTemporaria2
        ReadOnly = True
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnMarcarTudo: TBitBtnLocked
        Left = 820
        Top = 20
        Width = 89
        Height = 26
        Caption = '[F3] Marcar Tudo'
        TabOrder = 8
        OnClick = btnMarcarTudoClick
      end
      object btnDesmarcarTudo: TBitBtnLocked
        Left = 908
        Top = 20
        Width = 106
        Height = 26
        Caption = '[F4] Des. Tudo'
        TabOrder = 9
        OnClick = btnDesmarcarTudoClick
      end
      object edtDupCor: TEditFocus
        Left = 584
        Top = 24
        Width = 90
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clWindow
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTotVencidoOrig: TEditFocus
        Left = 430
        Top = 1
        Width = 89
        Height = 22
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
        TipoTexto = ttAlfanumerico
      end
      object dbeHistBai: TDBMemoFocus
        Left = 101
        Top = 86
        Width = 715
        Height = 43
        DataField = 'CTR_HISBAI'
        DataSource = dtsTemporaria2
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object flwBotoesRodape: TFlowPanel
        Left = 8
        Top = 164
        Width = 994
        Height = 54
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 12
        object btnRelatorio: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 92
          Height = 25
          Caption = '[ F5 ] - Relat'#243'rio'
          TabOrder = 0
          OnClick = btnRelatorioClick
        end
        object btnObsDoc: TBitBtnLocked
          Left = 92
          Top = 0
          Width = 133
          Height = 25
          Caption = '[ F6 ] - Obs. Documento'
          TabOrder = 1
          OnClick = btnObsDocClick
        end
        object btnProdutos: TBitBtnLocked
          Left = 225
          Top = 0
          Width = 100
          Height = 25
          Caption = '[ F7 ] - Produtos'
          TabOrder = 2
          OnClick = btnProdutosClick
        end
        object btnAgrupamentos: TBitBtnLocked
          Left = 325
          Top = 0
          Width = 127
          Height = 25
          Caption = '[ F8 ] - Dups. Agrupadas'
          Enabled = False
          TabOrder = 3
          OnClick = btnAgrupamentosClick
        end
        object btnEnviarEmail: TBitBtnLocked
          Left = 452
          Top = 0
          Width = 115
          Height = 25
          Caption = '[ F9 ] - Enviar email'
          TabOrder = 4
          OnClick = btnEnviarEmailClick
        end
        object btnAgeHis: TBitBtnLocked
          Left = 567
          Top = 0
          Width = 124
          Height = 25
          Caption = '[F10] &Agendar Hist'#243'rico'
          TabOrder = 5
          OnClick = btnAgeHisClick
        end
        object btnVisChq: TBitBtnLocked
          Left = 691
          Top = 0
          Width = 203
          Height = 25
          Caption = '[ Enter ] Visualizar Cadastro de Cheques'
          Default = True
          TabOrder = 6
          OnClick = btnVisChqClick
        end
        object btnCfgRec: TBitBtnLocked
          Left = 894
          Top = 0
          Width = 96
          Height = 25
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
          TabOrder = 7
          OnClick = btnCfgRecClick
        end
        object BtnImprimirBoleto: TBitBtnLocked
          Left = 0
          Top = 25
          Width = 124
          Height = 25
          Caption = '[F10] &Imprimir Boleto'
          TabOrder = 8
          OnClick = BtnImprimirBoletoClick
        end
        object btnAlterarPortador: TBitBtnLocked
          Left = 124
          Top = 25
          Width = 124
          Height = 25
          Caption = '[F2] &Alterar Portador'
          TabOrder = 9
          OnClick = btnAlterarPortadorClick
        end
        object btnEnviarNF: TBitBtnLocked
          Left = 248
          Top = 25
          Width = 124
          Height = 25
          Caption = '[F11] &Enviar NF'
          TabOrder = 10
          OnClick = btnEnviarNFClick
        end
        object btnAcompEntrega: TBitBtnLocked
          Left = 372
          Top = 25
          Width = 173
          Height = 25
          Caption = 'Ac&ompanhamento de Entrega'
          Default = True
          TabOrder = 11
          OnClick = btnAcompEntregaClick
        end
        object btnEnviarWhatsapp: TBitBtnLocked
          Left = 545
          Top = 25
          Width = 108
          Height = 25
          Caption = 'Enviar Whatsapp'
          TabOrder = 12
          OnClick = btnEnviarWhatsappClick
        end
      end
      object PnlInfCob: TPanel
        Left = 820
        Top = 47
        Width = 509
        Height = 110
        TabOrder = 13
        object lblHist: TLabel
          Left = 1
          Top = 1
          Width = 507
          Height = 14
          Align = alTop
          Caption = 'Hist'#243'rico de cobran'#231'a'
          ExplicitWidth = 106
        end
        object grdHistDups: TcxGridCitel
          Left = 1
          Top = 15
          Width = 322
          Height = 94
          Align = alLeft
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdHistDupsTableView1: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GridLines = glNone
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdHistDupsCob_DtaLan: TcxGridDBColumn
              Caption = 'Dt Inclus'#227'o'
              DataBinding.FieldName = 'COB_DTALAN'
              Width = 63
            end
            object grdHistDupsDATA: TcxGridDBColumn
              Caption = 'Dt Ag/Rel'
              DataBinding.FieldName = 'DTA'
              Width = 58
            end
            object grdHistDupsAGEREL: TcxGridDBColumn
              Caption = 'Tipo'
              DataBinding.FieldName = 'AGEREL'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              Properties.Alignment.Vert = taVCenter
              OnGetDisplayText = grdHistDupsAGERELGetDisplayText
              HeaderAlignmentHorz = taCenter
              Width = 45
            end
            object grdHistDupsTableCOB_CODOPE: TcxGridDBColumn
              Caption = 'Op. Cobran'#231'a'
              DataBinding.FieldName = 'COB_CODOPE'
              Width = 80
            end
            object grdHistDupsTableCOB_BAIXAD: TcxGridDBColumn
              Caption = 'Baixado'
              DataBinding.FieldName = 'COB_BAIXAD'
              OnGetDisplayText = grdHistDupsTableCOB_BAIXADGetDisplayText
              Width = 51
            end
          end
          object grdHistDupsLevel1: TcxGridLevel
            GridView = grdHistDupsTableView1
          end
        end
        object mdbHisDup: TDBMemoFocus
          Left = 323
          Top = 15
          Width = 185
          Height = 94
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BevelKind = bkFlat
          DataField = 'COB_HISCOB'
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
    object dbgDuplicatas: TcxGridCitel
      Left = 1
      Top = 25
      Width = 1017
      Height = 243
      Align = alClient
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasDados: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDuplicatasDadosCustomDrawCell
        DataController.DataSource = dtsTemporaria2
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OnColumnHeaderClick = dbgDuplicatasDadosColumnHeaderClick
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasDados
      end
    end
  end
  object pnlDebChq: TPanel [5]
    Left = 0
    Top = 491
    Width = 1019
    Height = 203
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object Label4: TLabel
      Left = 9
      Top = 146
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emitente:'
    end
    object Label6: TLabel
      Left = 315
      Top = 139
      Width = 58
      Height = 28
      Alignment = taRightJustify
      Caption = 'Total '#13#10'Telecheque:'
    end
    object Label8: TLabel
      Left = 493
      Top = 139
      Width = 80
      Height = 28
      Alignment = taRightJustify
      Caption = 'Total '#13#10'N'#227'o Telecheque:'
    end
    object Label7: TLabel
      Left = 548
      Top = 174
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object dbgCheques: TDBGridCitel
      Left = 1
      Top = 25
      Width = 1017
      Height = 111
      Align = alTop
      DataSource = dtsTemporaria3
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgChequesDrawColumnCell
      OnTitleClick = dbgChequesTitleClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_NUMCHQ'
          Title.Caption = 'Nro. Cheque'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLIENTE'
          Title.Caption = 'Cliente'
          Width = 200
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_CODEMP'
          Title.Caption = 'Emp.'
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_CODBCO'
          Title.Caption = 'Banco'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_NOMEMI'
          Title.Caption = 'Emitente'
          Width = 170
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_DTADEP'
          Title.Caption = 'Dt. Dep'#243'sito'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_DTADEV'
          Title.Caption = 'Dt. Devolu'#231#227'o'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_DTAVEN'
          Title.Caption = 'Dt. Vencimento'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CHQ_VALCHQ'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHQ_TELNUM'
          Title.Caption = 'Telecheque'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_REPASS'
          Title.Caption = 'Repassado'
          Visible = True
        end>
    end
    object pnlTitChq: TPanel
      Left = 1
      Top = 1
      Width = 1017
      Height = 24
      Align = alTop
      Caption = 'Cadastro de Cheques'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
    end
    object dbeNomEmi: TDBEditFocus
      Left = 55
      Top = 142
      Width = 250
      Height = 22
      DataField = 'CHQ_NOMEMI'
      DataSource = dtsTemporaria3
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtTotTel: TEditFocus
      Left = 376
      Top = 142
      Width = 103
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtTotNao: TEditFocus
      Left = 575
      Top = 142
      Width = 103
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtChqTot: TEditFocus
      Left = 575
      Top = 170
      Width = 103
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object btnVisCtr: TBitBtnLocked
      Left = 6
      Top = 169
      Width = 209
      Height = 25
      Caption = '[ Enter ] Visualizar Contas a Receber'
      Default = True
      Enabled = False
      TabOrder = 6
      OnClick = btnVisCtrClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
  end
  object dtsTemporaria: TDataSource
    DataSet = cdsTemporaria
    Left = 647
    Top = 16
  end
  object dtsTemporaria2: TDataSource
    DataSet = cdsTemporaria2
    OnDataChange = dtsTemporaria2DataChange
    Left = 647
    Top = 64
  end
  object dtsTemporaria3: TDataSource
    DataSet = cdsTemporaria3
    Left = 647
    Top = 112
  end
  object cdsTemporaria: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'cpvTemporaria'
    Left = 584
    Top = 16
  end
  object cpvTemporaria: TUniDataSetProvider
    Options = []
    Left = 616
    Top = 16
  end
  object cdsTemporaria2: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'cpvTemporaria2'
    Left = 584
    Top = 64
  end
  object cpvTemporaria2: TUniDataSetProvider
    Options = []
    Left = 616
    Top = 64
  end
  object cdsTemporaria3: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'cpvTemporaria3'
    Left = 584
    Top = 112
  end
  object cpvTemporaria3: TUniDataSetProvider
    Options = []
    Left = 616
    Top = 112
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'cpvRelatorio'
    Left = 688
    Top = 320
  end
  object cpvRelatorio: TUniDataSetProvider
    DataSet = qryRelatorio
    Options = []
    Left = 720
    Top = 320
  end
  object qryRelatorio: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 760
    Top = 320
  end
  object cdsNaoTelecheque: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 552
    Top = 64
  end
  object cdsTelecheque: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 552
    Top = 112
  end
end
