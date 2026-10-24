inherited frmCadTransportadoras: TfrmCadTransportadoras
  Left = 180
  Top = 171
  Width = 706
  Height = 725
  Caption = 'Cadastro de Transportadoras'
  OnDestroy = FormDestroy
  ExplicitWidth = 706
  ExplicitHeight = 725
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 655
    Width = 700
    Height = 25
    ExplicitTop = 655
    ExplicitWidth = 700
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 621
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 621
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
      object btnCadClientes: TBitBtnLocked
        Left = 444
        Top = 0
        Width = 100
        Height = 20
        Caption = '[F2] Cad.Clientes'
        Enabled = False
        TabOrder = 6
        OnClick = btnCadClientesClick
      end
      object btnCadFor: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 130
        Height = 20
        Caption = '[F3] Cad. Fornecedores'
        Enabled = False
        TabOrder = 7
        OnClick = btnCadForClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 623
      Width = 75
      Height = 21
      Align = alRight
      ExplicitLeft = 623
      ExplicitWidth = 75
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 680
    Width = 700
    ExplicitTop = 680
    ExplicitWidth = 700
    inherited pnlNomeForm: TPanel
      Left = 513
      Width = 187
      ExplicitLeft = 513
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 513
      ExplicitWidth = 513
    end
  end
  inherited pgcDados: TPageControl
    Width = 700
    Height = 655
    StyleElements = [seFont, seBorder]
    ExplicitWidth = 700
    ExplicitHeight = 655
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 692
      ExplicitHeight = 623
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 692
        Height = 623
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 4
          Top = 15
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 180
          Top = 15
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data de Cadastro:'
        end
        object Label3: TLabel
          Left = 4
          Top = 63
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Raz'#227'o:'
        end
        object Label4: TLabel
          Left = 4
          Top = 132
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Endere'#231'o:'
        end
        object Label5: TLabel
          Left = 4
          Top = 155
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Bairro:'
        end
        object Label10: TLabel
          Left = 15
          Top = 178
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ins. Estadual:'
        end
        object Label11: TLabel
          Left = 4
          Top = 201
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Telefone 1:'
        end
        object Label12: TLabel
          Left = 372
          Top = 201
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telefone 2:'
        end
        object Label13: TLabel
          Left = 4
          Top = 224
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'FAX:'
        end
        object Label14: TLabel
          Left = 373
          Top = 224
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nro. Placa:'
        end
        object Label15: TLabel
          Left = 4
          Top = 247
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Contato:'
        end
        object Label16: TLabel
          Left = 4
          Top = 293
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'E-Mail:'
        end
        object Label17: TLabel
          Left = 4
          Top = 270
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Home Page:'
        end
        object Label18: TLabel
          Left = 4
          Top = 86
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fantasia:'
        end
        object Label47: TLabel
          Left = 2
          Top = 607
          Width = 688
          Height = 14
          Align = alBottom
          Alignment = taRightJustify
          Caption = '<Pressione ALT+2 - pr'#243'xima p'#225'gina>   '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 505
          ExplicitWidth = 185
        end
        object Label19: TLabel
          Left = 4
          Top = 369
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor frete:'
        end
        object LabelCgcCpf1: TLabelCgcCpf
          Left = 10
          Top = 39
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = '1-CNPJ/2-CPF:'
          Pais = opcBrasil
        end
        object Label9: TLabel
          Left = 400
          Top = 369
          Width = 185
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Ordem de Prioridade para Expedi'#231#227'o:'
        end
        object Label20: TLabel
          Left = 375
          Top = 247
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd ANTT:'
        end
        object Label21: TLabel
          Left = 1
          Top = 315
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Observa'#231#245'es:'
        end
        object lblFrete: TLabel
          Left = 49
          Top = 393
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Frete:'
        end
        object Label54: TLabel
          Left = 320
          Top = 392
          Width = 166
          Height = 49
          Alignment = taRightJustify
          Caption = 'Op'#231#227'o de Integra'#231#227'o e Imp. de Etiq. de Despacho:'
          WordWrap = True
        end
        object Label8: TLabel
          Left = 570
          Top = 108
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object Label7: TLabel
          Left = 203
          Top = 108
          Width = 41
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Cidade:'
        end
        object Label6: TLabel
          Left = 58
          Top = 108
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object dbeCodTra: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 11
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_CODTRA'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaCad: TDBEditFocus
          Left = 272
          Top = 11
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'TRA_DTACAD'
          DataSource = dtsCadTra
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomTra: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 59
          Width = 571
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_NOMTRA'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEndere: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 128
          Width = 571
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_ENDERE'
          DataSource = dtsCadTra
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
          Tag = 99
          Left = 83
          Top = 151
          Width = 571
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_BAIRRO'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumIes: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 174
          Width = 225
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_I_E_S_'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFone02: TDBEditFocus
          Tag = 99
          Left = 429
          Top = 197
          Width = 225
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_FONE02'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFone01: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 197
          Width = 246
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_FONE01'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumPla: TDBEditFocus
          Tag = 99
          Left = 429
          Top = 220
          Width = 95
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_NUMPLA'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumFax: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 220
          Width = 246
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_F_A_X_'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeContat: TDBEditFocus
          Left = 83
          Top = 243
          Width = 284
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_CONTAT'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeEmail: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 289
          Width = 571
          Height = 22
          CharCase = ecLowerCase
          DataField = 'TRA_EMAIL_'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 255
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHomPag: TDBEditFocus
          Left = 83
          Top = 266
          Width = 571
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_HOMEPA'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNomFan: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 82
          Width = 571
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_NOMFAN'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValFre: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 366
          Width = 102
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_VALFRE'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object Panel1: TPanel
          Left = 83
          Top = 34
          Width = 281
          Height = 24
          BevelOuter = bvNone
          Caption = 'Panel1'
          Color = 16770261
          ParentBackground = False
          TabOrder = 3
          object dbeCgcCpf: TDBEditTipoCgcCpf
            Tag = 99
            Left = 0
            Top = 0
            Width = 37
            Height = 24
            Align = alLeft
            DataField = 'TRA_CGCCPF'
            DataSource = dtsCadTra
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeCgcCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
            ExplicitHeight = 22
          end
          object dbeNumCgc: TDBEditCgcCpf
            Tag = 99
            Left = 37
            Top = 0
            Width = 209
            Height = 24
            Align = alLeft
            CharCase = ecUpperCase
            DataField = 'TRA_C_G_C_'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnChange = dbeNumCgcChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
            Tipo = C_G_C_
            ExplicitHeight = 22
          end
          object btnConsultaFit: TBitBtnLocked
            Left = 246
            Top = 1
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
        object dbePriExp: TDBEditFocus
          Tag = 99
          Left = 588
          Top = 366
          Width = 66
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_PRIEXP'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeC_ANTT: TDBEditFocus
          Tag = 99
          Left = 429
          Top = 243
          Width = 225
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_C_ANTT'
          DataSource = dtsCadTra
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
          Left = 83
          Top = 312
          Width = 571
          Height = 53
          DataField = 'TRA_OBSERV'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbeCodFrg: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 389
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_CODFRG'
          DataSource = dtsCadTra
          TabOrder = 23
          OnKeyPress = dbeCodFrgKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesFrg: TEditFocus
          Left = 148
          Top = 389
          Width = 181
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 26
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbchekTRA_ATIVA_: TDBCheckBox
          Left = 379
          Top = 12
          Width = 66
          Height = 17
          Caption = 'Ativa?'
          DataField = 'TRA_ATIVA_'
          DataSource = dtsCadTra
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object pnlFrenet: TPanel
          Left = 297
          Top = 499
          Width = 183
          Height = 24
          BevelOuter = bvNone
          TabOrder = 24
          Visible = False
        end
        object pnlEscCre: TPanel
          Left = 14
          Top = 523
          Width = 673
          Height = 26
          BevelOuter = bvNone
          TabOrder = 25
          Visible = False
        end
        object cbbEtiquetaDespacho: TComboBoxFocus
          Tag = 99
          Left = 488
          Top = 389
          Width = 166
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 21
          OnChange = cbbEtiquetaDespachoChange
          Items.Strings = (
            ''
            'CORREIOS'
            'MANDAE'
            'B2W'
            'JADLOG')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtEstado: TEditFocus
          Left = 613
          Top = 105
          Width = 41
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 27
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCidade: TEditFocus
          Left = 294
          Top = 105
          Width = 255
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
        object dbeNumCep: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 105
          Width = 107
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_C_E_P_'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
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
          Left = 250
          Top = 105
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_CODCID'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
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
        object pnlDataFrete: TPanel
          Left = 471
          Top = 499
          Width = 193
          Height = 24
          BevelOuter = bvNone
          TabOrder = 29
        end
        object dbcheckVeiEst: TDBCheckBox
          Left = 530
          Top = 223
          Width = 126
          Height = 17
          Caption = 'Ve'#237'culo Estrangeiro?'
          DataField = 'TRA_VEIEST'
          DataSource = dtsCadTra
          TabOrder = 30
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object tsComplemento: TTabSheet
      Caption = '&2-Complemento'
      ImageIndex = 1
      object lblTipoFretePermitido: TLabel
        Left = 366
        Top = 1
        Width = 112
        Height = 14
        Caption = 'Tipo de Frete Permitido:'
      end
      object Label48: TLabel
        Left = 19
        Top = 195
        Width = 510
        Height = 14
        Caption = 
          'Escrit'#243'rio Credenciado - CNPJ autorizado a baixar o XML das Nota' +
          's Fiscais Eletr'#244'nicas ( todas as notas ):'
      end
      object rdgFreVen: TDBRadioGroup
        Tag = 99
        Left = 19
        Top = 3
        Width = 199
        Height = 55
        Caption = 'Frete na Venda:'
        DataField = 'TRA_FREVEN'
        DataSource = dtsCadTra
        Items.Strings = (
          'Destacado no Documento'
          'Distribuido nos Produtos (Rateio)')
        TabOrder = 0
        TabStop = True
        Values.Strings = (
          'D'
          'R')
        OnClick = rdgFreVenClick
        OnEnter = rdgFreVenEnter
      end
      object cklOpcoesRateioFrete: TCheckListBox
        Left = 19
        Top = 64
        Width = 199
        Height = 106
        Hint = 'Op'#231#245'es de frete em que ser'#225' realizado o rateio'
        OnClickCheck = cklOpcoesRateioFreteClickCheck
        Enabled = False
        ItemHeight = 14
        Items.Strings = (
          'Todos os tipos de frete'
          'Emitente (CIF)                      '
          'Sem Frete        '
          'Destinat'#225'rio (FOB)                  '
          'Transporte Pr'#243'prio Remetente        '
          'Terceiros                           '
          'Transporte Pr'#243'prio Destinat'#225'rio')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object cklTipoFretePermitido: TCheckListBox
        Left = 368
        Top = 18
        Width = 199
        Height = 152
        Hint = 'Op'#231#245'es de frete em que ser'#225' realizado o rateio'
        Enabled = False
        ItemHeight = 14
        Items.Strings = (
          'Todos os tipos de frete'
          'Emitente (CIF)                      '
          'Sem Frete        '
          'Destinat'#225'rio (FOB)                  '
          'Transporte Pr'#243'prio Remetente        '
          'Terceiros                           '
          'Transporte Pr'#243'prio Destinat'#225'rio')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = cklTipoFretePermitidoClick
      end
      object dbeEscCre: TDBEditCgcCpf
        Left = 535
        Top = 192
        Width = 124
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_ESCCRE'
        DataSource = dtsCadTra
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
        Tipo = C_G_C_
      end
      object pnlComplementos1: TPanel
        Left = 4
        Top = 216
        Width = 284
        Height = 105
        BevelOuter = bvNone
        TabOrder = 4
        object pnlRealizaColetaB2W: TPanel
          Left = 0
          Top = 0
          Width = 284
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblRealizaColetaB2WEnt: TLabel
            Left = 16
            Top = 4
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Realiza coleta da B2W Entrega?'
          end
          object ColorLabel4: TColorLabel
            Left = 221
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbTRA_B2WENT: TDBEditFocus
            Tag = 99
            Left = 176
            Top = 1
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_B2WENT'
            DataSource = dtsCadTra
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlIntegracaoFusion: TPanel
          Left = 0
          Top = 25
          Width = 284
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object lblIntFus: TLabel
            Left = 78
            Top = 6
            Width = 92
            Height = 14
            Alignment = taRightJustify
            Caption = 'Integra'#231#227'o Fusion?'
          end
          object corIntFus: TColorLabel
            Left = 221
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeIntFus: TDBEditFocus
            Tag = 99
            Left = 176
            Top = 1
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_INTFUS'
            DataSource = dtsCadTra
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlExportaParaB2B: TPanel
          Left = 0
          Top = 50
          Width = 284
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object lblExpB2B: TLabel
            Left = 67
            Top = 6
            Width = 103
            Height = 14
            Alignment = taRightJustify
            Caption = 'Exporta para o B2B ?'
          end
          object corExpB2B: TColorLabel
            Left = 221
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeExpB2B: TDBEditFocus
            Tag = 99
            Left = 176
            Top = 1
            Width = 39
            Height = 22
            BevelOuter = bvNone
            CharCase = ecUpperCase
            DataField = 'TRA_EXPB2B'
            DataSource = dtsCadTra
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlObrigatorioInformarRota: TPanel
          Left = 0
          Top = 75
          Width = 284
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object lblObrigatorioInformarRota: TLabel
            Left = 34
            Top = 4
            Width = 136
            Height = 14
            Alignment = taRightJustify
            Caption = 'Obrigat'#243'rio informar a Rota?'
          end
          object clbObrigatorioInformarRota: TColorLabel
            Left = 221
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbOBGROT: TDBEditFocus
            Tag = 99
            Left = 176
            Top = 1
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_OBGROT'
            DataSource = dtsCadTra
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
      object pnlComplementos2: TPanel
        Left = 294
        Top = 216
        Width = 394
        Height = 101
        BevelOuter = bvNone
        TabOrder = 5
        object pnlUtilizaBox: TPanel
          Left = 0
          Top = 0
          Width = 394
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblUtilizaBox: TLabel
            Left = 1
            Top = 4
            Width = 278
            Height = 14
            Alignment = taRightJustify
            Caption = 'Entra no controle de Box de Entrega ENTREGA IMEDIATA?'
            WordWrap = True
          end
          object lblUtilizaBoxSN: TColorLabel
            Left = 330
            Top = 4
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
          object dbeUtilizaBox: TDBEditFocus
            Tag = 99
            Left = 285
            Top = 1
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_UTIBOX'
            DataSource = dtsCadTra
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
        object pnlControlaCanhoto: TPanel
          Left = 0
          Top = 25
          Width = 394
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object lbl15: TLabel
            Left = 100
            Top = 6
            Width = 179
            Height = 14
            Alignment = taRightJustify
            Caption = 'Controlar canhoto de notas emitidas?'
            WordWrap = True
          end
          object ColorLabel28: TColorLabel
            Left = 330
            Top = 4
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
          object dbeControlaCanhoto: TDBEditFocus
            Tag = 99
            Left = 285
            Top = 1
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_CNHREC'
            DataSource = dtsCadTra
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
        object pnlIMPDES: TPanel
          Left = 0
          Top = 50
          Width = 394
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object lblIMPDES: TLabel
            Left = 31
            Top = 0
            Width = 248
            Height = 28
            Alignment = taRightJustify
            Caption = 
              'Trazer marcado o check-box "Imprimir Etiquetas de Despacho" na E' +
              'xpedi'#231#227'o?'
            WordWrap = True
          end
          object corIMPDES: TColorLabel
            Left = 330
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeIMPDES: TDBEditFocus
            Tag = 99
            Left = 285
            Top = 1
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_IMPDES'
            DataSource = dtsCadTra
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
      object grbJaglog: TGroupBox
        Left = 19
        Top = 319
        Width = 635
        Height = 58
        Caption = 'Jadlog'
        TabOrder = 6
        object Label61: TLabel
          Left = 303
          Top = 11
          Width = 135
          Height = 14
          Caption = 'Layout de Impress'#227'o Jadlog'
        end
        object lblModJadLog: TLabel
          Left = 27
          Top = 30
          Width = 91
          Height = 14
          Caption = 'Modalidade Jadlog:'
        end
        object edtLayJad: TEditFocus
          Left = 347
          Top = 27
          Width = 264
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
        object edtCodLayJad: TDBEditFocus
          Tag = 99
          Left = 303
          Top = 27
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_JADLAY'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          OnKeyPress = edtCodLayJadKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object cbbModJadLog: TComboBoxFocus
          Tag = 99
          Left = 124
          Top = 27
          Width = 129
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            ''
            '0 - EXPRESSO'
            '3 - PACKAGE'
            '4 - RODOVI'#193'RIO'
            '5 - ECON'#212'MICO'
            '6 - DOC'
            '7 - CORPORATE'
            '9 - COM'
            '10 - INTERNACIONAL '
            '12 - CARGO'
            '14 - EMERG'#202'NCIAL')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object grpFrenet: TGroupBox
        Left = 20
        Top = 383
        Width = 637
        Height = 58
        Caption = 'Frenet'
        TabOrder = 7
        object Panel2: TPanel
          Left = 327
          Top = 16
          Width = 251
          Height = 50
          BevelOuter = bvNone
          TabOrder = 1
          object lblDataFrete: TLabel
            Left = 4
            Top = 10
            Width = 122
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'd. Transp. DataFrete:'
          end
          object DBECODDTF: TDBEditFocus
            Tag = 99
            Left = 132
            Top = 7
            Width = 65
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_CODDTF'
            DataSource = dtsCadTra
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
        object Panel3: TPanel
          Left = 16
          Top = 16
          Width = 209
          Height = 47
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          object Label57: TLabel
            Left = -12
            Top = 10
            Width = 116
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'd. Transp. Frenet:'
          end
          object edtFrenet: TDBEditFocus
            Tag = 99
            Left = 110
            Top = 7
            Width = 65
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_CODFRE'
            DataSource = dtsCadTra
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
      end
    end
    object tbsContatos: TTabSheet
      Caption = '&3 - Contatos'
      ImageIndex = 1
      object dbgContatos: TDBGridCitel
        Left = 0
        Top = 136
        Width = 692
        Height = 487
        Align = alClient
        DataSource = dtsTraCtt
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
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
            Width = 205
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TELCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Fone'
            Width = 91
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CELCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Celular'
            Width = 85
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'FAXCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Fax'
            Width = 83
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DEPCTT'
            Title.Alignment = taCenter
            Title.Caption = 'Departamento'
            Width = 140
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
            FieldName = 'NOMCID'
            Title.Caption = 'Cidade'
            Width = 129
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
          end>
      end
      object pnlContatos: TPanel
        Left = 0
        Top = 0
        Width = 692
        Height = 136
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        BorderWidth = 2
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
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
          Top = 35
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label26: TLabel
          Left = 26
          Top = 58
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object Label27: TLabel
          Left = 514
          Top = 12
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fone:'
        end
        object Label28: TLabel
          Left = 22
          Top = 81
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object Label29: TLabel
          Left = 446
          Top = 81
          Width = 25
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'UF:'
        end
        object Label30: TLabel
          Left = 27
          Top = 104
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'E-Mail:'
        end
        object Label36: TLabel
          Left = 377
          Top = 104
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Depto:'
        end
        object Label34: TLabel
          Left = 520
          Top = 35
          Width = 21
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cel.:'
        end
        object Label35: TLabel
          Left = 520
          Top = 58
          Width = 21
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fax:'
        end
        object edtNomCtt: TEditFocus
          Tag = 99
          Left = 62
          Top = 8
          Width = 445
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
          Top = 31
          Width = 445
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
          Top = 54
          Width = 445
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
          Top = 77
          Width = 335
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
          Top = 77
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 6
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
          Left = 474
          Top = 77
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
          Top = 100
          Width = 303
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecLowerCase
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
          Left = 411
          Top = 100
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
        object mskTelCtt: TMaskEditTelefone
          Tag = 99
          Left = 545
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
          Left = 545
          Top = 31
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
          Left = 545
          Top = 54
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
          Left = 546
          Top = 77
          Width = 109
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
          TabOrder = 11
          OnClick = btnAdicionarCttClick
        end
        object btnCancelaCtt: TBitBtnLocked
          Left = 546
          Top = 100
          Width = 109
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
          TabOrder = 12
          OnClick = btnCancelaCttClick
        end
      end
    end
    object tbsExportacao: TTabSheet
      Caption = '&4 - Etiqueta Despacho - Correios'
      ImageIndex = 2
      object pnlEtqDados: TPanel
        Left = 0
        Top = 235
        Width = 692
        Height = 388
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object grbObjetos: TGroupBox
          Left = 8
          Top = 6
          Width = 329
          Height = 123
          Caption = 'Configura'#231#227'o de N'#250'mero de Objeto'
          TabOrder = 0
          object Label22: TLabel
            Left = 12
            Top = 22
            Width = 66
            Height = 14
            Caption = 'N'#250'mero Inicial'
          end
          object Label23: TLabel
            Left = 116
            Top = 22
            Width = 62
            Height = 14
            Caption = 'N'#250'mero Final'
          end
          object Label31: TLabel
            Left = 220
            Top = 22
            Width = 64
            Height = 14
            Caption = 'N'#250'mero Atual'
          end
          object Label32: TLabel
            Left = 12
            Top = 70
            Width = 78
            Height = 14
            Caption = 'Sigla do Servi'#231'o'
          end
          object Label33: TLabel
            Left = 116
            Top = 70
            Width = 61
            Height = 14
            Caption = 'Sigla do Pa'#237's'
          end
          object dbeSeqIni: TDBEditFocus
            Tag = 99
            Left = 12
            Top = 38
            Width = 98
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_SEQINI'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeSeqIniExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object dbeSeqFin: TDBEditFocus
            Tag = 99
            Left = 116
            Top = 38
            Width = 98
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_SEQFIN'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object dbeSeqAtu: TDBEditFocus
            Tag = 99
            Left = 220
            Top = 38
            Width = 98
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'TRA_SEQATU'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object dbeSiglaS: TDBEditFocus
            Tag = 99
            Left = 12
            Top = 86
            Width = 98
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'TRA_SIGLAS'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfabetico
          end
          object dbeSiglaP: TDBEditFocus
            Tag = 99
            Left = 116
            Top = 86
            Width = 98
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'TRA_SIGLAP'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfabetico
          end
        end
        object grbImpressao: TGroupBox
          Left = 8
          Top = 135
          Width = 329
          Height = 110
          Caption = 'Impress'#227'o'
          TabOrder = 1
          object Label37: TLabel
            Left = 10
            Top = 20
            Width = 101
            Height = 14
            Caption = 'Layout de Impress'#227'o'
          end
          object Label38: TLabel
            Left = 10
            Top = 60
            Width = 128
            Height = 14
            Caption = 'Data/Hora '#218'ltima Altera'#231#227'o'
          end
          object edtDesLay: TEditFocus
            Left = 54
            Top = 36
            Width = 264
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object dbeLayEtq: TDBEditFocus
            Tag = 99
            Left = 10
            Top = 36
            Width = 43
            Height = 22
            CharCase = ecUpperCase
            DataField = 'TRA_LAYETQ'
            DataSource = dtsCadTra
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnKeyPress = dbeLayEtqKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDtaLay: TEditFocus
            Left = 10
            Top = 76
            Width = 158
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
        end
      end
      object pnlEtqTipo: TPanel
        Left = 0
        Top = 0
        Width = 692
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object drgTipEtq: TDBRadioGroup
          Left = 8
          Top = 0
          Width = 329
          Height = 51
          Caption = 'Tipo de Arquivo'
          Columns = 3
          DataField = 'TRA_TIPETQ'
          DataSource = dtsCadTra
          Items.Strings = (
            'Nenhum'
            'Correio'
            'Transportadora')
          TabOrder = 0
          Values.Strings = (
            'N'
            'C'
            'T')
          OnChange = drgTipEtqChange
        end
      end
      object pnlSerCor: TPanel
        Left = 0
        Top = 57
        Width = 692
        Height = 178
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object dbgCorTra: TDBGridCitel
          Left = 0
          Top = 36
          Width = 692
          Height = 142
          Align = alBottom
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          CorZebra = clMoneyGreen
          Zebra = True
          DestacarMouse = True
          Columns = <
            item
              Expanded = False
              FieldName = 'CODEMP'
              Title.Caption = 'Empresa'
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODSER'
              Title.Caption = 'C'#243'digo'
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRI'
              Title.Caption = 'Servi'#231'o'
              Width = 426
              Visible = True
            end>
        end
        object btnCarregarServicoCorreio: TBitBtnLocked
          Left = 0
          Top = 6
          Width = 146
          Height = 25
          Caption = 'Carregar Servi'#231'o'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000030000000E000000150000000C0000
            0002000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000200000012072B199C136940FF051E127A0000
            000C000000010000000000000000000000000000000000000000000000000000
            0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
            063D000000060000000000000000000000000000000000000000000000000000
            0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
            2BCE000000150000000200000000000000000000000000000000000000000000
            00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
            65FF082B1A8A0000000C00000001000000000000000000000000000000000000
            00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
            9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
            00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
            B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
            0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
            AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
            0000000000030000000600000005000000020000000000000002010302121A63
            44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
            0000000000000000000000000000000000000000000000000000000000020105
            03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000010002010B15573DA5509769FF0822184A00000004000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000100000004000000060000000300000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          OnClick = btnCarregarServicoCorreioClick
        end
        object btnRemoverServicoCorreio: TBitBtnLocked
          Left = 152
          Top = 6
          Width = 146
          Height = 25
          Caption = 'Remover Servi'#231'o'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000020000000A00000010000000090000000200000000000000000000
            00020000000A000000120000000C000000030000000000000000000000000000
            00020000000F0F0742921D0F7EEF0603347A0000000E00000002000000020000
            000F0804347C1D0F7EF00F084194000000120000000200000000000000000000
            0008120B47923233AFFF3648CCFF1D1EA5FF0603357A0000000F0000000F0703
            357C1F20A5FF3747CCFF2D2FAEFF120B46950000000B00000000000000000000
            000C281C8DF1596CD8FF3B51D3FF3A4FD2FF1E22A6FF0602347D0502357E2022
            A6FF3A50D3FF3A50D3FF4C5FD4FF291D8CF10000001000000000000000000000
            0006130F3C734D4FBAFF667EE0FF415AD6FF415AD7FF1F24A7FF2529A8FF415A
            D7FF415AD7FF5B72DEFF484AB8FF130F3C790000000900000000000000000000
            00010000000A16123F73585CC1FF758DE6FF4A64DBFF4A65DBFF4A65DBFF4A64
            DBFF6983E3FF5356C0FF16123F780000000C0000000200000000000000000000
            0000000000010000000A191643755D63C7FF6783E5FF5774E2FF5774E2FF5774
            E2FF565CC6FF1916437A0000000D000000020000000000000000000000000000
            00000000000100000009100E3D734A50BEFF7492EBFF6383E7FF6483E7FF6383
            E7FF3840B6FF0B0839780000000C000000020000000000000000000000000000
            0001000000071413416E555CC5FF85A1EFFF7897EDFF9CB6F4FF9DB7F5FF7997
            EEFF7796EDFF414ABCFF0E0C3C730000000A0000000100000000000000000000
            00041818456B636CCFFF93AFF3FF83A1F1FFA6BFF7FF676DCAFF7E87DDFFAFC7
            F8FF83A3F2FF83A1F1FF5058C4FF121040710000000600000000000000000000
            00065759C3EFAFC6F6FF8EADF4FFABC4F8FF6F76D0FF1817456F24244F70868E
            E1FFB5CCF9FF8DACF4FFA1B8F4FF5758C3EF0000000900000000000000000000
            000331326B8695A0EAFFC0D3F9FF7880D7FF1C1C496B00000006000000072527
            526C8B93E6FFC1D3F9FF949EE9FF303168870000000500000000000000000000
            00010000000431336B825E62CBEC1F204D680000000500000001000000010000
            00052728536B5E62CBEC31326883000000070000000100000000000000000000
            0000000000000000000200000004000000020000000100000000000000000000
            0001000000030000000500000004000000010000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 2
          OnClick = btnRemoverServicoCorreioClick
        end
      end
    end
    object tsMandae: TTabSheet
      Caption = '&5 - Etiqueta Despacho - Manda'#234
      ImageIndex = 3
      object Label39: TLabel
        Left = 3
        Top = 16
        Width = 230
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora Utiliza Integra'#231#227'o com Manda'#234'?'
      end
      object ColorLabel1: TColorLabel
        Left = 271
        Top = 16
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
      object Label42: TLabel
        Left = 155
        Top = 41
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Entrega:'
      end
      object ColorLabel2: TColorLabel
        Left = 271
        Top = 41
        Width = 104
        Height = 14
        Caption = '(R)'#225'pida (E)con'#244'mica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object Label41: TLabel
        Left = 3
        Top = 146
        Width = 134
        Height = 14
        Caption = 'Data/Hora '#218'ltima Altera'#231#227'o: '
      end
      object edtUtilizaIntegracaoMandae: TDBEditFocus
        Tag = 99
        Left = 239
        Top = 13
        Width = 26
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_MANUSA'
        DataSource = dtsCadTra
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
      object GroupBox1: TGroupBox
        Left = 0
        Top = 65
        Width = 329
        Height = 72
        Caption = 'Impress'#227'o'
        TabOrder = 2
        object Label40: TLabel
          Left = 10
          Top = 20
          Width = 101
          Height = 14
          Caption = 'Layout de Impress'#227'o'
        end
        object edtNomeLayoutImpressaoMandae: TEditFocus
          Left = 54
          Top = 36
          Width = 264
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtLayoutImpressaoMandae: TDBEditFocus
          Tag = 99
          Left = 10
          Top = 36
          Width = 43
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TRA_MANLAY'
          DataSource = dtsCadTra
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          OnKeyPress = edtLayoutImpressaoMandaeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
      end
      object edtTipoDeEntregaMandae: TDBEditFocus
        Tag = 99
        Left = 239
        Top = 38
        Width = 26
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_MANTEN'
        DataSource = dtsCadTra
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object edtDataHoraUltimaAtualizacaoMandae: TDBEditFocus
        Tag = 99
        Left = 135
        Top = 143
        Width = 194
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'TRA_MANATU'
        DataSource = dtsCadTra
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
    end
    object tsConFreteEletr: TTabSheet
      Caption = '&6 - Conhecimento de Frete Eletr'#244'nico'
      ImageIndex = 4
      DesignSize = (
        692
        623)
      object lblTranspHabilitadaFE: TLabel
        Left = 0
        Top = 12
        Width = 210
        Height = 28
        Alignment = taRightJustify
        Caption = 
          'Transportadora Habilitada para Emiss'#227'o de Conhecimento de Frete ' +
          'Eletr'#244'nico?'
        WordWrap = True
      end
      object ColorLabel3: TColorLabel
        Left = 260
        Top = 20
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
      object Label148: TLabel
        Left = 21
        Top = 46
        Width = 189
        Height = 28
        Alignment = taRightJustify
        Caption = 'Empresa respons'#225'vel pela emiss'#227'o do conhecimento:'
        WordWrap = True
      end
      object dbeTranspHabFE: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 16
        Width = 39
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_CONHAB'
        DataSource = dtsCadTra
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
        OnExit = dbeTranspHabFEExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object edtDesEmpRespConh: TEditFocus
        Left = 277
        Top = 49
        Width = 385
        Height = 22
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
      object dbeCodEmpRespConh: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 49
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_EMPRES'
        DataSource = dtsCadTra
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        OnExit = dbeCodEmpRespConhExit
        OnKeyPress = dbeCodEmpRespConhKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object gpbPadraoCTe: TGroupBox
        Left = 0
        Top = 77
        Width = 685
        Height = 240
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Padr'#227'o para Emiss'#227'o de CT-e'
        Enabled = False
        TabOrder = 2
        object Label43: TLabel
          Left = 93
          Top = 17
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'CFOP Pessoa F'#237'sica:'
        end
        object Label44: TLabel
          Left = 80
          Top = 42
          Width = 113
          Height = 14
          Alignment = taRightJustify
          Caption = 'Natureza da Opera'#231#227'o:'
        end
        object Label45: TLabel
          Left = 140
          Top = 67
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'S'#233'rie CT-e:'
        end
        object Label46: TLabel
          Left = 94
          Top = 92
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tomador do Servi'#231'o:'
        end
        object Label49: TLabel
          Left = 26
          Top = 117
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo da Classifica'#231#227'o Tribut'#225'ria:'
        end
        object Label50: TLabel
          Left = 85
          Top = 142
          Width = 108
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto Predominante:'
        end
        object Label51: TLabel
          Left = 86
          Top = 167
          Width = 107
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o do Servi'#231'o:'
        end
        object Label52: TLabel
          Left = 10
          Top = 184
          Width = 183
          Height = 28
          Alignment = taRightJustify
          Caption = 'Registro Nacional de Transportadores Rodovi'#225'rios de Carga:'
          WordWrap = True
        end
        object lblAliquota: TLabel
          Left = 109
          Top = 216
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'Al'#237'quota do ICMS:'
        end
        object Label53x: TLabel
          Left = 332
          Top = 17
          Width = 109
          Height = 14
          Alignment = taRightJustify
          Caption = 'CFOP Pessoa Jur'#237'dica:'
        end
        object edtCFOP: TEditFocus
          Tag = 99
          Left = 196
          Top = 14
          Width = 53
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
        object edtNaturezaOp: TEditFocus
          Tag = 99
          Left = 196
          Top = 39
          Width = 463
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 60
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSerie: TEditFocus
          Tag = 99
          Left = 196
          Top = 64
          Width = 44
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
        object cmbTomadorServ: TComboBoxFocus
          Tag = 99
          Left = 196
          Top = 89
          Width = 124
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemIndex = 0
          ParentFont = False
          TabOrder = 4
          Text = '0 - Remetente'
          Items.Strings = (
            '0 - Remetente'
            '3 - Destinat'#225'rio')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object cmbCodigoClassTrib: TComboBoxFocus
          Tag = 99
          Left = 196
          Top = 114
          Width = 417
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemIndex = 1
          ParentFont = False
          TabOrder = 5
          Text = '00 - Tributa'#231#227'o normal ICMS'
          Items.Strings = (
            '1 - SIMPLES NACIONAL'
            '00 - Tributa'#231#227'o normal ICMS'
            '20 - Tributa'#231#227'o com BC reduzida do ICMS'
            '40 - ICMS isen'#231#227'o'
            '41 - ICMS n'#227'o tributada'
            '51 - ICMS diferido'
            '60 - ICMS cobrado anteriormente por substitui'#231#227'o tribut'#225'ria'
            '90 - ICMS outros'
            
              '90 - ICMS devido a UF de origem de presta'#231#227'o, quando diferente d' +
              'a UF')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtProdutoPredom: TEditFocus
          Tag = 99
          Left = 196
          Top = 139
          Width = 463
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 60
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescricaoServ: TEditFocus
          Tag = 99
          Left = 196
          Top = 164
          Width = 385
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRNTRC: TEditFocus
          Tag = 99
          Left = 196
          Top = 189
          Width = 151
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAliquota: TEditFocus
          Tag = 99
          Left = 196
          Top = 213
          Width = 151
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCFOPJU: TEditFocus
          Tag = 99
          Left = 444
          Top = 14
          Width = 53
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
      end
      object gpbFinanceiro: TGroupBox
        Left = 0
        Top = 318
        Width = 685
        Height = 143
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Financeiro'
        Enabled = False
        TabOrder = 3
        object Label53: TLabel
          Left = 147
          Top = 17
          Width = 44
          Height = 14
          Hint = '888'
          Alignment = taRightJustify
          Caption = 'Portador:'
        end
        object Label55: TLabel
          Left = 90
          Top = 67
          Width = 101
          Height = 14
          Hint = '999'
          Alignment = taRightJustify
          Caption = 'Cnd. Pag.  (A Pagar):'
        end
        object Label56: TLabel
          Left = 80
          Top = 117
          Width = 111
          Height = 14
          Hint = '999'
          Alignment = taRightJustify
          Caption = 'Cnd. Pag.  (A receber):'
        end
        object edtCodPor: TEditFocus
          Tag = 99
          Left = 194
          Top = 14
          Width = 69
          Height = 22
          Hint = '888'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomPor: TEditFocus
          Left = 265
          Top = 14
          Width = 347
          Height = 22
          Hint = '888'
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
        object mskConPagPagar: TMaskEditFocus
          Tag = 99
          Left = 194
          Top = 64
          Width = 418
          Height = 22
          Hint = '999'
          AutoSize = False
          EditMask = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999;0;'
          MaxLength = 98
          TabOrder = 3
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskConPagReceber: TMaskEditFocus
          Tag = 99
          Left = 194
          Top = 114
          Width = 419
          Height = 22
          Hint = '999'
          AutoSize = False
          EditMask = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999;0;'
          MaxLength = 98
          TabOrder = 5
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        inline fraPlanoDeContasPga: TfraPlanoDeContasMskEdit
          Left = 87
          Top = 39
          Width = 535
          Height = 22
          TabOrder = 1
          ExplicitLeft = 87
          ExplicitTop = 39
          ExplicitWidth = 535
          inherited lblPlaContas: TLabel
            Left = 4
            Width = 100
            Height = 14
            Caption = 'Pl. Contas (A pagar):'
            ExplicitLeft = 4
            ExplicitWidth = 100
            ExplicitHeight = 14
          end
          inherited edtDesCta: TEditFocus
            Left = 178
            Width = 347
            Height = 22
            ExplicitLeft = 178
            ExplicitWidth = 347
            ExplicitHeight = 22
          end
          inherited MskCodCta: TMaskEdit
            Left = 107
            Width = 69
            Height = 22
            OnKeyPress = fraPlanoDeContasPgaMskCodCtaKeyPress
            ExplicitLeft = 107
            ExplicitWidth = 69
            ExplicitHeight = 22
          end
        end
        inline fraPlanoDeContasRec: TfraPlanoDeContasMskEdit
          Left = 81
          Top = 89
          Width = 544
          Height = 22
          TabOrder = 4
          ExplicitLeft = 81
          ExplicitTop = 89
          ExplicitWidth = 544
          inherited lblPlaContas: TLabel
            Left = 0
            Width = 110
            Height = 14
            Caption = 'Pl. Contas (A receber):'
            ExplicitLeft = 0
            ExplicitWidth = 110
            ExplicitHeight = 14
          end
          inherited edtDesCta: TEditFocus
            Left = 184
            Width = 347
            Height = 22
            ExplicitLeft = 184
            ExplicitWidth = 347
            ExplicitHeight = 22
          end
          inherited MskCodCta: TMaskEdit
            Left = 113
            Width = 69
            Height = 22
            OnKeyPress = fraPlanoDeContasRecMskCodCtaKeyPress
            ExplicitLeft = 113
            ExplicitWidth = 69
            ExplicitHeight = 22
          end
        end
      end
    end
    object tbsIntelipost: TTabSheet
      Caption = '&7 - Intelipost'
      ImageIndex = 5
      object lblUtilizaIntelipost: TLabel
        Left = 2
        Top = 24
        Width = 243
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora Utiliza Integra'#231#227'o com a Intelipost?'
      end
      object lblSimNaoIntelipost: TColorLabel
        Left = 283
        Top = 24
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
      object lblCodTranspIntelipost: TLabel
        Left = 2
        Top = 48
        Width = 189
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo da Transportadora na Intelipost:'
      end
      object dbeUtiItelipost: TDBEditFocus
        Tag = 99
        Left = 251
        Top = 21
        Width = 26
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_ITPUSA'
        DataSource = dtsCadTra
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
      object dbeCodTranspIntelipost: TDBEditFocus
        Tag = 99
        Left = 196
        Top = 44
        Width = 65
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TRA_CODITP'
        DataSource = dtsCadTra
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 665
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 660
    Top = 348
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 192
  end
  object cdsTraCtt: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 657
    Top = 140
    object cdsTraCttNOMCTT: TStringField
      FieldName = 'NOMCTT'
      Size = 50
    end
    object cdsTraCttENDCTT: TStringField
      FieldName = 'ENDCTT'
      Size = 50
    end
    object cdsTraCttBAICTT: TStringField
      FieldName = 'BAICTT'
      Size = 30
    end
    object cdsTraCttNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 40
    end
    object cdsTraCttESTCID: TStringField
      FieldName = 'ESTCID'
      Size = 2
    end
    object cdsTraCttTELCTT: TStringField
      FieldName = 'TELCTT'
      Size = 16
    end
    object cdsTraCttEMACTT: TStringField
      FieldName = 'EMACTT'
      Size = 255
    end
    object cdsTraCttCODCID: TStringField
      FieldName = 'CODCID'
      Size = 5
    end
    object cdsTraCttCELCTT: TStringField
      FieldName = 'CELCTT'
      Size = 16
    end
    object cdsTraCttFAXCTT: TStringField
      FieldName = 'FAXCTT'
      Size = 16
    end
    object cdsTraCttDEPCTT: TStringField
      FieldName = 'DEPCTT'
      Size = 25
    end
  end
  object dtsTraCtt: TDataSource
    DataSet = cdsTraCtt
    Left = 658
    Top = 292
  end
  object dtsCadTra: TDataSource
    Left = 656
    Top = 96
  end
  object ImageSefaz: TcxImageList
    SourceDPI = 96
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 3474068
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
