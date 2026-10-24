inherited frmCadCentroCusto: TfrmCadCentroCusto
  Left = 411
  Top = 434
  Width = 699
  Height = 583
  Caption = 'Cadastro de Plano de Contas'
  OnDestroy = FormDestroy
  ExplicitWidth = 699
  ExplicitHeight = 583
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 494
    Width = 693
    Height = 44
    TabOrder = 1
    ExplicitTop = 377
    ExplicitWidth = 693
    ExplicitHeight = 44
    DesignSize = (
      693
      44)
    inherited FlwBotoes: TFlowPanel
      Width = 689
      Height = 40
      ExplicitTop = 2
      ExplicitWidth = 689
      ExplicitHeight = 40
      inherited btnIncluir: TBitBtnLocked
        Width = 84
        ExplicitWidth = 84
      end
      inherited btnGravar: TBitBtnLocked
        Left = 84
        Width = 84
        ExplicitLeft = 84
        ExplicitWidth = 84
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 168
        Width = 84
        ExplicitLeft = 168
        ExplicitWidth = 84
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 252
        Width = 84
        ExplicitLeft = 252
        ExplicitWidth = 84
      end
      inherited btnCancela: TBitBtnLocked
        Left = 336
        Width = 84
        ExplicitLeft = 336
        ExplicitWidth = 84
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 420
        Width = 84
        ExplicitLeft = 420
        ExplicitWidth = 84
      end
      object btnRateios: TBitBtnLocked
        Left = 504
        Top = 0
        Width = 84
        Height = 20
        Align = alRight
        Caption = '&Rateios'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
          333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
          300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
          333337F373F773333333303330033333333337F3377333333333303333333333
          333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
          333337777F337F33333330330BB00333333337F373F773333333303330033333
          333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
          333377777F77377733330BBB0333333333337F337F33333333330BB003333333
          333373F773333333333330033333333333333773333333333333}
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnRateiosClick
      end
      object btnPlaNco: TBitBtnLocked
        Left = 588
        Top = 0
        Width = 84
        Height = 20
        Caption = 'Plano de Contas'
        TabOrder = 7
        OnClick = btnPlaNcoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 589
      Top = 22
      Width = 84
      Height = 20
      ExplicitLeft = 589
      ExplicitTop = 22
      ExplicitWidth = 84
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 538
    Width = 693
    TabOrder = 3
    ExplicitTop = 421
    ExplicitWidth = 693
    inherited pnlNomeForm: TPanel
      Left = 498
      Width = 195
      ExplicitLeft = 498
      ExplicitWidth = 195
    end
    inherited pnlInfo: TPanel
      Width = 498
      ExplicitWidth = 498
    end
  end
  inherited pgcDados: TPageControl
    Width = 693
    Height = 494
    Visible = False
    ExplicitWidth = 693
    ExplicitHeight = 377
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 685
      ExplicitHeight = 345
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 693
    Height = 494
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 377
    object Label1: TLabel
      Left = 51
      Top = 41
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Completo:'
    end
    object Label2: TLabel
      Left = 82
      Top = 87
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 239
      Top = 40
      Width = 119
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo do Plano de Contas:'
    end
    object lblDesPlaCon: TLabel
      Left = 65
      Top = 129
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano Cont'#225'bil:'
    end
    object lbl1: TLabel
      Left = 15
      Top = 151
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classif. Plano de Contas:'
    end
    object Label5: TLabel
      Left = 31
      Top = 68
      Width = 103
      Height = 14
      Alignment = taRightJustify
      Caption = 'Contas de Resultado:'
    end
    object Label6: TLabel
      Left = 12
      Top = 182
      Width = 124
      Height = 28
      Alignment = taRightJustify
      Caption = 'Entra no relat'#243'rio de fluxo de caixa como:'
      WordWrap = True
    end
    object lblPlaRes: TLabel
      Left = 10
      Top = 251
      Width = 125
      Height = 28
      Alignment = taRightJustify
      Caption = 'Plano de contas de conta de resultado:'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 48
      Top = 19
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Resumido:'
    end
    object ColorLabel1: TColorLabel
      Left = 397
      Top = 19
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
    object Label37: TLabel
      Left = 313
      Top = 19
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object edtDesPlaNco: TEditFocus
      Left = 274
      Top = 127
      Width = 311
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbePlaNco: TDBEditFocus
      Tag = 99
      Left = 138
      Top = 127
      Width = 135
      Height = 22
      DataField = 'CTA_PLANCO'
      DataSource = dtsCadCta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnKeyPress = dbePlaNcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCta: TDBEditFocus
      Tag = 99
      Left = 138
      Top = 37
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_CODCTA'
      DataSource = dtsCadCta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesCta: TDBEditFocus
      Tag = 99
      Left = 138
      Top = 83
      Width = 447
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_DESCTA'
      DataSource = dtsCadCta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbbTipCta: TComboBoxFocus
      Left = 360
      Top = 37
      Width = 225
      Height = 22
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbbTipCtaChange
      Items.Strings = (
        'Venda Bruta\Receitas'
        'Custo do Produto'
        'Despesas'
        'Despesas Financeiras'
        'Compras'
        'Despesas Vari'#225'veis')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeConCon: TDBEditFocus
      Tag = 99
      Left = 138
      Top = 127
      Width = 220
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_CONCON'
      DataSource = dtsCadCta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbchkEntRel: TDBCheckBox
      Left = 138
      Top = 173
      Width = 230
      Height = 17
      Caption = 'Entra no Relat'#243'rio de Despesas e Receitas'
      DataField = 'CTA_ENTREL'
      DataSource = dtsCadCta
      TabOrder = 13
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object cbbClaCta: TComboBoxFocus
      Left = 138
      Top = 150
      Width = 220
      Height = 22
      Style = csDropDownList
      TabOrder = 11
      Items.Strings = (
        'Investimento'
        'Despesas Fixas'
        'Despesas Vari'#225'veis'
        'Despesas Extras')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbchkDesmembr: TDBCheckBox
      Left = 138
      Top = 107
      Width = 230
      Height = 17
      Caption = 'Conta Cont'#225'bil desmembrada por empresa?'
      DataField = 'CTA_DESMEM'
      DataSource = dtsCadCta
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dbchkDesmembrClick
    end
    object btnDesmembr: TBitBtnLocked
      Left = 447
      Top = 105
      Width = 139
      Height = 22
      Caption = 'Desmembra Conta Cont'#225'bil'
      TabOrder = 8
      Visible = False
      OnClick = btnDesmembrClick
    end
    object edtCtaRes: TEditFocus
      Tag = 99
      Left = 138
      Top = 60
      Width = 59
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
      TabOrder = 4
      OnEnter = edtCtaResEnter
      OnExit = edtCtaResExit
      OnKeyPress = edtCtaResKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesResultado: TEditFocus
      Left = 199
      Top = 60
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbbEntraRelComo: TComboBoxFocus
      Left = 138
      Top = 191
      Width = 135
      Height = 22
      Style = csDropDownList
      TabOrder = 14
      Items.Strings = (
        'Imposto'
        'Despesa'
        'Fornecedores')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbchkExpAut: TDBCheckBox
      Left = 138
      Top = 216
      Width = 117
      Height = 17
      Caption = 'Exportar pelo Autsi'
      DataField = 'CTA_EXPAUT'
      DataSource = dtsCadCta
      TabOrder = 15
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkProCon: TDBCheckBox
      Left = 138
      Top = 231
      Width = 137
      Height = 17
      Caption = 'Gerar provis'#227'o cont'#225'bil?'
      DataField = 'CTA_PROCON'
      DataSource = dtsCadCta
      TabOrder = 16
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = chkProConClick
    end
    object dbePlaRes: TDBEditFocus
      Tag = 99
      Left = 138
      Top = 254
      Width = 135
      Height = 22
      DataField = 'CTA_PLARES'
      DataSource = dtsCadCta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      OnKeyPress = dbePlaResKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesPlaRes: TEditFocus
      Left = 274
      Top = 254
      Width = 311
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodRes: TDBEditFocus
      Tag = 99
      Left = 138
      Top = 14
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_CODRES'
      DataSource = dtsCadCta
      Enabled = False
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
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 14
      Width = 32
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_STATUS'
      DataSource = dtsCadCta
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
    object rdgRegimeDRE: TDBRadioGroup
      Left = 138
      Top = 279
      Width = 170
      Height = 51
      Caption = 'Regime'
      DataField = 'CTA_REGDRE'
      DataSource = dtsCadCta
      Items.Strings = (
        'Data de Pagamento (CAIXA)'
        'Compet'#234'ncia')
      TabOrder = 23
      TabStop = True
      Values.Strings = (
        '1'
        '2')
    end
    object dbchkPerBaiCar: TDBCheckBox
      Left = 305
      Top = 216
      Width = 137
      Height = 17
      Caption = 'Permitir baixa de cart'#245'es'
      DataField = 'CTA_PERBCA'
      DataSource = dtsCadCta
      TabOrder = 19
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbchkPerBaiChe: TDBCheckBox
      Left = 305
      Top = 231
      Width = 159
      Height = 17
      Caption = 'Permitir dep'#243'sito de cheques'
      DataField = 'CTA_PERBCH'
      DataSource = dtsCadCta
      TabOrder = 20
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbchkPerBaiRec: TDBCheckBox
      Left = 477
      Top = 216
      Width = 187
      Height = 17
      Caption = 'Permitir baixa de contas a receber'
      DataField = 'CTA_PERREC'
      DataSource = dtsCadCta
      TabOrder = 21
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbchkPerBaiPag: TDBCheckBox
      Left = 477
      Top = 231
      Width = 187
      Height = 17
      Caption = 'Permitir baixa de contas a pagar'
      DataField = 'CTA_PERPAG'
      DataSource = dtsCadCta
      TabOrder = 22
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object pnlHis: TPanel
      Left = 2
      Top = 458
      Width = 689
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 24
      TabStop = True
      ExplicitTop = 341
      object lblHisCon: TLabel
        Left = 9
        Top = 4
        Width = 123
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico Padr'#227'o Cont'#225'bil:'
      end
      object edtDesHisCon: TEditFocus
        Left = 225
        Top = 1
        Width = 358
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeHisCon: TDBEditFocus
        Tag = 99
        Left = 136
        Top = 1
        Width = 87
        Height = 22
        DataField = 'CTA_HISCON'
        DataSource = dtsCadCta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeHisConKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object grbDespesasFinanceiras: TGroupBox
      AlignWithMargins = True
      Left = 137
      Top = 334
      Width = 449
      Height = 121
      Margins.Left = 135
      Margins.Right = 105
      Align = alBottom
      Caption = 'Despesas Financeiras SPED Contribui'#231#245'es ( PIS/COFINS )'
      TabOrder = 25
      ExplicitTop = 217
      object dbeChkUtlDespesasFinanceiras: TDBCheckBox
        Left = 15
        Top = 22
        Width = 320
        Height = 17
        Margins.Top = 10
        Margins.Bottom = 10
        Caption = 'Utilizar Despesas Financeiras para este Plano de Contas'
        DataField = 'CTA_USADFI'
        DataSource = dtsCadCta
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dbeChkUtlDespesasFinanceirasClick
      end
      object pnlDespesasFinanceiras: TPanel
        Left = 2
        Top = 42
        Width = 445
        Height = 77
        Align = alBottom
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        object lblBCCrePisCofins: TLabel
          Left = 13
          Top = 6
          Width = 134
          Height = 14
          Caption = 'C'#243'd.BC Cr'#233'dito PIS/COFINS:'
        end
        object Label7: TLabel
          Left = 205
          Top = 29
          Width = 42
          Height = 14
          Caption = 'Al'#237'quota:'
        end
        object Label8: TLabel
          Left = 106
          Top = 29
          Width = 41
          Height = 14
          Caption = 'CST PIS:'
        end
        object Label11: TLabel
          Left = 205
          Top = 53
          Width = 42
          Height = 14
          Caption = 'Al'#237'quota:'
        end
        object Label9: TLabel
          Left = 83
          Top = 53
          Width = 63
          Height = 14
          Caption = 'CST COFINS:'
        end
        object dbeCbcCre: TDBEditFocus
          Tag = 99
          Left = 149
          Top = 3
          Width = 47
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CTA_CBCCRE'
          DataSource = dtsCadCta
          MaxLength = 2
          TabOrder = 0
          OnKeyPress = dbeCbcCreKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqPis: TDBEditFocus
          Tag = 99
          Left = 249
          Top = 26
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CTA_ALQPIS'
          DataSource = dtsCadCta
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeCstPis: TDBEditFocus
          Tag = 99
          Left = 149
          Top = 26
          Width = 47
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CTA_CSTPIS'
          DataSource = dtsCadCta
          MaxLength = 2
          TabOrder = 1
          OnKeyPress = dbeCstPisKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeAlqCof: TDBEditFocus
          Tag = 99
          Left = 249
          Top = 49
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CTA_ALQCOF'
          DataSource = dtsCadCta
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeCstCof: TDBEditFocus
          Tag = 99
          Left = 149
          Top = 49
          Width = 47
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CTA_CSTCOF'
          DataSource = dtsCadCta
          MaxLength = 2
          TabOrder = 3
          OnKeyPress = dbeCstCofKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 640
    Top = 8
  end
  object dtsCadCta: TDataSource
    OnStateChange = dtsCadCtaStateChange
    Left = 488
    Top = 32
  end
end
