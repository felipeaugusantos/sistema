inherited frmRelEstSemMov: TfrmRelEstSemMov
  Left = 453
  Top = 241
  Width = 492
  Height = 575
  Caption = 'Relat'#243'rio de Produtos Sem Movimenta'#231#227'o Estoque'
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitTop = -131
  ExplicitWidth = 492
  ExplicitHeight = 575
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 502
    Width = 486
    ExplicitTop = 502
    ExplicitWidth = 486
    inherited btnSair: TBitBtnLocked
      Left = 404
      ExplicitLeft = 404
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 12
      ExplicitLeft = 12
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 89
      Width = 80
      ExplicitLeft = 89
      ExplicitWidth = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 486
    Height = 492
    ExplicitWidth = 486
    ExplicitHeight = 492
    object Label5: TLabel [0]
      Left = 7
      Top = 2
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
      Left = 82
      Top = 2
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
    object Label12: TLabel [2]
      Left = 7
      Top = 37
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
    object Label9: TLabel [3]
      Left = 7
      Top = 72
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
    object Label10: TLabel [4]
      Left = 7
      Top = 107
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
    object Label11: TLabel [5]
      Left = 7
      Top = 142
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
    object lblEmpresa: TLabel [6]
      Left = 7
      Top = 282
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
    object Label1: TLabel [7]
      Left = 7
      Top = 247
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
    object Label2: TLabel [8]
      Left = 82
      Top = 247
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
    object Label3: TLabel [9]
      Left = 161
      Top = 264
      Width = 129
      Height = 14
      Caption = '(Cadastro de Produtos)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel [10]
      Left = 7
      Top = 177
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Compra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDepartamento: TLabel [11]
      Left = 7
      Top = 212
      Width = 122
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento do Produto'
    end
    inherited gpbDestino: TGroupBox
      Left = 172
      Top = 358
      Width = 177
      Height = 43
      TabOrder = 20
      ExplicitLeft = 172
      ExplicitTop = 358
      ExplicitWidth = 177
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 16
      Width = 73
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
      Left = 82
      Top = 16
      Width = 73
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
    object edtFornecedor: TEditFocus
      Left = 7
      Top = 51
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
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
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 86
      Width = 57
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
      TabOrder = 4
      Text = ''
      OnEnter = mskLinhaGrupoEnter
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtProdutos: TEditFocus
      Left = 7
      Top = 121
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
    object edtMarca: TEditFocus
      Left = 7
      Top = 156
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 8
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
    object edtDesFornecedor: TEditFocus
      Left = 66
      Top = 51
      Width = 410
      Height = 22
      TabStop = False
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
    object edtDesGrupo: TEditFocus
      Left = 66
      Top = 86
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesProduto: TEditFocus
      Left = 66
      Top = 121
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMarca: TEditFocus
      Left = 66
      Top = 156
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkSalZer: TCheckBox
      Left = 9
      Top = 405
      Width = 249
      Height = 17
      Caption = 'Entrar itens com saldo zerado ou negativos?'
      Checked = True
      State = cbChecked
      TabOrder = 22
    end
    object gpbItens: TGroupBox
      Left = 7
      Top = 358
      Width = 164
      Height = 43
      Caption = 'Itens:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 20
        Width = 128
        Height = 14
        Caption = '(A)tivos (I)nativos (T)odos'
        CorDestaque = clRed
      end
      object edtIteAti: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 296
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
      TabOrder = 16
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
      Left = 66
      Top = 296
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbOpcao: TGroupBox
      Left = 7
      Top = 318
      Width = 469
      Height = 40
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      object lbl1: TColorLabel
        Left = 28
        Top = 20
        Width = 166
        Height = 14
        Caption = '(G)rupo de Produtos (F)ornecedor'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'G'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkImpRef: TCheckBox
      Left = 9
      Top = 422
      Width = 118
      Height = 17
      Caption = 'Imprimir refer'#234'ncia?'
      TabOrder = 23
    end
    object chkAjusteEstoque: TCheckBox
      Left = 171
      Top = 422
      Width = 177
      Height = 17
      Caption = 'Considerar Ajustes de Estoque'
      Checked = True
      State = cbChecked
      TabOrder = 24
    end
    object chkTransfEstoque: TCheckBox
      Left = 9
      Top = 438
      Width = 273
      Height = 17
      Caption = 'Considerar Transfer'#234'ncia de Estoque em Empresa'
      Checked = True
      State = cbChecked
      TabOrder = 25
    end
    object mskCadIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 261
      Width = 72
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
      TabOrder = 14
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskCadFin: TMaskEditFocus
      Tag = 99
      Left = 82
      Top = 261
      Width = 73
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
      TabOrder = 15
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodGruCmp: TEditFocus
      Tag = 99
      Left = 7
      Top = 191
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnExit = edtCodGruCmpExit
      OnKeyPress = edtCodGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 66
      Top = 191
      Width = 410
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 7
      Top = 226
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 12
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
      Left = 66
      Top = 226
      Width = 410
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkCFOPVen: TCheckBox
      Left = 9
      Top = 455
      Width = 273
      Height = 17
      Caption = 'Considerar apenas CFOP de Venda'
      TabOrder = 26
    end
    object chkIteNMov: TCheckBox
      Left = 9
      Top = 473
      Width = 273
      Height = 17
      Caption = 'Listar itens nunca movimentados?'
      Checked = True
      State = cbChecked
      TabOrder = 27
    end
    object GroupBox1: TGroupBox
      Left = 349
      Top = 358
      Width = 127
      Height = 43
      Caption = 'Imprime Lista individual?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 20
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object edtImprimeLista: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  object pbProgresso: TProgressBar [3]
    Left = 0
    Top = 492
    Width = 486
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 530
    Width = 486
    TabOrder = 4
    ExplicitTop = 530
    ExplicitWidth = 486
    inherited pnlNomeForm: TPanel
      Left = 334
      Width = 152
      TabOrder = 1
      ExplicitLeft = 334
      ExplicitWidth = 152
    end
    inherited pnlInfo: TPanel
      Width = 334
      TabOrder = 0
      ExplicitWidth = 334
      inherited shpMultSel: TShape
        Left = 190
        ExplicitLeft = 190
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 264
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 296
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 264
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 328
    Top = 72
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 264
    Top = 72
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 232
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 232
    Top = 72
  end
  inherited frxGen: TfrxUserDataSet
    Left = 232
    Top = 40
  end
end
