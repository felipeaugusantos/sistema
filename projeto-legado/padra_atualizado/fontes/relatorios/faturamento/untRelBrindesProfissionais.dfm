inherited frmRelBrindesProfissionais: TfrmRelBrindesProfissionais
  Left = 369
  Top = 200
  Width = 355
  Height = 701
  Caption = 'Relat'#243'rio de Brindes por Profissional'
  ExplicitTop = -136
  ExplicitWidth = 355
  ExplicitHeight = 701
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 629
    Width = 349
    TabOrder = 4
    ExplicitTop = 585
    ExplicitWidth = 349
    inherited btnSair: TBitBtnLocked
      Left = 265
      ExplicitLeft = 265
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 1
      ExplicitLeft = 1
    end
  end
  inherited pnlDados: TPanel
    Top = 162
    Width = 349
    Height = 359
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 162
    ExplicitWidth = 349
    ExplicitHeight = 359
    object Label3: TLabel [0]
      Left = 7
      Top = 37
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
      Top = 112
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
      Top = -1
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
    object Label14: TLabel [3]
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
    object Label7: TLabel [4]
      Left = 7
      Top = 150
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
    inherited gpbDestino: TGroupBox
      Left = 231
      Top = 299
      Width = 113
      Height = 50
      TabOrder = 15
      ExplicitLeft = 231
      ExplicitTop = 299
      ExplicitWidth = 113
      ExplicitHeight = 50
      inherited ColorLabel1: TColorLabel
        Top = 18
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitTop = 18
        ExplicitWidth = 36
      end
      object ColorLabel6: TColorLabel [1]
        Left = 28
        Top = 30
        Width = 68
        Height = 14
        Caption = '( I )mpressora'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 4
        Top = 21
        ExplicitLeft = 4
        ExplicitTop = 21
      end
    end
    object edtCodCliente: TEditFocus
      Left = 7
      Top = 51
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Top = 51
      Width = 269
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
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
      Top = 126
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 6
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
      Top = 126
      Width = 307
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
    object gpbTipRel: TGroupBox
      Left = 131
      Top = 299
      Width = 94
      Height = 50
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 17
        Width = 49
        Height = 14
        Caption = '(A)nal'#237'tico'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 29
        Width = 49
        Height = 14
        Caption = '(S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipRel: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
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
    object rdgOpcao: TRadioGroup
      Left = 7
      Top = 192
      Width = 90
      Height = 50
      Caption = 'Valor'
      ItemIndex = 0
      Items.Strings = (
        'Venda'
        'Custo')
      TabOrder = 10
    end
    object edtNomVendedor: TEditFocus
      Left = 75
      Top = 13
      Width = 269
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 7
      Top = 13
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object rdgAssoci: TRadioGroup
      Left = 103
      Top = 192
      Width = 241
      Height = 101
      Caption = 'Op'#231#227'o de Filtro'
      ItemIndex = 0
      Items.Strings = (
        'Todos os Brindes'
        'Brindes Associados a um Profissional'
        'Brindes N'#227'o Associados a um Profissional')
      TabOrder = 12
    end
    object rdgEmpresa: TRadioGroup
      Left = 7
      Top = 243
      Width = 90
      Height = 50
      Caption = 'Empresa de...'
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      ParentCtl3D = False
      TabOrder = 11
    end
    object edtCodRede: TEditFocus
      Left = 7
      Top = 89
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
      Top = 89
      Width = 269
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
    object gpb1: TGroupBox
      Left = 7
      Top = 299
      Width = 118
      Height = 50
      Caption = 'Cr'#233'dito / D'#233'bito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 18
        Width = 83
        Height = 14
        Caption = '(C)r'#233'dito (D)'#233'bito'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 47
        Top = 30
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtCreDeb: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
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
    end
    object edtCodMarca: TEditFocus
      Left = 7
      Top = 164
      Width = 59
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodMarcaExit
      OnKeyPress = edtCodMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 66
      Top = 164
      Width = 278
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
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
    Top = 657
    Width = 349
    TabOrder = 6
    ExplicitTop = 613
    ExplicitWidth = 349
    inherited pnlNomeForm: TPanel
      Left = 178
      TabOrder = 1
      ExplicitLeft = 178
    end
    inherited pnlInfo: TPanel
      Width = 178
      TabOrder = 0
      ExplicitWidth = 178
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 349
    Height = 122
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 0
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
      Top = 18
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
    object lblDtaFin: TLabel
      Left = 80
      Top = 58
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
    object Label1: TLabel
      Left = 7
      Top = 41
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
    object Label4: TLabel
      Left = 7
      Top = 82
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 14
      Width = 67
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
      Left = 7
      Top = 55
      Width = 68
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
    object edtCodProfissional: TEditFocus
      Left = 7
      Top = 96
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
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
      Top = 96
      Width = 269
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCodPar: TPanel [5]
    Left = 0
    Top = 122
    Width = 349
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label6: TLabel
      Left = 7
      Top = -1
      Width = 40
      Height = 14
      Caption = 'Parceiro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodPar: TEditFocus
      Tag = 99
      Left = 7
      Top = 13
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodParExit
      OnKeyPress = edtCodParKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPar: TEditFocus
      Left = 75
      Top = 13
      Width = 269
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
  end
  object pnlTipBri: TPanel [6]
    Left = 0
    Top = 521
    Width = 349
    Height = 109
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    ExplicitTop = 479
    object rdgAgrPor: TRadioGroup
      Left = 7
      Top = 2
      Width = 337
      Height = 46
      Caption = 'Agrupar por...'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Profissional'
        'Parceiro')
      TabOrder = 0
    end
    object gpbTipBri: TGroupBox
      Left = 7
      Top = 54
      Width = 337
      Height = 52
      Caption = 'Tipo de Brinde'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object clbTipBri: TColorLabel
        Left = 28
        Top = 27
        Width = 251
        Height = 14
        Caption = '(G)arantia (C)ortesia (R)evis'#227'o (M)ontagem (T)odos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtTipBri: TEditFocus
        Tag = 99
        Left = 7
        Top = 22
        Width = 18
        Height = 22
        Alignment = taCenter
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
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 160
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 448
    Top = 16
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 528
    Top = 208
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 528
    Top = 160
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 528
    Top = 112
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 528
    Top = 64
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 528
    Top = 16
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 312
    Top = 32
  end
  inherited frxGen: TfrxUserDataSet
    Left = 448
    Top = 112
  end
  inherited frxDesigner: TfrxDesigner
    Left = 608
    Top = 64
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 608
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 16
  end
  object frxPaginaM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39525.600182083300000000
    ReportOptions.LastChange = 41137.718212337960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '{ M A T R I C I A L }  '
      ''
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
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(<frxRelatorio."DET_NUM_PD">) = '#39#39') and'
      '    (Trim(<frxRelatorio."DET_ESP_PD">) = '#39#39') and'
      '    (Trim(<frxRelatorio."DET_EMP_PD">) = '#39#39') then              '
      '    Memo4.Text := '#39#39';                      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 224
    Top = 32
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
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DET_DTAENT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[frxRelatorio."DET_NUMDOC"]-[frxRelatorio."DET_ESPDOC"] [frxRela' +
              'torio."DET_CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]-[frxRelatorio."DET_DESCRI"]'
            '')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValDeb: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDEB"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DET_REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValCre: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTCRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo4: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[frxRelatorio."DET_NUM_PD"]-[frxRelatorio."DET_ESP_PD"] [frxRela' +
              'torio."DET_EMP_PD"]')
          WordWrap = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 629.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
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
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 854.400000000000000000
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
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
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
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PEDIDO-ESP-EMP')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'UNIDADE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTitValDeb: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR D'#201'BITO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllComiss: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTitValCre: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR CR'#201'DITO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DOCUMENTO-ESP-EMP')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        Stretched = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
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
          Left = 643.200000000000000000
          Top = 34.000000000000000000
          Width = 518.400000000000000000
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
        object rllFiltros: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Frame.Typ = [ftBottom]
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
            end
            item
            end
            item
            end>
        end
      end
      object rlbDetalheSint: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 527.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllDetSintetico: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODDIV"] [frxRelatorio."DIV_NOMDIV"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotalSin: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."DET_TOTCRE"> - <frxRelatorio."DET_TOTDEB">]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValDebSin: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDEB"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValCreSin: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTCRE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTituloSint: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 1257.600000000000000000
        object rllTitDetSintetico: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CODIGO / NOME DO PROFISSIONAL')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTitValCreSin: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CR'#201'DITO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTitValDebSin: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.D'#201'BITO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTitTotalSin: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTituloGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxRelatorio."DET_CODDIV"'
        object rllTituloGrupo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1075.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              'PROFISSIONAL:[frxRelatorio."DET_CODDIV"] [frxRelatorio."DIV_NOMD' +
              'IV"] ')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 408.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotGerBR: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalhes) - SUM(<frxRelatori' +
              'o."DET_TOTDEB">,rlbDetalhes)]'
            '')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumarioSint: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 561.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllGerTotalSin: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalheSint) - SUM(<frxRelat' +
              'orio."DET_TOTDEB">,rlbDetalheSint)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 323.000000000000000000
        Width = 1257.600000000000000000
        Stretched = True
        object LineSumGru: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotalGrupo: TfrxDMPMemoView
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
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllTotDeb: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTDEB">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotCre: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotal: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              'TOTAL: [SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalhes) - SUM(<frxR' +
              'elatorio."DET_TOTDEB">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPaginaJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.770000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39525.600182083300000000
    ReportOptions.LastChange = 41137.596920023100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
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
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(<frxRelatorio."DET_NUM_PD">) = '#39#39') and'
      '    (Trim(<frxRelatorio."DET_ESP_PD">) = '#39#39') and'
      '    (Trim(<frxRelatorio."DET_EMP_PD">) = '#39#39') then              '
      
        '    Memo12.Text := '#39#39';                                          ' +
        '                                                        '
      'end;'
      ''
      'begin'
      '  '
      'end.')
    Left = 272
    Top = 32
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
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.015748030000000000
        Top = 260.787570000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 34.015748030000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Memo.UTF8W = (
            '')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Width = 84.661417320000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DET_DTAENT"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 86.820470000000000000
          Width = 163.426840000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[frxRelatorio."DET_NUM_PD"]-[frxRelatorio."DET_ESP_PD"] - [frxRe' +
              'latorio."DET_EMP_PD"]')
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 417.017440000000000000
          Top = 17.007874019999970000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DET_REFERE"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 895.354360000000000000
          Top = 17.007874019999970000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Top = 17.007874019999970000
          Width = 415.748031500000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]-[frxRelatorio."DET_DESCRI"]')
          WordWrap = False
        end
        object rllValDeb: TfrxMemoView
          Left = 1083.424193230000000000
          Top = 17.007874019999970000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."DET_TOTDEB">]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 417.017440000000000000
          Width = 779.792580000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 798.039890000000000000
          Top = 17.007874019999970000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllValCre: TfrxMemoView
          Left = 964.780150000000000000
          Top = 17.007874019999970000
          Width = 117.165354330000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTCRE"]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 252.228510000000000000
          Width = 163.426840000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            
              '[frxRelatorio."DET_NUMDOC"]-[frxRelatorio."DET_ESPDOC"] - [frxRe' +
              'latorio."DET_CODEMP"]')
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 604.724800000000000000
        Width = 1201.134634000000000000
        object rllNomeForm: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.000000000000000000
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
          Top = 2.000000000000000000
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
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 45.354328270000000000
        Top = 147.401670000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 45.354328270000000000
          Fill.BackColor = clSilver
        end
        object Memo1: TfrxMemoView
          Top = 1.889763780000010000
          Width = 84.661417320000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA CAD.')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 86.820470000000000000
          Top = 1.889763780000010000
          Width = 163.426840000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 417.017440000000000000
          Top = 1.889763780000010000
          Width = 779.792580000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 895.354360000000000000
          Top = 25.354360000000010000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UNIDADE')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Top = 25.354360000000010000
          Width = 415.748031500000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          WordWrap = False
        end
        object rllTitValDeb: TfrxMemoView
          Left = 1083.424193230000000000
          Top = 25.354360000000010000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR D'#201'BITO')
          ParentFont = False
          WordWrap = False
        end
        object rllComiss: TfrxMemoView
          Left = 417.017440000000000000
          Top = 25.354360000000010000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 798.039890000000000000
          Top = 25.322849289999990000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
        end
        object rllTitValCre: TfrxMemoView
          Left = 964.780150000000000000
          Top = 25.322849289999990000
          Width = 117.165354330000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR CR'#201'DITO')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 252.228510000000000000
          Top = 1.889763780000010000
          Width = 163.426840000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 67.968459999999990000
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        Stretched = True
        object rllNomeEmpresa: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 7.559060000000000000
          Top = 20.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
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
          Left = 590.200000000000000000
          Top = 20.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
        end
        object rllFiltros: TfrxMemoView
          Left = 7.559060000000000000
          Top = 46.000000000000000000
          Width = 1185.486580000000000000
          Height = 16.984230000000000000
          StretchMode = smMaxHeight
          WordWrap = False
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
            end
            item
            end
            item
            end>
        end
      end
      object rlbDetalheSint: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 480.000310000000000000
        Width = 1201.134634000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllDetSintetico: TfrxMemoView
          Left = 5.779530000000000000
          Width = 862.942240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODDIV"] [frxRelatorio."DIV_NOMDIV"]')
          WordWrap = False
        end
        object rllTotalSin: TfrxMemoView
          Left = 1095.370073860000000000
          Width = 103.937012760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."DET_TOTCRE"> - <frxRelatorio."DET_TOTDEB">]')
          WordWrap = False
        end
        object rllValDebSin: TfrxMemoView
          Left = 987.457330000000000000
          Width = 100.157482760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDEB"]'
            '')
          WordWrap = False
        end
        object rllValCreSin: TfrxMemoView
          Left = 880.630490000000000000
          Width = 103.937012760000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTCRE"]')
          WordWrap = False
        end
      end
      object rlbTituloSint: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.661410000000000000
        ParentFont = False
        Top = 434.645950000000000000
        Width = 1201.134634000000000000
        object Shape2: TfrxShapeView
          Left = 3.779530000000000000
          Top = 0.677180000000021200
          Width = 1196.220474880000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDetSintetico: TfrxMemoView
          Left = 5.779530000000000000
          Top = 1.677180000000021000
          Width = 776.013050000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'C'#211'DIGO / NOME DO PROFISSIONAL')
          WordWrap = False
        end
        object rllTitTotalSin: TfrxMemoView
          Left = 1096.174830000000000000
          Top = 1.133858270000019000
          Width = 102.047248980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOTAL')
          WordWrap = False
        end
        object rllTitValCreSin: TfrxMemoView
          Left = 880.630490000000000000
          Top = 1.000000000000000000
          Width = 102.047248980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CR'#201'DITO')
          ParentFont = False
          WordWrap = False
        end
        object rllTitValDebSin: TfrxMemoView
          Left = 986.457330000000000000
          Top = 1.000000000000000000
          Width = 102.047248980000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.D'#201'BITO')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTituloGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 215.433210000000000000
        Width = 1201.134634000000000000
        Condition = 'frxRelatorio."DET_CODDIV"'
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 20.787401570000000000
          Fill.BackColor = clSilver
        end
        object rllTituloGrupo: TfrxMemoView
          Top = 2.000000000000000000
          Width = 1111.257330000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              'PROFISSIONAL: [frxRelatorio."DET_CODDIV"] [frxRelatorio."DIV_NOM' +
              'DIV"]')
          WordWrap = False
        end
      end
      object rlbSumario: TfrxFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 389.291590000000000000
        Width = 1201.134634000000000000
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
        object rllTotGerBR: TfrxMemoView
          Left = 974.425113860000000000
          Top = 3.000000000000000000
          Width = 224.881972760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalhes) - SUM(<frxRelatori' +
              'o."DET_TOTDEB">,rlbDetalhes)]')
          WordWrap = False
        end
      end
      object rlbSumarioSint: TfrxFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 521.575140000000100000
        Width = 1201.134634000000000000
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
        object Line6: TfrxLineView
          Left = 3.779530000000000000
          Top = 2.500000000000000000
          Width = 1194.331418980000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotGerSint: TfrxMemoView
          Left = 974.425113860000000000
          Top = 4.000000000000000000
          Width = 224.881972760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalheSint) - SUM(<frxRelat' +
              'orio."DET_TOTDEB">,rlbDetalheSint)]')
          WordWrap = False
        end
      end
      object rlbSumarioGrupo: TfrxGroupFooter
        FillType = ftBrush
        Height = 47.220470000000000000
        Top = 317.480520000000000000
        Width = 1201.134634000000000000
        object rllTotalGrupo: TfrxMemoView
          Left = 5.779530000000000000
          Top = 3.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Top = 0.500000000000000000
          Width = 1192.440944880000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotDeb: TfrxMemoView
          Left = 1083.424193230000000000
          Top = 3.000000000000000000
          Width = 113.385826770000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTDEB">,rlbDetalhes)]')
          WordWrap = False
        end
        object LineSumGru: TfrxLineView
          Left = 3.779530000000000000
          Top = 40.015769999999970000
          Width = 1192.440944880000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTotCre: TfrxMemoView
          Left = 964.780150000000000000
          Top = 3.779530000000022000
          Width = 117.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalhes)]')
          WordWrap = False
        end
        object rllTotal: TfrxMemoView
          Left = 964.780150000000000000
          Top = 22.677180000000020000
          Width = 232.441032760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              'TOTAL: [SUM(<frxRelatorio."DET_TOTCRE">,rlbDetalhes) - SUM(<frxR' +
              'elatorio."DET_TOTDEB">,rlbDetalhes)]')
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
    Left = 448
    Top = 160
  end
end
