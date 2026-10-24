inherited frmRelPedNecessidadeProducao: TfrmRelPedNecessidadeProducao
  Left = 459
  Top = 314
  Width = 472
  Height = 445
  Caption = 'Relat'#243'rio de Necessidade de Produ'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 472
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 372
    Width = 466
    ExplicitTop = 372
    ExplicitWidth = 466
    inherited btnSair: TBitBtnLocked
      Left = 382
      ExplicitLeft = 382
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 11
      ExplicitLeft = 11
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 88
      ExplicitLeft = 88
    end
  end
  inherited pnlDados: TPanel
    Width = 466
    Height = 372
    ExplicitWidth = 466
    ExplicitHeight = 372
    object Label12: TLabel [0]
      Left = 11
      Top = 5
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
    object Label11: TLabel [1]
      Left = 11
      Top = 47
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
    object Label2: TLabel [2]
      Left = 11
      Top = 88
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [3]
      Left = 11
      Top = 128
      Width = 32
      Height = 14
      Caption = 'Pedido'
    end
    object lblEmpresa: TLabel [4]
      Left = 11
      Top = 209
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
    object Label3: TLabel [5]
      Left = 11
      Top = 167
      Width = 37
      Height = 14
      Caption = 'Produto'
    end
    inherited gpbDestino: TGroupBox
      Left = 231
      Top = 258
      Width = 209
      TabOrder = 10
      ExplicitLeft = 231
      ExplicitTop = 258
      ExplicitWidth = 209
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 11
      Top = 19
      Width = 62
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
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 11
      Top = 61
      Width = 64
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
      ValidaData = False
    end
    object edtCodCliente: TEditFocus
      Left = 11
      Top = 102
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 5
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 78
      Top = 102
      Width = 362
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
    object edtCodPedido: TEditFocus
      Left = 11
      Top = 142
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 6
      OnExit = edtCodPedidoExit
      OnKeyPress = edtCodPedidoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtDesPedido: TEditFocus
      Left = 98
      Top = 142
      Width = 342
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 12
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
      Left = 11
      Top = 223
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
      Left = 44
      Top = 223
      Width = 396
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
    object gpbTipo: TGroupBox
      Left = 11
      Top = 257
      Width = 214
      Height = 50
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 24
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        OnExit = edtTipoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object rdgFiltroData: TRadioGroup
      Left = 84
      Top = 13
      Width = 113
      Height = 72
      Caption = 'Filtrar por'
      ItemIndex = 0
      Items.Strings = (
        'Data de Entrada'
        'Data de Previs'#227'o')
      TabOrder = 2
    end
    object rdgOrdemData: TRadioGroup
      Left = 204
      Top = 13
      Width = 114
      Height = 72
      Caption = 'Ordenar por Data:'
      ItemIndex = 0
      Items.Strings = (
        'de Entrada'
        'de Previs'#227'o')
      TabOrder = 3
    end
    object rdgOrdemItens: TRadioGroup
      Left = 326
      Top = 13
      Width = 114
      Height = 72
      Caption = 'Ordenar Itens Por:'
      ItemIndex = 0
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
      TabOrder = 4
    end
    object edtCodIte: TEditFocus
      Left = 11
      Top = 181
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 7
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 78
      Top = 181
      Width = 362
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 361
      Width = 464
      Height = 10
      Align = alBottom
      Smooth = True
      TabOrder = 15
      Visible = False
    end
    object rdgQuebra: TRadioGroup
      Left = 11
      Top = 311
      Width = 429
      Height = 43
      Caption = 'Op'#231#227'o de Quebra:'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Quebrar por Cliente'
        'Quebrar por Documento')
      TabOrder = 16
    end
  end
  inherited pnlStatus: TPanel
    Top = 400
    Width = 466
    ExplicitTop = 400
    ExplicitWidth = 466
    inherited pnlNomeForm: TPanel
      Left = 295
      ExplicitLeft = 295
    end
    inherited pnlInfo: TPanel
      Width = 295
      ExplicitWidth = 295
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 184
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 456
    Top = 151
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 296
    Top = 152
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 264
    Top = 152
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 232
    Top = 152
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 200
    Top = 152
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 168
    Top = 152
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 104
    Top = 152
  end
  inherited frxGen: TfrxUserDataSet
    Left = 136
    Top = 152
  end
  inherited frxDesigner: TfrxDesigner
    Left = 360
    Top = 152
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 392
    Top = 152
  end
end
