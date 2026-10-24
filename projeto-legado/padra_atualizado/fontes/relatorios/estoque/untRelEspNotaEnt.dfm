inherited frmRelEspNotaEnt: TfrmRelEspNotaEnt
  Left = 411
  Top = 126
  Width = 598
  Height = 561
  Caption = 'Relat'#243'rio de Espelho da Nota de Entrada'
  ExplicitWidth = 598
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 490
    Width = 592
    ExplicitTop = 490
    ExplicitWidth = 592
    inherited FlwBotoes: TFlowPanel
      Width = 511
      ExplicitWidth = 511
    end
    inherited btnSair: TBitBtnLocked
      Left = 513
      ExplicitLeft = 513
    end
  end
  inherited pnlDados: TPanel
    Width = 592
    Height = 490
    ExplicitWidth = 592
    ExplicitHeight = 490
    object lbl1: TLabel [0]
      Left = 8
      Top = 8
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
    object lbl2: TLabel [1]
      Left = 104
      Top = 26
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
    object lbl3: TLabel [2]
      Left = 8
      Top = 46
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
    object lbl4: TLabel [3]
      Left = 104
      Top = 64
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
    object lbl5: TLabel [4]
      Left = 8
      Top = 84
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
    object lbl6: TLabel [5]
      Left = 105
      Top = 84
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel [6]
      Left = 150
      Top = 84
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel [7]
      Left = 8
      Top = 120
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
    object lblEmpresa: TLabel [8]
      Left = 8
      Top = 231
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
    object Label3: TLabel [9]
      Left = 8
      Top = 192
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
    object Label2: TLabel [10]
      Left = 8
      Top = 155
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
      Left = 425
      Top = 397
      TabOrder = 22
      ExplicitLeft = 425
      ExplicitTop = 397
      inherited ColorLabel1: TColorLabel
        Top = 19
        ExplicitTop = 19
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 88
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
      Left = 8
      Top = 60
      Width = 88
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
    object edtDocumento: TEditFocus
      Left = 8
      Top = 98
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Left = 105
      Top = 98
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 3
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
      Left = 150
      Top = 98
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
      Left = 8
      Top = 134
      Width = 64
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
      Left = 73
      Top = 134
      Width = 215
      Height = 22
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 245
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
      TabOrder = 8
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
      Top = 245
      Width = 250
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpb1: TGroupBox
      Left = 292
      Top = 196
      Width = 281
      Height = 45
      Caption = 'C'#225'lculo da Varia'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 20
        Width = 208
        Height = 14
        Caption = '(C)adastro de Produto  (P)edido de Compra'
        CorDestaque = clRed
      end
      object edtCalc: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        OnChange = edtCalcChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkNFTransf: TCheckBox
      Left = 292
      Top = 262
      Width = 278
      Height = 17
      Caption = 'Mostrar Notas provenientes de Transfer'#234'ncia'
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object rdgVariacao: TRadioGroup
      Left = 8
      Top = 397
      Width = 280
      Height = 83
      Caption = 'C'#225'lculo da varia'#231#227'o do pre'#231'o de compra'
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o de Compra'
        'Pre'#231'o de Compra mais Impostos'
        'Pr.Compra Ent. + Impostos X Pre'#231'o Compra Entrada')
      TabOrder = 11
      OnClick = rdgVariacaoClick
    end
    object gpbImpMarca: TGroupBox
      Left = 423
      Top = 334
      Width = 140
      Height = 52
      Caption = 'Imprimir Marca/Refer'#234'ncia'
      TabOrder = 21
      object ColorLabel3: TColorLabel
        Left = 30
        Top = 20
        Width = 102
        Height = 14
        Caption = '(M)arca (R)efer'#234'ncia'
        CorDestaque = clRed
      end
      object edtImpMarca: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'R'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object rdgOrdemProd: TRadioGroup
      Tag = 15
      Left = 292
      Top = 150
      Width = 281
      Height = 44
      Caption = 'Ordenar produtos'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Por Grava'#231#227'o'
        'Por Descri'#231#227'o')
      TabOrder = 15
    end
    object rdgOrdem: TRadioGroup
      Left = 292
      Top = 111
      Width = 281
      Height = 38
      Caption = 'Ordenado'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Por Data Entrada'
        'Por Fornecedor')
      TabOrder = 14
    end
    object rdgVisualizacao: TRadioGroup
      Left = 292
      Top = 8
      Width = 281
      Height = 52
      Caption = 'Visualiza'#231#227'o'
      Columns = 2
      Items.Strings = (
        'Localiza'#231#227'o Fisica'
        'Pedido de Compra'
        'C'#243'digo de F'#225'brica'
        'NCM')
      TabOrder = 12
      OnClick = rdgVisualizacaoClick
    end
    object chkVariacao: TCheckBox
      Left = 292
      Top = 280
      Width = 297
      Height = 26
      Caption = 'Exibir Varia'#231#227'o Positiva em Azul e Negativa em Vermelho'
      TabOrder = 19
      WordWrap = True
    end
    object chkQtdCmp: TCheckBox
      Left = 292
      Top = 244
      Width = 181
      Height = 17
      Caption = 'Mostrar Quantidade de Compra'
      TabOrder = 17
      OnClick = chkPreVenClick
    end
    object rdgExibirCfop: TRadioGroup
      Left = 292
      Top = 60
      Width = 281
      Height = 50
      Caption = 'Exibir '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Todas as CFOPs'
        'CFOP de Compra'
        'CFOP de Bonifica'#231#227'o')
      TabOrder = 13
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 277
      Width = 280
      Height = 46
      Caption = 'Pre'#231'o de Venda'
      TabOrder = 9
      object Label1: TLabel
        Left = 7
        Top = 45
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
        Visible = False
      end
      object lblTabPreco: TLabel
        Left = 181
        Top = 24
        Width = 51
        Height = 14
        Caption = 'Tab.Pre'#231'o:'
      end
      object chkPreVen: TCheckBox
        Left = 4
        Top = 24
        Width = 171
        Height = 15
        Caption = 'Mostrar Pre'#231'o de Venda/Custo'
        TabOrder = 0
        OnClick = chkPreVenClick
      end
      object cmbTabPre: TComboBoxFocus
        Tag = 99
        Left = 237
        Top = 21
        Width = 38
        Height = 22
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Sorted = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbComCus: TComboBoxFocus
        Tag = 99
        Left = 7
        Top = 59
        Width = 277
        Height = 22
        Style = csDropDownList
        Enabled = False
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object rdgValUni: TRadioGroup
      Left = 8
      Top = 334
      Width = 409
      Height = 52
      Caption = 'Valor unit'#225'rio da nota de entrada'
      ItemIndex = 0
      Items.Strings = (
        
          'Valor unit'#225'rio bruto, com desconto especial destacado no total d' +
          'o documento'
        
          'Valor unit'#225'rio l'#237'quido, com desconto especial distribu'#237'do nos pr' +
          'odutos')
      TabOrder = 10
    end
    object edtProdutos: TEditFocus
      Left = 8
      Top = 206
      Width = 64
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
      TabOrder = 7
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
      Left = 73
      Top = 206
      Width = 215
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 25
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
      Left = 8
      Top = 170
      Width = 64
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
      TabOrder = 6
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
      Left = 73
      Top = 170
      Width = 215
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkObsCom: TCheckBox
      Left = 292
      Top = 306
      Width = 292
      Height = 26
      Caption = 'Exibir Observa'#231#227'o do Pedido de Compra'
      TabOrder = 20
      WordWrap = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 516
    Width = 592
    ExplicitTop = 516
    ExplicitWidth = 592
    inherited pnlNomeForm: TPanel
      Left = 439
      Width = 153
      ExplicitLeft = 439
      ExplicitWidth = 153
    end
    inherited pnlInfo: TPanel
      Width = 439
      ExplicitWidth = 439
      inherited shpMultSel: TShape
        Left = 425
        ExplicitLeft = 425
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 72
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 232
    Top = 72
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 232
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 200
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 168
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 264
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 232
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 168
  end
  inherited frxGen: TfrxUserDataSet
    Left = 200
  end
  inherited frxDesigner: TfrxDesigner
    Left = 168
    Top = 72
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 200
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 104
  end
end
