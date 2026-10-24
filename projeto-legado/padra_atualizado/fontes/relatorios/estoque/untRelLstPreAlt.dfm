inherited frmRelLstPreAlt: TfrmRelLstPreAlt
  Left = 504
  Top = 206
  Width = 709
  Height = 508
  Caption = 'Relat'#243'rio de Pre'#231'os Alterados'
  OnDestroy = FormDestroy
  ExplicitWidth = 709
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 435
    Width = 703
    ExplicitTop = 435
    ExplicitWidth = 703
    inherited btnSair: TBitBtnLocked
      Left = 620
      ExplicitLeft = 620
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 5
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 5
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 85
      Width = 82
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 85
      ExplicitWidth = 82
    end
  end
  inherited pnlDados: TPanel
    Width = 703
    Height = 435
    ExplicitWidth = 703
    ExplicitHeight = 435
    object Label5: TLabel [0]
      Left = 6
      Top = 7
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
      Left = 118
      Top = 7
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
    object Label10: TLabel [2]
      Left = 7
      Top = 44
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
    object Label1: TLabel [3]
      Left = 381
      Top = 169
      Width = 64
      Height = 14
      Caption = 'Listar Pre'#231'os'
    end
    object Label2: TLabel [4]
      Left = 380
      Top = 7
      Width = 82
      Height = 14
      Caption = 'Listar Altera'#231#245'es'
    end
    object lblDescricao: TLabel [5]
      Left = 7
      Top = 81
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [6]
      Left = 7
      Top = 118
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel [7]
      Left = 7
      Top = 155
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel [8]
      Left = 7
      Top = 192
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
    object Label3: TLabel [9]
      Left = 528
      Top = 7
      Width = 36
      Height = 14
      Caption = 'Imprimir'
    end
    object shaListAlt: TShape [10]
      Left = 381
      Top = 21
      Width = 8
      Height = 65
    end
    object shaImpAlt: TShape [11]
      Left = 526
      Top = 21
      Width = 8
      Height = 65
    end
    object Bevel1: TBevel [12]
      Left = 372
      Top = 0
      Width = 4
      Height = 430
      Shape = bsLeftLine
    end
    object Label11: TLabel [13]
      Left = 7
      Top = 232
      Width = 89
      Height = 14
      Caption = 'Localiza'#231#227'o Fisica'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel [14]
      Left = 7
      Top = 272
      Width = 114
      Height = 14
      Caption = 'Localiza'#231#227'o F'#237'sica Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 500
      Top = 310
      Width = 197
      Height = 43
      TabOrder = 20
      ExplicitLeft = 500
      ExplicitTop = 310
      ExplicitWidth = 197
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Left = 29
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 17
        ExplicitTop = 17
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 6
      Top = 21
      Width = 86
      Height = 22
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 118
      Top = 21
      Width = 86
      Height = 22
      EditMask = '!99/99/9999;1;_'
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
      ValidaData = False
    end
    object edtProdutos: TEditFocus
      Tag = 99
      Left = 7
      Top = 58
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnExit = edtProdutosExit
      OnKeyPress = edtProdutosKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesProduto: TEditFocus
      Left = 66
      Top = 58
      Width = 300
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkIncNov: TCheckBox
      Left = 379
      Top = 97
      Width = 129
      Height = 17
      Caption = 'Incluir produtos novos'
      TabOrder = 12
    end
    object chkLisPre: TCheckListBox
      Tag = 99
      Left = 379
      Top = 183
      Width = 115
      Height = 170
      OnClickCheck = chkLisPreClickCheck
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      TabOrder = 16
    end
    object rdgTipRel: TRadioGroup
      Left = 502
      Top = 174
      Width = 195
      Height = 43
      Caption = 'Tipo de Relat'#243'rio:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Completo'
        'Resumido')
      TabOrder = 17
      OnClick = rdgTipRelClick
    end
    object chkListAlt: TCheckListBox
      Tag = 99
      Left = 387
      Top = 21
      Width = 107
      Height = 65
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      Items.Strings = (
        'Pre'#231'o de Custo'
        'Margem de Lucro'
        'Pre'#231'o de Venda'
        'Pre'#231'o de Compra')
      TabOrder = 10
    end
    object rdgOpcQuebra: TRadioGroup
      Left = 500
      Top = 217
      Width = 197
      Height = 43
      Caption = 'Quebrar por:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Data Altera'#231#227'o'
        'Fornecedor')
      TabOrder = 18
      OnClick = rdgOpcQuebraClick
    end
    object pgbStatus: TProgressBar
      Left = 1
      Top = 426
      Width = 701
      Height = 8
      Align = alBottom
      Smooth = True
      Step = 0
      TabOrder = 22
      Visible = False
    end
    object chkImpRef: TCheckBox
      Left = 379
      Top = 114
      Width = 166
      Height = 17
      Caption = 'Imprimir referencia do Produto'
      TabOrder = 13
    end
    object edtDescri: TEditFocus
      Left = 7
      Top = 95
      Width = 359
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
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 7
      Top = 132
      Width = 359
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
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFornecedor: TEditFocus
      Tag = 99
      Left = 7
      Top = 169
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 66
      Top = 169
      Width = 300
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 23
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
      Left = 7
      Top = 206
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodDigExit
      OnKeyPress = edtCodDigKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDig: TEditFocus
      Left = 66
      Top = 206
      Width = 300
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
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOpcOrd: TRadioGroup
      Left = 500
      Top = 261
      Width = 197
      Height = 43
      Caption = 'Ordenar por:'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Data Altera'#231#227'o'
        'Descri'#231#227'o Item')
      TabOrder = 19
    end
    object chkOriAlt: TCheckBox
      Left = 379
      Top = 148
      Width = 201
      Height = 17
      Caption = 'Imprimir origem da altera'#231#227'o de pre'#231'o'
      TabOrder = 15
    end
    object chkImprimir: TCheckListBox
      Tag = 99
      Left = 533
      Top = 21
      Width = 115
      Height = 65
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      Items.Strings = (
        'Pre'#231'o de Custo'
        'Margem de Lucro'
        'Pre'#231'o de Venda'
        'Pre'#231'o de Compra')
      TabOrder = 11
    end
    object grpDadosNE: TGroupBox
      Left = 7
      Top = 318
      Width = 359
      Height = 103
      Caption = 'Dados da Nota de Entrada'
      TabOrder = 9
      OnEnter = grpDadosNEEnter
      object Label4: TLabel
        Left = 6
        Top = 23
        Width = 54
        Height = 14
        Caption = 'Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEspecie: TLabel
        Left = 88
        Top = 23
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblSerie: TLabel
        Left = 129
        Top = 23
        Width = 25
        Height = 14
        Caption = 'S'#233'rie'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 157
        Top = 23
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 7
        Top = 60
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 223
        Top = 60
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
      object Label9: TLabel
        Left = 287
        Top = 60
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
      object edtDocumento: TEditFocus
        Tag = 99
        Left = 6
        Top = 37
        Width = 79
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 0
        OnExit = edtDocumentoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspecie: TEditFocus
        Left = 88
        Top = 37
        Width = 38
        Height = 21
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 1
        Text = 'NF'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtSerie: TEditFocus
        Left = 129
        Top = 37
        Width = 25
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 157
        Top = 37
        Width = 29
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 3
        OnExit = edtCodEmpresaExit
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 189
        Top = 37
        Width = 160
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtForNot: TEditFocus
        Tag = 99
        Left = 7
        Top = 73
        Width = 46
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnExit = edtForNotExit
        OnKeyPress = edtForNotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesForNot: TEditFocus
        Left = 55
        Top = 73
        Width = 164
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaEntIni: TMaskEditFocus
        Left = 223
        Top = 73
        Width = 62
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 7
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaEntFin: TMaskEditFocus
        Left = 287
        Top = 73
        Width = 62
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 8
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object edtLocIni: TEditFocus
      Tag = 99
      Left = 7
      Top = 245
      Width = 359
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
      ParentFont = False
      TabOrder = 7
      OnKeyPress = edtLocIniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkLocFis: TCheckBox
      Left = 379
      Top = 131
      Width = 250
      Height = 17
      Caption = 'Imprimir localiza'#231#227'o f'#237'sica do Produto'
      TabOrder = 14
    end
    object edtLocFin: TEditFocus
      Tag = 99
      Left = 7
      Top = 285
      Width = 359
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
      ParentFont = False
      TabOrder = 8
      OnKeyPress = edtLocFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 463
    Width = 703
    ExplicitTop = 463
    ExplicitWidth = 703
    inherited pnlNomeForm: TPanel
      Left = 587
      Width = 116
      ExplicitLeft = 587
      ExplicitWidth = 116
    end
    inherited pnlInfo: TPanel
      Width = 587
      ExplicitWidth = 587
      inherited shpMultSel: TShape
        Left = 568
        ExplicitLeft = 568
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 808
    Top = 80
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 744
    Top = 80
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 776
    Top = 48
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 744
    Top = 48
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 904
    Top = 16
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 872
    Top = 16
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 840
    Top = 16
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 776
    Top = 16
  end
  inherited frxGen: TfrxUserDataSet
    Left = 808
    Top = 16
  end
  inherited frxDesigner: TfrxDesigner
    Left = 840
    Top = 48
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 872
    Top = 48
  end
  object svdExcel: TSaveDialog
    DefaultExt = '*.xls'
    FileName = 'D:\Documents and Settings\Programa'#231#227'o\Desktop\TESTEss.xls'
    Filter = 'Planilha Excel|*.xls'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 776
    Top = 80
  end
end
