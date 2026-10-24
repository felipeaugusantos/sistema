inherited frmEntDadosCaixa2: TfrmEntDadosCaixa2
  Left = 240
  Top = 311
  Height = 477
  VertScrollBar.Range = 26
  Anchors = [akRight, akBottom]
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Valores'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitHeight = 477
  PixelsPerInch = 96
  TextHeight = 14
  object pgbDados: TProgressBar [0]
    Left = 0
    Top = 422
    Width = 769
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 3
  end
  inherited pnlBotoes: TPanel
    Top = 432
    ExplicitTop = 432
    inherited FlwBotoes: TFlowPanel
      ExplicitWidth = 765
    end
    inherited btnSair: TBitBtnLocked
      Left = 571
      ExplicitLeft = 571
    end
  end
  inherited pnlStatus: TPanel
    Top = 432
    ExplicitTop = 432
    inherited pnlNomeForm: TPanel
      Left = 585
      Width = 184
      ExplicitLeft = 585
      ExplicitWidth = 184
    end
    inherited pnlInfo: TPanel
      Width = 585
      ExplicitWidth = 585
    end
  end
  inherited pgcDados: TPageControl
    Top = 115
    Height = 260
    Visible = False
    ExplicitTop = 115
    ExplicitHeight = 260
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 228
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 41
    Width = 769
    Height = 74
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label3: TLabel
      Left = 52
      Top = 30
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. Frete:'
    end
    object Label28: TLabel
      Left = 31
      Top = 6
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total de Itens:'
    end
    object Label29: TLabel
      Left = 447
      Top = 30
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label4: TLabel
      Left = 323
      Top = 30
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object lbl1: TLabel
      Left = 180
      Top = 30
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Aces.:'
    end
    object edtValFre: TEditFocus
      Tag = 99
      Left = 102
      Top = 26
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnExit = edtValFreExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#0.00'
    end
    object edtTotIte: TEditFocus
      Left = 102
      Top = 3
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtVlrCon: TEditFocus
      Left = 505
      Top = 26
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesEsp: TEditFocus
      Tag = 99
      Left = 375
      Top = 26
      Width = 64
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnExit = edtDesEspExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesAce: TEditFocus
      Tag = 99
      Left = 246
      Top = 26
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnCalculaTotais: TBitBtnLocked
      Tag = 99
      Left = 590
      Top = 26
      Width = 111
      Height = 22
      Caption = '&Calcula Totais'
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
      TabOrder = 5
      OnClick = btnCalculaTotaisClick
    end
    object pnlTipoFrete: TPanel
      Left = 1
      Top = 49
      Width = 767
      Height = 24
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object lbl2: TLabel
        Left = 20
        Top = 4
        Width = 76
        Height = 14
        Caption = 'Rateio do Frete:'
      end
      object cbbTipFre: TComboBoxFocus
        Tag = 99
        Left = 101
        Top = 1
        Width = 177
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbbTipFreChange
        Items.Strings = (
          'Proporcional ao Valor do Item'
          'Proporcional ao Peso do Item'
          'Proporcional a Quantidade de Item')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
  end
  object pnlContasPagar: TPanel [5]
    Left = 0
    Top = 115
    Width = 769
    Height = 260
    Align = alClient
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 5
    object lblCodOpe: TLabel
      Left = 48
      Top = 13
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object Label7: TLabel
      Left = 10
      Top = 101
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pagamento:'
    end
    object Label1: TLabel
      Left = 428
      Top = 79
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblCodDig: TLabel
      Left = 426
      Top = 13
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
      Visible = False
    end
    object lblCodRep: TLabel
      Left = 398
      Top = 101
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Representante:'
    end
    object Label10: TLabel
      Left = 418
      Top = 125
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mod. Frete:'
    end
    object lblInfCtp: TLabel
      Left = 6
      Top = 142
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observ. Cta Pagar:'
    end
    object lblNumAD: TLabel
      Left = 248
      Top = 35
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do AD:'
    end
    object lblPesBru: TLabel
      Left = 415
      Top = 147
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Bruto:'
    end
    object lblPesLiq: TLabel
      Left = 580
      Top = 147
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso L'#237'quido:'
    end
    object lblCredFor: TLabel
      Left = 398
      Top = 236
      Width = 335
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Credito com este Fornecedor no valor de'
      Font.Charset = ANSI_CHARSET
      Font.Color = 213
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      StyleElements = [seClient, seBorder]
    end
    object Label6: TLabel
      Left = 405
      Top = 171
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Volumes:'
    end
    object Label2: TLabel
      Left = 576
      Top = 171
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object lblBcoFor: TLabel
      Left = 63
      Top = 57
      Width = 31
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = 'Conta:'
      ParentBiDiMode = False
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 102
      Top = 9
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 97
      Width = 273
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 7
      Text = ''
      OnExit = mskCndPagExit
      OnKeyPress = mskCndPagKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 476
      Top = 75
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 14
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomOpe: TEditFocus
      Left = 144
      Top = 9
      Width = 233
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
    object edtNomPor: TEditFocus
      Left = 532
      Top = 75
      Width = 181
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 476
      Top = 9
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 11
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 532
      Top = 9
      Width = 181
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 17
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 476
      Top = 97
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 18
      OnKeyPress = edtCodRepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomRep: TEditFocus
      Left = 532
      Top = 97
      Width = 181
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkGraFin: TCheckBox
      Left = 102
      Top = 123
      Width = 120
      Height = 17
      Caption = 'Gravar Financeiro'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 8
      OnClick = chkGraFinClick
    end
    object chkImprCp: TCheckBox
      Left = 236
      Top = 123
      Width = 77
      Height = 17
      Caption = 'Imprime CP'
      Enabled = False
      TabOrder = 9
    end
    object mmoHisCta: TMemoFocus
      Left = 102
      Top = 142
      Width = 275
      Height = 98
      ScrollBars = ssBoth
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object chkPgoAnt: TCheckBox
      Left = 101
      Top = 78
      Width = 166
      Height = 17
      Caption = 'Utilizar Pagamento Antecipado'
      TabOrder = 5
      OnClick = chkPgoAntClick
    end
    object edtNumAD: TEditFocus
      Tag = 99
      Left = 321
      Top = 31
      Width = 56
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      ReadOnly = True
      TabOrder = 3
      OnKeyPress = edtNumADKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtPesBru: TEditFocus
      Tag = 99
      Left = 476
      Top = 144
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 21
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
    object edtPesLiq: TEditFocus
      Tag = 99
      Left = 649
      Top = 144
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 23
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
    object chkAtuPre: TCheckBox
      Left = 476
      Top = 203
      Width = 260
      Height = 17
      Caption = 'N'#227'o atualizar pre'#231'os automaticamente no produto'
      TabOrder = 22
      OnClick = chkAtuPreClick
    end
    object btnPgoAnt: TBitBtnLocked
      Left = 270
      Top = 75
      Width = 41
      Height = 22
      Enabled = False
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
      TabOrder = 6
      OnClick = btnPgoAntClick
    end
    object cbxModFre: TComboBox
      Left = 476
      Top = 120
      Width = 93
      Height = 22
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 19
      Text = '3-TERCEIROS '
      OnChange = cbxModFreChange
      Items.Strings = (
        '1-CIF '
        '2-FOB '
        '3-TERCEIROS '
        '9-SEM FRETE')
    end
    object chkVeioBo: TCheckBox
      Left = 88
      Top = 34
      Width = 83
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Veio Boleto'
      ParentBiDiMode = False
      TabOrder = 1
    end
    object chkDeposi: TCheckBox
      Left = 176
      Top = 35
      Width = 65
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Dep'#243'sito'
      ParentBiDiMode = False
      TabOrder = 2
      OnClick = chkDeposiClick
    end
    object edtQtdVol: TEditFocus
      Tag = 99
      Left = 476
      Top = 167
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 24
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
    object edtEspVol: TEditFocus
      Tag = 99
      Left = 622
      Top = 167
      Width = 92
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 10
      TabOrder = 25
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object cbxBcoFor: TComboBoxFocus
      Left = 102
      Top = 53
      Width = 275
      Height = 22
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = cbxBcoForChange
      OnDropDown = cbxBcoForDropDown
      OnEnter = cbxBcoForEnter
      OnExit = cbxBcoForExit
      OnKeyUp = cbxBcoForKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 382
      Top = 31
      Width = 350
      Height = 22
      TabOrder = 12
      ExplicitLeft = 382
      ExplicitTop = 31
      ExplicitWidth = 350
      inherited lblEventos: TLabel
        Left = 3
        Width = 87
        Height = 14
        ExplicitLeft = 3
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Height = 22
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Width = 181
        Height = 22
        ExplicitWidth = 181
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 387
      Top = 53
      Width = 330
      Height = 22
      TabOrder = 13
      ExplicitLeft = 387
      ExplicitTop = 53
      ExplicitWidth = 330
      inherited lblPlaContas: TLabel
        Width = 81
        Height = 14
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 145
        Width = 181
        Height = 22
        ExplicitLeft = 145
        ExplicitWidth = 181
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 89
        Width = 55
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 89
        ExplicitWidth = 55
        ExplicitHeight = 22
      end
    end
  end
  object pnlBotoesEnt: TPanel [6]
    Left = 0
    Top = 375
    Width = 769
    Height = 47
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object FlwPnlBotoesEnt: TFlowPanel
      Left = 1
      Top = 1
      Width = 767
      Height = 45
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ F10 ] Confirma'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnImpEspelho: TBitBtnLocked
        Left = 151
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ F7 ] Imprime Espelho'
        TabOrder = 1
        OnClick = btnImpEspelhoClick
      end
      object btnConFre: TBitBtnLocked
        Left = 302
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ F5 ] Conhecimento de Frete'
        TabOrder = 2
        OnClick = btnConFreClick
      end
      object btnConfDigitacao: TBitBtnLocked
        Left = 453
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ F4 ] Confer'#234'ncia Digita'#231#227'o'
        TabOrder = 3
        OnClick = btnConfDigitacaoClick
      end
      object btnGnre: TBitBtnLocked
        Left = 604
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ F2 ] GNRE'
        TabOrder = 4
        OnClick = btnGnreClick
      end
      object btnDesmembraValores: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 151
        Height = 22
        Caption = '[ F3 ] Desmembra Valores'
        TabOrder = 5
        OnClick = btnDesmembraValoresClick
      end
      object btnVendor: TBitBtnLocked
        Left = 151
        Top = 22
        Width = 151
        Height = 22
        Caption = '[ F6 ] Vendor'
        TabOrder = 6
        OnClick = btnVendorClick
      end
      object btnOutDes: TBitBtnLocked
        Left = 302
        Top = 22
        Width = 151
        Height = 22
        Caption = '[ F8 ] Outras Desp.'
        TabOrder = 7
        OnClick = btnOutDesClick
      end
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 605
      Top = 23
      Width = 151
      Height = 22
      Caption = '[ Esc ] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
    end
  end
  object pnlTipoOP: TPanel [7]
    Left = 0
    Top = 0
    Width = 769
    Height = 41
    Align = alTop
    Caption = 'pnlTipoOP'
    ShowCaption = False
    TabOrder = 7
    object rdgTipoEntrada: TRadioGroup
      Left = 1
      Top = 1
      Width = 767
      Height = 39
      Align = alClient
      Caption = 'Tipo de Entrada'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Entrada por Compra'
        'Entrada por Garantia')
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 736
    Top = 176
  end
end
