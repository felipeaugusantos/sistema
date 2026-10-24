inherited frmCadFornecedores: TfrmCadFornecedores
  Left = 228
  Top = 153
  Width = 1024
  Height = 768
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Cadastro de Fornecedores'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 669
    Width = 1008
    Height = 44
    ExplicitTop = 669
    ExplicitWidth = 1008
    ExplicitHeight = 44
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      Height = 40
      ExplicitTop = 2
      ExplicitWidth = 1004
      ExplicitHeight = 40
      inherited btnIncluir: TBitBtnLocked
        Width = 102
        ExplicitWidth = 102
      end
      inherited btnGravar: TBitBtnLocked
        Left = 102
        Width = 102
        ExplicitLeft = 102
        ExplicitWidth = 102
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 204
        Width = 102
        ExplicitLeft = 204
        ExplicitWidth = 102
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 306
        Width = 102
        ExplicitLeft = 306
        ExplicitWidth = 102
      end
      inherited btnCancela: TBitBtnLocked
        Left = 408
        Width = 102
        ExplicitLeft = 408
        ExplicitWidth = 102
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 510
        Width = 102
        ExplicitLeft = 510
        ExplicitWidth = 102
      end
      object btnFichaCad: TBitBtnLocked
        Left = 612
        Top = 0
        Width = 102
        Height = 20
        Caption = '[ F8 ] Ficha Cad.'
        TabOrder = 6
        OnClick = btnFichaCadClick
      end
      object btnAltPar: TBitBtnLocked
        Left = 714
        Top = 0
        Width = 102
        Height = 20
        Caption = 'Altera'#231#227'o de Dados'
        TabOrder = 7
        OnClick = btnAltParClick
      end
      object btnPlaNco: TBitBtnLocked
        Left = 816
        Top = 0
        Width = 102
        Height = 20
        Caption = 'Plano de Contas'
        TabOrder = 8
        OnClick = btnPlaNcoClick
      end
      object btnCadClientes: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 96
        Height = 20
        Caption = '[F9] Cad.Clientes'
        Enabled = False
        TabOrder = 9
        OnClick = btnCadClientesClick
      end
      object btnCadTransportadora: TBitBtnLocked
        Left = 96
        Top = 20
        Width = 133
        Height = 20
        Caption = '[F7] Cad.transportadora'
        Enabled = False
        TabOrder = 10
        OnClick = btnCadTransportadoraClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 893
      Top = 21
      Width = 96
      Height = 20
      ExplicitLeft = 893
      ExplicitTop = 21
      ExplicitWidth = 96
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1008
    ExplicitTop = 713
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 825
      Width = 183
      ExplicitLeft = 825
      ExplicitWidth = 183
    end
    inherited pnlInfo: TPanel
      Width = 825
      ExplicitWidth = 825
    end
  end
  inherited pgcDados: TPageControl
    Width = 1008
    Height = 669
    OnChange = pgcDadosChange
    ExplicitWidth = 1008
    ExplicitHeight = 669
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1000
      ExplicitHeight = 637
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 43
          Top = 10
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 7
          Top = 32
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Cadastro:'
        end
        object Label3: TLabel
          Left = 49
          Top = 76
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label4: TLabel
          Left = 5
          Top = 98
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome Fantasia:'
        end
        object Label5: TLabel
          Left = 409
          Top = 164
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label6: TLabel
          Left = 30
          Top = 142
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label10: TLabel
          Left = 390
          Top = 186
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cx. Postal:'
        end
        object Label12: TLabel
          Left = 594
          Top = 186
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'Insc. Est.:'
        end
        object Label13: TLabel
          Left = 388
          Top = 208
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 1:'
        end
        object Label14: TLabel
          Left = 588
          Top = 208
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 2:'
        end
        object Label15: TLabel
          Left = 56
          Top = 230
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'FAX:'
        end
        object Label16: TLabel
          Left = 39
          Top = 252
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Contato:'
        end
        object Label17: TLabel
          Left = 48
          Top = 274
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-mail:'
        end
        object Label18: TLabel
          Left = 398
          Top = 297
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'WebSite:'
        end
        object Label19: TLabel
          Left = 393
          Top = 364
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
        end
        object Label21: TLabel
          Left = 591
          Top = 231
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o:'
        end
        object Label47: TLabel
          Left = 6
          Top = 461
          Width = 73
          Height = 42
          Alignment = taRightJustify
          Caption = 'Observa'#231#245'es:'#13#10'[ALT+2]'#13#10'pr'#243'xima p'#225'gina'
        end
        object Label23: TLabel
          Left = 16
          Top = 411
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo Fornec.:'
        end
        object lblDesPlaCon: TLabel
          Left = 7
          Top = 318
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Cont'#225'bil:'
        end
        object Label32: TLabel
          Left = 414
          Top = 230
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = '0800:'
        end
        object Label37: TLabel
          Left = 485
          Top = 10
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object ColorLabel2: TColorLabel
          Left = 580
          Top = 10
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
        object Label38: TLabel
          Left = 601
          Top = 142
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero:'
        end
        object Label39: TLabel
          Left = 12
          Top = 164
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
        end
        object Label40: TLabel
          Left = 8
          Top = 366
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regime Tribut.:'
        end
        object lblCelular: TLabel
          Left = 238
          Top = 230
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Celular:'
        end
        object lblPerFFx: TLabel
          Left = 612
          Top = 435
          Width = 105
          Height = 14
          Alignment = taRightJustify
          Caption = '% Frete (Fluxo Caixa)'
        end
        object Label45: TLabel
          Left = 225
          Top = 32
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = #218'lt. Altera'#231#227'o:'
        end
        object Label46: TLabel
          Left = 401
          Top = 274
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-mail 2:'
        end
        object Label49: TLabel
          Left = 481
          Top = 32
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador:'
        end
        object LabelCgcCpf1: TLabelCgcCpf
          Left = 9
          Top = 55
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = '1-CNPJ/2-CPF:'
          Pais = opcBrasil
        end
        object LabelRg1: TLabelRg
          Left = 55
          Top = 209
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'R.G.:'
          Pais = opcBrasil
        end
        object lbl11: TLabel
          Left = 26
          Top = 296
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-mail NFe:'
        end
        object lbl12: TLabel
          Left = 602
          Top = 252
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'Revista:'
        end
        object ColorLabel19: TColorLabel
          Left = 691
          Top = 252
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
        object lbl13: TLabel
          Left = 689
          Top = 231
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lbl14: TLabel
          Left = 14
          Top = 435
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Zona Franca:'
        end
        object ColorLabel4: TColorLabel
          Left = 116
          Top = 435
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
        object Label259: TLabel
          Left = 9
          Top = 342
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Con. Reduzida'
        end
        object ColorLabel3: TColorLabel
          Left = 116
          Top = 366
          Width = 224
          Height = 14
          Caption = '(S)imples  /  Lucro (R)eal  /  Lucro (P)resumido'
          CorDestaque = clRed
        end
        object lblCliFor: TLabel
          Left = 282
          Top = 342
          Width = 159
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Fornecedor no Cad. Cliente:'
        end
        object cblpeicms: TColorLabel
          Left = 504
          Top = 389
          Width = 55
          Height = 14
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
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
        object lblPeiIcms: TLabel
          Left = 82
          Top = 389
          Width = 360
          Height = 14
          Hint = 'Habilitado quando o Regime Tribut'#225'rio for Simples'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Alignment = taRightJustify
          Caption = 
            'Permitir Creditar ICMS (CONSULTA TRIBUT'#193'RIA 16542/2017 de 01/11/' +
            '2107)'
        end
        object clbNotDes: TColorLabel
          Left = 708
          Top = 526
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
        object lblNotDes: TLabel
          Left = 5
          Top = 525
          Width = 651
          Height = 14
          Alignment = taRightJustify
          Caption = 
            'Fornecedor enquadrado no art. 7'#186' do Anexo XVIII da Parte II da R' +
            'esolu'#231#227'o SEFAZ n'#186' 720/14, inclu'#237'do pela Resolu'#231#227'o SEFAZ n'#186' 13/19' +
            ' ?'
        end
        object Label86: TLabel
          Left = 23
          Top = 537
          Width = 55
          Height = 28
          Alignment = taRightJustify
          Caption = 'Grupo Econ'#244'mico:'
          WordWrap = True
        end
        object imgWppCtt: TImage
          Left = 185
          Top = 229
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
          Visible = False
        end
        object Label9: TLabel
          Left = 57
          Top = 120
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object Label7: TLabel
          Left = 256
          Top = 120
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label20: TLabel
          Left = 682
          Top = 120
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object dbeEmail2: TDBEditFocus
          Left = 444
          Top = 270
          Width = 319
          Height = 22
          CharCase = ecLowerCase
          DataField = 'FOR_EMAIL2'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 255
          TabOrder = 26
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtAtividade: TEditFocus
          Left = 500
          Top = 361
          Width = 263
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 41
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 6
          Width = 69
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODFOR'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDtaCad: TDBEditFocus
          Left = 81
          Top = 28
          Width = 69
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FOR_DTACAD'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomFor: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 72
          Width = 682
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_NOMFOR'
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
        object dbeNomFan: TDBEditFocus
          Left = 81
          Top = 94
          Width = 682
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_NOMFAN'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndere: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 138
          Width = 494
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ENDERE'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeBairro: TDBEditFocus
          Left = 443
          Top = 160
          Width = 320
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_BAIRRO'
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
        object dbeCaiPos: TDBEditFocus
          Left = 443
          Top = 182
          Width = 102
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CAIPOS'
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
        object dbeNumIes: TDBEditFocus
          Tag = 99
          Left = 643
          Top = 182
          Width = 120
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_I_E_S_'
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
          Left = 443
          Top = 204
          Width = 102
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_FONE01'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 14
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFon02: TDBEditFocus
          Tag = 99
          Left = 643
          Top = 204
          Width = 120
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_FONE02'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 14
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumFax: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 226
          Width = 101
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_F_A_X_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 14
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeContato: TDBEditFocus
          Left = 81
          Top = 248
          Width = 409
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CONTAT'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmail: TDBEditFocus
          Left = 81
          Top = 270
          Width = 270
          Height = 22
          CharCase = ecLowerCase
          DataField = 'FOR_EMAIL_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 255
          TabOrder = 25
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHomPag: TDBEditFocus
          Left = 444
          Top = 292
          Width = 319
          Height = 22
          CharCase = ecLowerCase
          DataField = 'FOR_HOMEPA'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 28
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodAti: TDBEditFocus
          Tag = 99
          Left = 444
          Top = 361
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODATI'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 35
          OnKeyPress = dbeCodAtiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbeCodAtiChamaCadastro
        end
        object dbeComissao: TDBEditFocus
          Left = 643
          Top = 227
          Width = 44
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_PERCOM'
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
        object dbeNumRg: TDBEditFocus
          Left = 81
          Top = 204
          Width = 296
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_NUMRG_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeObserv: TDBMemoFocus
          Left = 81
          Top = 456
          Width = 682
          Height = 62
          DataField = 'FOR_OBSERV'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 40
          OnKeyPress = dbeObservKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbeConCon: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 315
          Width = 120
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CONCON'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 30
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbe0800__: TDBEditFocus
          Left = 443
          Top = 226
          Width = 102
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_0800__'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 14
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeStatus: TDBEditFocus
          Tag = 99
          Left = 536
          Top = 6
          Width = 39
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_STATUS'
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndNum: TDBEditFocus
          Left = 643
          Top = 138
          Width = 120
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ENDNUM'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndCom: TDBEditFocus
          Left = 81
          Top = 160
          Width = 248
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ENDCOM'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSimPau: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 361
          Width = 29
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_SIMPAU'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 34
          OnExit = dbeSimPauExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeNumCel: TDBEditFocus
          Tag = 99
          Left = 275
          Top = 226
          Width = 102
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_NUMCEL'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 14
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePerFCx: TDBEditFocus
          Tag = 99
          Left = 719
          Top = 431
          Width = 44
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_PERFCX'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 39
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeUltAlt: TDBEditFocus
          Tag = 99
          Left = 294
          Top = 28
          Width = 68
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'FOR_DTAALT'
          DataSource = dtsTabela
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeOpeAlt: TDBEditFocus
          Tag = 99
          Left = 536
          Top = 28
          Width = 39
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODOPE'
          DataSource = dtsTabela
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtNomOpe: TEditFocus
          Left = 576
          Top = 28
          Width = 187
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 44
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object Panel1: TPanel
          Left = 81
          Top = 50
          Width = 312
          Height = 22
          BevelOuter = bvNone
          TabOrder = 5
          object dbeCgcCpf: TDBEditTipoCgcCpf
            Tag = 99
            Left = 0
            Top = 0
            Width = 69
            Height = 22
            Align = alLeft
            CharCase = ecUpperCase
            DataField = 'FOR_CGCCPF'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeCgcCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeNumCgc: TDBEditCgcCpf
            Tag = 99
            Left = 69
            Top = 0
            Width = 188
            Height = 22
            Align = alLeft
            CharCase = ecUpperCase
            DataField = 'FOR_C_G_C_'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
            Tipo = C_G_C_
          end
          object btnConsultaFit: TBitBtnLocked
            Left = 256
            Top = 0
            Width = 27
            Height = 22
            Hint = 'Consulta Dados Cadastrais do CNPJ.'
            Enabled = False
            Glyph.Data = {
              36060000424D3606000000000000360000002800000020000000100000000100
              1800000000000006000000000000000000000000000000000000A449A3DC7D47
              D35C18D55D18D35C18D15B17D35C18C35516F1AA81CA5817D55D18D35C18D35C
              18D35C18F0A173A449A3A449A3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
              C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFA449A3DA7B44DC6019
              D35C18E97837F9DDCDE97939C65616F1AB83FDF2ECEF9C6CCF5A17DC6019DC60
              19DC6019DC6019F5C2A5C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3C3C3C3C3C3C3
              C3C3FFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E76A22D15B17
              EA7E40DA5F18E36319FAE2D4FBE8DDC15416FBE5D8FAE2D4E8722ED15B17DA5F
              18DA5F18DA5F18F1AB82C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFC3
              C3C3FFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3F1A87ECE5A17
              F8D4BFE76B24EC8D56E97736F9DAC8CA5817FDF1EAFDF1EAFADFCFE76C25D55D
              18DC6019DC6019F1AB83C3C3C3C3C3C3FFFFFFC3C3C3C3C3C3C3C3C3FFFFFFC3
              C3C3FFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3F0A173F7CEB7
              F6C8ADE76A22F9DBC9EA7D3FC15416FDF3EDFDF1EAFDF1EAFCEEE6FDF1EAF9D9
              C6E76920DC6019F1AB83C3C3C3FFFFFFC3C3C3C3C3C3FFFFFFC3C3C3C3C3C3FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3FFFFFFEF9F71F4BB9B
              F8D6C2E76D27F5BFA0E97939C35516FDF2ECFBE8DDFCEBE1FDF2ECFCEDE4FDF2
              ECEF9F71DC6019F1AB83C3C3C3C3C3C3FFFFFFC3C3C3FFFFFFC3C3C3C3C3C3FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C85716D75E18
              D35C18DC6019D15B17E16219F7D0B9CE5A17E97736E97736C65616FDF2ECFDF1
              EAFAE0D1D35C18F1AB83C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3
              C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFC3C3C3C3C3C3D15B17CC5917
              E76D27CE5A17F3B795FDF2ECF6C8AEDE6119EC8A51ED905BED935FFDF1EAFCEE
              E6FDF1EAE16219F2AD85C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3C3C3C3
              C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFC3C3C3FFFFFFCE5A17EC8A52
              FBE5D8F1A97FFDF2ECFDF1EAF8D3BDDC6019EE9866E06219C35516FDF2ECFCED
              E4FCEEE6F5C2A4F1A87EC3C3C3C3C3C3FFFFFFC3C3C3FFFFFFFFFFFFFFFFFFC3
              C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C35516FDF2EC
              FCEDE4FCEEE6FCEDE4FCEDE4FDF1EAE97532E56319CC5917EE9664FCEFE8FCED
              E4FCEDE4FDF2ECF0A579C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3
              C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFC3C3C3D15B17CF5A17
              FCEBE1FCEFE8FCEDE4FCEDE4FCEDE4FDF1EAFDF2ECFDF2ECFDF1EAFDF1EAFCEF
              E8FBE8DDDA5F18F2AD85C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3FFFFFFD15B17CE5A17
              FAE1D2FDF1EAFCEDE4FCEDE4FCEDE4FCEDE4FBE9DFF6C6ABFCEDE4F6C5A9EB82
              46E8702BD85E18F2AD85C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3D35C18D55D18
              F6CAB0F2AE87F9DCCBFCEDE4F8D1BBFCEFE8FDF2ECE97736CA5817DA5F18E062
              19E06219E06219F2AD85C3C3C3C3C3C3FFFFFFC3C3C3FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3D35C18E06219
              DE6119D55D18F4BB9BFBE6DAE8712DED905AF2AE87E76A22D85E18E16219E062
              19E06219E06219F2AD85C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFC3C3C3C3
              C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E08049E16219
              E16219E16219D75E18E06219E16219E16219DE6119E16219E06219E06219E062
              19E06219E16219F6C8ADC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
              C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFA449A3EE9561
              E56319E56319E56319E56319E56319E56319E56319E56319E56319E56319E563
              19E56319F4B997A449A3A449A3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
              C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3A449A3}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            TabStop = False
            OnClick = btnConsultaFitClick
          end
        end
        object dbeEmail3: TDBEditFocus
          Left = 81
          Top = 292
          Width = 270
          Height = 22
          CharCase = ecLowerCase
          DataField = 'FOR_EMAIL3'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 255
          TabOrder = 27
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeRevist: TDBEditFocus
          Tag = 99
          Left = 643
          Top = 248
          Width = 44
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_REVIST'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 24
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeZonFra: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 431
          Width = 29
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ZONFRA'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 38
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbchkDesmembr: TDBCheckBox
          Left = 444
          Top = 318
          Width = 151
          Height = 17
          Caption = 'Conta Cont'#225'bil / Empresa?'
          DataField = 'FOR_DESMEM'
          DataSource = dtsTabela
          TabOrder = 31
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object cbxMarRev: TComboBoxFocus
          Left = 81
          Top = 407
          Width = 135
          Height = 22
          Enabled = False
          TabOrder = 36
          OnChange = cbxMarRevChange
          Items.Strings = (
            'Com'#233'rcio'
            'Distribuidor'
            'Ind'#250'stria'
            'Revenda'
            'Material de Consumo'
            'Ind'#250'stria Incentivada')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeConRed: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 338
          Width = 159
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CONRED'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 32
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodCli: TDBEditFocus
          Tag = 99
          Left = 444
          Top = 338
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODCLI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 33
          OnKeyPress = dbeCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 501
          Top = 338
          Width = 262
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 43
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbePlaNco: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 315
          Width = 135
          Height = 22
          DataField = 'FOR_PLANCO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 29
          OnKeyPress = dbePlaNcoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDesPlaNco: TEditFocus
          Left = 219
          Top = 315
          Width = 132
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 42
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        inline fraPlanoDeContasAux: TfraPlanoDeContasDBEditFocus
          Left = 277
          Top = 407
          Width = 486
          Height = 22
          TabOrder = 37
          ExplicitLeft = 277
          ExplicitTop = 407
          ExplicitWidth = 486
          inherited lblPlaContas: TLabel
            Left = 45
            Top = 3
            Width = 119
            Height = 14
            Caption = 'Pl. Contas Di'#225'rio Auxiliar:'
            ExplicitLeft = 45
            ExplicitTop = 3
            ExplicitWidth = 119
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 167
            Height = 22
            DataField = 'FOR_CTATRA'
            DataSource = dtsTabela
            OnKeyPress = fraPlanoDeContasAuxdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            ExplicitLeft = 167
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 223
            Width = 263
            Height = 22
            ExplicitLeft = 223
            ExplicitWidth = 263
            ExplicitHeight = 22
          end
        end
        object DBEPEICMS: TDBEditFocus
          Tag = 99
          Left = 444
          Top = 384
          Width = 55
          Height = 22
          Hint = 'Habilitado quando o Regime Tribut'#225'rio for Simples'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          CharCase = ecUpperCase
          DataField = 'FOR_PEICMS'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 45
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeNotDes: TDBEditFocus
          Tag = 99
          Left = 662
          Top = 522
          Width = 39
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_NOTDES'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 46
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object btnAbrirPastaCliente: TBitBtnLocked
          Left = 771
          Top = 27
          Width = 101
          Height = 39
          Caption = 'Arquivos de Cadastro'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FF92635DA46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769A46769A46769A46769A46769A46769A46769A46769FF00FFFF
            00FFFF00FFFF00FFFF00FF93655EF2D9B0F2D7ABF0D4A9F0D1A5EFD1A1F0CF9E
            EFCE9CEFCB98EECA95EDC992EDC78FEDC68EEDC58BEBC488EBC286EBC184EBC0
            829F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF3DAB5F2D8B0F2D7ADF2
            D5AAF0D3A5EFD1A3EFD09FEFCE9DEFCC99EFCB97EDCA93EEC991EDC68EEBC58B
            EBC489EBC287EBC2869F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF4DD
            BAF3DAB6008100008100F2D5AAF0D4A7811E00811E00811E00811E00811E0081
            1E00811E00811E00811E00EDC58AEDC4889F6F60FF00FFFF00FFFF00FFFF00FF
            FF00FF93655FF4E0BDF3DEBB008100008100F3D8B0F2D5ACF0D4A9F2D3A4F0D1
            A1EFCF9FEFCE9CEECC98EECA96EEC992EDC990EDC68CEDC58B9F6F60FF00FFFF
            00FFFF00FFFF00FFFF00FF654441A79A86A69882A6977FA5967EA5957BA59378
            A59276A59173A59072A48F6EA48E6CA38C6AA38B68A18A66A18965A18862A188
            606C4C41FF00FFFF00FFFF00FF004B00004B00004B00004B00004B00004B0000
            4B00004B00004B00004B00004B00004B00004B00004B00004B00004B00004B00
            004B00004B00004B00004B00004B00004B00FF00FF004B00FF00FF986963F7E6
            CCF7E5C9F6E2C5F6E1C1F4DEBFF4DDBAF3DCB6F3D9B2F2D7AFF2D5ABF0D4A9F0
            D3A4F0D0A1EFCF9EEFCE9AEFCB98EECB969F6F60FF00FF004B00FF00FF004B00
            FF00FF9E6E64F8E9D0F7E6CE004B00004B00F6E2C2F4E0BF004B00004B00004B
            00004B00004B00004B00004B00004B00004B00EFCE9CEECC999F6F60FF00FF00
            4B00FF00FF004B00FF00FFA37266FAEBD7F8EAD3004B00004B00F6E3C7F6E2C4
            F4E0C0F4DEBCF3DCB8F3DCB5F2D8B1F2D7ADF2D4AAF0D3A6F0D1A4F0D0A0EFCE
            9D9F6F60FF00FF004B00FF00FF004B00FF00FF724F46AAA195A99F91A79E8FA9
            9E8EA99D8BA79A89A79A86A79983A79881A6977FA6967BA59379A59377A59175
            A59072A48F70A48F6D6C4C42FF00FF004B00FF00FF004B00004B00004A000049
            00004800004800004900004A00004B00004B00004B00004B00004B00004B0000
            4B00004B00004B00004B00004B00004B00004B00004B00004B00FF00FFFF00FF
            FF00FFA77766DED7CAD4CCBFD4CABBDCD1C1EBE0CAF4E6CFF7E9CFF7E6CAF6E3
            C7F4E2C4F4E0C0F4DEBCF4DCB8F3DCB5F3D9B1F2D7ADF0D5AAA07264FF00FFFF
            00FFFF00FFFF00FFFF00FFA1735FBFBAB0ABA59C005800006200DDD1C1F0E3D0
            801E00811E00811E00811E00811E00811E00811E00811E00811E00F3D9B2F3D8
            AFA07264FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B00004B00004B0000
            5600CEC5B6E7DCCBF0E5D1F6E7D1F6E7D0F7E6CEF7E5CAF6E3C6F6E1C2F4E0BF
            F3DEBBF4DCB6F3D9B4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B000895
            1106900E004B0098938BB8B0A6CEC5B8DDD4C2EBE1CEF6E9D3F8EAD3F7E7CEF7
            E6CBF6E3C6F6E1C4F6E0C0F4DEBCF3DDB8A07264FF00FFFF00FFFF00FFFF00FF
            FF00FF004B000C9D190A9814004B008A888198938CA7A198BFB6AADDD4C4F2E6
            D4F8EBD7F8EAD3F8E9D0F7E6CCF6E5C9F6E2C5F4E1C1F4E0BDA07264FF00FFFF
            00FF004B00004B00004B00004B0011A6240EA11D004B00004B00004B00004B00
            ABA59CD5CCC1F0E6D7F8EDD9FAEDD8F8EAD5F8E9D1F7E6CCF6E5CAF6E3C6F6E1
            C1A07264FF00FFFF00FF004B0025C74720C1401CBA3818B23014AC2911A5220D
            A01C0A9A17004B005814006E19007D1D00801E00811E00811E00811E00811E00
            811E00F7E6CAF6E3C6A07264FF00FFFF00FF004B002CD35528CC4D23C5451FBF
            3E1BB73517B02E13AB2710A520004B00BFBBB4DEDAD0F3EDE0FBF2E3FBF0E1FA
            EFDDF8EDDAF8EBD7F8EAD3F7E9CFF7E6CBA07264FF00FFFF00FF004B00004B00
            004B00004B0027CB4B22C443004B00004B00004B00004B00E0DCD7EFEAE2FAF3
            E9FBF4E9FBF2E5FAF2E2FBEFE0FAEEDAF8EBD8F8EAD4F7E7D0A07264FF00FFFF
            00FFFF00FFFF00FFFF00FF004B002DD45829CF52004B00AAA9A7D0CFCCEBE9E5
            F6F2EDFAF6EFFBF6EEFCF6EDFCF4E9FBF2E6FAF0E2FAEFE0FAEEDDFAEDD8F8EA
            D4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B0034DE6530D95E004B009D
            6B4FB77E5CC98965CE8C67CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68
            CF8E68CF8E68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B
            00004B00004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ParentFont = False
          TabOrder = 47
          WordWrap = True
          OnClick = btnAbrirPastaClienteClick
        end
        object dbeCODGEF: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 542
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODGEF'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 48
          OnKeyPress = dbeCODGEFKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDESGEF: TEditFocus
          Left = 137
          Top = 542
          Width = 263
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
        object dbeNumCep: TDBEditFocus
          Tag = 99
          Left = 81
          Top = 116
          Width = 69
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_C_E_P_'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          OnKeyPress = dbeNumCepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodCid: TDBEditFocus
          Tag = 99
          Left = 294
          Top = 116
          Width = 68
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODCID'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 9
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
        object edtEstado: TEditFocus
          Left = 724
          Top = 116
          Width = 39
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 50
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCidade: TEditFocus
          Left = 362
          Top = 116
          Width = 293
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 51
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
    object tbsCompras: TTabSheet
      Tag = 1
      Caption = '&2 - Compras'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnl1: TPanel
        Left = 0
        Top = 28
        Width = 1000
        Height = 609
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl3: TLabel
          Left = 33
          Top = 12
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cond. Pag.:'
        end
        object lbl4: TLabel
          Left = 16
          Top = 38
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Transportador:'
        end
        object lbl5: TLabel
          Left = 17
          Top = 109
          Width = 63
          Height = 28
          Alignment = taRightJustify
          Caption = 'E-mail Pedido'#13#10'de Compra:'
        end
        object lblVlRed2: TLabel
          Left = 111
          Top = 138
          Width = 355
          Height = 14
          Alignment = taRightJustify
          Caption = 
            'Arredondar valor '#224' partir da 2a parcela quando Cond. de Pagto. '#192 +
            ' Prazo?'
        end
        object lbl2: TColorLabel
          Left = 504
          Top = 138
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lbl6: TLabel
          Left = 206
          Top = 160
          Width = 260
          Height = 14
          Alignment = taRightJustify
          Caption = 'Car'#234'ncia p/ pagamento em Pedido de Compra '#192' Vista:'
        end
        object lbl7: TLabel
          Left = 297
          Top = 182
          Width = 169
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto para Pagamento '#192' Vista:'
        end
        object lbl8: TLabel
          Left = 684
          Top = 487
          Width = 108
          Height = 11
          Caption = '<ALT+3> Pr'#243'xima p'#225'gina'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl9: TLabel
          Left = 515
          Top = 160
          Width = 20
          Height = 14
          Caption = 'dias'
        end
        object lbl10: TLabel
          Left = 515
          Top = 182
          Width = 10
          Height = 14
          Caption = '%'
        end
        object Label60: TLabel
          Left = 361
          Top = 203
          Width = 105
          Height = 14
          Caption = 'Acordo de Objetivos?'
        end
        object ColorLabel1: TColorLabel
          Left = 517
          Top = 203
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblMinOrc: TLabel
          Left = 115
          Top = 249
          Width = 351
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor m'#237'nimo para gera'#231#227'o autom'#225'tica de or'#231'amentos de compra:'
        end
        object Label61: TLabel
          Left = 368
          Top = 227
          Width = 98
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Dias para entrega:'
        end
        object Label64: TLabel
          Left = 9
          Top = 559
          Width = 134
          Height = 14
          Caption = 'Observa'#231#245'es para Compra:'
        end
        object LabelDesMinPed: TLabel
          Left = 111
          Top = 271
          Width = 351
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor m'#237'nimo obrigat'#243'rio do pedido de compra para faturamento:'
        end
        object Label78: TLabel
          Left = 47
          Top = 91
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador:'
        end
        object Label79: TLabel
          Left = 6
          Top = 55
          Width = 82
          Height = 28
          Alignment = taRightJustify
          Caption = 'Transportador de Redespacho: '
          WordWrap = True
        end
        object Label80: TLabel
          Left = 370
          Top = 38
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Frete:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label81: TLabel
          Left = 370
          Top = 65
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Frete:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label84: TLabel
          Left = 153
          Top = 294
          Width = 312
          Height = 14
          Caption = 'Utilizar Rede '#194'ncora Services na cota'#231#227'o de pedido de compra?'
        end
        object ColorLabel5: TColorLabel
          Left = 517
          Top = 293
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblSEMAGEResp: TColorLabel
          Left = 517
          Top = 316
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblSEMAGE: TLabel
          Left = 21
          Top = 318
          Width = 442
          Height = 14
          Caption = 
            'Plano de Recebimento - Fornecedor sem necessidade de agendamento' +
            ' para recebimentos?'
        end
        object lbl154: TLabel
          Left = 17
          Top = 573
          Width = 124
          Height = 28
          AutoSize = False
          BiDiMode = bdRightToLeft
          Caption = 'Pressione TAB para o pr'#243'ximo campo'
          ParentBiDiMode = False
          WordWrap = True
        end
        object lblPALREC: TLabel
          Left = 96
          Top = 340
          Width = 367
          Height = 14
          Caption = 
            'Utiliza controle de cobran'#231'a por descarregamento de pallet no re' +
            'cebimento?'
        end
        object lblPALREC_SN: TColorLabel
          Left = 517
          Top = 340
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblConCol: TLabel
          Left = 286
          Top = 91
          Width = 266
          Height = 14
          Caption = 'Realizar controle de coleta de compras no fornecedor?'
        end
        object clrConCol: TColorLabel
          Left = 583
          Top = 91
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label50: TLabel
          Left = 102
          Top = 363
          Width = 361
          Height = 14
          Alignment = taRightJustify
          Caption = 
            'Selecionar empresa para faturar pedidos gerados pela Pasta de Co' +
            'mpras?'
        end
        object ColorLabel7: TColorLabel
          Left = 517
          Top = 363
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblDesBavBap: TLabel
          Left = 239
          Top = 450
          Width = 223
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto concedido apenas no boleto a vista:'
        end
        object lblPctDav: TLabel
          Left = 517
          Top = 452
          Width = 44
          Height = 14
          Caption = '% prazo:'
        end
        object lblPctDap: TLabel
          Left = 614
          Top = 452
          Width = 10
          Height = 14
          Caption = '%'
        end
        object dbeCndPag: TDBEditFocus
          Tag = 99
          Left = 144
          Top = 8
          Width = 332
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CNDPAG'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodTrans: TDBEditFocus
          Tag = 99
          Left = 93
          Top = 34
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODTRA'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnKeyPress = dbeCodTransKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodTraChamaCadastro
        end
        object edtNomTrans: TEditFocus
          Left = 144
          Top = 34
          Width = 220
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
        object dbeEmaPed: TDBEditFocus
          Left = 82
          Top = 112
          Width = 270
          Height = 22
          CharCase = ecLowerCase
          DataField = 'FOR_EMAPED'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVlRed2: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 134
          Width = 29
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_VLRED2'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeCarPag: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 156
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CARPAG'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDesVis: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 178
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_DESVIS'
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
        object dbeAcoObj: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 201
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ACOOBJ'
          DataSource = dtsTabela
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMinOrc: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 246
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_MINORC'
          DataSource = dtsTabela
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDiaEnt: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 224
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_DIAENT'
          DataSource = dtsTabela
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeObsCmp: TDBMemoFocus
          Left = 147
          Top = 562
          Width = 523
          Height = 39
          DataField = 'FOR_OBSCMP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 26
          OnKeyPress = dbeObservKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbeMinPed: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 268
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_MINPED'
          DataSource = dtsTabela
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object grbNivel: TcxGroupBox
          Left = 680
          Top = 6
          Caption = 'N'#237'vel de Giro e Criticidade'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          Style.Shadow = False
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 27
          Height = 181
          Width = 321
          object cmbTipNiv: TComboBoxFocus
            Left = 9
            Top = 19
            Width = 238
            Height = 22
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = 'Nenhum'
            OnChange = cmbTipNivChange
            Items.Strings = (
              'Nenhum'
              'N'#237'vel de Giro'
              'N'#237'vel de Criticidade'
              'N'#237'vel de Giro + N'#237'vel de Criticidade')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cxgNivel: TcxGridCitel
            Left = 9
            Top = 44
            Width = 300
            Height = 130
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvNivel: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              OnEditKeyDown = cxvNivelEditKeyDown
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxvNivelNIVGIR: TcxGridDBColumn
                Caption = 'N'#237'vel'
                DataBinding.FieldName = 'NIVGIR'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 50
              end
              object cxvNivelUSANIV: TcxGridDBColumn
                Caption = 'Calcular'
                DataBinding.FieldName = 'USANIV'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 50
              end
              object cxvNivelQTDDIA: TcxGridDBColumn
                Caption = 'Dias de Compra'
                DataBinding.FieldName = 'QTDDIA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DecimalPlaces = 0
                Properties.DisplayFormat = '0;-0'
                Properties.OnValidate = cxvNivelQTDDIAPropertiesValidate
                HeaderAlignmentHorz = taRightJustify
                Width = 90
              end
              object cxvNivelPERCON: TcxGridDBColumn
                Caption = '% Eleva'#231#227'o Consum'#237'veis'
                DataBinding.FieldName = 'PERCON'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                Width = 137
              end
            end
            object cxgNivelLevel1: TcxGridLevel
              GridView = cxvNivel
            end
          end
        end
        object grbCalMinMax: TGroupBox
          Left = 680
          Top = 186
          Width = 321
          Height = 169
          Caption = 'C'#225'lculo do Estoque M'#237'nimo e M'#225'ximo'
          TabOrder = 29
          object cxgMinMax: TcxGridCitel
            Left = 2
            Top = 16
            Width = 317
            Height = 145
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvMinMax: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              OnEditKeyDown = cxvNivelEditKeyDown
              OnEditKeyPress = cxvMinMaxEditKeyPress
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Zebra = True
              Destaque = False
              CorZebra = clMoneyGreen
              object cxvMinMaxNIVABC: TcxGridDBColumn
                Caption = 'ABC'
                DataBinding.FieldName = 'FOR_NIVGIR'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                SortIndex = 0
                SortOrder = soAscending
                Width = 47
              end
              object cxvMinMaxNIVXYZ: TcxGridDBColumn
                Caption = 'XYZ'
                DataBinding.FieldName = 'FOR_NIVCRI'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                SortIndex = 1
                SortOrder = soAscending
                Width = 47
              end
              object cxvMinMaxPERMIN: TcxGridDBColumn
                Caption = '%M'#237'nimo'
                DataBinding.FieldName = 'FOR_PERMIN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '#,##0.00;-#,##0.00'
                HeaderAlignmentHorz = taCenter
                Width = 55
              end
              object cxvMinMaxPERMAX: TcxGridDBColumn
                Caption = '%M'#225'ximo'
                DataBinding.FieldName = 'FOR_PERMAX'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '#,##0.00;-#,##0.00'
                HeaderAlignmentHorz = taCenter
                Width = 55
              end
              object cxvMinMaxELECON: TcxGridDBColumn
                Caption = '%Elev.Consum.'
                DataBinding.FieldName = 'FOR_ELECON'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '#,##0.00;-#,##0.00'
                HeaderAlignmentHorz = taCenter
                Width = 80
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxvMinMax
            end
          end
        end
        object edtNomPor: TEditFocus
          Left = 144
          Top = 87
          Width = 117
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
        object dbeCodPor: TDBEditFocus
          Tag = 99
          Left = 93
          Top = 87
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODPOR'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 8
          OnKeyPress = dbeCodPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object dbeCodTransRedes: TDBEditFocus
          Tag = 99
          Left = 93
          Top = 61
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_TRARED'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          OnKeyPress = dbeCodTransRedesKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodTraChamaCadastro
        end
        object edtNomTransRedes: TEditFocus
          Left = 144
          Top = 61
          Width = 220
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
        object cmbTipFre: TComboBoxFocus
          Tag = 99
          Left = 438
          Top = 34
          Width = 200
          Height = 22
          Style = csDropDownList
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object cmbTipFreRedespacho: TComboBoxFocus
          Tag = 99
          Left = 438
          Top = 61
          Width = 200
          Height = 22
          Style = csDropDownList
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeAncora: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 291
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ANCORA'
          DataSource = dtsTabela
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object rdgBSTXML: TDBRadioGroup
          Left = 11
          Top = 468
          Width = 661
          Height = 47
          Caption = 'Base da Substitui'#231#227'o na Importa'#231#227'o do XML:'
          DataField = 'FOR_BSTXML'
          DataSource = dtsTabela
          Items.Strings = (
            
              'Somar o valor do IPI ao total dos produtos para depois aplicar a' +
              ' redu'#231#227'o da Base da ST.'
            
              'Aplicar a redu'#231#227'o da Base da ST somente sobre o total dos produt' +
              'os.')
          TabOrder = 24
          Values.Strings = (
            '0'
            '1')
        end
        object btnHelp: TBitBtnLocked
          Left = 646
          Top = 480
          Width = 24
          Height = 22
          Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
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
            00000000000000000000000000000000000019110A229F7143DDB8824DFF563D
            2477000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000004A341F66B8824DFFB8824DFFB882
            4DFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000019110A229F7143DDB8824DFF563D
            2477000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000251A0F33B8824DFFB8824DFF251A
            0F33000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000031231544B8824DFFB8824DFF4A34
            1F66000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000956A3FCFB8824DFFB882
            4DFF45311D600000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000023180E30A17243DFB882
            4DFFB8824DFF3A29185000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000C080510AC7A
            48EFB8824DFFA17243DF00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000006749
            2B8FB8824DFFB8824DFF2E211340000000000000000000000000000000000000
            0000000000000000000000000000956A3FCF17100A2000000000000000007E59
            35AFB8824DFFB8824DFF2E211340000000000000000000000000000000000000
            0000000000000000000000000000B8824DFFB8824DFF956A3FCF956A3FCFB882
            4DFFB8824DFFAC7A48EF0C080510000000000000000000000000000000000000
            0000000000000000000000000000A17243DFB8824DFFB8824DFFB8824DFFB882
            4DFFAC7A48EF45311D6000000000000000000000000000000000000000000000
            0000000000000000000000000000000000002E2113405C41267F5C41267F4531
            1D600C0805100000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 30
          OnClick = btnHelpClick
          OnMouseLeave = btnHelpMouseLeave
        end
        inline fraPlanoDeContasCmp: TfraPlanoDeContasDBEditFocus
          Left = 358
          Top = 112
          Width = 318
          Height = 22
          TabOrder = 11
          ExplicitLeft = 358
          ExplicitTop = 112
          ExplicitWidth = 318
          inherited lblPlaContas: TLabel
            Left = 3
            Top = 3
            Width = 51
            Height = 14
            Caption = 'Pl. Contas:'
            ExplicitLeft = 3
            ExplicitTop = 3
            ExplicitWidth = 51
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 56
            Height = 22
            DataField = 'FOR_CODCTA'
            DataSource = dtsTabela
            OnKeyPress = fraPlanoDeContasCmpdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            ExplicitLeft = 56
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 112
            Width = 205
            Height = 22
            ExplicitLeft = 112
            ExplicitWidth = 205
            ExplicitHeight = 22
          end
        end
        object dbeSEMAGE: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 314
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_SEMAGE'
          DataSource = dtsTabela
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEPALREC: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 337
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_PALREC'
          DataSource = dtsTabela
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConCol: TDBEditFocus
          Tag = 99
          Left = 556
          Top = 87
          Width = 26
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CONCOL'
          DataSource = dtsTabela
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmpPas: TDBEditFocus
          Tag = 99
          Left = 469
          Top = 360
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_EMPPAS'
          DataSource = dtsTabela
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object pnlPedidoCompraDolar: TPanel
          Left = 18
          Top = 424
          Width = 246
          Height = 23
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = 'Pedido de compra em d'#243'lar?'
          TabOrder = 31
          object ColorLabel9: TColorLabel
            Left = 191
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbePedidoCompraDolar: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 0
            Width = 43
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FOR_PEDDOL'
            DataSource = dtsTabela
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlCompraImportacao: TPanel
          Left = 299
          Top = 424
          Width = 275
          Height = 23
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = 'Pedido de Compra de Importa'#231#227'o?'
          TabOrder = 32
          object ColorLabel11: TColorLabel
            Left = 218
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object DBEditFocus1: TDBEditFocus
            Tag = 99
            Left = 169
            Top = 1
            Width = 43
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FOR_PEDIMP'
            DataSource = dtsTabela
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object dbeDesBav: TDBEditFocus
          Tag = 99
          Left = 468
          Top = 449
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_DESBAV'
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
        object dbeDesBap: TDBEditFocus
          Tag = 99
          Left = 565
          Top = 449
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_DESBAP'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 34
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodCnd: TDBEditFocus
          Tag = 99
          Left = 93
          Top = 8
          Width = 50
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_CODCND'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnKeyPress = dbeCodCndKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object DBRadioGroup1: TDBRadioGroup
          Left = 21
          Top = 382
          Width = 553
          Height = 36
          Caption = 'Este fornecedor inclui o valor do IPI ?'
          Columns = 3
          DataField = 'FOR_SOMIPI'
          DataSource = dtsTabela
          Items.Strings = (
            'N'#227'o Inclui'
            'Na base de calculo do ICMS'
            'Na base de calculo do ICMS ST')
          TabOrder = 23
          Values.Strings = (
            'N'
            'S'
            'T')
        end
        object btnObsCmp: TBitBtnLocked
          Left = 672
          Top = 561
          Width = 24
          Height = 22
          Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
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
            7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
            88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
            C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
            87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
            F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
            A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
            FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
            A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
            F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
            92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
            D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
            6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
            A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
            84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
            4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
            F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
            020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
            A2FC62504B900404031000000002000000000000000000000000000000000000
            000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
            1F3E000000060000000100000000000000000000000000000000}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 35
          OnClick = btnObsCmpClick
          OnMouseLeave = btnHelpMouseLeave
        end
        object Panel9: TPanel
          Left = 9
          Top = 515
          Width = 976
          Height = 43
          BevelOuter = bvNone
          TabOrder = 25
          object Label93: TLabel
            Left = 5
            Top = 1
            Width = 239
            Height = 14
            Caption = 'CFOP v'#225'lidos para Entrada Manual no Livro Fiscal'
          end
          object Label41: TLabel
            Left = 466
            Top = 9
            Width = 506
            Height = 28
            Caption = 
              '* Aten'#231#227'o: se nenhuma CFOP for informada nesa tela, ent'#227'o ser'#227'o ' +
              'consideradas, na inclus'#227'o manual do livro fiscal, as CFOPs de en' +
              'trada definidas na configura'#231#227'o CFG_CLAGOM, com j'#225' '#233' atualmente.'
            WordWrap = True
          end
          object DBEditFocus2: TDBEditFocus
            Left = 5
            Top = 16
            Width = 455
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FOR_CODCFO'
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
        end
        object edtCndDescri: TEditFocus
          Left = 477
          Top = 8
          Width = 199
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 36
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlTipAbf: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 28
        Align = alTop
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object lblAbfTit: TLabel
          Left = 2
          Top = 6
          Width = 139
          Height = 14
          Caption = 'Tipo de Abrv. Fiscal de ICMS:'
          Visible = False
        end
        object lblAbfDes: TLabel
          Left = 141
          Top = 6
          Width = 433
          Height = 14
          Caption = 
            'PER - ENTRADAS PESSOA JUR'#205'DICA (DISTRIBUI'#199#195'O/REVENDA/COMERCIALIZ' +
            'A'#199#195'O)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          Visible = False
        end
        object btnAbf: TBitBtnLocked
          Left = 707
          Top = 2
          Width = 98
          Height = 22
          Caption = 'Cad Abrv. ICMS'
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
          TabStop = False
          Visible = False
          OnClick = btnAbfClick
        end
      end
    end
    object Tributações: TTabSheet
      Caption = '&3 - Tributa'#231#245'es'
      ImageIndex = 15
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFundoTribut: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object Panel6: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 708
          Height = 629
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object lblCPRB: TLabel
            Left = 10
            Top = 365
            Width = 436
            Height = 14
            Caption = 
              'Fornecedor '#233' contribuiente da contribui'#231#227'o previdenci'#225'ria sobre ' +
              'a Receita Bruta ( CPRB )?'
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 295
            Width = 708
            Height = 54
            Align = alTop
            Caption = 'IPI'
            TabOrder = 5
            object chkFOR_ADIDCI: TDBCheckBox
              Left = 15
              Top = 16
              Width = 500
              Height = 17
              Caption = 
                'Aplicar desconto de ICMS Desonerado na base de c'#225'lculo do IPI ? ' +
                ' '
              DataField = 'FOR_ADIDCI'
              DataSource = dtsTabela
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkFOR_ADPCIP: TDBCheckBox
              Left = 15
              Top = 32
              Width = 500
              Height = 17
              Caption = 'Aplicar desconto de PIS/COFINS na base de c'#225'lculo do IPI ?    '
              DataField = 'FOR_ADPCIP'
              DataSource = dtsTabela
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox2: TGroupBox
            Left = 0
            Top = 87
            Width = 708
            Height = 113
            Align = alTop
            Caption = 'PIS/Cofins'
            TabOrder = 2
            object Label57: TLabel
              Left = 15
              Top = 71
              Width = 167
              Height = 14
              Alignment = taRightJustify
              Caption = 'Al'#237'quota de PIS para Compras:......:'
            end
            object Label70: TLabel
              Left = 236
              Top = 71
              Width = 10
              Height = 14
              Caption = '%'
            end
            object Label82: TLabel
              Left = 15
              Top = 94
              Width = 168
              Height = 14
              Alignment = taRightJustify
              Caption = 'Al'#237'quota de COFINS para Compras:'
            end
            object Label83: TLabel
              Left = 236
              Top = 94
              Width = 10
              Height = 14
              Caption = '%'
            end
            object chkFOR_ADPCPC: TDBCheckBox
              Left = 15
              Top = 15
              Width = 386
              Height = 17
              Caption = 'Aplicar desconto de PIS/COFINS no Pedido de Compra ?  '
              DataField = 'FOR_ADPCPC'
              DataSource = dtsTabela
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkFOR_IFDAPC: TDBCheckBox
              Left = 15
              Top = 31
              Width = 406
              Height = 17
              Caption = 
                'Incluir FRETE e DESP.ACESSORIAS na base de c'#225'lculo do PIS/COFINS' +
                ' ?   '
              DataField = 'FOR_IFDAPC'
              DataSource = dtsTabela
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dbeAlqPis: TDBEditFocus
              Tag = 99
              Left = 184
              Top = 64
              Width = 49
              Height = 22
              CharCase = ecUpperCase
              DataField = 'FOR_ALQPIS'
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
            object dbeAlqCof: TDBEditFocus
              Tag = 99
              Left = 184
              Top = 87
              Width = 49
              Height = 22
              CharCase = ecUpperCase
              DataField = 'FOR_ALQCOF'
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
            object chkFOR_ADICPC: TDBCheckBox
              Tag = 99
              Left = 15
              Top = 47
              Width = 617
              Height = 17
              Caption = 
                'Aplicar desconto de ICMS Desonerado na base de c'#225'lculo do PIS/CO' +
                'FINS ?     '
              DataField = 'FOR_ADICPC'
              DataSource = dtsTabela
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox4: TGroupBox
            Left = 0
            Top = 29
            Width = 708
            Height = 58
            Align = alTop
            Caption = 'ICMS Desonerado'
            TabOrder = 1
            object chkFOR_ADIDPC: TDBCheckBox
              Left = 549
              Top = 12
              Width = 28
              Height = 17
              Caption = 'Aplicar desconto de ICMS Desonerado no Pedido de Compra ?'
              DataField = 'FOR_ADIDPC'
              DataSource = dtsTabela
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              Visible = False
            end
            object chkFOR_FDAICD: TDBCheckBox
              Left = 15
              Top = 17
              Width = 500
              Height = 17
              Caption = 
                'Incluir FRETE e DESP.ACESSORIAS na base de c'#225'lculo na base de c'#225 +
                'lculo do ICMS Desonerado ?'
              DataField = 'FOR_FDAICD'
              DataSource = dtsTabela
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkFOR_IDPCID: TDBCheckBox
              Tag = 99
              Left = 15
              Top = 34
              Width = 500
              Height = 17
              Caption = 
                'Incluir desconto de PIS/COFINS na base de c'#225'lculo do ICMS Desone' +
                'rado ?  '
              DataField = 'FOR_IDPCID'
              DataSource = dtsTabela
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox3: TGroupBox
            Left = 0
            Top = 200
            Width = 708
            Height = 56
            Align = alTop
            Caption = 'Substitui'#231#227'o Tribut'#225'ria'
            TabOrder = 3
            object chkFOR_ADIDST: TDBCheckBox
              Left = 15
              Top = 16
              Width = 500
              Height = 17
              Caption = 'Aplicar desconto de ICMS Desonerado na base de c'#225'lculo da ST ? '
              DataField = 'FOR_ADIDST'
              DataSource = dtsTabela
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkFOR_REDPIS: TDBCheckBox
              Left = 15
              Top = 32
              Width = 500
              Height = 17
              Caption = 'Aplicar desconto de PIS/COFINS na base de c'#225'lculo da ST ?  '
              DataField = 'FOR_REDPIS'
              DataSource = dtsTabela
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox5: TGroupBox
            Left = 0
            Top = 256
            Width = 708
            Height = 39
            Align = alTop
            Caption = 'ICMS Opera'#231#245'es Pr'#243'prias'
            TabOrder = 4
            object chkFOR_ADIDIC: TDBCheckBox
              Left = 549
              Top = 16
              Width = 28
              Height = 17
              Caption = 
                'Aplicar desconto de ICMS Desonerado na base de c'#225'lculo do ICMS ?' +
                '  '
              DataField = 'FOR_ADIDIC'
              DataSource = dtsTabela
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              Visible = False
            end
            object chkFOR_ADPCST: TDBCheckBox
              Left = 15
              Top = 15
              Width = 500
              Height = 17
              Caption = 'Aplicar desconto de PIS/COFINS na base de c'#225'lculo do ICMS ?    '
              DataField = 'FOR_ADPCST'
              DataSource = dtsTabela
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 708
            Height = 29
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label181: TLabel
              Left = 10
              Top = 11
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Suframa:'
            end
            object dbeSuframa: TDBEditFocus
              Tag = 99
              Left = 60
              Top = 3
              Width = 153
              Height = 22
              CharCase = ecUpperCase
              DataField = 'FOR_SUFRAM'
              DataSource = dtsTabela
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 25
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object cbxCPRB: TComboBoxFocus
            Left = 452
            Top = 360
            Width = 255
            Height = 22
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 6
            Text = 'N'#227'o '#233' contribuinte da CPRB - reten'#231#227'o de 11%'
            Items.Strings = (
              'N'#227'o '#233' contribuinte da CPRB - reten'#231#227'o de 11%'
              #201' contribuinte da CPRB - reten'#231#227'o de 3,5%.')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
    end
    object tbsDadosDeposito: TTabSheet
      Tag = 2
      Caption = '&4 - Dados para Dep'#243'sito'
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlContaBancaria: TPanel
        Tag = 2
        Left = 0
        Top = 0
        Width = 1000
        Height = 325
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object grbDadosBancarios: TGroupBox
          Left = 0
          Top = 0
          Width = 1000
          Height = 325
          Align = alClient
          Caption = 'Dados Banc'#225'rios '
          TabOrder = 0
          object pnlDadosBancariosGrid: TPanel
            Left = 2
            Top = 124
            Width = 996
            Height = 199
            Align = alBottom
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            object dbgBcoFor: TDBGridCitel
              Left = 0
              Top = 27
              Width = 996
              Height = 172
              Align = alClient
              DataSource = dtsBcoFor
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
              ReadOnly = True
              TabOrder = 1
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = 14
              TitleFont.Name = 'Arial'
              TitleFont.Pitch = fpVariable
              TitleFont.Style = []
              OnDblClick = dbgBcoForDblClick
              OnKeyDown = dbgBcoForKeyDown
              CorZebra = clMoneyGreen
              Zebra = False
              DestacarMouse = False
              Columns = <
                item
                  Expanded = False
                  FieldName = 'BANCO'
                  Width = 225
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'AGENCIA'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CONTA'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BCF_DIGVER'
                  Width = 101
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BCF_CAMCEN'
                  Width = 109
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BCF_COMPDES'
                  Width = 110
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BCF_NOMTIT'
                  Title.Caption = 'Nome Titular Conta'
                  Width = 179
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BCF_DESPAG'
                  Title.Caption = 'Conta Pagamento'
                  Visible = True
                end>
            end
            object pnlAcoesDD: TPanel
              Left = 0
              Top = 0
              Width = 996
              Height = 27
              Align = alTop
              BevelOuter = bvNone
              Color = clGray
              ParentBackground = False
              TabOrder = 0
              object btnIncluirDD: TBitBtnLocked
                Left = 4
                Top = 2
                Width = 76
                Height = 24
                Caption = '&Incluir'
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
                OnClick = btnIncluirDDClick
              end
              object btnAlterarDD: TBitBtnLocked
                Left = 158
                Top = 2
                Width = 76
                Height = 24
                Caption = '&Alterar'
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                  A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
                  69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
                  CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
                  A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
                  7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
                  820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
                  A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
                  81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
                  860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
                  A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
                  93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
                  C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
                  BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
                  A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
                  D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
                  D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
                  B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
                  9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
                  DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
                  55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
                  E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
                  6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
                  926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
                TabOrder = 2
                OnClick = btnAlterarDDClick
              end
              object btnExcluirDD: TBitBtnLocked
                Left = 234
                Top = 2
                Width = 76
                Height = 24
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
                TabOrder = 3
                OnClick = btnExcluirDDClick
              end
              object btnCancelarDD: TBitBtnLocked
                Left = 311
                Top = 2
                Width = 76
                Height = 24
                Caption = 'Ca&ncelar'
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
                TabOrder = 4
                OnClick = btnCancelarDDClick
              end
              object btnGravarDD: TBitBtnLocked
                Left = 81
                Top = 2
                Width = 76
                Height = 24
                Caption = 'G&ravar'
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
                TabOrder = 1
                OnClick = btnGravarDDClick
              end
            end
          end
          object pnlDadosBancarios: TPanel
            Left = 2
            Top = 16
            Width = 996
            Height = 108
            Align = alClient
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object lblCodBco: TLabel
              Left = 132
              Top = 3
              Width = 34
              Height = 14
              Caption = 'Banco:'
            end
            object Label73: TLabel
              Left = 88
              Top = 25
              Width = 78
              Height = 14
              Caption = 'Ag'#234'ncia / D'#237'gito:'
            end
            object lblConCor: TLabel
              Left = 267
              Top = 25
              Width = 66
              Height = 14
              Caption = 'Conta / D'#237'gito:'
            end
            object Label74: TLabel
              Left = 456
              Top = 25
              Width = 85
              Height = 14
              Caption = 'D'#237'gito Verificador:'
              Visible = False
            end
            object Label75: TLabel
              Left = 13
              Top = 47
              Width = 153
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'd. da C'#226'mara Centralizadora:'
            end
            object Label76: TLabel
              Left = 228
              Top = 47
              Width = 165
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'C'#243'd. Complementar de Destino:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object ColorLabel6: TColorLabel
              Left = 439
              Top = 47
              Width = 203
              Height = 14
              Caption = '(CC) Conta Corrente (PP) Conta Poupan'#231'a'
              CorDestaque = clRed
            end
            object lblNomTit: TLabel
              Left = 43
              Top = 69
              Width = 123
              Height = 14
              Caption = 'Nome do Titular da Conta:'
            end
            object edtCodBco: TEditFocus
              Tag = 99
              Left = 169
              Top = 0
              Width = 57
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 3
              TabOrder = 0
              OnExit = edtCodBcoExit
              OnKeyPress = edtCodBcoKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttNumerico
            end
            object edtNomBco: TEditFocus
              Left = 226
              Top = 0
              Width = 337
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
            object edtNumAge: TEditFocus
              Tag = 99
              Left = 169
              Top = 22
              Width = 57
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 5
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDigAge: TEditFocus
              Tag = 99
              Left = 226
              Top = 22
              Width = 19
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 1
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtNumCta: TEditFocus
              Tag = 99
              Left = 336
              Top = 22
              Width = 77
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 12
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDigCta: TEditFocus
              Tag = 99
              Left = 413
              Top = 22
              Width = 19
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 2
              TabOrder = 5
              OnExit = edtDigCtaExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDigVer: TEditFocus
              Tag = 99
              Left = 544
              Top = 22
              Width = 19
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 1
              TabOrder = 6
              Visible = False
              OnEnter = edtDigVerEnter
              OnExit = edtDigVerExit
              OnMouseEnter = edtDigVerMouseEnter
              OnMouseLeave = edtDigVerMouseLeave
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtCamCen: TEditFocus
              Tag = 99
              Left = 169
              Top = 44
              Width = 57
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 3
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttInteiro
            end
            object edtCompDes: TEditFocus
              Tag = 99
              Left = 396
              Top = 44
              Width = 36
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 5
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtNomTit: TEditFocus
              Tag = 99
              Left = 169
              Top = 66
              Width = 394
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 60
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 60
              TipoTexto = ttAlfanumerico
            end
            object dbchkCtaPag: TDBCheckBox
              Left = 169
              Top = 90
              Width = 145
              Height = 16
              Caption = 'Conta Pagamento'
              DataField = 'FOR_DESMEM'
              DataSource = dtsTabela
              TabOrder = 10
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
        end
      end
      object grpPixDoFornecedor: TGroupBox
        Left = 0
        Top = 325
        Width = 1000
        Height = 312
        Align = alClient
        Caption = 'Dados Pix do Fornecedor'
        TabOrder = 1
        object pnlCamposPix: TPanel
          Left = 2
          Top = 16
          Width = 996
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label88: TLabel
            Left = 12
            Top = 4
            Width = 55
            Height = 14
            Caption = 'Tipo do Pix:'
          end
          object Label89: TLabel
            Left = 232
            Top = 4
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Chave:'
          end
          object cmbTipoDoPix: TComboBoxFocus
            Tag = 99
            Left = 73
            Top = 0
            Width = 145
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = cmbTipoDoPixChange
            Items.Strings = (
              '1-CNPJ / 2-CPF'
              'Celular'
              'Email'
              'Chave Aleat'#243'ria')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtCPFCNPJPix: TEditFocus
            Tag = 99
            Left = 268
            Top = 1
            Width = 27
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 1
            TabOrder = 1
            OnEnter = edtCPFCNPJPixEnter
            OnExit = edtCPFCNPJPixExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttInteiro
          end
          object edtChavePix: TEditFocus
            Tag = 99
            Left = 295
            Top = 1
            Width = 224
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 14
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
        end
        object pnlAcoesPix: TPanel
          Left = 2
          Top = 44
          Width = 996
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Color = clGray
          ParentBackground = False
          TabOrder = 1
          object btnIncluirPix: TBitBtnLocked
            Left = 4
            Top = 2
            Width = 76
            Height = 24
            Caption = 'Incluir'
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
            OnClick = btnIncluirPixClick
          end
          object btnAlterarPix: TBitBtnLocked
            Left = 157
            Top = 2
            Width = 76
            Height = 24
            Caption = 'Alterar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
              69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
              CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
              A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
              7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
              820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
              A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
              81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
              860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
              A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
              93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
              C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
              BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
              A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
              D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
              D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
              B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
              9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
              DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
              55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
              E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
              6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
              926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 2
            OnClick = btnAlterarPixClick
          end
          object btnExcluirPix: TBitBtnLocked
            Left = 234
            Top = 2
            Width = 76
            Height = 24
            Caption = 'Excluir'
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
            TabOrder = 3
            OnClick = btnExcluirPixClick
          end
          object btnCancelarPix: TBitBtnLocked
            Left = 311
            Top = 2
            Width = 76
            Height = 24
            Caption = 'Cancelar'
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
            TabOrder = 4
            OnClick = btnCancelarPixClick
          end
          object btnGravarPix: TBitBtnLocked
            Left = 81
            Top = 2
            Width = 76
            Height = 24
            Caption = 'Gravar'
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
            TabOrder = 1
            OnClick = btnGravarPixClick
          end
        end
        object dbgChavesPix: TDBGridCitel
          Left = 2
          Top = 71
          Width = 996
          Height = 239
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 2
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDblClick = dbgChavesPixDblClick
          OnKeyDown = dbgChavesPixKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'PIX_TIPCHV'
              Title.Caption = 'Tipo da Chave Pix'
              Width = 125
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PIX_CHAVE_'
              Title.Caption = 'Chave Pix'
              Width = 301
              Visible = True
            end>
        end
      end
    end
    object tbsContatos: TTabSheet
      Tag = 3
      Caption = '&5 - Contatos'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlContatos: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 177
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label24: TLabel
          Left = 28
          Top = 12
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label25: TLabel
          Left = 9
          Top = 34
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label26: TLabel
          Left = 26
          Top = 56
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label27: TLabel
          Left = 472
          Top = 12
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fone:'
        end
        object Label28: TLabel
          Left = 23
          Top = 78
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label29: TLabel
          Left = 405
          Top = 78
          Width = 25
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'UF:'
        end
        object Label30: TLabel
          Left = 27
          Top = 100
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail:'
        end
        object Label34: TLabel
          Left = 478
          Top = 34
          Width = 21
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cel.:'
        end
        object Label35: TLabel
          Left = 478
          Top = 56
          Width = 21
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fax:'
        end
        object Label36: TLabel
          Left = 336
          Top = 100
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Depto:'
        end
        object edtNomCtt: TEditFocus
          Tag = 99
          Left = 62
          Top = 8
          Width = 405
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEndCtt: TEditFocus
          Tag = 99
          Left = 62
          Top = 30
          Width = 405
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBaiCtt: TEditFocus
          Tag = 99
          Left = 62
          Top = 52
          Width = 405
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesCidCtt: TEditFocus
          Left = 112
          Top = 74
          Width = 294
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCidCtt: TEditFocus
          Tag = 99
          Left = 62
          Top = 74
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 6
          OnEnter = edtCidCttEnter
          OnExit = edtCidCttExit
          OnKeyPress = edtCidCttKeyPress
          OnKeyUp = edtCidCttKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtEstadoCtt: TEditFocus
          Left = 433
          Top = 74
          Width = 34
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
        object edtEmaCtt: TEditFocus
          Tag = 99
          Left = 62
          Top = 96
          Width = 268
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 80
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDepCtt: TEditFocus
          Tag = 99
          Left = 370
          Top = 96
          Width = 97
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 80
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkCmpCtt: TCheckBox
          Tag = 99
          Left = 62
          Top = 120
          Width = 268
          Height = 17
          Caption = 'Contato do Pedido de Compra'
          TabOrder = 11
        end
        object mskTelCtt: TMaskEditTelefone
          Tag = 99
          Left = 504
          Top = 8
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          EditMask = '!\(99\)9999-9999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 13
          TabOrder = 1
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
          Pais = opcBrasil
        end
        object mskCelCtt: TMaskEditTelefone
          Tag = 99
          Left = 504
          Top = 30
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          EditMask = '!\(99\)9999-9999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 13
          TabOrder = 2
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
          Pais = opcBrasil
        end
        object mskFaxCtt: TMaskEditTelefone
          Tag = 99
          Left = 504
          Top = 52
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          EditMask = '!\(99\)9999-9999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 13
          TabOrder = 3
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
          Pais = opcBrasil
        end
        object btnAdicionarCtt: TBitBtnLocked
          Left = 504
          Top = 74
          Width = 111
          Height = 22
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
          TabOrder = 12
          OnClick = btnAdicionarCttClick
        end
        object btnCancelaCtt: TBitBtnLocked
          Left = 504
          Top = 96
          Width = 111
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
          TabOrder = 13
          OnClick = btnCancelaCttClick
        end
        object Panel8: TPanel
          Left = 4
          Top = 151
          Width = 992
          Height = 22
          Align = alBottom
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 14
          object btnGatWpp: TBitBtnLocked
            Left = 753
            Top = 0
            Width = 239
            Height = 22
            Align = alRight
            Caption = 'Whatsapp - Gatilhos para envio de mensagens'
            TabOrder = 0
            Visible = False
            OnClick = btnGatWppClick
          end
        end
      end
      object dbgContatos: TDBGridCitel
        Left = 0
        Top = 177
        Width = 1000
        Height = 460
        Align = alClient
        DataSource = dtsForCtt
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnEnter = dbgContatosEnter
        OnKeyDown = dbgContatosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'NOMCTT'
            Title.Caption = 'Nome'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TELCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Telefone'
            Width = 95
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CELCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Celular'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'FAXCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Fax'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DEPCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Departamento'
            Width = 108
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMCID'
            Title.Caption = 'Cidade'
            Width = 129
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENDCTT'
            Title.Caption = 'Endere'#231'o'
            Width = 162
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAICTT'
            Title.Caption = 'Bairro'
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTCID'
            Title.Caption = 'UF'
            Width = 24
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMACTT'
            Title.Caption = 'E-Mail'
            Width = 255
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CMPCTT'
            Title.Caption = 'Ped.Compra'
            Visible = True
          end>
      end
    end
    object tbsPreFor: TTabSheet
      Tag = 4
      Caption = '&6 - Produtos / Pre'#231'os'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlItens: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 69
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label42: TLabel
          Left = 33
          Top = 15
          Width = 43
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object Label43: TLabel
          Left = 327
          Top = 38
          Width = 77
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Unit'#225'rio:'
        end
        object Label44: TLabel
          Left = 5
          Top = 38
          Width = 71
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Refer'#234'ncia:'
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 78
          Top = 11
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
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
          Left = 148
          Top = 11
          Width = 337
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
        object edtPreFor: TEditFocus
          Tag = 99
          Left = 406
          Top = 34
          Width = 79
          Height = 22
          Alignment = taRightJustify
          TabOrder = 3
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
        object edtRefere: TEditFocus
          Left = 78
          Top = 34
          Width = 244
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object btnAddIte: TBitBtnLocked
          Tag = 99
          Left = 498
          Top = 11
          Width = 85
          Height = 22
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
          TabOrder = 4
          OnClick = btnAddIteClick
        end
        object btnCanIte: TBitBtnLocked
          Tag = 99
          Left = 582
          Top = 11
          Width = 85
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
          TabOrder = 5
          OnClick = btnCanIteClick
        end
        object btnImpExcel: TBitBtnLocked
          Left = 498
          Top = 35
          Width = 143
          Height = 22
          Caption = 'Importar do Excel'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000020000
            00090000000E0000000F00000010000000100000001100000011000000110000
            001200000012000000110000000C000000030000000000000000000000087B50
            43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
            59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
            5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
            ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
            62FFFDFBFAFFF7EDE6FF53A46CFF058131FF048030FF047F30FF037E2FFF037D
            2EFF027C2EFF027B2DFF02792CFF01792CFF00782BFF00511DAD0000000BB079
            66FFFDFBFBFFF8EEE8FF068332FFFAF6F6FF058131FFF9F5F3FF047F2FFFF8F2
            F1FFF7F2EFFF7DB68EFFF7EFEDFFF6EEEBFF7BB48BFF01782BFF0000000AB37C
            69FFFEFCFBFFF8F0EAFF068433FFFBF7F6FF058231FFF9F5F4FF048030FFF8F4
            F2FF037E2FFF037D2FFF027C2EFF7DB68DFFF6EEEBFF01792CFF00000009B67F
            6CFFFEFDFCFFF9F0EBFF078533FF81BE95FFFBF7F6FF80BD94FF048131FFF9F5
            F2FF047F30FF037E2FFF7EB88FFFF6F1EEFF037B2DFF017A2DFF00000009B983
            71FFFEFDFCFFFAF3EEFF068634FFFCF8F8FF068433FFFBF7F6FF068231FFFAF5
            F3FF048030FF047F30FFF8F3F0FF037D2EFF027C2EFF027A2DFF00000008BC88
            77FFFEFEFDFFFBF4EFFF078634FFFBFAF9FF078533FFFAF8F7FF068333FFFAF7
            F5FF058131FF058030FF7EB991FFF8F2F0FFF7F2EFFF027C2DFF00000007BF8C
            7AFFFEFEFDFFFBF6F1FF55AA71FF078634FF078534FF068534FF068433FF0683
            32FF058332FF058131FF058030FF047F30FF037E2FFF025420AD00000006C18F
            7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
            EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
            82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
            F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
            85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
            F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
            89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
            FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
            67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
            87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
            0002000000030000000400000004000000050000000500000005000000060000
            0006000000060000000600000005000000010000000000000000}
          TabOrder = 6
          OnClick = btnImpExcelClick
        end
        object btnHlpImp: TBitBtnLocked
          Left = 643
          Top = 35
          Width = 24
          Height = 22
          Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
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
          TabOrder = 7
          OnClick = btnHlpImpClick
        end
      end
      object dbgItens: TDBGridCitel
        Left = 0
        Top = 69
        Width = 1000
        Height = 568
        Align = alClient
        DataSource = dtsForCta
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = FormKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CODITE'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESITE'
            Title.Caption = 'Descri'#231#227'o'
            Width = 302
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REFERE'
            Title.Caption = 'Referencia'
            Width = 159
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'VALITE'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Unit'#225'rio'
            Width = 108
            Visible = True
          end>
      end
    end
    object tbsCentCust: TTabSheet
      Tag = 5
      Caption = '&7 - Plano de Contas'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlForCta: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 32
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object btnIncCta: TBitBtnLocked
          Left = 561
          Top = 6
          Width = 41
          Height = 22
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
          TabOrder = 1
          OnClick = btnIncCtaClick
        end
        inline fraPlanoDeContasPl: TfraPlanoDeContasMskEdit
          Left = 20
          Top = 6
          Width = 542
          Height = 22
          TabOrder = 0
          ExplicitLeft = 20
          ExplicitTop = 6
          ExplicitWidth = 542
          inherited lblPlaContas: TLabel
            Left = 9
            Top = 3
            Width = 81
            Height = 14
            ExplicitLeft = 9
            ExplicitTop = 3
            ExplicitWidth = 81
            ExplicitHeight = 14
          end
          inherited edtDesCta: TEditFocus
            Left = 159
            Width = 380
            Height = 22
            ExplicitLeft = 159
            ExplicitWidth = 380
            ExplicitHeight = 22
          end
          inherited MskCodCta: TMaskEdit
            Left = 92
            Width = 62
            Height = 22
            OnKeyPress = fraPlanoDeContasPlMskCodCtaKeyPress
            ExplicitLeft = 92
            ExplicitWidth = 62
            ExplicitHeight = 22
          end
        end
      end
      object cxgCentCust: TcxGrid
        Left = 0
        Top = 32
        Width = 1000
        Height = 605
        Align = alClient
        TabOrder = 1
        object cxgForCtaView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsForCenCus
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.GroupByBox = False
          object cxgColCodCta: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CTF_CODCTA'
            PropertiesClassName = 'TcxMaskEditProperties'
            Properties.OnChange = cxgColCodCtaPropertiesChange
            Options.Editing = False
            Width = 46
          end
          object cxgColDesCta: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Plano de Contas'
            DataBinding.FieldName = 'CTA_DESCTA'
            Options.Editing = False
            Width = 372
          end
        end
        object cxgForCta: TcxGridLevel
          GridView = cxgForCtaView
        end
      end
    end
    object tbsRepresentante: TTabSheet
      Tag = 6
      Caption = '&8 - Representante'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFundoRepresentante: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object pnlNomRep: TPanel
          Left = 1
          Top = 1
          Width = 998
          Height = 37
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label8: TLabel
            Left = 13
            Top = 19
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Raz'#227'o Social:'
          end
          object dbeRepRazSoc: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 15
            Width = 588
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_RAZSOC'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlDadosRep: TPanel
          Left = 1
          Top = 38
          Width = 998
          Height = 467
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object LabelCgcCpf2: TLabelCgcCpf
            Left = 9
            Top = 99
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = '1-CNPJ/2-CPF:'
            Pais = opcBrasil
          end
          object Label11: TLabel
            Left = 500
            Top = 98
            Width = 47
            Height = 14
            Alignment = taRightJustify
            Caption = 'Insc. Est.:'
          end
          object Label22: TLabel
            Left = 35
            Top = 6
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Telefone:'
          end
          object Label31: TLabel
            Left = 217
            Top = 6
            Width = 23
            Height = 14
            Alignment = taRightJustify
            Caption = 'FAX:'
          end
          object Label33: TLabel
            Left = 510
            Top = 6
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Celular:'
          end
          object Label48: TLabel
            Left = 204
            Top = 29
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cidade:'
          end
          object Label51: TLabel
            Left = 599
            Top = 29
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Estado:'
          end
          object Label52: TLabel
            Left = 57
            Top = 29
            Width = 22
            Height = 14
            Alignment = taRightJustify
            Caption = 'CEP:'
          end
          object Label53: TLabel
            Left = 30
            Top = 52
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Endere'#231'o:'
          end
          object Label54: TLabel
            Left = 507
            Top = 52
            Width = 40
            Height = 14
            Alignment = taRightJustify
            Caption = 'N'#250'mero:'
          end
          object Label56: TLabel
            Left = 12
            Top = 75
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Complemento:'
          end
          object Label59: TLabel
            Left = 354
            Top = 75
            Width = 32
            Height = 14
            Alignment = taRightJustify
            Caption = 'Bairro:'
          end
          object Label55: TLabel
            Left = 48
            Top = 121
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'E-mail:'
          end
          object Label58: TLabel
            Left = 39
            Top = 144
            Width = 40
            Height = 14
            Alignment = taRightJustify
            Caption = 'Contato:'
          end
          object dbeRepCgcCpf: TDBEditTipoCgcCpf
            Tag = 99
            Left = 81
            Top = 94
            Width = 35
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_CGCCPF'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 10
            OnExit = dbeRepCgcCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepNumCGC: TDBEditCgcCpf
            Tag = 99
            Left = 117
            Top = 94
            Width = 226
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_C_G_C_'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 11
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
            Tipo = C_G_C_
          end
          object dbeRepNumIES: TDBEditFocus
            Tag = 99
            Left = 553
            Top = 99
            Width = 120
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_I_E_S_'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 12
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepFone01: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 102
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_FONE01'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 14
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepFax: TDBEditFocus
            Tag = 99
            Left = 242
            Top = 2
            Width = 101
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_F_A_X_'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 14
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepNumCel: TDBEditFocus
            Tag = 99
            Left = 549
            Top = 2
            Width = 120
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_NUMCEL'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 14
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepCodCid: TDBEditFocus
            Tag = 99
            Left = 242
            Top = 25
            Width = 50
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_CODCID'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 4
            OnKeyPress = dbeRepCodCidKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
            OnChamaCadastro = dbeCodCidChamaCadastro
          end
          object edtRepEst: TEditFocus
            Left = 637
            Top = 25
            Width = 32
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
          object dbeRepNumCep: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 25
            Width = 102
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_C_E_P_'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            OnKeyPress = dbeRepNumCepKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepEndere: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 48
            Width = 408
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_ENDERE'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepNum: TDBEditFocus
            Left = 549
            Top = 48
            Width = 120
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_ENDNUM'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepEndCom: TDBEditFocus
            Left = 81
            Top = 71
            Width = 262
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_ENDCOM'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepBairro: TDBEditFocus
            Left = 388
            Top = 71
            Width = 281
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_BAIRRO'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepEmail: TDBEditFocus
            Left = 81
            Top = 117
            Width = 408
            Height = 22
            CharCase = ecLowerCase
            DataField = 'REP_EMAIL_'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeRepContat: TDBEditFocus
            Left = 81
            Top = 140
            Width = 408
            Height = 22
            CharCase = ecUpperCase
            DataField = 'REP_CONTAT'
            DataSource = dtsRepFor
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 14
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtRepCidade: TEditFocus
            Left = 294
            Top = 25
            Width = 221
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 15
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
    end
    object tbsForConconEmp: TTabSheet
      Caption = '&9 - Conta cont'#225'bil / Empresa'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 68
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label62: TLabel
          Left = 66
          Top = 17
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label63: TLabel
          Left = 39
          Top = 40
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Cont'#225'bil:'
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 115
          Top = 13
          Width = 55
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
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
          Left = 171
          Top = 13
          Width = 316
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object edtConcon: TEditFocus
          Tag = 99
          Left = 115
          Top = 36
          Width = 372
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
      end
      object grdEmpFor: TDBGridCitel
        Left = 0
        Top = 68
        Width = 1000
        Height = 540
        Align = alClient
        DataSource = dtsEmpFor
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyPress = grdEmpForKeyPress
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CodEmp'
            Title.Caption = 'C'#243'd. Emp.'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomEmp'
            Title.Caption = 'Empresa'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Concon'
            Title.Caption = 'Conta Cont'#225'bil'
            Width = 115
            Visible = True
          end>
      end
      object pnlCampos: TPanel
        Left = 0
        Top = 608
        Width = 1000
        Height = 29
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object btnIncluirCC: TBitBtnLocked
          Left = 4
          Top = 4
          Width = 76
          Height = 20
          Caption = '&Incluir'
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
          OnClick = btnIncluirCCClick
        end
        object btnAlterarCC: TBitBtnLocked
          Left = 157
          Top = 4
          Width = 76
          Height = 20
          Caption = '&Alterar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
            CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
            A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
            820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
            860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
            C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
            D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
            9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnAlterarCCClick
        end
        object btnExcluirCC: TBitBtnLocked
          Left = 233
          Top = 4
          Width = 76
          Height = 20
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
          TabOrder = 3
          OnClick = btnExcluirCCClick
        end
        object btnCancelarCC: TBitBtnLocked
          Left = 309
          Top = 4
          Width = 76
          Height = 20
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
          TabOrder = 4
          OnClick = btnCancelarCCClick
        end
        object btnGravarCC: TBitBtnLocked
          Left = 81
          Top = 4
          Width = 76
          Height = 20
          Caption = '&Gravar'
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
          TabOrder = 1
          OnClick = btnGravarCCClick
        end
      end
    end
    object tbsNeoGrid: TTabSheet
      Caption = '10 - NeoGrid'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlNeoGrid: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object lbl15: TLabel
          Left = 9
          Top = 41
          Width = 210
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo da empresa no fornecedor NeoGrid:'
        end
        object lbl16: TLabel
          Left = 146
          Top = 64
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Layout:'
        end
        object lbl17: TLabel
          Left = 108
          Top = 110
          Width = 111
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sequ'#234'ncial do Arquivo:'
        end
        object lbl18: TLabel
          Left = 68
          Top = 132
          Width = 151
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data do Sequ'#234'ncial do Arquivo:'
        end
        object lbl19: TLabel
          Left = 74
          Top = 25
          Width = 153
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pasta para gera'#231#227'o do Arquivo:'
        end
        object lblINIARQ: TLabel
          Left = 105
          Top = 87
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome Inicial do Arquivo:'
        end
        object lblExpTigre: TLabel
          Left = 21
          Top = 153
          Width = 198
          Height = 28
          Caption = 
            'Envio de dados Tigre - XML Nota Fiscal Eletr'#244'nica - Exportar dad' +
            'os para a Tigre?'
          WordWrap = True
        end
        object lblExpTigreSN: TColorLabel
          Left = 271
          Top = 159
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeEanCli: TDBEditFocus
          Tag = 99
          Left = 223
          Top = 37
          Width = 248
          Height = 22
          CharCase = ecUpperCase
          DataField = 'NEO_EANCLI'
          DataSource = dtsNeoGri
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        inline fraPatArq: TfraDirectoryEditFocus
          Tag = 99
          Left = 222
          Top = 13
          Width = 446
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          TabOrder = 1
          ExplicitLeft = 222
          ExplicitTop = 13
          ExplicitWidth = 446
          ExplicitHeight = 24
          inherited edtDirectory: TEditFocus
            Width = 421
            Height = 22
            ExplicitWidth = 421
            ExplicitHeight = 22
          end
          inherited btnOpenDirectory: TcxButton
            Left = 423
            Height = 24
            ExplicitLeft = 423
            ExplicitHeight = 24
          end
        end
        object dbeSeqArq: TDBEditFocus
          Tag = 99
          Left = 223
          Top = 107
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'NEO_SEQARQ'
          DataSource = dtsNeoGri
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaArq: TDBEditFocus
          Tag = 99
          Left = 223
          Top = 130
          Width = 83
          Height = 22
          CharCase = ecUpperCase
          DataField = 'NEO_DTASEQ'
          DataSource = dtsNeoGri
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object cbxLayNeo: TComboBoxFocus
          Left = 223
          Top = 60
          Width = 248
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 4
          OnChange = cbxLayNeoChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object DBEINIARQ: TDBEditFocus
          Tag = 99
          Left = 223
          Top = 84
          Width = 250
          Height = 22
          CharCase = ecUpperCase
          DataField = 'NEO_INIARQ'
          DataSource = dtsNeoGri
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeExpTigre: TDBEditFocus
          Tag = 99
          Left = 223
          Top = 154
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_ENVTIG'
          DataSource = dtsTabela
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
    end
    object tbsRetencoes: TTabSheet
      Caption = '11 - Reten'#231#245'es Servi'#231'os Tomados'
      ImageIndex = 8
      object pnlImpParaServicos: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object grbDadosRetencoes: TGroupBox
          Left = 1
          Top = 1
          Width = 998
          Height = 163
          Align = alTop
          Caption = 'Dados para Reten'#231#245'es - Nota de Servi'#231'o'
          TabOrder = 0
          object lblTipo: TLabel
            Left = 51
            Top = 39
            Width = 40
            Height = 14
            Caption = 'Imposto:'
          end
          object lblAliq: TLabel
            Left = 246
            Top = 39
            Width = 42
            Height = 14
            Caption = 'Al'#237'quota:'
          end
          object lblForn: TLabel
            Left = 32
            Top = 64
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fornecedor:'
          end
          object lblPortador: TLabel
            Left = 47
            Top = 88
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Portador:'
          end
          object Label65: TLabel
            Left = 2
            Top = 16
            Width = 994
            Height = 14
            Align = alTop
            Caption = 
              '  (*) Os dados abaixo ser'#227'o utilizados para gerar lan'#231'amentos no' +
              ' Contas a Pagar, pelo Livro Fiscal, referentes as Notas Fiscais ' +
              'de Servi'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 670
          end
          object cmbTipImp: TComboBoxFocus
            Tag = 99
            Left = 91
            Top = 36
            Width = 145
            Height = 22
            TabOrder = 0
            OnSelect = cmbTipImpSelect
            Items.Strings = (
              'Reten'#231#227'o de PIS'
              'Reten'#231#227'o de COFINS'
              'Reten'#231#227'o de CSLL'
              'Reten'#231#227'o de IRRF'
              'Reten'#231#227'o de INSS'
              'Reten'#231#227'o de ISS'
              'Reten'#231#227'o de INSS Patronal')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtAliq: TEditFocus
            Tag = 99
            Left = 290
            Top = 36
            Width = 43
            Height = 22
            Alignment = taRightJustify
            TabOrder = 1
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
          object edtDesFor: TEditFocus
            Left = 146
            Top = 60
            Width = 400
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
          object edtCodFor: TEditFocus
            Tag = 99
            Left = 91
            Top = 60
            Width = 55
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 8
            TabOrder = 2
            OnKeyPress = edtCodForKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object rdgVencimento: TRadioGroup
            Tag = 99
            Left = 556
            Top = 53
            Width = 119
            Height = 75
            Caption = 'Tipo Vencimento'
            ItemIndex = 1
            Items.Strings = (
              'Dia Fixo'
              #218'ltimo Dia do M'#234's')
            TabOrder = 9
            OnClick = rdgVencimentoClick
            OnExit = rdgVencimentoExit
          end
          object edtVencimento: TEditFocus
            Tag = 99
            Left = 619
            Top = 71
            Width = 20
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 2
            TabOrder = 8
            OnExit = edtVencimentoExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 2
            TipoTexto = ttInteiro
          end
          inline fraCentroCusto: TfraCentroCustoEditFocus
            Left = 4
            Top = 129
            Width = 542
            Height = 22
            TabOrder = 7
            ExplicitLeft = 4
            ExplicitTop = 129
            ExplicitWidth = 542
            inherited lblEventos: TLabel
              Left = 0
              Width = 87
              Height = 14
              ExplicitLeft = 0
              ExplicitWidth = 87
              ExplicitHeight = 14
            end
            inherited edtCodEve: TEditFocus
              Left = 87
              Height = 22
              ExplicitLeft = 87
              ExplicitHeight = 22
            end
            inherited edtDesEve: TEditFocus
              Left = 142
              Height = 22
              ExplicitLeft = 142
              ExplicitHeight = 22
            end
          end
          inline fraPlanoDeContasImp: TfraPlanoDeContasMskEdit
            Left = 7
            Top = 106
            Width = 540
            Height = 22
            TabOrder = 6
            ExplicitLeft = 7
            ExplicitTop = 106
            ExplicitWidth = 540
            inherited lblPlaContas: TLabel
              Left = 4
              Width = 81
              Height = 14
              ExplicitLeft = 4
              ExplicitWidth = 81
              ExplicitHeight = 14
            end
            inherited edtDesCta: TEditFocus
              Left = 139
              Height = 22
              ExplicitLeft = 139
              ExplicitHeight = 22
            end
            inherited MskCodCta: TMaskEdit
              Left = 84
              Width = 55
              Height = 22
              ExplicitLeft = 84
              ExplicitWidth = 55
              ExplicitHeight = 22
            end
          end
          object edtCodPorRet: TEditFocus
            Tag = 99
            Left = 91
            Top = 83
            Width = 55
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtCodPorRetKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtNomPorRet: TEditFocus
            Left = 146
            Top = 83
            Width = 400
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
        end
        object grdImpostos: TcxGridCitel
          Left = 1
          Top = 191
          Width = 998
          Height = 249
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdImpostosTableView1: TcxGridDBTableViewCitel
            OnDblClick = grdImpostosTableView1DblClick
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = grdImpostosTableView1EditKeyDown
            DataController.DataSource = dtsForRet
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = False
            CorZebra = clMoneyGreen
            object grdImpostosDESTIP: TcxGridDBColumn
              DataBinding.FieldName = 'DESTIP'
            end
            object grdImpostosRET_ALIQUO: TcxGridDBColumn
              DataBinding.FieldName = 'RET_ALIQUO'
              OnGetDataText = grdImpostosRET_ALIQUOGetDataText
            end
            object grdImpostosDESFOR: TcxGridDBColumn
              DataBinding.FieldName = 'DESFOR'
              Width = 200
            end
            object grdImpostosNOMPOR: TcxGridDBColumn
              DataBinding.FieldName = 'NOMPOR'
            end
            object grdImpostosDESCTA: TcxGridDBColumn
              DataBinding.FieldName = 'DESCTA'
            end
            object grdImpostosDESEVE: TcxGridDBColumn
              DataBinding.FieldName = 'DESEVE'
            end
            object grdImpostosDESVEN: TcxGridDBColumn
              Caption = 'Tipo de Vencimento'
              DataBinding.FieldName = 'DESVEN'
              Width = 105
            end
            object grdImpostosRET_DIAVEN: TcxGridDBColumn
              DataBinding.FieldName = 'RET_DIAVEN'
            end
            object grdImpostosRET_TIPRET: TcxGridDBColumn
              DataBinding.FieldName = 'RET_TIPRET'
              Visible = False
              VisibleForCustomization = False
              VisibleForEditForm = bFalse
            end
          end
          object grdImpostosLevel1: TcxGridLevel
            GridView = grdImpostosTableView1
          end
        end
        object pnlBotoesImp: TPanel
          Left = 1
          Top = 164
          Width = 998
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          Color = clGray
          ParentBackground = False
          TabOrder = 2
          object btnIncluirImp: TBitBtnLocked
            Left = 4
            Top = 2
            Width = 76
            Height = 24
            Caption = '&Incluir'
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
            OnClick = btnIncluirImpClick
          end
          object btnAlterarImp: TBitBtnLocked
            Left = 157
            Top = 2
            Width = 76
            Height = 24
            Caption = '&Alterar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
              69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
              CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
              A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
              7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
              820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
              A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
              81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
              860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
              A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
              93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
              C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
              BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
              A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
              D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
              D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
              B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
              9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
              DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
              55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
              E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
              6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
              926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 2
            OnClick = btnAlterarImpClick
          end
          object btnExcluirImp: TBitBtnLocked
            Left = 234
            Top = 2
            Width = 76
            Height = 24
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
            TabOrder = 3
            OnClick = btnExcluirImpClick
          end
          object btnCancelarImp: TBitBtnLocked
            Left = 311
            Top = 2
            Width = 76
            Height = 24
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
            TabOrder = 4
            OnClick = btnCancelarImpClick
          end
          object btnGravarImp: TBitBtnLocked
            Left = 81
            Top = 2
            Width = 76
            Height = 24
            Caption = '&Gravar'
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
            TabOrder = 1
            OnClick = btnGravarImpClick
          end
        end
        object pnlFunrural: TPanel
          Left = 1
          Top = 440
          Width = 998
          Height = 119
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 3
          object grbFunrural: TGroupBox
            Left = 0
            Top = 0
            Width = 998
            Height = 119
            Align = alClient
            Caption = ' '
            Color = 16770261
            ParentBackground = False
            ParentColor = False
            TabOrder = 1
            object Label50x: TLabel
              Left = 32
              Top = 50
              Width = 59
              Height = 14
              Alignment = taRightJustify
              Caption = 'Fornecedor:'
            end
            object Label85: TLabel
              Left = 49
              Top = 27
              Width = 42
              Height = 14
              Alignment = taRightJustify
              Caption = 'Al'#237'quota:'
            end
            object lblEventos: TLabel
              Left = 4
              Top = 95
              Width = 87
              Height = 14
              Alignment = taRightJustify
              Caption = 'Centro de Custos:'
            end
            inline fraPlanoDeContasFunrural: TfraPlanoDeContasDBEditFocus
              Left = 2
              Top = 69
              Width = 558
              Height = 22
              TabOrder = 3
              ExplicitLeft = 2
              ExplicitTop = 69
              ExplicitWidth = 558
              inherited lblPlaContas: TLabel
                Left = 8
                Top = 3
                Width = 84
                Height = 14
                ExplicitLeft = 8
                ExplicitTop = 3
                ExplicitWidth = 84
                ExplicitHeight = 14
              end
              inherited dbeCodCta: TDBEditFocus
                Left = 89
                Height = 22
                DataField = 'FOR_RFRCTA'
                DataSource = dtsTabela
                ExplicitLeft = 89
                ExplicitHeight = 22
              end
              inherited edtDesCta: TEditFocus
                Left = 145
                Height = 22
                ExplicitLeft = 145
                ExplicitHeight = 22
              end
            end
            object dbeFunruralFornecedor: TDBEditFocus
              Tag = 99
              Left = 91
              Top = 46
              Width = 55
              Height = 22
              CharCase = ecUpperCase
              DataField = 'FOR_RFRFOR'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 1
              OnKeyPress = dbeFunruralFornecedorKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttNumerico
            end
            object edtFunruralNomFor: TEditFocus
              Left = 147
              Top = 46
              Width = 400
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object dbeFunruralAliquota: TDBEditFocus
              Tag = 99
              Left = 91
              Top = 22
              Width = 44
              Height = 22
              CharCase = ecUpperCase
              DataField = 'FOR_RFRALI'
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
            object rdgFunruralVenc: TDBRadioGroup
              Tag = 99
              Left = 548
              Top = 38
              Width = 119
              Height = 75
              Caption = 'Dia Vencimento'
              DataField = 'FOR_RFRTVE'
              DataSource = dtsTabela
              Items.Strings = (
                'Dia Fixo'
                #218'ltimo Dia do M'#234's')
              TabOrder = 6
              Values.Strings = (
                '0'
                '1')
            end
            object dbeFunruralDiaVenc: TDBEditFocus
              Tag = 99
              Left = 618
              Top = 57
              Width = 21
              Height = 22
              DataField = 'FOR_RFRDVE'
              DataSource = dtsTabela
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeCodEve: TDBEditFocus
              Tag = 99
              Left = 91
              Top = 92
              Width = 55
              Height = 22
              CharCase = ecUpperCase
              DataField = 'FOR_RFREVE'
              DataSource = dtsTabela
              MaxLength = 20
              TabOrder = 4
              OnKeyPress = dbeCodEveKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object edtDesEve: TEditFocus
              Left = 147
              Top = 92
              Width = 400
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
          object chkUsaFunrural: TDBCheckBox
            Left = 10
            Top = 0
            Width = 419
            Height = 17
            Caption = 
              'Utilizar Reten'#231#227'o Funrural - Dados para Renten'#231#245'es - Emiss'#227'o de ' +
              'Nota de Entrada'
            DataField = 'FOR_USARFR'
            DataSource = dtsTabela
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkUsaFunruralClick
          end
        end
        object gbpREINF: TGroupBox
          Left = 1
          Top = 559
          Width = 998
          Height = 77
          Align = alBottom
          Caption = 'REINF'
          TabOrder = 4
          object lblNatRend: TLabel
            Left = 12
            Top = 25
            Width = 121
            Height = 14
            Alignment = taRightJustify
            Caption = 'Natureza do Rendimento:'
          end
          object lblTipServ: TLabel
            Left = 55
            Top = 49
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Servi'#231'o:'
          end
          object edtNatRend: TEditFocus
            Left = 199
            Top = 22
            Width = 683
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
          object edtTipoServico: TEditFocus
            Left = 199
            Top = 46
            Width = 683
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
          object dbeCodNatRend: TDBEditFocus
            Tag = 99
            Left = 134
            Top = 22
            Width = 65
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FOR_TB01RE'
            DataSource = dtsTabela
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = dbeCodNatRendKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCodTipServ: TDBEditFocus
            Tag = 99
            Left = 134
            Top = 46
            Width = 65
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FOR_TB06RE'
            DataSource = dtsTabela
            MaxLength = 9
            TabOrder = 2
            OnKeyPress = dbeCodTipServKeyPress
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
    object tbsBosch: TTabSheet
      Caption = '12 - BOSH'
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlBOSH: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object Label67: TLabel
          Left = 145
          Top = 39
          Width = 73
          Height = 14
          Caption = 'Tipo de Pedido:'
        end
        object Label66: TLabel
          Left = 67
          Top = 12
          Width = 153
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pasta para gera'#231#227'o do Arquivo:'
        end
        object Label69: TLabel
          Left = 142
          Top = 87
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Entrega:'
        end
        object Label68: TLabel
          Left = 127
          Top = 62
          Width = 93
          Height = 14
          Caption = 'Divis'#227'o de Vendas:'
        end
        object edtDivVen: TComboBoxFocus
          Left = 224
          Top = 59
          Width = 203
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          OnChange = edtDivVenChange
          Items.Strings = (
            '01 - Auto Pe'#231'as'
            '02 - Ferramentas el'#233'tricas'
            '03 - aparelhos de Teste'
            '04 - Hidr'#225'ulica M'#243'bil'
            '42 - Blaupunkt'
            '66 - Termot'#233'cnica')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtTipPed: TComboBoxFocus
          Left = 224
          Top = 34
          Width = 203
          Height = 22
          Style = csDropDownList
          TabOrder = 1
          OnChange = edtTipPedChange
          Items.Strings = (
            '01 - Indent'
            '02 - Estoque'
            '03 - Venda Comissionada'
            '04 - FUN (PT)'
            '05 - Indent - Pol.Desconto'
            '06 - Estoque - Pol.Desconto')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnTabelaCondpagBosch: TBitBtnLocked
          Left = 224
          Top = 112
          Width = 237
          Height = 23
          Caption = '&Tabela Condi'#231#227'o de Pagamento Bosch'
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
          OnClick = btnTabelaCondpagBoschClick
        end
        object edtTipEnt: TEditFocus
          Left = 224
          Top = 84
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          OnChange = edtTipEntChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        inline fraDirBosh: TfraDirectoryEditFocus
          Tag = 99
          Left = 223
          Top = 9
          Width = 446
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          TabOrder = 4
          ExplicitLeft = 223
          ExplicitTop = 9
          ExplicitWidth = 446
          ExplicitHeight = 24
          inherited edtDirectory: TEditFocus
            Width = 421
            Height = 22
            ExplicitWidth = 421
            ExplicitHeight = 22
          end
          inherited btnOpenDirectory: TcxButton
            Left = 423
            Height = 24
            ExplicitLeft = 423
            ExplicitHeight = 24
          end
        end
      end
    end
    object tbsGruCom: TTabSheet
      Caption = '13 - G&rupos de Produtos para Cota'#231#227'o de Compra'
      ImageIndex = 11
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlGruCom1: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        Enabled = False
        ParentColor = True
        TabOrder = 0
        object Label71: TLabel
          Left = 8
          Top = 25
          Width = 94
          Height = 14
          Caption = 'Grupo de Produtos:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object btnIncGru: TBitBtnLocked
          Left = 498
          Top = 17
          Width = 121
          Height = 22
          Caption = 'Incluir Grupo'
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
          OnClick = btnIncGruClick
        end
        object mskCodGru: TMaskEditFocus
          Tag = 99
          Left = 105
          Top = 17
          Width = 51
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
          OnExit = mskCodGruExit
          OnKeyPress = mskCodGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGru: TEditFocus
          Left = 156
          Top = 17
          Width = 325
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
      end
      object pnlGruCom2: TPanel
        Left = 0
        Top = 596
        Width = 1000
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        Enabled = False
        ParentBackground = False
        TabOrder = 1
        object btnDelGru: TBitBtnLocked
          Left = 9
          Top = 12
          Width = 160
          Height = 22
          Caption = '[ ALT + L ] Excluir Grupo'
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
          TabOrder = 0
        end
      end
      object cxgGrupos: TcxGrid
        Left = 0
        Top = 49
        Width = 1000
        Height = 547
        Align = alClient
        TabOrder = 2
        object cxvGrupos: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum grupo incluido>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxvGruposCODGRU: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'GRF_CODGRU'
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
            Width = 95
          end
          object cxvGruposDESGRU: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Grupo'
            DataBinding.FieldName = 'GRU_DESGRU'
            Width = 582
          end
        end
        object cxgGruposLevel1: TcxGridLevel
          GridView = cxvGrupos
        end
      end
    end
    object tbsPraEnt: TTabSheet
      Caption = '14 - Prazo de Entrega'
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlComprador: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 45
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label97: TLabel
          Left = 18
          Top = 16
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
        object dbeCompra: TDBEditFocus
          Tag = 99
          Left = 77
          Top = 11
          Width = 36
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_COMPRA'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnKeyPress = dbeCompraKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtDesCompra: TEditFocus
          Left = 114
          Top = 11
          Width = 310
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
      end
      object cxgEmpresas: TcxGrid
        Left = 0
        Top = 45
        Width = 1000
        Height = 592
        Align = alClient
        TabOrder = 1
        object cxvEmpresas: TcxGridDBTableView
          OnMouseMove = cxvEmpresasMouseMove
          Navigator.Buttons.CustomButtons = <>
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object cxvEmpresasColumn1: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'PRA_CODEMP'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 69
          end
          object cxvEmpresasColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da Empresa'
            DataBinding.FieldName = 'PRA_NOMEMP'
            Options.Editing = False
            Width = 326
          end
          object cxvEmpresasPRAENT: TcxGridDBColumn
            Caption = 'Prazo de Entrega (Dias)'
            DataBinding.FieldName = 'PRA_DIAENT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ' ,0;-0'
            Properties.OnValidate = cxvEmpresasPRAENTPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 130
          end
          object cxvEmpresasVALMIN: TcxGridDBColumn
            Caption = 'Valor M'#237'nimo do Pedido Compra'
            DataBinding.FieldName = 'PRA_VALMIN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.OnValidate = cxvEmpresasVALMINPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 166
          end
          object cxvEmpresasDIACOM: TcxGridDBColumn
            Caption = 'Dias Para Compra'
            DataBinding.FieldName = 'PRA_DIACOM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ' ,0;-0'
            Properties.OnValidate = cxvEmpresasDIACOMPropertiesValidate
            Width = 109
          end
          object cxvEmpresasColumn3: TcxGridDBColumn
            Caption = 'Quantidade M'#237'nima do Pedido Compra(UN)'
            DataBinding.FieldName = 'PRA_MINQTD'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.0000;-,0.0000'
            Width = 209
          end
          object cxvEmpresasColumn4: TcxGridDBColumn
            Caption = 'Peso M'#237'nimo do Pedido Compra(KG)'
            DataBinding.FieldName = 'PRA_MINPES'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.0000;-,0.0000'
            Width = 180
          end
          object cxvEmpresasColumn5: TcxGridDBColumn
            Caption = 'Litragem M'#237'nima do Pedido Compra(LT)'
            DataBinding.FieldName = 'PRA_MINLIT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.0000;-,0.0000'
            Width = 199
          end
          object cxvEmpresasColumn6: TcxGridDBColumn
            Caption = 'Metragem M'#237'nima do Pedido Compra(MT)'
            DataBinding.FieldName = 'PRA_MINMET'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.0000;-,0.0000'
            Width = 208
          end
        end
        object cxgEmpresasLevel1: TcxGridLevel
          GridView = cxvEmpresas
        end
      end
    end
    object tsbAutonomas: TTabSheet
      Caption = '15 - Filiais Aut'#244'nomas'
      ImageIndex = 12
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxgSatelites: TcxGrid
        Left = 0
        Top = 33
        Width = 1000
        Height = 574
        Align = alClient
        TabOrder = 0
        object cxvSatelites: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhuma filial sat'#233'lite definida>'
          OptionsView.GroupByBox = False
          object cxvSatelitesCODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'AUT_CODEMP'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 67
          end
          object cxvSatelitesNOMEMP: TcxGridDBColumn
            Caption = 'Nome da Empresa'
            DataBinding.FieldName = 'NOMEMP'
            Options.Editing = False
            Width = 352
          end
          object cxvSatelitesTIPEMP: TcxGridDBColumn
            Caption = 'Tipo Atual'
            DataBinding.FieldName = 'TIPEMP'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 103
          end
          object cxvSatelitesAUTONO: TcxGridDBColumn
            Caption = 'Aut'#244'noma para esse fornecedor'
            DataBinding.FieldName = 'AUTONO'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 185
          end
        end
        object cxgSatelitesLevel1: TcxGridLevel
          GridView = cxvSatelites
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        Caption = 
          'Marque as filiais sat'#233'lites que s'#227'o aut'#244'nomas para esse forneced' +
          'or'
        ParentColor = True
        TabOrder = 2
      end
      object Panel4: TPanel
        Left = 0
        Top = 607
        Width = 1000
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object btnMarcaTodasAutonoma: TBitBtnLocked
          Left = 325
          Top = 6
          Width = 202
          Height = 22
          Caption = 'Marca todas como Aut'#244'noma'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnMarcaTodasAutonomaClick
        end
        object btnDesmarcaTodasAutonoma: TBitBtnLocked
          Left = 529
          Top = 6
          Width = 208
          Height = 22
          Caption = 'Desmarca todas como Aut'#244'noma'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF3333993333339993333377FF3333377FF3399993333339
            993337777FF3333377F3393999333333993337F777FF333337FF993399933333
            399377F3777FF333377F993339993333399377F33777FF33377F993333999333
            399377F333777FF3377F993333399933399377F3333777FF377F993333339993
            399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
            99333773FF3333777733339993333339933333773FFFFFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnDesmarcaTodasAutonomaClick
        end
      end
    end
    object tbsValorPedido: TTabSheet
      Caption = '16 - Limite de Pedidos de Compra'
      ImageIndex = 13
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel5: TPanel
        Left = 0
        Top = 597
        Width = 1000
        Height = 40
        Align = alBottom
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        object btnExcluiLimMes: TBitBtnLocked
          Left = 387
          Top = 10
          Width = 121
          Height = 22
          Caption = 'Excluir M'#234's'
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
          TabOrder = 0
          OnClick = btnExcluiLimMesClick
        end
        object btnImpArq: TBitBtnLocked
          Left = 11
          Top = 10
          Width = 134
          Height = 22
          Caption = 'Importar Arquivo CSV'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
            FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
            00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
            F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
            00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
            F033777777777337F73309999990FFF0033377777777FFF77333099999000000
            3333777777777777333333399033333333333337773333333333333903333333
            3333333773333333333333303333333333333337333333333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnImpArqClick
        end
        object btnHelpLimPedCom: TBitBtnLocked
          Left = 145
          Top = 10
          Width = 24
          Height = 22
          Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
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
          TabOrder = 2
          OnClick = btnHelpLimPedComClick
        end
      end
      object pnlInclusao: TPanel
        Left = 0
        Top = 543
        Width = 1000
        Height = 54
        Align = alBottom
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 1
        object Label72: TLabel
          Left = 148
          Top = 23
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor mensal:'
        end
        object Label77: TLabel
          Left = 22
          Top = 22
          Width = 51
          Height = 14
          Caption = 'M'#234's / Ano:'
        end
        object mskMesAno: TMaskEditFocus
          Tag = 99
          Left = 74
          Top = 18
          Width = 55
          Height = 22
          EditMask = '99/9999'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 0
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtValMes: TEditFocus
          Tag = 99
          Left = 215
          Top = 18
          Width = 86
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnIncLimPed: TBitBtnLocked
          Left = 310
          Top = 18
          Width = 75
          Height = 22
          Caption = '&Incluir'
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
          OnClick = btnIncLimPedClick
        end
      end
      object cxgLimitePedidos: TcxGrid
        Left = 0
        Top = 0
        Width = 1000
        Height = 543
        Align = alClient
        TabOrder = 2
        object cxvLimitePedidos: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = cxvLimitePedidosVALLIM
            end>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum valor informado>'
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxvLimitePedidosCODFOR: TcxGridDBColumn
            Caption = 'C'#243'd.Fornecedor'
            DataBinding.FieldName = 'LIM_CODFOR'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 94
          end
          object cxvLimitePedidosNOMFOR: TcxGridDBColumn
            Caption = 'Nome do Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Visible = False
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 326
          end
          object cxvLimitePedidosANOMES: TcxGridDBColumn
            Caption = 'Ano '
            DataBinding.FieldName = 'LIM_NROANO'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 1
            SortOrder = soDescending
            Width = 73
          end
          object cxvLimitePedidosColumn1: TcxGridDBColumn
            Caption = 'M'#234's'
            DataBinding.FieldName = 'LIM_NROMES'
            OnGetDisplayText = cxvLimitePedidosColumn1GetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 2
            SortOrder = soDescending
          end
          object cxvLimitePedidosVALLIM: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'LIM_VALPED'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.OnValidate = cxvLimitePedidosVALLIMPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 113
          end
        end
        object cxgLimitePedidosLevel1: TcxGridLevel
          GridView = cxvLimitePedidos
        end
      end
    end
    object tbsGestaoControle: TTabSheet
      Caption = '17 - Gest'#227'o controle de qualidade'
      ImageIndex = 16
      OnEnter = tbsGestaoControleEnter
      object pnlDadosCertificado: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 50
        Width = 994
        Height = 584
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        Visible = False
        object imgCertificado: TImage
          AlignWithMargins = True
          Left = 4
          Top = 84
          Width = 986
          Height = 496
          Align = alClient
          ExplicitWidth = 1012
          ExplicitHeight = 456
        end
        object dxPDFViewer: TdxPDFViewer
          AlignWithMargins = True
          Left = 4
          Top = 84
          Width = 986
          Height = 496
          Align = alClient
          Visible = False
        end
        object pnlCabecalho: TPanel
          Left = 1
          Top = 1
          Width = 992
          Height = 80
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label87: TLabel
            Left = 3
            Top = 14
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Certificado:'
          end
          object lblValCertificado: TLabel
            Left = 14
            Top = 46
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Validade:'
          end
          object lblCertVencido: TLabel
            Left = 238
            Top = 48
            Width = 93
            Height = 14
            Caption = 'Certificado vencido'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object dbeValidade: TDBEditFocus
            Tag = 99
            Left = 78
            Top = 43
            Width = 154
            Height = 22
            CharCase = ecUpperCase
            DataField = 'FOR_CERVAL'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnOpcoesCert: TcxButton
            Left = 78
            Top = 10
            Width = 75
            Height = 25
            Caption = 'Op'#231#245'es...'
            PopupMenu = popMenuCert
            TabOrder = 1
            OnClick = btnOpcoesCertClick
          end
        end
      end
      object pnlCabecalhoCert: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 994
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object lblObgGestao: TLabel
          Left = 42
          Top = 23
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Obrigat'#243'rio?'
        end
        object ColorLabel10: TColorLabel
          Left = 151
          Top = 23
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
        object dbeObgCtrlGestao: TDBEditFocus
          Tag = 99
          Left = 103
          Top = 19
          Width = 44
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FOR_OBGCTR'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 823
    Top = 218
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 952
    Top = 74
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 987
    Top = 486
  end
  object cdsForCtt: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 953
    Top = 370
    object cdsForCttNOMCTT: TStringField
      FieldName = 'NOMCTT'
      Size = 50
    end
    object cdsForCttENDCTT: TStringField
      FieldName = 'ENDCTT'
      Size = 50
    end
    object cdsForCttBAICTT: TStringField
      FieldName = 'BAICTT'
      Size = 30
    end
    object cdsForCttNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 40
    end
    object cdsForCttESTCID: TStringField
      FieldName = 'ESTCID'
      Size = 2
    end
    object cdsForCttTELCTT: TStringField
      FieldName = 'TELCTT'
      Size = 16
    end
    object cdsForCttEMACTT: TStringField
      FieldName = 'EMACTT'
      Size = 80
    end
    object cdsForCttCODCID: TStringField
      FieldName = 'CODCID'
      Size = 5
    end
    object cdsForCttCELCTT: TStringField
      FieldName = 'CELCTT'
      Size = 16
    end
    object cdsForCttFAXCTT: TStringField
      FieldName = 'FAXCTT'
      Size = 16
    end
    object cdsForCttDEPCTT: TStringField
      FieldName = 'DEPCTT'
      Size = 25
    end
    object cdsForCttCMPCTT: TStringField
      FieldName = 'CMPCTT'
    end
  end
  object dtsForCtt: TDataSource
    DataSet = cdsForCtt
    Left = 814
    Top = 386
  end
  object dtsTabela: TDataSource
    OnStateChange = dtsTabelaStateChange
    OnDataChange = dtsTabelaDataChange
    Left = 813
    Top = 482
  end
  object dtsForCta: TDataSource
    Left = 895
    Top = 370
  end
  object dtsForCenCus: TDataSource
    DataSet = cdsForCta
    Left = 851
    Top = 386
  end
  object cdsForCta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspForCta'
    BeforeDelete = cdsForCtaBeforeDelete
    AfterDelete = cdsForCtaAfterDelete
    Left = 905
    Top = 450
    object cdsForCtaCTF_CODCTA: TStringField
      FieldName = 'CTF_CODCTA'
      Size = 7
    end
    object cdsForCtaCTF_CODEMP: TStringField
      FieldName = 'CTF_CODEMP'
      Size = 3
    end
    object cdsForCtaCTA_DESCTA: TStringField
      FieldName = 'CTA_DESCTA'
      Size = 30
    end
    object cdsForCtaCTF_CODFOR: TStringField
      FieldName = 'CTF_CODFOR'
      Size = 50
    end
  end
  object qryForCta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 965
    Top = 322
  end
  object dspForCta: TUniDataSetProvider
    DataSet = qryForCta
    Options = []
    Left = 852
    Top = 528
  end
  object dtsRepFor: TDataSource
    Left = 822
    Top = 122
  end
  object dtsEmpFor: TDataSource
    DataSet = cdsEmpFor
    Left = 862
    Top = 173
  end
  object cdsEmpFor: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 821
    Top = 173
    object cdsEmpForCodEmp: TStringField
      FieldName = 'CodEmp'
    end
    object cdsEmpForNomEmp: TStringField
      FieldName = 'NomEmp'
    end
    object cdsEmpForConcon: TStringField
      FieldName = 'Concon'
    end
    object cdsEmpForCodigo: TStringField
      FieldName = 'Codigo'
    end
    object cdsEmpForAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object dtsNeoGri: TDataSource
    Left = 862
    Top = 122
  end
  object dtsForRet: TDataSource
    DataSet = cdsForRet
    Left = 811
    Top = 434
  end
  object cdsForRet: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspForRet'
    Left = 852
    Top = 434
    object cdsForRetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsForRetRET_ALIQUO: TFloatField
      DisplayLabel = '% Al'#237'quota'
      FieldName = 'RET_ALIQUO'
      EditFormat = '#,####0.0000'
    end
    object cdsForRetDESTIP: TStringField
      DisplayLabel = 'Tipo Imposto'
      FieldName = 'DESTIP'
    end
    object cdsForRetRET_DIAVEN: TIntegerField
      DisplayLabel = 'Dia Vencimto'
      FieldName = 'RET_DIAVEN'
    end
    object cdsForRetDESVEN: TStringField
      DisplayLabel = 'Tipo Vencimto'
      FieldName = 'DESVEN'
    end
    object cdsForRetDESEVE: TStringField
      DisplayLabel = 'Centro de Custo'
      FieldName = 'DESEVE'
    end
    object cdsForRetDESCTA: TStringField
      DisplayLabel = 'Plano de Contas'
      FieldName = 'DESCTA'
    end
    object cdsForRetNOMPOR: TStringField
      DisplayLabel = 'Portador'
      FieldName = 'NOMPOR'
    end
    object cdsForRetDESFOR: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'DESFOR'
      Size = 200
    end
    object cdsForRetRET_TIPRET: TStringField
      FieldName = 'RET_TIPRET'
      Visible = False
      Size = 1
    end
    object cdsForRetRET_CODFOR: TStringField
      FieldName = 'RET_CODFOR'
      Visible = False
      Size = 8
    end
    object cdsForRetRET_CODEVE: TStringField
      FieldName = 'RET_CODEVE'
      Visible = False
    end
    object cdsForRetRET_CODCTA: TStringField
      FieldName = 'RET_CODCTA'
      Visible = False
      Size = 7
    end
    object cdsForRetRET_TIPVEN: TStringField
      FieldName = 'RET_TIPVEN'
      Visible = False
      Size = 1
    end
    object cdsForRetRET_FORRET: TStringField
      FieldName = 'RET_FORRET'
      Visible = False
      Size = 8
    end
    object cdsForRetFOR_NOMFOR: TStringField
      FieldName = 'FOR_NOMFOR'
      Visible = False
    end
    object cdsForRetCTA_DESCTA: TStringField
      FieldName = 'CTA_DESCTA'
      Visible = False
    end
    object cdsForRetEVE_DESEVE: TStringField
      FieldName = 'EVE_DESEVE'
      Visible = False
    end
    object cdsForRetPOR_NOMPOR: TStringField
      FieldName = 'POR_NOMPOR'
    end
    object cdsForRetRET_CODPOR: TStringField
      FieldName = 'RET_CODPOR'
    end
  end
  object dspForRet: TUniDataSetProvider
    DataSet = qryForRet
    Options = []
    Left = 856
    Top = 482
  end
  object qryForRet: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 820
    Top = 528
  end
  object dtsCndPagBosh: TDataSource
    Left = 952
    Top = 412
  end
  object dtsBcoFor: TDataSource
    AutoEdit = False
    DataSet = cdsBcoFor
    OnStateChange = dtsBcoForStateChange
    Left = 851
    Top = 82
  end
  object cdsBcoFor: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsBcoForAfterScroll
    OnCalcFields = cdsBcoForCalcFields
    Left = 817
    Top = 86
    object cdsBcoForAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsBcoForBCF_CODFOR: TStringField
      FieldName = 'BCF_CODFOR'
      Size = 8
    end
    object cdsBcoForBCF_CODBCO: TStringField
      FieldName = 'BCF_CODBCO'
      Size = 3
    end
    object cdsBcoForBANCO: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'BANCO'
      ProviderFlags = []
      OnGetText = cdsBcoForBANCOGetText
      Size = 100
    end
    object cdsBcoForBCF_NUMAGE: TStringField
      FieldName = 'BCF_NUMAGE'
      Size = 5
    end
    object cdsBcoForBCF_DIGAGE: TStringField
      FieldName = 'BCF_DIGAGE'
      Size = 1
    end
    object cdsBcoForAGENCIA: TStringField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'AGENCIA'
      OnGetText = cdsBcoForAGENCIAGetText
      Size = 7
    end
    object cdsBcoForBCF_NUMCTA: TStringField
      FieldName = 'BCF_NUMCTA'
      Size = 12
    end
    object cdsBcoForBCF_DIGCTA: TStringField
      FieldName = 'BCF_DIGCTA'
      Size = 1
    end
    object cdsBcoForCONTA: TStringField
      DisplayLabel = 'Conta'
      FieldName = 'CONTA'
      OnGetText = cdsBcoForCONTAGetText
      Size = 14
    end
    object cdsBcoForBCF_DIGVER: TStringField
      DisplayLabel = 'D'#237'gito Verificador'
      FieldName = 'BCF_DIGVER'
      Size = 1
    end
    object cdsBcoForBCF_CAMCEN: TStringField
      DisplayLabel = 'C'#226'm. Centralizadora'
      FieldName = 'BCF_CAMCEN'
      Size = 3
    end
    object cdsBcoForBCF_COMPDES: TStringField
      DisplayLabel = 'C'#243'd. Comp. Destino'
      FieldName = 'BCF_COMPDES'
      Size = 2
    end
    object cdsBcoForBCO_NOMBCO: TStringField
      FieldName = 'BCO_NOMBCO'
      ProviderFlags = []
      Size = 100
    end
    object cdsBcoForBCF_NOMTIT: TStringField
      FieldName = 'BCF_NOMTIT'
      Size = 60
    end
    object cdsBcoForBCF_CTAPAG: TStringField
      FieldName = 'BCF_CTAPAG'
      Size = 1
    end
    object cdsBcoForBCF_DESPAG: TStringField
      FieldKind = fkCalculated
      FieldName = 'BCF_DESPAG'
      Size = 3
      Calculated = True
    end
  end
  object cxHintStyleController1: TcxHintStyleController
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Tahoma'
    HintStyle.Font.Style = []
    Left = 928
    Top = 24
  end
  object cxHintStyleController2: TcxHintStyleController
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Tahoma'
    HintStyle.Font.Style = []
    Left = 864
    Top = 228
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpLeftBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 903
    Top = 64
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 896
    Top = 168
  end
  object frxExpHtml: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 928
    Top = 168
  end
  object frxExpXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 960
    Top = 168
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44113.690385625000000000
    ReportOptions.LastChange = 44113.690385625000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 904
    Top = 216
    Datasets = <
      item
        DataSet = frxDBFichaForn
        DataSetName = 'frxDBFichaForn'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 600.945270000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Shape1: TfrxShapeView
          Width = 445.228346460000000000
          Height = 30.236220470000000000
          Fill.BackColor = clSilver
        end
        object Shape2: TfrxShapeView
          Left = 445.425480000000000000
          Width = 90.708720000000000000
          Height = 30.236220470000000000
        end
        object Shape3: TfrxShapeView
          Left = 536.236550000000000000
          Width = 90.708661420000000000
          Height = 30.236220470000000000
        end
        object Shape4: TfrxShapeView
          Left = 626.401574800000000000
          Width = 91.464566930000000000
          Height = 30.236220470000000000
        end
        object Memo1: TfrxMemoView
          Left = 147.622140000000000000
          Top = 6.559060000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DADOS GERAIS')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 449.984540000000000000
          Top = 1.779530000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 449.205010000000000000
          Top = 13.118120000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataField = 'CODFOR'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CODFOR"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 538.661422200000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dt. Cadastro:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 538.795610000000000000
          Top = 13.338590000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataField = 'DTACAD'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."DTACAD"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 630.401574800000000000
          Top = 1.889763780000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Situa'#231#227'o:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 630.401574800000000000
          Top = 13.228346460000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."STATUS"]')
          ParentFont = False
        end
        object Shape5: TfrxShapeView
          Top = 30.236240000000000000
          Width = 445.228346460000000000
          Height = 30.236220470000000000
        end
        object Memo8: TfrxMemoView
          Left = 3.338590000000000000
          Top = 32.015770000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome Raz'#227'o:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.559060000000000000
          Top = 43.354360000000000000
          Width = 438.425480000000000000
          Height = 15.118120000000000000
          DataField = 'NOMFOR'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."NOMFOR"]')
          ParentFont = False
        end
        object Shape6: TfrxShapeView
          Left = 445.606299210000000000
          Top = 30.236240000000000000
          Width = 272.126160000000000000
          Height = 30.236220470000000000
        end
        object Memo10: TfrxMemoView
          Left = 450.543600000000000000
          Top = 32.015770000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome Fantasia:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 449.764070000000000000
          Top = 43.354360000000000000
          Width = 264.567100000000000000
          Height = 15.118120000000000000
          DataField = 'NOMFAN'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."NOMFAN"]')
          ParentFont = False
        end
        object Shape7: TfrxShapeView
          Top = 60.472480000000000000
          Width = 600.189076460000000000
          Height = 30.236220470000000000
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.472480000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 4.000000000000000000
          Top = 72.811070000000000000
          Width = 593.386210000000000000
          Height = 15.118120000000000000
          DataField = 'ENDERE'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."ENDERE"]')
          ParentFont = False
        end
        object Shape8: TfrxShapeView
          Left = 599.945270000000000000
          Top = 60.472480000000000000
          Width = 117.921276930000000000
          Height = 30.236220470000000000
        end
        object Memo14: TfrxMemoView
          Left = 604.945270000000000000
          Top = 62.362243780000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 604.945270000000000000
          Top = 73.700826460000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DataField = 'ENDNUM'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."ENDNUM"]')
          ParentFont = False
        end
        object Shape9: TfrxShapeView
          Top = 90.708720000000000000
          Width = 214.677016460000000000
          Height = 30.236220470000000000
        end
        object Memo16: TfrxMemoView
          Left = 3.779530000000000000
          Top = 91.708720000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 4.000000000000000000
          Top = 103.047310000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DataField = 'BAIRRO'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."BAIRRO"]')
          ParentFont = False
        end
        object Shape10: TfrxShapeView
          Left = 214.677165350000000000
          Top = 90.708720000000000000
          Width = 285.354330710000000000
          Height = 30.236220470000000000
        end
        object Memo18: TfrxMemoView
          Left = 219.771800000000000000
          Top = 91.708720000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 219.992270000000000000
          Top = 103.047310000000000000
          Width = 275.905690000000000000
          Height = 15.118120000000000000
          DataField = 'NOMCID'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."NOMCID"]')
          ParentFont = False
        end
        object Shape11: TfrxShapeView
          Left = 500.236550000000000000
          Top = 90.708720000000000000
          Width = 85.039370080000000000
          Height = 30.236220470000000000
        end
        object Memo20: TfrxMemoView
          Left = 502.795610000000000000
          Top = 92.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Estado:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 502.811021180000000000
          Top = 103.826840000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'ESTADO'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."ESTADO"]')
          ParentFont = False
        end
        object Shape12: TfrxShapeView
          Left = 585.606680000000000000
          Top = 90.708661420000000000
          Width = 132.283464570000000000
          Height = 30.236220470000000000
        end
        object Memo22: TfrxMemoView
          Left = 588.165740000000000000
          Top = 92.267780000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 588.181151180000000000
          Top = 103.606370000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          DataField = 'C_E_P_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."C_E_P_"]')
          ParentFont = False
        end
        object Shape13: TfrxShapeView
          Top = 120.945018580000000000
          Width = 203.338426460000000000
          Height = 30.236220470000000000
        end
        object Shape14: TfrxShapeView
          Left = 203.338575350000000000
          Top = 120.945018580000000000
          Width = 160.629840710000000000
          Height = 30.236220470000000000
        end
        object Shape15: TfrxShapeView
          Left = 364.173470000000000000
          Top = 120.945018580000000000
          Width = 187.086680080000000000
          Height = 30.236220470000000000
        end
        object Shape16: TfrxShapeView
          Left = 551.590910000000000000
          Top = 120.944960000000000000
          Width = 166.299234570000000000
          Height = 30.236220470000000000
        end
        object Shape17: TfrxShapeView
          Top = 151.181258580000000000
          Width = 101.291116460000000000
          Height = 30.236220470000000000
        end
        object Shape18: TfrxShapeView
          Left = 101.291265350000000000
          Top = 151.181258580000000000
          Width = 58.582530710000000000
          Height = 30.236220470000000000
        end
        object Shape19: TfrxShapeView
          Left = 159.740260000000000000
          Top = 151.181200000000000000
          Width = 101.291116460000000000
          Height = 30.236220470000000000
        end
        object Shape20: TfrxShapeView
          Left = 261.031525350000000000
          Top = 151.181200000000000000
          Width = 58.582530710000000000
          Height = 30.236220470000000000
        end
        object Shape21: TfrxShapeView
          Left = 319.260050000000000000
          Top = 151.181200000000000000
          Width = 101.291116460000000000
          Height = 30.236220470000000000
        end
        object Shape22: TfrxShapeView
          Left = 420.551315350000000000
          Top = 151.181200000000000000
          Width = 58.582530710000000000
          Height = 30.236220470000000000
        end
        object Shape23: TfrxShapeView
          Left = 479.000310000000000000
          Top = 151.181200000000000000
          Width = 101.291116460000000000
          Height = 30.236220470000000000
        end
        object Shape24: TfrxShapeView
          Left = 580.047620000000000000
          Top = 151.181200000000000000
          Width = 137.952755910000000000
          Height = 30.236220470000000000
        end
        object Shape25: TfrxShapeView
          Top = 181.417498580000000000
          Width = 180.661246460000000000
          Height = 30.236220470000000000
        end
        object Shape26: TfrxShapeView
          Left = 180.661395350000000000
          Top = 181.417498580000000000
          Width = 364.724460710000000000
          Height = 30.236220470000000000
        end
        object Shape27: TfrxShapeView
          Left = 545.590910000000000000
          Top = 181.417498580000000000
          Width = 89.196833310000000000
          Height = 30.236220470000000000
        end
        object Shape28: TfrxShapeView
          Left = 634.740570000000000000
          Top = 181.417440000000000000
          Width = 83.149574570000000000
          Height = 30.236220470000000000
        end
        object Shape29: TfrxShapeView
          Top = 211.653738580000000000
          Width = 180.661246460000000000
          Height = 30.236220470000000000
        end
        object Shape30: TfrxShapeView
          Left = 180.661395350000000000
          Top = 211.653738580000000000
          Width = 171.968430710000000000
          Height = 30.236220470000000000
        end
        object Shape31: TfrxShapeView
          Left = 352.834880000000000000
          Top = 211.653738580000000000
          Width = 213.543390080000000000
          Height = 30.236220470000000000
        end
        object Shape32: TfrxShapeView
          Left = 566.709030000000000000
          Top = 211.653680000000000000
          Width = 151.181114570000000000
          Height = 30.236220470000000000
        end
        object Shape33: TfrxShapeView
          Top = 241.889920000000000000
          Width = 282.708556460000000000
          Height = 30.236220470000000000
        end
        object Shape34: TfrxShapeView
          Left = 282.708705350000000000
          Top = 241.889920000000000000
          Width = 435.023609840000000000
          Height = 30.236220470000000000
        end
        object Shape35: TfrxShapeView
          Left = 0.377952760000000000
          Top = 283.464750000000000000
          Width = 717.732283460000000000
          Height = 30.236220470000000000
          Fill.BackColor = clSilver
        end
        object Shape36: TfrxShapeView
          Left = 0.377952760000000000
          Top = 313.700990000000000000
          Width = 717.732283460000000000
          Height = 264.567080470000000000
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 290.023810000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 317.480520000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#245'es:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 4.000000000000000000
          Top = 328.819110000000000000
          Width = 702.992580000000000000
          Height = 238.110390000000000000
          DataField = 'OBSERV'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."OBSERV"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 122.944960000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 4.000000000000000000
          Top = 134.283550000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'C_G_C_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."C_G_C_"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 205.874150000000000000
          Top = 122.724490000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RG:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 206.094620000000000000
          Top = 134.063080000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          DataField = 'NUMRG_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."NUMRG_"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 366.834880000000000000
          Top = 122.944960000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Insc. Est.:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 366.992125980000000000
          Top = 134.283550000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          DataField = 'I_E_S_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."I_E_S_"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 554.590910000000000000
          Top = 122.944960000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cx. Postal.:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 554.590551180000000000
          Top = 134.283550000000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          DataField = 'CAIPOS'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CAIPOS"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 3.779530000000000000
          Top = 152.960730000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefone 01:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 4.000000000000000000
          Top = 164.299320000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'FONE01'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."FONE01"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 103.826840000000000000
          Top = 152.181200000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ramal:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 162.519790000000000000
          Top = 152.181200000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Telefone 02:')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 162.740260000000000000
          Top = 164.031496060000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'FONE02'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."FONE02"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 263.567100000000000000
          Top = 152.181200000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ramal:')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 321.394079130000000000
          Top = 152.181200000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FAX:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 321.260050000000000000
          Top = 163.653543310000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'F_A_X_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."F_A_X_"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 423.441389130000000000
          Top = 152.181200000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ramal:')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 481.913869130000000000
          Top = 152.181200000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '0800:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 481.779840000000000000
          Top = 163.653543310000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = '_0800_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."_0800_"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 582.181649130000000000
          Top = 152.314960630000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 582.047620000000000000
          Top = 163.653543310000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          DataField = 'CONTAT'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CONTAT"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 182.551181100000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'E-Mail:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 4.000000000000000000
          Top = 193.889763780000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DataField = 'EMAIL_'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."EMAIL_"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 182.417440000000000000
          Top = 182.551181100000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Home Page:')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 182.637910000000000000
          Top = 193.889763780000000000
          Width = 359.055350000000000000
          Height = 15.118120000000000000
          DataField = 'HOMEPA'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."HOMEPA"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 548.031850000000000000
          Top = 182.551181100000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta Contabil:')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 548.252320000000000000
          Top = 193.889763780000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataField = 'CONCON'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CONCON"]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 637.228346460000000000
          Top = 182.417440000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '% Comiss'#227'o:')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 637.181510000000000000
          Top = 193.756030000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'PERCOM'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."PERCOM"]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 3.779530000000000000
          Top = 213.165354330000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Plano de Contas:')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 4.000000000000000000
          Top = 224.125984250000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DataField = 'CODCTA'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CODCTA"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 185.196970000000000000
          Top = 213.165354330000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transportador:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 185.417440000000000000
          Top = 224.125984250000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          DataField = 'CODTRA'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CODTRA"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 355.275820000000000000
          Top = 213.165354330000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Atividade:')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 355.496290000000000000
          Top = 224.125984250000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DataField = 'DESATI'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."DESATI"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 570.709030000000000000
          Top = 213.165354330000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo de Fornecedor:')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 570.929500000000000000
          Top = 224.125984250000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'MATREV'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."MATREV"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 3.779530000000000000
          Top = 242.889920000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cond. Pagto.:')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 4.000000000000000000
          Top = 254.362204720000000000
          Width = 275.905690000000000000
          Height = 15.118120000000000000
          DataField = 'CNDPAG'
          DataSet = frxDBFichaForn
          DataSetName = 'frxDBFichaForn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBFichaForn."CNDPAG"]')
          ParentFont = False
        end
      end
    end
  end
  object frxExpRTF: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'Citel Software'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 904
    Top = 272
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 960
    Top = 272
  end
  object DtsFicha: TDataSource
    DataSet = CdsFicha
    Left = 948
    Top = 120
  end
  object CdsFicha: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 912
    Top = 120
    object CdsFichaCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 200
    end
    object CdsFichaNOMFOR: TStringField
      FieldName = 'NOMFOR'
      Size = 200
    end
    object CdsFichaENDERE: TStringField
      FieldName = 'ENDERE'
      Size = 200
    end
    object CdsFichaENDNUM: TStringField
      FieldName = 'ENDNUM'
      Size = 200
    end
    object CdsFichaDTACAD: TStringField
      FieldName = 'DTACAD'
      Size = 200
    end
    object CdsFichaNOMFAN: TStringField
      FieldName = 'NOMFAN'
      Size = 200
    end
    object CdsFichaBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 200
    end
    object CdsFichaC_E_P_: TStringField
      FieldName = 'C_E_P_'
      Size = 200
    end
    object CdsFichaCGCCPF: TStringField
      FieldName = 'CGCCPF'
      Size = 200
    end
    object CdsFichaC_G_C_: TStringField
      FieldName = 'C_G_C_'
      Size = 200
    end
    object CdsFichaI_E_S_: TStringField
      FieldName = 'I_E_S_'
      Size = 200
    end
    object CdsFichaCONTAT: TStringField
      FieldName = 'CONTAT'
      Size = 200
    end
    object CdsFichaCAIPOS: TStringField
      FieldName = 'CAIPOS'
      Size = 200
    end
    object CdsFichaFONE01: TStringField
      FieldName = 'FONE01'
      Size = 200
    end
    object CdsFichaFONE02: TStringField
      FieldName = 'FONE02'
      Size = 200
    end
    object CdsFichaF_A_X_: TStringField
      FieldName = 'F_A_X_'
      Size = 200
    end
    object CdsFicha_0800_: TStringField
      FieldName = '_0800_'
      Size = 200
    end
    object CdsFichaEMAIL_: TStringField
      FieldName = 'EMAIL_'
      Size = 200
    end
    object CdsFichaHOMEPA: TStringField
      FieldName = 'HOMEPA'
      Size = 200
    end
    object CdsFichaCNDPAG: TStringField
      FieldName = 'CNDPAG'
      Size = 200
    end
    object CdsFichaCONCON: TStringField
      FieldName = 'CONCON'
      Size = 200
    end
    object CdsFichaCODCTA: TStringField
      FieldName = 'CODCTA'
      Size = 200
    end
    object CdsFichaCODTRA: TStringField
      FieldName = 'CODTRA'
      Size = 200
    end
    object CdsFichaNUMRG_: TStringField
      FieldName = 'NUMRG_'
      Size = 200
    end
    object CdsFichaMATREV: TStringField
      FieldName = 'MATREV'
      Size = 200
    end
    object CdsFichaPERCOM: TStringField
      FieldName = 'PERCOM'
      Size = 200
    end
    object CdsFichaSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 200
    end
    object CdsFichaNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 200
    end
    object CdsFichaESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 200
    end
    object CdsFichaDESATI: TStringField
      FieldName = 'DESATI'
      Size = 200
    end
    object CdsFichaOBSERV: TStringField
      FieldName = 'OBSERV'
      Size = 1000
    end
  end
  object frxDBFichaForn: TfrxDBDataset
    UserName = 'frxDBFichaForn'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODFOR=CODFOR'
      'NOMFOR=NOMFOR'
      'ENDERE=ENDERE'
      'ENDNUM=ENDNUM'
      'DTACAD=DTACAD'
      'NOMFAN=NOMFAN'
      'BAIRRO=BAIRRO'
      'C_E_P_=C_E_P_'
      'CGCCPF=CGCCPF'
      'C_G_C_=C_G_C_'
      'I_E_S_=I_E_S_'
      'CONTAT=CONTAT'
      'CAIPOS=CAIPOS'
      'FONE01=FONE01'
      'FONE02=FONE02'
      'F_A_X_=F_A_X_'
      '_0800_=_0800_'
      'EMAIL_=EMAIL_'
      'OBSERV=OBSERV'
      'HOMEPA=HOMEPA'
      'CNDPAG=CNDPAG'
      'CONCON=CONCON'
      'CODCTA=CODCTA'
      'CODTRA=CODTRA'
      'NUMRG_=NUMRG_'
      'MATREV=MATREV'
      'PERCOM=PERCOM'
      'STATUS=STATUS'
      'NOMCID=NOMCID'
      'ESTADO=ESTADO'
      'DESATI=DESATI')
    DataSource = DtsFicha
    BCDToCurrency = False
    Left = 952
    Top = 224
  end
  object ImageSefaz: TcxImageList
    SourceDPI = 96
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 18350924
    ImageInfo = <
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300DC7D
          4700D35C1800D55D1800D35C1800D15B1700D35C1800C3551600F1AA8100CA58
          1700D55D1800D35C1800D35C1800D35C1800F0A17300A449A300A449A300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00A449A300DA7B4400DC60
          1900D35C1800E9783700F9DDCD00E9793900C6561600F1AB8300FDF2EC00EF9C
          6C00CF5A1700DC601900DC601900DC601900DC601900F5C2A500C3C3C300C3C3
          C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3C300FFFFFF00C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300E76A2200D15B
          1700EA7E4000DA5F1800E3631900FAE2D400FBE8DD00C1541600FBE5D800FAE2
          D400E8722E00D15B1700DA5F1800DA5F1800DA5F1800F1AB8200C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300FFFFFF00FFFFFF00C3C3C300FFFFFF00FFFF
          FF00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300F1A87E00CE5A
          1700F8D4BF00E76B2400EC8D5600E9773600F9DAC800CA581700FDF1EA00FDF1
          EA00FADFCF00E76C2500D55D1800DC601900DC601900F1AB8300C3C3C300C3C3
          C300FFFFFF00C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300FFFFFF00FFFF
          FF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300F0A17300F7CE
          B700F6C8AD00E76A2200F9DBC900EA7D3F00C1541600FDF3ED00FDF1EA00FDF1
          EA00FCEEE600FDF1EA00F9D9C600E7692000DC601900F1AB8300C3C3C300FFFF
          FF00C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300FFFFFF00EF9F7100F4BB
          9B00F8D6C200E76D2700F5BFA000E9793900C3551600FDF2EC00FBE8DD00FCEB
          E100FDF2EC00FCEDE400FDF2EC00EF9F7100DC601900F1AB8300C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00C3C3C300C3C3C300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C8571600D75E
          1800D35C1800DC601900D15B1700E1621900F7D0B900CE5A1700E9773600E977
          3600C6561600FDF2EC00FDF1EA00FAE0D100D35C1800F1AB8300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300D15B1700CC59
          1700E76D2700CE5A1700F3B79500FDF2EC00F6C8AE00DE611900EC8A5100ED90
          5B00ED935F00FDF1EA00FCEEE600FDF1EA00E1621900F2AD8500C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300FFFFFF00CE5A1700EC8A
          5200FBE5D800F1A97F00FDF2EC00FDF1EA00F8D3BD00DC601900EE986600E062
          1900C3551600FDF2EC00FCEDE400FCEEE600F5C2A400F1A87E00C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3551600FDF2
          EC00FCEDE400FCEEE600FCEDE400FCEDE400FDF1EA00E9753200E5631900CC59
          1700EE966400FCEFE800FCEDE400FCEDE400FDF2EC00F0A57900C3C3C300FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300D15B1700CF5A
          1700FCEBE100FCEFE800FCEDE400FCEDE400FCEDE400FDF1EA00FDF2EC00FDF2
          EC00FDF1EA00FDF1EA00FCEFE800FBE8DD00DA5F1800F2AD8500C3C3C300C3C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300FFFFFF00D15B1700CE5A
          1700FAE1D200FDF1EA00FCEDE400FCEDE400FCEDE400FCEDE400FBE9DF00F6C6
          AB00FCEDE400F6C5A900EB824600E8702B00D85E1800F2AD8500C3C3C300C3C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3C300D35C1800D55D
          1800F6CAB000F2AE8700F9DCCB00FCEDE400F8D1BB00FCEFE800FDF2EC00E977
          3600CA581700DA5F1800E0621900E0621900E0621900F2AD8500C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300D35C1800E062
          1900DE611900D55D1800F4BB9B00FBE6DA00E8712D00ED905A00F2AE8700E76A
          2200D85E1800E1621900E0621900E0621900E0621900F2AD8500C3C3C300C3C3
          C300C3C3C300C3C3C300FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300E0804900E162
          1900E1621900E1621900D75E1800E0621900E1621900E1621900DE611900E162
          1900E0621900E0621900E0621900E0621900E1621900F6C8AD00C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00A449A300EE95
          6100E5631900E5631900E5631900E5631900E5631900E5631900E5631900E563
          1900E5631900E5631900E5631900E5631900F4B99700A449A300A449A300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300}
        MaskColor = 10766755
      end
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000679C36FFA386
          3BFF4CB122FF65A625FF7EA030FF58AC24FF52AD22FF779F2DFF93AA4BFF7F9E
          2FFF4CB122FF4CB122FF4CB122FF4CB122FF759F31FFA2688EFFAB64A9FFBFB4
          BFFFC3C3C3FFC3C3C3FFC8C8C8FFC4C4C4FFC3C3C3FFC3C3C3FFC8C8C8FFC4C4
          C4FFC3C3C3FFC3C3C3FFC3C3C3FFC8C8C8FFE4DBE4FFB26EB1FFA68638FF5AA9
          25FF4CB122FFBC8936FFEBA77EFFCE9553FFAE893BFFD29C65FFF4D0BCFFE8A1
          75FF92912BFF4CB122FF4CB122FF4CB122FF7D9F2DFFD3A989FFC6B5B9FFC2C1
          C2FFC3C3C3FFC7C7C7FFE2E2E2FFD0D0D0FFCBCBCBFFC9C9C9FFE9E9E9FFD0D0
          D0FFC4C4C4FFC3C3C3FFC3C3C3FFC3C3C3FFC7C6C7FFC0B7C0FF62AA28FF68A3
          24FF88A034FF5DAA25FFB38D34FFDAC194FFEAC5AAFFCE7D4AFFF2CFBBFFF6D1
          BCFFCC9651FF58AC24FF4CB122FF4CB122FF61A926FFA3A954FFC9BFB8FFC3C3
          C3FFC8C8C8FFC4C4C4FFCCCCCCFFEAEAEAFFEFEFEFFFD0D0D0FFF3F3F3FFF3F3
          F3FFD0D0D0FFC4C4C4FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FF94A23FFFD480
          47FF9BA749FFC58A3AFFAD9C43FF6DB036FFDAB386FFC98D54FFF4DACAFFFBEB
          E2FFF3CFB6FFCC9651FFB68735FF63A624FF61A926FF77A733FFCABFB9FFCECE
          CEFFE3E3E3FFC9C9C9FFCACACAFFCECECEFFE8E8E8FFD6D6D6FFF6F6F6FFFEFE
          FEFFF3F3F3FFD2D2D2FFCBCBCBFFC4C4C4FFC3C3C3FFCBCBCBFF7BAB39FF4CB1
          22FF74AC35FFD38C46FFF1B38FFFC39146FFAE8C40FFF0D1BEFFFAEDE3FFFCEE
          E7FFFBEBE1FFF9DFD0FFF3C5AAFF9E9C3BFF61A926FF77A833FFCEC3BDFFE5E5
          E5FFD3D3D3FFCACACAFFE8E8E8FFCACACAFFCDCDCDFFF1F1F1FFFDFDFDFFFFFF
          FFFFFEFEFEFFF8F8F8FFF1F1F1FFCACACAFFC7C7C7FFE9E9E9FFDE965FFFBAA6
          5EFFC2AB6AFFDF8040FFDFA16DFF7CA430FFB48C43FFEFC8B3FFF6D6C3FFF7D7
          C5FFF5D9CAFFFAEAE1FFFAE5D9FFEBA579FFA98A2EFF77A733FFCABFB9FFCCCC
          CCFFE2E2E2FFCDCDCDFFE6E6E6FFCACACAFFCFCFCFFFEFEFEFFFF4F4F4FFF4F4
          F4FFF5F5F5FFFDFDFDFFF9F9F9FFD1D1D1FFC4C4C4FFC8C8C8FF55AC22FF968E
          29FFA2882CFF61A623FFB3802DFFCA8943FFDAAD7DFFA4933CFFBD8C3CFF969C
          37FFCB864CFFF6DFD1FFFBEDE5FFF4CEB8FFCD7D3AFF77A733FFC9BEB8FFC3C3
          C3FFC7C7C7FFC4C4C4FFC8C8C8FFCECECEFFE4E4E4FFCECECEFFC9C9C9FFC9C9
          C9FFCECECEFFF7F7F7FFFEFEFEFFF2F2F2FFCBCBCBFFC9C9C9FF4CB122FF8394
          26FFBE8A39FFB78637FFDDB083FFF4D8C4FFE2C49EFF62AE2EFF66A626FF4CB1
          22FF81AB40FFF8E1D3FFFBEDE5FFF8DFD0FFD68F50FF76AA33FFC9BEB8FFC3C3
          C3FFC9C9C9FFC4C4C4FFCFCFCFFFECECECFFD7D7D7FFC5C5C5FFC3C3C3FFC3C3
          C3FFC9C9C9FFF6F6F6FFFFFFFFFFF8F8F8FFD8D8D8FFE8E8E8FF63A726FFA0A4
          4AFFF4C7ABFFF0B693FFF8DFD1FFFBECE2FFE8CEAEFF6CAC31FF6AA627FF5BAB
          25FF87A23CFFF5DCCFFFFCEDE4FFFAE7DCFFE5C29CFFBCAF6CFFCABEB7FFCECE
          CEFFEAEAEAFFD5D5D5FFF0F0F0FFFCFCFCFFF2F2F2FFCACACAFFC3C3C3FFC3C3
          C3FFC9C9C9FFF6F6F6FFFFFFFFFFFDFDFDFFF3F3F3FFCFCFCFFF6FA731FFEDBF
          A5FFF9E5D9FFFAE6DBFFFBEBE2FFFCECE3FFF7E0D0FFD29D5DFFCB8B41FFB48E
          41FFDDA473FFF9E3D7FFFBECE3FFFAE8DEFFF5D1BDFFC2B072FFCEC2BBFFE9E9
          E9FFFAFAFAFFF9F9F9FFFDFDFDFFFFFFFFFFF9F9F9FFD3D3D3FFCCCCCCFFCCCC
          CCFFD2D2D2FFF7F7F7FFFFFFFFFFFDFDFDFFF1F1F1FFD1D1D1FF60A522FFC582
          40FFF4D5C2FFFBEDE5FFFCEDE4FFFCEDE4FFFBEBE2FFF9E2D5FFF8DED1FFF6DB
          CCFFF9E3D7FFFAE8DDFFF9E0D2FFF4CCB5FFCF8C4BFFA9A957FFCABFB8FFCECE
          CEFFF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF8F8F8FFF7F7F7FFF7F7
          F7FFF8F8F8FFFCFCFCFFF8F8F8FFF0F0F0FFD4D4D4FFEAEAEAFF4CB122FFA08A
          2FFFF1C8B0FFFAE4D7FFFBE9DEFFFBEBE2FFFBE8DEFFFBEBE3FFFAE5DAFFF4C6
          ABFFF3CDB7FFF0B695FFCF9957FF82A637FF799E28FF61A926FFC9BEB8FFC9C9
          C9FFF3F3F3FFF6F6F6FFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFF5F5
          F5FFF4F4F4FFEFEFEFFFD0D0D0FFC9C9C9FFC4C4C4FFC8C8C8FF4CB122FF978E
          2AFFE6AC82FFE8B38BFFF6D3BFFFFAE4D8FFF6CFB9FFF9DECFFFF8D9C8FFD193
          52FFAD8532FFA4892BFF4CB122FF4CB122FF61A926FF61A926FFC9BEB8FFC8C8
          C8FFE8E8E8FFD5D5D5FFF5F5F5FFFDFDFDFFF8F8F8FFF6F6F6FFF1F1F1FFCFCF
          CFFFC9C9C9FFC8C8C8FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FF4CB122FF56AB
          22FF6BA72AFFAD8830FFECA67FFFF3C1A5FFE88A52FF91A843FFDBA16AFF6AA8
          29FF4CB122FF4CB122FF4CB122FF4CB122FF61A926FFA9AB5CFFCABFB9FFC3C3
          C3FFC7C7C7FFC8C8C8FFECECECFFEFEFEFFFD0D0D0FFC9C9C9FFC8C8C8FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFCBCBCBFFA38B39FF6EA3
          27FF4CB122FF4CB122FFA48728FFA78C2EFF4CB122FF4CB122FF909225FF4CB1
          22FF4CB122FF4CB122FF4CB122FF4CB122FF84A135FFE3A898FFC5B4BAFFC2C0
          C2FFC3C3C3FFC3C3C3FFC7C7C7FFC8C8C8FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC7C6C7FFE5DBE5FF66A133FF859C
          34FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB1
          22FF4CB122FF4CB122FF4CB122FF929428FFCE996CFFB563A0FFAB63A9FFBFB4
          BFFFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC0B7C0FFB16BB0FF000000000000
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
      end>
  end
  object odgCertGestao: TOpenDialog
    Filter = '*.pdf|*.pdf|*.jpeg|*.jpeg|*.png|*.png|*.jpg|*.jpg'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 836
    Top = 332
  end
  object popMenuCert: TPopupMenu
    Left = 424
    Top = 111
    object miBuscar: TMenuItem
      Caption = 'Buscar'
      OnClick = miBuscarClick
    end
    object miExportar: TMenuItem
      Caption = 'Exportar'
      OnClick = miExportarClick
    end
    object miVisualizar: TMenuItem
      Caption = 'Visualizar'
      OnClick = miVisualizarClick
    end
  end
  object fodExportarCert: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 815
    Top = 292
  end
  object frxAjudaImpCSV: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43609.400216446760000000
    ReportOptions.LastChange = 43609.400216446760000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 208
    Top = 448
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 340.157700000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baWidth
          Top = 18.897650000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Layout do Arquivo para Importa'#231#227'o dos Limites Mensais de Compras' +
              ' por Fornecedor')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 30.236240000000000000
          Top = 68.031540000000000000
          Width = 381.732530000000000000
          Height = 226.771800000000000000
          Memo.UTF8W = (
            'O arquivo deve conter as seguintes colunas separadas por ";" :'
            ''
            'C'#243'digo do Fornecedor: At'#233' 8 caracteres; '
            ''
            'N'#250'mero do Ano: 4 caracteres'
            ''
            'N'#250'mero do M'#234's: um valor de 1 a 12'
            ''
            'Valor do Limite: valor num'#233'rico; Exemplo: 25000,00'
            ''
            ''
            'Exemplo de linha do arquivo:'
            ''
            '12345678;2019;05;60000')
        end
      end
    end
  end
  object frxHelp: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42496.335923645800000000
    ReportOptions.LastChange = 43446.605427349500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 832
    Top = 192
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 3.000000000000000000
      RightMargin = 3.000000000000000000
      TopMargin = 3.000000000000000000
      BottomMargin = 3.000000000000000000
      LargeDesignHeight = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 18.897650000000000000
        Width = 1099.843230000000000000
        PrintChildIfInvisible = True
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 876.850960000000000000
        Width = 1099.843230000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 771.024120000000000000
        ParentFont = False
        Top = 83.149660000000000000
        Width = 1099.843230000000000000
        object Memo1: TfrxMemoView
          Left = 257.008047320000000000
          Top = 7.559060000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          HAlign = haCenter
          Memo.UTF8W = (
            'O layout do Excel esperado para a importa'#231#227'o dos dados.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 265.236408420000000000
          Top = 91.590600000000000000
          Width = 79.370130000000000000
          Height = 45.354360000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Consolas'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Coluna A'
            'Coluna B')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 349.386068420000000000
          Top = 92.811070000000000000
          Width = 11.338590000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '-'
            '-')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          Left = 29.897657320000000000
          Top = 213.653680000000000000
          Width = 1039.370750000000000000
          Height = 283.464750000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000040A
            0000027C0802000000F86DD49D000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            0044D449444154785EEDDD0BBC64575920FAD3210121810E84C8640817253C03
            984888092812F0C10D83330CE6CEEF7A650C8801758CDCBE3C9408721D045474
            5A088386F820238A0F44408461E41104F4F620AF01028104190C446090BC934E
            F739E7AE53DFD78BDDB5AB76EFAA53E75175FE7F2A9BF57D6BEDB577D5AEB36B
            7F55A7FAEC3AEDF433960000009696D6CA83B32E7D47460000C03670CBB37FE8
            59DF7652061BE3922F5C7B9757FE650603FB2E38F7A86C0200003B9EF2000000
            48CA03000020290F000080A43C000000D264E5C16BCFFCD6A58F9C586EA5B1D6
            060000B6CE63FEE8CD71CB78546622139407A51E78E625ABD1BEE4EFB3010000
            6C95F7FF5F4F8E46D403B52AA8F949F52D0F4A6D504B8233CE587AD6233FBCB4
            F4F73E40000080AD3554211453D70645DFF2E08C67AEBEF6B54B1FFE70AD0DD6
            728325C042895F9E8C5BA67ADB3E6F9A4CB427F5FEC62DB3DBD5F6DF4380CDD7
            AC07D6531B14137F35B9140903A5368822016041C4C5F1333FF4D5B86576E36D
            87EBDD7AAF37F38E03B00DF52A0FEA4BD7875FBB2B1A000BA97971EC42198079
            D1FC22F2D45F4A0EBDCA83339EB9F6AD835A1B3CF392FAD1C1AA0F7981C5109F
            1B64D0527AEB2D53871C313FD435948C46CD0C8521C26666A48E611D5DDD46AE
            1861CD37C368374D941F992CC6E58B915D110EE5236C668A914980F9D2FECAC1
            7A2A845DA79D7EC65997BE23A351CA49B39607CFBC6435BE7EF0DA67D5AF1FEC
            F2061BB000CAB9AEBB3CA8BD1DEDB2EC1ED64C561D931423E769EB98E488338C
            9B76DC8AA55D9623C376D711DB559FC1A55D96930E2B468E6C2601B69B5B9EFD
            43CFFAB6933218AFA33638E297102EF9C2B57779E55F6630B0EF82738FFCE941
            D406D128B541114B5F3F00768E9117914317974363A6BEEE6CAED8DE44C964D0
            D0B1273DAF80CBB07AAB998E4D0FCD59C3667E68866A64BEE7E08EF94BBB6432
            E8B727000BA0D40071CB7854662247280FEAA9F6C3AFFDB02F1E003B59391FC6
            2DE31E46AE32D10C335177A363D3E5EAB9DE32350B7D365D4D347852E326DF88
            6D01CCB523940743DF3AF8FEBBFF7CB47DFD00D839E29A72A2ABE771AB4418BD
            99DA787537E296D94D31D1A6271A3CA99193477B930F07C0367784F2A0140387
            6A8347FEDCCFFDDCA03182132B30EFE2323183967A41D95FC72A53CCC6C67138
            009A8E501E9493663D6FFEEA40B487BE7E502A87BBBFF1371409C0BC6B9EC746
            9ED39AC9727A3CE2F8625CBE8FF626465ECB76EF490D87F2DD7A6EBADBC84D0F
            CD5CF519DCDDD5B1877564731500DA8EFC2F17B57DF8D213D796AF2D85C1DABF
            5C543F5528C5C3142F1E00DBC7D0B5633DA7D57C5C92B6F3C5B8AE66BE998C46
            88FCD00CD5B8B59AEA9862689EA1AE6C358CDC6818B9E9A1F11D615DBD181A93
            AD46BEE7E0E6FC45ED1D4A36C362E4E423D705D8267AFECB45EB31F25F2E9AA6
            3C88F3E9332F597DEDB3D4060000307BA53CC8D6469A4D79109AEFC4146A0300
            00986BEB2A0F00008045D2EBCFA20100003B84F200000048CA03000020290F00
            0080A43C00000092F200000048A3FF61D363AFFFC6B1377C2303000060B1DC7C
            B7BBDFBCFBEE191CD2F5770F7EED0177CCD63CF8D24DBBCBF243EFBAECFCF3CF
            BFE24B6B997B1F77FDDAFF2DAE1D7897E78BE7645532D96246DA8FB0F3C07A38
            9D2EA41D72583D7B174F1CD3CDF1CA6BBF96AD06E5C11C7346D8E63C27AB92D9
            B76F5F06ACDB45175D74F2C9270F3DC2CE03EBE174BA9076C861F5EC5D3C714C
            3787F260D138236C739E9355C994F2E035AF79CDF5D75FBF7BF76ECB752E6FBC
            F146E5C16C399D2EA41D72583D7B174F1CD3CD31AE3CF0D5646033745CEF5A4E
            B4CC0714003686F200D80C1DD7BB96132DF3010560115DB1EF6D9B76CB4DB628
            0F60E9F8E38FCF161BA6E37AD772A2653EA030234E80B0DD3CE6BBCF9CE8B69E
            B5469AB23C98F46C52C6878C27B79E7587C49E1419F7902BCCED3934F7BEDFFE
            E7D0814C1D49FF911B217635646A1265ADEBAEBB2E83969873BA992735D156CA
            E090710F1D83279A673A1DD7BB96132DF3019DDCE0F9B226E34E39F490CC6E91
            89766043F776F0607C53668F24476F8F7B31347309EB09B0BDD1C88CDC9966B2
            B49B323B5772D7FBEDFCD0B09E6B5583EDACC9F870EDFCB89153186C764DC69D
            7A0E9BC846CC39A9C103903235A1A9576C8A1DA832BB6D4C531E4C7A37CAF872
            F6095BFE104CB133DB6AFFA730C5FEE7E8F9B9BFB9BB53ED70592B5BA374F7CE
            D0447B3EC531DD72ED2BDD5DBB76959D8F65BB776859479665F7C8F672DCFC7D
            B63B6ED95C773DFB36C5321FD00995DDCB67CCE4E781A2E72A0B2F1F8EC16921
            964734C523BF99CA5E656B94EEDEA6C1FD4B999A1F531CA3A90FE511B755F2D9
            9AB529EEE6E2693E08C5748F4359315BEB103BD06C6C2B139707F1C866D0C3D0
            F8D2AE07A334420DEB321A21C25999F418941D18DAFF68C4BE15356C268B767E
            2853C31061917123B34E93DEE5A68EE3550C8545648A8CC7DF9DC80C754558D4
            B02EA311221CA96387A3D1CC141116198F5A2BDA439922C29928B3F53F4C4383
            6B7BB0536B86C222C2BA8C46A8C9584623445864DCC84CA17DA55B9265E75757
            57CBB2DD3BB42C836364594E7A153E72EB1DF93ECBE6BAEBD9B729966573EB54
            9F3353C8A742E3D9529343991A86088B8CC767321888B02EA31186C222C2BA8C
            468870F3954D371FEDDA8EBD2A86C222C2BA8C4688B0293B1A5D19B7D62D22AC
            CB688408433333D455957CF7B328565C9BE890767E2853C3106191716766F395
            BBDFDE81D8AB22E356A634869E0FD1D55E46A3B6B750EC43EC4C68E723534458
            647C78A6B98C4688B0C8B891099119EA8AB0A8615D462344384EC78FE4D0320C
            654A23445864DC991927C7F518B909262E0FBACF087DC40CE5FE9746A88F4524
            C7F56E1FDD3B3F32DFCE34BB8AE86D6766A5CC1693673CA158379476331361F7
            98A20EAB6A6FC7E0488EEBEDD0315BCDB4C7B4334569D7E5C801DBC1B83D0FD1
            1B99B21C1A5C96E3BA4666A633748D1BD3B6AF7DC72D9B3344BBCC509725DF7E
            FF3E3243E3A33746967C1D1F99F69866A62E4BBE54023533F5BE4D9A8965D9C4
            74CA6C21E323C9D103E5604566F0445853DA75D8C84CB3AB88DE3E9922E341A6
            2C235396EB1F3C137543D319B963194F722FDA5D230767DC6FE69AAC999ECAF8
            AA66CA3CA5313461E4DB99665711BD7D32EB175385D2CEEC8462DD50DA23336D
            A52B1A439BAEEB8E5B7133D57D1BDAA5A19DAC61313253962519CB230E2E99A6
            DADB313892E37A43648692258CC145ED8A64B4476AAFD527334E7364A6B6D4A6
            7E35B9DCF930322CEA83521AD9D7F968AE479979B6C760DC6CED7CC7DDAC9968
            477226CA6C3179C6138A7543A60E295DD96AA96B453B92D55066E426EA9891BD
            DD72F4A8D9C6A95B897624375AD9DCA66D2B4CF460CEEA31695FE39639E30AB8
            991FB76CCE10ED98A1EC5269977986DEBFAF99D8F3BA569DA1F4C6B264629E3A
            7E64A6AE5B9665C5666668E658C60CA5DDB16F13659A5B9F4E992D947DCB54A7
            181C8DC81465DD90F1A86745C7F8D255C33A2C3245841DEAEA45A63AE5D07E83
            B7A79E77B9F998F73472E629E60965C5AA66A231A49D6F6672870EED52E9AA61
            0CAB9962306406CA5465DAD07FDAF6E0B57D1AC8B8530E3D34B8CC168D21E3F2
            53881D0E99EA67EA7DAB5B8C7624C7E91E3C94A9838B4C35C68CECAD4A6F1D90
            A951C7AE8CA98DC897654D0EE9C80F665D5B7DDC98893C7E20831E261D5FCDB2
            3C8887A0C8B8A53C34CD4727C290A943CA24D9318B47B32DE6CFE090C1BEAFC9
            78E3956DC57D2C3275E861D99CDD18DCDD35198F57C6C48E1599EA275659FF26
            A6D8811C3D90A91E627C9F1D9EA1B2B9D8E2D076235F643C2365C2B89B45A63A
            C5C875EE46F37ABA2CEBB56FCC3CD4DB5E9619CA55721919D7CD9129EBD6DEE6
            C866A68C19CAB4C79446E46B3BF62AAECBEB5686C6D44C09BBF7ADF6967664EA
            BA757CCD44BBE463AD3AA66EB10C98ADB29590F1E1E2A1C8E0D0932164AA530E
            1D6866A69BB3AC95E3A6DDFAFAC53E64D050F221E3192913C6FE17999A918D9B
            793D7287069A99FAC06EF26E97CD858C3BE56E0D646ABC9EC3662B365A647C48
            DEC9593F7B8BD85CCF99FB0F2E63627091A986EEDE10BD755B1186C8CC4ACCD9
            F311E81617FAEF79CF7B22EC23064F5121CCB23C8887A0C878A084CD07258E59
            0687743C6A337940878CDC87626DD707321E28E1D0FE67ABB73EABD431B531B4
            DDF5E898677077D764DC52D61DEA6DCFD6317FED2A93F45FB163C2E288BDEDBB
            5357E95EB7A80346EEF00629DB0AD18E64887C91F140099BFBB69EFDECB3EEAC
            1E937A75DB5E0EF596ADD42BE3E69872955CF6A15E2B37D76AB727CA9446E49B
            EDD856D993C83797CDF16559C2EE7DABBD6539D43B727CB463FCD0E3509665C0
            6C95AD848CFBA94F869ECF8A18560797CDB557EC3955D17F649874FC14E2312C
            321E286173D3EBD98DEE756735739F79CA98A1BB39919EBB1AC3EAE0A147B2E8
            39CF3AAD1DD1818C0F57F2237763DCBE0D8D2FED71335733BC9B1D53ADDDC381
            8CFB39E2BED50165E6750E1EB77AF7B4FDE7A9460E885DEA787CC64D5BF37D1E
            816E53D40661BA0A61337EB9281E94501FDC91C9AAF6B6BBD6A9CC19CB10C96E
            ED5D6D673AD4C1ED91EDAE9A29DAE3A733C59C397AD48EF5C914916C679A6AEF
            D0E0F6C8A2BB37BA8ADA5BC717ED6464DA63DA99AA64CAB263C0666AEF46CF1D
            2BBD65590737470E7515D1DBCE4C67E81AB7CCD6BCDE6DF696ADD42BE9716386
            32ED76CDB4DFB36F674A23D6ADED5A15943D19AA10E2716866EA3C2333CD76DC
            EBEE4CB4EBE3138F7FED2DCB32600A314F28EDCCF613EBD646A893D4647BDAF6
            F83E99914A6F59D6C11D238BA1C145F7F80DD5DE8D9E3B567ACBB20E6E8F6CCF
            D3CE8C547ACBB20E6E8E1C99EC23D60A991AA36313B5AB88DE8E4C8433D1DE4A
            7F757C7B9291D38E4CB6D5611D6326D573D3FD0DED647BFE76A628ED915D2307
            57B57768707B64D1D15BBB420C6826DBAB8CD35EAB4F669CE6C84C1D6EEACF01
            A6AB2B769D76FA19675DFA8E8C1A7EED0177CCD63CF8D24D6B2F991F7AD765E7
            9F7FFE155F5ACBDCFBB8B557D92D570E73F713626ADBF62EF7B4718FCC389BBC
            C5793F405368DFE55032FBF6ED7BCD6B5ED3BCC62DCB7A122CC7A5991FB92CD7
            E8E54ABD23D39E2D32717D1F2387326559C7473B7AEBFC43999A9F34336EDF26
            CDC4F2C61B6F3CF9E493871EE1AD7A9A959D2CBB97C1DCDA813FAD5B65339F30
            3BE4B06ED5DDDCCC43B99DCF331BB16F7FFDEEF78FFB9B65E3AEF5DFFFC10F95
            657BADEEDAA0ACF5D7FFDB591934ECBBE0DC893F3D280FC490EC9813B9D30DD9
            B1B8F27E366407DB431E9586EC582CF5EAB62ECB29B55C4397E5507EE472E8FA
            BB9D69CF1699E6C8A14C737CB4EBC891999A9F3413F3D46D45A63C264399F698
            A14C2CE3F19C543EB71AB28349E463D7901DCCB33C960DD9B158F2BE356407EB
            504ED19BF948960BFD71D7FA234D3ABE9AB83C280FC490EC9813B9D30DD9B131
            367AFE3EE26E3665C796DAFCDDD82677BC6D704C0E931D8B65E81A77D7A16FEB
            D665B377272CCB819EEE5EE7033AA1786A3565C7FACC6A9E79110F5D5376D0CF
            F67CC4E2503665C762C9FBD6901D5359E7EA13D9CC6D4D6A336B83CDB419DF3D
            0018BAC68DF7C59BCBF675F0622FE345A57BCCC8653C9E006CB9F2E25564B040
            9407C066E8B8DEDD99CBF28A52EAA2EE312397F98002C0C6501E009BA1E37AD7
            72A2653EA000B0319407C086BBE8A28B6EBCF1C66BAEB9C672FDCB7C4C016063
            F8874DE7957F896F9BF39CAC4EBD773698A1E623EC3CB04E4EA70B69871C56CF
            DEC5F3D7EF7E7FB636DEB87FD8746C79F0EC934E9CA36758FC780C59EC9F901D
            7897E78BE7245BC57960524EA70B69871C56CFDEC5B3992FA6AFBCF66BD96A98
            E6EF1E0000008BAAEBD3836C0100008BC5A7070000C011280F000080A43C0000
            0052AFEF1E7CE85D97650B0000984343FFF2F8B8EF1EF42D0FCEFCFEF3330000
            00E6CDA9F73EECCFE6F86A3200007004937D7AE0AF9F0200C01CB9ECB26F5EC9
            CFFE978B8626050000B6B37157F27EB90800003802E501000090940700004052
            1E000000497900000024E501000090FCC3A687B9F4D7F7646B513CE6F13F902D
            600778F0239E982D001898F41F36551E1CA694077BF7EECD60FEEDD9B3A79407
            C73EDCE502EC08377FE2EDFDCB83C57B37A4A70B9EBB7727DFF76C013B89F260
            5D9407C0FC9AB43CB8F0C20B33D8312EBEF8E2280F76EC7DCF00D849262D0F7C
            F700000048CA0300467BC55B6EE873CBD18BEB812FB87FBD650A6071290F0018
            EBB7F69C5E6EAFDE73FAAB7EF6F4FF74E169BFF2D3A7BDECA71EFE4BCF7CD82F
            FCC4C39EF7F487FDDFE73FE4B6FFF9B11CBA88A224B8F3771C7DB7B3EF74AFC7
            1D576E2A0460E1290F00186379796DB1BAB4B2BC7AFBEAEAEDCB4BCB2B2BFB97
            97F6AFACEE2F9995E5D25E60A51238EAAEBBEEF1F83B9F70F25DEE7CE098636E
            BDC3BFDCBDFB09CF7A880A01586CDBAE3C78E8C9BBEA2D53BD8D5B658AA90058
            5D593EB8BCFAD0975CF1F0977EFA8C977DFAAC5FFDF4A35F71E539BF71E50FEC
            FDDCBF7AD5E79EFCEAABF71F58CDA12DA71C92716FB1CA142BCE507C6870F4EE
            A3EE73CEEE7B1E77DC3F5D7EF3573F7AF397F65DFFC977FED347FFFA9AA73CF3
            3BBA2B84C1FD5E93F18CCC7C428091B6E3A7079FBA66356EDBE1B2FE9FEFF380
            7ACBD428471C309D3E9B06D8282B07965797FEFE050FF9FF9EFF90F73FE741EF
            DDF3C077FEEC03FEF2674EF9F39F3AE58F7FF27EFFE527EE777BE91EA55CC85E
            7DC84417B5B16269C4720B9DF4A8BB9EFA83DF7AF23DEEFEF9FFF6F52B5E74E5
            952FFDDC952FBBEA53BF78E5072EF8E85FBDE18A1F7AFAC3C6550853DF77806D
            620E7EB9288A845A2A9446DC222CDA61B61A5D35199966188D91E2BAFC1EFFF8
            B972AB21C00EB17AF0E081E59583CBA54A5839B0B27ADBDAAF15ADDCBEB274FB
            F2D26DB72FED3FB87AEBC1951CDA502FF1436D977C180A8B9AE9B3AC4A18326E
            64D6E9B32FBFEADABFBBF1BE27DDF3BE279DF080EF3C71A812F8C4459F79E71F
            7FFAC167DFAB5D21947D98EEBE1719F7B85F996DCC569700EB371FDF3D2817F1
            9FBA66ED3DAA68343F5BA8997117FAA5AB2EDBAB477EA45A1B44588B8422DED1
            8F5B64AA66B2B6DB8D10E150B28AA4CA04D82AABCB076E5F5D3AFBD7AE7CCC6F
            5CF9F8BD9F3DF7559FFDD7AFBEFA875F73F58FBCF6EAA7FDDEE72F78DD3F1C38
            38F6143AA45CBC966BE5502F64333E94298DBAAC62C5A1765916B15624436466
            E5FE27DFF3AB9FBFF1D37FF7958C1B3EF98B577EF6EF47FC7BE1238DDCC38CC7
            DF8B916B1523F3918C36C03A6DC7F2A05CB8C7AD5EBB775CC4577DC6CC44BD6A
            9FF4C2BD8C6CAE12E114F3006C8ED5E5DB6F3FB8F4AE673FF0ED3FFB80B7FCCC
            03FEF427EFF7FA0B4EF9BD1FFFF64B9EF6ED17FFFBFBFEA71FB9EFAD1BFFD5E4
            E655EFC82BE0B84A0E999A85CFBEFCAABDCFBFFC5D7F7A6569945B661B3EF392
            CF8ECCB74DBA87F56EE63A87AF3572B6918F0CC074B6F5770F325E14510654B5
            2A501800DBD48103079657F6AFACDE7670A5DCF62F2FDDBEBCF28D9BAF3BE775
            77F9C13F38EEB6E59571DF3DD84CE52AB95C1C874CCDC8B8C2605253EF61AE33
            90A98DBCBF00613E7EB9A88FF865A1A67666BB89C260A86C00D82656570EDCB6
            B254AA8287BEE65B6ED87FEB6D0757DFF3A9B73CE94FFE65E9FA931FFEFAFEB5
            F260C4770FCA656BF38DED667B43CD6A430F3CFC8FA0FDE129A774DF62ADD07D
            DF7BEE617BD8C8157BCE0630A9392B0F3E35F8CE40F3578F6AA67EDAD0CE1425
            2CCBDA557B23BF25BA6B83FA9142BB01B039560F1EB8FDE0CAFE836BBF42F493
            BFFDB85F7DF34FBD68DF8F7CCF9D9EFC67E7DD7070F50EB71F5C3AB032FAD383
            B84A0EF126773B332B75E6194EFBD32FF9DE1F7ECE69192C2DBDE0DB765DF4E0
            632E3AFB9E2F3CEF3B5FF4E2A7BDE81D7FF8A2DB6F79D1EA6AB9E58886F63DED
            B3871D6B15CD156BBE990498A16D571E34AFE9C350A68471CBF850261A233335
            ACED66188DB6A1AF0494C64417E833B99A2FFB10B78C0136D1CA5A79B0BA7F65
            F57D4FBBE98A3B7DECAFBE7159493EFB87FEE0F6B57FBF6875ED7630068E502E
            5E43C6AD4C6D14ED6434FA8C8946B46B669DAEF9FA3F7FE12B5FCF6069E9B695
            A55208ACAEAEAEAC94FF5697960F2E1D1C7FCF0FED4F91716B0F63196A7B6DC4
            408445C68D01B511EDE612605616E7978B3642AD10E25A3FC291C9AAF60EE5DB
            86E601D876560EDEB6BC560394DBDB7EF4C692F8D3F36ED8BFB2BC9639B07460
            79A9540831B029DEDB1E927D73E2ADBFF9C90FBFFE9A0C9696F67E71F5E5571E
            78F9BEAFBFEC4D1FFBE5975CF692279DFF92BBDCED25BB76955B8EE8940F4143
            76006C4BCA83232817F1F596A951C991ED766364BBDE22198632ED01001B6D75
            F9E0FEE5A55BD7BE94BCBAFFC0D21BD66A8395DB075F502E85C181959583A3BE
            9A3C786B7B58F6CD83F84672FD5EF28F5E7D75F72DD6EA900F414376006C4BCA
            0300465B5D59BE6CEF9FFCF1ABFEEC8DFFF98D7FF9DB6F7CE76BFFFCDDBFF317
            7FF3FB7FF1777FF0960FFFE15B3EF6476FFDE49FBC358702B0289407008CF6E2
            E73FE1453FFBBD47BCE5680016C2AED34E3FE3AC4BDF9151C3B34F3A315B4B4B
            1F7AD765677EFFF9A571EABD97AEF852E416D3A5BFBE67EFDEBD19CCBF3D7BF6
            3CE6F13F70ECC39F9831B0D06EFEC4DB1FFC88BE3FEFE57497AD1DE682E7EEDD
            C9F73D5BC04E32EE4AFE95D78EF8EBEFFB2E3857797098C57BCD28E541B6801D
            A07F7900C00EA13C00000092F2605D3EF391B7670B16CB4E7E537947FD2689DF
            1E016088F2605D4A79E037F5593C13FD4AFAE259B0EF1475D8B3678FF2008021
            CA8375511EB0909407CA83B6675DEADF249D03975CF0AFB3358BCFC1548FB033
            290FD64579C042521E280FDA4A7970D98F3D2C03B6A5F3FFCB2787CA830B2FBC
            3083C95D7CF1C5CA03D899262D0FFCDD03801DEDC94F7EF244CB134E38E19453
            4EE9B3EC9EC7B27BD9DFEAC0CACACAF2F272591625CC3E80C9F9F4E0303E3D60
            21F9F4C0A7076DF1E941B9127DF39BDF9CA97ECA75FFB39EF75BF77FD019A5BD
            BA7669BAB46B69696575B028CBD59592B8FACAFFFEBB7B7FF6EAABAF8E559854
            1C973E9F1E940370C36DCB9FF9DAC12F5FB77C9763EF74DB2DB71D73E0D647DE
            EFB87BDEED4E471D75D83B803E3D801D6BA77C7AF0D093CB4B11B053ACFF47FE
            9FEFF3807ACBD428471C30A9BAD17ACB8E965D8764DC901D8DAE8C470D9EC8A4
            B541B8DF031EF19C679C596ECFFDF1EF7ADE33BEEBB9CF38F3F93FF1C8E7FDC4
            773DFF82339F7FC1593F77C177DDF77E8FC8A14CA5E77129B5C1D76F3AF0C12F
            2EDFF584130EEEDFFFF9ABBE7CD677DEF7D87B9EF87BEFFEA72F7EE5269F2100
            D3D9F0F2A0BCA8376F991DE388034219F6A96B567B0E0E130D861DAEFDF332F2
            27683D3F83E3D68D7C7B70F991CFA061DC246D71517E8F7FFC5CB9D57033C5A6
            3BB65E2EF4CBC55C18BAE86F77750C9ED4A4BFC7120EAEAE2CAD2EEDDFBF7CDB
            EDCBB7EE2FB7955B6E5BBEF5B6E55B6E5BB979FFCAF2EAEAF2C1951CCA547A1E
            979595950F5C75D3C31E74D2473FF9C5A5FDB77CC7834EF8B3B77FFC810F3FF9
            B18F7FD89FBCEFCBCBCBCB390E60129BF1E941795DAFB78E97F37157006D31AC
            E7E030D16060AB8CFC511DF7F3DBF3E7FA456F7C5B59C6A579346A3BDECE8F5B
            64AA66B2B6DB8D10E150722E4CF7E9C1F2ED6BD79DA50C18FC96FBDAAF13AD2E
            ED5A59D955A24162E9E0980BD3534E39255BB3B09ED98EB86E19D094D9C94DB7
            6EFF4F0FAEFCC20D37DEBAFFE39FFCD27D762FDD7EE32D773CFAE8DB0EAC5EBF
            74EC55D7DC508A871C0730892DFBE5A2520CC4AD8675198D897A8732C550A6D9
            189907AA72D9DDFCD128EDB8108F9F9DF64FCD503E1AED616D75C53AB8B68732
            CD7068198DB8D5301ADDE252BEFB4DFD91CAC8E62A114E31CF7630DDA707CB07
            CBD5FF5A1D50942BD05212AC950ABBD66A83B5F26065E9B167DD3787CEB3AB1B
            32B5597A1E975DBB763DF45E47FDEE6BDFF5E06F3DFAC1F7DDFD81FFF1F5479E
            F5A02FFCAF95CF7DE64BDF7EE29DD6F9C912B0636D4679505FB9CBAD5E649446
            DC4ABB64223FAEB726C7F50E65468E29DAF9D2882EA05BFF1FAB9A8C76B7F6BA
            B1622CFB4CDE1ED3ECDD08510654B52AE8280CA237060CADBEB5A6FBF4E0C0F2
            4A7988579676FDE25FFDE8E37FF3B8EFFBCDE3BEFF378FFDBEBDE576DCF7EF3D
            F651BFF22DCF7FF7834E7FF1D14FB9EC81DFF773231E9378437DF0A67C6AE723
            534458D4B0266B5833450DEBB26930E4B064648A8CC76B8EA9EDC1AA6B222C32
            EE3161879EC7E5A8A38E3AF7AC7BFFEA4F3FF2477FF0942BBFBAF2C0877EFBCD
            2BC7FCC5EBDF73FB3F7CFA19FFEADBEE70873BE43880496CDE2F174523324579
            158F5BC6876BF7F65F774873C5D29E685DD8B1E287A534CA327E8826FAF169FE
            DCADC7C88DCE6AF2193AE2757FE98A5B697754119B6F1D9F1E2CADAC2CBDFFAA
            B77EF0B93795E3F1FEE7DCB4B4BAF4FED25E595A5D5D7AFAA35E70F9736EBAFC
            B937DDF5C1B1C6B072F51C6FC9C77BF3F5623AF23553C3A23DA6B463D9312CDA
            A10E1B1A136AB22A99AA84754C5996766D84665788CC74FA7F7A506A80638E39
            A6343EFD8F371D778FDD6FFD930F3EED7BEEF6333FFCA013EF71D7A17FB908A0
            A7CD3B77C4CB7C0683B0DE32D5B09EDE0E6507A65B11D8921F9FB9F899DD869F
            09F437DDA707B71F582E35C0EADA3F8CB3F64B4583DF33DAB5B2BA5630AC2557
            57CF7FF445DFFB8A631FFB6BC72E8DF9EDF772F59CADC38DCB37B5C7C4B578C8
            54E7547DB652946155CD944DD4B0A92663378A08A733E97129E5C1B7ACEEFF9D
            57BFEDD1F73BEA61F73FF18E77BCA3DA0098DAD69F3E9A3543DB7A7AC3C8317D
            56841DAE5C91979F94F675F996FCF8AC67A32F39EF496559DFB32F8D89DEBFDF
            9C37FBD7AEAF0F195C76AF29ED915D23074F67BA4F0F0E0C3E3D582E35C2EAAE
            DFFDDB97BEFF3937FFDEDFBE74F0170F06FF5B5DFDFD0FBEECF2E7DE587ACBCE
            C62A1BAA5C8BAF5DC20F646AEBE47E0C646A72131D97780E9C7BC609BFF78233
            CE7DD4C9471F7D7479624417C01436B53C88AB8DDA885BFBE2633DBD61DC989A
            AFC9D28E06D0ADFDE3136ABEDDD5D41CD63D3294316559D7EA39730C2B8DE8AA
            EA6FF5C4B57E84239355ED1DCAB70DCD3352F4C6807113968BBC9071437634BA
            325E5F6D504CF7E9C1F25A6590A5C0D31F75D177BFE22E4F3BFB056BFB12BBB4
            BAF4FB1FF8E5DFFFE0CBDFF39C5221E42A3DADF34DF79EAB4FBD95A84346AEDE
            4E4EBD9562A2E3520EC73F5C7BC3FBAE3AF0AECFECBFFACBFEC12260BD36BC3C
            187A51AF6169C42DC262A8DDEC6D76151DBDCDE4C83135D95C02230DFD808CFB
            F1897C338CC6903A6CE4C868D76573CC50D720BD66684C338C4653B928AFB74C
            8D4A8E6CB71B23DBF516C930D4556ED9B13D4CF9DD83E5E552090C7E9568AD24
            18140A83FF5F59BAFCB9379DFFA88BDEFB9C9B7FECEC17BCEE6F5F3A69791017
            DF45BCF55EC362E49BF1255F96436B8DD31E5633457BDDEC188830C6C45AB511
            9A5D2132D399E8B8DC7EFBEDEFF8D80DF73DED61CB773B69EF1F7D7AFFFEFDD9
            013015BF9B08B04DADFFC381239AEED383836B7F156DEDDF337DF4B7FFD077BF
            E2D8B29F8FF9B563CBEE3E66F07D83DFFFE04BCBF271AF38F6751F78E90D571E
            7617EA3574336C368AD26E87450DA3510CE5A3DD5CB60D461D36203245845566
            0F894C7415B53DE85C136191716340342632D171298FFFD7BF7EF3FB3FF48F9F
            FDF2CDFB6FBD6D139E36C062531E00EC5C537E7A7070B95C811EF72D47BFF4DF
            BEE1BDCFB9F9BDCFBDE53DCF29B75BDFF3DC9BDFFDDC5BDEFDBC5B7EE9319FF8
            E4CB57DF7AC1D597FFFA3417C74C745CEE78C73B3EFE6177F9FBFFFA379F7EF7
            DF3CF509F7296176004C457900B0734DF7E9C135577FE419CF7BD34F5EF4E6FF
            F00B6FF90FBFF0E69FBEE8CD3FF3A2BFF89917BEF9C25F78EBCFBEB0DCDEF2AA
            DF7A7D0E9DC4746FB42FA4898ECBD1471FFDA8EFB8F7AB9E73E625173DFA7167
            DFFF98638EC90E80A9280F0076AE78977AD2E59FBFEE79AFFFCDFFE335BFF403
            65F99F7FE907DFF0AA7FF79A5F7AC21B2EFE77BFF5CB3FF88657FFBBDFFEE527
            BCEF2F5F7EDD75D775CC60D967D9D3AE5DBBEE74A73BDD6DA034FCB345C03AED
            3AEDF433CEBAF41D19353CFBA413B3B5B4F4A1775D76E6F79F5F1AA7DE7BE98A
            2F456E317DE6236F3FF6E14FCC0016C5CD9F78FB831FB1739FD897FEFA9EBD7B
            F766B0D0F6ECD973C173FBDED3675DFAD6CB7EEC6119B02D9DFF5F3E79C905FF
            3A83C133F9C20B2FCC6072175F7C71FFA707B048C65DC9BFF2DAAF65AB61DF05
            E72A0F0E53CA836CC162D9E1E541B6768089CA836CB18D0D9507D99A96F20076
            26E501000090262D0F7CF700000048CA03000020290F000080A43C00000092F2
            00000048CA03000020290F000080A43C000000D2647F16AD3422030000CC850D
            FCABC90000C03CF25793010080C9F4FAF4A0941A0000C05C9BD92F175DB1EF6D
            D9020000E6D3A9673D295BEB2F0FCE7BCA37E7020000E6CB1BDFF4B6199707D7
            5F7F7DC600C0E476EFDE9D2D8075B8FCF2CBB3D5DB39E79CA33C0080ED457900
            CC44290FCAE57E063DC4F89EE5817FB908000048CA030000206D417970FCF1C7
            676BCEC51D5998BB03404FCEFCC002DBC0F2A09C3D43C60325BCEEBAEB326888
            614383FB5BDBCC21999A858ED94A57B923B1CC1470F80F6391D9318E38606A1B
            37339BAC7D28C71DDC890EFAD0E0EE39DB833B5EC800E6DD46950771F60CCD33
            6609B3354A776FB7C1A6D6CCF0045D66CB564B74750C801D6BEDE7F0908E9FC7
            384B64306B1B37333BCAC827D2B86797671DB01836A43C187AD5AFED920F1116
            EDB036A23D942922EC50365787C52A458445C6E333D1682EA311222C32EECC00
            55FE78347EA6EA321AA18675198D3014169129323E7C86688408993BCD537A51
            DA1DAF2921B3873F196AD861B0526A66A2D1CC14351C5A46234408B069F6ECD9
            93AD75D8BCEF1E94136539A7873869D6CCD039B49DAF9962687087F65A7D3235
            19EDA2CF5AED0CEC58E547A02A3F1191899F8EA2B44BA634EAB2DD5B93E37A33
            3ED20FE0B83C0B60A2831EC968778B158BBA6E69D7659FC9478E01D804511BAC
            BF42D882AF26B7957368B60E372EDF5F39358708E3641D617BF29AE9D86E74D5
            798AC80355F901A93F299129F20766CC8F4CF6357AFBAF3BA4B96269E79A7E54
            E7591CC7D228CB7A7C273AB8CD67C57A8CDCE8AC2607588FA80AF6EEDD5BDB53
            DB16E5C1C62967EDAA99699ED9A750568F798A4C01872B3F1D43975055A61AB2
            6320530DD93190A97EFCA82EB02D39B89E51C0F6D4AC0DD65F216C487950CE9B
            CDCB82667BA471038EB8E24871FACEE09098AA4E38B487A1CFE686C6F4590568
            EAFEA9594F6F1839C68FEABC8B93F6C88BF22D39B89E51C07613554168B6A7B0
            519F1EC4A93CC409BD231361D5CED74C3134B8CAEECEB5FA64DA3AD6AAABB4C7
            00F173511BA1FD03B29EDE306E4CCD8F5B91F935EEE0D67CD171DC9BC38A8E91
            A18C29CBBA56CF998F382DC04CB4EB81F55408BB4E3BFD8CB32E7D47460DCF3E
            E9C46C2D2D5DB1EF6DE73DE549D75F7F7DC69B68FB9C5E9DE80158A7DDBB7767
            0B601D2EBFFCF273CE3927831E62FC1BDFF4B653CF7A52A696965E79EDD7B2D5
            B0EF8273B7E3770F06EFB9A4ED73451E6F08650000008B683B9607E542BCCAD4
            36A036000060E16DF75F2E028085E1978B8099B8FCF2CBB3D55BFF5F2E521E00
            DBD7AE81D2581D8824CC2FE50130131BFADD831997079B7CE22BBBE4540BDB81
            1FC6C5E6F8CE84871198951DF7D5E4FE3EF6B18F650BD8527E18179BE33B131E
            46602ECC7779000000CC90F200000048CA030000206D607910FFE44891F1B499
            62281C29C60C56FDA67199B5151ADA9962641280F93274322F61C87854A6CA8E
            CEC119F79B1060FBDBA8F2A09C16E31F222CE214395D2692D1E823D66D366A3B
            44A639E7C8F927DA2800DBD3D0C9BC84F962D0F9BA13FA0CEE9301982FDBFD97
            8BE23C9BC166D9928D02305B4EE60053D8EEE5C14CCEECE515A28A4C7D53A72C
            DB9BF07202B0009CCC01A6B023BE9A5C5E21AA4C01B0F3945781C13B456BC665
            AA8E2E8005B623CA0300086B6F140D643C2A536587B796809D64E79607E574BF
            CBAFA502EC24EDCF013A3E19F0A101B0336D54791017DF212EC1A7CBCC44CE38
            902900769E9EAF3BA53DB26BBA0CC07CD9C04F0FCA6931643C6DA6180A476A8E
            196A3745A6760D359A462601982F4327F312868C4765AAECE81C9C71BF0901B6
            3FDF3D00000092F200000EE38D7F6027531E000000497900000024E501000090
            9407000040521E0000004979000000A40D2C0FF28F4636FE5071C6EBCE8C1403
            6264352EB3B642C3C84CC818803994A7F2C6C93CE3CE4C951D13AE9EF1A80901
            B6BF8D2A0FCA6931FE666411A7C85965BAC5C866A3B643649A53B5A79D74A300
            6C43ED93799F4CD567709F0CC07CD9EEBF5C544EAFD9DA445BB2510066CBC91C
            600A3BE2BB07BB1A2253DFD4294BAF1F000010E6A63C58CF757C59B1CA543F8A
            078005504FE66559DA21BADA99AAA30B6081CD4779504ECD9B7F99BE251B0560
            B6864EE6A51D321E95A9B2C36B01B093CC4179B04197E965CE8E99D506000B60
            E8645EC26C1DD2CE541D5D000B6CA3CA83B8F80E716A9E2E531AB10CA53D855C
            7920539D62588C2F2209C07C8913789CC98BD2EEF3BA5394F6C8AEE93200F365
            033F3D28A7C590F154990C0E89E448CDDEA17653646AD75023AC8D6BC82C0073
            254FE2870C25232C321E75B6CF8ECEC119F79B1060FB9B9BAF260300001B4D79
            000087F1C63FB093290F000080A43C00000092F200000048CA03000020290F00
            0080A43C000000D2069607F947231B7F7538E37567468A0131B21A97595BA161
            6426640CC01CCA5379E3649E7167A6CA8E0957CF78D48400DBDF469507E5B418
            7F33B28853E4AC32DD6264B351DB2132CDA9DAD34EBA5100B6A1F6C9BC4FA6EA
            33B84F0660BE6CF75F2E2AA7D76C6DA22DD92800B3E5640E3085F9F8EEC1AE81
            A94FF4B17A884C7D53A72CC74D3B183EFD4601D80E9CCC0126321FE54139AD17
            E5FC9EF18462F590A91E62FCD41B05603B689ECCA3116A6FC6ADB37D4717C002
            9B8FF200006662AD5618C87854A6CA0E9F3C003BC9762F0F36EE3D9B72BA2F93
            8F3CE97BA3086001B44FE67D3295D7026067DAA8F2202EBE435C82CF2A33855C
            7F20539D66B25100B656FB64DE275394F6C8AEE93200F365033F3D28A7C590F1
            EC322335070CB59B2253BB861AD5DAD0818C019843792A6F9CCC33EECC54D931
            E1EA198F9A1060FBF3DD03000020290F00E030DEF8077632E501000090940700
            0040521E000000497900000024E5010000909407000040DAC0F220FF6864E30F
            15673C6126B4334362C060D56F1A97595BA1A19D09E3F200CC91E6C9BCB443C6
            A33255764CB87AC6A32604D8FE36AA3C28A7C5F89B91459C22A7CB8466BB5BAC
            DB6CD476884C9FC9FB6F14806D6BE8849F2F06477ADD29FA0CEE9301982F73F0
            CB4571AACD60B36CC94601982D27738049ED88EF1E9497872A32F54D9DB2F4CA
            01000061BB970733B97C2F335499EAA466005800ED9379094B328CCB541D5D00
            0B6C3E7EB9284ECD9B7982DE928D02305BED9379B9E80F1116198F7A57283BBC
            6104EC24DBBD3CC813F3E0D41CCB5929B395578B9173AE6D6F20DA910460BEC4
            99BC887659D622A16A67AA8E2E8005B651E541391197136BA8A7E68C27C9CC44
            CE38902900769E9EAF3BA53DB26BBA0CC07CD9C04F0FCA6931643C6D26B43343
            9A0386DA4D91A95D438D21E3F200CC91E6C9BCB443C6A33255764CB87AC6A326
            04D8FEE6E0BB070000C0E6501E00C061BCF10FEC64CA03000020290F000080A4
            3C00000092F200000048D39407C71F7F7CB60000800532E5A7072A040000583C
            D3FF72D1112B84FCA3918D3F549CF1B4992253A3446F0CABC665D656681899A9
            3205C0BCC9F3F8C05026C222E35167FBECE81C9C71BF0901B6BF757DF7A0A342
            28A7C5F89B91459C22A7CB844CF5F887A8EBB0DAA8ED1099E6E4CD7653AEE05F
            BF069867792A1F9CCCDBAF32ED4CD567709F0CC07C59EF579337FAB78CE23C9B
            C166D9928D02305B4EE60053586F79506C428510329E5CAE3F1099FAA64E598E
            7CF1188C5D93310073284FE54EE600BDCDA03CB8EEBAEBB2B501CAB57B35F5F9
            3DD71FC854A71C3AE04505604EE5797C204EE6D108754CC6ADB37D4717C0025B
            6F79B0A1B50100CCD65AAD3090F1A84C951D7E4309D849D6551E6C426DB071EF
            D994D37D997CE449DF1B45000BA07D32EF93A9BC16003BD3F4E541776D1017DF
            212EC167959942AE3F90A94E33D928005BAB7D32EF93294A7B64D7741980F932
            6579D0E77383725A0C19CF2E335273C050BB2932B56BA851AD0D1DC818803994
            A7F2C6C93CE3CE4C951D13AE9EF1A80901B6BF69CA03DF3700008085B4DEAF26
            03C082F1C63FB093290F000080344179B0BB871CBA591EFBD8C7660BD8527E18
            179BE33B131E46602EF8F400000048CA03000020290F000080A43C00000092F2
            00000048CA03000020290F000080A43C00000092F200000048CA03000020290F
            000080A43C00000092F200000048CA03000020290F000080A43C00000092F200
            000048CA03000020290F000080A43C00000092F200000048CA03000020290F00
            0080A43C00000092F200000048CA03000020290F000080A43C00000092F20000
            0048CA03000020290F000080A43C00000092F200000048CA03000020290F0000
            80A43C00000092F200000048CA03000020290F000080A43C00000092F2000000
            48CA03000020290F000080A43C00000092F200000048CA03000020290F000080
            A43C00000092F200000048CA03000020290F000080A43C00000092F200000048
            CA03000020290F000080A43C00000092F200000048CA03000020290F000080A4
            3C00000092F200000048CA03000020290F000080A43C00000092F200000048CA
            03000020290F000080A43C00000092F200000048CA03000020290F000080A43C
            00000092F200000048CA03000020290F000080A43C00000092F200000048CA03
            000020290F000080A43C00000092F200000048CA03000020290F000080A43C00
            000092F200000048CA03000020290F000080A43C00000092F200000048CA0300
            0020290F000080A43C00000092F200000048CA03000020290F000080A43C0000
            0092F200000048BB4E3BFD8CB32E7D47460DCF3EE9C46C2D2D5DB1EF6DE73DE5
            49190000005BE7F5AF7F7DB67A7BEA539FFAC637BDEDD4B3BE7949FFCA6BBF96
            AD867D179CEBD303000098338F9E44AED38FF200000048CA03000020290F0000
            80A43C00000092F200000048CA03000020290F000080A43C00000092F2000000
            48CA03000020290F000080A43C00000092F200000048CA03000020290F000080
            A43C00000092F200000048CA03000020290F000080A43C00000092F200000048
            CA03000020290F000080A43C00000092F200000048CA03000020290F000080A4
            3C00000092F200000048CA03000020290F000080A43C00000092F200000048CA
            03000020290F000080A43C00000092F200000048CA03000020290F000080A43C
            00000092F200000048CA03000020290F000080A43C00000092F200000048CA03
            000020290F000080A43C00000092F200000048CA03000020290F000080A43C00
            000092F200000048CA03000020290F000080A43C00000092F200000048CA0300
            0020290F000080A43C00000092F200000048CA03000020290F000080A43C0000
            0092F200000048CA03000020290F000080A43C00000092F200000048CA030000
            20290F000080A43C00000092F200000048CA03000020290F000080A43C000000
            92F200000048CA03000020290F000080A43C00000092F200000048CA03000020
            290F000080A43C00000092F200000048CA03000020290F000080A43C00000092
            F200000048CA03000020290F000080A43C00000092F200000048CA0300002029
            0F000080A43C00000092F200000048CA03000020290F000080A43C00000092F2
            00000048CA03000020290F000080A43C00000092F200000048CA03000020290F
            000080A43C00000092F200000048CA0300009863178F927D93531E0000004979
            00000073ECC251B26F72CA0300009863F9EB4487CBBEC9290F000080A43C0000
            803996BF4E74B8EC9B9CF2000000E658FE3AD1E1B26F72CA03000020290F0000
            608EE5AF131D2EFB26A73C00000092F200000048CA03000020290F000080A43C
            00000092F200000048CA03000020290F000080A43C00000092F200000048CA03
            000020290F000080A43C00000092F200000048CA03000020290F000080A43C00
            000092F200000048CA03000020290F000080A43C00000092F200000048CA0300
            0020290F000080A43C00000092F200000048CA03000020290F000080A43C0000
            0092F200000048CA03000020290F000080A43C00000092F200000048CA030000
            20290F000080A43C00000092F200000048CA03000020290F000080A43C000000
            92F200000048CA03000020290F000080A43C00000092F200000048CA03000020
            290F000080A43C00000092F200000048CA03000020290F000080A43C00000092
            F200000048CA03000020290F000080A43C00000092F200000048CA0300002029
            0F000080A43C00000092F200000048CA03000020290F000080A43C00000092F2
            00000048CA03000020290F000080A43C00000092F200000048CA03000020290F
            000080A43C00000092F200000048CA03000020290F000080A43C00000092F200
            000048CA03000020290F000080A43C00000092F200000048CA03000020290F00
            0080A43C00000092F200000048CA03000020290F000080A43C00000092F20000
            0048CA03000020290F000080A43C00000092F200000048CA03000020290F0000
            80A43C00000092F200000048CA03000020290F000080A43C00000092F2000000
            48CA03000020290F000080A43C00000092F200000048CA03000020290F000080
            A43C000000D2AED34E3FE3AC4BDF9151C3B34F3A315B4B4B57EC7BDB794F7952
            060000C0D679FDEB5F9FADDE9EFAD4A7BEF14D6F3BF5AC6F5ED2BFF2DAAF65AB
            61DF05E7FAF4000000E6C9C993CB357BF0E9010000CC93CB2FBFFC9C73CEC9A0
            8718EFD30300006032CA03000020290F000080A43C00000092F2000000E6D89E
            3D7BB275483BD39FF2000000E65BB31E584F6D50280F0000608EEDDDBBB72CA3
            2A886564A6A33C000080F9D6AC10D6531B14CA030000987B5115ACB336289407
            0000B008D65F1B14CA03000020290F000080A43C00000092F200000048BB4E3B
            FD8CB32E7D47460DCF3EE9C46C2D2D5DB1EF6DE73DE549190000005BE7F2CB2F
            CF566FE79C73CE1BDFF4B653CFFAE625FD2BAFFD5AB61AF65D70AEF200000016
            DF8CCB836C010000F36966E5010000B048C69507BE9A0C000024E50100009094
            070000401AFBDD834B1EE9BB070000B0802EBBECB2BF7DE8133368E8FA6A7229
            0FCA6A190000000BE1FCF3CF9FBE3CF8C217BE9031000030FF5EFCE217779407
            BE7B00000024E501000090FAFE72D1C31F71663416C9273EF2A1B2BCEEBAEB22
            5C24C71F7F7C592EF0512B16FBDE2DF0D3B270EC16523DBE0BF608D4FB1576E0
            F11D7A0460212DE40B535B7DA9EAFEE5A209CA83273CFEB1D15E0CEF7CCFFB6A
            7970E185174672315C7CF1C5B53C58D4A3562CF6BD5BE0A765E1D82D9EE6F15D
            A447A079BFC24E3BBEED470016D2E2BD30B5355FAA7CF760365E79F127BFF295
            6F346F25937D0000B0109407BDFCC8FFF937C71E7BC2C31FFEA00307F7C7EDBE
            DF76AF9229F91C019BE8812FB87FBD650A00601694077DADAE2E97E5B77EEBBF
            885B246193454970E7EF38FA6E67DFE95E8F3BAEDC540800C00C6D97F260EFDE
            BDD93A927123FBCF309DA38EBEC331DFB2F4D5AFFE53DCEE78CCD1D9D1E99443
            325E2C438F79841B7D203641B90B4D993D927123FBCF7044A51238EAAEBBEEF1
            F83B9F70F25DEE7CE098636EBDC3BFDCBDFB09CF7AC8112B847C16CEFA7938F3
            09FB1B1C9994A91999E184EDC73C32D55032C2AA9D8C4C1599E81A322EDF6130
            E59A8C3BF51CD636B4628435591A5564FACBD5063235A189568C0D859A89C6AC
            F49C70B00B6B32EE61A2C1C0868A17B290A9968EAE0DB2389F1EECD9B3275B1B
            E34B5FBAFEAACFDE72F2C90FB9F7BD4FFD17FFE221B71F38363BC62BA7E0AB0F
            59BCD37179B296C77CF39FB29BA3DCB52A53D35AFF0C457C6870F4EEA3EE73CE
            EE7B1E77DC3F5D7EF3573F7AF397F65DFFC977FED347FFFA9AA73CF33B3A2A84
            457D1EC6D12966FB242C13666B16CA639EAD43E2408412761C9D92C956438C0C
            11467E9D36E749125BE99E3FF6A19868379AFB5F6CDC5D68CA8D6DD6E6466ADE
            F12DDC0D603A7129558D7B392B5DD9DA2CDBAB3C288F4B95A94632E3816618ED
            F67256CE3BEFBCB2FCC7FF79875FB8E8C3AF78C5275EFEB20FFFBF2FFEEF3FFF
            F31FFA87AB0FC48091E2AC9DC1E08524CEDDCD6534420DA3513493A18675B9DD
            0C3DFEA5116A5897D10835ACCBEDA6B957CD1D0E11866618EDF6723A273DEAAE
            A7FEE0B79E7C8FBB7FFEBF7DFD8A175D79E54B3F77E5CBAEFAD42F5EF9810B3E
            FA576FB8E2879EFEB0911542799E0C3D0FA3B1F67C1A180A8BC8141977664266
            1BB3D5E5662A0F6FC8787C261A75198632A511222C326E0CA8CBADD27CCC4384
            6128136191F12125D3E749520C85331113764C3BD8E69A1AD6E5387117EAC8E6
            E0088B8C5B03D62F262C86C2223245C6A3B6DBCE47A6C8F8909299E2A7BBB98C
            4688B0C8B8910136472D03062F356B6A38B4DC68DBEED38341F9B4A63E0A19F7
            7E8F3056C9607D7EFCC77FBCD406BFF7BB9794F6EACA31471F7DF3D7BE76E5F5
            D77DF8A77EE61E673E72F77BDFFBFE18D653F3DC5D5FBD4A238C3B178F1C5367
            D86EE2918FE5C863578F4E77EF962B7B5295B0EE6459C61E462344D711D575A7
            F0D9975F75EDDFDD78DF93EE79DF934E78C0779E3854097CE2A2CFBCF38F3FFD
            E0B3EFD5F11942D3C82755C68D3A36E3F19930321FC9686F8EF611E9C844D8A1
            63DDA2AE1EC968F7541E9910613C68A1CF2396431B8F7F51C2B5477FA076D564
            64468EE9D01E5F337D56EFAF4C58976DEDDDA8C96887E8AD03AA1819BDCDB018
            CA44B87EED4D14198FDF8DAA76D57CC7E091468ECF789029CBC894657BF0C8D5
            810D122F28F53525C42B4B18D995C1469AA75F2EEAF988CCF081BBE1861B3EF2
            918F9CFE9D6B7F2963D7D2EA5147DDF6A92BBE74AF934E79CCA3CFBCC73D8E59
            5EDE5FF2FFE6DF3CB9DC06C3C72A27D9106139EDD6467634BAA25D9631AC3DA6
            A8336C95FA046D3F779B4A57C8B8717462C510996286C76E9DCA9E54355376B5
            864D23936D3D8775B8FFC9F7FCEAE76FFCF4DF7D25E3864FFEE2959FFDFBAF65
            7024239F541DEAF32DD7397CADAD7A8AC693A7A80F6CC6879E5171C8221C7AF0
            8F782CDAEBD64C3118B2E688F3B495472644581EB48C0FFDEC77CBA1E31FDEDA
            3534A6848343B426539D3AC6776CBD439927568C9923D936D8E09AE6E010038A
            913B50927570A6468D8C0145C687B4471E514E74685743DD8722535369CE99D3
            AD6FC291DA7B5B33D18E24B071CAEB487D7DA999088BC854A52B5B1B6C71BE7B
            B041969797979656CF7FC6436FBEE5B6FFF5B5EBBEFBEC3B9C73CE09FFE3E31F
            BFE69A6B96578EBAD39D961FFFB8731FF33D8F7BC94B5E9A2B8C524EB223CFB3
            E5141C5D45A65AFA8CD912F9CC6D3D779B06CFF994A943CA8AD9B159CFF579F7
            D9975FB5F7F997BFEB4FAF2C8D72CB6CC3675EF2D991F9B6A99F54B9CE40A6B6
            EE299ACF9EC6F327E38166A6FB593ACED0BAF3FE8C9DF4306DC4612D73868C47
            C94D1EDA68199C71BFDD88911D9B88012153D3CA590E9F67D21DEE23A71BC8D4
            8C8CDCDB08BB0F13305BF1E212AF38DBE1E5669ECA8391AFF123933374CB0D37
            7EF5CBD73EFDC71EFEBCE7DEFB279FF99D673EF2F8F7BDF7CFFEE37FFCA5AB3E
            F75F9FB3E7D4FF67CF839FF18C7FFFC25FF8F99FFFF9E7FFC44F5C90EB0C0C9D
            5EE32C9C414B7364ACD81EBC7D4ED6CD276E38E251E818B0D1477056E25E8FDC
            DBFEC9751A571874683F0FB335D0F349D51E3672C59EB36D8278F0EB21681FB8
            F6D11937A0CFBADBCA118F427BC0A44F92236EA2ADAC52B6D234E924DDE3C7F5
            76AC35D435E9FE1CD13A271CB9FA5072E8615CCF16EBBAB531C5310226D5FD82
            B2852F37DBBD3C88D7E650DA996DE49BC98D70D91FFCC175D7DDF0C57FF8C213
            FFF7533E77D5BB3E75C5E7CE3EFBD12F7DD9CB5FFE2B2F7CE6B3BEE7D4871DFF
            F9AB3EFB6BAFFBD5A7FFE9D372858638BD86D2CE6C431D30B237F419B3DD94E3
            5296E38E5DD8B423389DD8B71061EC67EC766D84E65DA8F966729D1E78F81F41
            FBC3534EE9BEC55A557D0A15F12CEAF3A4EA58AB68AE58F3CDE4E66B1F918E4C
            842333A1E68BE81A37729DC63DAA13E933491D3372407B86F6F876A62861B6D6
            67DC3C2337DA5687853A7868F5E6B0A14C84EBD767C23AA6181AD65EBD6370D1
            EEED1E5F95DEB2AC83EBC89EAB035378E31BDF98AD439AAF35C586BEDC4C64D7
            69A79F71D6A5EFC8A8E192479E78D965977DE10B5F88F0E18F38F3098F7F6CB4
            17C33BDFF3BE4F7CE443A571DD75D75D78E185916C3BEFBCF37EF7924B0FDCBE
            FCD18F7EECE39FF8D80B5FF8C29B6EBDF1139FF8E417BFF8C50F7CE0031FFFF8
            C7970F2EDFE721F759BDDBEA315FBBE3EFFCCEA5B9DA96BAF8E28B8F3FFEF8D2
            58E0A3562CF6BD6B3E2D4B55F0D32FF9DEAF5C77FD9FFFC6C73FFBF2AB4A01F0
            826FDBB5EB5B8E5E3A7EF75127DF67D7434F5B3AFB0796BEEFDF2E1D73E732F8
            25BB76FDE8B67C51AF4FCB623B1CBBD99E79471EBBF55F60CDD1255AF3F8769F
            5437CD4C1EBDE6FD0ADBE4DE6D9AF623000B69735E988E3DF6D89B6FBE39834D
            D77CA97AF18B5F5CAEF3FFF6A14F8CB069DF05E76E974F0FA24ECA603B29A5DE
            339E75C11FFDF11F5D75F5E78E3EFAE8D7FCD66FBFFAD5AF7EDDEB5EF7CA57BE
            F24D6F7A5379EDF9CA57BF72D6A9677FF7C9DF9D2B1CB2F6DECB28D93DCFE260
            B565F7FCCBFBD3901D5BE79AAFFFF317BEF2F50C96966E5B595A5D2DB7D59595
            F2DFEAD2F2C1A58307B3EF70F9B43B5CF6CDB33C300DD9B1CDACE7D15E8C2305
            4035541BE40BD8E1B26F4BF9F4A0D75B41E79D77DEE31EF3B85B6FBBEDEE279C
            F0176F7EE3EEDDBBEF7297BB7CF9CB5F3EE79C73F6EDDB1763DA9F196D159F1E
            CCA98E4F0FA251C4A707198CE1D383CD37EED8ED1CDBF0D38399F0E9814F0FD8
            2116EF85A96DFE3E3DD8E6CAA5FF7BDFFFDEA38FB9CBC1E5E5273DE95F3DF189
            4FFCC637BE71E73BDFB9D406A52BE45098B5F84672DC4A58AEFEBB6FB11600C0
            1426F8F4201A8BA47E7A10E111BDEF7DEFCBD6D2D2631FBBAD4BCCFAE941848B
            A4F9E941341649F31DE8682C92E6A707D158248B7DECFA687E7A108DC5D0FEF4
            205B3B864F0FD80916F285A9ADE7A7077DCB0300006001F8E5220000A017E501
            000090BA7EB9285B0000C00299E6BB078FFED4DBB30500002C9669BE9A9C2D00
            00E6C765975D76FEF9E76700A34CFF2F17650000C03C28854194072EE418279E
            1E5396074F7EF29333060060DBDBBD7B772D0F5CC831523C49FCC3A60000C011
            280F000098A549FFD876191F32EE14C3627C155D9B6CABB6BBD194070000CC4C
            B968BEEEBAEB32E821C687892EB8739D814C310BCA0300006623AEEF3B965509
            23D3BCB8AFED185344580C8523C598A286CD6535E85C93F154990C062253D4B0
            2EA311222C323E7C92ED43790000C06CC4F57DF32ABFDD2ECBA2E3E238468618
            5633CDB54A3BD430C61443C968475711BDEDF11365221C39A62647F68E1CBFAD
            280F0000D810E50A385B87B7BBC57573C8D4214313868C47E9EECD6D8CBA46AF
            2BE688CE3D696BF6E6FA8766285D35EC9E64AB280F0000D846CAA573B96E0E99
            DA18B98D814CB564F740A626942B0F343351216C43CA030000B6C6D055F2D015
            73FB027A832EA9FB6CE888FB7644B14A5D71DB5608CA030000B64C5C2587D26E
            66221C9969AB638A8E61557BFC449908478E696AF7768FDF0E94070000CC4CBD
            E46D5EFBB69343BD21E34399688CCCC472C860C89A1A46A318D95E1B3A106191
            718F4C349A99A286D108D155643C2AB3AD280F000080B4EBB4D3CF38EBD27764
            D470C9234FCC160000F3E3B2CB2E3BFFFCF3338051CA93E46F1FFAC40C1AF65D
            70EED8F2E0D19F7A7BB6000080C532597970E79B6E28B70C000080C572EB7177
            2BB70C0EE9FAF4000000D8514A79E0ABC9000040521E000000497900000024E5
            0100009094070000405AFB978BB2090000EC644B4BFF3F93E2DF425F4A355600
            00000049454E44AE426082}
          Stretched = False
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo4: TfrxMemoView
          Left = 361.937230000000000000
          Top = 91.590600000000000000
          Width = 532.913730000000000000
          Height = 45.354360000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Consolas'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo do Item'
            'Pre'#231'o do Produto. *Utilizar '#39','#39'(v'#237'rgula) como separador decimal.')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 4.779530000000000000
          Top = 495.236550000000000000
          Width = 1065.827460000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Figura 1 - Aba Produtos/Pre'#231'os no Cadastro do Fornecedor')
          ParentFont = False
        end
        object Picture2: TfrxPictureView
          Left = 31.118120000000000000
          Top = 47.236240000000000000
          Width = 211.653680000000000000
          Height = 132.283550000000000000
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D49484452000000A3
            000000830806000000E1C0ABB6000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
            00090D49444154785EED9D098E14B91286B9CADC05BD0BCDB11020C42EC426C4
            2EC422F67DEBA6A19B6E210E90F3A248A320261CE974D991AEF1FF4921A51DCE
            743AF2930BA82AEAD0B973E786BFFEFEDF00C0D2B8CAF8F0E1C3E1C3870FDD06
            ADBF670E0E0EC6231D5719EFDFBFAF3EA45E82D6DF33FBFBFBE3918EAB8CF7EE
            DD531F522F41EBEF99BDBDBDF148C755C6BB77EFAA0FA997A0F5F7CCEEEEEE78
            A473E8FF5493F1E7CF9FE3D12F6EDFBEAD3E248FA03586D0F21E41EBEF99AF5F
            BF8E473AD5764612F1DDBB7763EB17376FDE541F9247B42023AD7F090E1F3EFC
            472CC5CECECE78A45365670C224A19AF5FBFAE3EA4DAC1255C52485AFF124801
            9712727B7B7B3CD229BE337211A58CD7AE5D531F52ED6845465AFF12B422E3D6
            D6D678A453544629A294F1EAD5ABEA43AA1DADC848EB5F825664FCF4E9D378A4
            53EC655A1351CA78F9F265F521D50C295F68F33EAFA0F52F01C9C763293E7EFC
            381EE914D919632252702E5EBCA83EA49AC1E593A18DAF19B4FE2590022E2524
            D5C0626D192D112938172E5CF8D703AA1D52401EDAF89A41EB5F825664943E48
            D692714A440ACEF9F3E7D587542B62E2C5FA6B07AD7F095A91F1EDDBB7E391CE
            A1A3478FAE1ECA5C5244A4E09C3D7B567D48B5C2126E091969FD4B40F2F1588A
            D7AF5F8F473A593B63AA88149CD3A74FAB0FA997A0F5F7CCAB57AFC6239DD932
            CE11918273F2E449F521F512B4FE9E79F1E2C578A453E46FD3A99C3871427D48
            BD04ADBF679E3F7F3E1EE9B8CA78FCF871F521F512B4FE9E79FAF4E978A4E326
            23CD81F815BDF2E4C993F148E7B78C8F1F3F1E1E3D7A343C78F060F58964FA20
            287DFEEECE9D3BC3AD5BB7861B376EACDEE8A7F757E96DAD2B57AE0C972E5D5A
            FD432EFDFB19FDB3055DEBCC9933C3A953A7567F3EA29725DA0D8E1D3BF6AF07
            D2731C397204A1C46F19B5979592111E44CFF45E03DAF02C20A3239011323603
            64848CCD001921633340C64A3286C26A392D7A7F1044EF35282E632868086D8C
            1661BC37F4E1E110929A390D8F1A58F3879C96B772126BAC95EB5A465910DEAE
            99936302B56B60CD2FFB78DBCA49D6B94ED72FD3B985CBCD05B43EC2AB0629F7
            C4DB564EB2CE7526650C9F67D404B2221456CB69E1F52038B985CBCD05B43EC2
            AB0629F7C4DB564EB2CE75B03332520B979B0B687D84570D62F3533F0F8E9593
            C4C6CAF3641B3232520B979B0B687D84570D62F373AC3129E707F858799E6C43
            46466AE1727301AD8FF0AA416C7E8E3526E5FC001F2BCF936DC8C8482D5C6E2E
            A0F5115E3588CD1FB0F229EB0B4C8D95EDAE6524A8202124A573BC5FCBD7AE81
            35BFD61798CA71ACB18495AF26E3DC584AC696D8C41AC4A4CB0132826C4A8A48
            40C606086BE7D12390B101C2DA79F448B28C3410DF81291F84D64FF546FC19BF
            65AC8D7C18BD446CED3D42C259B8C948D037C07A448AE855EFD6808C0D31F530
            FEEB40C686808C90B11920E3848CB9FF3F630E9011325A64ED8CB9FFF1E41232
            5AEF957AE73C64B4E6CFCD49ACB156AEB88C52C039427ACB280BC2DBDE39A2B6
            8CB9F766E524EB5CA7CACEC8818C7FB63932E7B1337252EFDBCA49D6B90E6464
            A4162E37279139C85851C6D6FFCC985BB8DC1C47EBF794519B9FFA7870AC9C24
            36569E27DBD5649C2B22011997959163E5A7CEE5F0B1F23CD9AE22638E88442F
            326A7D84978CB1F939D69894F3037CAC3C4FB68BCB982B22D1838CB2CDF190D1
            9A3F608D99B39EA9B1B25D454619A978CB48504142484AE778BF96AF2DA335BF
            D61798CA71ACB184952F2EE33A2C21634B78EC8CA589499703646C884D93B1A4
            8804646C884DDC194B02191B023226CAF8E3C78FE1E0E060D8DFDF1FBE7FFF3E
            ECEDED0DBBBBBBC3B76FDF869D9D9DE1CB972FC3F6F6F6B0B5B5357CFEFC79F5
            13FFF445ABF7EFDFAF7E23907EBEF5CD9B37AB5FCE7CF9F2E5EA77E2E8E7B99E
            3D7BB6FA6524FA411A92916E0881D0023BA32354F09E995A3F3ECFE808644C7C
            99F6003242460BC8E80864848CCD001921633340C60A32E6BC2F4D2C21A3F55E
            A977CE43466BFEDC9CC41A6BE58ACB28056CF98312B220BCED9D236ACB987B6F
            564EB2CE75AAEC8C1CC8F8679B23731E3B2327F5BEAD9C649DEB4046466AE172
            731299838C1564240143CCA10719A91D42E221A3353FCFC9BC9593C4C6CAF364
            1B3B2323B570B93989CC2DB9334A7273123E569E27DB9091915AB8DC9C44E620
            636119A57C90312D47D496716AFE40AC9F48BD06313556B6ABC8C8630EDE3212
            54901012EF9CC7CE189B3FD64F4CE538D658C2CA1797711D9690B1253C642C4D
            4CBA1C2063436C9A8C2545242665C4E719FDD8C49DB124D8191B023226CA88EF
            C020960EEC8C8E50C17B666AFD90D111C808199B013242C666808C90B1192023
            646C06C8585146BC371D7F8742CB7BCAA8CD1FFA643F61E524D6582B574DC64D
            F8A0842C086FD7C805429FCC79C9A8CD2FEF25352759E73A9091915AB8DC5C20
            F4C91C64AC2063901032CE1BEB21636CFE39F729DB9C75AE535C462E20649C37
            764919096AF3E05839496CAC3C4FB68BCA48F241C6BC1C515BC6A9F939B93909
            1F3B357F151965A4D2838C5A043C64D44223D64F5839091F2BCF93EDA2324AE6
            8848F4F2179880CCD5965112BBB739F7BCCE58D9EE5A46820A12425223C791F9
            2565B4EE792AC7B1C61256BEAA8C735942C696F096B10431E972808C0DB16932
            961491808C0DB1893B634920634340C64419F11D18C4D2819DD1112A78CF4CAD
            1F323A02192163334046C8D80C901132360364848CCD00190BCBC83FAD132295
            2564B4DE2B2D9DE3FD5ABEB68C53F3C7FA092B27B1C65AB92A32E6E22DA32C08
            6F7BE4241E32C69873DFB5AE031919A9852B959340C60A32F298430F32F29078
            C8189BDF6A4F8DE5AC739DE23272E60AF95F97512273B5659468F7CA8363E524
            B1B1F23CD9AE2A230119FF6C73646E691939B939091F2BCF936DC8C8482D5C6E
            4E227390B1B08C5C3EBC4CA7E788DA324ECD1F88F513A9D720A6C6CA76151979
            CCC15B46820A1242E29DF3D81963F3C7FA89A91CC71A4B58F9E232AEC31232B6
            84878CA589499703646C884D93B1A48804646C884DDC194B02191B023226CA88
            EFC020960EEC8C8E50C17B666AFD90D111C808199B013242C666808C90B11920
            23646C06C85849C69CF7A7212364B4C89271EE0724029011325ACC9631574402
            3242468B2C1979CC013242C638C3F00F3E4331ADDD9300100000000049454E44
            AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
end
