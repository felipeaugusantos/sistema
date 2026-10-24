inherited frmEntDadosFiscaisResumo: TfrmEntDadosFiscaisResumo
  Left = 163
  Top = 183
  Width = 1185
  Height = 752
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Dados Fiscais - Resumo'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1185
  ExplicitHeight = 752
  PixelsPerInch = 96
  TextHeight = 14
  object pgbDadosFiscais: TProgressBar [0]
    Left = 0
    Top = 676
    Width = 1179
    Height = 7
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
    ExplicitWidth = 1044
  end
  inherited pnlBotoes: TPanel
    Top = 683
    Width = 1179
    ExplicitTop = 683
    ExplicitWidth = 1044
    DesignSize = (
      1179
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1175
      ExplicitWidth = 1040
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 707
    Width = 1179
    ExplicitTop = 707
    ExplicitWidth = 1044
    inherited pnlNomeForm: TPanel
      Left = 990
      Width = 189
      ExplicitLeft = 855
      ExplicitWidth = 189
    end
    inherited pnlInfo: TPanel
      Width = 990
      ExplicitWidth = 855
    end
  end
  inherited pgcDados: TPageControl
    Top = 235
    Width = 1179
    Height = 441
    Visible = False
    ExplicitTop = 235
    ExplicitWidth = 1044
    ExplicitHeight = 441
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1036
      ExplicitHeight = 409
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1179
    Height = 46
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitWidth = 1044
    object Label1: TLabel
      Left = 202
      Top = 6
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. Substitui'#231#227'o:'
    end
    object Label2: TLabel
      Left = 388
      Top = 6
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Acessoria:'
    end
    object Label3: TLabel
      Left = 236
      Top = 27
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. Frete:'
    end
    object Label4: TLabel
      Left = 76
      Top = 27
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. IPI:'
    end
    object Label5: TLabel
      Left = 422
      Top = 27
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object Label28: TLabel
      Left = 40
      Top = 6
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total de Itens:'
    end
    object Label29: TLabel
      Left = 608
      Top = 27
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label32: TLabel
      Left = 560
      Top = 6
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr. ICMS Antecipado:'
    end
    object edtValSub: TEditFocus
      Left = 286
      Top = 2
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
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesAce: TEditFocus
      Left = 476
      Top = 2
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
    object edtValFre: TEditFocus
      Left = 286
      Top = 23
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
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#0.00'
    end
    object edtValIpi: TEditFocus
      Left = 110
      Top = 23
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
      TabOrder = 1
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
      Left = 476
      Top = 23
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
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotIte: TEditFocus
      Left = 110
      Top = 2
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
      Left = 666
      Top = 23
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
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValAnt: TEditFocus
      Left = 666
      Top = 2
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
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlContasPagar: TPanel [5]
    Left = 0
    Top = 46
    Width = 1179
    Height = 189
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    ExplicitWidth = 1044
    object lblCodOpe: TLabel
      Left = 31
      Top = 5
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object lblCondPgto: TLabel
      Left = 25
      Top = 84
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pag.:'
    end
    object Label30: TLabel
      Left = 558
      Top = 50
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblCodDig: TLabel
      Left = 673
      Top = 4
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
      Visible = False
    end
    object lblCodRep: TLabel
      Left = 804
      Top = 49
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Represent.:'
    end
    object lblChaNFE: TLabel
      Left = 546
      Top = 113
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chave NFE:'
    end
    object lblInfCtp: TLabel
      Left = 4
      Top = 125
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs. Cta Pagar:'
    end
    object lblCodCon: TLabel
      Left = 3
      Top = 106
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Cont'#225'bil:'
    end
    object lblModFre: TLabel
      Left = 542
      Top = 71
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mod. Frete:'
    end
    object lblPesBru: TLabel
      Left = 882
      Top = 94
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Bruto:'
    end
    object lblPesLiq: TLabel
      Left = 788
      Top = 92
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso L'#237'q.:'
    end
    object lblTemPgtoAntecipado: TLabel
      Left = 362
      Top = 26
      Width = 154
      Height = 28
      AutoSize = False
      Caption = 'Fornecedor possui pagamento antecipado'
      Font.Charset = ANSI_CHARSET
      Font.Color = 213
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
      StyleElements = [seClient, seBorder]
    end
    object lblQtdVol: TLabel
      Left = 535
      Top = 94
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Volumes:'
    end
    object lblEspVol: TLabel
      Left = 658
      Top = 93
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object lblBcoFor: TLabel
      Left = 49
      Top = 63
      Width = 31
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = 'Conta:'
      ParentBiDiMode = False
    end
    object lblCODMOD: TLabel
      Left = 565
      Top = 132
      Width = 37
      Height = 14
      Caption = 'Modelo:'
    end
    object lblCredFor: TLabel
      Left = 459
      Top = 171
      Width = 351
      Height = 13
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
    object lblCompet: TLabel
      Left = 537
      Top = 4
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Compet'#234'ncia:'
    end
    object lblHistorioLivroFiscal: TLabel
      Left = 520
      Top = 154
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist. Livro Fiscal:'
    end
    object lblPagamentoCartaoCredito: TLabel
      Left = 305
      Top = 105
      Width = 216
      Height = 14
      Caption = 'Possui pedidos com pag. por cart'#227'o de cr'#233'd.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 82
      Top = 80
      Width = 434
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
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
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 82
      Top = 2
      Width = 40
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 602
      Top = 45
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 17
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
      Left = 126
      Top = 2
      Width = 393
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
    object edtNomPor: TEditFocus
      Left = 660
      Top = 45
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
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 720
      Top = 1
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 14
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
      Left = 776
      Top = 1
      Width = 260
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 29
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
      Left = 861
      Top = 45
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
      Left = 919
      Top = 45
      Width = 117
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object chkGraFin: TCheckBox
      Left = 125
      Top = 104
      Width = 112
      Height = 17
      Caption = 'Gravar Financeiro'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 9
      OnClick = chkGraFinClick
    end
    object chkImprCp: TCheckBox
      Left = 233
      Top = 104
      Width = 77
      Height = 17
      Caption = 'Imprime CP'
      Enabled = False
      TabOrder = 10
      OnClick = chkGraFinClick
    end
    object edtChaNFE: TEditFocus
      Tag = 99
      Left = 602
      Top = 110
      Width = 301
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 24
      OnExit = edtChaNFEExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object mmoHisCta: TMemoFocus
      Left = 82
      Top = 122
      Width = 434
      Height = 42
      ScrollBars = ssBoth
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object chkPgoAnt: TCheckBox
      Left = 157
      Top = 25
      Width = 166
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Utilizar Pagamento Antecipado'
      ParentBiDiMode = False
      TabOrder = 3
      OnClick = chkPgoAntClick
    end
    object chkVeioBo: TCheckBox
      Left = 11
      Top = 27
      Width = 77
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Veio Boleto'
      ParentBiDiMode = False
      TabOrder = 1
      OnClick = chkVeioBoClick
    end
    object edtCodCon: TEditFocus
      Tag = 99
      Left = 82
      Top = 101
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object cbxModFre: TComboBoxFocus
      Tag = 99
      Left = 602
      Top = 67
      Width = 301
      Height = 22
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 19
      Text = '2-FOB '
      OnChange = cbxModFreChange
      Items.Strings = (
        '1-CIF '
        '2-FOB '
        '3-TERCEIROS '
        '4-TRANSPORTE PR'#211'PRIO POR CONTA DO REMETENTE'
        '5-TRANSPORTE PR'#211'PRIO POR CONTA DO DESTINAT'#193'RIO'
        '9-SEM FRETE')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtPesBru: TEditFocus
      Tag = 99
      Left = 941
      Top = 88
      Width = 45
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
    object edtPesLiq: TEditFocus
      Tag = 99
      Left = 833
      Top = 88
      Width = 45
      Height = 22
      Alignment = taRightJustify
      TabOrder = 20
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
      Left = 82
      Top = 164
      Width = 265
      Height = 17
      Caption = 'N'#227'o atualizar pre'#231'os automaticamente no produto'
      TabOrder = 12
      OnClick = chkAtuPreClick
    end
    object btnPgoAnt: TBitBtnLocked
      Left = 325
      Top = 27
      Width = 31
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
      TabOrder = 4
      OnClick = btnPgoAntClick
    end
    object chkDeposi: TCheckBox
      Left = 89
      Top = 27
      Width = 67
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Dep'#243'sito'
      ParentBiDiMode = False
      TabOrder = 2
      OnClick = chkDeposiClick
    end
    object edtQtdVol: TEditFocus
      Tag = 99
      Left = 602
      Top = 88
      Width = 55
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
    object edtEspVol: TEditFocus
      Tag = 99
      Left = 706
      Top = 88
      Width = 75
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 10
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object cbxBcoFor: TComboBoxFocus
      Left = 82
      Top = 59
      Width = 434
      Height = 22
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
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
    object cbxCODMOD: TComboBoxFocus
      Tag = 99
      Left = 602
      Top = 131
      Width = 301
      Height = 22
      Style = csDropDownList
      TabOrder = 25
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 602
      Top = 1
      Width = 55
      Height = 22
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 13
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtHistorioLivroFiscal: TEditFocus
      Tag = 99
      Left = 602
      Top = 152
      Width = 434
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 26
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 60
      TipoTexto = ttAlfanumerico
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Tag = 99
      Left = 519
      Top = 23
      Width = 260
      Height = 22
      TabOrder = 15
      ExplicitLeft = 519
      ExplicitTop = 23
      ExplicitWidth = 260
      inherited lblEventos: TLabel
        Top = 3
        Width = 80
        Height = 14
        Caption = 'Cent. de Custos:'
        ExplicitTop = 3
        ExplicitWidth = 80
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Left = 83
        Height = 22
        ExplicitLeft = 83
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 141
        Width = 117
        Height = 22
        ExplicitLeft = 141
        ExplicitWidth = 117
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Tag = 99
      Left = 780
      Top = 23
      Width = 260
      Height = 22
      TabOrder = 16
      ExplicitLeft = 780
      ExplicitTop = 23
      ExplicitWidth = 260
      inherited lblPlaContas: TLabel
        Left = 1
        Top = 3
        Width = 81
        Height = 14
        ExplicitLeft = 1
        ExplicitTop = 3
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 139
        Width = 117
        Height = 22
        ExplicitLeft = 139
        ExplicitWidth = 117
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 81
        Width = 55
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 81
        ExplicitWidth = 55
        ExplicitHeight = 22
      end
    end
    object chkPrevisao: TCheckBox
      Left = 157
      Top = 41
      Width = 166
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Utilizar Previs'#227'o'
      ParentBiDiMode = False
      TabOrder = 5
      OnClick = chkPrevisaoClick
    end
  end
  object pnlDetalhes: TPanel [6]
    Left = 0
    Top = 235
    Width = 1179
    Height = 441
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    ExplicitWidth = 1044
    object vgrDetalhes: TcxDBVerticalGrid
      Left = 1
      Top = 1
      Width = 780
      Height = 439
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.ScrollBars = ssVertical
      OptionsView.GridLineColor = 16770261
      OptionsView.RowHeaderMinWidth = 0
      OptionsView.ShowHeaders = False
      OptionsBehavior.BandSizing = False
      OptionsBehavior.HeaderSizing = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Background = cxsTituloDetalhes
      Styles.OnGetContentStyle = pGetContentStyleDetalhes
      TabOrder = 0
      TabStop = False
      DataController.DataSource = dtsCadFis
      Version = 1
      object rowTitulos: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            Caption = '1'#170' Class.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            Caption = '2'#170' Class.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            Caption = '3'#170' Class.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            Caption = '4'#170' Class.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            Caption = '5'#170' Class.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            Caption = 'Total'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end>
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object rowClfSc: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Classifica'#231#227'o. Fiscal'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_CLFSC1'
            OnGetDisplayText = pGetDisplayTextClaFis
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_CLFSC2'
            OnGetDisplayText = pGetDisplayTextClaFis
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_CLFSC3'
            OnGetDisplayText = pGetDisplayTextClaFis
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_CLFSC4'
            OnGetDisplayText = pGetDisplayTextClaFis
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_CLFSC5'
            OnGetDisplayText = pGetDisplayTextClaFis
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taCenter
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_CLFSCT'
            OnGetDisplayText = pGetDisplayTextClaFis
          end>
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object rowVlCon: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor Cont'#225'bil'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCON1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCON2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCON3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCON4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCON5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCONT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object rowDAces: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Desp. Acess.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_DACES1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_DACES2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_DACES3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_DACES4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_DACES5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_DACEST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object rowBasIc: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base ICMS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIC1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIC2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIC3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIC4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIC5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASICT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object rowAlqIc: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Al'#237'quota. ICMS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ALQIC1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ALQIC2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ALQIC3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ALQIC4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ALQIC5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ALQICT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object rowVlrIc: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor ICMS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIC1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIC2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIC3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIC4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIC5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRICT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object rowOutra: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Outras'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_OUTRA1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_OUTRA2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_OUTRA3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_OUTRA4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_OUTRA5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_OUTRAT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object rowIsent: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Isentas'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ISENT1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ISENT2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ISENT3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ISENT4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ISENT5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ISENTT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      object rowBcRet: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base ICMS Subst.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCRET1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCRET2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCRET3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCRET4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCRET5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCRETT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
      object rowRetId: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor ICMS Subst.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_RETID1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_RETID2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_RETID3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_RETID4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_RETID5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_RETIDT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 10
        ParentID = -1
        Index = 10
        Version = 1
      end
      object rowBasAn: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base ICMS Antecip.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASAN1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASAN2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASAN3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASAN4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASAN5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASANT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 11
        ParentID = -1
        Index = 11
        Version = 1
      end
      object rowAntIc: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor ICMS Antecip.'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ANTIC1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ANTIC2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ANTIC3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ANTIC4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ANTIC5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_ANTICT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 12
        ParentID = -1
        Index = 12
        Version = 1
      end
      object rowBaeRe: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base ICMS Subst. N'#227'o Creditado'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAERE1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAERE2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAERE3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAERE4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAERE5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAERET'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 13
        ParentID = -1
        Index = 13
        Version = 1
      end
      object rowVaeRe: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor ICMS Subst. N'#227'o Creditado'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAERE1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAERE2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAERE3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAERE4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAERE5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAERET'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 14
        ParentID = -1
        Index = 14
        Version = 1
      end
      object rowBasIp: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base IPI'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIP1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIP2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIP3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIP4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIP5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BASIPT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 15
        ParentID = -1
        Index = 15
        Version = 1
      end
      object rowVlrIp: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor IPI'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIP1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIP2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIP3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIP4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIP5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLRIPT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 16
        ParentID = -1
        Index = 16
        Version = 1
      end
      object rowBaeIp: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base IPI N'#227'o Creditado'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAEIP1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAEIP2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAEIP3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAEIP4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAEIP5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BAEIPI'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 17
        ParentID = -1
        Index = 17
        Version = 1
      end
      object rowVaeIp: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor IPI N'#227'o Creditado'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAEIP1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAEIP2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAEIP3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAEIP4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAEIP5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VAEIPI'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 18
        ParentID = -1
        Index = 18
        Version = 1
      end
      object rowBFCPS: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base Fundo Combate a Pobreza ST'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BFCPS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BFCPS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BFCPS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BFCPS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BFCPS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BFCPST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 19
        ParentID = -1
        Index = 19
        Version = 1
      end
      object rowVFCPS: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor Fundo Combate a Pobreza ST'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VFCPS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VFCPS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VFCPS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VFCPS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VFCPS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VFCPST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 20
        ParentID = -1
        Index = 20
        Version = 1
      end
      object rowBcCbs: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base CBS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCCBS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCCBS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCCBS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCCBS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCCBS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCCBST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 21
        ParentID = -1
        Index = 21
        Version = 1
      end
      object rowVlCbs: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor CBS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCBS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCBS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCBS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCBS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCBS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLCBST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 22
        ParentID = -1
        Index = 22
        Version = 1
      end
      object rowBcIbs: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base IBS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCIBS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCIBS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCIBS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCIBS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCIBS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BCIBST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 23
        ParentID = -1
        Index = 23
        Version = 1
      end
      object rowVlIbs: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor IBS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLIBS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLIBS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLIBS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLIBS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLIBS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VLIBST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 24
        ParentID = -1
        Index = 24
        Version = 1
      end
      object rowBc_Is: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Base IS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BC_IS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BC_IS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BC_IS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BC_IS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BC_IS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_BC_IST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 25
        ParentID = -1
        Index = 25
        Version = 1
      end
      object rowVl_Is: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor IS'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VL_IS1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VL_IS2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VL_IS3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VL_IS4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VL_IS5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VL_IST'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 26
        ParentID = -1
        Index = 26
        Version = 1
      end
      object rowQBCMo: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Quantidade tributada monof'#225'sica'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_QBCMO1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_QBCMO2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_QBCMO3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_QBCMO4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_QBCMO5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_QBCMOT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 27
        ParentID = -1
        Index = 27
        Version = 1
      end
      object rowValMo: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Valor monof'#225'sica'
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.Alignment.Horz = taRightJustify
            EditProperties.ReadOnly = True
            Width = 1800
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
            OnGetDisplayText = pGetDisplayTextTitulo
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VALMO1'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VALMO2'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VALMO3'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VALMO4'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VALMO5'
            OnGetDisplayText = pGetDisplayTextValor
          end
          item
            EditPropertiesClassName = 'TcxTextEditProperties'
            EditProperties.ReadOnly = True
            Width = 20
            Options.Editing = False
            Options.Focusing = False
            Options.TabStop = False
          end
          item
            EditPropertiesClassName = 'TcxCurrencyEditProperties'
            EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            EditProperties.ReadOnly = True
            Width = 800
            DataBinding.FieldName = 'FIS_VALMOT'
            OnGetDisplayText = pGetDisplayTextValor
          end>
        ID = 28
        ParentID = -1
        Index = 28
        Version = 1
      end
    end
    object pnlCheckBox: TPanel
      Left = 787
      Top = 279
      Width = 300
      Height = 108
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lblEmpresa: TLabel
        Left = 10
        Top = 62
        Width = 90
        Height = 14
        Caption = 'Dep'#243'sito Fechado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkRealizaMovimentacaoDeSaldo: TCheckBox
        Left = 10
        Top = 0
        Width = 216
        Height = 16
        Caption = 'Realiza movimenta'#231#227'o de saldo?'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 0
      end
      object chkTransfAut: TCheckBox
        Left = 10
        Top = 26
        Width = 274
        Height = 16
        Caption = 'Mercadoria a ser enviada para o dep'#243'sito fechado?'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 1
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 10
        Top = 76
        Width = 57
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
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 68
        Top = 76
        Width = 215
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
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
  object pnlBotoesEnt: TPanel [7]
    Left = 0
    Top = 683
    Width = 1179
    Height = 24
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 7
    ExplicitWidth = 1044
    object btnCancelarEntrada: TBitBtnLocked
      Left = 1095
      Top = 1
      Width = 83
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
      ExplicitLeft = 960
    end
    object FlwPnlBotoesEnt: TFlowPanel
      Left = 1
      Top = 1
      Width = 1094
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 959
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '[F10]Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnOutDes: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 90
        Height = 22
        Caption = '[F9]Outras Desp.'
        TabOrder = 1
        OnClick = btnOutDesClick
      end
      object btnImpEspelho: TBitBtnLocked
        Left = 165
        Top = 0
        Width = 61
        Height = 22
        Caption = '[F8]Espelho'
        TabOrder = 2
        OnClick = btnImpEspelhoClick
      end
      object btnVendor: TBitBtnLocked
        Left = 226
        Top = 0
        Width = 60
        Height = 22
        Caption = '[F7]Vendor'
        TabOrder = 3
        OnClick = btnVendorClick
      end
      object btnConFre: TBitBtnLocked
        Left = 286
        Top = 0
        Width = 79
        Height = 22
        Caption = '[F6]Conh. Frete'
        TabOrder = 4
        OnClick = btnConFreClick
      end
      object btnConfDigitacao: TBitBtnLocked
        Left = 365
        Top = 0
        Width = 110
        Height = 22
        Caption = '[F5]Confer'#234'ncia Digit.'
        TabOrder = 5
        Visible = False
        OnClick = btnConfDigitacaoClick
      end
      object btnDesmembraValores: TBitBtnLocked
        Left = 475
        Top = 0
        Width = 121
        Height = 22
        Caption = '[F4]Desmembra Valores'
        TabOrder = 6
        OnClick = btnDesmembraValoresClick
      end
      object btnGnreST: TBitBtnLocked
        Left = 596
        Top = 0
        Width = 97
        Height = 22
        Caption = '[F3]GNRE Prod. ST'
        TabOrder = 7
        OnClick = btnGnreSTClick
      end
      object btnGnreTribut: TBitBtnLocked
        Left = 693
        Top = 0
        Width = 112
        Height = 21
        Caption = '[F2]GNRE Prod. Tribut.'
        TabOrder = 8
        OnClick = btnGnreTributClick
      end
      object btnTCIF: TBitBtnLocked
        Left = 805
        Top = 0
        Width = 46
        Height = 21
        Caption = '[F1]TCIF'
        TabOrder = 9
        Visible = False
        OnClick = btnTCIFClick
      end
      object btnTS: TBitBtnLocked
        Left = 851
        Top = 0
        Width = 60
        Height = 21
        Caption = '[Alt+F1]TS'
        TabOrder = 10
        Visible = False
        OnClick = btnTSClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 808
    Top = 360
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 256
  end
  object dtsCadFis: TDataSource
    Left = 808
    Top = 416
  end
  object cxStyleRepositoryDetalhes: TcxStyleRepository
    Left = 840
    Top = 416
    PixelsPerInch = 96
    object cxsTituloDetalhes: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
  end
end
