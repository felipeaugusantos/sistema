inherited frmRelEstListaAjuste: TfrmRelEstListaAjuste
  Left = 255
  Top = 146
  Width = 493
  Height = 580
  Caption = 'Relat'#243'rio de Ajustes de Estoques'
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 493
  ExplicitHeight = 580
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 508
    Width = 487
    ExplicitTop = 508
    ExplicitWidth = 487
    inherited btnSair: TBitBtnLocked
      Left = 401
      ExplicitLeft = 401
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 8
      ExplicitLeft = 8
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 86
      ExplicitLeft = 86
    end
  end
  inherited pnlDados: TPanel
    Width = 487
    Height = 502
    ExplicitWidth = 487
    ExplicitHeight = 502
    object Label9: TLabel [0]
      Left = 8
      Top = 60
      Width = 65
      Height = 14
      Caption = 'Linha / Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [1]
      Left = 8
      Top = 98
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
    object Label10: TLabel [2]
      Left = 8
      Top = 136
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
    object Label11: TLabel [3]
      Left = 8
      Top = 174
      Width = 30
      Height = 14
      Caption = 'Marca'
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
      Top = 248
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
    object Label7: TLabel [5]
      Left = 388
      Top = 248
      Width = 85
      Height = 14
      Caption = 'N'#250'mero do Ajuste'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDescricao: TLabel [6]
      Left = 8
      Top = 286
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
    object Label5: TLabel [7]
      Left = 268
      Top = 286
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
    object Label1: TLabel [8]
      Left = 8
      Top = 324
      Width = 82
      Height = 14
      Caption = 'Refer'#234'ncia Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [9]
      Left = 224
      Top = 324
      Width = 78
      Height = 14
      Caption = 'Refer'#234'ncia Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [10]
      Left = 440
      Top = 324
      Width = 21
      Height = 14
      Caption = 'Unid'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCodDig: TLabel [11]
      Left = 8
      Top = 211
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador'
    end
    inherited gpbDestino: TGroupBox
      Left = 252
      Top = 434
      Width = 226
      Height = 44
      TabOrder = 16
      ExplicitLeft = 252
      ExplicitTop = 434
      ExplicitWidth = 226
      ExplicitHeight = 44
      inherited ColorLabel1: TColorLabel
        Left = 29
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitWidth = 138
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 469
      Height = 50
      Caption = 'Per'#237'odo de Emiss'#227'o'
      TabOrder = 0
      object Label6: TLabel
        Left = 95
        Top = 23
        Width = 6
        Height = 14
        Caption = #224
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 9
        Top = 19
        Width = 76
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 110
        Top = 19
        Width = 78
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
    end
    object mskLinhaGrupo: TMaskEditFocus
      Left = 8
      Top = 76
      Width = 55
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 1
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 66
      Top = 76
      Width = 412
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtProdutos: TEditFocus
      Left = 8
      Top = 114
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
      Top = 114
      Width = 412
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Left = 8
      Top = 152
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnExit = edtFornecedorExit
      OnKeyPress = edtFornecedorKeyPress
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
      Top = 152
      Width = 412
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
    object edtMarca: TEditFocus
      Left = 8
      Top = 190
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 4
      OnExit = edtMarcaExit
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 66
      Top = 190
      Width = 412
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 264
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 6
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
    object edtDesEmpresa: TEditFocus
      Left = 38
      Top = 264
      Width = 348
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 388
      Top = 264
      Width = 90
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
      TabOrder = 7
      OnExit = edtNumDocExit
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Left = 8
      Top = 302
      Width = 258
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Left = 268
      Top = 302
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 8
      Top = 340
      Width = 214
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefFin: TEditFocus
      Left = 224
      Top = 340
      Width = 214
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Tag = 99
      Left = 440
      Top = 340
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 12
      OnKeyPress = edtUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOrdem: TRadioGroup
      Left = 215
      Top = 367
      Width = 263
      Height = 61
      Caption = 'Ordenar por'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'C'#243'd. Produto'
        'Nro. Ajuste'
        'Emiss'#227'o '
        'Descri'#231#227'o'
        'Linha/Grupo'
        'Fornecedor'
        'Empresa')
      TabOrder = 14
      OnClick = rdgOrdemClick
    end
    object chkImpObs: TCheckBox
      Left = 8
      Top = 481
      Width = 137
      Height = 17
      Caption = 'Imprimir Observa'#231#245'es'
      TabOrder = 17
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 7
      Top = 225
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 5
      OnExit = edtCodDigExit
      OnKeyPress = edtCodDigKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 66
      Top = 225
      Width = 412
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOriAju: TRadioGroup
      Left = 8
      Top = 367
      Width = 201
      Height = 61
      Caption = 'Origem do Ajuste'
      ItemIndex = 2
      Items.Strings = (
        'Ajuste pela Movimenta'#231#227'o de Itens'
        'Ajuste por Balan'#231'o de Estoque'
        'Todos')
      TabOrder = 13
      OnClick = rdgOrdemClick
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 434
      Width = 238
      Height = 45
      Caption = 'Exibir'
      TabOrder = 15
      object cmbPreExi: TComboBox
        Left = 5
        Top = 16
        Width = 224
        Height = 22
        Style = csDropDownList
        ItemIndex = 4
        TabOrder = 0
        Text = 'PRE'#199'O M'#201'DIO'
        OnKeyPress = cmbPreExiKeyPress
        Items.Strings = (
          'PRE'#199'O DE VENDA'
          'PRE'#199'O DE CUSTO'
          'PRE'#199'O DE ULT.COMPRA'
          'PRE'#199'O DE ULT.COMPRA + IMP.ENTRADA'
          'PRE'#199'O M'#201'DIO')
      end
    end
  end
  object pgbProgresso: TProgressBar [3]
    Left = 0
    Top = 502
    Width = 487
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 536
    Width = 487
    ExplicitTop = 536
    ExplicitWidth = 487
    inherited pnlNomeForm: TPanel
      Left = 316
      ExplicitLeft = 316
    end
    inherited pnlInfo: TPanel
      Width = 316
      ExplicitWidth = 316
      inherited shpMultSel: TShape
        Left = 294
        ExplicitLeft = 294
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 448
    Top = 40
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 416
    Top = 72
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 320
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 320
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 352
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 384
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 448
  end
  inherited frxGen: TfrxUserDataSet
    Left = 416
  end
  inherited frxDesigner: TfrxDesigner
    Left = 352
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 448
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 72
  end
end
