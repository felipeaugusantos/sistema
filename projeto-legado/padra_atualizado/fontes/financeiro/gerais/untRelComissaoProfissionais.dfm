inherited frmRelComissaoProfissionais: TfrmRelComissaoProfissionais
  Left = 369
  Top = 200
  Width = 351
  Height = 658
  Caption = 'Relat'#243'rio de Comiss'#227'o de Profissionais'
  ExplicitTop = -74
  ExplicitWidth = 351
  ExplicitHeight = 658
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 587
    Width = 345
    TabOrder = 4
    ExplicitTop = 587
    ExplicitWidth = 345
    inherited FlwBotoes: TFlowPanel
      Width = 264
      ExplicitWidth = 264
    end
    inherited btnSair: TBitBtnLocked
      Left = 266
      ExplicitLeft = 266
    end
  end
  inherited pnlDados: TPanel
    Top = 193
    Width = 345
    Height = 394
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 193
    ExplicitWidth = 345
    ExplicitHeight = 394
    object Label3: TLabel [0]
      Left = 7
      Top = 39
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
    object lblEmpresa: TLabel [1]
      Left = 7
      Top = 150
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
    object Label5: TLabel [2]
      Left = 7
      Top = 1
      Width = 45
      Height = 14
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel [3]
      Left = 7
      Top = 76
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
    object Label11: TLabel [4]
      Left = 7
      Top = 114
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdgQuebra: TRadioGroup [5]
      Left = 7
      Top = 278
      Width = 153
      Height = 91
      Caption = 'Quebra por:'
      ItemIndex = 0
      Items.Strings = (
        'Profissional'
        'Data Faturamento'
        'Vendedor'
        'Empresa + Profissional'
        'Nome Profissional')
      TabOrder = 14
      OnClick = rdgQuebraClick
    end
    object rdgTipCom: TRadioGroup [6]
      Left = 166
      Top = 347
      Width = 169
      Height = 35
      Caption = 'Tipo de Comiss'#227'o:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Por Valor'
        'Por Pontos')
      TabOrder = 18
      OnClick = rdgQuebraClick
    end
    object gpbTipRel: TGroupBox [7]
      Left = 164
      Top = 277
      Width = 171
      Height = 46
      Caption = 'Tipo'
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
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipRel: TEditFocus
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
        OnExit = edtTipRelExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object rdgSitPro: TRadioGroup [8]
      Left = 7
      Top = 233
      Width = 153
      Height = 47
      Caption = 'Situa'#231#227'o do Profissional'
      Columns = 2
      ItemIndex = 2
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 12
    end
    inherited gpbDestino: TGroupBox
      Left = 164
      Top = 233
      Width = 171
      Height = 44
      TabOrder = 13
      ExplicitLeft = 164
      ExplicitTop = 233
      ExplicitWidth = 171
      ExplicitHeight = 44
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object edtCodCliente: TEditFocus
      Left = 7
      Top = 53
      Width = 68
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
      TabOrder = 2
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
      Left = 75
      Top = 53
      Width = 260
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 163
      Width = 30
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
      Left = 37
      Top = 163
      Width = 298
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
    object rdgOpcao: TRadioGroup
      Left = 7
      Top = 187
      Width = 153
      Height = 47
      Caption = 'Op'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Calculado na Venda'
        '% Cad. Diversos')
      TabOrder = 10
    end
    object edtDesAtividade: TEditFocus
      Left = 37
      Top = 15
      Width = 298
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
    object edtCodAtividade: TEditFocus
      Tag = 99
      Left = 7
      Top = 15
      Width = 30
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
      TabOrder = 0
      OnExit = edtCodAtividadeExit
      OnKeyPress = edtCodAtividadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodRede: TEditFocus
      Left = 7
      Top = 90
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      OnExit = edtCodRedeExit
      OnKeyPress = edtCodRedeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesRede: TEditFocus
      Left = 75
      Top = 90
      Width = 260
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbFiltro: TGroupBox
      Left = 164
      Top = 187
      Width = 171
      Height = 45
      Caption = 'Filtrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 16
        Width = 118
        Height = 14
        Caption = '(P)endentes (B)aixados '
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 63
        Top = 27
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtFiltro: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
    end
    object pgbGerArq: TProgressBar
      Left = 0
      Top = 387
      Width = 345
      Height = 7
      Align = alBottom
      Smooth = True
      TabOrder = 19
      Visible = False
    end
    object chkSaldoInicial: TCheckBox
      Left = 180
      Top = 327
      Width = 138
      Height = 17
      Caption = 'Calcular o saldo inicial?'
      Checked = True
      State = cbChecked
      TabOrder = 17
    end
    object edtFornecedor: TEditFocus
      Left = 7
      Top = 128
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
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
    object edtDesFornecedor: TEditFocus
      Left = 75
      Top = 128
      Width = 260
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkExcelSimples: TCheckBox
      Left = 22
      Top = 369
      Width = 120
      Height = 17
      Caption = 'Exporta'#231#227'o Simples'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 15
    end
  end
  inherited pnlStatus: TPanel
    Top = 613
    Width = 345
    TabOrder = 5
    ExplicitTop = 613
    ExplicitWidth = 345
    inherited pnlNomeForm: TPanel
      Left = 174
      TabOrder = 1
      ExplicitLeft = 174
    end
    inherited pnlInfo: TPanel
      Width = 174
      TabOrder = 0
      ExplicitWidth = 174
      inherited shpMultSel: TShape
        Left = 154
        Visible = True
        ExplicitLeft = 154
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 345
    Height = 157
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 3
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
    object lblDtaIni: TLabel
      Left = 80
      Top = 21
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
    object Label8: TLabel
      Left = 179
      Top = 3
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
    object Label6: TLabel
      Left = 251
      Top = 20
      Width = 56
      Height = 14
      Caption = '(BAIXADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 44
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
    object lblDtaFin: TLabel
      Left = 80
      Top = 61
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
    object Label9: TLabel
      Left = 179
      Top = 45
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
    object Label7: TLabel
      Left = 251
      Top = 61
      Width = 56
      Height = 14
      Caption = '(BAIXADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 7
      Top = 81
      Width = 56
      Height = 14
      Caption = 'Profissional'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 7
      Top = 118
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 17
      Width = 65
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
    object mskDtaBai: TMaskEditFocus
      Tag = 99
      Left = 179
      Top = 17
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 58
      Width = 67
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaBaf: TMaskEditFocus
      Tag = 99
      Left = 179
      Top = 58
      Width = 66
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodProfissional: TEditFocus
      Left = 7
      Top = 95
      Width = 68
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
      TabOrder = 4
      OnExit = edtCodProfissionalExit
      OnKeyPress = edtCodProfissionalKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomProfissional: TEditFocus
      Left = 75
      Top = 95
      Width = 260
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
    object edtCodVen: TEditFocus
      Left = 7
      Top = 132
      Width = 30
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
      TabOrder = 6
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesVen: TEditFocus
      Left = 37
      Top = 132
      Width = 298
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
  end
  object pnlVendedor2: TPanel [5]
    Left = 0
    Top = 157
    Width = 345
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label12: TLabel
      Left = 7
      Top = -2
      Width = 56
      Height = 14
      Caption = 'Vendedor 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodVe2: TEditFocus
      Left = 7
      Top = 13
      Width = 30
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
      TabOrder = 0
      OnExit = edtCodVe2Exit
      OnKeyPress = edtCodVe2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesVe2: TEditFocus
      Left = 37
      Top = 13
      Width = 298
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 128
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 344
    Top = 64
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 408
    Top = 96
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 376
    Top = 96
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 344
    Top = 96
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 504
    Top = 64
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 472
    Top = 64
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 376
    Top = 64
  end
  inherited frxGen: TfrxUserDataSet
    Left = 440
    Top = 64
  end
  inherited frxDesigner: TfrxDesigner
    Left = 472
    Top = 96
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 504
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 64
  end
  object frxPaginaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39525.600182083300000000
    ReportOptions.LastChange = 41968.715899548610000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '{ M A T R I C I A L }  '
      ''
      'Var'
      '  strCreDeb: String;'
      '  strCreDebSI: String;      '
      '  fltTotPro: Double;'
      '  fltTotProComi: Double;'
      '  fltTotEmp: Double;'
      '  fltTotEmpComi: Double;      '
      '  fltTotGer: Double;'
      '  fltTotGerComi: Double;      '
      '  fltTotGerSint: Double;'
      '  fltTotGerComiSint: Double;              '
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotPro := fltTotPro + <frxRelatorio."COM_VRVEND">;'
      '  fltTotGer := fltTotGer + <frxRelatorio."COM_VRVEND">;'
      '  fltTotProComi := fltTotProComi + <frxRelatorio."COM_VRCOMI">;'
      
        '  fltTotGerComi := fltTotGerComi + <frxRelatorio."COM_VRCOMI">; ' +
        '   '
      'end;'
      ''
      'procedure rlbSumarioGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotGer    := fltTotGer     + fRetSalVen;'
      '  fltTotGerComi:= fltTotGerComi + fRetSalCom;'
      ''
      '  fltTotPro := fltTotPro + fRetSalVen;       '
      '  '
      '  If fltTotPro < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotPro.Text    := FormatFloat('#39'#,##0.00'#39', fltTotPro);'
      
        '  rllCreDebPro.Text := strCreDeb;                               ' +
        '                            '
      ''
      
        '  fltTotEmp := fltTotEmp + fltTotPro;                           ' +
        '      '
      ''
      '  fltTotProComi := fltTotProComi + fRetSalCom;'
      '    '
      '  If fltTotProComi < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotProComi.Text:= FormatFloat('#39'#,##0.00'#39', fltTotProComi);'
      
        '  rllCreDebPro.Text := strCreDeb;                               ' +
        '                            '
      ''
      '  fltTotEmpComi := fltTotEmpComi + fltTotProComi;'
      ''
      
        '  If fltTotPro <> 0 Then                                        ' +
        '         '
      
        '    rdbTotPerCom1.Text := FormatFloat('#39'#,##0.00'#39', fltTotProComi ' +
        '/ fltTotPro * 100)'
      '  Else              '
      '    rdbTotPerCom1.Text := '#39'0,00'#39';  '
      '      '
      '  fltTotPro := 0;      '
      '  fltTotProComi := 0;  '
      'end;'
      ''
      'procedure rllSalVenOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltSalVen: Double;'
      'begin'
      
        '  fltSalVen := fRetSalVen;                                      ' +
        '  '
      '    '
      '  If fltSalVen < 0 Then'
      '  Begin              '
      '    strCreDebSI := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDebSI := '#39'C'#39';    '
      '    '
      '  rllSalVen.Text:= FormatFloat('#39'#,##0.00'#39', fltSalVen);'
      'end;'
      ''
      'procedure rllSalComOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltSalCom: Double;'
      'begin'
      
        '  fltSalCom := fRetSalCom;                                      ' +
        '  '
      '    '
      '  If fltSalCom < 0 Then'
      '  Begin              '
      '    strCreDebSI := '#39'D'#39';'
      '  End'
      '  Else            '
      '    strCreDebSI := '#39'C'#39';'
      '      '
      '  rllSalCom.Text:= FormatFloat('#39'#,##0.00'#39', fltSalCom);'
      '  rllCreDebSI.Text := strCreDebSI;    '
      'end;'
      ''
      'procedure rlbTituloGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  pCarregaSaldoInicial(<frxRelatorio."COM_CODPRO">);            ' +
        '       '
      'end;'
      ''
      'procedure rlbDetalheSintOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltValor: Double;'
      '    fltValorVenda: Double;'
      '    fltValorComissao: Double;        '
      'begin'
      '  pCarregaSaldoInicial(<frxRelatorio."COM_CODPRO">);'
      ''
      '  fltValor := fRetSalVen;'
      ''
      '  If fltValor < 0 Then'
      '    rdbVrVendSintSal.Text := FormatFloat('#39'#,##0.00 D'#39', fltValor)'
      '  Else'
      
        '    rdbVrVendSintSal.Text := FormatFloat('#39'#,##0.00 C'#39', fltValor)' +
        ';'
      ''
      '  fltValor := fRetSalCom;'
      ''
      '  If fltValor < 0 Then'
      '    rdbVrComiSintSal.Text := FormatFloat('#39'#,##0.00 D'#39', fltValor)'
      '  Else'
      
        '    rdbVrComiSintSal.Text := FormatFloat('#39'#,##0.00 C'#39', fltValor)' +
        ';'
      ''
      
        '  fltValorVenda := <frxRelatorio."COM_VRVEND"> + fRetSalVen;    ' +
        '                                          '
      ''
      '  fltTotGerSint := fltTotGerSint + fltValorVenda;'
      ''
      '  If fltValorVenda < 0 Then'
      
        '    rdbVrVendSint.Text := FormatFloat('#39'#,##0.00 D'#39', fltValorVend' +
        'a)'
      '  Else'
      
        '    rdbVrVendSint.Text := FormatFloat('#39'#,##0.00 C'#39', fltValorVend' +
        'a);'
      ''
      '  fltValorComissao  := <frxRelatorio."COM_VRCOMI"> + fRetSalCom;'
      '    '
      '  fltTotGerComiSint := fltTotGerComiSint + fltValorComissao;'
      ''
      '  If <frxRelatorio."COM_VRCOMI"> < 0 Then'
      
        '    rdbVrComiSint.Text := FormatFloat('#39'#,##0.00 D'#39', fltValorComi' +
        'ssao)'
      '  Else'
      
        '    rdbVrComiSint.Text := FormatFloat('#39'#,##0.00 C'#39', fltValorComi' +
        'ssao);'
      ''
      '  If fltValorVenda <> 0 Then                                 '
      
        '    rdbPerComSint.Text := FormatFloat('#39'#,##0.00'#39', fltValorComiss' +
        'ao / fltValorVenda * 100)'
      '  Else              '
      
        '    rdbPerComSint.Text := '#39'0,00'#39';                               ' +
        '    '
      'end;'
      ''
      'procedure rlbSumarioEmpresaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If fltTotEmpComi < 0 Then'
      '    strCreDeb := '#39'D'#39
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotEmpComi.Text:= FormatFloat('#39'#,##0.00'#39', fltTotEmpComi);'
      '  rllTotEmp.Text    := FormatFloat('#39'#,##0.00'#39', fltTotEmp);      '
      '  rllCreDebEmp.Text := strCreDeb;'
      ''
      
        '  If fltTotEmp <> 0 Then                                        ' +
        '         '
      
        '    rdbTotPerCom2.Text := FormatFloat('#39'#,##0.00'#39', fltTotEmpComi ' +
        '/ fltTotEmp * 100)'
      '  Else              '
      '    rdbTotPerCom2.Text := '#39'0,00'#39';  '
      ''
      '  fltTotEmpComi := 0;'
      '  fltTotEmp     := 0;'
      'end;'
      ''
      'procedure rlbSumarioSintOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If fltTotGerSint < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39' D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39' C'#39';    '
      '    '
      
        '  rllTotGerSint.Text    := FormatFloat('#39'#,##0.00'#39' + strCreDeb, f' +
        'ltTotGerSint);'
      ''
      '  If fltTotGerComiSint < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39' D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39' C'#39';    '
      '    '
      
        '  rllTotGerComSint.Text    := FormatFloat('#39'#,##0.00'#39' + strCreDeb' +
        ', fltTotGerComiSint);'
      ''
      
        '  If fltTotGerSint <> 0 Then                                    ' +
        '                            '
      
        '    rdbPerComGerSint.Text := FormatFloat('#39'#,##0.00'#39', fltTotGerCo' +
        'miSint / fltTotGerSint * 100)                               '
      '  Else          '
      '    rdbPerComGerSint.Text := '#39'0,00'#39';'
      ''
      '  fltTotGerSint     := 0;    '
      '  fltTotGerComiSint := 0;        '
      'end;'
      ''
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If fltTotGer < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotGer.Text    := FormatFloat('#39'#,##0.00'#39', fltTotGer);'
      
        '  rllCreDebGer.Text := strCreDeb;                               ' +
        '                            '
      ''
      '  If fltTotGerComi < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotComiGer.Text:= FormatFloat('#39'#,##0.00'#39', fltTotGerComi);'
      '  rllCreDebGer.Text := strCreDeb;'
      ''
      
        '  If fltTotGer <> 0 Then                                        ' +
        '         '
      
        '    rdbTotPerCom3.Text := FormatFloat('#39'#,##0.00'#39', fltTotGerComi ' +
        '/ fltTotGer * 100)'
      '  Else              '
      '    rdbTotPerCom3.Text := '#39'0,00'#39';  '
      ''
      '  fltTotGer := 0;    '
      '  fltTotGerComi := 0;  '
      'end;'
      ''
      'begin'
      '  strCreDeb     := '#39#39';'
      '  fltTotPro     := 0;'
      '  fltTotProComi := 0;'
      '  fltTotEmp     := 0;'
      '  fltTotEmpComi := 0;      '
      '  fltTotGer     := 0;    '
      '  fltTotGerComi := 0;'
      '  fltTotGerSint := 0;'
      '  fltTotGerComiSint:= 0;      '
      'end.  ')
    OnUserFunction = frxPaginaMUserFunction
    Left = 264
    Top = 88
    Datasets = <
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Top = 493.000000000000000000
        Width = 1257.600000000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxPaginaM.ChildDetVend
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 969.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 51.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMsgSaldoPro: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1036.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Obs: A opcao de quebra por [QUEBRA] nao exibe o saldo inicial do' +
              ' profissional.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllFilFor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1036.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          Memo.UTF8W = (
            
              '* Os valores exibidos no relat'#195#179'rio s'#195#163'o referentes aos itens do' +
              '(s) fornecedor(es) filtrado(s).')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Top = 221.000000000000000000
        Width = 1257.600000000000000000
        Child = frxPaginaM.ChildTituloVend
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 614.400000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[CODPRO]'
            '[CODCLI]'
            '[REDLOJ]'
            '[CODFOR]'
            '[VENDED]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[REFERENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 51.000000000000000000
          Width = 614.400000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[CODATI]'
            '[CODEMP]'
            '[TIPFIL]'
            '[STATUS]'
            '[VENDED2]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object rlbDetalheSint: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 850.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbDetalheSintOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo25: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_CODPRO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_NOMDIV"]-[frxRelatorio."ATI_DESATI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVrVendSint: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRVEND')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVrComiSint: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRCOMI')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVrVendSintSal: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRVEND')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbVrComiSintSal: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRCOMI')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_C_G_C_"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[fFormataFoneInterna(<frxRelatorio."DIV_CELULA">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_EMAIL_"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbPerComSint: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTituloSint: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 782.000000000000000000
        Width = 1257.600000000000000000
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOME DO PROFISSIONAL / ATIVIDADE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllValCom: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.INI.VENDA')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalIni: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.INI.COM.')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCpf: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CPF/CNPJ')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CELULAR')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'E-MAIL')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerComSint: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '(%)COM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTituloGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbTituloGrupoOnBeforePrint'
        Condition = 'frxRelatorio."COM_CODPRO"'
        object rllTitGrupo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PROFISSIONAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDesGrupo: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_CODPRO"]  [frxRelatorio."DIV_NOMDIV"]-[frxRel' +
              'atorio."ATI_DESATI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalCom: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalComOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALCOM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalVen: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalVenOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalTit: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SALDO INICIAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCreDebSI: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllCreDebSIOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'D/C')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 731.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotGer: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllCreDebGer: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'CREDEB')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotComiGer: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotPerCom3: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumarioSint: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 901.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbSumarioSintOnBeforePrint'
        object DMPMemo28: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotGerSint: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotGerComSint: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbPerComGerSint: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 612.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbSumarioGrupoOnBeforePrint'
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotalGrupoTit: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotPro: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTPRO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllCreDebPro: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'CREDEB')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotProComi: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTPRO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotPerCom1: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildTituloDtaCad: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 340.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        PrintChildIfInvisible = True
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'D/C')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBSERVACOES')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllComiss3: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PROFISSIONAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOC.  ESP EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerCom3: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '(%)COM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildTituloProfissional: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 289.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        Child = frxPaginaM.ChildTituloDtaCad
        PrintChildIfInvisible = True
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DTA CAD.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOC.  ESP EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'D/C')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBSERVACOES')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllComiss2: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerCom2: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '(%)COM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildTituloVend: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 238.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        Child = frxPaginaM.ChildTituloProfissional
        PrintChildIfInvisible = True
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DTA CAD.')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOC.  ESP EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'D/C')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBSERVACOES')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllComiss1: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PROFISSIONAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPerCom1: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '(%)COM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildDetDtaCad: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 578.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        PrintChildIfInvisible = True
        object DMPMemo56: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_NUMDOC"]-[frxRelatorio."COM_ESPDOC"]-[frxRela' +
              'torio."COM_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRCOMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."COM_CREDEB"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_OBSERV"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRVEND"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDED"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_NOMDIV"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbPerCom3: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxRelatorio."COM_VRVEND"> <> 0,<frxRelatorio."COM_VRCOMI' +
              '"> / <frxRelatorio."COM_VRVEND"> * 100, 0))]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildDetProfissional: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 544.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        Child = frxPaginaM.ChildDetDtaCad
        PrintChildIfInvisible = True
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_NUMDOC"]-[frxRelatorio."COM_ESPDOC"]-[frxRela' +
              'torio."COM_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRCOMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."COM_CREDEB"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_OBSERV"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRVEND"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDED"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbPerCom2: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxRelatorio."COM_VRVEND"> <> 0,<frxRelatorio."COM_VRCOMI' +
              '"> / <frxRelatorio."COM_VRVEND"> * 100, 0))]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildDetVend: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 510.000000000000000000
        Visible = False
        Width = 1257.600000000000000000
        Child = frxPaginaM.ChildDetProfissional
        PrintChildIfInvisible = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_NUMDOC"]-[frxRelatorio."COM_ESPDOC"]-[frxRela' +
              'torio."COM_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRCOMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."COM_CREDEB"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_OBSERV"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRVEND"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_NOMDIV"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbPerCom1: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxRelatorio."COM_VRVEND"> <> 0,<frxRelatorio."COM_VRCOMI' +
              '"> / <frxRelatorio."COM_VRVEND"> * 100, 0))]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTituloEmpresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxRelatorio."COM_CODEMP"'
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object rlbSumarioEmpresa: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 680.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbSumarioEmpresaOnBeforePrint'
        object DMPMemo63: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL EMPRESA:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotEmp: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCreDebEmp: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'CREDEB')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotEmpComi: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbTotPerCom2: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPaginaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39525.600182083300000000
    ReportOptions.LastChange = 42850.498200914350000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  strCreDeb: String;'
      '  strCreDebSI: String;      '
      '  fltTotPro: Double;'
      '  fltTotProComi: Double;'
      '  fltTotEmp: Double;'
      '  fltTotEmpComi: Double;      '
      '  fltTotGer: Double;'
      '  fltTotGerComi: Double;      '
      '  fltTotGerSint: Double;'
      '  fltTotGerComiSint: Double;'
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotPro := fltTotPro + <frxRelatorio."COM_VRVEND">;'
      '  fltTotGer := fltTotGer + <frxRelatorio."COM_VRVEND">;'
      '  fltTotProComi := fltTotProComi + <frxRelatorio."COM_VRCOMI">;'
      
        '  fltTotGerComi := fltTotGerComi + <frxRelatorio."COM_VRCOMI">; ' +
        '     '
      'end;'
      ''
      'procedure rlbSumarioGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotGer    := fltTotGer     + fRetSalVen;'
      '  fltTotGerComi:= fltTotGerComi + fRetSalCom;'
      ''
      '  fltTotPro := fltTotPro + fRetSalVen;       '
      '  '
      '  If fltTotPro < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotPro.Text    := FormatFloat('#39'#,##0.00'#39', fltTotPro);'
      
        '  rllCreDebPro.Text := strCreDeb;                               ' +
        '                            '
      ''
      
        '  fltTotEmp := fltTotEmp + fltTotPro;                           ' +
        '      '
      ''
      '  fltTotProComi := fltTotProComi + fRetSalCom;'
      '    '
      '  If fltTotProComi < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotProComi.Text:= FormatFloat('#39'#,##0.00'#39', fltTotProComi);'
      
        '  rllCreDebPro.Text := strCreDeb;                               ' +
        '                            '
      ''
      '  fltTotEmpComi := fltTotEmpComi + fltTotProComi;'
      ''
      
        '  If fltTotPro <> 0 Then                                        ' +
        '         '
      
        '    rdbTotPerCom1.Text := FormatFloat('#39'#,##0.00'#39', fltTotProComi ' +
        '/ fltTotPro * 100)'
      '  Else              '
      '    rdbTotPerCom1.Text := '#39'0,00'#39';  '
      '      '
      '  fltTotPro := 0;      '
      '  fltTotProComi := 0;  '
      'end;'
      '  '
      'procedure rllSalVenOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltSalVen: Double;'
      'begin'
      
        '  fltSalVen := fRetSalVen;                                      ' +
        '                      '
      
        '  rllSalVen.Text := FormatFloat('#39'#,##0.00'#39', fltSalVen);         ' +
        '             '
      'end;'
      ''
      'procedure rlbDetalheSintOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltValor: Double;'
      '    fltValorVenda: Double;'
      '    fltValorComissao: Double;        '
      'begin'
      '  pCarregaSaldoInicial(<frxRelatorio."COM_CODPRO">);'
      ''
      '  fltValor := fRetSalVen;'
      ''
      '  If fltValor < 0 Then'
      '    rdbVrVendSintSal.Text := FormatFloat('#39'#,##0.00 D'#39', fltValor)'
      '  Else'
      
        '    rdbVrVendSintSal.Text := FormatFloat('#39'#,##0.00 C'#39', fltValor)' +
        ';'
      ''
      '  fltValor := fRetSalCom;'
      ''
      '  If fltValor < 0 Then'
      '    rdbVrComiSintSal.Text := FormatFloat('#39'#,##0.00 D'#39', fltValor)'
      '  Else'
      
        '    rdbVrComiSintSal.Text := FormatFloat('#39'#,##0.00 C'#39', fltValor)' +
        ';'
      ''
      
        '  fltValorVenda := <frxRelatorio."COM_VRVEND"> + fRetSalVen;    ' +
        '                                          '
      ''
      '  fltTotGerSint := fltTotGerSint + fltValorVenda;'
      ''
      '  If fltValorVenda < 0 Then'
      
        '    rdbVrVendSint.Text := FormatFloat('#39'#,##0.00 D'#39', fltValorVend' +
        'a)'
      '  Else'
      
        '    rdbVrVendSint.Text := FormatFloat('#39'#,##0.00 C'#39', fltValorVend' +
        'a);'
      ''
      '  fltValorComissao  := <frxRelatorio."COM_VRCOMI"> + fRetSalCom;'
      '    '
      '  fltTotGerComiSint := fltTotGerComiSint + fltValorComissao;'
      ''
      '  If <frxRelatorio."COM_VRCOMI"> < 0 Then'
      
        '    rdbVrComiSint.Text := FormatFloat('#39'#,##0.00 D'#39', fltValorComi' +
        'ssao)'
      '  Else'
      
        '    rdbVrComiSint.Text := FormatFloat('#39'#,##0.00 C'#39', fltValorComi' +
        'ssao);'
      ''
      '  If fltValorVenda <> 0 Then                                 '
      
        '    rdbPerComSint.Text := FormatFloat('#39'#,##0.00'#39', fltValorComiss' +
        'ao / fltValorVenda * 100)'
      '  Else              '
      
        '    rdbPerComSint.Text := '#39'0,00'#39';                               ' +
        '    '
      'end;'
      ''
      'procedure rllSalComOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      '    fltSalCom: Double;'
      'begin'
      
        '  fltSalCom := fRetSalCom;                                      ' +
        '                      '
      '    '
      '  If fltSalCom < 0 Then'
      '  Begin              '
      '    strCreDebSI := '#39'D'#39';          '
      '  End'
      '  Else'
      '    strCreDebSI := '#39'C'#39';               '
      '    '
      '  rllSalCom.Text := FormatFloat('#39'#,##0.00'#39', fltSalCom);'
      '  rllCreDebSI.Text := strCreDebSI;      '
      'end;'
      '       '
      'procedure rlbSumarioEmpresaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If fltTotEmpComi < 0 Then'
      '    strCreDeb := '#39'D'#39
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotEmpComi.Text:= FormatFloat('#39'#,##0.00'#39', fltTotEmpComi);'
      '  rllTotEmp.Text    := FormatFloat('#39'#,##0.00'#39', fltTotEmp);      '
      '  rllCreDebEmp.Text := strCreDeb;'
      ''
      
        '  If fltTotEmp <> 0 Then                                        ' +
        '         '
      
        '    rdbTotPerCom2.Text := FormatFloat('#39'#,##0.00'#39', fltTotEmpComi ' +
        '/ fltTotEmp * 100)'
      '  Else              '
      '    rdbTotPerCom2.Text := '#39'0,00'#39';  '
      ''
      '  fltTotEmpComi := 0;'
      '  fltTotEmp     := 0;'
      'end;'
      ''
      'procedure rlbTituloGrupoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  pCarregaSaldoInicial(<frxRelatorio."COM_CODPRO">);  '
      'end;'
      ''
      'procedure rlbSumarioSintOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If fltTotGerSint < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39' D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39' C'#39';    '
      '    '
      
        '  rllTotGerSint.Text    := FormatFloat('#39'#,##0.00'#39' + strCreDeb, f' +
        'ltTotGerSint);'
      ''
      '  If fltTotGerComiSint < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39' D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39' C'#39';    '
      '    '
      
        '  rllTotGerComSint.Text    := FormatFloat('#39'#,##0.00'#39' + strCreDeb' +
        ', fltTotGerComiSint);'
      ''
      
        '  If fltTotGerSint <> 0 Then                                    ' +
        '                            '
      
        '    rdbPerComGerSint.Text := FormatFloat('#39'#,##0.00'#39', fltTotGerCo' +
        'miSint / fltTotGerSint * 100)                               '
      '  Else          '
      '    rdbPerComGerSint.Text := '#39'0,00'#39';'
      ''
      '  fltTotGerSint     := 0;    '
      '  fltTotGerComiSint := 0;        '
      'end;'
      ''
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If fltTotGer < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotGer.Text    := FormatFloat('#39'#,##0.00'#39', fltTotGer);'
      
        '  rllCreDebGer.Text := strCreDeb;                               ' +
        '                            '
      ''
      '  If fltTotGerComi < 0 Then'
      '  Begin              '
      '    strCreDeb := '#39'D'#39';'
      '  End                '
      '  Else'
      '    strCreDeb := '#39'C'#39';    '
      '    '
      '  rllTotComiGer.Text:= FormatFloat('#39'#,##0.00'#39', fltTotGerComi);'
      '  rllCreDebGer.Text := strCreDeb;'
      ''
      
        '  If fltTotGer <> 0 Then                                        ' +
        '         '
      
        '    rdbTotPerCom3.Text := FormatFloat('#39'#,##0.00'#39', fltTotGerComi ' +
        '/ fltTotGer * 100)'
      '  Else              '
      '    rdbTotPerCom3.Text := '#39'0,00'#39';  '
      ''
      '  fltTotGer := 0;    '
      '  fltTotGerComi := 0;  '
      'end;'
      ''
      'begin'
      '  strCreDeb        := '#39#39';'
      
        '  strCreDebSI      := '#39#39';                                       ' +
        '           '
      '  fltTotPro        := 0;'
      '  fltTotProComi    := 0;'
      '  fltTotEmp        := 0;'
      '  fltTotEmpComi    := 0;      '
      '  fltTotGer        := 0;    '
      '  fltTotGerComi    := 0;'
      '  fltTotGerSint    := 0;'
      '  fltTotGerComiSint:= 0;      '
      'end.')
    OnUserFunction = frxPaginaMUserFunction
    Left = 296
    Top = 88
    Datasets = <
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
    object qckPagina: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      LargeDesignHeight = True
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Top = 540.472790000000000000
        Width = 1201.134634000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxPaginaJ.ChildDetVend
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 41.559060000000000000
        Top = 1065.827460000000000000
        Width = 1201.134634000000000000
        object rllNomeForm: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          WordWrap = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 337.600000000000000000
          Top = 20.000000000000000000
          Width = 858.179530000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          WordWrap = False
        end
        object rllMsgSaldoPRo: TfrxMemoView
          Left = 1.881880000000000000
          Width = 645.694620000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Obs: A op'#231#227'o de quebra por [QUEBRA] nao exibe o saldo inicial do' +
              ' profissional.')
          ParentFont = False
          WordWrap = False
        end
        object rllFilFor: TfrxMemoView
          Left = 652.401980000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Visible = False
          Memo.UTF8W = (
            
              '* Os valores exibidos no relat'#243'rio s'#227'o referentes aos itens do(s' +
              ') fornecedor(es) filtrado(s).')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Top = 253.228510000000000000
        Width = 1201.134634000000000000
        Child = frxPaginaJ.ChildTituloVend
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 171.968523460000000000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 5.779530000000000000
          Top = 3.000000000000000000
          Width = 1192.063080000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 5.779530000000000000
          Top = 20.000000000000000000
          Width = 1190.929500000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 1031.800000000000000000
          Top = 3.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 1108.600000000000000000
          Top = 20.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 1017.286890000000000000
          Top = 20.000000000000000000
          Width = 91.313110000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 151.078850000000000000
          Width = 1194.331480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[REFERENTE]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133890000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODPRO]')
          WordWrap = False
        end
        object Memo72: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.031540000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODCLI]')
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[REDLOJ]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 608.504330000000000000
          Top = 49.133890000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CODATI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 608.504330000000000000
          Top = 68.031540000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo75: TfrxMemoView
          Left = 608.504330000000000000
          Top = 86.929190000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TIPFIL]')
          ParentFont = False
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 3.779530000000000000
          Top = 105.826840000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          Memo.UTF8W = (
            '[CODFOR]')
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 608.504330000000000000
          Top = 105.826840000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 124.724490000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          Memo.UTF8W = (
            '[VENDED]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 608.504330000000000000
          Top = 124.724490000000000000
          Width = 585.826771650000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VENDED2]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbDetalheSint: TfrxMasterData
        FillType = ftBrush
        Height = 39.677180000000000000
        Top = 918.425790000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbDetalheSintOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 39.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 5.779530000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_CODPRO"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 86.179530000000000000
          Width = 625.965430000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_NOMDIV"]-[frxRelatorio."ATI_DESATI"]')
          WordWrap = False
        end
        object rdbVrVendSint: TfrxMemoView
          Left = 934.129190000000000000
          Width = 90.708658980000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRVEND')
          WordWrap = False
        end
        object rdbVrComiSint: TfrxMemoView
          Left = 1029.733890000000000000
          Width = 98.267718980000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRCOMI')
          WordWrap = False
        end
        object rdbVrVendSintSal: TfrxMemoView
          Left = 721.480830000000000000
          Width = 102.047248980000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRVEND')
          WordWrap = False
        end
        object rdbVrComiSintSal: TfrxMemoView
          Left = 833.085530000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VRCOMI')
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 5.779530000000000000
          Top = 18.897662200000000000
          Width = 186.406370000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_C_G_C_"]')
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 196.645798660000000000
          Top = 18.897650000000000000
          Width = 159.949660000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[fFormataFoneInterna(<frxRelatorio."DIV_CELULA">)]')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 361.945118660000000000
          Top = 18.897662200000000000
          Width = 832.706000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_EMAIL_"]')
          WordWrap = False
        end
        object RDBPerComSint: TfrxMemoView
          Left = 1133.859000000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTituloSint: TfrxHeader
        FillType = ftBrush
        Height = 45.338590000000000000
        Top = 850.394250000000000000
        Width = 1201.134634000000000000
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
        object Shape2: TfrxShapeView
          Left = 3.779530000000000000
          Top = 0.677180000000000000
          Width = 1192.440944880000000000
          Height = 41.574830000000000000
          Fill.BackColor = clSilver
        end
        object Memo22: TfrxMemoView
          Left = 5.779530000000000000
          Top = 1.677180000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 93.738590000000000000
          Top = 1.677180000000000000
          Width = 618.406370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOME DO PROFISSIONAL')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 936.129190000000000000
          Top = 1.677180000000000000
          Width = 90.708658980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
        end
        object rllValCom: TfrxMemoView
          Left = 1031.733890000000000000
          Top = 1.677180000000000000
          Width = 98.267718980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 722.921770000000000000
          Top = 1.779530000000000000
          Width = 102.047248980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.INI.VENDA')
          WordWrap = False
        end
        object rllSalIni: TfrxMemoView
          Left = 834.526470000000000000
          Top = 1.779530000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.INI.COM.')
          WordWrap = False
        end
        object rllCpf: TfrxMemoView
          Left = 5.559060000000000000
          Top = 19.897650000000000000
          Width = 186.406370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CPF/CNPJ')
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 196.425328660000000000
          Top = 19.897650000000000000
          Width = 159.949660000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CELULAR')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 361.724648660000000000
          Top = 19.897650000000000000
          Width = 832.706000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'E-MAIL')
          WordWrap = False
        end
        object rllPerComSint: TfrxMemoView
          Left = 1133.859000000000000000
          Top = 1.677180000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '(%) COM')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 805.039890000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object Memo20: TfrxMemoView
          Left = 5.779530000000000000
          Top = 3.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
        end
        object rllTotGer: TfrxMemoView
          Left = 657.245640000000000000
          Top = 3.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
        end
        object rllCreDebGer: TfrxMemoView
          Left = 854.645640000000000000
          Top = 3.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CREDEB')
          ParentFont = False
          WordWrap = False
        end
        object rllTotComiGer: TfrxMemoView
          Left = 755.445640000000000000
          Top = 3.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
        end
        object rdbTotPerCom3: TfrxMemoView
          Left = 885.748610000000000000
          Top = 3.000000000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumarioSint: TfrxFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 982.677800000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbSumarioSintOnBeforePrint'
        object Memo28: TfrxMemoView
          Left = 5.779530000000000000
          Top = 4.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
        end
        object rllTotGerSint: TfrxMemoView
          Left = 936.129190000000000000
          Top = 4.000000000000000000
          Width = 90.708658980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
        end
        object Line6: TfrxLineView
          Left = 3.779530000000000000
          Top = 2.500000000000000000
          Width = 1194.331418980000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotGerComSint: TfrxMemoView
          Left = 1031.733890000000000000
          Top = 4.000000000000000000
          Width = 98.267718980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
        end
        object rdbPerComGerSint: TfrxMemoView
          Left = 1133.859000000000000000
          Top = 3.779530000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 28.322820000000000000
        Top = 687.874460000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbSumarioGrupoOnBeforePrint'
        object rllTotalGrupoTit: TfrxMemoView
          Left = 5.779530000000000000
          Top = 3.000000000000000000
          Width = 290.570130000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          ParentFont = False
          WordWrap = False
        end
        object rllTotPro: TfrxMemoView
          Left = 657.245640000000000000
          Top = 3.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTPRO')
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Top = 0.500000000000000000
          Width = 1192.440944880000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllCreDebPro: TfrxMemoView
          Left = 854.645640000000000000
          Top = 3.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CREDEB')
          ParentFont = False
          WordWrap = False
        end
        object rllTotProComi: TfrxMemoView
          Left = 755.445640000000000000
          Top = 3.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTPRO')
          WordWrap = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 25.015770000000000000
          Width = 1192.440944880000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rdbTotPerCom1: TfrxMemoView
          Left = 885.748610000000000000
          Top = 3.000000000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildTituloProfissional: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Visible = False
        Width = 1201.134634000000000000
        Child = frxPaginaJ.ChildTituloDtaCad
        PrintChildIfInvisible = True
        object Shape6: TfrxShapeView
          Left = 3.779530000000000000
          Width = 1192.440944880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo111: TfrxMemoView
          Left = 5.779530000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DT CAD.')
          WordWrap = False
        end
        object Memo116: TfrxMemoView
          Left = 854.645640000000000000
          Top = 1.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'D/C')
          ParentFont = False
          WordWrap = False
        end
        object Memo117: TfrxMemoView
          Left = 946.518120000000000000
          Top = 1.000000000000000000
          Width = 244.006370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBSERVACOES')
          WordWrap = False
        end
        object Memo118: TfrxMemoView
          Left = 657.245640000000000000
          Top = 1.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
        end
        object rllComiss2: TfrxMemoView
          Left = 755.445640000000000000
          Top = 1.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 476.220482200000000000
          Width = 80.579530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 64.141732280000000000
          Width = 149.291338580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 214.905533780000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
        end
        object rllPerCom2: TfrxMemoView
          Left = 885.748610000000000000
          Top = 1.000000000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '(%) COM')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildTituloVend: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 275.905690000000000000
        Visible = False
        Width = 1201.134634000000000000
        Child = frxPaginaJ.ChildTituloProfissional
        PrintChildIfInvisible = True
        object Shape5: TfrxShapeView
          Left = 3.779530000000000000
          Width = 1192.440944880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo87: TfrxMemoView
          Left = 5.779530000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DT CAD.')
          ParentFont = False
          WordWrap = False
        end
        object Memo88: TfrxMemoView
          Left = 64.141732280000000000
          Top = 1.000000000000000000
          Width = 149.291338580000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 214.954360000000000000
          Top = 1.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo106: TfrxMemoView
          Left = 854.645640000000000000
          Top = 1.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'D/C')
          ParentFont = False
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 946.518120000000000000
          Top = 1.000000000000000000
          Width = 244.006370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVACOES')
          ParentFont = False
          WordWrap = False
        end
        object Memo108: TfrxMemoView
          Left = 657.245640000000000000
          Top = 1.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          ParentFont = False
          WordWrap = False
        end
        object rllComiss1: TfrxMemoView
          Left = 755.445640000000000000
          Top = 1.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          ParentFont = False
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 475.842529450000000000
          Top = 0.968489290000000000
          Width = 114.595300000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PROFISSIONAL')
          ParentFont = False
          WordWrap = False
        end
        object rllPerCom1: TfrxMemoView
          Left = 885.748610000000000000
          Top = 1.000000000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '(%) COM')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildTituloDtaCad: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 366.614410000000000000
        Visible = False
        Width = 1201.134634000000000000
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Left = 3.779530000000000000
          Width = 1192.440944880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object Memo5: TfrxMemoView
          Left = 854.645640000000000000
          Top = 1.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'D/C')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 946.518120000000000000
          Top = 1.000000000000000000
          Width = 244.006370000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OBSERVACOES')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 657.245640000000000000
          Top = 1.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.VENDA')
          WordWrap = False
        end
        object rllComiss3: TfrxMemoView
          Left = 755.445640000000000000
          Top = 1.000000000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          WordWrap = False
        end
        object Memo120: TfrxMemoView
          Left = 369.370100710000000000
          Top = 0.968489290000000000
          Width = 80.579530000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 502.921240310000000000
          Top = 1.133858270000000000
          Width = 114.595300000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PROFISSIONAL')
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 144.529190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 153.921294020000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
        end
        object rllPerCom3: TfrxMemoView
          Left = 885.748610000000000000
          Top = 1.000000000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '(%) COM')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDetDtaCad: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 646.299630000000000000
        Visible = False
        Width = 1201.134634000000000000
        PrintChildIfInvisible = True
        object rllZebra3: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo134: TfrxMemoView
          Left = 755.445640000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRCOMI"]')
          WordWrap = False
        end
        object Memo135: TfrxMemoView
          Left = 854.645640000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."COM_CREDEB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo136: TfrxMemoView
          Left = 946.518120000000000000
          Width = 244.006370000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_OBSERV"]')
          WordWrap = False
        end
        object Memo137: TfrxMemoView
          Left = 657.245640000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRVEND"]')
          WordWrap = False
        end
        object Memo138: TfrxMemoView
          Left = 153.921291570000000000
          Width = 211.653533540000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
        end
        object Memo139: TfrxMemoView
          Left = 369.488154800000000000
          Width = 124.724363070000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDED"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 502.921240310000000000
          Width = 151.181073070000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_NOMDIV"]')
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 148.157548660000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_NUMDOC"]-[frxRelatorio."COM_ESPDOC"]-[frxRela' +
              'torio."COM_CODEMP"]')
          WordWrap = False
        end
        object rdbPerCom3: TfrxMemoView
          Left = 885.748610000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxRelatorio."COM_VRVEND"> <> 0,<frxRelatorio."COM_VRCOMI' +
              '"> / <frxRelatorio."COM_VRVEND"> * 100, 0))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDetProfissional: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 604.724800000000000000
        Visible = False
        Width = 1201.134634000000000000
        Child = frxPaginaJ.ChildDetDtaCad
        PrintChildIfInvisible = True
        object rllZebra2: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo121: TfrxMemoView
          Left = 5.779530000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."COM_DTACAD"]')
          WordWrap = False
        end
        object Memo125: TfrxMemoView
          Left = 755.445640000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRCOMI"]')
          WordWrap = False
        end
        object Memo126: TfrxMemoView
          Left = 854.645640000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."COM_CREDEB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo127: TfrxMemoView
          Left = 946.518120000000000000
          Width = 244.006370000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_OBSERV"]')
          WordWrap = False
        end
        object Memo128: TfrxMemoView
          Left = 657.245640000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRVEND"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 476.220470000000000000
          Width = 175.747992440000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDED"]')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 64.141732280000000000
          Width = 149.291338580000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_NUMDOC"]-[frxRelatorio."COM_ESPDOC"]-[frxRela' +
              'torio."COM_CODEMP"]')
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 214.905533780000000000
          Width = 258.897652440000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
        end
        object rdbPerCom2: TfrxMemoView
          Left = 885.748610000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxRelatorio."COM_VRVEND"> <> 0,<frxRelatorio."COM_VRCOMI' +
              '"> / <frxRelatorio."COM_VRVEND"> * 100, 0))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDetVend: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 563.149970000000000000
        Visible = False
        Width = 1201.134634000000000000
        Child = frxPaginaJ.ChildDetProfissional
        PrintChildIfInvisible = True
        object rllZebra1: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 5.779530000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."COM_DTACAD"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 64.141732280000000000
          Width = 149.291338580000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_NUMDOC"]-[frxRelatorio."COM_ESPDOC"]-[frxRela' +
              'torio."COM_CODEMP"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 755.445640000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRCOMI"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 854.645640000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."COM_CREDEB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 946.518120000000000000
          Width = 244.006370000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."COM_OBSERV"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 657.245640000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."COM_VRVEND"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 214.905533780000000000
          Width = 258.897652440000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          WordWrap = False
        end
        object Memo130: TfrxMemoView
          Left = 475.882190000000000000
          Width = 175.747992440000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DIV_NOMDIV"]')
          WordWrap = False
        end
        object rdbPerCom1: TfrxMemoView
          Left = 885.748610000000000000
          Width = 59.036240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(IIF(<frxRelatorio."COM_VRVEND"> <> 0,<frxRelatorio."COM_VRCOMI' +
              '"> / <frxRelatorio."COM_VRVEND"> * 100, 0))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTituloEmpresa: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574803150000000000
        Top = 411.968770000000000000
        Width = 1201.134634000000000000
        Condition = 'frxRelatorio."COM_CODEMP"'
        object Shape3: TfrxShapeView
          Left = 3.779530000000000000
          Width = 1192.440944880000000000
          Height = 37.795275590000000000
          Fill.BackColor = clInfoBk
        end
        object Memo3: TfrxMemoView
          Left = 5.779530000000000000
          Width = 79.445640000000000000
          Height = 37.795275590000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA:')
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 90.708720000000000000
          Width = 1099.313730000000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMEMP"]')
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbSumarioEmpresa: TfrxGroupFooter
        FillType = ftBrush
        Height = 41.574803150000000000
        Top = 740.787880000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbSumarioEmpresaOnBeforePrint'
        object Shape4: TfrxShapeView
          Left = 3.779530000000000000
          Width = 1192.440944880000000000
          Height = 37.795275590000000000
          Fill.BackColor = clInfoBk
        end
        object Memo14: TfrxMemoView
          Left = 5.779530000000000000
          Width = 291.099320000000000000
          Height = 37.795275590000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DA EMPRESA:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotEmp: TfrxMemoView
          Left = 657.245640000000000000
          Width = 96.377952760000000000
          Height = 37.795275590000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCreDebEmp: TfrxMemoView
          Left = 854.645640000000000000
          Width = 28.800000000000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CREDEB')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotEmpComi: TfrxMemoView
          Left = 755.445640000000000000
          Width = 96.377952760000000000
          Height = 37.795275590000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTGER')
          WordWrap = False
          VAlign = vaCenter
        end
        object rdbTotPerCom2: TfrxMemoView
          Left = 885.748610000000000000
          Width = 59.036240000000000000
          Height = 37.795275590000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PERCOM')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbTituloGrupo: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 41.574830000000000000
        ParentFont = False
        Top = 476.220780000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbTituloGrupoOnBeforePrint'
        Condition = 'frxRelatorio."COM_CODPRO"'
        object rllTitGrupo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 143.697650000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PROFISSIONAL:')
          WordWrap = False
        end
        object rllDesGrupo: TfrxMemoView
          Left = 152.266110000000000000
          Top = 3.779530000000000000
          Width = 1038.841250000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."COM_CODPRO"]  [frxRelatorio."DIV_NOMDIV"]-[frxRel' +
              'atorio."ATI_DESATI"]')
          WordWrap = False
        end
        object rllSalTit: TfrxMemoView
          Left = 534.693260000000000000
          Top = 20.677180000000000000
          Width = 105.902350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SALDO INICIAL:')
          WordWrap = False
        end
        object rllSalCom: TfrxMemoView
          Left = 755.445640000000000000
          Top = 20.677180000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalComOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
        end
        object rllSalVen: TfrxMemoView
          Left = 657.245640000000000000
          Top = 20.677180000000000000
          Width = 96.377952760000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalVenOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
        end
        object rllCreDebSI: TfrxMemoView
          Left = 854.645640000000000000
          Top = 20.677180000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'D/C')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxSaldo: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxSaldo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 344
    Top = 128
  end
end
