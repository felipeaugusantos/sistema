inherited frmCadOperadores: TfrmCadOperadores
  Left = 290
  Top = 114
  Width = 831
  Height = 757
  Caption = 'Cadastro de Operadores'
  OnDestroy = FormDestroy
  ExplicitWidth = 831
  ExplicitHeight = 757
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 687
    Width = 825
    Height = 25
    TabOrder = 1
    ExplicitTop = 687
    ExplicitWidth = 825
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 748
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 748
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      object btnComissao: TBitBtnLocked
        Left = 435
        Top = 0
        Width = 72
        Height = 20
        Caption = 'C&omiss'#227'o'
        Enabled = False
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
        TabOrder = 6
        OnClick = btnComissaoClick
      end
      object btnMobile: TBitBtnLocked
        Left = 507
        Top = 0
        Width = 72
        Height = 20
        Caption = '&Mobile'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333FFFFFFFFF333333300000000
          0333333777777777F33333330888888803333337FFFFFFF7F333333307777777
          0333333777777777F33333330FFFFFFF03333337F3F3FFF7F33333330F9F000F
          03333337F7377737F33333330FFFFFFF03333337F3333337F33333330FFFFFFF
          03333337F3FFFFF7F33333330F40004F03333337F77777F7F33333330F00000F
          03333337F7F337F7F33333330F00000F03333337F7FFF7F7F33333330F40004F
          03333337F7777737F33333330FFFFFFF03333337FFFFFFF7F333333300000000
          0333333777777777333333333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 7
        OnClick = btnMobileClick
      end
      object btnHeranca: TBitBtnLocked
        Left = 579
        Top = 0
        Width = 72
        Height = 21
        Caption = '&Heran'#231'a'
        Enabled = False
        TabOrder = 8
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 750
      Width = 73
      Height = 21
      Align = alRight
      ExplicitLeft = 750
      ExplicitWidth = 73
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 712
    Width = 825
    TabOrder = 2
    ExplicitTop = 712
    ExplicitWidth = 825
    inherited pnlNomeForm: TPanel
      Left = 650
      Width = 175
      TabOrder = 1
      ExplicitLeft = 650
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 650
      TabOrder = 0
      ExplicitWidth = 650
    end
  end
  inherited pgcDados: TPageControl
    Width = 825
    Height = 687
    TabOrder = 0
    OnChange = pgcDadosChange
    ExplicitWidth = 825
    ExplicitHeight = 687
    inherited tbsGeral: TTabSheet
      Tag = 1
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 817
      ExplicitHeight = 655
      object Label8: TLabel
        Left = 40
        Top = 145
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
      end
      object Label1: TLabel
        Left = 40
        Top = 7
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 46
        Top = 30
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label3: TLabel
        Left = 42
        Top = 53
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Senha:'
      end
      object Label4: TLabel
        Left = 355
        Top = 53
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Confirma'#231#227'o:'
      end
      object Label5: TLabel
        Left = 19
        Top = 76
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome Fant.:'
      end
      object Label6: TLabel
        Left = 168
        Top = 99
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
      end
      object Label7: TLabel
        Left = 44
        Top = 122
        Width = 32
        Height = 14
        Alignment = taRightJustify
        Caption = 'Bairro:'
      end
      object Label9: TLabel
        Left = 52
        Top = 99
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CEP:'
      end
      object Label10: TLabel
        Left = 438
        Top = 145
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado:'
      end
      object Label11: TLabel
        Left = 13
        Top = 168
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dta. Nascim.:'
      end
      object Label12: TLabel
        Left = 221
        Top = 168
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dta. Admiss'#227'o:'
      end
      object Label13: TLabel
        Left = 402
        Top = 168
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dta. Demiss'#227'o:'
      end
      object Label15: TLabel
        Left = 9
        Top = 214
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telef.1/Ramal:'
      end
      object Label18: TLabel
        Left = 9
        Top = 237
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Telef.2/Ramal:'
      end
      object Label19: TLabel
        Left = 12
        Top = 375
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Observa'#231#227'o:'
      end
      object Label20: TLabel
        Left = 262
        Top = 260
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'E-mail:'
      end
      object lblLimCred: TLabel
        Left = 325
        Top = 191
        Width = 149
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lim. de Cr'#233'dito Clientes Novos:'
      end
      object Label22: TLabel
        Left = 30
        Top = 444
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label23: TLabel
        Left = 17
        Top = 283
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label37: TLabel
        Left = 128
        Top = 7
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Situa'#231#227'o:'
      end
      object ColorLabel1: TColorLabel
        Left = 204
        Top = 7
        Width = 75
        Height = 14
        Caption = '(A)tivo (I)nativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object Label24: TLabel
        Left = 297
        Top = 7
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Operador:'
      end
      object lblCodDep: TLabel
        Left = 5
        Top = 329
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento:'
      end
      object LabelCpf1: TLabelCpf
        Left = 54
        Top = 191
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CPF:'
        Pais = opcBrasil
      end
      object LabelRg1: TLabelRg
        Left = 204
        Top = 191
        Width = 24
        Height = 14
        Alignment = taRightJustify
        Caption = 'R.G.:'
        Pais = opcBrasil
      end
      object lbl7: TLabel
        Left = 281
        Top = 237
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'ID-NEXTEL:'
      end
      object lblTipCli: TLabel
        Left = 454
        Top = 489
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Cliente:'
      end
      object clbTipCli: TColorLabel
        Left = 577
        Top = 506
        Width = 92
        Height = 14
        Caption = '(A)tacado (V)arejo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object shpLimCred: TShape
        Left = 566
        Top = 186
        Width = 5
        Height = 22
        Brush.Color = clGreen
      end
      object lblPrazoMedioVenda: TLabel
        Left = 416
        Top = 514
        Width = 111
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prazo M'#233'dio de Venda:'
        Visible = False
      end
      object lblLimCredA: TLabel
        Left = 296
        Top = 214
        Width = 178
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lim. de Cr'#233'dito Clientes + %s Meses:'
      end
      object shpLimCredA: TShape
        Left = 566
        Top = 209
        Width = 5
        Height = 22
        Brush.Color = clGreen
      end
      object lblEmailsB2B: TLabel
        Left = 13
        Top = 420
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'E-mails B2B:'
      end
      object shpInformarSenhaLiberacao: TShape
        Left = 572
        Top = 560
        Width = 5
        Height = 22
        Brush.Color = clGreen
      end
      object lblInformarSenhaLiberacao: TLabel
        Left = 184
        Top = 546
        Width = 343
        Height = 14
        Alignment = taRightJustify
        Caption = 
          'Obrigat'#243'rio informar senha na libera'#231#227'o de qualquer trava do sis' +
          'tema ?'
      end
      object lblTabPre: TLabel
        Left = 6
        Top = 489
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tab. de Pre'#231'o:'
      end
      object clbTabPre: TColorLabel
        Left = 119
        Top = 489
        Width = 120
        Height = 14
        Caption = 'Pre'#231'o de Venda (1) a (7)'
        CorDestaque = clRed
      end
      object Label42: TLabel
        Left = 1
        Top = 351
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ident. do Caixa:'
      end
      object lblMatricula: TLabel
        Left = 10
        Top = 588
        Width = 63
        Height = 28
        Alignment = taRightJustify
        Caption = 'Matr'#237'cula LG Sistemas:'
        WordWrap = True
      end
      object Label25: TLabel
        Left = 324
        Top = 444
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'd. Barras:'
      end
      object lblNumWpp: TLabel
        Left = 19
        Top = 260
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = ' WhatsApp:'
      end
      object imgNumWpp: TImage
        Left = 0
        Top = 258
        Width = 16
        Height = 16
        AutoSize = True
        Center = True
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          000000100803000000282D0F530000000467414D410000B18F0BFC6105000000
          206348524D00007A26000080840000FA00000080E8000075300000EA6000003A
          98000017709CBA513C00000285504C5445EDEDEDFEFEFEFDFDFDFFFFFFEFEFEF
          FBFBFBEEEEEEF0F0F0F1F1F1ECECECE0E0E0F7F8F7FFFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFEFFF9FAF9FBFBFBFFFFFFFCFEFCFAFEFAFFFFFFFB
          FBFBF9F9F9FFFEFFFFFFFFFAFAFAE7E7E7FFFDFFFFFEFFF1F1F1FBFAFAFDFEFD
          FBFDFBFBFBFBFFFDFFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFD
          FFFFFDFFFBF9FBFCFAFBF3F3F3FEFDFDF3F3F3FAFAFAFEFEFEF8F7F8BCBCBCFE
          FDFEF3FBF4F7FBF8F9F8F9E8E9E8FDFDFDF6FBF7FEFDFDFFFDFFF1F9F2FEFCFD
          F7F6F6E6E7E6F8F8F8F8F8F8F6F5F6F0F0F0EEEEEEF6F5F6FCF9FCFEFBFEFEFB
          FEFCFAFCF7F6F7DAF5DDB0EAB598E39FADE9B3D7F4D9EDFAEE9AE3A261D36C55
          D06154D0605FD36B94E19CE9F9EAEEFAEF83DC8C50CD5D55CF6152CE5F7CDA86
          E9F9EB9DE3A54CCB5A89DD93C4EEC967D3734DCB5B4ECB5C93E09CE1F6E35BCE
          6954CC62DAF4DDFFFFFF9FE3A748C8574AC95949C95857CD64D9F4DCB9EABF45
          C65554CB62DEF5E1A6E4AD46C65646C75644C654AFE7B6A2E2AA3FC35042C453
          A7E4AFFBFEFB7CD6873EC34F42C45241C45240C3513FC34F97DFA0A5E2AD3BC1
          4D3CC14E53C862D5F2D9D8F3DB5ECC6C39C04B49C55A59CA683FC2503DC14F3B
          C14C99DFA2C1EBC73DC04F39BF4C37BE4A62CC71DFF4E2E2F6E48BDA96B1E6B8
          EAF8ECA4E2AC43C255B6E8BD5AC96933BC4735BD4859C869BFEAC5F5FCF6D6F1
          DA42C15550C561E4F6E798DDA22FB94331BA4538BD4C64CB7397DCA29FDFA95A
          C86A33BB47A5E1AD80D48D27B53C2BB7412AB7402CB7412AB73F28B63D2FB844
          8BD897F6FBF782D48F89D7959FDEA95CC76D33B9482AB54029B53F32B84757C5
          68AFE4B7FDFEFDCEEED3B4E5BCB3E5BBCCEDD1EFF9F0D58BAB87000000527452
          4E5300000000000000000000000445A5E3FBFCE5AB4C06148DEDF0971A13AAB6
          1A038998063FEAF14E9BADD8E6F1FCEFFBD2E190A036EA3F2AE2830263FAFE9E
          0FA9FCE7E5FEE27A0EC6AE6B323182C4E2E3C788B6487A6D00000001624B4744
          03110C4CF20000000970485973000014C3000014C30115704D42000000077449
          4D4507E60A11142219762A9F280000011B4944415418D3011001EFFE00000102
          0B0C0D0E0F101112131402030400020215161752535454555618191A02030005
          1B1C5758595A5B5B5A5C5D5E1D1E05001F205F60616263636363636164652122
          002324666768696A6B6C6C6C6C676D252600276E6F7071727374757575757677
          78280029797A7B7C727D7A7E7F7F7F7F80812A002B82838485868788898A8B89
          898C8D2C002D8E8F909192939495969798999A9B2E002F9C9D9E9FA0A1A2A3A4
          A5A6A79EA8300031A5A9AAABAAACADAE7272AFB0B1B23200332AB3B4B5B5B4B6
          B7B8B9BABBBC3435003637BDBEBFC0C1C1C2C2C3C4C5C63839003A3BC7C8C9CA
          CBCCCDCECFD03C3D3E06003FD140414243D2D3D4D5D64445460708004748494A
          4B4C4D4E4F50514B0309040AD48F69A2B3084A4B000000257445587464617465
          3A63726561746500323032322D31302D31375432303A33333A34332B30303A30
          301BEDAACA0000002574455874646174653A6D6F6469667900323032322D3130
          2D31375432303A33333A34332B30303A30306AB012760000001974455874536F
          667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000000049
          454E44AE426082}
      end
      object lblAutSenhaOpe: TLabel
        Left = 101
        Top = 569
        Width = 426
        Height = 14
        Alignment = taRightJustify
        Caption = 
          'Carregar automaticamente a senha do operador logado como vendedo' +
          'r no faturamento?'
      end
      object lblTitPorApp: TLabel
        Left = 5
        Top = 467
        Width = 263
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador de controle dos lan'#231'amentos para APP Sales:'
      end
      object lblFuncionario: TLabel
        Left = 21
        Top = 306
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Funcion'#225'rio:'
        Visible = False
      end
      object edtEstado: TEditFocus
        Left = 480
        Top = 140
        Width = 85
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
      object dbeCodOpe: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 2
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODOPE'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNomOpe: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 25
        Width = 485
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_NOMOPE'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtConSenha: TEditFocus
        Tag = 99
        Left = 424
        Top = 48
        Width = 141
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSenha: TEditFocus
        Tag = 99
        Left = 80
        Top = 48
        Width = 141
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
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
      object dbeNomFan: TDBEditFocus
        Left = 80
        Top = 71
        Width = 485
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_NOMFAN'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEndere: TDBEditFocus
        Left = 221
        Top = 94
        Width = 344
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_ENDERE'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBairro: TDBEditFocus
        Left = 80
        Top = 117
        Width = 485
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_BAIRRO'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodCid: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 140
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODCID'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
        OnKeyPress = dbeCodCidKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeCodCidChamaCadastro
      end
      object dbeNumCep: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 94
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_C_E_P_'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        OnKeyPress = dbeNumCepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaNas: TDBEditFocus
        Left = 80
        Top = 163
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_DTANAS'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaAdm: TDBEditFocus
        Left = 298
        Top = 163
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_DTAADM'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaDem: TDBEditFocus
        Left = 480
        Top = 163
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_DTADMI'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFone01: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 209
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_FONE01'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumRg: TDBEditFocus
        Left = 234
        Top = 186
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_NUM_RG'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFone02: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 232
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_FONE02'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 22
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeObse01: TDBEditFocus
        Left = 79
        Top = 370
        Width = 485
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_OBS001'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 32
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeObse02: TDBEditFocus
        Left = 79
        Top = 393
        Width = 485
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_OBS002'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 33
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtCidade: TEditFocus
        Left = 124
        Top = 140
        Width = 259
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeE_mail: TDBEditFocus
        Left = 298
        Top = 255
        Width = 267
        Height = 22
        CharCase = ecLowerCase
        DataField = 'OPE_E_MAIL'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 26
        OnExit = dbeE_mailExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeLimCred: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 186
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_LIMCRE'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodEmp: TDBEditFocus
        Tag = 99
        Left = 79
        Top = 439
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODEMP'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 35
        OnKeyPress = dbeCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeCodEmpChamaCadastro
      end
      object edtDesEmp: TEditFocus
        Left = 123
        Top = 439
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 39
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCodFor: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 278
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODFOR'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 27
        OnKeyPress = dbeCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
        OnChamaCadastro = dbeCodForChamaCadastro
      end
      object edtNomFor: TEditFocus
        Left = 143
        Top = 278
        Width = 422
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 28
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeStatus: TDBEditFocus
        Tag = 99
        Left = 175
        Top = 2
        Width = 23
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_STATUS'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        OnEnter = dbeStatusEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodDep: TDBEditFocus
        Tag = 99
        Left = 79
        Top = 324
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODDEP'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 29
        OnKeyPress = dbeCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
        OnChamaCadastro = dbeCodDepChamaCadastro
      end
      object edtDesDep: TEditFocus
        Left = 142
        Top = 324
        Width = 422
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 31
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeNumCPF: TDBEditCgcCpf
        Tag = 99
        Left = 80
        Top = 186
        Width = 118
        Height = 22
        HelpType = htKeyword
        CharCase = ecUpperCase
        DataField = 'OPE_NUMCPF'
        DataSource = dtsTabela
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
        Tipo = C_G_C_
      end
      object dbeNEXTEL: TDBEditFocus
        Tag = 99
        Left = 341
        Top = 232
        Width = 224
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_NEXTEL'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 24
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRamal1: TDBEditFocus
        Tag = 99
        Left = 173
        Top = 209
        Width = 67
        Height = 22
        DataField = 'OPE_RAMAL1'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRamal2: TDBEditFocus
        Tag = 99
        Left = 173
        Top = 232
        Width = 67
        Height = 22
        DataField = 'OPE_RAMAL2'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeIntExt: TDBLookupComboBoxFocus
        Tag = 99
        Left = 375
        Top = 2
        Width = 190
        Height = 22
        DataField = 'OPE_INTEXT'
        DataSource = dtsTabela
        DropDownRows = 4
        Enabled = False
        KeyField = 'CodTip'
        ListField = 'DesTip'
        ListSource = dtsListTipVen
        TabOrder = 2
        OnExit = dbeIntExtExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeTipCli: TDBEditFocus
        Tag = 99
        Left = 529
        Top = 485
        Width = 35
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_TIPCLI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 40
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePrazoMedioVenda: TDBEditFocus
        Tag = 99
        Left = 529
        Top = 508
        Width = 35
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_PRZMMA'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 42
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeLimCredA: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 209
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_LIMCRA'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object chbPermiteCreditoTransferencia: TDBCheckBox
        Left = 79
        Top = 512
        Width = 271
        Height = 17
        Caption = 'Permitir receber cr'#233'dito em transfer'#234'ncia de valores'
        DataField = 'OPE_PERTRF'
        DataSource = dtsTabela
        TabOrder = 41
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeEmailsB2B: TDBEditFocus
        Tag = 99
        Left = 79
        Top = 416
        Width = 485
        Height = 22
        CharCase = ecLowerCase
        DataField = 'OPE_EMAB2B'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 150
        TabOrder = 34
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeInformarSenhaLiberacao: TDBEditFocus
        Tag = 99
        Left = 529
        Top = 543
        Width = 35
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_SENLIB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 44
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTabPre: TDBEditFocus
        Tag = 99
        Left = 79
        Top = 484
        Width = 35
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_TABPRE'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 38
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeCodCax: TDBEditFocus
        Tag = 99
        Left = 79
        Top = 347
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODCAX'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 30
        OnEnter = dbeCodCaxEnter
        OnExit = dbeCodCaxExit
        OnKeyPress = dbeCodCaxKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtDesCaixa: TEditFocus
        Left = 142
        Top = 347
        Width = 422
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
      object dbeMatricula: TDBEditFocus
        Left = 79
        Top = 588
        Width = 176
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_MATRIC'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 47
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object chkPEDMLT: TDBCheckBox
        Left = 79
        Top = 528
        Width = 317
        Height = 17
        Caption = 'Permitir gerar pedido de compra multi-lojas'
        DataField = 'OPE_PEDMLT'
        DataSource = dtsTabela
        TabOrder = 43
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeCodBar: TDBEditFocus
        Tag = 99
        Left = 388
        Top = 439
        Width = 176
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODBAR'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 36
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumWpp: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 255
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_NUMWPP'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAutSenhaOpe: TDBEditFocus
        Tag = 99
        Left = 529
        Top = 566
        Width = 35
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CASOPE'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 45
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object pnlPortifolioContele: TPanel
        Left = 0
        Top = 624
        Width = 817
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 48
        Visible = False
        object lblIdPortifolioContele: TLabel
          Left = 14
          Top = 7
          Width = 95
          Height = 14
          Caption = 'ID Portif'#243'lio Contele:'
        end
        object btnPortifolioContele: TBitBtnLocked
          Left = 345
          Top = 1
          Width = 117
          Height = 25
          Caption = 'Relacionar Portif'#243'lio'
          TabOrder = 0
          OnClick = btnPortifolioConteleClick
        end
        object dbeIdPortifolioContele: TDBEditFocus
          Left = 117
          Top = 3
          Width = 223
          Height = 22
          Color = 16768952
          DataField = 'OPE_IDCONT'
          DataSource = dtsTabela
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object dbeCodPorApp: TDBEditFocus
        Tag = 99
        Left = 269
        Top = 462
        Width = 49
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_PORAPP'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 37
        OnKeyPress = dbeCodPorAppKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtDesPorApp: TEditFocus
        Left = 319
        Top = 462
        Width = 245
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 49
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeCodFun: TDBEditFocus
        Tag = 99
        Left = 79
        Top = 301
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODFUN'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 50
        Visible = False
        OnKeyPress = dbeCodFunKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeCodFunChamaCadastro
      end
      object edtDesFun: TEditFocus
        Left = 142
        Top = 301
        Width = 422
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 51
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object tsComissao: TTabSheet
      Tag = 2
      Caption = '&2 - Comiss'#227'o / Metas'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label40: TLabel
        Left = 6
        Top = 481
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sub-Gerente:'
      end
      object Label46: TLabel
        Left = 29
        Top = 504
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Gerente:'
      end
      object Label27: TLabel
        Left = 7
        Top = 458
        Width = 64
        Height = 14
        Caption = 'Sal'#225'rio Base:'
      end
      object GroupBox1: TGroupBox
        Left = 392
        Top = 3
        Width = 321
        Height = 100
        Caption = 'Comiss'#227'o - Vendedores'
        TabOrder = 1
        object gpbComPro: TGroupBox
          Left = 3
          Top = 18
          Width = 147
          Height = 82
          Caption = '   Produtos   '
          TabOrder = 0
          Visible = False
          object Label16: TLabel
            Left = 9
            Top = 27
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss'#227'o:'
          end
          object lbl2: TLabel
            Left = 170
            Top = 29
            Width = 42
            Height = 14
            Caption = '('#224' Vista)'
          end
          object lbl3: TLabel
            Left = 170
            Top = 52
            Width = 45
            Height = 14
            Caption = '('#224' Prazo)'
          end
          object lbl1: TLabel
            Left = 9
            Top = 50
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss'#227'o:'
          end
          object dbePerCom: TDBEditFocus
            Tag = 99
            Left = 76
            Top = 24
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_PERCOM'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePerCo2: TDBEditFocus
            Tag = 99
            Left = 76
            Top = 47
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_PERCO2'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object gpbComAti: TGroupBox
          Left = 90
          Top = 9
          Width = 231
          Height = 91
          Caption = '   Produtos   '
          TabOrder = 1
          Visible = False
          object Label28: TLabel
            Left = 9
            Top = 18
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss'#227'o:'
          end
          object Label29: TLabel
            Left = 175
            Top = 20
            Width = 41
            Height = 14
            Caption = 'Atacado'
          end
          object Label30: TLabel
            Left = 175
            Top = 43
            Width = 31
            Height = 14
            Caption = 'Varejo'
          end
          object Label31: TLabel
            Left = 9
            Top = 41
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss'#227'o:'
          end
          object Label32: TLabel
            Left = 9
            Top = 63
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = '% Comiss'#227'o:'
          end
          object Label33: TLabel
            Left = 175
            Top = 65
            Width = 15
            Height = 14
            Caption = 'SM'
          end
          object dbeComAta: TDBEditFocus
            Tag = 99
            Left = 76
            Top = 15
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_COMATA'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeComVar: TDBEditFocus
            Tag = 99
            Left = 76
            Top = 38
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_COMVAR'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCom_SM: TDBEditFocus
            Tag = 99
            Left = 76
            Top = 60
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_COM_SM'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object gpbSubGer: TGroupBox
        Left = 3
        Top = 3
        Width = 383
        Height = 100
        Caption = 'Comiss'#227'o / Meta - Vendedores'
        TabOrder = 0
        object Label35: TLabel
          Left = 91
          Top = 23
          Width = 196
          Height = 14
          Alignment = taRightJustify
          Caption = '% Comiss'#227'o sobre meta de faturamento:'
        end
        object Label36: TLabel
          Left = 5
          Top = 46
          Width = 282
          Height = 14
          Alignment = taRightJustify
          Caption = '% Comiss'#227'o aceleradora sobre meta faturamento atingida:'
        end
        object Label38: TLabel
          Left = 25
          Top = 69
          Width = 262
          Height = 14
          Alignment = taRightJustify
          Caption = '% Comiss'#227'o aceleradora sobre meta margem atingida:'
        end
        object dbeComCMF: TDBEditFocus
          Tag = 99
          Left = 289
          Top = 20
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_COMCMF'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComCFA: TDBEditFocus
          Tag = 99
          Left = 289
          Top = 43
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_COMCFA'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComCMA: TDBEditFocus
          Tag = 99
          Left = 289
          Top = 66
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_COMCMA'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object dbeCodSub: TDBEditFocus
        Tag = 99
        Left = 77
        Top = 478
        Width = 28
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODSUB'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        OnKeyPress = dbeCodSubKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object edtDesSub: TEditFocus
        Left = 106
        Top = 478
        Width = 218
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object dbeCodGer: TDBEditFocus
        Tag = 99
        Left = 77
        Top = 501
        Width = 28
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_CODGER'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        OnKeyPress = dbeCodGerKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object edtDesGer: TEditFocus
        Left = 106
        Top = 501
        Width = 218
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
      object dbeSalBas: TDBEditFocus
        Tag = 99
        Left = 77
        Top = 455
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_SALBAS'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object grpComMecanicos: TGroupBox
        Left = 3
        Top = 109
        Width = 383
        Height = 100
        Caption = 'Comiss'#227'o - Mec'#226'nicos'
        TabOrder = 2
        object lbl4: TLabel
          Left = 23
          Top = 45
          Width = 96
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o Produtos:'
        end
        object lbl5: TLabel
          Left = 23
          Top = 68
          Width = 96
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o Servi'#231'os:'
        end
        object Label162: TLabel
          Left = 31
          Top = 24
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Comiss'#227'o:'
        end
        object ColorLabel31: TColorLabel
          Left = 151
          Top = 24
          Width = 96
          Height = 14
          Caption = '(P)ercentual (V)alor'
          CorDestaque = clRed
        end
        object lblMecCItPerVal: TLabel
          Left = 216
          Top = 45
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblMecCSePerVal: TLabel
          Left = 216
          Top = 69
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object dbeMecCIt: TDBEditFocus
          Tag = 99
          Left = 123
          Top = 42
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_MECCIT'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMecCSe: TDBEditFocus
          Tag = 99
          Left = 123
          Top = 65
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_MECCSE'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTpCoMc: TDBEditFocus
          Tag = 99
          Left = 123
          Top = 19
          Width = 22
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_TPCOMC'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = dbeTpCoMcExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object grbComSerVen: TGroupBox
        Left = 392
        Top = 109
        Width = 321
        Height = 100
        Caption = 'Comiss'#227'o - Vendedores'
        TabOrder = 3
        object grbComSer: TGroupBox
          Left = 2
          Top = 16
          Width = 317
          Height = 82
          Align = alClient
          Caption = '   Servi'#231'os   '
          TabOrder = 0
          object Label17: TLabel
            Left = 15
            Top = 26
            Width = 88
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Comiss'#227'o:'
          end
          object ColorLabel2: TColorLabel
            Left = 137
            Top = 26
            Width = 96
            Height = 14
            Caption = '(P)ercentual (V)alor'
            CorDestaque = clRed
          end
          object Label26: TLabel
            Left = 25
            Top = 49
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Comiss'#227'o:'
          end
          object lblTpComSerVen: TLabel
            Left = 203
            Top = 47
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object dbeTpCoVn: TDBEditFocus
            Tag = 99
            Left = 109
            Top = 21
            Width = 22
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_TPCOVN'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeTpCoVnExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeVenCSe: TDBEditFocus
            Tag = 99
            Left = 109
            Top = 46
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_VENCSE'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object grbRotinaFlex: TGroupBox
        Left = 3
        Top = 211
        Width = 708
        Height = 82
        Caption = 'Rotina Flex'
        TabOrder = 9
        object Label44: TLabel
          Left = 103
          Top = 29
          Width = 348
          Height = 14
          Caption = 
            'Percentual de distribui'#231#227'o na baixa de cr'#233'ditos FLEX - Parte da ' +
            'Empresa'
        end
        object Label45: TLabel
          Left = 103
          Top = 52
          Width = 353
          Height = 14
          Caption = 
            'Percentual de distribui'#231#227'o na baixa de cr'#233'ditos FLEX - Parte do ' +
            'Vendedor'
        end
        object dbePEEMFL: TDBEditFocus
          Tag = 99
          Left = 9
          Top = 24
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_PEEMFL'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePEOPFL: TDBEditFocus
          Tag = 99
          Left = 9
          Top = 47
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_PEOPFL'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object grpComAssTec: TGroupBox
        Left = 3
        Top = 295
        Width = 383
        Height = 154
        Caption = 'Comiss'#227'o - Assist'#234'ncia T'#233'cnica'
        TabOrder = 10
        Visible = False
        object pnlComAte: TPanel
          Left = 2
          Top = 16
          Width = 379
          Height = 55
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label43: TLabel
            Left = 183
            Top = 8
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label47: TLabel
            Left = 7
            Top = 8
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Comiss'#227'o:'
          end
          object dbeComATe: TDBEditFocus
            Tag = 99
            Left = 86
            Top = 5
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'OPE_COMATE'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object pnlTecnico: TPanel
            Left = 0
            Top = 28
            Width = 379
            Height = 27
            Align = alBottom
            BevelOuter = bvLowered
            TabOrder = 1
            object lblNomTec: TLabel
              Left = 44
              Top = 5
              Width = 41
              Height = 14
              Alignment = taRightJustify
              Caption = 'T'#233'cnico:'
            end
            object edtCodTec: TEditFocus
              Tag = 99
              Left = 86
              Top = 2
              Width = 35
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 3
              TabOrder = 0
              OnExit = edtCodTecExit
              OnKeyPress = edtCodTecKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttNumerico
            end
            object edtNomTec: TEditFocus
              Left = 122
              Top = 2
              Width = 185
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object btnAdicionaTec: TBitBtnLocked
              Left = 311
              Top = 1
              Width = 65
              Height = 23
              Caption = '&Inserir'
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
              OnClick = btnAdicionaTecClick
            end
          end
        end
        object dbgOpeTec: TDBGridCitel
          Tag = 99
          Left = 2
          Top = 71
          Width = 379
          Height = 81
          Align = alClient
          DataSource = dtsOpeATe
          Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyDown = dbgOpeTecKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'CODTEC'
              Title.Caption = 'C'#243'digo'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOMTEC'
              Title.Caption = 'Nome do T'#233'cnico'
              Width = 301
              Visible = True
            end>
        end
      end
    end
    object tsFinanceiro: TTabSheet
      Caption = '&3 - Financeiro'
      ImageIndex = 2
      OnShow = tsFinanceiroShow
      object pnlPortadores: TPanel
        Left = 0
        Top = 0
        Width = 817
        Height = 655
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblclbPortadores: TLabel
          Left = 5
          Top = 523
          Width = 95
          Height = 14
          Cursor = crHandPoint
          Caption = 'Op'#231#245'es de Sele'#231#227'o'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblclbPortadoresClick
        end
        object clbPortadores: TCheckListBox
          Left = 1
          Top = 72
          Width = 722
          Height = 448
          OnClickCheck = clbPortadoresClickCheck
          Align = alCustom
          Enabled = False
          ItemHeight = 14
          TabOrder = 0
        end
        object pnlTitPor: TPanel
          Left = 1
          Top = 1
          Width = 815
          Height = 41
          Align = alTop
          Caption = 'Portadores'
          Color = clActiveCaption
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object tbsComForEsp: TTabSheet
      Caption = '&4 - Comiss'#227'o Fornecedores Espec'#237'ficos'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbl20: TLabel
        Left = 8
        Top = 5
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor'
      end
      object Label14: TLabel
        Left = 440
        Top = 5
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o'
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 8
        Top = 20
        Width = 78
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttInteiro
      end
      object edtNomForn: TEditFocus
        Left = 88
        Top = 20
        Width = 349
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object dbgForCom: TDBGridCitel
        Left = 8
        Top = 47
        Width = 769
        Height = 437
        DataSource = dtsComFor
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
        ReadOnly = True
        TabOrder = 5
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgForComDblClick
        OnEnter = dbgForComEnter
        OnExit = dbgForComExit
        OnKeyDown = dbgForComKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'FOR_CODFOR'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FOR_NOMFOR'
            Title.Caption = 'Nome do Fornecedor'
            Width = 346
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FOR_PERCOM'
            Title.Caption = 'Comiss'#227'o'
            Width = 67
            Visible = True
          end>
      end
      object edtComFor: TCurrencyEditFocus
        Left = 440
        Top = 20
        Properties.DisplayFormat = '0.00;-0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 70
      end
      object btnAddComFor: TBitBtnLocked
        Left = 518
        Top = 19
        Width = 31
        Height = 22
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
        TabOrder = 3
        OnClick = btnAddComForClick
      end
      object btnRemComFor: TBitBtnLocked
        Left = 555
        Top = 19
        Width = 31
        Height = 22
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
        OnClick = btnRemComForClick
      end
    end
    object tbsAcessoEmp: TTabSheet
      Caption = '&5 - Acesso Empresa'
      ImageIndex = 4
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 817
        Height = 655
        Align = alLeft
        ParentColor = True
        TabOrder = 0
        object lblclbGeral: TLabel
          Left = 663
          Top = 519
          Width = 145
          Height = 14
          Cursor = crHandPoint
          Caption = 'Op'#231#245'es de Sele'#231#227'o (Geral)'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblclbGeralClick
        end
        object gpbEmpresaAcesso: TGroupBox
          Left = 3
          Top = 135
          Width = 260
          Height = 132
          Caption = 'Empresas - Acesso'
          TabOrder = 1
          object lblclbEmpresa: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpresaClick
          end
          object btnHlpEmpresa: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpEmpresaClick
          end
          object clbEmpresa: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbEmpresaIncRom: TGroupBox
          Left = 3
          Top = 270
          Width = 260
          Height = 132
          Caption = 'Empresas - Inclus'#227'o/Baixa de Romaneio'
          TabOrder = 2
          object lblclbIncRom: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbIncRomClick
          end
          object btnHlpRom: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpRomClick
          end
          object clbIncRom: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbBaixaReceber: TGroupBox
          Left = 3
          Top = 404
          Width = 260
          Height = 132
          Caption = 'Empresas - Baixa Contas a Receber'
          TabOrder = 3
          object lblclbBaixaReceber: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbBaixaReceberClick
          end
          object btnHlpBaixaReceber: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpBaixaReceberClick
          end
          object clbBaixaReceber: TCheckListBox
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbEmpresaLogin: TGroupBox
          Left = 5
          Top = 1
          Width = 260
          Height = 132
          Caption = 'Empresas - Login'
          TabOrder = 0
          object lblclbLogin: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbLoginClick
          end
          object btnHlpLogin: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpLoginClick
          end
          object clbLogin: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            OnClickCheck = clbLoginClickCheck
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbBaixaPagar: TGroupBox
          Left = 278
          Top = 1
          Width = 260
          Height = 132
          Caption = 'Empresas - Baixa de Contas a Pagar'
          TabOrder = 4
          object lblclbBaixaPagar: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbBaixaPagarClick
          end
          object btnHlpBaixaPagar: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpBaixaPagarClick
          end
          object clbBaixaPagar: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbEmpresaEstoque: TGroupBox
          Left = 278
          Top = 135
          Width = 260
          Height = 132
          Caption = 'Empresas - Estoque'
          TabOrder = 5
          object lblclbEmpEst: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpEstClick
          end
          object btnHlpEmpEst: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpEmpEstClick
          end
          object clbEmpEst: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbEmpConsVendFatur: TGroupBox
          Left = 278
          Top = 270
          Width = 260
          Height = 132
          Caption = 'Empresas - Consultas Vendas Faturamento'
          TabOrder = 6
          object lblclbEmpConsVendFatur: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpConsVendFaturClick
          end
          object btnHlpConsVendFutur: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpConsVendFuturClick
          end
          object clbEmpConsVendFatur: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbEmpLibRemota: TGroupBox
          Left = 278
          Top = 404
          Width = 260
          Height = 132
          Caption = 'Empresas - Acesso para receber libera'#231#227'o remota'
          TabOrder = 7
          object lblclbEmpLibRemota: TLabel
            Left = 3
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpLibRemotaClick
          end
          object btnHlpLibRemota: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpLibRemotaClick
          end
          object clbEmpLibRemota: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object grpMltLjs: TGroupBox
          Left = 550
          Top = 1
          Width = 260
          Height = 132
          Caption = 'Empresas - Multi-Lojas'
          TabOrder = 8
          object lblclbEmpMltLjs: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpMltLjsClick
          end
          object btnHlpEmpMltLjs: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpEmpMltLjsClick
          end
          object clbEmpMltLjs: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object grpEstMin: TGroupBox
          Left = 549
          Top = 135
          Width = 260
          Height = 132
          Caption = 'Empresas - Acesso p/ receber mens. Estoque M'#237'n.'
          TabOrder = 9
          object lblclbEmpEstMin: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpEstMinClick
          end
          object btnHlpEmpEstMin: TSpeedButton
            Left = 240
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpEmpMltLjsClick
          end
          object clbEmpEstMin: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object gpbEmpReimpressaoDocs: TGroupBox
          Left = 550
          Top = 270
          Width = 260
          Height = 132
          Caption = 'Empresas - Reimpress'#227'o de Documento'
          TabOrder = 10
          object lblclbEmpReimpressaoDocs: TLabel
            Left = 4
            Top = 115
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Op'#231#245'es de Sele'#231#227'o'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblclbEmpReimpressaoDocsClick
          end
          object btnHlpReimpressaoDocs: TSpeedButton
            Left = 237
            Top = 114
            Width = 20
            Height = 18
            Hint = 'Ajuda'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnHlpReimpressaoDocsClick
          end
          object clbEmpReimpressaoDocs: TCheckListBox
            Tag = 99
            Left = 2
            Top = 14
            Width = 256
            Height = 101
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
      end
    end
    object tbsEmail: TTabSheet
      Caption = '&6 - e-Mail'
      ImageIndex = 5
      object grbProvedor: TGroupBox
        Left = 0
        Top = 0
        Width = 817
        Height = 474
        Align = alClient
        Caption = '   Configura'#231#245'es de e-Mail   '
        TabOrder = 0
        object pnlEmailTop: TPanel
          Left = 2
          Top = 16
          Width = 813
          Height = 153
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label21: TLabel
            Left = 7
            Top = 8
            Width = 54
            Height = 14
            Alignment = taRightJustify
            Caption = 'Remetente:'
          end
          object lblProvedor: TLabel
            Left = 14
            Top = 32
            Width = 47
            Height = 14
            Caption = 'Provedor:'
          end
          object Label34: TLabel
            Left = 30
            Top = 56
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'e-Mail:'
          end
          object Label39: TLabel
            Left = 32
            Top = 80
            Width = 29
            Height = 14
            Alignment = taRightJustify
            Caption = 'Login:'
          end
          object lblSenhaEmail: TLabel
            Left = 27
            Top = 105
            Width = 34
            Height = 14
            Caption = 'Senha:'
          end
          object edtSenhaEmail: TEditFocus
            Tag = 99
            Left = 62
            Top = 102
            Width = 131
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 25
            PasswordChar = '*'
            TabOrder = 4
            OnChange = edtEmailChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 25
            TipoTexto = ttAlfanumerico
          end
          object chkMostrarSenha: TCheckBox
            Tag = 99
            Left = 197
            Top = 105
            Width = 95
            Height = 17
            Caption = 'Mostrar senha?'
            TabOrder = 5
            Visible = False
            OnClick = chkMostrarSenhaClick
          end
          object btnValidarDadosEmail: TBitBtnLocked
            Left = 293
            Top = 102
            Width = 74
            Height = 22
            Caption = 'Validar dados'
            Enabled = False
            TabOrder = 6
            OnClick = btnValidarDadosEmailClick
          end
          object pnlValidaDadosConta: TPanel
            Left = 62
            Top = 125
            Width = 320
            Height = 30
            BevelOuter = bvNone
            Enabled = False
            TabOrder = 10
            object btnDadosSmtp: TSpeedButton
              Left = 0
              Top = 5
              Width = 98
              Height = 22
              Caption = 'Provedor SMTP'
              Flat = True
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000030000
                000B000000120000001300000013000000140000001400000014000000140000
                0014000000140000001500000015000000140000000D000000030000000B1C11
                6CC3261796FF271696FF261695FF261594FF251594FF251594FF241394FF2412
                93FF241292FF231292FF231192FF231191FF190C68C50000000C0000000F2B1C
                9BFF384AD3FF2637CEFF3042D2FF4254D9FF3646D4FF2437CCFF2434CCFF3444
                D3FF3C4ED6FF2A3ACEFF202FC9FF1E2CC9FF251595FF000000120000000F3121
                A0FF4356D7FF374BD5FF3F4BCBFF2827ABFF363CBEFF3E4FD6FF3D4ED5FF353A
                BEFF2827ABFF3B45C9FF2F41D0FF2332CCFF291A99FF000000120000000E3529
                A5FF4E62DBFF444FCCFF605DBDFFEDEDF8FF8B89CEFF383CBCFF383CBBFF8B89
                CEFFEDEDF8FF5F5DBDFF3D47C9FF293ACEFF2D1F9EFF000000110000000D392F
                ABFF596FDFFF2722A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
                EDFFF3E9E2FFECE6EBFF2721A5FF2F42D1FF3326A3FF0000000F0000000C4036
                B1FF657AE2FF3135B7FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
                E2FFEADAD1FF7F6FACFF2E31B6FF3549D5FF372CA9FF0000000E0000000B453D
                B6FF6E83E5FF485EDCFF393BB7FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
                E5FF897DB8FF3739B6FF4054D9FF3D51D7FF3C33AFFF0000000D0000000A4A44
                BCFF788FE8FF6077E3FF4B4BBBFF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
                E8FF9087C5FF4949BAFF596FDFFF4359DAFF423AB4FF0000000C00000009504C
                C2FF92A7EEFF5655BCFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
                EAFFFAF5F2FF8F89CAFF5453BCFF6278E2FF4943B9FF0000000B000000086B6A
                D0FFADC1F4FF2A1E9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
                D8FFF4ECE7FFE5D9DCFF2A1D9BFF8B9EEBFF6563C9FF0000000A000000077577
                D6FFB1C6F5FF6E77D1FF5747A1FFCCB6BCFF7A68A8FF4E4CB7FF4F4EB8FF7A68
                A8FFCBB5BCFF5746A1FF6B75D0FF8EA1ECFF706ED0FF0000000900000006797B
                DAFFB5CAF6FF93A7EEFF7079D2FF2E229BFF5453BBFF93A7EEFF93A7EEFF5555
                BCFF2E219BFF6F77D1FF91A4EDFF90A3EDFF7475D4FF00000008000000057D80
                DEFFB9CDF6FFB9CDF6FFB9CCF6FFB9CCF6FFB9CDF6FFB8CCF6FFB8CCF6FFB7CC
                F6FFB7CBF6FFB6CBF6FFB5C9F6FFB5C9F6FF787AD8FF00000006000000036062
                A6C08184E1FF8183E0FF8083E0FF7F83DFFF7F83DFFF7F82DFFF7E81DFFF7E81
                DEFF7D81DEFF7D80DEFF7D7FDEFF7C7FDDFF5C5EA3C100000004000000000000
                0002000000030000000400000004000000040000000400000004000000040000
                0004000000040000000400000005000000050000000300000001}
            end
            object btnDadosImap: TSpeedButton
              Left = 209
              Top = 5
              Width = 96
              Height = 22
              Caption = 'Provedor IMAP'
              Flat = True
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000030000
                000B000000120000001300000013000000140000001400000014000000140000
                0014000000140000001500000015000000140000000D000000030000000B1C11
                6CC3261796FF271696FF261695FF261594FF251594FF251594FF241394FF2412
                93FF241292FF231292FF231192FF231191FF190C68C50000000C0000000F2B1C
                9BFF384AD3FF2637CEFF3042D2FF4254D9FF3646D4FF2437CCFF2434CCFF3444
                D3FF3C4ED6FF2A3ACEFF202FC9FF1E2CC9FF251595FF000000120000000F3121
                A0FF4356D7FF374BD5FF3F4BCBFF2827ABFF363CBEFF3E4FD6FF3D4ED5FF353A
                BEFF2827ABFF3B45C9FF2F41D0FF2332CCFF291A99FF000000120000000E3529
                A5FF4E62DBFF444FCCFF605DBDFFEDEDF8FF8B89CEFF383CBCFF383CBBFF8B89
                CEFFEDEDF8FF5F5DBDFF3D47C9FF293ACEFF2D1F9EFF000000110000000D392F
                ABFF596FDFFF2722A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
                EDFFF3E9E2FFECE6EBFF2721A5FF2F42D1FF3326A3FF0000000F0000000C4036
                B1FF657AE2FF3135B7FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
                E2FFEADAD1FF7F6FACFF2E31B6FF3549D5FF372CA9FF0000000E0000000B453D
                B6FF6E83E5FF485EDCFF393BB7FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
                E5FF897DB8FF3739B6FF4054D9FF3D51D7FF3C33AFFF0000000D0000000A4A44
                BCFF788FE8FF6077E3FF4B4BBBFF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
                E8FF9087C5FF4949BAFF596FDFFF4359DAFF423AB4FF0000000C00000009504C
                C2FF92A7EEFF5655BCFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
                EAFFFAF5F2FF8F89CAFF5453BCFF6278E2FF4943B9FF0000000B000000086B6A
                D0FFADC1F4FF2A1E9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
                D8FFF4ECE7FFE5D9DCFF2A1D9BFF8B9EEBFF6563C9FF0000000A000000077577
                D6FFB1C6F5FF6E77D1FF5747A1FFCCB6BCFF7A68A8FF4E4CB7FF4F4EB8FF7A68
                A8FFCBB5BCFF5746A1FF6B75D0FF8EA1ECFF706ED0FF0000000900000006797B
                DAFFB5CAF6FF93A7EEFF7079D2FF2E229BFF5453BBFF93A7EEFF93A7EEFF5555
                BCFF2E219BFF6F77D1FF91A4EDFF90A3EDFF7475D4FF00000008000000057D80
                DEFFB9CDF6FFB9CDF6FFB9CCF6FFB9CCF6FFB9CDF6FFB8CCF6FFB8CCF6FFB7CC
                F6FFB7CBF6FFB6CBF6FFB5C9F6FFB5C9F6FF787AD8FF00000006000000036062
                A6C08184E1FF8183E0FF8083E0FF7F83DFFF7F83DFFF7F82DFFF7E81DFFF7E81
                DEFF7D81DEFF7D80DEFF7D7FDEFF7C7FDDFF5C5EA3C100000004000000000000
                0002000000030000000400000004000000040000000400000004000000040000
                0004000000040000000400000005000000050000000300000001}
            end
            object btnAutenticacaoSmtp: TSpeedButton
              Left = 105
              Top = 5
              Width = 98
              Height = 22
              Caption = 'Autent. SMTP'
              Flat = True
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000030000
                000B000000120000001300000013000000140000001400000014000000140000
                0014000000140000001500000015000000140000000D000000030000000B1C11
                6CC3261796FF271696FF261695FF261594FF251594FF251594FF241394FF2412
                93FF241292FF231292FF231192FF231191FF190C68C50000000C0000000F2B1C
                9BFF384AD3FF2637CEFF3042D2FF4254D9FF3646D4FF2437CCFF2434CCFF3444
                D3FF3C4ED6FF2A3ACEFF202FC9FF1E2CC9FF251595FF000000120000000F3121
                A0FF4356D7FF374BD5FF3F4BCBFF2827ABFF363CBEFF3E4FD6FF3D4ED5FF353A
                BEFF2827ABFF3B45C9FF2F41D0FF2332CCFF291A99FF000000120000000E3529
                A5FF4E62DBFF444FCCFF605DBDFFEDEDF8FF8B89CEFF383CBCFF383CBBFF8B89
                CEFFEDEDF8FF5F5DBDFF3D47C9FF293ACEFF2D1F9EFF000000110000000D392F
                ABFF596FDFFF2722A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
                EDFFF3E9E2FFECE6EBFF2721A5FF2F42D1FF3326A3FF0000000F0000000C4036
                B1FF657AE2FF3135B7FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
                E2FFEADAD1FF7F6FACFF2E31B6FF3549D5FF372CA9FF0000000E0000000B453D
                B6FF6E83E5FF485EDCFF393BB7FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
                E5FF897DB8FF3739B6FF4054D9FF3D51D7FF3C33AFFF0000000D0000000A4A44
                BCFF788FE8FF6077E3FF4B4BBBFF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
                E8FF9087C5FF4949BAFF596FDFFF4359DAFF423AB4FF0000000C00000009504C
                C2FF92A7EEFF5655BCFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
                EAFFFAF5F2FF8F89CAFF5453BCFF6278E2FF4943B9FF0000000B000000086B6A
                D0FFADC1F4FF2A1E9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
                D8FFF4ECE7FFE5D9DCFF2A1D9BFF8B9EEBFF6563C9FF0000000A000000077577
                D6FFB1C6F5FF6E77D1FF5747A1FFCCB6BCFF7A68A8FF4E4CB7FF4F4EB8FF7A68
                A8FFCBB5BCFF5746A1FF6B75D0FF8EA1ECFF706ED0FF0000000900000006797B
                DAFFB5CAF6FF93A7EEFF7079D2FF2E229BFF5453BBFF93A7EEFF93A7EEFF5555
                BCFF2E219BFF6F77D1FF91A4EDFF90A3EDFF7475D4FF00000008000000057D80
                DEFFB9CDF6FFB9CDF6FFB9CCF6FFB9CCF6FFB9CDF6FFB8CCF6FFB8CCF6FFB7CC
                F6FFB7CBF6FFB6CBF6FFB5C9F6FFB5C9F6FF787AD8FF00000006000000036062
                A6C08184E1FF8183E0FF8083E0FF7F83DFFF7F83DFFF7F82DFFF7E81DFFF7E81
                DEFF7D81DEFF7D80DEFF7D7FDEFF7C7FDDFF5C5EA3C100000004000000000000
                0002000000030000000400000004000000040000000400000004000000040000
                0004000000040000000400000005000000050000000300000001}
            end
          end
          object btnAjudaProvedores: TBitBtnLocked
            Left = 492
            Top = 29
            Width = 27
            Height = 22
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              499191480000000000000000000000009AECEB91000000000000000000000000
              E309F49A00000000000000000000000049E3A349000000000000000000000000
              00000000000000000000000000000000009A9949000000000000000000000000
              00A309E2480000000000000000000000009AEC09E29100000000000000005191
              49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
              EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
              A3EC09EC9A000000000000000000000000000000000000000000}
            Spacing = 2
            TabOrder = 8
            TabStop = False
            Visible = False
            OnClick = btnAjudaProvedoresClick
          end
          object btnLimparDadosProvedor: TBitBtnLocked
            Left = 369
            Top = 29
            Width = 122
            Height = 22
            Caption = 'Limpar dados provedor'
            Enabled = False
            TabOrder = 7
            OnClick = btnLimparDadosProvedorClick
          end
          object grbEmailEmps: TGroupBox
            Tag = 99
            Left = 522
            Top = 5
            Width = 279
            Height = 144
            Caption = 'Empresas'
            TabOrder = 9
            object lblEmailOpc: TLabel
              Left = 4
              Top = 125
              Width = 95
              Height = 14
              Cursor = crHandPoint
              Caption = 'Op'#231#245'es de Sele'#231#227'o'
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsUnderline]
              ParentFont = False
              OnClick = lblEmailOpcClick
            end
            object btnEmailHelp: TSpeedButton
              Left = 233
              Top = 125
              Width = 20
              Height = 18
              Hint = 'Ajuda'
              Flat = True
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                0800000000000001000000000000000000000001000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                A6000020400000206000002080000020A0000020C0000020E000004000000040
                20000040400000406000004080000040A0000040C0000040E000006000000060
                20000060400000606000006080000060A0000060C0000060E000008000000080
                20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                20004000400040006000400080004000A0004000C0004000E000402000004020
                20004020400040206000402080004020A0004020C0004020E000404000004040
                20004040400040406000404080004040A0004040C0004040E000406000004060
                20004060400040606000406080004060A0004060C0004060E000408000004080
                20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                20008000400080006000800080008000A0008000C0008000E000802000008020
                20008020400080206000802080008020A0008020C0008020E000804000008040
                20008040400080406000804080008040A0008040C0008040E000806000008060
                20008060400080606000806080008060A0008060C0008060E000808000008080
                20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                499191480000000000000000000000009AECEB91000000000000000000000000
                E309F49A00000000000000000000000049E3A349000000000000000000000000
                00000000000000000000000000000000009A9949000000000000000000000000
                00A309E2480000000000000000000000009AEC09E29100000000000000005191
                49009A0909EC9100000000000000E309E3499AEC0909DA00000000000000A309
                EC9AA3EC09099A0000000000000049EC09ECEC0909E300000000000000000049
                A3EC09EC9A000000000000000000000000000000000000000000}
              ParentShowHint = False
              ShowHint = True
              OnClick = btnHlpLoginClick
            end
            object clbEmailEmps: TCheckListBox
              Tag = 99
              Left = 2
              Top = 14
              Width = 274
              Height = 110
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemHeight = 14
              TabOrder = 0
            end
          end
          object edtRemetente: TEditFocus
            Tag = 99
            Left = 62
            Top = 5
            Width = 305
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEmail: TEditFocus
            Tag = 99
            Left = 62
            Top = 53
            Width = 305
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecLowerCase
            TabOrder = 2
            OnChange = edtEmailChange
            OnExit = edtEmailExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtLogin: TEditFocus
            Tag = 99
            Left = 62
            Top = 77
            Width = 305
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 100
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 100
            TipoTexto = ttAlfanumerico
          end
          object cmbProvedores: TcxLookupComboBox
            Tag = 99
            Left = 62
            Top = 29
            Enabled = False
            Properties.KeyFieldNames = 'PRV_CODPRV'
            Properties.ListColumns = <
              item
                FieldName = 'PRV_NOMPRV'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListOptions.SyncMode = True
            StyleFocused.Color = clInfoBk
            TabOrder = 1
            OnClick = cmbProvedoresClick
            Width = 305
          end
        end
        object pnlEmailCenter: TPanel
          Left = 2
          Top = 169
          Width = 813
          Height = 303
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object grbAssinaturaEmail: TGroupBox
            Left = 0
            Top = 0
            Width = 813
            Height = 303
            Align = alClient
            Caption = '   Assinatura   '
            Enabled = False
            TabOrder = 0
            object grbAssinaturaTexto: TGroupBox
              Left = 2
              Top = 16
              Width = 354
              Height = 285
              Align = alLeft
              Caption = '   Texto   '
              TabOrder = 0
              object mmoAssinatura: TMemoFocus
                Left = 2
                Top = 16
                Width = 350
                Height = 267
                Align = alClient
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                StringQuebra = '<<csq>>'
              end
            end
            object grbAssinaturaImagem: TGroupBox
              Left = 366
              Top = 16
              Width = 445
              Height = 285
              Align = alRight
              Caption = '   Imagem   '
              TabOrder = 1
              object imgAssinatura: TImage
                Tag = 99
                Left = 2
                Top = 16
                Width = 441
                Height = 244
                Align = alClient
                Center = True
                Enabled = False
                Proportional = True
                ExplicitLeft = 0
                ExplicitWidth = 352
                ExplicitHeight = 291
              end
              object pnlBotoesAssinatura: TPanel
                Left = 2
                Top = 260
                Width = 441
                Height = 23
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 0
                object btnAdicionarAssinatura: TBitBtnLocked
                  Left = 3
                  Top = 2
                  Width = 72
                  Height = 20
                  Caption = 'Adicionar'
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000000000000000
                    00000000000000000000000000000000000100000003000000080000000C0000
                    000E0000000D0000000800000003000000010000000000000000000000020000
                    000A00000010000000110000001300000018050E0A3F16412DAC216043EC256A
                    48FF216141ED163F2BAC050E09390000000900000001000000000000000A7B50
                    43C2AB705CFFAB6F5AFFC29A8CFFA2A191FF307554FF2D9D71FF24BA82FF23CB
                    8EFF23BA82FF25986BFF2C7050FD0A1E145C00000006000000000000000EAD73
                    5FFFFDFBF9FFFAF4F2FFDCE4DEFF388260FF40C397FF28CD92FF40956DFF487E
                    5DFF3F946CFF26CD91FF27BA84FF297150F5050F0A2F000000030000000EB077
                    62FFFDFBFAFFF6EFEBFF80AD96FF54B593FF36D29CFF2ECE95FF4A8362FFFFFF
                    FFFF4A8161FF2CD096FF2CCF95FF31A87AFF1B4833A1000000060000000CB079
                    66FFFDFBFBFFF7F2EFFF499371FF6CDBBBFF469D76FF4D8865FF4D8765FFF6F1
                    EBFF4D8665FF4D8664FF459B73FF33C892FF2B7453E7000000080000000BB37C
                    69FFFEFCFBFFF8F4F1FF3C926DFF81E9CCFF508C6AFFEADBD3FFF8F3EFFFF9F3
                    EFFFF8F3EFFFFFFFFFFF4E8968FF3FD5A3FF348662FA000000080000000AB67F
                    6CFFFEFDFCFFF8F3F1FF4FA07DFFB1E9D8FF6CA98CFF528F6EFF528F6DFFFAF5
                    F3FF528F6CFF518E6BFF5EA583FF76DCBBFF338260E70000000700000009B983
                    71FFFEFDFCFFFAF5F2FF8CC2AAFF94CBB5FFE2FAF5FFC5F5E9FF539371FFECDE
                    D8FF539270FFABF0DDFFB0F1DEFF84C6ADFF2358419A0000000400000007BC88
                    77FFFEFEFDFFFBF4F0FFE4ECE6FF4EAA84FFC8E7DBFFEEFDFAFF7AB095FF5696
                    74FF74AF94FFD9F9F2FFBEE5D8FF3E9873F208130E250000000100000006BF8C
                    7AFFFEFEFDFFFBF6F1FFFBF6F4FFC9E2D5FF4FAD85FF93CEB7FFD2ECE3FFF3FC
                    FBFFD2ECE3FF92CDB6FF4DA881FF122D2251000000020000000000000005C18F
                    7FFFFEFEFEFFFAF6F3FFFAF5F3FFFAF7F4FFE5EEE7FF90CAB1FF5BB48FFF46AB
                    82FF5BB48EFF8EC9B1FFC9BDB1FF00000008000000000000000000000004C493
                    82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFBF6F3FFFCF8F6FFFCF7F6FFFCF9
                    F7FFFBF8F5FFFCFBFAFFC49587FF00000005000000000000000000000003C799
                    85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
                    F3FFFCF6F2FFFDFCFAFFC28F7FFF00000004000000000000000000000002C99A
                    89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
                    FDFFFEFDFDFFFEFDFDFFC49382FF000000030000000000000000000000019774
                    67BECA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
                    87FFC79887FFC89886FF927063BF000000020000000000000000}
                  TabOrder = 0
                  OnClick = btnAdicionarAssinaturaClick
                end
                object btnLimparAssinatura: TBitBtnLocked
                  Left = 77
                  Top = 2
                  Width = 72
                  Height = 20
                  Caption = 'Limpar'
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    00020000000900000012000000180000001A0000001A00000018000000100000
                    0005000000010000000000000000000000000000000000000000000000020000
                    000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
                    022800000006000000010000000000000000000000000000000000000008442F
                    1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
                    2AD80302042A00000006000000010000000000000000000000000000000DB07D
                    4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
                    7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
                    329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
                    CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
                    000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
                    CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
                    00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
                    D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
                    0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
                    F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
                    000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
                    F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
                    000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
                    F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
                    00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
                    F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
                    000000000000000000000000000000000000000000010000000736457A9FD8F0
                    FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
                    0000000000000000000000000000000000000000000000000001000000063947
                    7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
                    0000000000000000000000000000000000000000000000000000000000010000
                    00053543728E4F63AACD151A2D40000000040000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0001000000030000000400000002000000000000000000000000}
                  TabOrder = 1
                  OnClick = btnLimparAssinaturaClick
                end
              end
            end
          end
        end
      end
      object pnlEmails: TPanel
        Left = 0
        Top = 503
        Width = 817
        Height = 152
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object dbgEmails: TDBGridCitel
          Left = 0
          Top = 0
          Width = 817
          Height = 152
          Align = alClient
          DataSource = dtsOpeEml
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDblClick = dbgEmailsDblClick
          OnKeyDown = dbgEmailsKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'EML_E_NOME'
              Title.Caption = 'Remetente'
              Width = 109
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EML_NOMPRV'
              Title.Caption = 'Provedor'
              Width = 115
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EML_E_MAIL'
              Title.Caption = 'E-mail'
              Width = 124
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EML_EMALOG'
              Title.Caption = 'Login'
              Width = 125
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EML_EMAEMP'
              Title.Caption = 'Empresas'
              Width = 204
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EML_EMAAUT'
              Title.Caption = 'Tarefas Autom'#225'ticas'
              Width = 119
              Visible = True
            end>
        end
      end
      object pnlEmailBottom: TPanel
        Left = 0
        Top = 474
        Width = 817
        Height = 29
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object btnEmailAdd: TBitBtnLocked
          Left = 620
          Top = 2
          Width = 94
          Height = 22
          Caption = 'Adicionar'
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
          TabOrder = 0
          OnClick = btnEmailAddClick
        end
        object btnEmailCan: TBitBtnLocked
          Left = 714
          Top = 2
          Width = 94
          Height = 22
          Caption = '&Cancelar'
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
          TabOrder = 1
          OnClick = btnEmailCanClick
        end
        object chkEmaAut: TcxCheckBox
          Left = 4
          Top = 2
          Caption = 
            'Exibir e-mails enviados pelo Autcom atrav'#233's do operador de execu' +
            #231#227'o de tarefas autom'#225'ticas. '
          TabOrder = 2
        end
      end
    end
    object tbsMensagensRecebidas: TTabSheet
      Caption = '&7 - Mensagens Recebidas '
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblMsgPos: TLabel
        Left = 17
        Top = 13
        Width = 74
        Height = 28
        Alignment = taRightJustify
        Caption = 'Exibir popup de mensagens:'
        WordWrap = True
      end
      object clbMsgPos: TColorLabel
        Left = 122
        Top = 17
        Width = 175
        Height = 14
        Caption = '(E)squerda da Tela   (D)ireita da Tela'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object chkMsgOrc: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 57
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Or'#231'amento de Venda inclu'#237'do'
        DataField = 'OPE_MSGORC'
        DataSource = dtsTabela
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgPed: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 75
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Pedido de Venda inclu'#237'do'
        DataField = 'OPE_MSGPED'
        DataSource = dtsTabela
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgTre: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 129
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de Transfer'#234'ncia de Estoque Pendente'
        DataField = 'OPE_MSGTRE'
        DataSource = dtsTabela
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgLib: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 147
        Width = 234
        Height = 17
        Caption = 'Receber mensagem de Libera'#231#227'o Remota'
        DataField = 'OPE_MSGLIB'
        DataSource = dtsTabela
        TabOrder = 7
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeMsgPos: TDBEditFocus
        Tag = 99
        Left = 96
        Top = 13
        Width = 23
        Height = 22
        CharCase = ecUpperCase
        DataField = 'OPE_MSGPOS'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnEnter = dbeMsgPosEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object chkMsgETF: TDBCheckBox
        Left = 96
        Top = 165
        Width = 393
        Height = 17
        Caption = 
          'Receber notifica'#231#227'o de efetiva'#231#227'o de tabela de pre'#231'os de fornece' +
          'dor'
        DataField = 'OPE_MSGETF'
        DataSource = dtsTabela
        TabOrder = 9
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeIteMin: TDBCheckBox
        Left = 96
        Top = 183
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de Produto com estoque abaixo do Estoque M'#237'nimo'
        DataField = 'OPE_ITEMIN'
        DataSource = dtsTabela
        TabOrder = 10
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgSfa: TDBCheckBox
        Left = 96
        Top = 201
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de erro na importa'#231#227'o de pedidos do Site/Tablet'
        DataField = 'OPE_MSGSFA'
        DataSource = dtsTabela
        TabOrder = 11
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgPedAlt: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 93
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Pedido de Venda alterado'
        DataField = 'OPE_MSGPAL'
        DataSource = dtsTabela
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgPedCanc: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 111
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Pedido de Venda cancelado'
        DataField = 'OPE_MSGPCA'
        DataSource = dtsTabela
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgLpa: TDBCheckBox
        Left = 96
        Top = 219
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Lote de Pre'#231'o para ativar'
        DataField = 'OPE_MSGLPA'
        DataSource = dtsTabela
        TabOrder = 12
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgTab: TDBCheckBox
        Left = 96
        Top = 237
        Width = 393
        Height = 17
        Caption = 
          'Receber mensagem de novo Pedido de Venda Tablet enviado para lib' +
          'era'#231#227'o'
        DataField = 'OPE_MSGTAB'
        DataSource = dtsTabela
        TabOrder = 13
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgPdl: TDBCheckBox
        Left = 96
        Top = 255
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Pedido de Compra para liberar'
        DataField = 'OPE_MSGPDL'
        DataSource = dtsTabela
        TabOrder = 14
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgOrcCompra: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 39
        Width = 393
        Height = 17
        Caption = 'Receber mensagem de novo Or'#231'amento de Compra inclu'#237'do'
        DataField = 'OPE_MSGOCD'
        DataSource = dtsTabela
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgDfl: TDBCheckBox
        Left = 96
        Top = 273
        Width = 421
        Height = 17
        Caption = 
          'Receber mensagem de inconsist'#234'ncias na defini'#231#227'o de lotes do ped' +
          'ido de venda'
        DataField = 'OPE_MSGDFL'
        DataSource = dtsTabela
        TabOrder = 15
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMensagemPrevisionamentoCTP: TDBCheckBox
        Left = 96
        Top = 291
        Width = 433
        Height = 17
        Caption = 
          'Receber mensagem de reprova do previsionamento de duplicatas do ' +
          'contas a pagar'
        DataField = 'OPE_MSGPRE'
        DataSource = dtsTabela
        TabOrder = 16
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgCVA: TDBCheckBox
        Left = 96
        Top = 328
        Width = 297
        Height = 17
        Caption = 'Receber mensagem de requisi'#231#227'o de compras atendidas'
        DataField = 'OPE_MSGCVA'
        DataSource = dtsTabela
        TabOrder = 17
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkMsgCVAClick
      end
      object chkMsgPrj: TDBCheckBox
        Left = 96
        Top = 398
        Width = 505
        Height = 17
        Caption = 
          'Receber notifica'#231#227'o ao abrir o sistema, sobre projetos com data ' +
          'de previs'#227'o atrasados.'
        DataField = 'OPE_MSGPRJ'
        DataSource = dtsTabela
        TabOrder = 19
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgGNR: TDBCheckBox
        Left = 96
        Top = 416
        Width = 505
        Height = 17
        Caption = 
          'Receber mensagem de notas fiscais emitidas com ST/DIFAL/FCP para' +
          ' emiss'#227'o da GNRE/GARE '
        DataField = 'OPE_MSGGNR'
        DataSource = dtsTabela
        TabOrder = 20
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgCRM: TDBCheckBox
        Left = 96
        Top = 453
        Width = 505
        Height = 17
        Caption = 'Receber mensagem de inclus'#227'o / altera'#231#227'o das ocorr'#234'ncias do CRM'
        DataField = 'OPE_MSGCRM'
        DataSource = dtsTabela
        TabOrder = 22
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkIgMsgL: TDBCheckBox
        Tag = 99
        Left = 335
        Top = 147
        Width = 366
        Height = 17
        Caption = 'Permitir ignorar popup de mensagem de Libera'#231#227'o Remota'
        DataField = 'OPE_IGMSGL'
        DataSource = dtsTabela
        TabOrder = 8
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMensagensPix: TDBCheckBox
        Left = 96
        Top = 471
        Width = 505
        Height = 17
        Caption = 'Receber mensagens dos pagamentos de pedidos realizados via Pix'
        DataField = 'OPE_MSGPIX'
        DataSource = dtsTabela
        TabOrder = 23
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkDMEFEM: TDBCheckBox
        Left = 96
        Top = 489
        Width = 629
        Height = 17
        Caption = 
          'Receber mensagens de Documentos lan'#231'ados no sistema e sem Efetiv' +
          'a'#231#227'o do Movimento Fiscal dentro do prazo estabelecido'
        DataField = 'OPE_DMEFEM'
        DataSource = dtsTabela
        TabOrder = 24
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        Visible = False
      end
      object chkMngCad: TDBCheckBox
        Left = 96
        Top = 507
        Width = 505
        Height = 17
        Caption = 'Receber mensagens de novos produtos cadastrados'
        DataField = 'OPE_MSGNPC'
        DataSource = dtsTabela
        TabOrder = 25
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMSGDIV: TDBCheckBox
        Left = 96
        Top = 525
        Width = 606
        Height = 17
        Caption = 
          'Receber mensagens de devolu'#231#227'o de mercadoria causada por n'#227'o con' +
          'formidade na confer'#234'ncia de entrada pelo Coletor'
        DataField = 'OPE_MSGDIV'
        DataSource = dtsTabela
        TabOrder = 26
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkCertificadosPix: TDBCheckBox
        Left = 96
        Top = 543
        Width = 505
        Height = 17
        Caption = 
          'Receber mensagens de certificados do Pix pr'#243'ximos a vencer/venci' +
          'dos das contas banc'#225'rias'
        DataField = 'OPE_MSGCPX'
        DataSource = dtsTabela
        TabOrder = 27
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkContratoLocVencer: TDBCheckBox
        Left = 96
        Top = 561
        Width = 505
        Height = 17
        Caption = 'Receber mensagens de Contrato de Loca'#231#227'o a vencer'
        DataField = 'OPE_MSGCTL'
        DataSource = dtsTabela
        TabOrder = 28
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgReqCompIncluida: TDBCheckBox
        Left = 96
        Top = 370
        Width = 297
        Height = 17
        Caption = 'Receber mensagem de requisi'#231#227'o de compras inclu'#237'das'
        DataField = 'OPE_MSGRCI'
        DataSource = dtsTabela
        TabOrder = 18
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkMsgReqCompIncluidaClick
      end
      object chkMsgMedAtrasoClientes: TDBCheckBox
        Left = 96
        Top = 579
        Width = 505
        Height = 17
        Caption = 
          'Receber mensagem de clientes com m'#233'dia de atraso maior que o con' +
          'figurado em [CFG_MEDCRE]'
        DataField = 'OPE_MSGMDA'
        DataSource = dtsTabela
        TabOrder = 29
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMsgReqCompNegada: TDBCheckBox
        Left = 96
        Top = 435
        Width = 290
        Height = 17
        Caption = 'Receber mensagem de requisi'#231#227'o de compra negada'
        DataField = 'OPE_MSGRCN'
        DataSource = dtsTabela
        TabOrder = 21
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkMSGCER: TDBCheckBox
        Tag = 99
        Left = 96
        Top = 597
        Width = 505
        Height = 17
        Caption = 'Receber mensagem de certificado digital da empresa a vencer'
        DataField = 'OPE_MSGCER'
        DataSource = dtsTabela
        TabOrder = 30
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object rdgRequisicaoComprasAtendidas: TDBRadioGroup
        Left = 416
        Top = 314
        Width = 321
        Height = 33
        Columns = 2
        DataField = 'OPE_CVATDS'
        DataSource = dtsTabela
        Items.Strings = (
          'De Todos Operadores'
          'Somente suas Requisi'#231#245'es')
        TabOrder = 31
        Values.Strings = (
          'S'
          'N')
      end
      object rdgRequisicaoComprasIncluidas: TDBRadioGroup
        Left = 416
        Top = 357
        Width = 321
        Height = 35
        Columns = 2
        DataField = 'OPE_RCITDS'
        DataSource = dtsTabela
        Items.Strings = (
          'De Todos Operadores'
          'Somente suas Requisi'#231#245'es')
        TabOrder = 32
        Values.Strings = (
          'S'
          'N')
      end
      object chkItePPF: TDBCheckBox
        Left = 96
        Top = 615
        Width = 497
        Height = 17
        Caption = 'Receber mensagem de Produto com Pre'#231'o de Pauta Fiscal vencido?'
        DataField = 'OPE_ITEPPF'
        DataSource = dtsTabela
        TabOrder = 33
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
      end
    end
    object tbsPermissaoHorariosOperacaoSistema: TTabSheet
      Caption = '&8 - Permiss'#227'o de hor'#225'rios de opera'#231#227'o do Sistema'
      Enabled = False
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlPerHorOpeSis_Cabecalho: TPanel
        Left = 0
        Top = 0
        Width = 817
        Height = 41
        Align = alTop
        TabOrder = 0
        object chkUtiDef: TDBCheckBox
          Tag = 99
          Left = 8
          Top = 12
          Width = 197
          Height = 17
          Caption = 'Utilizar defini'#231#227'o de hor'#225'rios?'
          DataField = 'OPE_UTIDEF'
          DataSource = dtsTabela
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = chkUtiDefClick
        end
      end
      object pnlPerHorOpeSis: TPanel
        Left = 0
        Top = 41
        Width = 817
        Height = 614
        Align = alClient
        TabOrder = 1
        Visible = False
        object cxPermissaoHorarios: TcxGrid
          Left = 1
          Top = 1
          Width = 815
          Height = 582
          Align = alClient
          TabOrder = 0
          object cxTblPermissaoHorarios: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsHorOpe
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            object cxTblPermissaoHorariosDIASEM: TcxGridDBColumn
              DataBinding.FieldName = 'DIASEM'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 60
            end
            object cxTblPermissaoHorariosRESACE: TcxGridDBColumn
              DataBinding.FieldName = 'RESACE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.Alignment = taCenter
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              Width = 100
            end
            object cxTblPermissaoHorariosRESVEN: TcxGridDBColumn
              DataBinding.FieldName = 'RESVEN'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.Alignment = taCenter
              Properties.ImmediatePost = True
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              Width = 100
            end
            object cxTblPermissaoHorariosHINI_1: TcxGridDBColumn
              DataBinding.FieldName = 'HINI_1'
              PropertiesClassName = 'TcxTimeEditProperties'
              Properties.ImmediatePost = True
              Properties.TimeFormat = tfHourMin
              HeaderAlignmentHorz = taCenter
              Width = 70
            end
            object cxTblPermissaoHorariosHFIN_1: TcxGridDBColumn
              DataBinding.FieldName = 'HFIN_1'
              PropertiesClassName = 'TcxTimeEditProperties'
              Properties.ImmediatePost = True
              Properties.TimeFormat = tfHourMin
              HeaderAlignmentHorz = taCenter
              Width = 70
            end
            object cxTblPermissaoHorariosHINI_2: TcxGridDBColumn
              DataBinding.FieldName = 'HINI_2'
              PropertiesClassName = 'TcxTimeEditProperties'
              Properties.ImmediatePost = True
              Properties.TimeFormat = tfHourMin
              HeaderAlignmentHorz = taCenter
              Width = 70
            end
            object cxTblPermissaoHorariosHFIN_2: TcxGridDBColumn
              DataBinding.FieldName = 'HFIN_2'
              PropertiesClassName = 'TcxTimeEditProperties'
              Properties.ImmediatePost = True
              Properties.TimeFormat = tfHourMin
              HeaderAlignmentHorz = taCenter
              Width = 70
            end
          end
          object cxPermissaoHorariosLvl: TcxGridLevel
            GridView = cxTblPermissaoHorarios
          end
        end
        object pnlPerHorOpeSis_Rodape: TPanel
          Left = 1
          Top = 583
          Width = 815
          Height = 30
          Align = alBottom
          TabOrder = 1
          object Label41: TLabel
            Left = 7
            Top = 8
            Width = 701
            Height = 14
            Caption = 
              '*** Caso selecionado as op'#231#245'es de restringir "Acesso/Venda" e n'#227 +
              'o seja informado as faixas de hor'#225'rios, ser'#225' considerado bloquei' +
              'o total no dia.'
          end
        end
      end
    end
    object tbsColetor: TTabSheet
      Caption = '&9 - Coletor de Dados'
      ImageIndex = 8
      object GroupBox2: TGroupBox
        Left = 9
        Top = 43
        Width = 452
        Height = 490
        Caption = 'Empresas - Monitoramento Notifica'#231#227'o'
        TabOrder = 0
        Visible = False
        DesignSize = (
          452
          490)
        object lblClbEmpresasNotificacaoColetor: TLabel
          Left = 11
          Top = 467
          Width = 95
          Height = 14
          Cursor = crHandPoint
          Anchors = [akLeft, akBottom]
          Caption = 'Op'#231#245'es de Sele'#231#227'o'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblClbEmpresasNotificacaoColetorClick
          ExplicitTop = 507
        end
        object clbEmpresasNotificacaoColetor: TCheckListBox
          Tag = 99
          Left = 4
          Top = 14
          Width = 443
          Height = 453
          Anchors = [akLeft, akTop, akRight, akBottom]
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          TabOrder = 0
        end
      end
      object chkSinalSonoro: TDBCheckBox
        Tag = 99
        Left = 13
        Top = 20
        Width = 197
        Height = 17
        Caption = 'Emitir sinal sonoro das notifica'#231#245'es'
        DataField = 'OPE_NTFSON'
        DataSource = dtsTabela
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkUtiDefClick
      end
    end
    object tbsWhatsapp: TTabSheet
      Caption = '&10 - Whatsapp'
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gpbCitelDesk: TGroupBox
        Left = 0
        Top = 0
        Width = 817
        Height = 52
        Align = alTop
        Caption = 'Citeldesk'
        TabOrder = 0
        object lblIDCIDE: TLabel
          Left = 16
          Top = 22
          Width = 176
          Height = 14
          Caption = 'C'#243'digo de Identifica'#231#227'o no Citeldesk:'
        end
        object dbeIdCiDe: TDBEditFocus
          Left = 195
          Top = 19
          Width = 121
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_IDCIDE'
          DataSource = dtsTabela
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
      object gpbFilas: TGroupBox
        Left = 0
        Top = 52
        Width = 817
        Height = 109
        Align = alTop
        Caption = 'Filas'
        TabOrder = 1
        object Label48: TLabel
          Left = 17
          Top = 80
          Width = 73
          Height = 14
          Caption = 'Fila para envio:'
        end
        object rdgUsaFil: TDBRadioGroup
          Left = 16
          Top = 21
          Width = 361
          Height = 44
          Caption = 'Operador utiliza filas'
          Columns = 2
          DataField = 'OPE_USAFIL'
          DataSource = dtsTabela
          Items.Strings = (
            'Somente da empresa logada'
            'De todas as empresas')
          TabOrder = 0
          Values.Strings = (
            'L'
            'T')
          OnClick = rdgUsaFilClick
        end
        object lkpFilaEnvio: TDBLookupComboBoxFocus
          Tag = 99
          Left = 94
          Top = 77
          Width = 283
          Height = 22
          DataField = 'OPE_SEQFIL'
          DataSource = dtsTabela
          Enabled = False
          KeyField = 'AUTOINCREM'
          ListField = 'FILAS'
          TabOrder = 1
          OnClick = cmbProvedoresClick
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
    end
    object tbsCartPremi: TTabSheet
      Caption = '11 - Cart'#227'o Premia'#231#227'o'
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grpCartaoPremiacao: TGroupBox
        Left = 0
        Top = 3
        Width = 321
        Height = 148
        Caption = 'Cart'#227'o Premia'#231#227'o'
        TabOrder = 0
        object Label49: TLabel
          Left = 100
          Top = 45
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'ID Hub:'
        end
        object Label50: TLabel
          Left = 6
          Top = 68
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo Interno para Carga:'
        end
        object Label51: TLabel
          Left = 45
          Top = 24
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero do Cart'#227'o:'
        end
        object dbeCPRIdH: TDBEditFocus
          Tag = 99
          Left = 141
          Top = 42
          Width = 164
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_CPRIDH'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCPRCiC: TDBEditFocus
          Tag = 99
          Left = 141
          Top = 65
          Width = 164
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_CPRCIC'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCPRNum: TDBEditFocus
          Tag = 99
          Left = 141
          Top = 19
          Width = 164
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OPE_CPRNUM'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = dbeTpCoMcExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 760
    Top = 2
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 202
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 240
  end
  object dtsTabela: TDataSource
    Left = 760
    Top = 32
  end
  object dtsListTipVen: TDataSource
    Left = 680
    Top = 144
  end
  object dtsComFor: TDataSource
    Left = 704
    Top = 296
  end
  object dlgAssinatura: TOpenDialog
    Filter = 'Arquivo JPEG|*.jpeg; *.jpg'
    InitialDir = 'C:\'
    Left = 705
    Top = 350
  end
  object imgValidacaoEmail: TImageList
    Left = 659
    Top = 92
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
      000000000000000000000000000000000000185A4200297B5A00217B5A00217B
      5A00217B5A00217B5A00217B5A00217B5A00217B5A00217B5200217B5200217B
      5200217352002173520018523900000000000000000018106B00211094002110
      9400211094002110940021109400211094002110940021109400211094002110
      9400211094002110940018086B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000211010006B42
      3100181008000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029845A0052CEA50052C6A50052C6
      A5004AC69C004AC69C004AC69C004AC69C004AC69C0042C69C0042C69C0042C6
      9C0042C6940042C69400217B5A00000000000000000029189C00394AD6002131
      CE003142D6004252DE003142D6002131CE002131CE003142D600394AD6002939
      CE002129CE001829CE0021109400000000000000000000000000000000000000
      000000000000000000000000000000000000311818004221180073423900CEB5
      AD005A3129003921180029181000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000298463005ACEAD0042C69C0042C6
      9C0042C69C0042C69C0063CEAD0073D6B5004AC69C0042C6940039C6940039BD
      940039BD94004AC69C00297B5A0000000000000000003121A5004252D600314A
      D600394ACE002921AD003139BD00394AD600394AD6003139BD002921AD003942
      CE002942D6002131CE0029189C00000000000000000000000000000000000000
      00000000000000000000000000000000000063423100CEBDB500DED6CE00DED6
      CE00E7D6D600AD948C004A292100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000298C6B0063D6B5004AC69C004AC6
      9C0042C69C005ACEAD0021845A000063390052BD940042C69C0042C69C0042C6
      9C0042C69C0052CEA5002984630000000000000000003129A5004A63DE00424A
      CE00635ABD00EFEFFF008C8CCE003939BD003939BD008C8CCE00EFEFFF005A5A
      BD003942CE002939CE0029189C00000000000000000000000000000000000000
      000000000000000000000000000000000000211010009C7B6B00EFEFE7008452
      4200E7DED6008C635A0018101000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000031946B0073D6BD004ACEA5004ACE
      A50063CEAD003994730084AD9C00B5CEC60021845A0052CEA5004AC69C0042C6
      9C0042C69C005ACEAD00298C630000000000000000003929AD005A6BDE002121
      A500EFE7EF00F7EFE700FFF7EF009494D6009494D600FFF7EF00F7EFE700EFE7
      EF002121A5002942D6003121A500000000000000000000000000000000000000
      0000000000000000000000000000000000006B4A4200D6C6BD00E7DED600FFFF
      FF00D6C6C600CEBDB50063423100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319473007BDEBD0052CEA50063D6
      AD004AA584006B948400FFF7EF00FFF7EF00317B5A005ABD9C004ACEA5004ACE
      A5004ACEA50063D6B500298C6B0000000000000000004231B500637BE7003131
      B5008473AD00EFDED600F7EFE700F7F7EF00FFF7EF00F7EFE700EFDED6007B6B
      AD002931B500314AD6003129AD00000000000000000000000000000000000000
      000039292100734A42003118180000000000392921005A4239008C635200EFDE
      DE008C6352005A42310039292100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319C730084DEC6005AD6AD005AB5
      94004A846B00F7EFE700C6C6B500EFE7DE00CEDED60018734A006BD6B50052CE
      A50052CEA50073D6BD0031946B0000000000000000004239B5006B84E7004A5A
      DE003939B5008C7BBD00F7EFE700F7EFE700F7EFE700F7EFE7008C7BBD003139
      B5004252DE003952D6003931AD00000000000000000008080000211010002118
      100073524200C6B5A5005A393100211010001810100008000000292118009C6B
      5A00292118000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039A57B008CE7CE005AD6B5000863
      4200D6D6CE006B8C7300106B420073947B00F7EFE70073A58C004AA584006BDE
      BD005AD6AD007BDEC6003194730000000000000000004A42BD007B8CEF006373
      E7004A4ABD00948CC600F7EFEF00F7EFEF00F7EFEF00F7EFEF009484C6004A4A
      BD005A6BDE00425ADE004239B5000000000000000000523931009C7B73008463
      5A00BDADA500E7DED600C6B5B5007B5A52008C6B630042292900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039A5840094EFD6006BDEBD0052BD
      9C00086B4200399C7B0063DEBD003194730073947B00F7EFE7004A8C6B0063BD
      9C0063DEBD0084E7CE00319C7B000000000000000000524AC60094A5EF005252
      BD008C8CCE00FFF7F700F7F7EF00EFE7DE00EFE7DE00F7F7EF00FFF7F7008C8C
      CE005252BD00637BE7004A42BD00000000000000000039292100A58C8400EFE7
      E700BDA59C009C7B7300C6ADA500EFE7DE009C7B730039292100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039AD8C009CEFDE006BE7C6006BE7
      C6006BE7C6006BDEC6006BE7C6006BDEC600298C63006B8C7300E7E7DE00106B
      42005AD6B50094E7D60039A5840000000000000000006B6BD600ADC6F7002918
      9C00E7DEDE00F7EFEF00EFDEDE00846BAD00846BAD00EFDEDE00F7EFE700E7DE
      DE0029189C008C9CEF006363CE000000000000000000000000008C6B5A00EFE7
      E7008C6B5A00291818008C6B6300E7DEDE0073524A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042B58C00A5EFDE0073E7C60073E7
      C60073E7C6006BE7C6006BE7C6006BE7C6006BE7C600399C7B00186B4A00298C
      63006BE7C60094EFD60039AD840000000000000000007373D600B5C6F7006B73
      D6005242A500CEB5BD007B6BAD004A4AB5004A4ABD007B6BAD00CEB5BD005242
      A5006B73D6008CA5EF00736BD600000000000000000042312900AD948C00EFEF
      E700B59C9C0073524A00AD948C00EFE7DE00A58C7B0039292100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042B59400ADEFE70073E7CE0073E7
      CE0073E7CE0073E7CE0073E7CE0073E7CE0073E7C60073E7C60063D6B5006BDE
      C6006BE7C6009CEFDE0042AD8C0000000000000000007B7BDE00B5CEF70094A5
      EF00737BD60029219C005252BD0094A5EF0094A5EF005252BD0029219C006B73
      D60094A5EF0094A5EF007373D60000000000000000006B524A00B5A59400AD8C
      7B00DECEC600F7F7F700D6C6BD00A5847B00B59C8C0063524200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042BD9400ADF7E70073EFCE0073E7
      CE0073E7CE0073E7CE0073E7CE0073E7CE0073E7CE0073E7CE0073E7CE0073E7
      CE0073E7CE00A5EFDE0042B58C0000000000000000007B84DE00BDCEF700BDCE
      F700BDCEF700BDCEF700BDCEF700BDCEF700BDCEF700B5CEF700B5CEF700B5CE
      F700B5CEF700B5CEF7007B7BDE00000000000000000010080800312121003129
      2100947B6B00E7DED6008C6B6300312121003121210010080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042BD9400C6F7EF00C6F7EF00C6F7
      EF00C6F7EF00C6F7EF00C6F7EF00C6F7EF00C6F7EF00C6F7EF00C6F7EF00C6F7
      EF00C6F7EF00C6F7EF0042B5940000000000000000006363A5008484E7008484
      E7008484E7007B84DE007B84DE007B84DE007B84DE007B84DE007B84DE007B84
      DE007B7BDE007B7BDE005A5AA500000000000000000000000000000000000000
      000052423900A584730052423900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000318C730042BD940042BD940042BD
      940042BD940042BD940042BD940042BD940042BD940042BD940042BD940042BD
      940042BD940042BD9400318C6B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object popOpSele: TPopupMenu
    Left = 660
    Top = 44
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
  object cdsHorOpe: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 508
    Top = 108
    object cdsHorOpeAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsHorOpeDIASEM: TStringField
      Alignment = taCenter
      DisplayLabel = 'Dia'
      FieldName = 'DIASEM'
      Size = 3
    end
    object cdsHorOpeRESACE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Restringir Acesso'
      FieldName = 'RESACE'
      Size = 1
    end
    object cdsHorOpeRESVEN: TStringField
      Alignment = taCenter
      DisplayLabel = 'Restringir Venda'
      FieldName = 'RESVEN'
      Size = 1
    end
    object cdsHorOpeHINI_1: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Hora Inicial 1'
      FieldName = 'HINI_1'
    end
    object cdsHorOpeHFIN_1: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Hora Final 1'
      FieldName = 'HFIN_1'
    end
    object cdsHorOpeHINI_2: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Hora Inicial 2'
      FieldName = 'HINI_2'
    end
    object cdsHorOpeHFIN_2: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Hora Final 2'
      FieldName = 'HFIN_2'
    end
  end
  object dtsHorOpe: TDataSource
    DataSet = cdsHorOpe
    Left = 504
    Top = 160
  end
  object dtsOpeATe: TDataSource
    Left = 543
    Top = 435
  end
  object dtsOpeEml: TUniDataSource
    DataSet = cdsOpeEml
    Left = 694
    Top = 604
  end
  object cdsOpeEml: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EML_E_NOME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EML_CODPRV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EML_E_MAIL'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EML_EMALOG'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EML_PRVSEN'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'EML_EMAAUT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EML_EMAEMP'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'EML_NOMPRV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EML_IMGB64'
        DataType = ftBlob
      end
      item
        Name = 'EML_TEXTO_'
        DataType = ftBlob
      end
      item
        Name = 'EML_SEQUEN'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'EML_CODOPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EML_IMAGEM'
        DataType = ftBlob
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 662
    Top = 605
    object cdsOpeEmlEML_E_NOME: TStringField
      FieldName = 'EML_E_NOME'
      Size = 50
    end
    object cdsOpeEmlEML_CODPRV: TStringField
      FieldName = 'EML_CODPRV'
    end
    object cdsOpeEmlEML_E_MAIL: TStringField
      FieldName = 'EML_E_MAIL'
      Size = 100
    end
    object cdsOpeEmlEML_EMALOG: TStringField
      FieldName = 'EML_EMALOG'
      Size = 100
    end
    object cdsOpeEmlEML_PRVSEN: TStringField
      FieldName = 'EML_PRVSEN'
      Size = 25
    end
    object cdsOpeEmlEML_EMAAUT: TStringField
      FieldName = 'EML_EMAAUT'
    end
    object cdsOpeEmlEML_EMAEMP: TStringField
      FieldName = 'EML_EMAEMP'
      Size = 500
    end
    object cdsOpeEmlEML_NOMPRV: TStringField
      FieldName = 'EML_NOMPRV'
    end
    object cdsOpeEmlEML_IMGB64: TBlobField
      FieldName = 'EML_IMGB64'
    end
    object cdsOpeEmlEML_TEXTO_: TBlobField
      FieldName = 'EML_TEXTO_'
    end
    object cdsOpeEmlEML_SEQUEN: TAutoIncField
      FieldName = 'EML_SEQUEN'
    end
    object cdsOpeEmlEML_CODOPE: TStringField
      FieldName = 'EML_CODOPE'
    end
    object cdsOpeEmlEML_IMAGEM: TBlobField
      FieldName = 'EML_IMAGEM'
    end
  end
end
