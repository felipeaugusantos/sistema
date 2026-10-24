inherited frmCadCartoesAlteracaoGlobal: TfrmCadCartoesAlteracaoGlobal
  Width = 1044
  Height = 761
  BorderIcons = []
  Caption = 'Altera'#231#227'o global de cart'#245'es '
  ExplicitWidth = 1044
  ExplicitHeight = 761
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 694
    Width = 1038
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 694
    ExplicitWidth = 1018
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 0
      Top = 0
      Width = 955
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 935
      inherited btnConfirma: TBitBtnLocked
        AlignWithMargins = True
        Left = 3
        Width = 105
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '[ F10 ] Confirmar'
        Glyph.Data = {00000000}
        ModalResult = 0
        ExplicitLeft = 3
        ExplicitWidth = 105
      end
      object btnMarcarTodas: TBitBtnLocked
        AlignWithMargins = True
        Left = 108
        Top = 0
        Width = 105
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 1
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        AlignWithMargins = True
        Left = 213
        Top = 0
        Width = 125
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 958
      Top = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      ExplicitLeft = 938
      ExplicitTop = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 716
    Width = 1038
    TabOrder = 3
    ExplicitTop = 716
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 859
      Width = 179
      ExplicitLeft = 839
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 859
      ExplicitWidth = 839
      object shpMultSel: TShape
        Left = 841
        Top = 2
        Width = 16
        Height = 12
        Hint = 'Cart'#245'es selecionados para serem alterados.'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 310
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object PgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 581
    Height = 694
    ActivePage = tbsGerais
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    ExplicitWidth = 591
    object tbsGerais: TTabSheet
      Caption = '&1 - Informa'#231#245'es Gerais'
      ImageIndex = 2
      ExplicitWidth = 562
      object Label5: TLabel
        Left = 91
        Top = 197
        Width = 48
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Prazo:'
      end
      object Label61: TLabel
        Left = 198
        Top = 197
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Caption = 'dias'
      end
      object lblCndPag: TLabel
        Left = 19
        Top = 220
        Width = 120
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. M'#237'nima de Parcelas'
      end
      object Label148: TLabel
        Left = 94
        Top = 243
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label7: TLabel
        Left = 197
        Top = 220
        Width = 113
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. M'#225'x. de  Parcelas:'
      end
      object Label13: TLabel
        Left = 93
        Top = 150
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Bandeira:'
      end
      object Label14: TLabel
        Left = 316
        Top = 197
        Width = 169
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Dias excedentes na 1'#170' parcela:'
      end
      object lbl1: TLabel
        Left = 367
        Top = 220
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor M'#237'nimo da parcela:'
      end
      object Label9: TLabel
        Left = 22
        Top = 290
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'CNPJ da administradora:'
      end
      object lbl2: TLabel
        Left = 90
        Top = 7
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo?'
      end
      object lbl3: TColorLabel
        Left = 174
        Top = 8
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label17: TLabel
        Left = 323
        Top = 289
        Width = 239
        Height = 14
        Alignment = taRightJustify
        Caption = '"/" para pesquisar administradoras/fornecedores.'
      end
      object Label6: TLabel
        Left = 63
        Top = 337
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Entrar no SPED:'
      end
      object ColorLabel1: TColorLabel
        Left = 174
        Top = 337
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblDesPlaCon: TLabel
        Left = 67
        Top = 361
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta Cont'#225'bil:'
      end
      object ColorLabel3: TColorLabel
        Left = 427
        Top = 314
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label24: TLabel
        Left = 282
        Top = 314
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Obrigat'#243'rio N'#250'm. NSU?'
      end
      object ColorLabel2: TColorLabel
        Left = 175
        Top = 314
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label22: TLabel
        Left = 3
        Top = 314
        Width = 137
        Height = 14
        Alignment = taRightJustify
        Caption = 'Obrigat'#243'rio N'#250'm. Libera'#231#227'o?'
      end
      object lblCodRed: TLabel
        Left = 6
        Top = 408
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
        Left = 76
        Top = 173
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Market Place:'
      end
      object ColorLabel5: TColorLabel
        Left = 195
        Top = 171
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblFornecedorFiscal: TLabel
        Left = 49
        Top = 431
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor Fiscal:'
      end
      object Label26: TLabel
        Left = 272
        Top = 266
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pr'#233'-Pago?'
      end
      object ColorLabel6: TColorLabel
        Left = 353
        Top = 266
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblParAdm: TLabel
        Left = 422
        Top = 265
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Parc. ADM?'
      end
      object lblParAdmSN: TColorLabel
        Left = 507
        Top = 266
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lbAdq: TLabel
        Left = 83
        Top = 126
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Adquirente:'
      end
      object ColorLabel9: TColorLabel
        Left = 174
        Top = 384
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label8: TLabel
        Left = 0
        Top = 377
        Width = 140
        Height = 28
        Alignment = taRightJustify
        Caption = 'Conta Cont'#225'bil desmembrada por empresa?'
        WordWrap = True
      end
      object Label10: TLabel
        Left = 68
        Top = 265
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Cart'#227'o:'
      end
      object ColorLabel10: TColorLabel
        Left = 172
        Top = 265
        Width = 83
        Height = 14
        Caption = '(C)r'#233'dito (D)'#233'bito'
        CorDestaque = clRed
      end
      object edtDesEmpresa: TEditFocus
        Left = 191
        Top = 239
        Width = 371
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
      object edtNomBan: TEditFocus
        Left = 191
        Top = 145
        Width = 244
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
      object edtDesPlaNco: TEditFocus
        Left = 241
        Top = 356
        Width = 208
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 24
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gbTxAdm: TGroupBox
        Left = 141
        Top = 31
        Width = 233
        Height = 88
        Caption = 'Taxa de Administra'#231#227'o'
        TabOrder = 1
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
        object edtPerdes: TEditFocus
          Tag = 99
          Left = 100
          Top = 15
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 0
          OnExit = edtPerdesExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTipTax: TEditFocus
          Tag = 99
          Left = 100
          Top = 38
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtTaxmin: TEditFocus
          Tag = 99
          Left = 100
          Top = 61
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 2
          OnExit = edtTaxminExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object edtDesCredenciadora: TEditFocus
        Left = 204
        Top = 405
        Width = 351
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
      object edtNomeFornecedorFiscal: TEditFocus
        Left = 204
        Top = 428
        Width = 351
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
        Left = 141
        Top = 454
        Width = 296
        Height = 46
        Caption = 'Arredondamento POS:'
        TabOrder = 28
        object ColorLabel11: TColorLabel
          Left = 39
          Top = 22
          Width = 248
          Height = 14
          Caption = '(P)Primeira Parcela   (U)'#218'ltima Parcela  (N)Nenhuma'
          WordWrap = True
          CorDestaque = clRed
        end
        object edtArredParcel: TEditFocus
          Tag = 99
          Left = 8
          Top = 17
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object edtNomAdq: TEditFocus
        Left = 191
        Top = 122
        Width = 244
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
      object gpbTipoTransacao: TGroupBox
        Left = 380
        Top = 44
        Width = 121
        Height = 72
        Caption = 'Tipo Transa'#231#227'o:'
        TabOrder = 2
        object ColorLabel7: TColorLabel
          Left = 61
          Top = 21
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label1: TLabel
          Left = 6
          Top = 22
          Width = 26
          Height = 13
          AutoSize = False
          Caption = 'POS:'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 6
          Top = 45
          Width = 26
          Height = 13
          AutoSize = False
          Caption = 'TEF:'
          WordWrap = True
        end
        object ColorLabel8: TColorLabel
          Left = 61
          Top = 44
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object edtTipoPos: TEditFocus
          Tag = 99
          Left = 32
          Top = 18
          Width = 27
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtTipoTEF: TEditFocus
          Tag = 99
          Left = 32
          Top = 41
          Width = 27
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
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
      object edtStatus: TEditFocus
        Tag = 99
        Left = 141
        Top = 4
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAdq: TEditFocus
        Tag = 99
        Left = 142
        Top = 122
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 3
        OnKeyPress = edtCodAdqKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodBan: TEditFocus
        Tag = 99
        Left = 142
        Top = 145
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 5
        OnKeyPress = edtCodBanKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPeriod: TEditFocus
        Left = 142
        Top = 192
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMktPlace: TEditFocus
        Tag = 99
        Left = 142
        Top = 168
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtExcDia: TEditFocus
        Left = 489
        Top = 192
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSugCPg: TEditFocus
        Left = 142
        Top = 216
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMaxPar: TEditFocus
        Left = 312
        Top = 216
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtParMin: TEditFocus
        Left = 489
        Top = 216
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 12
        OnExit = edtParMinExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 142
        Top = 239
        Width = 48
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 13
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPrePag: TEditFocus
        Tag = 99
        Left = 325
        Top = 263
        Width = 27
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtParAdm: TEditFocus
        Tag = 99
        Left = 479
        Top = 263
        Width = 27
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCnpj: TEditFocus
        Left = 142
        Top = 286
        Width = 175
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumCCD: TEditFocus
        Tag = 99
        Left = 142
        Top = 310
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumNsu: TEditFocus
        Tag = 99
        Left = 397
        Top = 310
        Width = 28
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEntSped: TEditFocus
        Tag = 99
        Left = 142
        Top = 333
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtConCon: TEditFocus
        Left = 142
        Top = 356
        Width = 307
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtplaNco: TEditFocus
        Left = 142
        Top = 356
        Width = 97
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 22
        OnExit = edtplaNcoExit
        OnKeyPress = edtplaNcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodRed: TEditFocus
        Left = 142
        Top = 405
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 26
        OnExit = edtCodRedExit
        OnKeyPress = edtCodRedKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodForFis: TEditFocus
        Tag = 99
        Left = 142
        Top = 428
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 8
        TabOrder = 27
        OnKeyPress = edtCodForFisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCarDesmem: TEditFocus
        Tag = 99
        Left = 142
        Top = 380
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTipCar: TEditFocus
        Tag = 99
        Left = 142
        Top = 262
        Width = 29
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gbDadosTef: TGroupBox
        Left = 5
        Top = 505
        Width = 565
        Height = 144
        Caption = '   Dados para TEF   '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 31
        object gbTefTrocaArquivo: TGroupBox
          Left = 8
          Top = 15
          Width = 255
          Height = 122
          Caption = '   Via Troca de Arquivos   '
          TabOrder = 0
          object Label11: TLabel
            Left = 5
            Top = 24
            Width = 104
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
          object Label12: TLabel
            Left = 5
            Top = 70
            Width = 104
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
            Left = 5
            Top = 48
            Width = 104
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
          object edtNomBanTEF: TEditFocus
            Left = 110
            Top = 42
            Width = 121
            Height = 22
            Hint = 'Campo 040-000 do arquivo INTPOS.001.'
            Alignment = taLeftJustify
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTipTraTEF: TEditFocus
            Left = 110
            Top = 67
            Width = 35
            Height = 22
            Hint = 'Campo 011-000 do arquivo INTPOS.001.'
            Alignment = taLeftJustify
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtNomRedTEF: TEditFocus
            Left = 110
            Top = 16
            Width = 121
            Height = 22
            Hint = 'Campo 010-000 do arquivo INTPOS.001.'
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
        end
        object gbTefViaDLL: TGroupBox
          Left = 267
          Top = 15
          Width = 293
          Height = 122
          Caption = '   Via DLL   '
          TabOrder = 1
          object lbCodBandeira: TLabel
            Left = 3
            Top = 55
            Width = 80
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
            Left = 3
            Top = 32
            Width = 80
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
            Left = 3
            Top = 101
            Width = 80
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
          object Label16: TLabel
            Left = 86
            Top = 10
            Width = 79
            Height = 14
            Caption = 'Fiserv-ClisiTef'
          end
          object Label18: TLabel
            Left = 178
            Top = 10
            Width = 112
            Height = 14
            Caption = 'Conex'#227'oTech-Scope'
          end
          object lbTipDeb: TLabel
            Left = 2
            Top = 76
            Width = 80
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
          object ColorLabel12: TColorLabel
            Left = 121
            Top = 78
            Width = 135
            Height = 14
            Caption = '(0)A Vista   (1)Pr'#233' Datado'
            CorDestaque = clRed
          end
          object edtTFTOPE: TEditFocus
            Left = 86
            Top = 27
            Width = 87
            Height = 22
            Hint = 'Campo grvado na TEFTRA, coluna TFT_CODRED'
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
          object edtTFTRED: TEditFocus
            Left = 86
            Top = 50
            Width = 87
            Height = 22
            Hint = 'Campo grvado na TEFTRA, coluna TFT_CODBAN'
            Alignment = taLeftJustify
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCardSE: TEditFocus
            Left = 86
            Top = 96
            Width = 87
            Height = 22
            Hint = 'C'#243'digo da Carteira Digital'
            Alignment = taLeftJustify
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTipDeb: TEditFocus
            Tag = 99
            Left = 86
            Top = 73
            Width = 29
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 1
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTFRED2: TEditFocus
            Left = 178
            Top = 27
            Width = 79
            Height = 22
            Hint = 'Campo grvado na TEFTRA, coluna TFT_CODRED'
            Alignment = taLeftJustify
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTFBAN2: TEditFocus
            Left = 178
            Top = 50
            Width = 79
            Height = 22
            Hint = 'Campo grvado na TEFTRA, coluna TFT_CODBAN'
            Alignment = taLeftJustify
            TabOrder = 5
            NormalColor = clWindow
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
    object tsBaixaOtimizada: TTabSheet
      Caption = '&2 - Informa'#231#245'es para Baixa Otimizada de Cart'#245'es'
      ImageIndex = 1
      ExplicitWidth = 562
      object gbCredito: TGroupBox
        Left = 0
        Top = 0
        Width = 573
        Height = 176
        Align = alTop
        Caption = 'Cr'#233'dito/Taxa'
        TabOrder = 0
        ExplicitWidth = 562
        object lblPORBAI: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object lblCTABAI: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblEVECRE: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblPORTAX: TLabel
          Left = 49
          Top = 84
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Taxa da Baixa:'
        end
        object lblFORTAX: TLabel
          Left = 34
          Top = 106
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor da Taxa da Baixa:'
        end
        object lblCTATAX: TLabel
          Left = 12
          Top = 130
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Taxa da Baixa:'
        end
        object lblEVETAX: TLabel
          Left = 6
          Top = 153
          Width = 173
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Taxa da Baixa:'
        end
        object edtPORBAI: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtPORBAIExit
          OnKeyPress = edtPORBAIKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtCTABAI: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 2
          OnExit = edtCTABAIExit
          OnKeyPress = edtCTABAIKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtEVECRE: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 4
          OnKeyPress = edtEVECREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
        end
        object edtPORTAX: TEditFocus
          Left = 182
          Top = 81
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 6
          OnExit = edtPORTAXExit
          OnKeyPress = edtPORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtFORTAX: TEditFocus
          Left = 182
          Top = 104
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          NumbersOnly = True
          TabOrder = 8
          OnKeyPress = edtFORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtCTATAX: TEditFocus
          Left = 182
          Top = 127
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 10
          OnExit = edtCTATAXExit
          OnKeyPress = edtCTATAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtEVETAX: TEditFocus
          Left = 182
          Top = 150
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 12
          OnKeyPress = edtEVETAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
        end
        object edtPORBAINome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
        object edtCTABAINome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEVECRENome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
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
        object edtPORTAXNome: TEditFocus
          Left = 247
          Top = 81
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtFORTAXNome: TEditFocus
          Left = 247
          Top = 104
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCTATAXNome: TEditFocus
          Left = 247
          Top = 127
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEVETAXNome: TEditFocus
          Left = 247
          Top = 150
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
      end
      object gbDebito: TGroupBox
        Left = 0
        Top = 176
        Width = 573
        Height = 84
        Align = alTop
        Caption = 'D'#233'bito'
        TabOrder = 1
        ExplicitWidth = 562
        object lblEVEDEB: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblCTABAD: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblPORBAD: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object edtEVEDEB: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 4
          OnKeyPress = edtEVEDEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttNumerico
        end
        object edtCTABAD: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 2
          OnExit = edtCTABADExit
          OnKeyPress = edtCTABADKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtPORBAD: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtPORBADExit
          OnKeyPress = edtPORBADKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtEVEDEBNome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
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
        object edtCTABADNome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPORBADNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbCancelamentos: TGroupBox
        Left = 0
        Top = 260
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Cancelamentos/Ajustes'
        TabOrder = 2
        ExplicitWidth = 562
        object lblCTAAJU: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTAAJU: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTAAJUExit
          OnKeyPress = edtCTAAJUKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTAAJUNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbAntecipacoes: TGroupBox
        Left = 0
        Top = 298
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Antecipa'#231#245'es'
        TabOrder = 3
        ExplicitWidth = 562
        object lblCTAANT: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTAANT: TEditFocus
          Left = 181
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTAANTExit
          OnKeyPress = edtCTAANTKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTAANTNome: TEditFocus
          Left = 246
          Top = 12
          Width = 300
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
      object gbFretes: TGroupBox
        Left = 0
        Top = 336
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Fretes'
        TabOrder = 4
        ExplicitWidth = 562
        object lblCTAFRE: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTAFRE: TEditFocus
          Left = 181
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTAFREExit
          OnKeyPress = edtCTAFREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTAFRENome: TEditFocus
          Left = 246
          Top = 12
          Width = 300
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
      object gbCupons: TGroupBox
        Left = 0
        Top = 374
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Cupons'
        TabOrder = 5
        ExplicitWidth = 562
        object lblCTACUP: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtCTACUP: TEditFocus
          Left = 181
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtCTACUPExit
          OnKeyPress = edtCTACUPKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 7
          TipoTexto = ttNumerico
        end
        object edtCTACUPNome: TEditFocus
          Left = 246
          Top = 12
          Width = 300
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
      object grpExportacaoEquals: TGroupBox
        Left = 0
        Top = 412
        Width = 573
        Height = 64
        Align = alTop
        Caption = 'Exporta'#231#227'o Equals'
        TabOrder = 6
        ExplicitWidth = 562
        object lblEQUADQ: TLabel
          Left = 118
          Top = 15
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Adquirinte:'
          WordWrap = True
        end
        object lblEQUCAP: TLabel
          Left = 97
          Top = 38
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Meio de Captura:'
        end
        object cmbEQUADQ: TDBLookupComboBox
          Tag = 99
          Left = 181
          Top = 11
          Width = 365
          Height = 22
          DataField = 'CAR_EQUADQ'
          KeyField = 'CODIGO'
          ListField = 'CODIGO;NOME'
          ListFieldIndex = 1
          TabOrder = 0
        end
        object cmbEQUCAP: TDBLookupComboBox
          Tag = 99
          Left = 181
          Top = 34
          Width = 365
          Height = 22
          DataField = 'CAR_EQUCAP'
          KeyField = 'CODIGO'
          ListField = 'CODIGO;NOME'
          ListFieldIndex = 1
          TabOrder = 1
        end
      end
    end
    object TsBaixaOtimizadaPorEmpresa: TTabSheet
      Caption = '&3 - Baixa Otimizada por Empresa (Concilia'#231#227'o)'
      ExplicitWidth = 562
      object gbPorEmpresaCredito: TGroupBox
        Left = 0
        Top = 22
        Width = 573
        Height = 176
        Align = alTop
        Caption = 'Cr'#233'dito/Taxa'
        TabOrder = 1
        ExplicitWidth = 562
        object lblPorEmpresaPORBAI: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object lblPorEmpresaCTABAI: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblPorEmpresaEVECRE: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblPorEmpresaPORTAX: TLabel
          Left = 49
          Top = 84
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Taxa da Baixa:'
        end
        object lblPorEmpresaFORTAX: TLabel
          Left = 34
          Top = 106
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor da Taxa da Baixa:'
        end
        object lblPorEmpresaCTATAX: TLabel
          Left = 12
          Top = 130
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Taxa da Baixa:'
        end
        object lblPorEmpresaEVETAX: TLabel
          Left = 6
          Top = 153
          Width = 173
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Taxa da Baixa:'
        end
        object edtPorEmpresaPORCRE: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaPORCREExit
          OnKeyPress = edtPorEmpresaPORCREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTACRE: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnExit = edtPorEmpresaCTACREExit
          OnKeyPress = edtPorEmpresaCTACREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVECRE: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          OnExit = edtPorEmpresaEVECREExit
          OnKeyPress = edtPorEmpresaEVECREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORTAX: TEditFocus
          Left = 182
          Top = 81
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          OnExit = edtPorEmpresaPORTAXExit
          OnKeyPress = edtPorEmpresaPORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaFORTAX: TEditFocus
          Left = 182
          Top = 104
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          OnExit = edtPorEmpresaFORTAXExit
          OnKeyPress = edtPorEmpresaFORTAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTATAX: TEditFocus
          Left = 182
          Top = 127
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          OnExit = edtPorEmpresaCTATAXExit
          OnKeyPress = edtPorEmpresaCTATAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVETAX: TEditFocus
          Left = 182
          Top = 150
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          OnExit = edtPorEmpresaEVETAXExit
          OnKeyPress = edtPorEmpresaEVETAXKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORCRENome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
        object edtPorEmpresaCTACRENome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorEmpresaEVECRENome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
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
        object edtPorEmpresaPORTAXNome: TEditFocus
          Left = 247
          Top = 81
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorEmpresaFORTAXNome: TEditFocus
          Left = 247
          Top = 104
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtPorEmpresaCTATAXNome: TEditFocus
          Left = 247
          Top = 127
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorEmpresaEVETAXNome: TEditFocus
          Left = 247
          Top = 150
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
      end
      object gbPorEmpresaDebito: TGroupBox
        Left = 0
        Top = 198
        Width = 573
        Height = 84
        Align = alTop
        Caption = 'D'#233'bito'
        TabOrder = 2
        ExplicitWidth = 562
        object lblPorEmpresaEVEDEB: TLabel
          Left = 47
          Top = 61
          Width = 132
          Height = 14
          Alignment = taRightJustify
          Caption = 'Centro de Custos da Baixa:'
        end
        object lblPorEmpresaCTABAD: TLabel
          Left = 53
          Top = 38
          Width = 126
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Baixa:'
        end
        object lblPorEmpresaPORBAD: TLabel
          Left = 90
          Top = 15
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object edtPorEmpresaEVEDEB: TEditFocus
          Left = 182
          Top = 58
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          OnExit = edtPorEmpresaEVEDEBExit
          OnKeyPress = edtPorEmpresaEVEDEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTADEB: TEditFocus
          Left = 182
          Top = 35
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnExit = edtPorEmpresaCTADEBExit
          OnKeyPress = edtPorEmpresaCTADEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaPORDEB: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaPORDEBExit
          OnKeyPress = edtPorEmpresaPORDEBKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaEVEDEBNome: TEditFocus
          Left = 247
          Top = 58
          Width = 300
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
        object edtPorEmpresaCTADEBNome: TEditFocus
          Left = 247
          Top = 35
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorEmpresaPORDEBNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaCancelamentos: TGroupBox
        Left = 0
        Top = 282
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Cancelamentos/Ajustes'
        TabOrder = 3
        ExplicitWidth = 562
        object lblPorEmpresaCTAAJU: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTAAJU: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTAAJUExit
          OnKeyPress = edtPorEmpresaCTAAJUKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTAAJUNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaAntecipacoes: TGroupBox
        Left = 0
        Top = 320
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Antecipa'#231#245'es'
        TabOrder = 4
        ExplicitWidth = 562
        object lblPorEmpresaCTAANT: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTAANT: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTAANTExit
          OnKeyPress = edtPorEmpresaCTAANTKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTAANTNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaFretes: TGroupBox
        Left = 0
        Top = 358
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Fretes'
        TabOrder = 5
        ExplicitWidth = 562
        object lblPorEmpresaCTAFRE: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTAFRE: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTAFREExit
          OnKeyPress = edtPorEmpresaCTAFREKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTAFRENome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object gbPorEmpresaCupons: TGroupBox
        Left = 0
        Top = 396
        Width = 573
        Height = 38
        Align = alTop
        Caption = 'Cupons'
        TabOrder = 6
        ExplicitWidth = 562
        object lblPorEmpresaCTACUP: TLabel
          Left = 12
          Top = 15
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Plano de Contas da Mov. Banc'#225'ria:'
        end
        object edtPorEmpresaCTACUP: TEditFocus
          Left = 182
          Top = 12
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCTACUPExit
          OnKeyPress = edtPorEmpresaCTACUPKeyPress
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPorEmpresaCTACUPNome: TEditFocus
          Left = 247
          Top = 12
          Width = 300
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
      object pnlPorEmpresaCODEMP: TPanel
        Left = 0
        Top = 0
        Width = 573
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 562
        object lblPorEmpresaCODEMP: TLabel
          Left = 134
          Top = 3
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object edtPorEmpresaCODEMPNome: TEditFocus
          Left = 247
          Top = 0
          Width = 300
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
        object edtPorEmpresaCODEMP: TEditFocus
          Left = 182
          Top = 0
          Width = 64
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtPorEmpresaCODEMPExit
          OnKeyPress = edtPorEmpresaCODEMPKeyPress
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
  object GridCartoes: TcxGrid [3]
    AlignWithMargins = True
    Left = 584
    Top = 0
    Width = 451
    Height = 693
    Margins.Top = 0
    Margins.Bottom = 1
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 572
    object TableViewCartoes: TcxGridDBTableView
      OnDblClick = TableViewCartoesDblClick
      OnKeyDown = TableViewCartoesKeyDown
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.FocusViewOnApplyFilter = True
      FindPanel.InfoText = 'Digite para pesquisar'
      FindPanel.ShowClearButton = False
      FindPanel.ShowFindButton = False
      OnCustomDrawCell = TableViewCartoesCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' cart'#245'es cadastrados'
      OptionsView.GroupByBox = False
      Styles.ContentOdd = styleZebraOdd
      object TableViewCartoesMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bFalse
      end
      object TableViewCartoesCODCAR: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CAR_CODCAR'
        Width = 45
      end
      object TableViewCartoesDESCAR: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CAR_DESCAR'
        Width = 190
      end
      object TableViewCartoesEMPRESA: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPRESA'
        Width = 185
      end
    end
    object GridCartoesLevel: TcxGridLevel
      GridView = TableViewCartoes
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 152
  end
  object dtsCartoes: TDataSource
    AutoEdit = False
    Left = 492
    Top = 212
  end
  object styleGridCartoes: TcxStyleRepository
    Left = 452
    Top = 242
    PixelsPerInch = 96
    object styleZebraOdd: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
