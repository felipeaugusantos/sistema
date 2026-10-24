inherited frmRelFatComVendedor: TfrmRelFatComVendedor
  Left = 206
  Top = 113
  Width = 755
  Height = 696
  Caption = 'Relat'#243'rio de Comiss'#227'o por Vendedor - Faturamento'
  OnDestroy = FormDestroy
  OnPaint = nil
  ExplicitWidth = 755
  ExplicitHeight = 696
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 14
    Top = 116
    Width = 47
    Height = 14
    Caption = 'Vendedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [1]
    Left = 14
    Top = 118
    Width = 42
    Height = 14
    Caption = 'Digitador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 625
    Width = 749
    ExplicitTop = 625
    ExplicitWidth = 749
    inherited FlwBotoes: TFlowPanel
      Width = 663
      ExplicitWidth = 663
      inherited btnImprimir: TBitBtnLocked
        Width = 82
        ExplicitWidth = 82
      end
      inherited btnConfigurar: TBitBtnLocked
        Left = 82
        Width = 82
        ExplicitLeft = 82
        ExplicitWidth = 82
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 665
      Width = 82
      ExplicitLeft = 665
      ExplicitWidth = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 651
    Width = 749
    ExplicitTop = 651
    ExplicitWidth = 749
    inherited pnlNomeForm: TPanel
      Left = 499
      Width = 250
      TabOrder = 1
      ExplicitLeft = 499
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 499
      TabOrder = 0
      ExplicitWidth = 499
      inherited shpMultSel: TShape
        Left = 481
        Top = 2
        Height = 12
        Align = alRight
        Visible = True
        ExplicitLeft = 470
        ExplicitTop = 2
        ExplicitHeight = 12
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 749
    Height = 625
    OnClick = pnlDadosClick
    ExplicitWidth = 749
    ExplicitHeight = 625
    object Label5: TLabel [0]
      Left = 8
      Top = 3
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [1]
      Left = 91
      Top = 3
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [2]
      Left = 175
      Top = 22
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVenDig: TLabel [3]
      Left = 8
      Top = 304
      Width = 56
      Height = 14
      Caption = 'Vendedor 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [4]
      Left = 8
      Top = 450
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [5]
      Left = 666
      Top = 3
      Width = 72
      Height = 14
      Caption = 'Somente Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpLiberado: TShape [6]
      Left = 8
      Top = 318
      Width = 8
      Height = 22
    end
    object Label4: TLabel [7]
      Left = 226
      Top = 170
      Width = 97
      Height = 14
      Caption = 'Op'#231#227'o de Vendedor'
    end
    object Label9: TLabel [8]
      Left = 8
      Top = 413
      Width = 116
      Height = 14
      Caption = 'Departamento Operador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel [9]
      Left = 8
      Top = 484
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [10]
      Left = 336
      Top = 484
      Width = 116
      Height = 14
      Caption = 'Condi'#231#227'o de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [11]
      Left = 221
      Top = 413
      Width = 107
      Height = 14
      Caption = 'Departamento Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel [12]
      Left = 8
      Top = 521
      Width = 32
      Height = 14
      Caption = 'Cliente'
    end
    object lbl5: TLabel [13]
      Left = 335
      Top = 521
      Width = 67
      Height = 14
      Caption = 'Cliente Excluir'
    end
    object lbl6: TLabel [14]
      Left = 8
      Top = 556
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
    end
    object lbl3: TLabel [15]
      Left = 439
      Top = 170
      Width = 85
      Height = 14
      Caption = 'Tipo de Vendedor'
    end
    object Label10: TLabel [16]
      Left = 8
      Top = 228
      Width = 151
      Height = 14
      Caption = 'Composi'#231#227'o do Pre'#231'o de Custo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblLinhaGrupoIni: TLabel [17]
      Left = 336
      Top = 555
      Width = 59
      Height = 14
      Caption = 'Linha/Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [18]
      Left = 8
      Top = 268
      Width = 39
      Height = 14
      Caption = 'Gerente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpGer: TShape [19]
      Left = 8
      Top = 282
      Width = 8
      Height = 22
    end
    object Label12: TLabel [20]
      Left = 233
      Top = 268
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Gerente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpSubGer: TShape [21]
      Left = 231
      Top = 282
      Width = 8
      Height = 20
    end
    object Label13: TLabel [22]
      Left = 8
      Top = 340
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel [23]
      Left = 8
      Top = 375
      Width = 30
      Height = 14
      Caption = 'Marca'
    end
    object edtCodAti: TEditFocus [24]
      Tag = 99
      Left = 8
      Top = 499
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 31
      OnExit = edtCodAtiExit
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus [25]
      Tag = 99
      Left = 8
      Top = 464
      Width = 35
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
      TabOrder = 29
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodDep: TEditFocus [26]
      Tag = 99
      Left = 8
      Top = 427
      Width = 35
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
      TabOrder = 25
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodVendedor: TEditFocus [27]
      Tag = 99
      Left = 16
      Top = 318
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
      TabOrder = 19
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    inherited gpbDestino: TGroupBox
      Left = 565
      Top = 112
      Width = 98
      Height = 59
      TabOrder = 7
      ExplicitLeft = 565
      ExplicitTop = 112
      ExplicitWidth = 98
      ExplicitHeight = 59
      inherited ColorLabel1: TColorLabel
        Left = 31
        Top = 13
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitLeft = 31
        ExplicitTop = 13
        ExplicitWidth = 36
      end
      object ColorLabel19: TColorLabel [1]
        Left = 31
        Top = 27
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      object ColorLabel21: TColorLabel [2]
        Left = 31
        Top = 41
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Top = 22
        ExplicitTop = 22
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 77
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 91
      Top = 17
      Width = 78
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtDesVendedor: TEditFocus
      Left = 74
      Top = 318
      Width = 359
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 44
      Top = 464
      Width = 389
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbTipo: TGroupBox
      Left = 8
      Top = 112
      Width = 289
      Height = 59
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object ColorLabel6: TColorLabel
        Left = 34
        Top = 19
        Width = 248
        Height = 14
        Caption = '(1)Sint.Doc (2)Sint.Ven (3)Sint.Ven+Dta (4)Anal'#237'tico'
        CorDestaque = clRed
      end
      object shpTipoRel: TShape
        Left = 3
        Top = 15
        Width = 8
        Height = 22
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 11
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        OnChange = edtTipoChange
        OnExit = edtTipoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object chkResAliq: TCheckBox
        Left = 11
        Top = 37
        Width = 178
        Height = 17
        Caption = 'Imprimir resumo por al'#237'quota'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 1
      end
    end
    object lstClaFis: TMemo
      Left = 666
      Top = 17
      Width = 78
      Height = 669
      TabStop = False
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
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
      WordWrap = False
    end
    object gpbOrdem: TGroupBox
      Left = 374
      Top = 112
      Width = 190
      Height = 59
      Caption = 'Ordem'
      TabOrder = 6
      object lblOrdem2: TColorLabel
        Left = 26
        Top = 27
        Width = 97
        Height = 14
        AutoSize = False
        Caption = '(2)Documento'
        CorDestaque = clRed
      end
      object lblOrdem1: TColorLabel
        Left = 26
        Top = 13
        Width = 161
        Height = 14
        AutoSize = False
        Caption = '(1)Vendedor 1 "C'#243'digo"'
        CorDestaque = clRed
      end
      object lblOrdem3: TColorLabel
        Left = 26
        Top = 41
        Width = 161
        Height = 14
        AutoSize = False
        Caption = '(3)Vendedor 1 "Nome"'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 5
        Top = 22
        Width = 16
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
    object gpbMargem: TGroupBox
      Left = 298
      Top = 112
      Width = 75
      Height = 59
      Caption = 'Ver Margem?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object ColorLabel9: TColorLabel
        Left = 35
        Top = 18
        Width = 25
        Height = 14
        Caption = '(S)im'
        WordWrap = True
        CorDestaque = clRed
      end
      object shpMargem: TShape
        Left = 5
        Top = 22
        Width = 8
        Height = 22
      end
      object ColorLabel22: TColorLabel
        Left = 35
        Top = 32
        Width = 27
        Height = 14
        Caption = '(N)'#227'o'
        WordWrap = True
        CorDestaque = clRed
      end
      object edtMargem: TEditFocus
        Tag = 99
        Left = 13
        Top = 22
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbAgrupar: TGroupBox
      Left = 8
      Top = 171
      Width = 212
      Height = 53
      Caption = 'Agrupar por'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      object ColorLabel11: TColorLabel
        Left = 29
        Top = 23
        Width = 175
        Height = 14
        Caption = '(D)ocumento (C)liente (L)inha/Grupo'
        CorDestaque = clRed
      end
      object edtOpcAgru: TEditFocus
        Tag = 99
        Left = 6
        Top = 19
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'D'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbEmpresa: TGroupBox
      Left = 439
      Top = 274
      Width = 224
      Height = 43
      Caption = 'Empresa do'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 47
      object ColorLabel12: TColorLabel
        Left = 28
        Top = 20
        Width = 111
        Height = 14
        Caption = '(F)aturamento (P)edido'
        CorDestaque = clRed
      end
      object edtEmpFat: TEditFocus
        Tag = 99
        Left = 6
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'F'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object grbFilTab: TGroupBox
      Left = 436
      Top = 319
      Width = 224
      Height = 167
      Caption = 'Filtro por Tabela de Pre'#231'o'
      TabOrder = 48
      DesignSize = (
        224
        167)
      object chkFilTab: TCheckBox
        Left = 11
        Top = 18
        Width = 108
        Height = 17
        Caption = 'Filtrar por Tabela'
        TabOrder = 0
        OnClick = chkFilTabClick
      end
      object clbTabPre: TCheckListBox
        Tag = 99
        Left = 10
        Top = 41
        Width = 206
        Height = 118
        Anchors = [akLeft, akTop, akBottom]
        Columns = 2
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemHeight = 14
        TabOrder = 1
      end
    end
    object cbxVendedor: TComboBoxFocus
      Tag = 99
      Left = 226
      Top = 185
      Width = 207
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 5
      TabOrder = 9
      Text = '6- Superv. Regional'
      OnChange = cbxVendedorChange
      Items.Strings = (
        '1- Vendedor 1'
        '2- Vendedor 2'
        '3- Digitador'
        '4- Representante'
        '5- Superv. Geral'
        '6- Superv. Regional'
        '(Verificar FormShow)')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtDesDep: TEditFocus
      Left = 44
      Top = 427
      Width = 176
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkPedPen: TCheckBox
      Left = 226
      Top = 207
      Width = 183
      Height = 31
      Caption = 'Exibir pedidos pendentes do vendedor'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      WordWrap = True
    end
    object edtAtividade: TEditFocus
      Left = 44
      Top = 499
      Width = 291
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 32
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object prbProgresso: TProgressBar
      Left = 1
      Top = 618
      Width = 747
      Height = 6
      Align = alBottom
      Smooth = True
      TabOrder = 49
    end
    object gpbOpcao: TGroupBox
      Left = 8
      Top = 40
      Width = 655
      Height = 71
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object ColorLabel2: TColorLabel
        Left = 34
        Top = 14
        Width = 113
        Height = 14
        Caption = '(1) Calculado na Venda'
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel
        Left = 34
        Top = 27
        Width = 102
        Height = 14
        Caption = '(2) % Cad. Vendedor'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 34
        Top = 40
        Width = 98
        Height = 14
        Caption = '(3) % Cad. Produtos'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 34
        Top = 52
        Width = 111
        Height = 14
        Caption = '(4) % Cad. Fornecedor'
        CorDestaque = clRed
      end
      object ColorLabel7: TColorLabel
        Left = 167
        Top = 14
        Width = 116
        Height = 14
        Caption = '(5) % Margem por Faixa'
        CorDestaque = clRed
      end
      object ColorLabel8: TColorLabel
        Left = 167
        Top = 27
        Width = 76
        Height = 14
        Caption = '(6) % Desconto'
        CorDestaque = clRed
      end
      object ColorLabel10: TColorLabel
        Left = 167
        Top = 39
        Width = 144
        Height = 14
        Caption = '(7) % Desc. no Cad. Produtos'
        CorDestaque = clRed
      end
      object ColorLabel13: TColorLabel
        Left = 167
        Top = 52
        Width = 143
        Height = 14
        Caption = '(8) Prop. Lucro Margem Bruta'
        CorDestaque = clRed
      end
      object ColorLabel14: TColorLabel
        Left = 328
        Top = 14
        Width = 157
        Height = 14
        Caption = '(9) % Desc. sobre % Com. Prod.'
        CorDestaque = clRed
      end
      object ColorLabel15: TColorLabel
        Left = 328
        Top = 27
        Width = 122
        Height = 14
        Caption = '(10) % Cad. Cond. Pagto.'
        CorDestaque = clRed
      end
      object ColorLabel18: TColorLabel
        Left = 328
        Top = 40
        Width = 123
        Height = 14
        Caption = '(11) % Cliente / Vendedor'
        CorDestaque = clRed
      end
      object shpOpcaoRel: TShape
        Left = 2
        Top = 24
        Width = 8
        Height = 22
      end
      object ColorLabel23: TColorLabel
        Left = 328
        Top = 52
        Width = 153
        Height = 14
        Caption = '(12) % Faixa Margem por Vend.'
        CorDestaque = clRed
      end
      object ColorLabel16: TColorLabel
        Left = 494
        Top = 14
        Width = 157
        Height = 14
        Caption = '(13) Prop. Lucro Margem L'#237'quida'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 11
        Top = 24
        Width = 20
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 0
        Text = '1'
        OnExit = edtOpcaoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object edtCodCnd: TEditFocus
      Tag = 99
      Left = 336
      Top = 499
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 33
      OnExit = edtCodCndExit
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesCnd: TEditFocus
      Left = 372
      Top = 499
      Width = 288
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 34
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDepProd: TEditFocus
      Tag = 99
      Left = 221
      Top = 427
      Width = 35
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
      TabOrder = 27
      OnExit = edtCodDepProdExit
      OnKeyPress = edtCodDepProdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDepProd: TEditFocus
      Left = 257
      Top = 427
      Width = 176
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 28
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 535
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 35
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 75
      Top = 535
      Width = 260
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 36
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliExc: TEditFocus
      Tag = 99
      Left = 335
      Top = 535
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 37
      OnExit = edtCliExcExit
      OnKeyPress = edtCliExcKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesExc: TEditFocus
      Left = 402
      Top = 535
      Width = 258
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 38
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
      Left = 8
      Top = 569
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 39
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Left = 75
      Top = 569
      Width = 260
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 40
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbTipVen: TComboBoxFocus
      Tag = 99
      Left = 439
      Top = 185
      Width = 224
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 3
      TabOrder = 10
      Text = 'Todos'
      OnChange = cbxVendedorChange
      Items.Strings = (
        'Interno'
        'Representante Externo Loja'
        'Representante Externo Distribuidor'
        'Todos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbbComCus: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 243
      Width = 425
      Height = 22
      Style = csDropDownList
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkCadCom: TCheckBox
      Left = 439
      Top = 207
      Width = 195
      Height = 31
      Caption = 'Exibir resumo por faixas de comiss'#227'o'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      WordWrap = True
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 336
      Top = 569
      Width = 66
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
      TabOrder = 41
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 403
      Top = 569
      Width = 257
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 42
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodGer: TEditFocus
      Tag = 99
      Left = 16
      Top = 282
      Width = 40
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
      TabOrder = 15
      OnExit = edtCodGerExit
      OnKeyPress = edtCodGerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGer: TEditFocus
      Left = 57
      Top = 282
      Width = 172
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSubGer: TEditFocus
      Tag = 99
      Left = 239
      Top = 281
      Width = 30
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
      TabOrder = 17
      OnExit = edtCodSubGerExit
      OnKeyPress = edtCodSubGerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesSubGer: TEditFocus
      Left = 269
      Top = 281
      Width = 164
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 8
      Top = 354
      Width = 65
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
      TabOrder = 21
      OnExit = edtCodProExit
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPro: TEditFocus
      Left = 74
      Top = 354
      Width = 359
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgItePro: TRadioGroup
      Left = 439
      Top = 237
      Width = 224
      Height = 36
      Caption = 'Itens em Promo'#231#227'o?'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 14
    end
    object edtCodMarca: TEditFocus
      Left = 8
      Top = 390
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 23
      OnExit = edtCodMarcaExit
      OnKeyPress = edtCodMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 76
      Top = 390
      Width = 357
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkEjeVen: TCheckBox
      Tag = 99
      Left = 8
      Top = 597
      Width = 226
      Height = 17
      Caption = 'Ejetar p'#225'gina a cada quebra de vendedor?'
      Enabled = False
      TabOrder = 43
    end
    object chkPDFVen: TCheckBox
      Tag = 99
      Left = 240
      Top = 597
      Width = 181
      Height = 17
      Caption = 'Gerar PDF para cada Vendedor?'
      Enabled = False
      TabOrder = 44
      OnClick = chkPDFVenClick
    end
    object edtDirPDF: TEditFocus
      Tag = 99
      Left = 423
      Top = 592
      Width = 201
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 45
      StyleElements = [seFont, seClient]
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object btnDirPDF: TBitBtnLocked
      Left = 625
      Top = 592
      Width = 34
      Height = 22
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000090000
        000E000000100000001000000010000000100000001000000011000000110000
        001100000011000000100000000B00000003000000000000000019427ACA245A
        A5FF255CA7FF255BA7FF245AA6FF2459A6FF2358A5FF2358A4FF2356A4FF2256
        A4FF2255A3FF2154A3FF2153A1FF1C468AE303080F2900000002255DA5FF316B
        AEFF6DA6D5FF86CAF0FF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
        E1FF389BE0FF369AE0FF3498DFFF2C77C1FF10284D8B000000082B68AEFF4984
        BEFF4B8BC5FFB2E3F8FF68BBECFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
        E5FF47A6E4FF44A4E4FF41A2E3FF3A92D6FF1C4885D50000000D2F6FB4FF6CA7
        D2FF3F87C4FFAED9F0FF9AD8F5FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
        EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2D69B1FF040B142F3276B9FF8FC7
        E6FF509FD4FF86BCE0FFC5EFFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
        EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF448BC9FF122D4D81357CBCFFAFE3
        F5FF75C8EDFF59A2D4FFDDF7FDFFDFF8FEFFDDF7FEFFDBF7FEFFD8F5FEFFD4F4
        FDFFD0F2FDFFCCEFFCFFC7EDFBFFC1EBFBFF9ACBE9FF215187CB3882C1FFC7F5
        FEFF97E5FCFF64BAE5FF4D9FD3FF4D9DD2FF4B9BD1FF4A99CFFF4998CFFF4896
        CEFF4694CCFF4592CBFF3073B7FF3072B6FF2F71B5FF2A65A4EA3A88C5FFCDF7
        FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFF89DFFBFF86DEFAFF81DAFAFF7ED8
        F9FF7BD7F9FF79D6F9FF2A6BB0FF000000140000000A000000073D8EC8FFD0F8
        FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFBBF2FDFFD4F9FEFFD5F9FEFFD3F8
        FEFFD1F8FEFFCEF7FDFF3680BFFF0000000800000000000000003F92CBFFD3F9
        FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF4895CBFF3B8CC6FF3B8AC6FF3A89
        C5FF3A88C5FF3A87C3FF2A6391C20000000500000000000000004197CEFFE2FC
        FEFFE2FCFEFFE1FCFEFFD4F3FAFF458FBFEC040A0E1B00000006000000060000
        000600000006000000060000000400000001000000000000000031739ABF429A
        D0FF4299D0FF4299D0FF4297CFFF153244590000000200000000000000000000
        0000000000000000000000000000000000000000000000000000000000020000
        0003000000030000000400000003000000020000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 46
      OnClick = btnDirPDFClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 376
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 656
    Top = 344
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 688
    Top = 280
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 656
    Top = 280
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 688
    Top = 248
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 656
    Top = 248
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 656
    Top = 216
  end
  inherited frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorioNaoUsado'
    Left = 656
    Top = 120
  end
  inherited frxGen: TfrxUserDataSet
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL'
      'VS_STRMARMKP'
      'MARGEM'
      'OP_COMISSAO'
      'VENDEDOR')
    Left = 656
    Top = 184
  end
  inherited frxDesigner: TfrxDesigner
    Left = 688
    Top = 184
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 656
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 680
    Top = 432
  end
  object frxPaginaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42933.590938703710000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  vr_margem_tot, vr_custo_tot : double;'
      '  vr_margem_fin, vr_custo_fin : double;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin   '
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin    '
      '    vr_margem_tot := vr_margem_tot + rllTotal.Value;'
      '    vr_custo_tot := vr_custo_tot + rllVrCusto.value;        '
      '  End;   '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      '    If (vr_margem_tot <> 0) and (vr_custo_tot <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllMargemTot.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_marg' +
        'em_tot  / vr_custo_tot ) *100 )-100)'
      '      Else'
      
        '        rllMargemTot.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cus' +
        'to_tot / vr_margem_tot ) )*100);'
      '    End  '
      '    Else'
      '    Begin          '
      
        '      If (vr_custo_tot = 0) And (<frxGen."VS_STRMARMKP"> = '#39'1'#39') ' +
        'Then'
      
        '        rllMargemTot.text := '#39'100,00'#39'                           ' +
        '                                              '
      '      Else                '
      '        rllMargemTot.text := '#39'0,00'#39';'
      
        '    End;                                                        ' +
        '                       '
      ''
      '    vr_margem_fin := vr_margem_fin + vr_margem_tot;'
      '    vr_custo_fin := vr_custo_fin + vr_custo_tot;'
      '      '
      '    vr_margem_tot := 0;'
      '    vr_custo_tot := 0;'
      '  End;                  '
      '    '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      '    If (vr_margem_fin <> 0) and (vr_custo_fin <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '       rllMargemTotGer.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_ma' +
        'rgem_fin  / vr_custo_fin ) *100 )-100)  '
      '      Else'
      
        '       rllMargemTotGer.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_c' +
        'usto_fin / vr_margem_fin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      
        '      If (vr_custo_fin = 0) And (<frxGen."VS_STRMARMKP"> = '#39'1'#39') ' +
        'Then'
      
        '        rllMargemTotGer.text := '#39'100,00'#39'                        ' +
        '                                                 '
      '      Else        '
      '        rllMargemTotGer.Text := '#39'0,00'#39';'
      '    End;                                '
      '  End;                           '
      'end;'
      '  '
      'procedure rlbCabecGroupAliqOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      '  Case <frxGen."VENDEDOR"> Of'
      '    0: Begin'
      '         fCriaResAliquota(<frxUserRelatorio."CODVEN">);'
      '       End;    '
      '    1: Begin'
      '         fCriaResAliquota(<frxUserRelatorio."CODVE2">);  '
      '       End;'
      '    2: Begin'
      '         fCriaResAliquota(<frxUserRelatorio."CODDIG">);  '
      '       End;'
      '    3: Begin'
      '         fCriaResAliquota(<frxUserRelatorio."CODREP">);  '
      '       End;'
      '    4,'
      '    5: Begin'
      '         fCriaResAliquota(<frxUserRelatorio."SUPERV">);  '
      '       End;'
      '  End;'
      '    '
      'end;'
      ''
      'procedure rllPedPenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllPedPen.Text := fRetPedidosPendentes();  '
      'end;'
      ''
      'procedure rllNumDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      ''
      ''
      'procedure rllNumDocGrpOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      '  vr_margem_tot := 0;'
      '  vr_custo_tot := 0;'
      '  vr_margem_fin := 0;'
      '  vr_custo_fin := 0;'
      'end.')
    OnUserFunction = frxPaginaMUserFunction
    Left = 688
    Top = 88
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxResFai
        DataSetName = 'frxResFai'
      end
      item
        DataSet = frxSinVen
        DataSetName = 'frxSinVen'
      end
      item
        DataSet = frxUserRelatorio
        DataSetName = 'frxUserRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaAnalitico: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = []
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 544.000000000000000000
        Width = 1257.600000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxUserRelatorio
        DataSetName = 'frxUserRelatorio'
        RowCount = 0
        object rllData: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."DTAENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNumDoc: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNumDocOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDocFat: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMFAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEmp: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCliente: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerComissao: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."PERCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotal: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrComissao: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrCusto: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTCUS'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCUS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargem: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataField = 'MARGEM'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."MARGEM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllResultDet: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."RESULT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllQtdIte: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCodigo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."CODITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDescricao: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."DESITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrUnitario: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."DET_UNITAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 816.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 289.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllDataTit: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DTA DOC.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNumDocTit: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDocFatTit: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOC. FAT.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEmpTit: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllClienteTit: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerComissaoTit: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COMISS')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalTit: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrComissaoTit: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR COMISS')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrCustoTit: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR CUSTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargemTit: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','#39'%MARKUP'#39','#39'%MARGEM'#39')]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllResultTit: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'RESULTADO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllQtdIteTit: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCodigoTit: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDescricaoTit: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 51.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrUnitarioTit: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllUnidadeTit: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 34.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REFERENTE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPCAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TABPRE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 68.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ATIVIDADE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPPRE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPVEN]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo72: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CONDICAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo73: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTOPROD]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo74: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo75: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo78: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo80: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 187.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[LINGRU]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo108: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[GERENTE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo109: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 204.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[PRODUTO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo112: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 204.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PROMOC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo114: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[MARCA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecGroupVend: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 408.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxUserRelatorio."CODVEN"'
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 825.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TITVEN]: [frxUserRelatorio."NOMVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodapGroupVend: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 646.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object DMPMemo24: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO [TITVEN]:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllVrTotal: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrComissaoTot: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerComissaoTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0,'
            
              '    (SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes) / SUM(<frxUser' +
              'Relatorio."TOTITE">,rlbDetalhes)) * 100,'
            '    0.00)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrCustoTot: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargemTot: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0) AND '
            '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) <> 0),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) / '
            '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) '
            '             ) *100 '
            '           )-100,       '
            ''
            '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) / '
            '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) = 0) AN' +
              'D '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllResultTot: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."RESULT">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllQtdIteGru: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 714.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object DMPMemo18: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrTotalGer: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrComissaoGer: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrCustoTotGer: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargemTotGer: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0) AND '
            '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) <> 0),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) / '
            '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) '
            '             ) *100 '
            '           )-100,       '
            ''
            '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) / '
            '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) = 0) AN' +
              'D '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerComissaoTotGer: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0,'
            
              '    (SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes) / SUM(<frxUser' +
              'Relatorio."TOTITE">,rlbDetalhes)) * 100,'
            '    0.00)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllResultTotGer: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."RESULT">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllQtdIteGer: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object qckResumoFaixa: TfrxSubreport
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Page = frxPaginaM.ResumoFaixa
        end
        object mmMsgCfgAna: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              'OBS.: Sistema configurado para nao deduzir desconto dado em conf' +
              'irmacao de documento.')
          TruncOutboundText = False
        end
      end
      object grpDocumento: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 476.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        Condition = 'frxUserRelatorio."NUMDOC"'
        object DMPLine8: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DTA DOC.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOC. FAT.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."DTAENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNumDocGrp: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNumDocGrpOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMFAT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo68: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object grpfDocumento: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 595.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        object DMPMemo64: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllVrTotalDoc: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrCustoDoc: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMargemDoc: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0) AND '
            '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) <> 0),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) / '
            '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) '
            '             ) *100 '
            '           )-100,       '
            ''
            '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) / '
            '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) = 0) AN' +
              'D '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllResultDoc: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."RESULT">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo71: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerComissaoDoc: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0,'
            
              '    (SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes) / SUM(<frxUser' +
              'Relatorio."TOTITE">,rlbDetalhes)) * 100,'
            '    0.00)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVrComissaoDoc: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object qckPaginaSintVendedor: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbCabecalhoSint: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1248.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1248.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL1]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA1]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REFERENTE1]'
            ' ')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPCAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 68.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPVEN]'
            ' ')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo76: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo77: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo79: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo107: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[LINGRU]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo113: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[PROMOC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo115: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[MARCA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbRodapeSint: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 578.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTituloSint: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 238.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VR.COMISS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VR.TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'TROCA/DEVOLUCAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAIS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA FIS/CUPOM FIS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VR.COMISS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VR.TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DOCS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTitMargem: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 34.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','#39'MARKUP'#39','#39'MARGEM'#39')]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPedPenTit1: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PEDIDOS')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPedPenTit2: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PEND.')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumarioSint: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 476.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo27: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITENF">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 336.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOMNF">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITEOU">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOMOU">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITETR">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOMTR">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLinha2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDDOC">,rlbDetalhesGroupAliq)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotMargem: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            
              '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupAliq) <> 0' +
              ') AND '
            
              '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupAliq) <> 0' +
              '),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            
              '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupAli' +
              'q) / '
            
              '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupAli' +
              'q) '
            '             ) *100 '
            '           )-100,       '
            ''
            
              '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupA' +
              'liq) / '
            
              '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupA' +
              'liq) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupAliq' +
              ') = 0) AND '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
          TruncOutboundText = False
        end
        object qckResumoFaixa2: TfrxSubreport
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Page = frxPaginaM.ResumoFaixa
        end
        object mmMsgCfgSin: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              'OBS.: Sistema configurado para nao deduzir desconto dado em conf' +
              'irmacao de documento.')
          TruncOutboundText = False
        end
      end
      object rlbCabecGroupAliq: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbCabecGroupAliqOnBeforePrint'
        Condition = 'frxUserRelatorio."CODVEN"'
      end
      object rlbRodapGroupAliq: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 391.000000000000000000
        Width = 1257.600000000000000000
        Stretched = True
        object qckResumo: TfrxSubreport
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          Page = frxPaginaM.Resumo
        end
      end
      object rlbDetalhesGroupAliq: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frxUserRelatorio
        DataSetName = 'frxUserRelatorio'
        RowCount = 0
        object rllValMargem: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."MARGEM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllToNfIf: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITENF'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITENF"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITEOU'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITEOU"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITETR'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITETR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMVEN'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NOMVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCoNfIf: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTCOMNF'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOMNF"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTCOMOU'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOMOU"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTCOMTR'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOMTR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTCOM'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."QTDDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPedPen: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllPedPenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object Resumo: TfrxDMPPage
      PaperWidth = 215.899860564673400000
      PaperHeight = 278.870653229369800000
      PaperSize = 1
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 796.800000000000000000
        object rllAliquotaTit: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'ALIQUOTA')
          TruncOutboundText = False
        end
        object rllBaseTit: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE COM.')
          TruncOutboundText = False
        end
        object rllVrComTit: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. COM.')
          TruncOutboundText = False
        end
      end
      object rlbDetalheAlq: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 68.000000000000000000
        Width = 796.800000000000000000
        DataSet = frxSinVen
        DataSetName = 'frxSinVen'
        RowCount = 0
        object rllAliquota: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSinVen."ALIQUOTA"]')
          TruncOutboundText = False
        end
        object rllBase: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSinVen."BASE"]')
          TruncOutboundText = False
        end
        object rllVrCom: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSinVen."VR_COM"]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 102.000000000000000000
        Width = 796.800000000000000000
        object rllTotalAliq: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          TruncOutboundText = False
        end
        object rllTotalBase: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSinVen."BASE">,rlbDetalheAlq)]')
          TruncOutboundText = False
        end
        object rllTotalVrCom: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSinVen."VR_COM">,rlbDetalheAlq)]')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 59.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotalAliquota: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxSinVen."BASE">,rlbDetalheAlq) = 0, 0, (SUM(<frxSinV' +
              'en."VR_COM">,rlbDetalheAlq) / SUM(<frxSinVen."BASE">,rlbDetalheA' +
              'lq) ) * 100)]')
          TruncOutboundText = False
        end
      end
    end
    object ResumoFaixa: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object rlbDetResFai: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frxResFai
        DataSetName = 'frxResFai'
        RowCount = 0
        object DMPMemo29: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxResFai."CODCOM"]-[frxResFai."DESFAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo85: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."MARVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo69: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResFai."VLRVEN"> - <frxResFai."VLRCUS">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo70: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."VLRCUS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo81: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."VLRCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo82: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."PERCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo83: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."VLRVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo84: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."MARFIN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo86: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."MARINI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo87: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxResFai."TIPPAG"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo105: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."TAXREP"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo94: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FAIXA')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo101: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','#39'%MARKUP'#39','#39'%MARGEM'#39')]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine13: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo106: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'FAIXAS DE COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo95: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'RESULTADO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo96: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CUSTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo97: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '$COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo98: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '%COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo99: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDAS')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo100: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'MAR.FINAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo102: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'MAR.INICIO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo103: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 51.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'V/P')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo104: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '%TAXA REP.')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 119.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxResFai."CODVEN"'
        object DMPMemo110: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[TITVEN]: [frxResFai."CODVEN"]-[frxResFai."NOMVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 204.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo111: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO [TITVEN]:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine12: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo118: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39',(((<SUM(<frxResFai."VLRVEN">,' +
              'rlbDetResFai)>  / IIF(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> =' +
              ' 0, 1, <SUM(<frxResFai."VLRCUS">,rlbDetResFai)>))*100)-100),((1-' +
              '(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> / IIF(<SUM(<frxResFai.' +
              '"VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">,rlbDe' +
              'tResFai)>)))*100))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo88: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxResFai."VLRVEN">,rlbDetResFai) - SUM(<frxResFai."VLRCUS' +
              '">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo89: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCUS">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo90: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCOM">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo91: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM(<frxResFai."VLRCOM">,rlbDetResFai) * 100) / IIF(<SUM(<frxR' +
              'esFai."VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">' +
              ',rlbDetResFai)>)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo92: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRVEN">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 272.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo93: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 1257.600000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            ' * V/P: Pagamento '#224' Vista / Pagamento '#224' Prazo   '
            
              ' * Quando a Taxa de Representatividade estiver preenchida, signi' +
              'fica que a comissao foi compartilhada entre Vendedor 1 e 2.')
          TruncOutboundText = False
        end
        object DMPLine19: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo147: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo148: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39',(((<SUM(<frxResFai."VLRVEN">,' +
              'rlbDetResFai)>  / IIF(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> =' +
              ' 0, 1, <SUM(<frxResFai."VLRCUS">,rlbDetResFai)>))*100)-100),((1-' +
              '(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> / IIF(<SUM(<frxResFai.' +
              '"VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">,rlbDe' +
              'tResFai)>)))*100))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo149: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxResFai."VLRVEN">,rlbDetResFai) - SUM(<frxResFai."VLRCUS' +
              '">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo150: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCUS">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo151: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCOM">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo152: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM(<frxResFai."VLRCOM">,rlbDetResFai) * 100) / IIF(<SUM(<frxR' +
              'esFai."VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">' +
              ',rlbDetResFai)>)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo153: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRVEN">,rlbDetResFai)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxSinVen: TfrxDBDataset
    UserName = 'frxSinVen'
    CloseDataSource = False
    DataSet = qryResAlq
    BCDToCurrency = False
    Left = 688
    Top = 120
  end
  object frxPaginaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42950.627500590280000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  vr_margem_tot, vr_custo_tot : double;'
      '  vr_margem_fin, vr_custo_fin : double;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      
        'begin                                                           ' +
        ' '
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin   '
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin    '
      '    vr_margem_tot := vr_margem_tot + rllTotal.Value;'
      '    vr_custo_tot := vr_custo_tot + rllVrCusto.value;        '
      '  End;   '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      '    If (vr_margem_tot <> 0) and (vr_custo_tot <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '        rllMargemTot.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_marg' +
        'em_tot  / vr_custo_tot ) *100 )-100)'
      '      Else'
      
        '        rllMargemTot.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_cus' +
        'to_tot / vr_margem_tot ) )*100);'
      '    End  '
      '    Else'
      '    Begin          '
      
        '      If (vr_custo_tot = 0) And (<frxGen."VS_STRMARMKP"> = '#39'1'#39') ' +
        'Then'
      
        '        rllMargemTot.text := '#39'100,00'#39'                           ' +
        '                                              '
      '      Else                '
      '        rllMargemTot.text := '#39'0,00'#39';'
      
        '    End;                                                        ' +
        '                       '
      ''
      '    vr_margem_fin := vr_margem_fin + vr_margem_tot;'
      '    vr_custo_fin := vr_custo_fin + vr_custo_tot;'
      '      '
      '    vr_margem_tot := 0;'
      '    vr_custo_tot := 0;'
      '  End;                  '
      '    '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."MARGEM"> = '#39'S'#39' Then'
      '  Begin'
      '    If (vr_margem_fin <> 0) and (vr_custo_fin <> 0) Then'
      '    Begin'
      '      if <frxGen."VS_STRMARMKP"> = '#39'2'#39' Then'
      
        '       rllMargemTotGer.Text  := Formatfloat('#39'#,##0.00'#39',( ( vr_ma' +
        'rgem_fin  / vr_custo_fin ) *100 )-100)  '
      '      Else'
      
        '       rllMargemTotGer.Text := Formatfloat('#39'#,##0.00'#39',( 1-( vr_c' +
        'usto_fin / vr_margem_fin ) )*100);'
      '    End'
      '    Else'
      '    Begin'
      
        '      If (vr_custo_fin = 0) And (<frxGen."VS_STRMARMKP"> = '#39'1'#39') ' +
        'Then'
      
        '        rllMargemTotGer.text := '#39'100,00'#39'                        ' +
        '                                                 '
      '      Else        '
      '        rllMargemTotGer.Text := '#39'0,00'#39';'
      '    End;                                '
      '  End;                           '
      'end;    '
      ''
      'procedure rlbCabecGroupAliqOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      '  Case <frxGen."VENDEDOR"> Of'
      '    0: Begin'
      '        fCriaResAliquota(<frxUserRelatorio."CODVEN">);'
      '       End;  '
      '    1: Begin'
      '        fCriaResAliquota(<frxUserRelatorio."CODVE2">);  '
      '       End;  '
      '    2: Begin'
      '        fCriaResAliquota(<frxUserRelatorio."CODDIG">);  '
      '       End;'
      '    3: Begin'
      '        fCriaResAliquota(<frxUserRelatorio."CODREP">);  '
      '       End;'
      '    4,'
      '    5: Begin'
      '        fCriaResAliquota(<frxUserRelatorio."SUPERV">);  '
      '       End;'
      '   End;'
      '              '
      'end;'
      ''
      'procedure rllPedPenOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllPedPen.Text := fRetPedidosPendentes();    '
      'end;'
      ''
      'procedure rllNumDocOnBeforePrint(Sender: TfrxComponent);'
      'begin                            '
      'end;'
      ''
      'procedure rllNumDocGrpOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      '  vr_margem_tot := 0;'
      '  vr_custo_tot := 0;'
      '  vr_margem_fin := 0;'
      '  vr_custo_fin := 0;'
      'end.')
    OnUserFunction = frxPaginaMUserFunction
    Left = 656
    Top = 88
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxResFai
        DataSetName = 'frxResFai'
      end
      item
        DataSet = frxSinVen
        DataSetName = 'frxSinVen'
      end
      item
        DataSet = frxUserRelatorio
        DataSetName = 'frxUserRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaAnalitico: TfrxReportPage
      PaperWidth = 337.819781820000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 39.677180000000000000
        Top = 510.236550000000000000
        Width = 1201.209399982144000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxUserRelatorio
        DataSetName = 'frxUserRelatorio'
        RowCount = 0
        object Memo19: TfrxMemoView
          Align = baClient
          Width = 1201.209399982144000000
          Height = 39.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 13619151
          ParentFont = False
        end
        object rllData: TfrxMemoView
          Left = 3.600000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."DTAENT"]')
          WordWrap = False
        end
        object rllNumDoc: TfrxMemoView
          Left = 79.000000000000000000
          Width = 127.974830000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNumDocOnBeforePrint'
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMDOC"]')
          WordWrap = False
        end
        object rllDocFat: TfrxMemoView
          Left = 245.415770000000000000
          Width = 150.652010000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMFAT"]')
          WordWrap = False
        end
        object rllEmp: TfrxMemoView
          Left = 209.795300000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."CODEMP"]')
          WordWrap = False
        end
        object rllCliente: TfrxMemoView
          Left = 398.667780000000000000
          Width = 261.921150000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NOMCLI"]')
          WordWrap = False
        end
        object rllPerComissao: TfrxMemoView
          Left = 676.000000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."PERCOM"]')
          WordWrap = False
        end
        object rllTotal: TfrxMemoView
          Left = 750.400000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITE"]')
          WordWrap = False
        end
        object rllVrComissao: TfrxMemoView
          Left = 1115.000000000000000000
          Width = 80.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOM"]')
          WordWrap = False
        end
        object rllVrCusto: TfrxMemoView
          Left = 845.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DataField = 'TOTCUS'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCUS"]')
          WordWrap = False
        end
        object rllMargem: TfrxMemoView
          Left = 1033.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'MARGEM'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."MARGEM"]')
          WordWrap = False
        end
        object rllResultDet: TfrxMemoView
          Left = 940.221090000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."RESULT"]')
          WordWrap = False
        end
        object rllQtdIte: TfrxMemoView
          Left = 582.945270000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."QTDITE"]')
          WordWrap = False
        end
        object rllCodigo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897649999999940000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."CODITE"]')
          WordWrap = False
        end
        object rllDescricao: TfrxMemoView
          Left = 79.179530000000000000
          Top = 18.897649999999940000
          Width = 332.069450000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."DESITE"]')
          WordWrap = False
        end
        object rllVrUnitario: TfrxMemoView
          Left = 494.044280000000000000
          Top = 18.897649999999940000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."DET_UNITAR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 414.069450000000000000
          Top = 18.897649999999940000
          Width = 70.374830000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."SIGUNI"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 823.937540000000000000
        Width = 1201.209399982144000000
        object rllNomeForm: TfrxMemoView
          Left = 2.250340000000000000
          Top = 4.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 670.866110000000000000
          Top = 4.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          WordWrap = False
        end
        object Line4: TfrxLineView
          Left = 2.250340000000000000
          Top = 24.602350000000120000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 47.236240000000000000
        Top = 309.921460000000000000
        Width = 1201.209399982144000000
        ReprintOnNewPage = True
        object Memo15: TfrxMemoView
          Left = 2.250340000000000000
          Top = 3.897649999999999000
          Width = 1197.354330710000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 2.250340000000000000
          Top = 2.500000000000000000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 2.250340000000000000
          Top = 26.500000000000000000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllDataTit: TfrxMemoView
          Left = 3.600000000000000000
          Top = 5.000000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA DOC.')
          ParentFont = False
          WordWrap = False
        end
        object rllNumDocTit: TfrxMemoView
          Left = 79.000000000000000000
          Top = 5.000000000000000000
          Width = 127.974830000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object rllDocFatTit: TfrxMemoView
          Left = 245.415770000000000000
          Top = 5.000000000000000000
          Width = 150.652010000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOC. FAT.')
          ParentFont = False
          WordWrap = False
        end
        object rllEmpTit: TfrxMemoView
          Left = 209.795300000000000000
          Top = 5.000000000000000000
          Width = 32.579530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
          WordWrap = False
        end
        object rllClienteTit: TfrxMemoView
          Left = 398.667780000000000000
          Top = 5.000000000000000000
          Width = 182.551020000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object rllPerComissaoTit: TfrxMemoView
          Left = 676.000000000000000000
          Top = 5.000000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COMISS')
          ParentFont = False
          WordWrap = False
        end
        object rllTotalTit: TfrxMemoView
          Left = 750.400000000000000000
          Top = 5.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object rllVrComissaoTit: TfrxMemoView
          Left = 1115.000000000000000000
          Top = 5.000000000000000000
          Width = 80.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR COMISS')
          ParentFont = False
          WordWrap = False
        end
        object rllVrCustoTit: TfrxMemoView
          Left = 845.000000000000000000
          Top = 5.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR CUSTO')
          ParentFont = False
          WordWrap = False
        end
        object rllMargemTit: TfrxMemoView
          Left = 1033.600000000000000000
          Top = 5.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','#39'%MARKUP'#39','#39'%MARGEM'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllResultTit: TfrxMemoView
          Left = 940.221090000000000000
          Top = 4.559059999999988000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'RESULTADO')
          ParentFont = False
          WordWrap = False
        end
        object rllQtdIteTit: TfrxMemoView
          Left = 582.945270000000000000
          Top = 5.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
          ParentFont = False
          WordWrap = False
        end
        object rllCodigoTit: TfrxMemoView
          Left = 3.779530000000000000
          Top = 28.015769999999970000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
          WordWrap = False
        end
        object RllDescricaoTit: TfrxMemoView
          Left = 77.179530000000000000
          Top = 28.015769999999970000
          Width = 332.069450000000000000
          Height = 17.000000000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object rllVrUnitarioTit: TfrxMemoView
          Left = 490.264750000000000000
          Top = 28.015769999999970000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.')
          ParentFont = False
          WordWrap = False
        end
        object rllUnidadeTit: TfrxMemoView
          Left = 414.069450000000000000
          Top = 28.015769999999970000
          Width = 70.374830000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 228.653680000000000000
        Top = 18.897650000000000000
        Width = 1201.209399982144000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 3.600000000000000000
          Top = 17.000000000000000000
          Width = 1196.523130000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 3.600000000000000000
          Top = 34.000000000000000000
          Width = 1197.581510000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 1026.066110000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1074.670810000000000000
          Top = 34.000000000000000000
          Width = 124.195300000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 862.941930000000000000
          Top = 34.000000000000000000
          Width = 215.508410000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 73.700787400000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 602.945270000000000000
          Top = 73.700787400000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 107.716535430000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REFERENTE]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 90.708661420000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPCAO]')
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 602.945270000000000000
          Top = 90.708661420000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TABPRE]')
          WordWrap = False
        end
        object Memo62: TfrxMemoView
          Left = 602.945270000000000000
          Top = 56.692949999999990000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTO]')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 124.724409450000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[ATIVIDADE]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 602.945270000000000000
          Top = 107.716535430000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPPRE]')
          WordWrap = False
        end
        object Memo78: TfrxMemoView
          Left = 3.779530000000000000
          Top = 141.732283460000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPVEN]')
          WordWrap = False
        end
        object Memo86: TfrxMemoView
          Left = 602.945270000000000000
          Top = 124.724409450000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CONDICAO]')
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 602.945270000000000000
          Top = 141.732283460000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTOPROD]')
          ParentFont = False
          WordWrap = False
        end
        object Memo88: TfrxMemoView
          Left = 3.779530000000000000
          Top = 158.740157480000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          WordWrap = False
        end
        object Memo89: TfrxMemoView
          Left = 602.945270000000000000
          Top = 158.740157480000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = 3.779530000000000000
          Top = 175.748031500000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          WordWrap = False
        end
        object Memo93: TfrxMemoView
          Left = 602.945270000000000000
          Top = 175.748031500000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[LINGRU]')
          WordWrap = False
        end
        object Memo129: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.692949999999990000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[GERENTE]')
          WordWrap = False
        end
        object Memo130: TfrxMemoView
          Left = 3.779530000000000000
          Top = 192.755905510000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[PRODUTO]')
          WordWrap = False
        end
        object Memo131: TfrxMemoView
          Left = 602.945270000000000000
          Top = 192.756030000000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PROMOC]')
          WordWrap = False
        end
        object Memo133: TfrxMemoView
          Left = 3.779530000000000000
          Top = 207.874150000000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[MARCA]')
          WordWrap = False
        end
      end
      object rlbCabecGroupVend: TfrxGroupHeader
        FillType = ftBrush
        Height = 39.661410000000000000
        Top = 381.732530000000000000
        Width = 1201.209399982144000000
        Condition = 'frxUserRelatorio."CODVEN"'
        object Memo3: TfrxMemoView
          Left = 3.600000000000000000
          Top = 12.000000000000000000
          Width = 734.740570000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TITVEN]: [frxUserRelatorio."NOMVEN"]')
          WordWrap = False
        end
      end
      object rlbRodapGroupVend: TfrxGroupFooter
        FillType = ftBrush
        Height = 28.322820000000000000
        Top = 634.961040000000000000
        Width = 1201.209399982144000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo24: TfrxMemoView
          Left = 264.614100000000000000
          Top = 6.000000000000000000
          Width = 312.415770000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO [TITVEN]:')
          WordWrap = False
        end
        object rllVrTotal: TfrxMemoView
          Left = 750.400000000000000000
          Top = 6.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllVrComissaoTot: TfrxMemoView
          Left = 1115.000000000000000000
          Top = 6.000000000000000000
          Width = 80.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllPerComissaoTot: TfrxMemoView
          Left = 676.000000000000000000
          Top = 6.000000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0,'
            
              '    (SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes) / SUM(<frxUser' +
              'Relatorio."TOTITE">,rlbDetalhes)) * 100,'
            '    0.00)]')
          WordWrap = False
        end
        object rllVrCustoTot: TfrxMemoView
          Left = 845.000000000000000000
          Top = 6.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllMargemTot: TfrxMemoView
          Left = 1033.600000000000000000
          Top = 6.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0) AND '
            '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) <> 0),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) / '
            '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) '
            '             ) *100 '
            '           )-100,       '
            ''
            '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) / '
            '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) = 0) AN' +
              'D '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
        end
        object rllResultTot: TfrxMemoView
          Left = 940.221090000000000000
          Top = 6.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxUserRela' +
              'torio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
        end
        object Line8: TfrxLineView
          Left = 2.250340000000000000
          Top = 4.779530000000022000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllQtdIteGru: TfrxMemoView
          Left = 582.945270000000000000
          Top = 6.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
        end
      end
      object rlbSumario: TfrxReportSummary
        FillType = ftBrush
        Height = 75.559060000000000000
        Top = 725.669760000000000000
        Width = 1201.209399982144000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object Memo18: TfrxMemoView
          Left = 264.614100000000000000
          Top = 3.000000000000000000
          Width = 312.415770000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
        end
        object rllVrTotalGer: TfrxMemoView
          Left = 750.400000000000000000
          Top = 3.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllVrComissaoGer: TfrxMemoView
          Left = 1115.000000000000000000
          Top = 3.000000000000000000
          Width = 80.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllVrCustoTotGer: TfrxMemoView
          Left = 845.000000000000000000
          Top = 3.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllMargemTotGer: TfrxMemoView
          Left = 1033.600000000000000000
          Top = 3.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0) AND '
            '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) <> 0),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) / '
            '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) '
            '             ) *100 '
            '           )-100,       '
            ''
            '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) / '
            '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) = 0) AN' +
              'D '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
        end
        object rllPerComissaoTotGer: TfrxMemoView
          Left = 676.000000000000000000
          Top = 3.000000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0,'
            
              '    (SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes) / SUM(<frxUser' +
              'Relatorio."TOTITE">,rlbDetalhes)) * 100,'
            '    0.00)]')
          WordWrap = False
        end
        object rllResultTotGer: TfrxMemoView
          Left = 940.221090000000000000
          Top = 3.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) - SUM(<frxUserRela' +
              'torio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllQtdIteGer: TfrxMemoView
          Left = 582.945270000000000000
          Top = 3.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 2.000000000000000000
          Top = 24.456710000000040000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object qckResumoFaixa: TfrxSubreport
          Top = 52.913419999999970000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxPaginaJ.ResumoFaixa
        end
        object mmMsgCfgAna: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.236239999999960000
          Width = 1201.209399980000000000
          Height = 15.118071180000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'OBS.: Sistema configurado para n'#227'o deduzir desconto dado em conf' +
              'irma'#231#227'o de documento.')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
      end
      object grpDocumento: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 445.984540000000000000
        Visible = False
        Width = 1201.209399982144000000
        Condition = 'frxUserRelatorio."NUMDOC"'
        object Memo14: TfrxMemoView
          Left = 57.472480000000000000
          Top = 3.000000000000000000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA DOC.')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 130.872480000000000000
          Top = 3.000000000000000000
          Width = 150.803149606299200000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Left = 325.965430000000000000
          Top = 3.000000000000000000
          Width = 150.652010000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOC. FAT.')
          ParentFont = False
          WordWrap = False
        end
        object Memo70: TfrxMemoView
          Left = 287.565430000000000000
          Top = 3.000000000000000000
          Width = 32.579530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
          WordWrap = False
        end
        object Memo71: TfrxMemoView
          Left = 482.437910000000000000
          Top = 3.000000000000000000
          Width = 367.747990000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo72: TfrxMemoView
          Left = 56.692950000000000000
          Top = 21.677180000000020000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."DTAENT"]')
          WordWrap = False
        end
        object rllNumDocGrp: TfrxMemoView
          Left = 132.092950000000000000
          Top = 21.677180000000020000
          Width = 150.803149606299200000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNumDocGrpOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMDOC"]')
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 325.185900000000000000
          Top = 21.677180000000020000
          Width = 150.652010000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxUserRelatorio."NUMFAT"]')
          WordWrap = False
        end
        object Memo75: TfrxMemoView
          Left = 286.785900000000000000
          Top = 21.677180000000020000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."CODEMP"]')
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 481.658380000000000000
          Top = 21.677180000000020000
          Width = 367.747990000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NOMCLI"]')
          WordWrap = False
        end
      end
      object grpfDocumento: TfrxGroupFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 574.488560000000000000
        Visible = False
        Width = 1201.209399982144000000
        object Memo77: TfrxMemoView
          Left = 266.143290000000000000
          Top = 8.000000000000000000
          Width = 312.415770000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          WordWrap = False
        end
        object Memo79: TfrxMemoView
          Left = 751.929190000000000000
          Top = 8.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes)]')
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Left = 1116.529190000000000000
          Top = 8.000000000000000000
          Width = 80.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllVrCustoDoc: TfrxMemoView
          Left = 846.529190000000000000
          Top = 8.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllMargemDoc: TfrxMemoView
          Left = 1033.700787400000000000
          Top = 8.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0) AND '
            '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) <> 0),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) / '
            '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) '
            '             ) *100 '
            '           )-100,       '
            ''
            '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) / '
            '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhes) = 0) AN' +
              'D '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
          WordWrap = False
        end
        object rllResultDoc: TfrxMemoView
          Left = 941.750280000000000000
          Top = 8.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."RESULT">,rlbDetalhes)]')
          WordWrap = False
        end
        object Line9: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo85: TfrxMemoView
          Left = 584.474460000000000000
          Top = 8.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDITE">,rlbDetalhes)]')
          WordWrap = False
        end
        object Line10: TfrxLineView
          Left = 3.779530000000000000
          Top = 30.236239999999960000
          Width = 1197.354330710000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPerComissaoDoc: TfrxMemoView
          Left = 676.535870000000000000
          Top = 8.559060000000045000
          Width = 69.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxUserRelatorio."TOTITE">,rlbDetalhes) <> 0,'
            
              '    (SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhes) / SUM(<frxUser' +
              'Relatorio."TOTITE">,rlbDetalhes)) * 100,'
            '    0.00)]')
          WordWrap = False
        end
      end
    end
    object qckPaginaSintVendedor: TfrxReportPage
      PaperWidth = 337.819781820000000000
      PaperHeight = 278.870653230000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalhoSint: TfrxPageHeader
        FillType = ftBrush
        Height = 187.078850000000000000
        Top = 18.897650000000000000
        Width = 1201.209399982144000000
        object Memo5: TfrxMemoView
          Left = 2.600000000000000000
          Top = 17.000000000000000000
          Width = 1196.523130000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 2.600000000000000000
          Top = 34.000000000000000000
          Width = 1197.581510000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL1]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 1025.286580000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo8: TfrxMemoView
          Left = 1111.686580000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Memo10: TfrxMemoView
          Left = 877.280520000000000000
          Top = 34.000000000000000000
          Width = 234.406060000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo63: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.692949999999990000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          WordWrap = False
        end
        object Memo64: TfrxMemoView
          Left = 601.945270000000000000
          Top = 73.700787400000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA1]')
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 3.779530000000000000
          Top = 90.708661420000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REFERENTE1]'
            ' ')
          WordWrap = False
        end
        object Memo66: TfrxMemoView
          Left = 3.779530000000000000
          Top = 73.700787400000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPCAO]')
          WordWrap = False
        end
        object Memo67: TfrxMemoView
          Left = 601.945270000000000000
          Top = 90.708661420000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[TABPRE]')
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 601.724800000000000000
          Top = 56.692949999999990000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DEPTO]')
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Left = 3.779530000000000000
          Top = 107.716535430000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPVEN]'
            ' ')
          WordWrap = False
        end
        object Memo90: TfrxMemoView
          Left = 601.945270000000000000
          Top = 107.716535430000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CLIENTE]')
          WordWrap = False
        end
        object Memo91: TfrxMemoView
          Left = 3.779530000000000000
          Top = 124.724409450000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTEEXC]')
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 601.945270000000000000
          Top = 124.724409450000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
          WordWrap = False
        end
        object Memo128: TfrxMemoView
          Left = 3.779530000000000000
          Top = 141.732261500000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[LINGRU]')
          WordWrap = False
        end
        object Memo132: TfrxMemoView
          Left = 601.945270000000000000
          Top = 141.732261500000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[PROMOC]')
          WordWrap = False
        end
        object Memo134: TfrxMemoView
          Left = 3.779530000000000000
          Top = 161.299320000000000000
          Width = 597.165354330000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[MARCA]')
          WordWrap = False
        end
      end
      object rlbRodapeSint: TfrxPageFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 631.181510000000000000
        Width = 1201.209399982144000000
        object Memo30: TfrxMemoView
          Top = 3.000000000000000000
          Width = 701.102040000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 670.866110000000000000
          Top = 3.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
      end
      object rlbTituloSint: TfrxHeader
        FillType = ftBrush
        Height = 45.322820000000000000
        Top = 268.346630000000000000
        Width = 1201.209399982144000000
        ReprintOnNewPage = True
        object Memo50: TfrxMemoView
          Align = baClient
          Width = 1201.209399982144000000
          Height = 45.322820000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Line5: TfrxLineView
          Top = 0.500000000000000000
          Width = 1200.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Top = 42.500000000000060000
          Width = 1200.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo32: TfrxMemoView
          Left = 2.600000000000000000
          Top = 22.000000000000060000
          Width = 91.918120000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 466.998330000000000000
          Top = 5.000000000000000000
          Width = 168.188978820000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 555.817230080000000000
          Top = 22.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 466.998330000000000000
          Top = 22.000000000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 638.598330000000000000
          Top = 5.000000000000000000
          Width = 164.409448820000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TROCA/DEVOLU'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 638.598330000000000000
          Top = 22.000000000000000000
          Width = 83.149608740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 723.598330000000000000
          Top = 22.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 895.017230080000000000
          Top = 22.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 806.198330000000000000
          Top = 5.000000000000000000
          Width = 168.188978820000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'TOTAIS')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 806.198330000000000000
          Top = 22.000000000000000000
          Width = 86.929138740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 299.398330000000000000
          Top = 5.000000000000000000
          Width = 164.409448820000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA FIS/CUPOM FIS')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 385.217227640000000000
          Top = 22.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 299.398330000000000000
          Top = 22.000000000000000000
          Width = 83.149606299212600000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 977.677800000000000000
          Top = 22.000000000000000000
          Width = 64.251970940000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DOCS')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 977.677800000000000000
          Top = 5.000000000000000000
          Width = 64.251968500000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          WordWrap = False
        end
        object rllTitMargem: TfrxMemoView
          Left = 1046.488870000000000000
          Top = 21.897650000000000000
          Width = 64.251970940000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','#39'MARKUP'#39','#39'MARGEM'#39')]')
          ParentFont = False
          WordWrap = False
        end
        object rllPedPenTit1: TfrxMemoView
          Left = 1116.299940000000000000
          Top = 3.779530000000022000
          Width = 75.590558500000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PEDIDOS')
          ParentFont = False
          WordWrap = False
        end
        object rllPedPenTit2: TfrxMemoView
          Left = 1116.299940000000000000
          Top = 20.787404009999990000
          Width = 75.590558500000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PEND.')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumarioSint: TfrxReportSummary
        FillType = ftBrush
        Height = 75.590551180000000000
        Top = 532.913730000000000000
        Width = 1201.209399982144000000
        object mmMsgCfgSin: TfrxMemoView
          Left = 3.000000000000000000
          Top = 33.456710000000040000
          Width = 1201.209399980000000000
          Height = 15.118071180000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'OBS.: Sistema configurado para n'#227'o deduzir desconto dado em conf' +
              'irma'#231#227'o de documento.')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Memo27: TfrxMemoView
          Left = 2.600000000000000000
          Top = 7.000000000000114000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL:')
        end
        object Memo28: TfrxMemoView
          Left = 299.398330000000000000
          Top = 7.000000000000000000
          Width = 86.929133858267720000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITENF">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 388.217227640000000000
          Top = 7.000000000000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOMNF">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 466.998330000000000000
          Top = 7.000000000000000000
          Width = 86.929133858267720000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITEOU">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 555.817230080000000000
          Top = 7.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOMOU">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 638.598330000000000000
          Top = 7.000000000000000000
          Width = 83.149608740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITETR">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 723.598330000000000000
          Top = 7.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOMTR">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Left = 806.198330000000000000
          Top = 7.000000000000000000
          Width = 86.929138740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 895.017230080000000000
          Top = 7.000000000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."TOTCOM">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object rllLinha2: TfrxLineView
          Left = 384.398330000000000000
          Top = 3.500000000000000000
          Width = 79.370078740000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo55: TfrxMemoView
          Left = 977.677800000000000000
          Top = 7.000000000000000000
          Width = 64.251970940000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUserRelatorio."QTDDOC">,rlbDetalhesGroupAliq)]')
          WordWrap = False
        end
        object rllTotMargem: TfrxMemoView
          Left = 1046.488870000000000000
          Top = 6.559060000000045000
          Width = 64.251970940000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[ '
            ' IIF('
            
              '     (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupAliq) <> 0' +
              ') AND '
            
              '     (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupAliq) <> 0' +
              '),'
            ''
            '      IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','
            
              '          ( (SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupAli' +
              'q) / '
            
              '             SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupAli' +
              'q) '
            '             ) *100 '
            '           )-100,       '
            ''
            
              '          (1-( SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupA' +
              'liq) / '
            
              '               SUM(<frxUserRelatorio."TOTITE">,rlbDetalhesGroupA' +
              'liq) '
            '             )'
            '           ) * 100),'
            ''
            '      IIF('
            
              '           (SUM(<frxUserRelatorio."TOTCUS">,rlbDetalhesGroupAliq' +
              ') = 0) AND '
            '           (<frxGen."VS_STRMARMKP"> = '#39'1'#39'),'
            
              '          100.00,                                               ' +
              '                          '
            '          0.00'
            '          )'
            '    )'
            ''
            ']')
        end
        object qckResumoFaixaSint: TfrxSubreport
          Top = 52.913385830000040000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Page = frxPaginaJ.ResumoFaixa
        end
      end
      object rlbCabecGroupAliq: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 336.378170000000000000
        Width = 1201.209399982144000000
        OnBeforePrint = 'rlbCabecGroupAliqOnBeforePrint'
        Condition = 'frxUserRelatorio."CODVEN"'
      end
      object rlbRodapGroupAliq: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 419.527830000000000000
        Width = 1201.209399982144000000
        Stretched = True
        object qckResumo: TfrxSubreport
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          Page = frxPaginaJ.Resumo
        end
      end
      object rlbDetalhesGroupAliq: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 377.953000000000000000
        Width = 1201.209399982144000000
        DataSet = frxUserRelatorio
        DataSetName = 'frxUserRelatorio'
        RowCount = 0
        object Memo51: TfrxMemoView
          Align = baClient
          Width = 1201.209399982144000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 13487565
          ParentFont = False
        end
        object rllToNfIf: TfrxMemoView
          Left = 299.398330000000000000
          Width = 86.929133858267720000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITENF"]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 466.998330000000000000
          Width = 86.929133859999990000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITEOU"]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 638.598330000000000000
          Width = 83.149608740000000000
          Height = 17.000000000000000000
          DataField = 'TOTITETR'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITETR"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 806.198330000000000000
          Width = 86.929138740000000000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTITE"]')
          WordWrap = False
        end
        object rllVendedor: TfrxMemoView
          Left = 2.600000000000000000
          Width = 294.198330000000000000
          Height = 17.000000000000000000
          DataField = 'NOMVEN'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxUserRelatorio."NOMVEN"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 555.817230079999900000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DataField = 'TOTCOMOU'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOMOU"]')
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 723.598330000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DataField = 'TOTCOMTR'
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOMTR"]')
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 895.017230080000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOM"]')
          WordWrap = False
        end
        object rllTotDoc: TfrxMemoView
          Left = 977.677800000000000000
          Width = 64.251970940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."QTDDOC"]')
          ParentFont = False
        end
        object rllValMargem: TfrxMemoView
          Left = 1046.488870000000000000
          Width = 64.251970940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."MARGEM"]')
          ParentFont = False
        end
        object rllPedPen: TfrxMemoView
          Left = 1116.299940000000000000
          Width = 75.590558500000000000
          Height = 15.118120000000000000
          OnAfterData = 'rllPedPenOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 388.217227640000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          DataSet = frxUserRelatorio
          DataSetName = 'frxUserRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserRelatorio."TOTCOMNF"]')
          WordWrap = False
        end
      end
    end
    object Resumo: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object rllAliquotaTit: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftLeft, ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA')
        end
        object rllBaseTit: TfrxMemoView
          Left = 130.400000000000000000
          Top = 17.000000000000000000
          Width = 122.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE COM.')
        end
        object rllVrComTit: TfrxMemoView
          Left = 254.200000000000000000
          Top = 17.000000000000000000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. COM.')
        end
      end
      object rlbDetalheAlq: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 75.590600000000000000
        Width = 740.409927000000000000
        DataSet = frxSinVen
        DataSetName = 'frxSinVen'
        RowCount = 0
        object rllAliquota: TfrxMemoView
          Left = 9.600000000000000000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSinVen."ALIQUOTA"]')
        end
        object rllBase: TfrxMemoView
          Left = 130.400000000000000000
          Width = 122.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSinVen."BASE"]')
        end
        object rllVrCom: TfrxMemoView
          Left = 254.200000000000000000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSinVen."VR_COM"]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 37.763760000000000000
        Top = 117.165430000000000000
        Width = 740.409927000000000000
        object rllTotalAliq: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.881879999999995000
          Width = 54.727520000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
        end
        object rllTotalBase: TfrxMemoView
          Left = 130.400000000000000000
          Top = 1.881879999999995000
          Width = 122.759060000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSinVen."BASE">,rlbDetalheAlq)]')
        end
        object rllTotalVrCom: TfrxMemoView
          Left = 254.200000000000000000
          Top = 1.881879999999995000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxSinVen."VR_COM">,rlbDetalheAlq)]')
        end
        object Line7: TfrxLineView
          Left = -0.400000000000000000
          Top = 29.263760000000010000
          Width = 741.542979999997100000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotalAliquota: TfrxMemoView
          Left = 63.252010000000000000
          Top = 1.881879999999995000
          Width = 66.066110000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxSinVen."BASE">,rlbDetalheAlq) = 0, 0, (SUM(<frxSinV' +
              'en."VR_COM">,rlbDetalheAlq) / SUM(<frxSinVen."BASE">,rlbDetalheA' +
              'lq) ) * 100)]')
        end
      end
    end
    object ResumoFaixa: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetResFai: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 117.165430000000000000
        Width = 1201.134634000000000000
        DataSet = frxResFai
        DataSetName = 'frxResFai'
        RowCount = 0
        object Memo114: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Fill.BackColor = clWhite
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Width = 314.834570000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResFai."CODCOM"]-[frxResFai."DESFAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 535.803049530000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."VLRVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo83: TfrxMemoView
          Left = 913.755829840000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."PERCOM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo84: TfrxMemoView
          Left = 819.267653070000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."MARVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo94: TfrxMemoView
          Left = 1102.866915020000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."VLRCOM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo95: TfrxMemoView
          Left = 724.779329840000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxResFai."VLRVEN"> - <frxResFai."VLRCUS">]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo96: TfrxMemoView
          Left = 630.291153070000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."VLRCUS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo97: TfrxMemoView
          Left = 441.314897170000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."MARFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 346.826659370000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."MARINI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo116: TfrxMemoView
          Left = 318.362400000000000000
          Width = 28.346456690000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResFai."TIPPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo119: TfrxMemoView
          Left = 1008.377952760000000000
          Width = 94.488188980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResFai."TAXREP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 75.590600000000000000
        Width = 1201.134634000000000000
        Condition = 'frxResFai."CODVEN"'
        object Memo102: TfrxMemoView
          Top = 0.755905510000005100
          Width = 1201.134634000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[TITVEN]: [frxResFai."CODVEN"]-[frxResFai."NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 154.960730000000000000
        Width = 1201.134634000000000000
        object Memo106: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clWhite
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 535.803049530000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRVEN">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo105: TfrxMemoView
          Left = 819.267653070000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39',(((<SUM(<frxResFai."VLRVEN">,' +
              'rlbDetResFai)>  / IIF(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> =' +
              ' 0, 1, <SUM(<frxResFai."VLRCUS">,rlbDetResFai)>))*100)-100),((1-' +
              '(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> / IIF(<SUM(<frxResFai.' +
              '"VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">,rlbDe' +
              'tResFai)>)))*100))]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo107: TfrxMemoView
          Left = 913.755829840000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM(<frxResFai."VLRCOM">,rlbDetResFai) * 100) / IIF(<SUM(<frxR' +
              'esFai."VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">' +
              ',rlbDetResFai)>)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo108: TfrxMemoView
          Left = 630.291153070000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCUS">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo109: TfrxMemoView
          Left = 1102.866915020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCOM">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo115: TfrxMemoView
          Left = 724.779329840000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxResFai."VLRVEN">,rlbDetResFai) - SUM(<frxResFai."VLRCUS' +
              '">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo117: TfrxMemoView
          Left = 9.314836150000000000
          Width = 526.488250000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO [TITVEN]:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 34.015748030000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Memo29: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 819.267653070000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39','#39'%MARKUP'#39','#39'%MARGEM'#39')]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Top = -0.000012200000000462
          Width = 1197.355104000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FAIXAS DE COMISS'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 724.779329840000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'RESULTADO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo98: TfrxMemoView
          Left = 630.291153070000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CUSTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo99: TfrxMemoView
          Left = 1102.866915020000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISS'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo100: TfrxMemoView
          Left = 913.755829840000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COMISS'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo101: TfrxMemoView
          Left = 535.803049530000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo111: TfrxMemoView
          Left = 441.314897170000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MAR. FINAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo112: TfrxMemoView
          Left = 346.826659370000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MAR. INICIAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo113: TfrxMemoView
          Top = 17.007874020000000000
          Width = 314.834570000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FAIXA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo110: TfrxMemoView
          Left = 318.362400000000000000
          Top = 17.007874020000000000
          Width = 28.346456690000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'V/P')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo118: TfrxMemoView
          Left = 1008.377952760000000000
          Top = 17.007874020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%TAXA REP.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 35.905511810000000000
        Top = 196.535560000000000000
        Width = 1201.134634000000000000
        object Memo103: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 35.905511810000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '* V/P: Pagamento '#224' Vista / Pagamento '#224' Prazo     * Quando Taxa d' +
              'e Representatividade estiver preenchida, significa que a comiss'#227 +
              'o foi compartilhada entre Vendedor 1 e 2.')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Memo127: TfrxMemoView
          Width = 1201.134634000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -2147483640
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clWhite
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 535.803049530000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRVEN">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo121: TfrxMemoView
          Left = 819.267653070000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxGen."VS_STRMARMKP"> = '#39'2'#39',(((<SUM(<frxResFai."VLRVEN">,' +
              'rlbDetResFai)>  / IIF(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> =' +
              ' 0, 1, <SUM(<frxResFai."VLRCUS">,rlbDetResFai)>))*100)-100),((1-' +
              '(<SUM(<frxResFai."VLRCUS">,rlbDetResFai)> / IIF(<SUM(<frxResFai.' +
              '"VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">,rlbDe' +
              'tResFai)>)))*100))]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo122: TfrxMemoView
          Left = 913.755829840000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM(<frxResFai."VLRCOM">,rlbDetResFai) * 100) / IIF(<SUM(<frxR' +
              'esFai."VLRVEN">,rlbDetResFai)> = 0, 1, <SUM(<frxResFai."VLRVEN">' +
              ',rlbDetResFai)>)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo123: TfrxMemoView
          Left = 630.291153070000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCUS">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo124: TfrxMemoView
          Left = 1102.866915020000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResFai."VLRCOM">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo125: TfrxMemoView
          Left = 724.779329840000000000
          Width = 94.488188980000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxResFai."VLRVEN">,rlbDetResFai) - SUM(<frxResFai."VLRCUS' +
              '">,rlbDetResFai)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo126: TfrxMemoView
          Left = 9.314836150000000000
          Width = 526.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object qryResAlq: TUniQuery
    ReadOnly = True
    Constraints = <>
    Left = 656
    Top = 312
  end
  object frxUserRelatorio: TfrxUserDataSet
    UserName = 'frxUserRelatorio'
    OnCheckEOF = frxUserRelatorioCheckEOF
    OnFirst = frxUserRelatorioFirst
    OnNext = frxUserRelatorioNext
    OnPrior = frxUserRelatorioPrior
    OnGetValue = frxUserRelatorioGetValue
    OnNewGetValue = frxUserRelatorioNewGetValue
    Left = 688
    Top = 152
  end
  object cdsQtdVen: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 688
    Top = 312
    object cdsQtdVenCODVEN: TStringField
      FieldName = 'CODVEN'
    end
    object cdsQtdVenQTDDOC: TIntegerField
      FieldName = 'QTDDOC'
    end
  end
  object frxResFai: TfrxDBDataset
    UserName = 'frxResFai'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 688
    Top = 376
  end
end
