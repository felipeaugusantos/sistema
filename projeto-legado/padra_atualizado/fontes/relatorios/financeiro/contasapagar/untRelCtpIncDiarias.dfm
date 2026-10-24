inherited frmRelCtpIncDiarias: TfrmRelCtpIncDiarias
  Left = 405
  Top = 244
  Width = 373
  Height = 627
  Caption = 'Relat'#243'rio de Inclus'#245'es Di'#225'rias de Contas a Pagar'
  OnDestroy = FormDestroy
  ExplicitWidth = 373
  ExplicitHeight = 627
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 555
    Width = 367
    ExplicitTop = 555
    ExplicitWidth = 367
    inherited btnSair: TBitBtnLocked
      Left = 286
      ExplicitLeft = 286
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 5
      ExplicitLeft = 5
    end
    inherited btnConfigurar: TBitBtnLocked
      Width = 85
      ExplicitWidth = 85
    end
  end
  inherited pnlDados: TPanel
    Width = 367
    Height = 555
    ExplicitWidth = 367
    ExplicitHeight = 555
    object Label9: TLabel [0]
      Left = 14
      Top = 51
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
    object Label10: TLabel [1]
      Left = 14
      Top = 86
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
    object Label11: TLabel [2]
      Left = 81
      Top = 72
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
    object Label12: TLabel [3]
      Left = 81
      Top = 107
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
    object Label13: TLabel [4]
      Left = 14
      Top = 125
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
    object lblEmpresa: TLabel [5]
      Left = 14
      Top = 198
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
    object Label1: TLabel [6]
      Left = 14
      Top = 161
      Width = 39
      Height = 14
      Caption = 'Eventos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [7]
      Left = 207
      Top = 51
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
    object Label3: TLabel [8]
      Left = 207
      Top = 86
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
    object Label4: TLabel [9]
      Left = 275
      Top = 72
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
    object Label5: TLabel [10]
      Left = 275
      Top = 107
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
    object Label6: TLabel [11]
      Left = 14
      Top = 236
      Width = 78
      Height = 14
      Caption = 'Plano de Contas'
    end
    object Label7: TLabel [12]
      Left = 207
      Top = 4
      Width = 62
      Height = 14
      Caption = 'Compet'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 14
      Top = 275
      Width = 178
      TabOrder = 10
      ExplicitLeft = 14
      ExplicitTop = 275
      ExplicitWidth = 178
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 141
        Caption = '(V)'#237'deo  (I)mpressora (E)xcel'
        ExplicitTop = 19
        ExplicitWidth = 141
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 65
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 100
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
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodFornecedor: TEditFocus
      Left = 14
      Top = 139
      Width = 65
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
      TabOrder = 6
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 14
      Top = 212
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
    object edtDesFornecedor: TEditFocus
      Left = 80
      Top = 139
      Width = 273
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
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 55
      Top = 212
      Width = 298
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
    object edtCodEve: TEditFocus
      Left = 14
      Top = 174
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 7
      OnExit = edtCodEveExit
      OnKeyPress = edtCodEveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesEve: TEditFocus
      Left = 55
      Top = 174
      Width = 298
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIniVen: TMaskEditFocus
      Tag = 99
      Left = 207
      Top = 65
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
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFinVen: TMaskEditFocus
      Tag = 99
      Left = 207
      Top = 100
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
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object gpbBoleto: TGroupBox
      Left = 207
      Top = 275
      Width = 146
      Height = 45
      Caption = 'Veio boleto ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      object ColorLabel6: TColorLabel
        Left = 32
        Top = 18
        Width = 25
        Height = 14
        Caption = '(S)im'
        CorDestaque = clRed
      end
      object ColorLabel7: TColorLabel
        Left = 66
        Top = 18
        Width = 27
        Height = 14
        Caption = '(N)'#227'o'
        CorDestaque = clRed
      end
      object ColorLabel8: TColorLabel
        Left = 101
        Top = 18
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtBoleto: TEditFocus
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
    object gpbIncPrevis: TGroupBox
      Left = 14
      Top = 326
      Width = 178
      Height = 73
      Caption = 'Gerar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 15
        Width = 97
        Height = 14
        Caption = 'Apenas (P)revis'#245'es'
        CorDestaque = clRed
      end
      object ColorLabel4: TColorLabel
        Left = 28
        Top = 33
        Width = 80
        Height = 14
        Caption = '(S)em Previs'#245'es'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 51
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtIncPrevis: TEditFocus
        Tag = 99
        Left = 7
        Top = 30
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
    object mskCodCta: TMaskEditFocus
      Left = 14
      Top = 249
      Width = 55
      Height = 22
      EditMask = '99.99.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 9
      Text = ''
      OnExit = mskCodCtaExit
      OnKeyPress = mskCodCtaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesCta: TEditFocus
      Left = 72
      Top = 249
      Width = 281
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
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object ckbExiCenCust: TCheckBox
      Left = 14
      Top = 508
      Width = 252
      Height = 31
      Caption = 'Exibir descri'#231#227'o do Plano de Contas da Duplicata'
      TabOrder = 16
      WordWrap = True
    end
    object gpbTipRel: TGroupBox
      Left = 14
      Top = 443
      Width = 339
      Height = 63
      Caption = 'Tipo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      object lbl1: TColorLabel
        Left = 28
        Top = 37
        Width = 239
        Height = 14
        Caption = '(A)nal'#237'tico, com os registros do desmembramento'
        CorDestaque = clRed
      end
      object lbl2: TColorLabel
        Left = 28
        Top = 19
        Width = 228
        Height = 14
        Caption = '(S)int'#233'tico, somente registro do Contas a Pagar'
        CorDestaque = clRed
      end
      object edtTipRel: TEditFocus
        Tag = 99
        Left = 7
        Top = 24
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object GroupBox1: TGroupBox
      Left = 207
      Top = 326
      Width = 146
      Height = 45
      Caption = 'Uso / Consumo ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      object ColorLabel9: TColorLabel
        Left = 32
        Top = 18
        Width = 25
        Height = 14
        Caption = '(S)im'
        CorDestaque = clRed
      end
      object ColorLabel10: TColorLabel
        Left = 66
        Top = 18
        Width = 27
        Height = 14
        Caption = '(N)'#227'o'
        CorDestaque = clRed
      end
      object ColorLabel11: TColorLabel
        Left = 101
        Top = 18
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtUsoCon: TEditFocus
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
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 207
      Top = 19
      Width = 51
      Height = 22
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object gpbContas: TGroupBox
      Left = 14
      Top = 4
      Width = 172
      Height = 42
      Caption = 'Contas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel3: TColorLabel
        Left = 27
        Top = 19
        Width = 130
        Height = 14
        Caption = '(T)odos (A)berto (Q)uitado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtContas: TEditFocus
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
    object rdgTipVal: TRadioGroup
      Left = 14
      Top = 399
      Width = 339
      Height = 38
      Caption = 'Considerar'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Valor Pago'
        'Valor da Duplicata')
      TabOrder = 14
    end
  end
  inherited pnlStatus: TPanel
    Top = 583
    Width = 367
    ExplicitTop = 583
    ExplicitWidth = 367
    inherited pnlNomeForm: TPanel
      Left = 196
      ExplicitLeft = 196
    end
    inherited pnlInfo: TPanel
      Width = 196
      ExplicitWidth = 196
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
    Top = 224
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 192
    Top = 176
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 272
    Top = 224
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 272
    Top = 136
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 312
    Top = 224
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 152
    Top = 224
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 312
    Top = 136
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 152
    Top = 176
  end
  inherited frxGen: TfrxUserDataSet
    Left = 232
    Top = 136
  end
  inherited frxDesigner: TfrxDesigner
    Left = 312
    Top = 176
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 192
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 224
  end
  object svdExcel: TSaveDialog
    Filter = 'Planilha Excel|*.xls'
    Left = 272
    Top = 176
  end
end
