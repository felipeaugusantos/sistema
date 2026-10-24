inherited frmRelEstEvoCompras: TfrmRelEstEvoCompras
  Left = 485
  Top = 230
  Width = 456
  Height = 553
  Caption = 'Relat'#243'rio de Evolu'#231#227'o de Compras'
  OnDestroy = FormDestroy
  ExplicitWidth = 456
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 481
    Width = 450
    ExplicitTop = 481
    ExplicitWidth = 450
    inherited FlwBotoes: TFlowPanel
      Width = 369
      ExplicitTop = 2
      ExplicitWidth = 369
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 371
      ExplicitLeft = 371
    end
  end
  inherited pnlDados: TPanel
    Width = 450
    Height = 471
    ExplicitWidth = 450
    ExplicitHeight = 471
    object Label1: TLabel [0]
      Left = 8
      Top = 8
      Width = 48
      Height = 14
      Caption = 'M'#234's Base'
    end
    object Label9: TLabel [1]
      Left = 8
      Top = 86
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
    object Label11: TLabel [2]
      Left = 8
      Top = 124
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
    object Label8: TLabel [3]
      Left = 8
      Top = 162
      Width = 39
      Height = 14
      Caption = 'Unidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [4]
      Left = 8
      Top = 48
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
    object Label3: TLabel [5]
      Left = 8
      Top = 315
      Width = 105
      Height = 14
      Caption = 'Quantidade de Meses'
    end
    object ColorLabel2: TColorLabel [6]
      Left = 36
      Top = 332
      Width = 61
      Height = 14
      Caption = '(01) at'#233' (12)'
      CorDestaque = clRed
    end
    object Label5: TLabel [7]
      Left = 348
      Top = 48
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
    object lblEmpresa: TLabel [8]
      Left = 8
      Top = 237
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
    object lbl1: TLabel [9]
      Left = 8
      Top = 275
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
    object Label12: TLabel [10]
      Left = 7
      Top = 199
      Width = 85
      Height = 14
      Caption = 'Grupo de Compra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 410
      Width = 199
      Height = 48
      TabOrder = 13
      ExplicitTop = 410
      ExplicitWidth = 199
      ExplicitHeight = 48
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 152
        AutoSize = False
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 19
        ExplicitWidth = 152
      end
    end
    object mskMesBas: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 24
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 100
      Width = 55
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
      TabOrder = 3
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
      Left = 62
      Top = 100
      Width = 282
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
    object edtCodProduto: TEditFocus
      Tag = 99
      Left = 8
      Top = 138
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
      TabOrder = 4
      OnExit = edtCodProdutoExit
      OnKeyPress = edtCodProdutoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesProduto: TEditFocus
      Left = 65
      Top = 138
      Width = 279
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
    object edtCodUnidade: TEditFocus
      Tag = 99
      Left = 8
      Top = 176
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 5
      OnExit = edtCodUnidadeExit
      OnKeyPress = edtCodUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesUnidade: TEditFocus
      Left = 65
      Top = 176
      Width = 279
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
    object edtFornecedor: TEditFocus
      Left = 8
      Top = 62
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
      Left = 65
      Top = 62
      Width = 279
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
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
      Left = 209
      Top = 340
      Width = 137
      Height = 118
      Caption = 'Opc'#227'o de Quebra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      object ColorLabel3: TColorLabel
        Left = 31
        Top = 12
        Width = 87
        Height = 14
        AutoSize = False
        Caption = '(1) Forn. / Produto'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 31
        Top = 26
        Width = 85
        Height = 14
        AutoSize = False
        Caption = '(2) Grupo '
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 31
        Top = 41
        Width = 85
        Height = 14
        AutoSize = False
        Caption = '(3) Produto '
        CorDestaque = clRed
      end
      object ColorLabel6: TColorLabel
        Left = 31
        Top = 55
        Width = 85
        Height = 14
        AutoSize = False
        Caption = '(4) Fornecedor '
        CorDestaque = clRed
      end
      object ColorLabel7: TColorLabel
        Left = 31
        Top = 70
        Width = 85
        Height = 14
        AutoSize = False
        Caption = '(5) Marca '
        CorDestaque = clRed
      end
      object ColorLabel8: TColorLabel
        Left = 31
        Top = 85
        Width = 85
        Height = 14
        AutoSize = False
        Caption = '(6) Linha/Grupo '
        CorDestaque = clRed
      end
      object ColorLabel9: TColorLabel
        Left = 31
        Top = 101
        Width = 102
        Height = 14
        AutoSize = False
        Caption = '(7) Grupo de Compra '
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 40
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
        TipoTexto = ttNumerico
      end
    end
    object gpbOpcao2: TGroupBox
      Left = 8
      Top = 358
      Width = 198
      Height = 48
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      object lblOpcao2: TColorLabel
        Left = 28
        Top = 19
        Width = 167
        Height = 14
        AutoSize = False
        Caption = '(L)itros/Kilos (Q)uantidade (V)alor'
        CorDestaque = clRed
      end
      object edtOpcao2: TEditFocus
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
        Text = 'V'
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
    object rdgData: TRadioGroup
      Left = 75
      Top = 11
      Width = 207
      Height = 43
      Caption = 'Op'#231#227'o de Data'
      Columns = 2
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Dta. Entrada'
        'Dta. Documento')
      ParentCtl3D = False
      TabOrder = 1
    end
    object edtQtdMes: TEditFocus
      Tag = 99
      Left = 8
      Top = 328
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 9
      Text = '07'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttNumerico
    end
    object chkTransf: TCheckBox
      Left = 179
      Top = 320
      Width = 168
      Height = 17
      Caption = 'Incluir transfer'#234'ncia das Lojas'
      TabOrder = 10
    end
    object lstClaFis: TMemo
      Left = 349
      Top = 62
      Width = 91
      Height = 403
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
      TabOrder = 18
      WantReturns = False
      WordWrap = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 9
      Top = 251
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
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
      Left = 39
      Top = 251
      Width = 305
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Left = 7
      Top = 289
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
    object edtDesMarca: TEditFocus
      Left = 64
      Top = 289
      Width = 280
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
    object edtGruCmp: TEditFocus
      Left = 8
      Top = 213
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
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 65
      Top = 213
      Width = 279
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
  end
  object pgbStatus: TProgressBar [3]
    Left = 0
    Top = 471
    Width = 450
    Height = 10
    Align = alBottom
    Smooth = True
    Step = 0
    TabOrder = 3
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 509
    Width = 450
    TabOrder = 4
    ExplicitTop = 509
    ExplicitWidth = 450
    inherited pnlNomeForm: TPanel
      Left = 279
      ExplicitLeft = 279
    end
    inherited pnlInfo: TPanel
      Width = 279
      ExplicitWidth = 279
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 178
    Top = 252
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 146
    Top = 188
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 210
    Top = 252
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 178
    Top = 220
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 146
    Top = 252
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 274
    Top = 188
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 146
    Top = 220
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 242
    Top = 188
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 178
    Top = 188
  end
  inherited frxGen: TfrxUserDataSet
    Left = 242
    Top = 220
  end
  inherited frxDesigner: TfrxDesigner
    Left = 210
    Top = 188
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 274
    Top = 220
  end
  object svdExcel: TSaveDialog
    Filter = 'Arquivos Excel|*.xls'
    Left = 242
    Top = 252
  end
end
