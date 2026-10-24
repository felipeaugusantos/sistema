inherited frmRelEstPosicaoEst: TfrmRelEstPosicaoEst
  Left = 379
  Top = 157
  Width = 805
  Height = 538
  Caption = 'Relat'#243'rio da Posi'#231#227'o do Estoque'
  OnDestroy = FormDestroy
  ExplicitWidth = 805
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 465
    Width = 799
    ExplicitTop = 465
    ExplicitWidth = 799
    inherited btnSair: TBitBtnLocked
      Left = 716
      ExplicitLeft = 716
    end
    inherited btnConfigurar: TBitBtnLocked
      Width = 83
      ExplicitWidth = 83
    end
  end
  inherited pnlDados: TPanel
    Width = 799
    Height = 465
    ExplicitWidth = 799
    ExplicitHeight = 465
    object Label9: TLabel [0]
      Left = 7
      Top = 40
      Width = 109
      Height = 14
      Caption = 'Linha / Grupo a excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [1]
      Left = 7
      Top = 112
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
      Left = 7
      Top = 147
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
      Left = 7
      Top = 341
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
      Left = 7
      Top = 415
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
    object Label2: TLabel [5]
      Left = 281
      Top = 378
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
      Left = 7
      Top = 76
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
    object lblEmpresa: TLabel [7]
      Left = 7
      Top = 260
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
    object Label4: TLabel [8]
      Left = 170
      Top = 415
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
    object Label5: TLabel [9]
      Left = 7
      Top = 378
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
    object Label6: TLabel [10]
      Left = 7
      Top = 3
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
    object Label7: TLabel [11]
      Left = 334
      Top = 2
      Width = 77
      Height = 14
      Caption = 'Tabela de Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [12]
      Left = 418
      Top = 2
      Width = 78
      Height = 14
      Caption = 'Op'#231#227'o de Pre'#231'o'
    end
    object lblDepartamento: TLabel [13]
      Left = 9
      Top = 183
      Width = 122
      Height = 14
      Caption = 'Departamento do Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel [14]
      Left = 9
      Top = 221
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
      Left = 602
      Top = 381
      Width = 184
      Height = 43
      TabOrder = 35
      ExplicitLeft = 602
      ExplicitTop = 381
      ExplicitWidth = 184
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 17
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitTop = 17
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 5
        ExplicitLeft = 5
      end
    end
    object mskLinhaGrupo: TMaskEditFocus
      Left = 7
      Top = 54
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
      TabOrder = 2
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
      Left = 7
      Top = 126
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
      Left = 7
      Top = 161
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
    object edtDescri: TEditFocus
      Left = 7
      Top = 355
      Width = 314
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
      Left = 7
      Top = 429
      Width = 159
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
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 281
      Top = 391
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
    object gpbOpcao: TGroupBox
      Left = 334
      Top = 41
      Width = 135
      Height = 43
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 25
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 20
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
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
        Text = 'A'
        OnChange = edtOpcaoChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbQuebra: TGroupBox
      Left = 467
      Top = 41
      Width = 161
      Height = 43
      Caption = 'Ordena'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 26
      object cbxQuebra: TComboBox
        Left = 5
        Top = 15
        Width = 151
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Alfab'#233'tica'
        Items.Strings = (
          'Alfab'#233'tica'
          'Linha/Grupo'
          'ABC Litragem'
          'ABC Saldo de Estoque'
          'ABC Pre'#231'o '#218'ltima Compra'
          'ABC Pre'#231'o Custo'
          'ABC Pre'#231'o Venda')
      end
    end
    object edtDesGrupo: TEditFocus
      Left = 67
      Top = 54
      Width = 254
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
    object edtDesFornecedor: TEditFocus
      Left = 67
      Top = 126
      Width = 254
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
      Left = 67
      Top = 161
      Width = 254
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
    object edtProdutos: TEditFocus
      Left = 7
      Top = 90
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
      Left = 67
      Top = 90
      Width = 254
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 274
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
      TabOrder = 14
      OnChange = edtCodEmpresaChange
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
      Top = 274
      Width = 255
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefFin: TEditFocus
      Left = 170
      Top = 429
      Width = 151
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
      TabOrder = 21
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 334
      Top = 381
      Width = 267
      Height = 70
      Caption = 'Saldos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 34
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 20
        Width = 173
        Height = 14
        Caption = '(P)ositivo (N)egativo (T)odos (Z)ero'
        CorDestaque = clRed
      end
      object edtSaldos: TEditFocus
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
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object rdbSalIte: TRadioButton
        Left = 32
        Top = 37
        Width = 217
        Height = 17
        Caption = 'Considera saldo de estoque do produto'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rdbSalLot: TRadioButton
        Left = 32
        Top = 51
        Width = 217
        Height = 17
        Caption = 'Considera saldo de estoque do lote'
        TabOrder = 2
      end
    end
    object edtLocFis: TEditFocus
      Left = 7
      Top = 391
      Width = 268
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
      TabOrder = 18
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgStatus: TRadioGroup
      Left = 614
      Top = 0
      Width = 172
      Height = 38
      Caption = 'Status'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 24
    end
    object mskLinhaGrupo1: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 17
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
      TabOrder = 0
      Text = ''
      OnExit = mskLinhaGrupo1Exit
      OnKeyPress = mskLinhaGrupo1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo1: TEditFocus
      Left = 67
      Top = 17
      Width = 254
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
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox2: TGroupBox
      Left = 334
      Top = 204
      Width = 452
      Height = 49
      Caption = 'Exibir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 30
      object chkResumoGP: TCheckBox
        Left = 7
        Top = 12
        Width = 119
        Height = 17
        Caption = 'Resumo por Grupo'
        TabOrder = 0
      end
      object chkReferencia: TCheckBox
        Left = 132
        Top = 11
        Width = 162
        Height = 17
        Caption = 'Refer'#234'ncia do Produto'
        TabOrder = 1
      end
      object chkMarca: TCheckBox
        Left = 300
        Top = 11
        Width = 125
        Height = 17
        Caption = 'Marca do Produto'
        TabOrder = 2
      end
      object chkSaldoRes: TCheckBox
        Left = 7
        Top = 28
        Width = 154
        Height = 17
        Caption = 'Saldo Reservado do Produto'
        TabOrder = 3
      end
      object chkExibirTotSaldo: TCheckBox
        Left = 231
        Top = 28
        Width = 217
        Height = 17
        Caption = 'Exibir totalizador do saldo de estoque'
        TabOrder = 4
      end
    end
    object edtTabPre: TEditFocus
      Tag = 99
      Left = 334
      Top = 16
      Width = 78
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object rdgLocalizacaoFisica: TRadioGroup
      Left = 334
      Top = 166
      Width = 448
      Height = 37
      Caption = 'Imprimir itens:'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Com localiza'#231#227'o f'#237'sica'
        'Sem localiza'#231#227'o f'#237'sica'
        'Todos')
      TabOrder = 29
    end
    object cbxTipPre: TComboBox
      Left = 418
      Top = 16
      Width = 190
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 23
      Text = 'Pre'#231'o de custo'
      Items.Strings = (
        'Pre'#231'o de custo'
        'Pre'#231'o de custo real'
        'Pre'#231'o m'#233'dio'
        'Pre'#231'o da '#250'ltima compra'
        'Pre'#231'o da '#250'ltima compra + impostos')
    end
    object pbProgresso: TProgressBar
      Left = 1
      Top = 456
      Width = 797
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 36
      Visible = False
    end
    object gpbOpcaoSintetico: TGroupBox
      Left = 627
      Top = 41
      Width = 160
      Height = 43
      Caption = 'Op'#231#227'o Sint'#233'tico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 27
      Visible = False
      object cbxOpcaoSint: TComboBox
        Left = 8
        Top = 16
        Width = 137
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Fornecedor'
        Items.Strings = (
          'Fornecedor'
          'Empresa'
          'Marca')
      end
    end
    object grbEntregaFutura: TGroupBox
      Left = 334
      Top = 254
      Width = 452
      Height = 83
      Caption = 'Entrega Futura'
      TabOrder = 31
      object chkEntFut: TCheckBox
        Tag = 99
        Left = 7
        Top = 20
        Width = 293
        Height = 17
        Caption = 'Considerar entrega futura pendente no saldo do produto'
        TabOrder = 0
        OnClick = chkEntFutClick
      end
      object grbMotFut: TGroupBox
        Left = 7
        Top = 35
        Width = 434
        Height = 38
        Enabled = False
        TabOrder = 1
        object chkFalta: TCheckBox
          Left = 6
          Top = 15
          Width = 97
          Height = 17
          Caption = 'Falta Produto'
          TabOrder = 0
        end
        object chkPrevisao: TCheckBox
          Left = 102
          Top = 15
          Width = 137
          Height = 17
          Caption = 'Previs'#227'o de Entrega'
          TabOrder = 1
        end
        object chkAguarda: TCheckBox
          Left = 232
          Top = 15
          Width = 131
          Height = 17
          Caption = 'Aguardando Cliente'
          TabOrder = 2
        end
      end
    end
    object rdgAtivoCompras: TRadioGroup
      Left = 602
      Top = 337
      Width = 184
      Height = 44
      Caption = 'Ativo para Compras'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 33
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 7
      Top = 197
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
      TabOrder = 10
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesDep: TEditFocus
      Left = 66
      Top = 197
      Width = 255
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
    object edtGruCmp: TEditFocus
      Tag = 99
      Left = 7
      Top = 236
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
      TabOrder = 12
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
      Left = 66
      Top = 236
      Width = 255
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox3: TGroupBox
      Left = 333
      Top = 85
      Width = 449
      Height = 80
      Caption = 'Lote'
      Padding.Left = 2
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      TabOrder = 28
      object rdgLotesDeProdutos: TRadioGroup
        Left = 4
        Top = 18
        Width = 253
        Height = 58
        Align = alLeft
        Caption = 'Itens'
        ItemIndex = 2
        Items.Strings = (
          'Apenas itens que possuem lote'
          'Apenas itens que n'#227'o possuem lote'
          'Todos os itens')
        TabOrder = 0
      end
      object grbLoteValidade: TGroupBox
        Left = 257
        Top = 18
        Width = 188
        Height = 58
        Align = alClient
        Caption = 'Validade do Lote'
        TabOrder = 1
        object Label13: TLabel
          Left = 6
          Top = 15
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
        object Label14: TLabel
          Left = 98
          Top = 15
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
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 6
          Top = 28
          Width = 86
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
          Left = 97
          Top = 28
          Width = 88
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
      end
    end
    object GroupBox4: TGroupBox
      Left = 334
      Top = 337
      Width = 267
      Height = 44
      Caption = 'Imprimir Lista ?'
      TabOrder = 32
      object ColorLabel4: TColorLabel
        Left = 29
        Top = 17
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtImpLis: TEditFocus
        Tag = 99
        Left = 7
        Top = 13
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
    object rdgOpcaoSaldoTodasEmpresas: TRadioGroup
      Left = 7
      Top = 297
      Width = 312
      Height = 43
      Caption = 'Op'#231#227'o de filtro de saldo:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Empresa'
        'Geral')
      TabOrder = 16
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 493
    Width = 799
    ExplicitTop = 493
    ExplicitWidth = 799
    inherited pnlNomeForm: TPanel
      Left = 628
      ExplicitLeft = 628
    end
    inherited pnlInfo: TPanel
      Width = 628
      ExplicitWidth = 628
      inherited shpMultSel: TShape
        Left = 295
        Visible = True
        ExplicitLeft = 295
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 104
    Top = 72
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 208
    Top = 32
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 160
    Top = 104
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 296
    Top = 72
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 264
    Top = 72
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 232
    Top = 72
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 200
    Top = 72
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 136
    Top = 72
  end
  inherited frxGen: TfrxUserDataSet
    Left = 168
    Top = 72
  end
  inherited frxDesigner: TfrxDesigner
    Left = 224
    Top = 104
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 256
    Top = 104
  end
  object dlgExcel: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Planilha do Excel|*.xls'
    Left = 152
    Top = 40
  end
end
