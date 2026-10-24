inherited frmRelPosContabil: TfrmRelPosContabil
  Left = 320
  Top = 244
  Width = 353
  Height = 648
  Caption = 'Relat'#243'rio de Posi'#231#227'o Cont'#225'bil de Contas a Receber'
  OnDestroy = FormDestroy
  ExplicitWidth = 353
  ExplicitHeight = 648
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 576
    Width = 347
    ExplicitTop = 576
    ExplicitWidth = 347
    inherited btnSair: TBitBtnLocked
      Left = 264
      ExplicitLeft = 264
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 79
      Width = 83
      ExplicitLeft = 79
      ExplicitWidth = 83
    end
  end
  inherited pnlDados: TPanel
    Width = 347
    Height = 576
    ExplicitWidth = 347
    ExplicitHeight = 576
    object Label6: TLabel [0]
      Left = 6
      Top = 7
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
    object lblDtaFin: TLabel [1]
      Left = 78
      Top = 28
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpresa: TLabel [2]
      Left = 7
      Top = 127
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
    object Label1: TLabel [3]
      Left = 7
      Top = 238
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
    object lblPatExp: TLabel [4]
      Left = 8
      Top = 521
      Width = 114
      Height = 14
      Caption = 'Path p/ Gera'#231'ao do Txt:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel [5]
      Left = 7
      Top = 166
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
    object Label16: TLabel [6]
      Left = 7
      Top = 202
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
    object lblPortador: TLabel [7]
      Left = 7
      Top = 277
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [8]
      Left = 7
      Top = 352
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object Label3: TLabel [9]
      Left = 7
      Top = 45
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
    object Label5: TLabel [10]
      Left = 78
      Top = 63
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel [11]
      Left = 7
      Top = 87
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
    object Label8: TLabel [12]
      Left = 78
      Top = 105
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel [13]
      Left = 7
      Top = 316
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
    inherited gpbDestino: TGroupBox
      Top = 390
      Width = 182
      Height = 42
      TabOrder = 13
      ExplicitTop = 390
      ExplicitWidth = 182
      ExplicitHeight = 42
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 19
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitTop = 19
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 15
        OnExit = nil
        ExplicitTop = 15
      end
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 6
      Top = 21
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
      ValidaData = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 143
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
      TabOrder = 3
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
      Left = 67
      Top = 143
      Width = 269
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 196
      Top = 390
      Width = 141
      Height = 42
      Caption = 'Tipo'
      TabOrder = 14
      object ColorLabel2: TColorLabel
        Left = 31
        Top = 19
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 8
        Top = 15
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
    object edtCodAtividade: TEditFocus
      Tag = 99
      Left = 7
      Top = 253
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
      TabOrder = 7
      OnKeyPress = edtCodAtividadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAtividade: TEditFocus
      Left = 67
      Top = 253
      Width = 269
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox2: TGroupBox
      Left = 196
      Top = 437
      Width = 141
      Height = 42
      Caption = 'Duplicatas descontadas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ColorLabel3: TColorLabel
        Left = 29
        Top = 19
        Width = 102
        Height = 14
        Caption = '(S)im  (N)'#227'o  (T)odas'
        CorDestaque = clRed
      end
      object edtDescontadas: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
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
    object chkGerTxt: TCheckBox
      Left = 196
      Top = 482
      Width = 112
      Height = 17
      Caption = 'Gerar Arquivo TXT'
      TabOrder = 17
      OnClick = chkGerTxtClick
    end
    object pgbGerTxt: TProgressBar
      Left = 7
      Top = 561
      Width = 329
      Height = 10
      TabOrder = 20
    end
    object gpbOrdem: TGroupBox
      Left = 7
      Top = 437
      Width = 182
      Height = 83
      Caption = 'Ordem'
      TabOrder = 15
      object lbl1: TColorLabel
        Left = 30
        Top = 18
        Width = 144
        Height = 14
        Caption = '(C)'#243'digo Cliente + Vencimento'
        CorDestaque = clRed
      end
      object lbl2: TColorLabel
        Left = 30
        Top = 38
        Width = 104
        Height = 14
        Caption = '(D)ata de Vencimento'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 30
        Top = 57
        Width = 138
        Height = 14
        Caption = '(N)ome Cliente + Vencimento'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 35
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 7
      Top = 180
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 4
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
    object edtNomCli: TEditFocus
      Left = 67
      Top = 180
      Width = 269
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRede: TEditFocus
      Tag = 99
      Left = 7
      Top = 216
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 5
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
      Left = 67
      Top = 216
      Width = 269
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
      ParentFont = False
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Left = 7
      Top = 291
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortador: TEditFocus
      Left = 67
      Top = 291
      Width = 269
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
    object mskEspecie: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 367
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      EditMask = 'll-ll-ll-ll-ll-ll;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 17
      ParentShowHint = False
      ShowHint = False
      TabOrder = 12
      Text = '  -  -  -  -  -  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskVenIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 60
      Width = 65
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
      ValidaData = False
    end
    object mskVenFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 102
      Width = 66
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomVen: TEditFocus
      Left = 67
      Top = 330
      Width = 269
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 7
      Top = 330
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
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    inline fraPatExp: TfraDirectoryEditFocus
      Tag = 99
      Left = 9
      Top = 535
      TabOrder = 18
      Height = 24
      Width = 327
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      inherited edtDirectory: TEditFocus
        OnChange = fraPatExpedtDirectoryChange
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 604
    Width = 347
    ExplicitTop = 604
    ExplicitWidth = 347
    inherited pnlNomeForm: TPanel
      Left = 176
      ExplicitLeft = 176
    end
    inherited pnlInfo: TPanel
      Width = 176
      ExplicitWidth = 176
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 0
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 272
    Top = 0
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 144
    Top = 32
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 112
    Top = 32
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 240
    Top = 0
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 208
    Top = 0
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 176
    Top = 0
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 112
    Top = 0
  end
  inherited frxGen: TfrxUserDataSet
    Left = 144
    Top = 0
  end
  inherited frxDesigner: TfrxDesigner
    Left = 208
    Top = 32
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 240
    Top = 32
  end
  object svdExcel: TSaveDialog
    Filter = 'Planilha Excel|*.xls'
    Left = 314
    Top = 33
  end
end
