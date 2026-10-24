inherited frmRelFatDocsCancelados: TfrmRelFatDocsCancelados
  Left = 634
  Top = 267
  Width = 313
  Height = 486
  Caption = 'Relat'#243'rio de Documentos Cancelados'
  ExplicitWidth = 313
  ExplicitHeight = 486
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 414
    Width = 307
    ExplicitTop = 414
    ExplicitWidth = 307
    inherited btnSair: TBitBtnLocked
      Left = 224
      ExplicitLeft = 224
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 6
      ExplicitLeft = 6
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 83
      ExplicitLeft = 83
    end
  end
  inherited pnlDados: TPanel
    Width = 307
    Height = 414
    ExplicitWidth = 307
    ExplicitHeight = 414
    object lblEmpresa: TLabel [0]
      Left = 7
      Top = 122
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
    object Label11: TLabel [1]
      Left = 8
      Top = 84
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
      Left = 8
      Top = 46
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
    object Label1: TLabel [3]
      Left = 97
      Top = 8
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
    object Label2: TLabel [4]
      Left = 8
      Top = 8
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label3: TLabel [5]
      Left = 7
      Top = 160
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [6]
      Left = 7
      Top = 198
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
    object lbl1: TLabel [7]
      Left = 7
      Top = 273
      Width = 54
      Height = 14
      Caption = 'Ocorr'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel [8]
      Left = 8
      Top = 236
      Width = 69
      Height = 14
      Caption = 'Rede de Lojas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [9]
      Left = 8
      Top = 311
      Width = 61
      Height = 14
      Caption = 'Class. Fiscal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 155
      Top = 349
      Width = 142
      Height = 53
      TabOrder = 12
      ExplicitLeft = 155
      ExplicitTop = 349
      ExplicitWidth = 142
      ExplicitHeight = 53
      object ColorLabel2: TColorLabel [1]
        Left = 53
        Top = 32
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 4
        Top = 22
        ExplicitLeft = 4
        ExplicitTop = 22
      end
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 7
      Top = 136
      Width = 37
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
      TabOrder = 5
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 46
      Top = 136
      Width = 251
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 60
      Width = 64
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
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 98
      Width = 64
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
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtEspDoc: TEditFocus
      Left = 97
      Top = 22
      Width = 37
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
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 86
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object rgpSelectDatas: TRadioGroup
      Left = 76
      Top = 46
      Width = 150
      Height = 74
      Caption = ' Selecione a Data '
      ItemIndex = 0
      Items.Strings = (
        'Data de Cancelamento'
        'Data de Entrada')
      TabOrder = 2
    end
    object edtCodVen: TEditFocus
      Left = 7
      Top = 174
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
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVen: TEditFocus
      Left = 72
      Top = 174
      Width = 225
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Left = 7
      Top = 212
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 7
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 72
      Top = 212
      Width = 225
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object gpb1: TGroupBox
      Left = 7
      Top = 349
      Width = 142
      Height = 53
      Caption = 'Exibir somente'
      TabOrder = 11
      object chkVenda: TCheckBox
        Left = 11
        Top = 11
        Width = 128
        Height = 17
        Caption = 'CFOP de Venda'
        TabOrder = 0
        OnClick = chkVendaClick
      end
      object chkCompra: TCheckBox
        Left = 8
        Top = 34
        Width = 128
        Height = 17
        Caption = 'CFOP de Compra'
        TabOrder = 1
        OnClick = chkCompraClick
      end
    end
    object edtCodOco: TEditFocus
      Tag = 99
      Left = 7
      Top = 287
      Width = 37
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
      TabOrder = 9
      OnExit = edtCodOcoExit
      OnKeyPress = edtCodOcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesOco: TEditFocus
      Left = 45
      Top = 287
      Width = 252
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRed: TEditFocus
      Left = 7
      Top = 249
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 8
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesRed: TEditFocus
      Left = 72
      Top = 249
      Width = 225
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
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 407
      Width = 305
      Height = 6
      Align = alBottom
      Smooth = True
      TabOrder = 18
      Visible = False
    end
    object edtCodCfop: TEditFocus
      Tag = 99
      Left = 7
      Top = 325
      Width = 37
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
      MaxLength = 4
      ParentFont = False
      TabOrder = 10
      OnChange = edtCodCfopChange
      OnExit = edtCodCfopExit
      OnKeyPress = edtCodCfopKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesCfops: TEditFocus
      Left = 45
      Top = 325
      Width = 252
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
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
    Top = 442
    Width = 307
    ExplicitTop = 442
    ExplicitWidth = 307
    inherited pnlNomeForm: TPanel
      Left = 136
      ExplicitLeft = 136
    end
    inherited pnlInfo: TPanel
      Width = 136
      ExplicitWidth = 136
      inherited shpMultSel: TShape
        Left = 118
        Top = 2
        Height = 12
        Align = alRight
        Visible = True
        ExplicitLeft = 119
        ExplicitTop = 2
        ExplicitHeight = 12
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 567
    Top = 110
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 538
    Top = 110
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 184
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 608
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 572
    Top = 12
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 492
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 597
    Top = 190
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 548
    Top = 179
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 534
    Top = 10
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 540
    Top = 62
  end
  inherited frxGen: TfrxUserDataSet
    Left = 588
    Top = 62
  end
  inherited frxDesigner: TfrxDesigner
    Left = 464
    Top = 108
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 492
    Top = 58
  end
end
