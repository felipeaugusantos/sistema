inherited frmRelEstItemsAcimaMax: TfrmRelEstItemsAcimaMax
  Left = 472
  Top = 229
  Width = 531
  Height = 543
  Caption = 'Relat'#243'rio de Produtos com Saldo Acima do M'#225'ximo'
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 531
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 472
    Width = 525
    ExplicitTop = 472
    ExplicitWidth = 525
    inherited FlwBotoes: TFlowPanel
      Width = 444
      ExplicitWidth = 444
      inherited btnConfigurar: TBitBtnLocked
        Width = 83
        ExplicitWidth = 83
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      ExplicitLeft = 446
    end
  end
  inherited pnlDados: TPanel
    Width = 525
    Height = 472
    ExplicitWidth = 525
    ExplicitHeight = 472
    object Label9: TLabel [0]
      Left = 7
      Top = 7
      Width = 88
      Height = 14
      Caption = 'Linha/Grupo Inicial'
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
      Top = 77
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
      Top = 112
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
      Top = 185
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
      Top = 222
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
      Left = 221
      Top = 222
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
      Top = 42
      Width = 84
      Height = 14
      Caption = 'Linha/Grupo Final'
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
      Top = 257
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
    object Label15: TLabel [8]
      Left = 7
      Top = 149
      Width = 91
      Height = 14
      Caption = 'Grupo de Compras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresaAbastecer: TLabel [9]
      Left = 266
      Top = 257
      Width = 126
      Height = 14
      Caption = 'Empresa a ser abastecida'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label14: TLabel [10]
      Left = 232
      Top = 112
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [11]
      Left = 266
      Top = 222
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o do Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 251
      Top = 422
      Width = 264
      Height = 42
      TabOrder = 29
      ExplicitLeft = 251
      ExplicitTop = 422
      ExplicitWidth = 264
      ExplicitHeight = 42
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 18
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitTop = 18
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 15
        ExplicitTop = 15
      end
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 21
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
      Top = 91
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 6
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
      Top = 199
      Width = 330
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
      TabOrder = 12
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
      Top = 235
      Width = 208
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
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 221
      Top = 235
      Width = 36
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
      TabOrder = 14
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
    object mskLinhaGrupo2: TMaskEditFocus
      Left = 7
      Top = 56
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
      OnExit = mskLinhaGrupo2Exit
      OnKeyPress = mskLinhaGrupo2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object GroupBox1: TGroupBox
      Left = 251
      Top = 378
      Width = 264
      Height = 42
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 28
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 19
        Width = 168
        Height = 14
        Caption = '(A)lfabetica (L)inha/Grupo (M)arca'
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
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtDesGrupo: TEditFocus
      Left = 68
      Top = 21
      Width = 448
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
    object edtDesGrupo2: TEditFocus
      Left = 68
      Top = 56
      Width = 448
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
      Left = 68
      Top = 91
      Width = 448
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMarca: TEditFocus
      Left = 68
      Top = 126
      Width = 157
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgStatus: TRadioGroup
      Left = 7
      Top = 378
      Width = 123
      Height = 86
      Caption = 'Status'
      ItemIndex = 2
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 26
    end
    object rdgSaldo: TRadioGroup
      Left = 135
      Top = 378
      Width = 111
      Height = 86
      Caption = 'Saldo Atual'
      ItemIndex = 2
      Items.Strings = (
        'Maior que zero'
        'Zero'
        'Todos')
      TabOrder = 27
    end
    object chkImpRef: TCheckBox
      Left = 7
      Top = 317
      Width = 116
      Height = 17
      Caption = 'Imprimir refer'#234'ncia?'
      TabOrder = 22
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 271
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
      TabOrder = 17
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
      Left = 68
      Top = 271
      Width = 189
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkGerOrc: TCheckBox
      Left = 7
      Top = 297
      Width = 314
      Height = 17
      Caption = 'Gerar Or'#231'amentos/Pedidos para Transfer'#234'ncia de Estoque'
      TabOrder = 21
      Visible = False
      OnClick = chkGerOrcClick
      OnExit = chkGerOrcExit
    end
    object edtGruCmp: TEditFocus
      Tag = 99
      Left = 7
      Top = 163
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
      TabOrder = 10
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
      Left = 68
      Top = 163
      Width = 448
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
    object chkInativoCompra: TCheckBox
      Left = 167
      Top = 317
      Width = 154
      Height = 17
      Hint = 'Incluir Inativos para Compra'
      Caption = 'Incluir Inativos para Compra'
      TabOrder = 23
    end
    object gpbPreco: TGroupBox
      Left = 7
      Top = 337
      Width = 509
      Height = 41
      Caption = 'Pre'#231'o'
      TabOrder = 25
      object ColorLabel3: TColorLabel
        Left = 94
        Top = 16
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object shpPreco: TShape
        Left = 66
        Top = 12
        Width = 8
        Height = 22
        Brush.Color = clRed
      end
      object Label4: TLabel
        Left = 5
        Top = 16
        Width = 60
        Height = 14
        Caption = 'Exibir Pre'#231'o:'
      end
      object Label5: TLabel
        Left = 158
        Top = 16
        Width = 23
        Height = 14
        Caption = 'Tipo:'
      end
      object edtExiPre: TEditFocus
        Tag = 99
        Left = 75
        Top = 12
        Width = 18
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'N'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object cmbTipPre: TComboBoxFocus
        Left = 186
        Top = 12
        Width = 316
        Height = 22
        Style = csDropDownList
        Enabled = False
        TabOrder = 1
        TabStop = False
        Items.Strings = (
          'PRE'#199'O DE CUSTO'
          'PRE'#199'O DE '#218'LTIMA COMPRA'
          'PRE'#199'O DE '#218'LTIMA COMPRA MAIS IMPOSTOS DA ENTRADA'
          'PRE'#199'O M'#201'DIO DE COMPRA')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object edtCodEmpresaAbastecer: TEditFocus
      Tag = 99
      Left = 266
      Top = 271
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
      Visible = False
      OnExit = edtCodEmpresaAbastecerExit
      OnKeyPress = edtCodEmpresaAbastecerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresaAbastecer: TEditFocus
      Left = 327
      Top = 271
      Width = 189
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 20
      Visible = False
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
      Left = 232
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
      ParentFont = False
      TabOrder = 8
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
    object edtDesCodDep: TEditFocus
      Left = 293
      Top = 126
      Width = 223
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
    object rdgSaldoProduto: TRadioGroup
      Left = 329
      Top = 299
      Width = 186
      Height = 39
      Caption = 'Saldo do Produto'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'F'#237'sico'
        'Dispon'#237'vel')
      TabOrder = 24
    end
    object edtSitPro: TEditFocus
      Tag = 99
      Left = 266
      Top = 235
      Width = 33
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      OnExit = edtSitProExit
      OnKeyPress = edtSitProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesPro: TEditFocus
      Left = 303
      Top = 235
      Width = 213
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 498
    Width = 525
    ExplicitTop = 498
    ExplicitWidth = 525
    inherited pnlNomeForm: TPanel
      Left = 354
      ExplicitLeft = 354
    end
    inherited pnlInfo: TPanel
      Width = 354
      ExplicitWidth = 354
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 400
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45265.686884583330000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure qckPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    mmoHEstMax000.Visible := False;'
      '    mmoHSaldo000.Visible  := False;'
      '    mmoHSalMax000.Visible := False;'
      '    mmoMEstMax000.Visible := False;'
      '    mmoMSaldo000.Visible  := False;'
      '    mmoMSalMax000.Visible := False;'
      ''
      '    mmoHEstMax001.Visible := False;'
      '    mmoHSaldo001.Visible  := False;'
      '    mmoHSalMax001.Visible := False;'
      '    mmoMEstMax001.Visible := False;'
      '    mmoMSaldo001.Visible  := False;'
      '    mmoMSalMax001.Visible := False;'
      ''
      '    mmoHValorUnitario.Visible := False;'
      '    mmoHValorTotal.Visible := False;'
      '    mmoMValorUnitario.Visible := False;'
      '    mmoMValorTotal.Visible := False;'
      ''
      '    mmoHCompras.Visible := False;'
      '    mmoMCompras.Visible := False;'
      ''
      '    if <IMPRIMIR_REFERENCIA> = '#39'N'#39' then'
      '    begin'
      
        '        mmoHDescricao.Width := mmoHDescricao.Width + mmoHReferen' +
        'cia.Width;'
      
        '        mmoMDescricao.Width := mmoMDescricao.Width + mmoMReferen' +
        'cia.Width;'
      '        mmoHReferencia.Visible := False;'
      '        mmoMReferencia.Visible := False;'
      '    end;'
      ''
      '    if <EMPRESA_ABASTECEDORA> = '#39#39' then'
      '    begin'
      '        mmoHEstMax000.Visible := True;'
      '        mmoHSaldo000.Visible  := True;'
      '        mmoHSalMax000.Visible := True;'
      '        mmoMEstMax000.Visible := True;'
      '        mmoMSaldo000.Visible  := True;'
      '        mmoMSalMax000.Visible := True;'
      ''
      '        mmoHEstMax000.Text    := '#39'EST.MAX'#39';'
      '        mmoHSaldo000.Text     := '#39'SALDO'#39';'
      '        mmoHSalMax000.Text    := '#39'SAL.MAX'#39';'
      ''
      '        if <EXIBIR_PRECOS> = '#39'S'#39' then'
      '        begin'
      '            mmoHValorUnitario.Visible := True;'
      '            mmoHValorTotal.Visible := True;'
      '            mmoMValorUnitario.Visible := True;'
      '            mmoMValorTotal.Visible := True;'
      '        end'
      '        else if <EXIBIR_PRECOS> = '#39'N'#39' then'
      '        begin'
      '            mmoHCompras.Visible := True;'
      '            mmoMCompras.Visible := True;'
      '        end;'
      '    end;'
      ''
      '    if <EMPRESA_ABASTECEDORA> <> '#39#39' then'
      '    begin'
      '        mmoHEstMax000.Visible := True;'
      '        mmoHSaldo000.Visible  := True;'
      '        mmoHSalMax000.Visible := True;'
      '        mmoMEstMax000.Visible := True;'
      '        mmoMSaldo000.Visible  := True;'
      '        mmoMSalMax000.Visible := True;'
      ''
      '        mmoHEstMax001.Visible := True;'
      '        mmoHSaldo001.Visible  := True;'
      '        mmoHSalMax001.Visible := True;'
      '        mmoMEstMax001.Visible := True;'
      '        mmoMSaldo001.Visible  := True;'
      '        mmoMSalMax001.Visible := True;'
      ''
      '        mmoHEstMax000.Text    := '#39'EST.MAX '#39' + <EMPRESA_CODIGO>;'
      '        mmoHSaldo000.Text     := '#39'SALDO '#39' + <EMPRESA_CODIGO>;'
      '        mmoHSalMax000.Text    := '#39'SAL.MAX '#39' + <EMPRESA_CODIGO>;'
      ''
      
        '        mmoHEstMax001.Text    := '#39'EST.MAX '#39' + <ABASTECEDORA_CODI' +
        'GO>;'
      
        '        mmoHSaldo001.Text     := '#39'SALDO '#39' + <ABASTECEDORA_CODIGO' +
        '>;'
      
        '        mmoHSalMax001.Text    := '#39'SAL.MAX '#39' + <ABASTECEDORA_CODI' +
        'GO>;'
      ''
      '    end;'
      ''
      '    grpLinha.Visible := False;'
      '    grpGrupo.Visible := False;'
      '    grpMarca.Visible := False;'
      ''
      '    mmoZebra.Highlight.Condition := '#39'<Line> Mod 2 = 0'#39';'
      ''
      '    if <OPCAO> = '#39'L'#39' then'
      '    begin'
      '        grpLinha.Visible := True;'
      '        grpGrupo.Visible := True;'
      '    end'
      '    else if <OPCAO> = '#39'M'#39' then'
      '        grpMarca.Visible := True'
      '    else if <OPCAO> = '#39'A'#39' then'
      '        mmoZebra.Highlight.Condition := '#39'<Line#> Mod 2 = 0'#39';'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 449
    Top = 6
    Datasets = <
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
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      ColumnWidth = 2.500000000000000000
      LargeDesignHeight = True
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 144.618120000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object memlNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object memNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object memPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
        end
        object memEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
        end
        object memFornecedor: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 36.015770000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
        object memLinhaGrupoInicial: TfrxMemoView
          Left = 7.559060000000000000
          Top = 62.472480000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAGRUPO_INICIAL]')
          ParentFont = False
        end
        object memLinhaGrupoFinal: TfrxMemoView
          Left = 362.834880000000000000
          Top = 62.472480000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAGRUPO_FINAL]')
          ParentFont = False
        end
        object memMarca: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.149660000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object memUnidade: TfrxMemoView
          Left = 362.834880000000000000
          Top = 78.149660000000000000
          Width = 347.716760000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object memDescricao: TfrxMemoView
          Left = 7.559060000000000000
          Top = 94.488250000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object memReferencia: TfrxMemoView
          Left = 362.834880000000000000
          Top = 94.488250000000000000
          Width = 347.716760000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
        end
        object memGrupoCompras: TfrxMemoView
          Left = 7.559060000000000000
          Top = 109.606370000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_COMPRAS]')
          ParentFont = False
        end
        object memPrecos: TfrxMemoView
          Left = 362.834880000000000000
          Top = 109.606370000000000000
          Width = 347.716760000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRECOS]')
          ParentFont = False
        end
        object memEmpresa: TfrxMemoView
          Left = 7.559060000000000000
          Top = 124.724490000000000000
          Width = 347.716535430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object memEmpresaAbastecedora: TfrxMemoView
          Left = 362.834880000000000000
          Top = 124.724490000000000000
          Width = 347.716760000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA_ABASTECEDORA]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 404.409710000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677165350000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clScrollBar
        end
        object mmoMCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 64.251963620000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GRUPO"].[frxRelatorio."CODITE"]')
          ParentFont = False
        end
        object mmoMDescricao: TfrxMemoView
          Left = 64.252010000000000000
          Top = 3.779530000000000000
          Width = 134.929128980000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object mmoMReferencia: TfrxMemoView
          Left = 202.094620000000000000
          Top = 3.779530000000000000
          Width = 78.992123540000000000
          Height = 15.118110240000000000
          DataField = 'REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMUnidade: TfrxMemoView
          Left = 283.464750000000000000
          Top = 3.779530000000000000
          Width = 18.897637800000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 306.141930000000000000
          Top = 3.779530000000000000
          Width = 68.409448820000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMEstMax000: TfrxMemoView
          Left = 377.953000000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTMAX"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMSaldo000: TfrxMemoView
          Left = 442.205010000000000000
          Top = 3.779530000000000000
          Width = 53.669291340000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMSalMax000: TfrxMemoView
          Left = 498.897960000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALMAX"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMEstMax001: TfrxMemoView
          Left = 563.149970000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTMAXABS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMSaldo001: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 53.669291340000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOSABS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMSalMax001: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALMAXABS"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMCompras: TfrxMemoView
          Left = 559.370078740000000000
          Top = 3.779530000000000000
          Width = 183.307164720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '_____________________________')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMValorTotal: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoMValorUnitario: TfrxMemoView
          Left = 618.401980000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALUNI"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677165350000000000
        ParentFont = False
        Top = 359.055350000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677165350000000000
          Fill.BackColor = clScrollBar
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object mmoHCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 64.251966060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHDescricao: TfrxMemoView
          Left = 64.252010000000000000
          Top = 3.779530000000000000
          Width = 134.929128980000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHReferencia: TfrxMemoView
          Left = 202.204714650000000000
          Top = 3.779530000000000000
          Width = 78.992123540000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHUnidade: TfrxMemoView
          Left = 283.464750000000000000
          Top = 3.779530000000000000
          Width = 18.897635350000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHMarca: TfrxMemoView
          Left = 306.141930000000000000
          Top = 3.779530000000000000
          Width = 68.409448820000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHEstMax000: TfrxMemoView
          Left = 377.953000000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EST.MAX 000')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHSaldo000: TfrxMemoView
          Left = 442.205010000000000000
          Top = 3.779530000000000000
          Width = 53.669291340000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO 000')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHSalMax000: TfrxMemoView
          Left = 498.897960000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.MAX 000')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHEstMax001: TfrxMemoView
          Left = 563.149970000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EST.MAX 001')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHSaldo001: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 53.669291340000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO 001')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHSalMax001: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.MAX 001')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHCompras: TfrxMemoView
          Left = 559.370440000000000000
          Top = 3.779530000000000000
          Width = 183.307164720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPRAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHValorTotal: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoHValorUnitario: TfrxMemoView
          Left = 618.330708661417000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 487.559370000000000000
        Width = 748.346940000000000000
        object mmoContaRegistro: TfrxMemoView
          Align = baRight
          Left = 495.118430000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData1, 2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmRelEstItemsAcimaMax')
          ParentFont = False
        end
        object mmoLinhaFinal: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object grpLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 222.992270000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."LINHA"'
        object frxRelatorioLINHA: TfrxMemoView
          Left = 3.779527559055118000
          Top = 3.779530000000000000
          Width = 661.417750000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Linha: [frxRelatorio."LINHA"].000 - [frxRelatorio."DESLIN"] ')
          ParentFont = False
        end
      end
      object grpGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 268.346630000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."GRUPO"'
        object Memo2: TfrxMemoView
          Left = 30.236220472440940000
          Top = 3.779530000000000000
          Width = 623.622450000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Grupo: [frxRelatorio."GRUPO"] - [frxRelatorio."DESGRU"]')
          ParentFont = False
        end
      end
      object grpMarca: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 313.700990000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."CODMAR"'
        object Memo3: TfrxMemoView
          Left = 30.236220472440900000
          Top = 3.779530000000000000
          Width = 661.417750000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Marca: [frxRelatorio."DESMAR"]')
          ParentFont = False
        end
      end
    end
  end
end
