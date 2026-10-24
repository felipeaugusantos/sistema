inherited frmRelCatalogoLinhaGrupo: TfrmRelCatalogoLinhaGrupo
  Width = 536
  Height = 644
  Caption = 'Cat'#225'logo de Produtos Linha / Grupo com Fotos'
  ExplicitWidth = 536
  ExplicitHeight = 644
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 573
    Width = 530
    ExplicitTop = 531
    ExplicitWidth = 530
    inherited FlwBotoes: TFlowPanel
      Width = 449
      ExplicitWidth = 449
      inherited btnImprimir: TBitBtnLocked
        Anchors = [akLeft, akTop, akBottom]
      end
      inherited btnConfigurar: TBitBtnLocked
        Anchors = [akLeft, akTop, akBottom]
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 451
      ExplicitLeft = 451
    end
  end
  inherited pnlStatus: TPanel
    Top = 599
    Width = 530
    ExplicitTop = 557
    ExplicitWidth = 530
    inherited pnlNomeForm: TPanel
      Left = 359
      ExplicitLeft = 359
    end
    inherited pnlInfo: TPanel
      Width = 359
      ExplicitWidth = 359
    end
  end
  inherited pnlDados: TPanel
    Width = 530
    Height = 573
    ExplicitWidth = 530
    ExplicitHeight = 531
    object Label9: TLabel [0]
      Left = 12
      Top = 89
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
    object Label10: TLabel [1]
      Left = 12
      Top = 162
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
    object Label11: TLabel [2]
      Left = 12
      Top = 197
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
    object lblDescricao: TLabel [3]
      Left = 12
      Top = 273
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
    object Label1: TLabel [4]
      Left = 243
      Top = 273
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
    object Label2: TLabel [5]
      Left = 499
      Top = 273
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
    object Label3: TLabel [6]
      Left = 12
      Top = 126
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
    object Label4: TLabel [7]
      Left = 12
      Top = 51
      Width = 67
      Height = 14
      Caption = 'Departamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [8]
      Left = 12
      Top = 13
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
    object Label6: TLabel [9]
      Left = 12
      Top = 233
      Width = 48
      Height = 14
      Caption = 'Promo'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 412
      Top = 511
      Width = 108
      Height = 49
      TabOrder = 33
      ExplicitLeft = 412
      ExplicitTop = 511
      ExplicitWidth = 108
      ExplicitHeight = 49
      inherited ColorLabel1: TColorLabel
        Left = 33
        Top = 16
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitLeft = 33
        ExplicitTop = 16
        ExplicitWidth = 36
      end
      object ColorLabel2: TColorLabel [1]
        Left = 36
        Top = 32
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 11
        Top = 21
        ExplicitLeft = 11
        ExplicitTop = 21
      end
    end
    object mskLinhaGrupo: TMaskEditFocus
      Left = 12
      Top = 103
      Width = 57
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
      TabOrder = 4
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtFornecedor: TEditFocus
      Left = 12
      Top = 176
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
      TabOrder = 8
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
    object edtMarca: TEditFocus
      Left = 12
      Top = 211
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
      TabOrder = 10
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
    object edtDescri: TEditFocus
      Left = 12
      Top = 287
      Width = 225
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
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 243
      Top = 287
      Width = 232
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
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 478
      Top = 287
      Width = 42
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
      TabOrder = 17
      OnExit = edtUnidadeExit
      OnKeyPress = edtUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesGrupo: TEditFocus
      Left = 70
      Top = 103
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 70
      Top = 176
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMarca: TEditFocus
      Left = 70
      Top = 211
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtProdutos: TEditFocus
      Tag = 99
      Left = 12
      Top = 139
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
    object edtDesProduto: TEditFocus
      Left = 70
      Top = 139
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgExibirItens: TRadioGroup
      Left = 12
      Top = 313
      Width = 77
      Height = 62
      Caption = 'Status'
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Ativos'
        'Inativos')
      TabOrder = 18
    end
    object edtCodDep: TEditFocus
      Left = 12
      Top = 65
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
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
      Left = 70
      Top = 65
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbCabecalho: TGroupBox
      Left = 207
      Top = 377
      Width = 108
      Height = 68
      Caption = 'Cores Cabe'#231'alho'
      TabOrder = 26
      object shpFundoCabecalho: TShape
        Left = 9
        Top = 19
        Width = 18
        Height = 18
        Brush.Color = 11888904
        Pen.Color = clSilver
      end
      object shpFonteCabecalho: TShape
        Left = 9
        Top = 40
        Width = 18
        Height = 18
        Pen.Color = clSilver
      end
      object btnFundoCabecalho: TBitBtnLocked
        Left = 28
        Top = 18
        Width = 70
        Height = 20
        Caption = 'Fundo'
        TabOrder = 0
        OnClick = btnFundoCabecalhoClick
      end
      object btnFonteCabecalho: TBitBtnLocked
        Left = 28
        Top = 39
        Width = 70
        Height = 20
        Caption = 'Fonte'
        TabOrder = 1
        OnClick = btnFonteCabecalhoClick
      end
    end
    object gpbRodape: TGroupBox
      Left = 412
      Top = 377
      Width = 108
      Height = 68
      Caption = 'Cores Rodap'#233
      TabOrder = 31
      object shpFundoRodape: TShape
        Left = 9
        Top = 19
        Width = 18
        Height = 18
        Brush.Color = 2169889
        Pen.Color = clSilver
      end
      object shpFonteRodape: TShape
        Left = 9
        Top = 40
        Width = 18
        Height = 18
        Pen.Color = clSilver
      end
      object btnFundoRodape: TBitBtnLocked
        Left = 28
        Top = 18
        Width = 70
        Height = 20
        Caption = 'Fundo'
        TabOrder = 0
        OnClick = btnFundoRodapeClick
      end
      object btnFonteRodape: TBitBtnLocked
        Left = 28
        Top = 39
        Width = 70
        Height = 20
        Caption = 'Fonte'
        TabOrder = 1
        OnClick = btnFonteRodapeClick
      end
    end
    object gpbColunas: TGroupBox
      Left = 345
      Top = 313
      Width = 61
      Height = 62
      Caption = 'Colunas'
      TabOrder = 25
      object cbxColunas: TcxComboBox
        Left = 10
        Top = 20
        Properties.Alignment.Horz = taCenter
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5')
        TabOrder = 0
        Text = '2'
        Width = 42
      end
    end
    object rdgImpLis: TRadioGroup
      Left = 95
      Top = 313
      Width = 106
      Height = 62
      Caption = 'Imprime Lista'
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 19
    end
    object gpbPrecos: TGroupBox
      Left = 12
      Top = 459
      Width = 189
      Height = 60
      Caption = 'Op'#231#245'es de Pre'#231'os'
      TabOrder = 22
      object chkExiPrecos: TCheckBox
        Left = 10
        Top = 19
        Width = 83
        Height = 17
        Caption = 'Exibir Pre'#231'os '
        TabOrder = 0
        OnClick = chkExiPrecosClick
      end
      object chkConsiderarPromocao: TCheckBox
        Left = 10
        Top = 38
        Width = 156
        Height = 17
        Hint = 
          #201' considerado o Valor de Tabela da promo'#231#227'o ativa para o item. S' +
          'e o Produto n'#227'o possuir promo'#231#227'o cadastrada, ser'#225' exibido o valo' +
          'r referente a tabela selecionada. '
        Caption = 'Considerar Promo'#231#245'es'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = chkConsiderarPromocaoClick
      end
      object cbxTabPre: TComboBoxFocus
        Left = 93
        Top = 14
        Width = 76
        Height = 22
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object rdgSaldoProduto: TRadioGroup
      Left = 12
      Top = 377
      Width = 189
      Height = 46
      Caption = 'Saldo do Produto'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Positivo'
        'Negativo'
        'Zerado')
      TabOrder = 20
    end
    object rdgDescricao: TRadioGroup
      Left = 412
      Top = 314
      Width = 108
      Height = 61
      Caption = 'Descri'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Completa'
        'Simplificada')
      TabOrder = 30
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 12
      Top = 27
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
      TabOrder = 0
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
      Left = 70
      Top = 27
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object gpbCamposAdicionais: TGroupBox
      Left = 12
      Top = 521
      Width = 189
      Height = 39
      Caption = 'Campos Adicionais'
      TabOrder = 23
      object chkExbUni: TCheckBox
        Left = 10
        Top = 16
        Width = 77
        Height = 17
        Caption = 'Exibir Unid.'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkExbEmb: TCheckBox
        Left = 100
        Top = 16
        Width = 75
        Height = 17
        Caption = 'Exibir Emb.'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object gpbBuscarAgregados: TGroupBox
      Left = 412
      Top = 454
      Width = 108
      Height = 54
      TabOrder = 32
      object chkAgregados: TCheckBox
        Left = 7
        Top = 18
        Width = 118
        Height = 17
        Caption = 'Buscar agreg.'
        TabOrder = 0
      end
    end
    object rdgOrientacao: TRadioGroup
      Left = 207
      Top = 445
      Width = 108
      Height = 63
      Caption = 'Orienta'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Paisagem'
        'Retrato')
      TabOrder = 27
    end
    object rdgExibir: TRadioGroup
      Left = 321
      Top = 377
      Width = 85
      Height = 131
      Caption = 'Exibir'
      ItemIndex = 5
      Items.Strings = (
        'Aplica'#231#227'o'
        'Saldos'
        'Ambos'
        'Marca'
        'Refer'#234'ncia'
        'Nenhum')
      TabOrder = 28
    end
    object rdgOrdemDep: TRadioGroup
      Left = 207
      Top = 511
      Width = 199
      Height = 49
      Caption = 'Ordenar por Departamento'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 29
    end
    object rdgImagem: TRadioGroup
      Left = 207
      Top = 313
      Width = 132
      Height = 62
      Caption = 'Imagem'
      ItemIndex = 2
      Items.Strings = (
        'Com imagem'
        'Sem imagem'
        'Todos')
      TabOrder = 24
    end
    object rdgAtivoCompras: TRadioGroup
      Left = 12
      Top = 424
      Width = 189
      Height = 34
      Caption = 'Ativo para Compras'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 21
    end
    object edtPromoc: TEditFocus
      Left = 12
      Top = 247
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 12
      OnExit = edtPromocExit
      OnKeyPress = edtPromocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesPromoc: TEditFocus
      Left = 70
      Top = 247
      Width = 263
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
    object rdgPromocao: TRadioGroup
      Left = 339
      Top = 237
      Width = 181
      Height = 32
      Caption = 'Somente itens em promo'#231#227'o'
      Columns = 2
      Enabled = False
      ItemIndex = 1
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 14
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 104
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 96
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 72
    Top = 16
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 280
    Top = 16
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 248
    Top = 16
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 216
    Top = 16
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 184
    Top = 16
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 152
    Top = 16
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 96
    Top = 80
  end
  inherited frxGen: TfrxUserDataSet
    Fields.Strings = (
      'EMP_NOMEMP'
      'EMP_FONE01'
      'EMP_EMAIL'
      'REL_NOMREL')
    Left = 168
    Top = 80
  end
  inherited frxDesigner: TfrxDesigner
    Left = 344
    Top = 16
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 376
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 48
  end
  object frxRelJato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43130.492521354200000000
    ReportOptions.LastChange = 43301.480279097220000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'procedure mmZebraOnBeforePrint(Sender: TfrxComponent);'
      'begin  '
      'end;'
      ''
      'procedure picLinGruOnAfterData(Sender: TfrxComponent);'
      'var'
      
        '  dblLeft: Double;                                              ' +
        '          '
      '  dblWidth: Double;'
      '  dblHeight: Double;                                           '
      'begin'
      
        '  //carrega a imagem do banco                                   ' +
        '                         '
      '  pCarregaImagemLinhaGrupo(<frxRelatorio."CODGRU">);'
      ''
      
        '  dblLeft := fRetornaLeftImagem;                                ' +
        '          '
      '  dblWidth := fRetornaWidthImagem;'
      
        '  dblHeight := (dblWidth * picLinGru.Picture.Height) / picLinGru' +
        '.Picture.Width;'
      ''
      '  picLinGru.Left := dblLeft;                      '
      '  picLinGru.Width := dblWidth;'
      '  picLinGru.Height := dblHeight;          '
      'end;'
      ''
      'procedure shpGapLinGruOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                            '
      'end;'
      ''
      'procedure shpGapProdutosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    '
      'end;'
      ''
      'procedure gphLinGruOnAfterCalcHeight(Sender: TfrxComponent);'
      'begin'
      ''
      
        ' //se ultrapassou o tamanho original, adiciona o tamanho da linh' +
        'a de t'#237'tulo                                                     ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                    '
      ' if gphLinGru.Height > strtofloat('#39'2,21'#39') then'
      
        '   gphLinGru.Height :=  gphLinGru.Height + mmCodigo.Height + str' +
        'tofloat('#39'1'#39');'
      ''
      
        ' //posiciona a linha de t'#237'tulo manualmente, pois estava tendo pr' +
        'oblema com o posicionamento autom'#225'tico e autosize da imagem     ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                                                ' +
        '                                                        '
      ' mmCodigo.Top    := gphLinGru.Height - mmCodigo.Height;'
      ' mmDescricao.Top := mmCodigo.Top;'
      ' mmUnidade.Top := mmCodigo.Top;'
      ' mmEmbalagem.Top := mmCodigo.Top;'
      ' mmPreco.Top := mmCodigo.Top;'
      ' mmAplica.Top := mmCodigo.Top;'
      ' mmSaldos.Top := mmCodigo.Top;     '
      '   '
      '            '
      '            '
      'end;'
      ''
      'procedure msdProdutosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  //shpGapLinGru.Visible := (Engine.CurX > 0);  '
      'end;'
      ''
      'procedure gphLinGruOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '// shpMsdProdutos.Visible := (Engine.CurX > 0);'
      'end;'
      ''
      'procedure mmCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '         '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxRelJatoUserFunction
    Left = 328
    Top = 88
    Datasets = <
      item
        DataSet = frxDepartamento
        DataSetName = 'frxDepartamento'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Columns = 2
      ColumnWidth = 143.500000000000000000
      ColumnPositions.Strings = (
        '0'
        '143,5')
      OnAfterPrint = 'Page1OnAfterPrint'
      OnBeforePrint = 'Page1OnBeforePrint'
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 37.795275590551180000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object mmDepartamento: TfrxMemoView
          Align = baRight
          Left = 702.992726460000000000
          Width = 381.732383540000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DESDEP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmEmpresa: TfrxMemoView
          Align = baWidth
          Width = 702.992726460000000000
          Height = 37.795275590000000000
          StretchMode = smActualHeight
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236220472440940000
        Top = 306.141930000000000000
        Width = 1084.725110000000000000
        object mmFone01: TfrxMemoView
          Align = baLeft
          Width = 361.883611210000000000
          Height = 30.236220470000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxGen."EMP_FONE01"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmEmail: TfrxMemoView
          Align = baWidth
          Left = 361.883611210000000000
          Width = 722.841498790000000000
          Height = 30.236220470000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGen."EMP_EMAIL"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object msdProdutos: TfrxMasterData
        FillType = ftBrush
        Height = 15.496062990000000000
        Top = 230.551330000000000000
        Width = 542.362555000000000000
        OnBeforePrint = 'msdProdutosOnBeforePrint'
        ColumnWidth = 453.543307086614000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 3.779527559055120000
          Top = 0.220470000000000000
          Width = 41.574634720000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mnoDescricao: TfrxMemoView
          Align = baWidth
          Left = 45.354162279055120000
          Top = 0.220470000000000000
          Width = 413.858781540944900000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object mnoEmbalagem: TfrxMemoView
          Align = baRight
          Left = 497.008219410000000000
          Width = 45.354335590000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."EMBALA"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mnoUnidade: TfrxMemoView
          Align = baRight
          Left = 459.212943820000000000
          Width = 37.795275590000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object shpMsdProdutos: TfrxShapeView
          Align = baLeft
          Width = 3.779527559055120000
          Height = 15.496062990000000000
          Frame.Color = clNone
        end
        object mnoPreco: TfrxMemoView
          Align = baRight
          Left = 402.520018230000000000
          Width = 56.692925590000000000
          Height = 15.118110240000000000
          Visible = False
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mnoSaldos: TfrxMemoView
          Align = baRight
          Left = 343.937230000000000000
          Width = 56.692925590000000000
          Height = 15.118110240000000000
          Visible = False
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[fRetornaSaldoDisponivel(<frxRelatorio."CODITE">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mnoAplica: TfrxMemoView
          Align = baRight
          Left = 249.448980000000000000
          Width = 94.488225590000000000
          Height = 15.118110240000000000
          Visible = False
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 13948116
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."APLICA"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object gphLinGru: TfrxGroupHeader
        FillType = ftBrush
        Height = 66.897645120000000000
        Top = 139.842610000000000000
        Width = 542.362555000000000000
        OnAfterCalcHeight = 'gphLinGruOnAfterCalcHeight'
        OnBeforePrint = 'gphLinGruOnBeforePrint'
        Condition = 'frxRelatorio."DESGRU"'
        Stretched = True
        object Memo10: TfrxMemoView
          Align = baWidth
          Left = 3.779527560000000000
          Top = 7.338590000000012000
          Width = 538.583027440000000000
          Height = 23.102350000000000000
          StretchMode = smActualHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxRelatorio."DESGRU"]')
          ParentFont = False
        end
        object picLinGru: TfrxPictureView
          Left = 120.944957560000000000
          Top = 32.795300000000000000
          Width = 285.354517440000000000
          Height = 7.559055120000000000
          OnAfterData = 'picLinGruOnAfterData'
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object mmCodigo: TfrxMemoView
          Align = baLeft
          Left = 3.779527560000000000
          Top = 46.968523460000000000
          Width = 41.574634720000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'mmCodigoOnBeforePrint'
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'COD.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmDescricao: TfrxMemoView
          Align = baWidth
          Left = 45.354162280000000000
          Top = 46.968523460000000000
          Width = 413.858781540000000000
          Height = 15.118110240000000000
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmUnidade: TfrxMemoView
          Align = baRight
          Left = 459.212943820000000000
          Top = 46.968523460000000000
          Width = 37.795275590000000000
          Height = 15.118110240000000000
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'UN.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmEmbalagem: TfrxMemoView
          Align = baRight
          Left = 497.008219410000000000
          Top = 46.968523460000000000
          Width = 45.354335590000000000
          Height = 15.118110240000000000
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'EMB.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmPreco: TfrxMemoView
          Align = baRight
          Left = 402.520018230000000000
          Top = 46.866141732283460000
          Width = 56.692925590000000000
          Height = 15.118110240000000000
          Visible = False
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'PRE'#199'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object shpGapLinGru: TfrxShapeView
          Align = baLeft
          Width = 3.779527560000000000
          Height = 63.118110240000000000
          Frame.Color = clNone
        end
        object mmSaldos: TfrxMemoView
          Align = baRight
          Left = 343.937230000000000000
          Top = 46.866141730000000000
          Width = 56.692925590000000000
          Height = 15.118110240000000000
          Visible = False
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmAplica: TfrxMemoView
          Align = baRight
          Left = 249.448980000000000000
          Top = 46.866141730000000000
          Width = 94.488225590000000000
          Height = 15.118110240000000000
          Visible = False
          Clipped = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'APLICA'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object gphDepartamento: TfrxGroupHeader
        FillType = ftBrush
        Top = 117.165430000000000000
        Width = 542.362555000000000000
        Condition = 'frxRelatorio."DESDEP"'
        StartNewPage = True
      end
    end
  end
  object frxProduto: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxProduto'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 88
    Top = 136
  end
  object dtsDepartamento: TDataSource
    Left = 312
    Top = 152
  end
  object frxDepartamento: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxDepartamento'
    CloseDataSource = False
    DataSource = dtsDepartamento
    BCDToCurrency = False
    Left = 192
    Top = 136
  end
  object cldPrincipal: TColorDialog
    Left = 272
    Top = 104
  end
end
