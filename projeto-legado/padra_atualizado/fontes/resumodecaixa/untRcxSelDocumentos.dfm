inherited frmRcxSelDocumentos: TfrmRcxSelDocumentos
  Left = 205
  Top = 178
  Width = 918
  BorderIcons = [biSystemMenu]
  Caption = 'Documentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 918
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 389
    Width = 912
    Height = 71
    Enabled = True
    TabOrder = 3
    Visible = True
    ExplicitTop = 389
    ExplicitWidth = 912
    ExplicitHeight = 71
    DesignSize = (
      912
      71)
    inherited FlwBotoes: TFlowPanel
      Width = 908
      Height = 67
      ExplicitWidth = 908
      ExplicitHeight = 67
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnImpressao: TBitBtnLocked
        Left = 168
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F3 ] Imprimir Recibo'
        TabOrder = 1
        OnClick = btnImpressaoClick
      end
      object btnSelecTodos: TBitBtnLocked
        Left = 336
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F4 ] Selecionar Todos'
        TabOrder = 2
        OnClick = btnSelecTodosClick
      end
      object btnPesquisa: TBitBtnLocked
        Left = 504
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F5 ] Pesquisa'
        TabOrder = 3
        OnClick = btnPesquisaClick
      end
      object btnDupAgrupadas: TBitBtnLocked
        Left = 672
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F6 ] Dups. Agrupadas'
        Enabled = False
        TabOrder = 4
        OnClick = btnDupAgrupadasClick
      end
      object btnProdutos: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 168
        Height = 22
        Caption = '[ F7 ] Produtos'
        TabOrder = 5
        OnClick = btnProdutosClick
      end
      object btnRecalculaJuros: TBitBtnLocked
        Left = 168
        Top = 22
        Width = 168
        Height = 22
        Caption = '[Alt+J] Recalcula Juros'
        PopupMenu = PopupCalcJuros
        TabOrder = 6
        OnClick = btnRecalculaJurosClick
      end
      object btnResumoFinanceiro: TBitBtnLocked
        Left = 336
        Top = 22
        Width = 168
        Height = 22
        Caption = '[Alt+F7] Res. financeiro'
        TabOrder = 7
        OnClick = btnResumoFinanceiroClick
      end
      object btnInfCobr: TBitBtnLocked
        Left = 504
        Top = 22
        Width = 168
        Height = 22
        Caption = '[F12] Informa'#231#245'es de Cobran'#231'a'
        TabOrder = 8
        Visible = False
        OnClick = btnInfCobrClick
      end
      object btnDescontoGeral: TBitBtnLocked
        Left = 672
        Top = 22
        Width = 168
        Height = 22
        Caption = '[Alt+F12] Desconto Geral'
        TabOrder = 9
        OnClick = btnDescontoGeralClick
      end
      object btnConfigurarGrid: TBitBtnLocked
        Left = 0
        Top = 44
        Width = 168
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
        TabOrder = 10
        OnClick = btnConfigurarGridClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 674
      Top = 46
      Width = 168
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 674
      ExplicitTop = 46
      ExplicitWidth = 168
    end
  end
  inherited pnlStatus: TPanel
    Width = 912
    ExplicitTop = 460
    ExplicitWidth = 912
    inherited pnlNomeForm: TPanel
      Left = 741
      ExplicitLeft = 741
    end
    inherited pnlInfo: TPanel
      Width = 741
      ExplicitWidth = 741
    end
  end
  inherited pgcDados: TPageControl
    Width = 912
    Height = 389
    ExplicitWidth = 912
    ExplicitHeight = 389
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 904
      ExplicitHeight = 357
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 912
    Height = 389
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 910
      Height = 72
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 302
        Top = 10
        Width = 41
        Height = 14
        Caption = 'Esp'#233'cie:'
      end
      object Label6: TLabel
        Left = 8
        Top = 10
        Width = 57
        Height = 14
        Caption = 'Documento:'
      end
      object Label8: TLabel
        Left = 201
        Top = 10
        Width = 39
        Height = 14
        Caption = 'Parcela:'
      end
      object lblNumCoo: TLabel
        Left = 405
        Top = 10
        Width = 26
        Height = 14
        Caption = 'COO:'
      end
      object lblEvento: TLabel
        Left = 499
        Top = 9
        Width = 53
        Height = 14
        Caption = 'Ctr.Custos:'
      end
      object lblNumDocOrigem: TLabel
        Left = 8
        Top = 38
        Width = 59
        Height = 14
        Caption = 'Doc.Origem:'
        Visible = False
      end
      object lblEspDocOrigem: TLabel
        Left = 202
        Top = 38
        Width = 38
        Height = 14
        Caption = 'Esp.Ori:'
        Visible = False
      end
      object edtEspDoc: TEditFocus
        Left = 344
        Top = 6
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumDoc: TEditFocus
        Left = 68
        Top = 6
        Width = 127
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtParcel: TEditFocus
        Left = 243
        Top = 6
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnAplicaFiltro: TBitBtnLocked
        Left = 618
        Top = 6
        Width = 85
        Height = 22
        Caption = '&Pesquisar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
          CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
          1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
          D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
          7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
          E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
          EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
          8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnAplicaFiltroClick
      end
      object edtNumCoo: TEditFocus
        Tag = 99
        Left = 432
        Top = 6
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 9
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 9
        TipoTexto = ttInteiro
      end
      object edtEvento: TEditFocus
        Tag = 99
        Left = 553
        Top = 6
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttInteiro
      end
      object edtNumDocOrigem: TEditFocus
        Left = 68
        Top = 34
        Width = 127
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtEspDocOrigem: TEditFocus
        Left = 243
        Top = 34
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlInformativos: TPanel
      Left = 1
      Top = 285
      Width = 910
      Height = 62
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label2: TLabel
        Left = 10
        Top = 13
        Width = 50
        Height = 14
        Caption = 'Vendedor:'
      end
      object Label3: TLabel
        Left = 16
        Top = 35
        Width = 44
        Height = 14
        Caption = 'Portador:'
      end
      object edtVendedor: TEditFocus
        Left = 63
        Top = 9
        Width = 350
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtPortador: TEditFocus
        Left = 63
        Top = 31
        Width = 350
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
      object memHistDup: TMemoFocus
        Left = 446
        Top = 8
        Width = 420
        Height = 45
        TabStop = False
        Color = 16770261
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object pnlValores: TPanel
      Left = 1
      Top = 347
      Width = 910
      Height = 41
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object Label4: TLabel
        Left = 434
        Top = 14
        Width = 87
        Height = 14
        Caption = 'Total Selecionado:'
      end
      object Label5: TLabel
        Left = 767
        Top = 14
        Width = 54
        Height = 14
        Caption = 'Total Geral:'
      end
      object Label7: TLabel
        Left = 243
        Top = 15
        Width = 97
        Height = 14
        Caption = 'Quant. Selecionada:'
      end
      object Label13: TLabel
        Left = 16
        Top = 14
        Width = 86
        Height = 14
        Caption = 'M'#233'dia Ponderada:'
      end
      object Label9: TLabel
        Left = 617
        Top = 14
        Width = 60
        Height = 14
        Caption = 'Total Duplic.:'
      end
      object edtTotSel: TEditFocus
        Left = 523
        Top = 10
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtTotGer: TEditFocus
        Left = 824
        Top = 10
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtQtdSel: TEditFocus
        Left = 343
        Top = 10
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtMedPond: TEditFocus
        Left = 108
        Top = 10
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        TabOrder = 3
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
      object btnMedPond: TBitBtnLocked
        Left = 188
        Top = 10
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
        TabOrder = 4
        OnClick = btnMedPondClick
        OnMouseEnter = btnMedPondMouseEnter
        OnMouseLeave = btnMedPondMouseLeave
      end
      object edtTotDpl: TEditFocus
        Left = 677
        Top = 10
        Width = 74
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
    end
    object dbgDocumentos: TcxGrid
      Left = 1
      Top = 73
      Width = 910
      Height = 212
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDocumentosDBTableView1: TcxGridDBTableView
        OnKeyDown = dbgDocumentosDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDocumentosDBTableView1CustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'CTR_VALSUJ'
            Column = dbgDocumentosCTR_VALCOR
            VisibleForCustomization = False
          end
          item
            Kind = skSum
            FieldName = 'CTR_VALCAL'
            Column = dbgDocumentosCTR_ENVBCO
          end
          item
            Kind = skSum
            FieldName = 'CTR_DUPORI'
            Column = dbgDocumentosCTR_DUPORI
            VisibleForCustomization = False
          end
          item
            Kind = skSum
            FieldName = 'CTR_VALCOR'
            Column = dbgDocumentosCTR_VALCOR
            VisibleForCustomization = False
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        object dbgDocumentosCTR_DUPPAR: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'CTR_DUPPAR'
          Width = 98
        end
        object dbgDocumentosCTR_ESPDOC: TcxGridDBColumn
          Caption = 'Esp.'
          DataBinding.FieldName = 'CTR_ESPDOC'
          Width = 28
        end
        object dbgDocumentosFGO_DOCORI: TcxGridDBColumn
          Caption = 'Doc. Origem'
          DataBinding.FieldName = 'FGO_DOCORI'
          Visible = False
          Width = 70
        end
        object dbgDocumentosFGO_ESPORI: TcxGridDBColumn
          Caption = 'Esp. Origem'
          DataBinding.FieldName = 'FGO_ESPORI'
          Visible = False
          Width = 60
        end
        object dbgDocumentosCTR_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CTR_CODEMP'
          Width = 27
        end
        object dbgDocumentosCTR_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CTR_NOMCLI'
          Width = 150
        end
        object dbgDocumentosCTR_DTAVEN: TcxGridDBColumn
          Caption = 'Data Venc.'
          DataBinding.FieldName = 'CTR_DTAVEN'
          Width = 70
        end
        object dbgDocumentosCTR_DTACAD: TcxGridDBColumn
          Caption = 'Data Cadastro'
          DataBinding.FieldName = 'CTR_DTACAD'
          Width = 76
        end
        object dbgDocumentosCTR_DUPORI: TcxGridDBColumn
          Caption = 'Val. Duplicata'
          DataBinding.FieldName = 'CTR_DUPORI'
          HeaderAlignmentHorz = taRightJustify
          VisibleForEditForm = bTrue
          Width = 75
        end
        object dbgDocumentosCTR_VALCOR: TcxGridDBColumn
          Caption = 'Val. Corrigido'
          DataBinding.FieldName = 'CTR_VALCOR'
          HeaderAlignmentHorz = taRightJustify
          Width = 75
        end
        object dbgDocumentosCTR_NOSNUM: TcxGridDBColumn
          Caption = 'Nosso N'#250'm.'
          DataBinding.FieldName = 'CTR_NOSNUM'
          Width = 75
        end
        object dbgDocumentosCTR_IMPBOL: TcxGridDBColumn
          Caption = 'Boleto'
          DataBinding.FieldName = 'CTR_IMPBOL'
          VisibleForCustomization = False
          Width = 37
        end
        object dbgDocumentosCTR_ENVBCO: TcxGridDBColumn
          Caption = 'Enviado Banco?'
          DataBinding.FieldName = 'CTR_ENVBCO'
          HeaderAlignmentHorz = taRightJustify
          Width = 86
        end
        object dbgDocumentosDIASATRASO: TcxGridDBColumn
          Caption = 'Dias em atraso'
          DataBinding.FieldName = 'DIASATRASO'
          Width = 80
        end
        object dbgDocumentosCTR_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_MARDES'
          Visible = False
        end
      end
      object dbgDocumentosLevel1: TcxGridLevel
        GridView = dbgDocumentosDBTableView1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 152
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
  end
  object PopupCalcJuros: TPopupMenu
    Left = 496
    Top = 224
    object mnuCalcJurosGlobal: TMenuItem
      Caption = 'Recalcula Juros Global'
      Hint = 
        'Esta rotina ir'#225' aplicar juros e multa em todos os t'#237'tulos carreg' +
        'ados na tela de sele'#231#227'o de duplicatas.'
      ShortCut = 119
      OnClick = mnuCalcJurosGlobalClick
    end
    object mnuCalcJurosIndividual: TMenuItem
      Caption = 'Recalcula Juros Individual'
      Hint = 
        'Esta rotina ir'#225' aplicar juros e multa somente neste t'#237'tulo selec' +
        'ionado.'
      ShortCut = 120
      OnClick = mnuCalcJurosIndividualClick
    end
    object mnuCalcJurosFuturo: TMenuItem
      Caption = 'Recalcular Juros Futuros'
      Hint = 
        'Esta rotina ir'#225' aplicar juros e multa em todos os t'#237'tulos carreg' +
        'ados nesta tela de sele'#231#227'o de duplicatas, conforme a data final ' +
        'digitada.'
      ShortCut = 122
      OnClick = mnuCalcJurosFuturoClick
    end
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
    Left = 560
    Top = 224
  end
end
