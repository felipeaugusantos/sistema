inherited frmRelEstSaldoLoj: TfrmRelEstSaldoLoj
  Left = 291
  Top = 190
  Width = 634
  Height = 602
  Caption = 'Relat'#243'rio de Saldos de Estoques das Lojas'
  OnDestroy = FormDestroy
  ExplicitTop = -169
  ExplicitWidth = 634
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 628
    ExplicitTop = 529
    ExplicitWidth = 628
    inherited btnSair: TBitBtnLocked
      Left = 545
      ExplicitLeft = 545
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
    Width = 628
    Height = 529
    ExplicitWidth = 628
    ExplicitHeight = 529
    object Label9: TLabel [0]
      Left = 8
      Top = 8
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
      Left = 8
      Top = 84
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
      Left = 8
      Top = 122
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
      Left = 8
      Top = 160
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
      Left = 8
      Top = 198
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
      Left = 382
      Top = 198
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
      Left = 8
      Top = 46
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
    object Label4: TLabel [7]
      Left = 425
      Top = 8
      Width = 48
      Height = 14
      Caption = 'Empresas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 204
      Top = 466
      Width = 190
      TabOrder = 17
      ExplicitLeft = 204
      ExplicitTop = 466
      ExplicitWidth = 190
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
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
      TabOrder = 0
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
    object edtFornecedor: TEditFocus
      Left = 8
      Top = 98
      Width = 59
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
      Left = 8
      Top = 136
      Width = 59
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
      Left = 8
      Top = 174
      Width = 410
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
    object edtRefere: TEditFocus
      Left = 8
      Top = 212
      Width = 373
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
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 382
      Top = 212
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
      MaxLength = 2
      ParentFont = False
      TabOrder = 10
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
      Tag = 99
      Left = 8
      Top = 60
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
      Left = 8
      Top = 466
      Width = 190
      Height = 45
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 20
        Width = 127
        Height = 14
        Caption = '(A)lfabetica (L)inha/Grupo'
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
    object lstEmpresas: TCheckListBox
      Left = 424
      Top = 22
      Width = 197
      Height = 407
      OnClickCheck = lstEmpresasClickCheck
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 18
      OnKeyDown = lstEmpresasKeyDown
    end
    object edtDesGrupo: TEditFocus
      Left = 68
      Top = 22
      Width = 350
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
      Top = 60
      Width = 350
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
    object edtDesFornecedor: TEditFocus
      Left = 68
      Top = 98
      Width = 350
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
    object edtDesMarca: TEditFocus
      Left = 68
      Top = 136
      Width = 350
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
    object rdgStatus: TRadioGroup
      Left = 8
      Top = 236
      Width = 77
      Height = 80
      Caption = 'Status'
      ItemIndex = 2
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 11
    end
    object GroupBox3: TGroupBox
      Left = 204
      Top = 243
      Width = 214
      Height = 132
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      object chkReferencia: TCheckBox
        Left = 8
        Top = 10
        Width = 167
        Height = 17
        Caption = 'Exibir Refer'#234'ncia do Produto'
        TabOrder = 0
        OnClick = chkReferenciaClick
      end
      object chkMarca: TCheckBox
        Left = 8
        Top = 42
        Width = 173
        Height = 17
        Caption = 'Mostrar marca e '#250'ltima compra'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = chkMarcaClick
      end
      object chkPreVen: TCheckBox
        Left = 8
        Top = 58
        Width = 173
        Height = 17
        Caption = 'Exibir Pre'#231'o de Venda'
        TabOrder = 3
        OnClick = chkPreVenClick
      end
      object cmbPrecos: TComboBoxFocus
        Left = 8
        Top = 99
        Width = 200
        Height = 22
        Style = csDropDownList
        Enabled = False
        TabOrder = 5
        Items.Strings = (
          'Tabela 1'
          'Tabela 2'
          'Tabela 3'
          'Tabela 4'
          'Tabela 5'
          'Tabela 6'
          'Tabela 7')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object chkPreCom: TCheckBox
        Left = 8
        Top = 74
        Width = 185
        Height = 17
        Caption = 'Exibir Valor de Pre'#231'o de Compra'
        TabOrder = 4
      end
      object chkCodFabrica: TCheckBox
        Left = 8
        Top = 26
        Width = 193
        Height = 17
        Caption = 'Exibir C'#243'digo de F'#225'brica do Produto'
        TabOrder = 1
        OnClick = chkReferenciaClick
      end
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 522
      Width = 626
      Height = 6
      Align = alBottom
      Smooth = True
      TabOrder = 19
      Visible = False
    end
    object rdgBocaCaixa: TRadioGroup
      Left = 91
      Top = 236
      Width = 107
      Height = 80
      Caption = 'Boca de Caixa?'
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 12
    end
    object rdgSaldos: TRadioGroup
      Left = 8
      Top = 318
      Width = 190
      Height = 57
      Caption = 'Saldo'
      Columns = 2
      ItemIndex = 3
      Items.Strings = (
        'Positivo'
        'Negativo'
        'Zero'
        'Todos')
      TabOrder = 13
    end
    object grbEntregaFutura: TGroupBox
      Left = 8
      Top = 377
      Width = 410
      Height = 86
      Caption = 'Entrega Futura'
      TabOrder = 15
      object chkEntFut: TCheckBox
        Tag = 99
        Left = 7
        Top = 18
        Width = 293
        Height = 17
        Caption = 'Considerar entrega futura pendente no saldo do produto'
        TabOrder = 0
        OnClick = chkEntFutClick
      end
      object grbMotFut: TGroupBox
        Left = 7
        Top = 40
        Width = 397
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
  end
  inherited pnlStatus: TPanel
    Top = 557
    Width = 628
    ExplicitTop = 557
    ExplicitWidth = 628
    inherited pnlNomeForm: TPanel
      Left = 436
      Width = 192
      ExplicitLeft = 436
      ExplicitWidth = 192
    end
    inherited pnlInfo: TPanel
      Width = 436
      ExplicitWidth = 436
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 96
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 592
    Top = 64
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 432
    Top = 64
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 592
    Top = 32
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 560
    Top = 32
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 528
    Top = 32
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 496
    Top = 32
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 424
    Top = 32
  end
  inherited frxGen: TfrxUserDataSet
    Left = 464
    Top = 32
  end
  inherited frxDesigner: TfrxDesigner
    Left = 496
    Top = 64
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 528
    Top = 64
  end
end
