inherited frmFatDadosCliConsumidor: TfrmFatDadosCliConsumidor
  Left = 339
  Top = 264
  Width = 491
  Height = 431
  BorderIcons = [biSystemMenu]
  Caption = 'Dados referentes ao Cliente - Consumidor'
  Position = poMainFormCenter
  ExplicitWidth = 491
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 360
    Width = 485
    Color = 16770261
    ExplicitTop = 315
    ExplicitWidth = 485
    DesignSize = (
      485
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 481
      ExplicitWidth = 481
    end
    inherited btnSair: TBitBtnLocked
      Left = 412
      ExplicitLeft = 412
    end
  end
  inherited pnlStatus: TPanel
    Top = 386
    Width = 485
    Color = 16770261
    ExplicitTop = 341
    ExplicitWidth = 485
    inherited pnlNomeForm: TPanel
      Left = 282
      Width = 203
      ExplicitLeft = 282
      ExplicitWidth = 203
    end
    inherited pnlInfo: TPanel
      Width = 282
      ExplicitWidth = 282
    end
  end
  inherited pgcDados: TPageControl
    Width = 485
    Height = 360
    Visible = False
    ExplicitWidth = 485
    ExplicitHeight = 315
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 477
      ExplicitHeight = 283
    end
  end
  object pnlDadosCons: TPanel [3]
    Left = 0
    Top = 0
    Width = 485
    Height = 360
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 315
    object pnlDadosSuperior: TPanel
      Left = 1
      Top = 1
      Width = 483
      Height = 102
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 65
        Top = 36
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label2: TLabel
        Left = 46
        Top = 82
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
      end
      object LabelCgcCpf1: TLabelCgcCpf
        Left = 25
        Top = 13
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = '1-CNPJ/2-CPF:'
        Pais = opcBrasil
      end
      object Label6: TLabel
        Left = 73
        Top = 61
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CEP:'
      end
      object Label4: TLabel
        Left = 162
        Top = 61
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
      end
      object Label7: TLabel
        Left = 391
        Top = 61
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Estado:'
      end
      object edtNomCli: TEditFocus
        Tag = 99
        Left = 97
        Top = 33
        Width = 362
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 40
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEndere: TEditFocus
        Tag = 99
        Left = 97
        Top = 79
        Width = 362
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object Panel1: TPanel
        Left = 97
        Top = 9
        Width = 369
        Height = 22
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object edtCgcCpf: TEditTipoCgcCpf
          Tag = 99
          Left = 0
          Top = 0
          Width = 38
          Height = 22
          Align = alLeft
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          OnChange = edtCgcCpfChange
          OnKeyPress = edtCgcCpfKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object mskNumCgc: TMaskEditC_G_C_
          Tag = 99
          Left = 38
          Top = 0
          Width = 117
          Height = 22
          Align = alLeft
          CharCase = ecUpperCase
          EditMask = '999.999.999-99;0;'
          MaxLength = 14
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = ''
          OnExit = mskNumCgcExit
          OnKeyPress = mskNumCgcKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnConsultaFit: TBitBtnLocked
          Left = 157
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
          OnClick = btnConsultaFitClick
        end
      end
      object mskNumCep: TMaskEditFocus
        Tag = 99
        Left = 97
        Top = 56
        Width = 61
        Height = 22
        EditMask = '99999-999;0;_'
        MaxLength = 9
        TabOrder = 2
        Text = ''
        OnKeyPress = mskNumCepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodCid: TEditFocus
        Tag = 99
        Left = 202
        Top = 56
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 3
        OnKeyPress = edtCodCidKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomCid: TEditFocus
        Left = 240
        Top = 56
        Width = 145
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtEstado: TEditFocus
        Left = 430
        Top = 56
        Width = 29
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    end
    object pnlEndNumCom: TPanel
      Left = 1
      Top = 103
      Width = 483
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object Label8: TLabel
        Left = 55
        Top = 3
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero:'
      end
      object Label9: TLabel
        Left = 163
        Top = 4
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Complemento:'
      end
      object edtEndNum: TEditFocus
        Tag = 99
        Left = 97
        Top = 0
        Width = 62
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEndCom: TEditFocus
        Tag = 99
        Left = 236
        Top = 0
        Width = 223
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDadosInferior: TPanel
      Left = 1
      Top = 125
      Width = 483
      Height = 234
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      ExplicitHeight = 189
      object pnlRegiao: TPanel
        Left = 0
        Top = 162
        Width = 483
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 140
        object lblRegiao: TLabel
          Left = 59
          Top = 3
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Regi'#227'o:'
        end
        object edtDesReg: TEditFocus
          Left = 153
          Top = 0
          Width = 306
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
        object edtCodReg: TEditFocus
          Tag = 99
          Left = 97
          Top = 0
          Width = 55
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
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlDadosInferior2: TPanel
        Left = 0
        Top = 0
        Width = 483
        Height = 162
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 63
          Top = 4
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label5: TLabel
          Left = 191
          Top = 29
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone:'
        end
        object lblIncEst: TLabel
          Left = 268
          Top = 50
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Inscri'#231#227'o Estadual:'
          Visible = False
        end
        object lblEmail_: TLabel
          Left = 64
          Top = 73
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-mail:'
        end
        object lblRG: TLabelRg
          Left = 71
          Top = 50
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'R.G.:'
          Pais = opcBrasil
        end
        object Label10: TLabel
          Left = 47
          Top = 119
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
        end
        object lblDtaNas: TLabel
          Left = 330
          Top = 29
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nascimento:'
        end
        object lblCanalAcesso: TLabel
          Left = 10
          Top = 142
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Canal de Acesso:'
        end
        object imgWpp: TImage
          Left = 6
          Top = 27
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
        object lblCelular: TLabel
          Left = 59
          Top = 29
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Celular:'
        end
        object Label11: TLabel
          Left = 55
          Top = 96
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-mail 2:'
        end
        object edtBairro: TEditFocus
          Tag = 99
          Left = 97
          Top = 1
          Width = 362
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 40
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtInsEst: TEditFocus
          Tag = 99
          Left = 362
          Top = 47
          Width = 97
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          MaxLength = 20
          TabOrder = 5
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRgCli: TEditFocus
          Left = 97
          Top = 47
          Width = 158
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 15
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEmail_: TEditFocus
          Tag = 99
          Left = 97
          Top = 70
          Width = 362
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecLowerCase
          MaxLength = 50
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskTelCon: TMaskEditTelefone
          Tag = 99
          Left = 238
          Top = 24
          Width = 86
          Height = 22
          EditMask = '!\(99\)9999-9999;0;_'
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
        object edtCodAtividade: TEditFocus
          Tag = 99
          Left = 97
          Top = 116
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 8
          OnKeyPress = edtCodAtividadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomAtividade: TEditFocus
          Left = 135
          Top = 116
          Width = 324
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object mskDtaNas: TMaskEditFocus
          Tag = 99
          Left = 397
          Top = 24
          Width = 62
          Height = 22
          EditMask = '99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 3
          Text = '  /  /    '
          OnKeyPress = mskNumCepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtDesCadCac: TEditFocus
          Left = 153
          Top = 139
          Width = 306
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
        object edtCodCac: TEditFocus
          Tag = 99
          Left = 97
          Top = 139
          Width = 55
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
          MaxLength = 5
          ParentFont = False
          TabOrder = 9
          OnKeyPress = edtCodCacKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object edtCelula: TMaskEditTelefone
          Tag = 99
          Left = 97
          Top = 24
          Width = 87
          Height = 22
          EditMask = '!\(99\)9999-9999;0;_'
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
        object edtEmail2: TEditFocus
          Tag = 99
          Left = 97
          Top = 93
          Width = 362
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecLowerCase
          MaxLength = 255
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlUtiNps: TPanel
        Left = 0
        Top = 184
        Width = 483
        Height = 18
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitTop = 162
        object lblUtiNps: TLabel
          Left = 97
          Top = 2
          Width = 165
          Height = 13
          Cursor = crHandPoint
          Caption = 'Clique aqui caso deseje Netpoints.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          Visible = False
          StyleElements = []
          OnClick = lblUtiNpsClick
        end
      end
    end
  end
  object pnlConfirma: TPanel [4]
    Left = 0
    Top = 360
    Width = 485
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 315
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
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
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 406
      Top = 2
      Width = 77
      Height = 22
      Align = alRight
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 344
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 344
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
    Left = 171
    Top = 344
  end
  object ImageSefaz: TcxImageList
    SourceDPI = 96
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 5242893
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
end
