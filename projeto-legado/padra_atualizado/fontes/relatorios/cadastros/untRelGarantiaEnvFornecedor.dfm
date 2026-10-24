inherited frmRelGarantiaEnvFornecedor: TfrmRelGarantiaEnvFornecedor
  Left = 442
  Top = 383
  Width = 400
  Height = 498
  Caption = 'Relat'#243'rio de Pe'#231'as Enviadas para o Fornecedor'
  ExplicitWidth = 400
  ExplicitHeight = 498
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 426
    Width = 394
    ExplicitTop = 426
    ExplicitWidth = 394
    inherited btnSair: TBitBtnLocked
      Left = 312
      ExplicitLeft = 312
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlDados: TPanel
    Width = 394
    Height = 426
    ExplicitWidth = 394
    ExplicitHeight = 426
    object Label5: TLabel [0]
      Left = 8
      Top = 7
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
    object lblOpcDtaIni: TLabel [2]
      Left = 92
      Top = 28
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
    object lblOpcDtaFin: TLabel [3]
      Left = 92
      Top = 67
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
    object Label10: TLabel [4]
      Left = 8
      Top = 86
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
    object Label11: TLabel [5]
      Left = 7
      Top = 124
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
    object Label1: TLabel [6]
      Left = 7
      Top = 164
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
    object Label3: TLabel [7]
      Left = 7
      Top = 205
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
    object Label2: TLabel [8]
      Left = 263
      Top = 303
      Width = 65
      Height = 14
      Caption = 'Tipo Relat'#243'rio'
    end
    inherited gpbDestino: TGroupBox
      Tag = 1
      Left = 199
      Top = 346
      Width = 182
      Height = 65
      TabOrder = 10
      ExplicitLeft = 199
      ExplicitTop = 346
      ExplicitWidth = 182
      ExplicitHeight = 65
      inherited ColorLabel1: TColorLabel
        Top = 29
        ExplicitTop = 29
      end
      inherited edtDestino: TEditFocus
        Left = 4
        Top = 26
        ExplicitLeft = 4
        ExplicitTop = 26
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 77
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
    object edtFornecedor: TEditFocus
      Left = 8
      Top = 100
      Width = 75
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
    object edtDesFornecedor: TEditFocus
      Left = 85
      Top = 100
      Width = 301
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
    object rdgFiltros: TRadioGroup
      Left = 8
      Top = 346
      Width = 185
      Height = 65
      Caption = 'Filtros'
      ItemIndex = 0
      Items.Strings = (
        'Todas'
        'A Devolver'
        'Terminadas')
      TabOrder = 9
    end
    object rdgOpcDta: TRadioGroup
      Left = 8
      Top = 248
      Width = 375
      Height = 43
      Caption = 'Filtrar por data de'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Envio'
        'Entrada')
      TabOrder = 6
      OnClick = rdgOpcDtaClick
    end
    object edtMarca: TEditFocus
      Left = 7
      Top = 138
      Width = 76
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
      TabOrder = 3
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
      Left = 85
      Top = 138
      Width = 301
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 178
      Width = 76
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
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 85
      Top = 178
      Width = 301
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object edtProdutos: TEditFocus
      Left = 7
      Top = 219
      Width = 76
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
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
      Left = 85
      Top = 219
      Width = 301
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object rdgOpcRel: TRadioGroup
      Left = 7
      Top = 297
      Width = 250
      Height = 43
      Caption = 'Op'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Pe'#231'as Enviadas'
        'Pe'#231'as n'#227'o Enviadas')
      TabOrder = 7
      OnClick = rdgOpcRelClick
    end
    object cbbTipoRel: TComboBoxFocus
      Tag = 99
      Left = 263
      Top = 318
      Width = 100
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 8
      Text = 'Anal'#237'tico'
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 454
    Width = 394
    ExplicitTop = 454
    ExplicitWidth = 394
    inherited pnlNomeForm: TPanel
      Left = 223
      ExplicitLeft = 223
    end
    inherited pnlInfo: TPanel
      Width = 223
      ExplicitWidth = 223
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 16
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 312
    Top = 16
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 312
    Top = 168
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 280
    Top = 168
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 248
    Top = 168
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 216
    Top = 168
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 184
    Top = 168
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 120
    Top = 168
  end
  inherited frxGen: TfrxUserDataSet
    Left = 152
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 200
  end
end
