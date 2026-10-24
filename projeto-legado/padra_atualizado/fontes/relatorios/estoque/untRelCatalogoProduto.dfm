inherited frmRelCatalogoProduto: TfrmRelCatalogoProduto
  Width = 536
  Height = 731
  Caption = 'Cat'#225'logo de Produtos com Fotos'
  ExplicitWidth = 536
  ExplicitHeight = 688
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 617
    Width = 530
    ExplicitTop = 598
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
    Top = 643
    Width = 530
    ExplicitTop = 624
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
    Height = 617
    ExplicitTop = 8
    ExplicitWidth = 530
    ExplicitHeight = 617
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
      Left = 170
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
      Left = 336
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
    object Label5: TLabel [9]
      Left = 12
      Top = 273
      Width = 138
      Height = 14
      Caption = 'Data Cadastro (inicial e final)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [10]
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
    object Label7: TLabel [11]
      Left = 12
      Top = 313
      Width = 68
      Height = 14
      Caption = 'Marca Ve'#237'culo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [12]
      Left = 269
      Top = 313
      Width = 72
      Height = 14
      Caption = 'Modelo Ve'#237'culo'
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
      Top = 537
      Width = 108
      Height = 66
      TabOrder = 38
      ExplicitLeft = 412
      ExplicitTop = 537
      ExplicitWidth = 108
      ExplicitHeight = 66
      inherited ColorLabel1: TColorLabel
        Left = 33
        Top = 22
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitLeft = 33
        ExplicitTop = 22
        ExplicitWidth = 36
      end
      object ColorLabel2: TColorLabel [1]
        Left = 36
        Top = 38
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Top = 22
        ExplicitTop = 22
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
      Left = 170
      Top = 287
      Width = 163
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
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 336
      Top = 287
      Width = 139
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
      TabOrder = 18
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
      TabOrder = 19
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
      Top = 355
      Width = 77
      Height = 62
      Caption = 'Status'
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Ativos'
        'Inativos')
      TabOrder = 24
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
    object rdgOrientacao: TRadioGroup
      Left = 207
      Top = 485
      Width = 108
      Height = 60
      Caption = 'Orienta'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Paisagem'
        'Retrato')
      TabOrder = 32
    end
    object gpbCabecalho: TGroupBox
      Left = 207
      Top = 419
      Width = 108
      Height = 68
      Caption = 'Cores Cabe'#231'alho'
      TabOrder = 31
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
      Top = 419
      Width = 108
      Height = 68
      Caption = 'Cores Rodap'#233
      TabOrder = 36
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
      Left = 321
      Top = 355
      Width = 85
      Height = 62
      Caption = 'Colunas'
      TabOrder = 30
      object cbxColunas: TcxComboBox
        Left = 22
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
      Top = 355
      Width = 106
      Height = 62
      Caption = 'Imprime Lista'
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 25
    end
    object gpbPrecos: TGroupBox
      Left = 12
      Top = 485
      Width = 189
      Height = 60
      Caption = 'Op'#231#245'es de Pre'#231'os / Promo'#231#245'es'
      TabOrder = 27
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
    object rdgExibir: TRadioGroup
      Left = 321
      Top = 419
      Width = 85
      Height = 126
      Caption = 'Exibir'
      ItemIndex = 6
      Items.Strings = (
        'Aplica'#231#227'o'
        'Saldos'
        'Ambos'
        'Marca'
        'Refer'#234'ncia'
        'C'#243'd. F'#225'b.'
        'Nenhum')
      TabOrder = 33
    end
    object rdgSaldoProduto: TRadioGroup
      Left = 12
      Top = 419
      Width = 189
      Height = 64
      Caption = 'Saldo do Produto'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Positivo'
        'Negativo'
        'Zerado')
      TabOrder = 26
    end
    object rdgDescricao: TRadioGroup
      Left = 412
      Top = 356
      Width = 108
      Height = 55
      Caption = 'Descri'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Completa'
        'Simplificada')
      TabOrder = 35
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
      Top = 546
      Width = 230
      Height = 57
      Caption = 'Exibir Informa'#231#245'es adicionais'
      TabOrder = 28
      object chkExbUni: TCheckBox
        Left = 10
        Top = 16
        Width = 46
        Height = 17
        Caption = 'Unid.'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkExbEmb: TCheckBox
        Left = 58
        Top = 16
        Width = 42
        Height = 17
        Caption = 'Emb.'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object chkExbEmail: TCheckBox
        Left = 104
        Top = 16
        Width = 48
        Height = 17
        Caption = 'E-mail'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object chkExbVeiculo: TCheckBox
        Left = 158
        Top = 16
        Width = 65
        Height = 17
        Caption = 'Ve'#237'culos'
        TabOrder = 3
        OnClick = chkExbVeiculoClick
      end
      object chkCodBar: TCheckBox
        Left = 10
        Top = 35
        Width = 119
        Height = 17
        Caption = 'Exibir C'#243'd. Barras'
        TabOrder = 4
      end
    end
    object gpbBuscarAgregados: TGroupBox
      Left = 412
      Top = 496
      Width = 108
      Height = 39
      TabOrder = 37
      object chkAgregados: TCheckBox
        Left = 7
        Top = 11
        Width = 118
        Height = 17
        Caption = 'Buscar agreg.'
        TabOrder = 0
      end
    end
    object mskDtaCadIni: TMaskEditFocus
      Tag = 99
      Left = 12
      Top = 287
      Width = 74
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
      TabOrder = 15
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rdgImagem: TRadioGroup
      Left = 207
      Top = 355
      Width = 108
      Height = 62
      Caption = 'Imagem'
      ItemIndex = 2
      Items.Strings = (
        'Com imagem'
        'Sem imagem'
        'Todos')
      TabOrder = 29
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
    object rdgAtivoCompras: TRadioGroup
      Left = 248
      Top = 547
      Width = 158
      Height = 56
      Caption = 'Ativo para Compras'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 34
    end
    object edtMarVei: TEditFocus
      Left = 12
      Top = 327
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
      MaxLength = 4
      ParentFont = False
      TabOrder = 20
      OnExit = edtMarVeiExit
      OnKeyPress = edtMarVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDescMarVei: TEditFocus
      Left = 70
      Top = 327
      Width = 193
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
    object edtModVei: TEditFocus
      Left = 269
      Top = 327
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
      MaxLength = 4
      ParentFont = False
      TabOrder = 22
      OnExit = edtModVeiExit
      OnKeyPress = edtModVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDescModVei: TEditFocus
      Left = 327
      Top = 327
      Width = 193
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
    object mskDtaCadFin: TMaskEditFocus
      Tag = 99
      Left = 91
      Top = 287
      Width = 74
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
      TabOrder = 16
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rdgOrdena: TRadioGroup
      Left = 12
      Top = 606
      Width = 508
      Height = 43
      Caption = 'Ordena'#231#227'o'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Departamento/Produto'
        'Alfab'#233'tico Crescente'
        'Alfab'#233'tico Decrescente')
      TabOrder = 39
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
    ReportOptions.LastChange = 45341.644936250000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure mmZebraOnBeforePrint(Sender: TfrxComponent);'
      'begin  '
      'end;'
      ''
      'procedure picCoditeOnAfterData(Sender: TfrxComponent);'
      'var'
      
        '  dblLeft: Double;                                              ' +
        '          '
      '  dblWidth: Double;'
      '  dblHeight: Double;                                           '
      'begin'
      
        '  //carrega a imagem do banco                                   ' +
        '                         '
      '  pCarregaImagemProdutoRed(<frxRelatorio."CODITE">);'
      ''
      
        '  dblLeft := fRetornaLeftImagem;                                ' +
        '          '
      '  dblWidth := fRetornaWidthImagem;'
      
        '  dblHeight := (dblWidth * picCodIte.Picture.Height) / picCodIte' +
        '.Picture.Width;             '
      ''
      '  picCodIte.Left := dblLeft;                      '
      '  picCodIte.Width := dblWidth;'
      '  picCodIte.Height := dblHeight;                                '
      'end;'
      ''
      'procedure shpGapCodIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                            '
      'end;'
      ''
      'procedure shpGapProdutosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    '
      'end;'
      ''
      'procedure gphCodIteOnAfterCalcHeight(Sender: TfrxComponent);'
      'begin                      '
      '  '
      'end;'
      ''
      'procedure msdProdutosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  SubVeiculos.Height := 13.22834646 + (fQuantVeiculo(<frxRelator' +
        'io."CODITE">) * 13.22834646);'
      
        '  ChildBarras.Visible := (fExibeCodBar) and (<frxRelatorio."CODB' +
        'AR"> <> '#39#39');      '
      'end;'
      ''
      'procedure gphCodIteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure mmCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '         '
      'end;'
      ''
      'procedure gpfCodIteOnAfterCalcHeight(Sender: TfrxComponent);'
      'begin'
      ' if  picCodIte.Picture.Height = 0 then'
      '   gpfCodIte.Height := 0'
      ' else'
      '   gpfCodIte.Height := picCodIte.Height + 2;    '
      'end;'
      ''
      'procedure ChildVeiculoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ChildVeiculo.Visible := fTemVeiculo(<frxRelatorio."CODITE">); ' +
        ' '
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
      end
      item
        DataSet = frxVeiculos
        DataSetName = 'frxVeiculos'
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
        Height = 71.811070000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object mmDepartamento: TfrxMemoView
          Align = baRight
          Left = 782.362856460000000000
          Top = 15.000000000000000000
          Width = 302.362253540000000000
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
          Left = 143.622140000000000000
          Top = 15.000000000000000000
          Width = 638.740716460000000000
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
        object picLogo: TfrxPictureView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 136.063080000000000000
          Height = 64.252010000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236220472440900000
        Top = 464.882190000000000000
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
        Top = 219.212740000000000000
        Width = 542.362555000000000000
        OnBeforePrint = 'msdProdutosOnBeforePrint'
        Child = frxRelJato.ChildVeiculo
        ColumnWidth = 453.543307086614000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 3.779527560000000000
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
          Left = 45.354162280000000000
          Top = 0.220470000000000000
          Width = 413.858781540000000000
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
          Width = 3.779527560000000000
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
      object gphCodIte: TfrxGroupHeader
        FillType = ftBrush
        Top = 196.535560000000000000
        Width = 542.362555000000000000
        OnAfterCalcHeight = 'gphCodIteOnAfterCalcHeight'
        OnBeforePrint = 'gphCodIteOnBeforePrint'
        Condition = '<frxRelatorio."DESITE"> + <frxRelatorio."CODITE">'
        KeepTogether = True
        Stretched = True
      end
      object gpfCodIte: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 302.362400000000000000
        Width = 542.362555000000000000
        OnAfterCalcHeight = 'gpfCodIteOnAfterCalcHeight'
        Child = frxRelJato.ChildBarras
        Stretched = True
        object picCODITE: TfrxPictureView
          Left = 120.944957560000000000
          Top = 7.559060000000000000
          Width = 285.354517440000000000
          Height = 7.559055120000000000
          OnAfterData = 'picCoditeOnAfterData'
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object Header: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 151.181200000000000000
        Width = 542.362555000000000000
        ReprintOnNewPage = True
        object mmCodigo: TfrxMemoView
          Align = baLeft
          Top = 3.881911730000000000
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
          Left = 41.574634720000000000
          Top = 3.881911730000000000
          Width = 417.638309100000000000
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
          Top = 3.881911730000000000
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
          Top = 3.881911730000000000
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
          Top = 3.779530000000000000
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
        object mmSaldos: TfrxMemoView
          Align = baRight
          Left = 343.937230000000000000
          Top = 3.779530000000000000
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
          Top = 3.779530000000000000
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
      object ChildVeiculo: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677180000000000000
        ParentFont = False
        Top = 257.008040000000000000
        Width = 542.362555000000000000
        OnBeforePrint = 'ChildVeiculoOnBeforePrint'
        Stretched = True
        object SubVeiculos: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelJato.Page2
        end
      end
      object ChildBarras: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 56.692913390000000000
        ParentFont = False
        Top = 347.716760000000000000
        Width = 542.362555000000000000
        OnBeforePrint = 'ChildBarrasOnBeforePrint'
        Stretched = True
        object barCodeItem: TfrxBarCodeView
          Align = baCenter
          Left = 219.681277500000000000
          Top = 6.047244090000000000
          Width = 103.000000000000000000
          Height = 45.354360000000000000
          BarType = bcCodeEAN13
          DataField = 'CODBAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Rotation = 0
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
    end
    object Page2: TfrxReportPage
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
      object MasterDataChild: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 13.228346460000000000
        ParentFont = False
        Top = 79.370130000000000000
        Width = 542.362555000000000000
        DataSet = frxVeiculos
        DataSetName = 'frxVeiculos'
        KeepTogether = True
        RowCount = 0
        object Memo1: TfrxMemoView
          Align = baLeft
          Width = 122.834725000000000000
          Height = 13.228346456692910000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxVeiculos."MARVEI"]')
          ParentFont = False
          WordBreak = True
        end
        object Memo2: TfrxMemoView
          Align = baWidth
          Left = 122.834725000000000000
          Width = 419.527830000000000000
          Height = 13.228346456692910000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            '[frxVeiculos."MODVEI"]')
          ParentFont = False
          WordBreak = True
        end
      end
      object HeaderChild: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 13.228346460000000000
        ParentFont = False
        Top = 41.574830000000000000
        Width = 542.362555000000000000
        object Memo4: TfrxMemoView
          Align = baLeft
          Width = 122.834725000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          WordBreak = True
        end
        object Memo5: TfrxMemoView
          Align = baWidth
          Left = 122.834725000000000000
          Width = 419.527830000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'MODELO')
          ParentFont = False
          WordBreak = True
        end
      end
      object GroupFooterChild: TfrxGroupFooter
        FillType = ftBrush
        Top = 117.165430000000000000
        Width = 542.362555000000000000
      end
      object GroupHeaderChild: TfrxGroupHeader
        FillType = ftBrush
        Top = 18.897650000000000000
        Width = 542.362555000000000000
        Condition = 'frxVeiculos."CODITE"'
        KeepTogether = True
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
  object frxVeiculos: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxVeiculos'
    CloseDataSource = False
    DataSource = dtsVeiculos
    BCDToCurrency = False
    Left = 192
    Top = 200
  end
  object dtsVeiculos: TDataSource
    Left = 312
    Top = 216
  end
end
