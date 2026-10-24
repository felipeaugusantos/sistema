inherited frmCadCartoes: TfrmCadCartoes
  Left = 294
  Top = 216
  Width = 820
  Height = 754
  Caption = 'Cadastro de Cart'#245'es'
  ExplicitWidth = 820
  ExplicitHeight = 754
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 814
    Height = 24
    ExplicitTop = 685
    ExplicitWidth = 814
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Width = 741
      Height = 20
      ExplicitTop = 2
      ExplicitWidth = 741
      ExplicitHeight = 20
      inherited btnCancela: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 363
        Width = 75
        ExplicitLeft = 363
        ExplicitWidth = 75
      end
      object btnPlaNco: TBitBtnLocked
        Left = 438
        Top = 0
        Width = 84
        Height = 20
        Caption = 'Plano de Contas'
        TabOrder = 6
        OnClick = btnPlaNcoClick
      end
      object BtnHeranca: TBitBtnLocked
        Left = 522
        Top = 0
        Width = 84
        Height = 20
        Caption = 'Heran'#231'a'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00070000000A0000000C0000000C0000000C0000000D0000000D0000000D0000
          000E0000000E0000000E0000000D000000090000000200000000000000068F6B
          4EBEC6956CFFC6946AFFC59369FFC49268FFC49167FFC39066FFC28F65FFC28E
          64FFC18D63FFC08D62FFC08C62FF8A6545C100000009000000000000000BD4AF
          91FFFDFDFDFFFAF3ECFFFAF3EBFFF9F3EBFFF9F2EBFFF9F3EBFFFAF2EAFFFAF2
          E9FFF9F1E9FFFAF1EAFFF9F1E9FFC08D62FF0000000D000000000000000DB670
          3DFFEFE8E3FFF8F2EBFFFAF4ECFFFAF3ECFFFAF3EBFFFAF3EBFFF9F2EBFFF9F2
          EAFFF9F2EAFFF9F2E9FFF9F2E9FFC18D63FF0000000E000000000000000EB873
          40FFBC7A49FFEBDED3FFF8F1EAFFFAF3ECFFFAF3ECFFF9F3EBFF5354C5FF5253
          C3FF5252C3FF5051C2FFF9F2EAFFC28E64FF0000000D000000000000000EBA76
          44FFCD905CFFBD7A48FFEFE3D6FFFAF4ECFFFAF3ECFFFAF4ECFFE3DDE7FFE3DD
          E6FFE2DCE6FFE2DCE5FFF9F3EAFFC29065FF0000000C000000000000000DBB79
          46FFBF7F4EFFEBE0D5FFF8F2ECFFFBF4EDFFFBF4ECFFFAF3EDFF5959CBFF5858
          C9FF5658C8FF5556C6FFFAF2EAFFC39067FF0000000C000000000000000BBD7B
          49FFF0E9E4FFF8F3ECFFFBF5EEFFFAF4EDFFFAF4EDFFFAF4EDFFE4DFE8FFE4DE
          E7FFE3DDE7FFE3DDE6FFFAF3EBFFC49168FF0000000B0000000000000008D9B6
          98FFFDFDFDFFC3926AFFC29167FFC28F66FFC18E65FFFAF5EDFF5F5FD0FF5E5E
          CFFF5C5DCDFF5A5BCCFFFAF3EBFFC59369FF0000000B0000000000000006CEA0
          78FFFFFFFFFFF3E8DDFFF2E7DDFFF3E7DBFFF3E7DBFFFAF5EEFFE5DFE9FFE4DF
          E9FFE4DFE9FFE3DFE9FFFAF4ECFFC5946BFF0000000A0000000000000005D0A0
          7AFFFFFFFFFFC7966FFFC5956EFFC4936CFFC4926AFFFAF5EEFF6565D7FF6363
          D5FF6262D4FF6161D3FFFAF4EDFFC6956CFF0000000A0000000000000005D0A2
          7BFFFFFFFFFFF4E9DFFFF4E9DEFFF3E8DDFFF3E7DEFFFAF5EFFFE5E1ECFFE6E1
          EBFFE5E0EAFFE5E0EAFFFAF4EDFFC7966DFF000000090000000000000004D1A3
          7DFFFFFFFFFFC99B75FFC89A73FFC79871FFC79770FFFBF5F0FF6869DBFF6868
          DAFF6667D9FF6666D8FFFAF4EDFFC9976FFF000000080000000000000004D1A4
          7EFFFFFFFFFFFBF7F1FFFBF7F1FFFBF7F1FFFBF6F1FFFBF6F0FFFBF5EFFFFBF5
          EFFFFBF5EFFFFBF5EEFFFBF5EEFFC99871FF000000080000000000000003D2A5
          7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFCA9A72FF0000000700000000000000029D7A
          5EBFD3A580FFD2A47EFFD2A47EFFD1A27DFFD0A27BFFD0A17AFFCFA079FFCE9F
          78FFCD9E77FFCC9D76FFCC9C75FF977356C10000000400000000}
        TabOrder = 7
        OnClick = BtnHerancaClick
      end
      object BtnAlteracaoGlobal: TBitBtnLocked
        Left = 606
        Top = 0
        Width = 109
        Height = 20
        Caption = 'Altera'#231#227'o global'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000001F421C11FF30140DEC190A06B30304
          075F0000001B0000000500000000000000000000000000000000000000000000
          00000000000000000000000000000000001E663C2BE7B9C7D2FF7889A2FF2441
          82FF051033AF0000002100000005000000000000000000000000000000000000
          0002000000090000000E0000000F0000002041261BAE879AB2FFC8E3F5FF1F66
          B6FF2B6BA8FF051236AD0000001F000000040000000000000000000000000000
          00088C6657C0C38C7AFFC38C79FFCBA395FFA89894FF488BC3FFDEFEFDFF51B4
          E3FF1F68B7FF3173AEFF061538AA0000001C0000000400000000000000000000
          000CC5917EFFFDFBFAFFFCF8F6FFFAF7F5FFECEAE9FF7CA3BFFF479FD2FFDEFE
          FDFF59BFE9FF216BB9FF367BB3FF07173AA70000001A00000004000000000000
          000CC79481FFFEFBFAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7EA4BFFF4BA5
          D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF081A3DA300000018000000000000
          000BC99786FFFEFCFBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7
          C2FF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F9E000000000000
          000ACB9C8BFFFEFDFCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9
          E7FF85ABC7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
          0009CFA08DFFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4
          EFFFEFECE9FF89AECAFF54B1DCFFDEFEFDFF4FA6D4FF102C4E93000000000000
          0009D0A393FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF6F1FFF3EFEDFF83A0B8FF357FBCFF173A598F0000000C000000000000
          0008D3A897FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFAF6F3FFE2CCC4FF000000160000000600000001000000000000
          0007D3AB9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFBF6F1FFD1A494FF0000000C0000000000000000000000000000
          0006D8AE9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
          F5FFFBF7F4FFFCF7F3FFD3A897FF0000000B0000000000000000000000000000
          0006D8B0A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
          F6FFFBF7F6FFFCF7F5FFD4AC9BFF0000000A0000000000000000000000000000
          0005D9B3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
          FEFFFEFEFEFFFEFEFEFFD7AE9EFF000000090000000000000000000000000000
          0003A3867AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3
          A2FFD9B2A2FFD8B2A2FFA08377C2000000060000000000000000}
        TabOrder = 8
        OnClick = BtnAlteracaoGlobalClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 743
      Width = 69
      Height = 20
      Align = alRight
      ExplicitLeft = 743
      ExplicitWidth = 69
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 709
    Width = 814
    TabOrder = 2
    ExplicitTop = 709
    ExplicitWidth = 814
    inherited pnlNomeForm: TPanel
      Left = 648
      Width = 166
      ExplicitLeft = 648
      ExplicitWidth = 166
    end
    inherited pnlInfo: TPanel
      Width = 648
      ExplicitWidth = 648
    end
  end
  inherited pgcDados: TPageControl
    Width = 814
    Height = 685
    TabOrder = 1
    OnChange = pgcDadosChange
    ExplicitWidth = 814
    ExplicitHeight = 685
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Informa'#231#245'es Gerais'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 806
      ExplicitHeight = 653
      object Label1: TLabel
        Left = 19
        Top = 16
        Width = 120
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo:'
      end
      object lbDesCar: TLabel
        Left = 19
        Top = 39
        Width = 120
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descri'#231#227'o do Cart'#227'o:'
      end
      object Label5: TLabel
        Left = 91
        Top = 176
        Width = 48
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Prazo:'
      end
      object Label61: TLabel
        Left = 206
        Top = 176
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Caption = 'dias'
      end
      object lblCndPag: TLabel
        Left = 19
        Top = 199
        Width = 120
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. M'#237'nima de Parcelas'
      end
      object Label148: TLabel
        Left = 94
        Top = 222
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label7: TLabel
        Left = 347
        Top = 199
        Width = 152
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. M'#225'xima de Parcelas:'
      end
      object Label13: TLabel
        Left = 93
        Top = 153
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Bandeira:'
      end
      object Label14: TLabel
        Left = 291
        Top = 176
        Width = 208
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Dias excedentes na 1'#170' parcela:'
      end
      object Label15: TLabel
        Left = 566
        Top = 176
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Caption = 'dias'
      end
      object Label16: TLabel
        Left = 64
        Top = 245
        Width = 76
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tipo de Cart'#227'o:'
      end
      object lbl1: TLabel
        Left = 382
        Top = 245
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor M'#237'nimo da parcela:'
      end
      object Label9: TLabel
        Left = 22
        Top = 269
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'CNPJ da administradora:'
      end
      object lbl2: TLabel
        Left = 358
        Top = 15
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo?'
      end
      object lbl3: TColorLabel
        Left = 426
        Top = 15
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label17: TLabel
        Left = 326
        Top = 268
        Width = 239
        Height = 14
        Alignment = taRightJustify
        Caption = '"/" para pesquisar administradoras/fornecedores.'
      end
      object Label6: TLabel
        Left = 63
        Top = 314
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Entrar no SPED:'
      end
      object ColorLabel1: TColorLabel
        Left = 174
        Top = 314
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblDesPlaCon: TLabel
        Left = 67
        Top = 338
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta Cont'#225'bil:'
      end
      object ColorLabel3: TColorLabel
        Left = 427
        Top = 292
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label24: TLabel
        Left = 282
        Top = 292
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Obrigat'#243'rio N'#250'm. NSU?'
      end
      object ColorLabel2: TColorLabel
        Left = 175
        Top = 291
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label22: TLabel
        Left = 3
        Top = 291
        Width = 137
        Height = 14
        Alignment = taRightJustify
        Caption = 'Obrigat'#243'rio N'#250'm. Libera'#231#227'o?'
      end
      object lblCodRed: TLabel
        Left = 6
        Top = 383
        Width = 133
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'd da Credenciadora SAT:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMarketPlace: TLabel
        Left = 433
        Top = 153
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Market Place:'
      end
      object ColorLabel5: TColorLabel
        Left = 534
        Top = 153
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblFornecedorFiscal: TLabel
        Left = 49
        Top = 406
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor Fiscal:'
      end
      object dbeCodCar: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 12
        Width = 65
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_CODCAR'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDesCar: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 35
        Width = 281
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_DESCAR'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePeriod: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 172
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_PERIOD'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSugCPg: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 195
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_SUGPAR'
        DataSource = dtsCadCar
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
        TipoTexto = ttNumerico
      end
      object edtCodEmpresa: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 218
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_CODEMP'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 11
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 203
        Top = 218
        Width = 359
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object dbeMaxPar: TDBEditFocus
        Tag = 99
        Left = 502
        Top = 195
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_MAXPAR'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object gbDadosTef: TGroupBox
        Left = 3
        Top = 467
        Width = 600
        Height = 142
        Caption = '   Dados para TEF   '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 24
        object gbTefTrocaArquivo: TGroupBox
          Left = 11
          Top = 16
          Width = 278
          Height = 122
          Caption = '   Via Troca de Arquivos   '
          TabOrder = 0
          object Label8: TLabel
            Left = 13
            Top = 24
            Width = 108
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Nome da Operadora:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 13
            Top = 70
            Width = 108
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Tipo da Transa'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 11
            Top = 48
            Width = 108
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Nome da Bandeira:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbeNomRed: TDBEditFocus
            Tag = 99
            Left = 125
            Top = 19
            Width = 150
            Height = 22
            Hint = 'Campo 010-000 do arquivo INTPOS.001.'
            CharCase = ecUpperCase
            DataField = 'CAR_NOMRED'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnEnter = dbeNomRedEnter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeTipTra: TDBEditFocus
            Tag = 99
            Left = 125
            Top = 67
            Width = 35
            Height = 22
            Hint = 'Campo 011-000 do arquivo INTPOS.001.'
            CharCase = ecUpperCase
            DataField = 'CAR_TIPTRA'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnEnter = dbeTipTraEnter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeNomBan: TDBEditFocus
            Tag = 99
            Left = 125
            Top = 43
            Width = 150
            Height = 22
            Hint = 'Campo 040-000 do arquivo INTPOS.001.'
            CharCase = ecUpperCase
            DataField = 'CAR_NOMBAN'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnEnter = dbeNomBanEnter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object gbTefViaDLL: TGroupBox
          Left = 292
          Top = 15
          Width = 304
          Height = 122
          Caption = '   Via DLL   '
          TabOrder = 1
          object lbCodBandeira: TLabel
            Left = 8
            Top = 55
            Width = 85
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'd. Bandeira:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbCodOperadora: TLabel
            Left = 8
            Top = 32
            Width = 85
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'd Operadora:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbCardSe: TLabel
            Left = 8
            Top = 101
            Width = 85
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'd. CardSE:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 98
            Top = 10
            Width = 79
            Height = 14
            Caption = 'Fiserv-ClisiTef'
          end
          object Label18: TLabel
            Left = 190
            Top = 10
            Width = 112
            Height = 14
            Caption = 'Conex'#227'oTech-Scope'
          end
          object lbTipDeb: TLabel
            Left = 1
            Top = 77
            Width = 92
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Tipo de D'#233'bito:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object DBETFTOPE: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 27
            Width = 79
            Height = 22
            Hint = 'Campo 010-000 do registro salvo na MOVTEF'
            CharCase = ecUpperCase
            DataField = 'CAR_TFTRED'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnEnter = DBETFTOPEEnter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBETFTRED: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 50
            Width = 79
            Height = 22
            Hint = 'Campo 010-001 do registro salvo na MOVTEF'
            CharCase = ecUpperCase
            DataField = 'CAR_TFTBAN'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnEnter = DBETFTREDEnter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCardSe: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 96
            Width = 79
            Height = 22
            Hint = 'C'#243'dido da Carteira Digital'
            CharCase = ecUpperCase
            DataField = 'CAR_CARDSE'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 5
            OnEnter = dbeCardSeEnter
            OnExit = dbeCardSeExit
            OnKeyPress = dbeCardSeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object DBETFRED2: TDBEditFocus
            Tag = 99
            Left = 190
            Top = 27
            Width = 79
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CAR_TFRED2'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnEnter = DBETFRED2Enter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBETFBAN2: TDBEditFocus
            Tag = 99
            Left = 190
            Top = 50
            Width = 79
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CAR_TFBAN2'
            DataSource = dtsCadCar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnEnter = DBETFBAN2Enter
            OnExit = dbeNomRedExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeTipDeb: TDBComboBoxFocus
            Tag = 99
            Left = 98
            Top = 73
            Width = 121
            Height = 22
            Style = csOwnerDrawFixed
            DataField = 'CAR_TIPDEB'
            DataSource = dtsCadCar
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Items.Strings = (
              '0 - '#192' Vista'
              '1 - Pr'#233' Datado')
            ParentFont = False
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
      object dbeCodBan: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 149
        Width = 36
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_CODBAN'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        OnKeyPress = dbeCodBanKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
        OnChamaCadastro = dbeCodBanChamaCadastro
      end
      object edtNomBan: TEditFocus
        Left = 179
        Top = 149
        Width = 244
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
      object dbeExcDia: TDBEditFocus
        Tag = 99
        Left = 502
        Top = 172
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_EXCDIA'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTipCar: TDBComboBoxFocus
        Tag = 99
        Left = 142
        Top = 241
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'CAR_TIPCAR'
        DataSource = dtsCadCar
        Items.Strings = (
          'Cr'#233'dito'
          'D'#233'bito')
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeParMin: TDBEditFocus
        Tag = 99
        Left = 502
        Top = 241
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_PARMIN'
        DataSource = dtsCadCar
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
        TipoTexto = ttAlfanumerico
      end
      object dbeCnpj: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 264
        Width = 178
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_C_G_C_'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 14
        OnKeyPress = dbeCnpjKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeStatus: TDBEditFocus
        Tag = 99
        Left = 394
        Top = 11
        Width = 29
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_STATUS'
        DataSource = dtsCadCar
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeEntSped: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 310
        Width = 29
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_ENTSPE'
        DataSource = dtsCadCar
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        OnChange = dbeEntSpedChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeConCon: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 333
        Width = 281
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_CONCON'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnDesmembr: TBitBtnLocked
        Left = 423
        Top = 333
        Width = 139
        Height = 22
        Caption = 'Desmembra Conta Cont'#225'bil'
        TabOrder = 19
        Visible = False
        OnClick = btnDesmembrClick
      end
      object dbchkDesmembr: TDBCheckBox
        Left = 142
        Top = 356
        Width = 230
        Height = 17
        Caption = 'Conta Cont'#225'bil desmembrada por empresa?'
        DataField = 'CAR_DESMEM'
        DataSource = dtsCadCar
        TabOrder = 20
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dbchkDesmembrClick
      end
      object dbeNumNSU: TDBEditFocus
        Tag = 99
        Left = 395
        Top = 288
        Width = 29
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_OBRNSU'
        DataSource = dtsCadCar
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeNumCCD: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 287
        Width = 29
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_OBRCCD'
        DataSource = dtsCadCar
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbePlaNco: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 333
        Width = 135
        Height = 22
        DataField = 'CAR_PLANCO'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        OnKeyPress = dbePlaNcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDesPlaNco: TEditFocus
        Left = 280
        Top = 333
        Width = 144
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 28
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gbTxAdm: TGroupBox
        Left = 40
        Top = 58
        Width = 238
        Height = 88
        Caption = 'Taxa de Administra'#231#227'o'
        TabOrder = 3
        object Label3: TLabel
          Left = 73
          Top = 18
          Width = 26
          Height = 13
          AutoSize = False
          Caption = 'Taxa:'
          WordWrap = True
        end
        object Label4: TLabel
          Left = 35
          Top = 41
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Taxa:'
        end
        object ColorLabel4: TColorLabel
          Left = 132
          Top = 41
          Width = 96
          Height = 14
          Caption = '(P)ercentual (V)alor'
          CorDestaque = clRed
        end
        object lbTaxMin: TLabel
          Left = 5
          Top = 64
          Width = 94
          Height = 14
          Caption = 'Vlr M'#237'n por Parcela:'
          WordWrap = True
        end
        object dbePerDes: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 15
          Width = 69
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_PERDES'
          DataSource = dtsCadCar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTipTax: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 38
          Width = 26
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_TIPTAX'
          DataSource = dtsCadCar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          OnExit = dbeTipTaxExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTaxMin: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 61
          Width = 69
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_TAXMIN'
          DataSource = dtsCadCar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object dbeCodRed: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 380
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_CODRED'
        DataSource = dtsCadCar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 21
        OnKeyPress = dbeCodRedKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object edtDesCredenciadora: TEditFocus
        Left = 203
        Top = 380
        Width = 393
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 29
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeMarketPlace: TDBEditFocus
        Tag = 99
        Left = 502
        Top = 149
        Width = 29
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_MKTPLA'
        DataSource = dtsCadCar
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object dbeCodigoFornecedorFiscal: TDBEditFocus
        Tag = 99
        Left = 142
        Top = 403
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAR_FORFIS'
        DataSource = dtsCadCar
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 22
        OnKeyPress = dbeCodigoFornecedorFiscalKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtNomeFornecedorFiscal: TEditFocus
        Left = 203
        Top = 403
        Width = 393
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 30
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gpbArredondamento: TGroupBox
        Left = 49
        Top = 426
        Width = 205
        Height = 37
        Caption = 'Arredondamento POS:'
        TabOrder = 23
        object chkPriParcela: TDBCheckBox
          Left = 7
          Top = 17
          Width = 97
          Height = 17
          Caption = 'Primeira Parcela'
          DataField = 'CAR_ARRPAR'
          DataSource = dtsCadCar
          TabOrder = 0
          ValueChecked = 'P'
          ValueUnchecked = 'N'
          OnClick = chkPriParcelaClick
        end
        object chkUltParcela: TDBCheckBox
          Left = 113
          Top = 17
          Width = 97
          Height = 17
          Caption = 'Ultima Parcela'
          DataField = 'CAR_ARRPAR'
          DataSource = dtsCadCar
          TabOrder = 1
          ValueChecked = 'U'
          ValueUnchecked = 'N'
          OnClick = chkUltParcelaClick
        end
      end
      object gbLinkPagamentoBandeira: TGroupBox
        Left = 3
        Top = 611
        Width = 592
        Height = 42
        Caption = 'Dados para Link de Pagamento CIELO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 31
        object Label20: TLabel
          Left = 19
          Top = 19
          Width = 108
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Nome da Bandeira:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbeCieban: TDBComboBoxFocus
          Left = 132
          Top = 16
          Width = 150
          Height = 22
          Style = csOwnerDrawFixed
          CharCase = ecUpperCase
          DataField = 'CAR_CIEBAN'
          DataSource = dtsCadCar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object gbAdquirente: TGroupBox
        Left = 282
        Top = 68
        Width = 342
        Height = 63
        TabOrder = 4
        Visible = False
        object lbAdq: TLabel
          Left = 5
          Top = 11
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Adquirente:'
        end
        object gpbTipoTransacao: TGroupBox
          Left = 3
          Top = 30
          Width = 108
          Height = 30
          Caption = 'Tipo Transa'#231#227'o:'
          TabOrder = 1
          object chkTipoPos: TDBCheckBox
            Left = 6
            Top = 14
            Width = 58
            Height = 17
            Caption = 'POS'
            DataField = 'CAR_TIPPOS'
            DataSource = dtsCadCar
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnExit = chkTipoPosExit
          end
          object chkTipoTef: TDBCheckBox
            Tag = 99
            Left = 56
            Top = 14
            Width = 39
            Height = 17
            Caption = 'TEF'
            DataField = 'CAR_TIPTEF'
            DataSource = dtsCadCar
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkTipoTefClick
            OnExit = chkTipoTefExit
          end
        end
        object dbeCodAdq: TDBEditFocus
          Tag = 99
          Left = 63
          Top = 8
          Width = 48
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_CODADQ'
          DataSource = dtsCadCar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodAdqKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodAdqChamaCadastro
        end
        object edtNomAdq: TEditFocus
          Left = 117
          Top = 8
          Width = 225
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
    object tsBaixaOtimizada: TTabSheet
      Caption = '&2 - Informa'#231#245'es para Baixa Otimizada de Cart'#245'es'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 3
        Top = 13
        Width = 547
        Height = 184
        Caption = 'Cr'#233'dito'
        TabOrder = 0
        object Label50: TLabel
          Left = 87
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 46
          Top = 107
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Taxa da Baixa:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 31
          Top = 39
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor da Taxa da Baixa:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbePorBai: TDBEditFocus
          Tag = 99
          Left = 179
          Top = 11
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_PORBAI'
          DataSource = dtsCadCar
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
          OnKeyPress = dbePorBaiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbePorBaiChamaCadastro
        end
        object edtPorBai: TEditFocus
          Left = 244
          Top = 11
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object edtPorTax: TEditFocus
          Left = 244
          Top = 103
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbePorTax: TDBEditFocus
          Tag = 99
          Left = 179
          Top = 103
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_PORTAX'
          DataSource = dtsCadCar
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 4
          OnKeyPress = dbePorTaxKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbePorTaxChamaCadastro
        end
        inline fraCentroCustoC: TfraCentroCustoDBEditFocus
          Left = 6
          Top = 80
          Width = 539
          Height = 22
          TabOrder = 3
          ExplicitLeft = 6
          ExplicitTop = 80
          ExplicitWidth = 539
          inherited lblEventos: TLabel
            Left = 38
            Width = 132
            Height = 14
            Caption = 'Centro de Custos da Baixa:'
            ExplicitLeft = 38
            ExplicitWidth = 132
            ExplicitHeight = 14
          end
          inherited dbeCodEve: TDBEditFocus
            Left = 173
            Width = 64
            Height = 22
            DataField = 'CAR_EVECRE'
            DataSource = dtsCadCar
            OnExit = fraCentroCustoCdbeCodEveExit
            PanelInfo = pnlInfo
            ExplicitLeft = 173
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesEve: TEditFocus
            Left = 238
            Width = 300
            Height = 22
            ExplicitLeft = 238
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
        inline fraCentroCustoTX: TfraCentroCustoDBEditFocus
          Left = 6
          Top = 149
          Width = 538
          Height = 22
          TabOrder = 6
          ExplicitLeft = 6
          ExplicitTop = 149
          ExplicitWidth = 538
          inherited lblEventos: TLabel
            Left = 28
            Top = 3
            Width = 142
            Height = 14
            Caption = 'Ctr. Custos da Taxa da Baixa:'
            ExplicitLeft = 28
            ExplicitTop = 3
            ExplicitWidth = 142
            ExplicitHeight = 14
          end
          inherited dbeCodEve: TDBEditFocus
            Left = 173
            Width = 64
            Height = 22
            DataField = 'CAR_EVETAX'
            DataSource = dtsCadCar
            OnExit = fraCentroCustoTXdbeCodEveExit
            PanelInfo = pnlInfo
            ExplicitLeft = 173
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesEve: TEditFocus
            Left = 238
            Width = 300
            Height = 22
            ExplicitLeft = 238
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
        inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
          Left = 92
          Top = 57
          Width = 452
          Height = 22
          TabOrder = 2
          ExplicitLeft = 92
          ExplicitTop = 57
          ExplicitWidth = 452
          inherited lblPlaContas: TLabel
            Left = 3
            Top = 3
            Width = 84
            Height = 14
            ExplicitLeft = 3
            ExplicitTop = 3
            ExplicitWidth = 84
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 87
            Width = 64
            Height = 22
            DataField = 'CAR_CTABAI'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasdbeCodCtaChamaCadastro
            ExplicitLeft = 87
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 152
            Width = 300
            Height = 22
            ExplicitLeft = 152
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
        inline fraPlanoDeContasDaBaixa: TfraPlanoDeContasDBEditFocus
          Left = 5
          Top = 126
          Width = 540
          Height = 22
          TabOrder = 5
          ExplicitLeft = 5
          ExplicitTop = 126
          ExplicitWidth = 540
          inherited lblPlaContas: TLabel
            Left = 4
            Width = 167
            Height = 14
            Caption = 'Plano de Contas da Taxa da Baixa:'
            ExplicitLeft = 4
            ExplicitWidth = 167
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 174
            Width = 64
            Height = 22
            DataField = 'CAR_CTATAX'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasDaBaixadbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasDaBaixadbeCodCtaChamaCadastro
            ExplicitLeft = 174
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 239
            Width = 300
            Height = 22
            ExplicitLeft = 239
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
        object dbeForTax: TDBEditFocus
          Tag = 99
          Left = 179
          Top = 34
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_FORTAX'
          DataSource = dtsCadCar
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 1
          OnKeyPress = dbeForTaxKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeForTaxChamaCadastro
        end
        object edtForTax: TEditFocus
          Left = 244
          Top = 34
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 192
        Width = 547
        Height = 82
        Caption = 'D'#233'bito'
        TabOrder = 1
        object Label19: TLabel
          Left = 87
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtPorBad: TEditFocus
          Left = 244
          Top = 11
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbePorBad: TDBEditFocus
          Tag = 99
          Left = 179
          Top = 11
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CAR_PORBAD'
          DataSource = dtsCadCar
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
          OnKeyPress = dbePorBadKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
          OnChamaCadastro = dbePorBadChamaCadastro
        end
        inline fraCentroCustoD: TfraCentroCustoDBEditFocus
          Left = 6
          Top = 57
          Width = 538
          Height = 22
          TabOrder = 2
          ExplicitLeft = 6
          ExplicitTop = 57
          ExplicitWidth = 538
          inherited lblEventos: TLabel
            Left = 38
            Width = 132
            Height = 14
            Caption = 'Centro de Custos da Baixa:'
            ExplicitLeft = 38
            ExplicitWidth = 132
            ExplicitHeight = 14
          end
          inherited dbeCodEve: TDBEditFocus
            Left = 173
            Width = 64
            Height = 22
            DataField = 'CAR_EVEDEB'
            DataSource = dtsCadCar
            OnExit = fraCentroCustoDdbeCodEveExit
            PanelInfo = pnlInfo
            ExplicitLeft = 173
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesEve: TEditFocus
            Left = 238
            Width = 300
            Height = 22
            ExplicitLeft = 238
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
        inline fraPlanoDeContasDebito: TfraPlanoDeContasDBEditFocus
          Left = 46
          Top = 34
          Width = 499
          Height = 22
          TabOrder = 1
          ExplicitLeft = 46
          ExplicitTop = 34
          ExplicitWidth = 499
          inherited lblPlaContas: TLabel
            Left = 1
            Top = 5
            Width = 126
            Height = 14
            Caption = 'Plano de Contas da Baixa:'
            ExplicitLeft = 1
            ExplicitTop = 5
            ExplicitWidth = 126
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 133
            Width = 64
            Height = 22
            DataField = 'CAR_CTABAD'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasDebitodbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = dbeCtaBadChamaCadastro
            ExplicitLeft = 133
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 198
            Width = 300
            Height = 22
            ExplicitLeft = 198
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
      end
      object grpCancelamentos: TGroupBox
        Left = 3
        Top = 280
        Width = 547
        Height = 39
        Caption = 'Cancelamentos/Ajustes'
        TabOrder = 2
        inline fraPlanoDeContasCanc: TfraPlanoDeContasDBEditFocus
          Left = 7
          Top = 13
          Width = 538
          Height = 22
          TabOrder = 0
          ExplicitLeft = 7
          ExplicitTop = 13
          ExplicitWidth = 538
          inherited lblPlaContas: TLabel
            Left = 1
            Top = 3
            Width = 167
            Height = 14
            Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
            ExplicitLeft = 1
            ExplicitTop = 3
            ExplicitWidth = 167
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 172
            Width = 64
            Height = 22
            DataField = 'CAR_CTAAJU'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasCancdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasCancdbeCodCtaChamaCadastro
            ExplicitLeft = 172
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 237
            Width = 300
            Height = 22
            ExplicitLeft = 237
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
      end
      object grpCtaAnt: TGroupBox
        Left = 3
        Top = 320
        Width = 547
        Height = 39
        Caption = 'Antecipa'#231#245'es'
        TabOrder = 3
        inline fraPlanoDeContasAnt: TfraPlanoDeContasDBEditFocus
          Left = 6
          Top = 12
          Width = 539
          Height = 22
          TabOrder = 0
          ExplicitLeft = 6
          ExplicitTop = 12
          ExplicitWidth = 539
          inherited lblPlaContas: TLabel
            Left = 2
            Top = 3
            Width = 167
            Height = 14
            Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
            ExplicitLeft = 2
            ExplicitTop = 3
            ExplicitWidth = 167
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 173
            Width = 64
            Height = 22
            DataField = 'CAR_CTAANT'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasAntdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasAntdbeCodCtaChamaCadastro
            ExplicitLeft = 173
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 238
            Width = 300
            Height = 22
            ExplicitLeft = 238
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
      end
      object grpFretes: TGroupBox
        Left = 3
        Top = 364
        Width = 547
        Height = 39
        Caption = 'Fretes'
        TabOrder = 4
        Visible = False
        inline fraPlanoDeContasFrete: TfraPlanoDeContasDBEditFocus
          Left = 5
          Top = 12
          Width = 539
          Height = 22
          TabOrder = 0
          ExplicitLeft = 5
          ExplicitTop = 12
          ExplicitWidth = 539
          inherited lblPlaContas: TLabel
            Left = 2
            Top = 3
            Width = 167
            Height = 14
            Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
            ExplicitLeft = 2
            ExplicitTop = 3
            ExplicitWidth = 167
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 174
            Width = 64
            Height = 22
            DataField = 'CAR_CTAFRE'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasFretedbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasAntdbeCodCtaChamaCadastro
            ExplicitLeft = 174
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 239
            Width = 300
            Height = 22
            ExplicitLeft = 239
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
      end
      object grpExportacaoEquals: TGroupBox
        Left = 3
        Top = 474
        Width = 358
        Height = 64
        Caption = 'Exporta'#231#227'o Equals:'
        TabOrder = 6
        object lblAdquirinteEquals: TLabel
          Left = 39
          Top = 18
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Adquirinte:'
          WordWrap = True
        end
        object lblMeiosCapturaEquals: TLabel
          Left = 18
          Top = 41
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Meio de Captura:'
        end
        object cmbAdquirinteEquals: TDBLookupComboBox
          Tag = 99
          Left = 105
          Top = 14
          Width = 246
          Height = 22
          DataField = 'CAR_EQUADQ'
          DataSource = dtsCadCar
          KeyField = 'CODIGO'
          ListField = 'CODIGO;NOME'
          ListFieldIndex = 1
          TabOrder = 0
        end
        object cmbMeiosCapturaEquals: TDBLookupComboBox
          Tag = 99
          Left = 105
          Top = 37
          Width = 246
          Height = 22
          DataField = 'CAR_EQUCAP'
          DataSource = dtsCadCar
          KeyField = 'CODIGO'
          ListField = 'CODIGO;NOME'
          ListFieldIndex = 1
          TabOrder = 1
        end
      end
      object grpCupons: TGroupBox
        Left = 3
        Top = 407
        Width = 547
        Height = 39
        Caption = 'Cupons'
        TabOrder = 5
        Visible = False
        inline fraPlanoDeContasCupons: TfraPlanoDeContasDBEditFocus
          Left = 4
          Top = 13
          Width = 539
          Height = 22
          TabOrder = 0
          ExplicitLeft = 4
          ExplicitTop = 13
          ExplicitWidth = 539
          inherited lblPlaContas: TLabel
            Left = 2
            Top = 3
            Width = 167
            Height = 14
            Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
            ExplicitLeft = 2
            ExplicitTop = 3
            ExplicitWidth = 167
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 175
            Width = 64
            Height = 22
            DataField = 'CAR_CTACUP'
            DataSource = dtsCadCar
            OnKeyPress = fraPlanoDeContasCuponsdbeCodCtaKeyPress
            PanelInfo = pnlInfo
            OnChamaCadastro = fraPlanoDeContasAntdbeCodCtaChamaCadastro
            ExplicitLeft = 175
            ExplicitWidth = 64
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 240
            Width = 300
            Height = 22
            ExplicitLeft = 240
            ExplicitWidth = 300
            ExplicitHeight = 22
          end
        end
      end
    end
    object tabBaixaOtimizadaPorEmpresa: TTabSheet
      Caption = '&3 - Baixa Otimizada por Empresa (Concilia'#231#227'o)'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlTopoOtimizadaPorEmpresa: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 25
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object pnlAcoesOtimizada: TPanel
          Left = 1
          Top = 1
          Width = 804
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          Color = clGray
          Padding.Top = 1
          ParentBackground = False
          TabOrder = 0
          object btnIncluirDadosEmpresa: TBitBtnLocked
            Left = 0
            Top = 1
            Width = 76
            Height = 23
            Align = alLeft
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
            OnClick = btnIncluirDadosEmpresaClick
          end
          object btnAlterarDadosEmpresa: TBitBtnLocked
            Left = 76
            Top = 1
            Width = 76
            Height = 23
            Align = alLeft
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
            TabOrder = 1
            OnClick = btnAlterarDadosEmpresaClick
          end
          object btnExcluirDadosEmpresa: TBitBtnLocked
            Left = 152
            Top = 1
            Width = 76
            Height = 23
            Align = alLeft
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
            TabOrder = 2
            OnClick = btnExcluirDadosEmpresaClick
          end
          object btnCopiarDadosEmpresa: TBitBtnLocked
            Left = 228
            Top = 1
            Width = 221
            Height = 23
            Align = alLeft
            Caption = 'Copiar dados da empresa selecionada'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0002000000090000000E0000000F0000000F0000001000000010000000110000
              0011000000100000000B00000003000000000000000000000000000000000000
              00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
              5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
              000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
              EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
              000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
              E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
              000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
              E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
              000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
              E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
              0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
              E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
              0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
              EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
              0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
              EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
              0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
              EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
              0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
              F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
              0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
              FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
              0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
              84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
              000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
              EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
              0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
              FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
              00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
              93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
            TabOrder = 3
            OnClick = btnCopiarDadosEmpresaClick
          end
        end
      end
      object pnlDadosOtimizadaPorEmpresa: TPanel
        Left = 0
        Top = 25
        Width = 806
        Height = 628
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object grdDadosOtimizada: TcxGridCitel
          Left = 0
          Top = 0
          Width = 806
          Height = 628
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdDadosOtimizadaDados: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsConPor
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
            OptionsSelection.CellSelect = False
            OptionsView.FocusRect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdDadosOtimizadaDadosCON_CODEMP: TcxGridDBColumn
              Caption = 'Empresa'
              DataBinding.FieldName = 'CON_CODEMP'
              Width = 53
            end
            object grdDadosOtimizadaDadosCON_PORCRE: TcxGridDBColumn
              Caption = 'Portador Cr'#233'dito'
              DataBinding.FieldName = 'DESPORCRE'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_CTACRE: TcxGridDBColumn
              Caption = 'Pl. Contas Cr'#233'dito'
              DataBinding.FieldName = 'DESCTACRE'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_EVECRE: TcxGridDBColumn
              Caption = 'Ctr. Custos Cr'#233'dito'
              DataBinding.FieldName = 'DESEVECRE'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_PORTAX: TcxGridDBColumn
              Caption = 'Portador Taxa'
              DataBinding.FieldName = 'DESPORTAX'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_FORTAX: TcxGridDBColumn
              Caption = 'Fornecedor Taxa'
              DataBinding.FieldName = 'DESFORTAX'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_CTATAX: TcxGridDBColumn
              Caption = 'Pl. Contas Taxa'
              DataBinding.FieldName = 'DESCTATAX'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_EVETAX: TcxGridDBColumn
              Caption = 'Ctr. Custos Taxa'
              DataBinding.FieldName = 'DESEVETAX'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_PORDEB: TcxGridDBColumn
              Caption = 'Portador D'#233'bito'
              DataBinding.FieldName = 'DESPORDEB'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_CTADEB: TcxGridDBColumn
              Caption = 'Pl. Contas D'#233'bito'
              DataBinding.FieldName = 'DESCTADEB'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_EVEDEB: TcxGridDBColumn
              Caption = 'Ctr. Custos D'#233'bito'
              DataBinding.FieldName = 'DESEVEDEB'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_CTAAJU: TcxGridDBColumn
              Caption = 'Pl. Contas Canc./Ajuste'
              DataBinding.FieldName = 'DESCTAAJU'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_CTAANT: TcxGridDBColumn
              Caption = 'Pl. Contas Antecipa'#231#227'o'
              DataBinding.FieldName = 'DESCTAANT'
              Width = 147
            end
            object grdDadosOtimizadaDadosCON_CTAFRE: TcxGridDBColumn
              Caption = 'Pl. Contas Frete'
              DataBinding.FieldName = 'DESCTAFRE'
              Width = 159
            end
            object grdDadosOtimizadaDadosCON_CTACUP: TcxGridDBColumn
              Caption = 'Pl. Contas Cupom'
              DataBinding.FieldName = 'DESCTACUP'
              Width = 159
            end
          end
          object grdDadosOtimizadaNivel: TcxGridLevel
            GridView = grdDadosOtimizadaDados
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 65528
  end
  object dtsCadCar: TDataSource
    OnStateChange = dtsCadCarStateChange
    OnDataChange = dtsCadCarDataChange
    Left = 552
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -12
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = []
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 402
    Top = 65528
  end
  object dtsConPor: TDataSource
    AutoEdit = False
    Left = 644
    Top = 428
  end
end
