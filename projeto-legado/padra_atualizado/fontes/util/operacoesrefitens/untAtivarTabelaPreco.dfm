inherited frmAtivarTabelaPreco: TfrmAtivarTabelaPreco
  Width = 977
  Height = 731
  Caption = 'Ativa'#231#227'o de Tabela de Pre'#231'o'
  ExplicitWidth = 977
  ExplicitHeight = 731
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 660
    Width = 971
    TabOrder = 6
    ExplicitTop = 660
    ExplicitWidth = 971
    inherited FlwBotoes: TFlowPanel
      Width = 967
      ExplicitWidth = 967
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 891
      ExplicitLeft = 891
    end
  end
  inherited pnlStatus: TPanel
    Top = 686
    Width = 971
    TabOrder = 7
    ExplicitTop = 686
    ExplicitWidth = 971
    inherited pnlNomeForm: TPanel
      Left = 800
      ExplicitLeft = 800
    end
    inherited pnlInfo: TPanel
      Width = 800
      ExplicitWidth = 800
      object shpMultSel: TShape
        Left = 782
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas desta tela possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 748
        ExplicitTop = 3
      end
    end
  end
  object pnlFiltro1: TPanel [2]
    Left = 0
    Top = 0
    Width = 971
    Height = 134
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 31
      Top = 5
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label2: TLabel
      Left = 47
      Top = 27
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 327
      Top = 27
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label4: TLabel
      Left = 372
      Top = 93
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label6: TLabel
      Left = 66
      Top = 50
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label167: TLabel
      Left = 11
      Top = 70
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Produto:'
    end
    object Label14: TLabel
      Left = 327
      Top = 49
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Compra:'
    end
    object Label50: TLabel
      Left = 701
      Top = 81
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Incide PIS?:'
    end
    object ColorLabel2: TColorLabel
      Left = 810
      Top = 81
      Width = 99
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos '
      CorDestaque = clRed
    end
    object Label31: TLabel
      Left = 529
      Top = 93
      Width = 121
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#237'vel de Giro de Estoque:'
    end
    object Label9: TLabel
      Left = 29
      Top = 94
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object lblCodGpr: TLabel
      Left = 336
      Top = 71
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Pre'#231'o:'
    end
    object Label20: TLabel
      Left = 37
      Top = 116
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Composi'#231#227'o:'
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 101
      Top = 2
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 149
      Top = 2
      Width = 543
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
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 101
      Top = 24
      Width = 220
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnKeyPress = edtDesIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 385
      Top = 24
      Width = 307
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnKeyPress = edtRefereKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 417
      Top = 90
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 16
      OnExit = edtCodUniExit
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 101
      Top = 46
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 5
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 149
      Top = 46
      Width = 172
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
    object rdgTipAltFor: TRadioGroup
      Left = 698
      Top = 3
      Width = 266
      Height = 73
      Caption = 'Tipo de Altera'#231#227'o, com Base na Tabela Do Fornec.'
      ItemIndex = 1
      Items.Strings = (
        
          'Aplicar a Margem da tabela do Fornecedor e recalcular Pre'#231'o de V' +
          'enda.'
        
          'Manter o Pre'#231'o de Venda do cadastro do produto e recalcular a ma' +
          'rgem.')
      TabOrder = 2
      TabStop = True
      WordWrap = True
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 101
      Top = 68
      Width = 48
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
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesPrdPro: TEditFocus
      Left = 149
      Top = 68
      Width = 172
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtGruCmp: TEditFocus
      Tag = 99
      Left = 417
      Top = 46
      Width = 69
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
      TabOrder = 7
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 486
      Top = 46
      Width = 206
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
    object edtIncPis: TEditFocus
      Tag = 99
      Left = 759
      Top = 77
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 13
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object rdgEstMin: TRadioGroup
      Left = 697
      Top = 99
      Width = 267
      Height = 33
      Caption = 'Op'#231#227'o para Estoque M'#237'nimo'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Gerado'
        'Digitado'
        'Todos')
      TabOrder = 17
    end
    object cmbGiroEstoque: TComboBoxFocus
      Tag = 99
      Left = 653
      Top = 90
      Width = 39
      Height = 22
      Style = csDropDownList
      DropDownCount = 4
      ItemIndex = 0
      MaxLength = 1
      TabOrder = 18
      Items.Strings = (
        ''
        'A'
        'B'
        'C')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 101
      Top = 90
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
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
    object edtDesDep: TEditFocus
      Left = 149
      Top = 90
      Width = 172
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodGpr: TEditFocus
      Tag = 99
      Left = 417
      Top = 68
      Width = 69
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 11
      OnExit = edtCodGprExit
      OnKeyPress = edtCodGprKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesGpr: TEditFocus
      Left = 486
      Top = 68
      Width = 206
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
    object edtCodCom: TEditFocus
      Tag = 99
      Left = 101
      Top = 112
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      OnExit = edtCodComExit
      OnKeyPress = edtCodComKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesComp: TEditFocus
      Left = 149
      Top = 112
      Width = 172
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlFiltro2: TPanel [3]
    Left = 0
    Top = 156
    Width = 971
    Height = 110
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label8: TLabel
      Left = 40
      Top = 4
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label5: TLabel
      Left = 33
      Top = 26
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Fiscal:'
    end
    object Label7: TLabel
      Left = 3
      Top = 92
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classifica'#231#227'o de IPI:'
    end
    object ColorLabel1: TColorLabel
      Left = 442
      Top = 92
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label13: TLabel
      Left = 369
      Top = 92
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo:'
    end
    object lbl50: TLabel
      Left = 233
      Top = 92
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo EX IPI:'
    end
    object Label18: TLabel
      Left = 47
      Top = 48
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Pis:'
    end
    object Label19: TLabel
      Left = 30
      Top = 70
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Cofins:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 101
      Top = 0
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
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
    object edtNomFor: TEditFocus
      Left = 170
      Top = 0
      Width = 370
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
    object edtCodAbr: TEditFocus
      Tag = 99
      Left = 101
      Top = 22
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodAbrExit
      OnKeyPress = edtCodAbrKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAbr: TEditFocus
      Left = 170
      Top = 22
      Width = 370
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
    object edtClaIPI: TEditFocus
      Tag = 99
      Left = 101
      Top = 88
      Width = 126
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 6
      OnKeyPress = edtClaIPIKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtStatus: TEditFocus
      Tag = 99
      Left = 399
      Top = 88
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 8
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtExcIpi: TEditFocus
      Tag = 99
      Left = 304
      Top = 88
      Width = 59
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtAbfPis: TEditFocus
      Tag = 99
      Left = 101
      Top = 44
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      OnExit = edtAbfPisExit
      OnKeyPress = edtAbfPisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesPis: TEditFocus
      Left = 170
      Top = 44
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtAbfCof: TEditFocus
      Tag = 99
      Left = 101
      Top = 66
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtAbfCofExit
      OnKeyPress = edtAbfCofKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCof: TEditFocus
      Left = 170
      Top = 66
      Width = 370
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object chkArrMai: TCheckBox
      Left = 557
      Top = 91
      Width = 247
      Height = 17
      Caption = 'Arredondar Casas Decimais(Pre'#231'o de Venda)'
      TabOrder = 11
      OnClick = chkArrMaiClick
    end
    object edtDecUni: TEditFocus
      Tag = 99
      Left = 810
      Top = 88
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 12
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object rdgForPrin: TRadioGroup
      Left = 557
      Top = 49
      Width = 267
      Height = 33
      Caption = 'Fornecedor Principal'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 13
    end
    object grbGirFor: TGroupBox
      Left = 558
      Top = -3
      Width = 266
      Height = 46
      Caption = 'N'#237'vel de Giro de Estoque por Fornecedor'
      TabOrder = 14
      object chkForA: TCheckBox
        Left = 30
        Top = 21
        Width = 33
        Height = 17
        Caption = 'A'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkForB: TCheckBox
        Left = 74
        Top = 21
        Width = 33
        Height = 17
        Caption = 'B'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object chkForC: TCheckBox
        Left = 117
        Top = 21
        Width = 33
        Height = 17
        Caption = 'C'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object pnlTabAtu: TPanel [4]
    Left = 0
    Top = 266
    Width = 971
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label11: TLabel
      Left = 7
      Top = 6
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Pre'#231'o Atual:'
    end
    object edtTabAtu: TEditFocus
      Tag = 99
      Left = 101
      Top = 0
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtTabAtuKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomAtu: TEditFocus
      Left = 170
      Top = 0
      Width = 370
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
  object pnlTabPre: TPanel [5]
    Left = 0
    Top = 288
    Width = 971
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object Label22: TLabel
      Left = 6
      Top = 6
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Pre'#231'o Nova:'
    end
    object Label23: TLabel
      Left = 547
      Top = 6
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Venda:'
    end
    object edtTabPre: TEditFocus
      Tag = 99
      Left = 101
      Top = 0
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtTabPreKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomTab: TEditFocus
      Left = 170
      Top = 0
      Width = 370
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
    object cbxPreVen: TComboBoxFocus
      Tag = 99
      Left = 629
      Top = 0
      Width = 52
      Height = 22
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbxPreVenChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkPreRev: TCheckBox
      Left = 101
      Top = 28
      Width = 242
      Height = 17
      Caption = 'Atualizar Pre'#231'o de Revista e Markup original'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object chkMarcaAtiva: TCheckBox
      Left = 349
      Top = 28
      Width = 262
      Height = 17
      Caption = 'Marcar a Tabela como Ativa para Compras'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object cxgItens: TcxGrid [6]
    Left = 0
    Top = 338
    Width = 971
    Height = 322
    Align = alClient
    TabOrder = 5
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro selecionado>'
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'TAB_CODTAB'
        SortIndex = 1
        SortOrder = soAscending
        Width = 65
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'TAB_NOMTAB'
        SortIndex = 0
        SortOrder = soAscending
        Width = 247
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Descri'#231#227'o no Fornecedor'
        DataBinding.FieldName = 'TAB_DESTAB'
        Width = 218
      end
      object cxgItensViewColumn6: TcxGridDBColumn
        Caption = 'Ativa'
        DataBinding.FieldName = 'TAB_ATICMP'
        HeaderAlignmentHorz = taCenter
        Width = 42
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'TAB_CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 68
      end
      object cxgItensViewColumn5: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 191
      end
      object cxgItensMARCADO: TcxGridDBColumn
        DataBinding.FieldName = 'MARCADO'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlCadMon: TPanel [7]
    Left = 0
    Top = 134
    Width = 971
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object lbl1: TLabel
      Left = 45
      Top = 3
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object edtCodMon: TEditFocus
      Tag = 99
      Left = 101
      Top = 0
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnExit = edtCodMonExit
      OnKeyPress = edtCodMonKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesMon: TEditFocus
      Left = 170
      Top = 0
      Width = 370
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 816
    Top = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 256
  end
end
