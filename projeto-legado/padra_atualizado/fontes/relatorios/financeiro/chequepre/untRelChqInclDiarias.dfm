inherited frmRelChqInclDiarias: TfrmRelChqInclDiarias
  Left = 432
  Top = 202
  Width = 320
  Height = 456
  Caption = 'Relat'#243'rio de Inclus'#245'es Diarias de Cheques'
  OnDestroy = FormDestroy
  ExplicitWidth = 320
  ExplicitHeight = 456
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 387
    Width = 314
    ExplicitTop = 384
    ExplicitWidth = 314
    inherited btnSair: TBitBtnLocked
      Left = 229
      ExplicitLeft = 229
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
  inherited pnlStatus: TPanel
    Top = 415
    Width = 314
    ExplicitTop = 412
    ExplicitWidth = 314
    inherited pnlNomeForm: TPanel
      Left = 143
      ExplicitLeft = 143
    end
    inherited pnlInfo: TPanel
      Width = 143
      ExplicitWidth = 143
      inherited shpMultSel: TShape
        Left = 126
        ExplicitLeft = 126
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 314
    Height = 387
    ExplicitWidth = 314
    ExplicitHeight = 384
    object Label9: TLabel [0]
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
    object Label10: TLabel [1]
      Left = 106
      Top = 26
      Width = 115
      Height = 14
      Caption = '(DATA DE CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel [2]
      Left = 106
      Top = 64
      Width = 115
      Height = 14
      Caption = '(DATA DE CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 8
      Top = 8
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
    object Label1: TLabel [4]
      Left = 8
      Top = 84
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
    object lblEmpresa: TLabel [5]
      Left = 8
      Top = 210
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
    object lblCnpjCpf: TLabel [6]
      Left = 8
      Top = 128
      Width = 61
      Height = 14
      Caption = '1-Cnpj/2-Cpf'
    end
    object lblEmit: TLabel [7]
      Left = 8
      Top = 169
      Width = 40
      Height = 14
      Caption = 'Emitente'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 316
      Width = 145
      Height = 43
      TabOrder = 9
      ExplicitLeft = 8
      ExplicitTop = 316
      ExplicitWidth = 145
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Left = 27
        Top = 19
        ExplicitLeft = 27
        ExplicitTop = 19
      end
      inherited edtDestino: TEditFocus
        Top = 15
        ExplicitTop = 15
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 248
      Width = 298
      Height = 50
      Caption = 'Quebra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object ColorLabel2: TColorLabel
        Left = 27
        Top = 15
        Width = 225
        Height = 14
        Caption = '(1) Cadastro (2) Vencimento (3) C'#243'digo Cliente'
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel
        Left = 27
        Top = 30
        Width = 242
        Height = 14
        Caption = '(4) Nome Cliente (5) Num. Cheque (6) Lan'#231'amento'
        CorDestaque = clRed
      end
      object edtQuebra: TEditFocus
        Tag = 99
        Left = 7
        Top = 18
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
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
      Left = 8
      Top = 60
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
      ValidaData = False
    end
    object edtCliente: TEditFocus
      Left = 8
      Top = 98
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnExit = edtClienteExit
      OnKeyPress = edtClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 66
      Top = 98
      Width = 240
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
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
      Left = 8
      Top = 224
      Width = 35
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
      Left = 44
      Top = 224
      Width = 262
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbTelecheque: TGroupBox
      Left = 161
      Top = 316
      Width = 145
      Height = 43
      Caption = 'Telecheque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object ColorLabel4: TColorLabel
        Left = 27
        Top = 19
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object edtTelecheque: TEditFocus
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
    object chkVisPra: TCheckBox
      Tag = 99
      Left = 8
      Top = 300
      Width = 298
      Height = 17
      Caption = 'Imprimir Cheques '#192' Vista e '#192' Prazo separados'
      TabOrder = 8
      OnClick = chkVisPraClick
    end
    object edtValidaCnpjCpf: TEditFocus
      Tag = 99
      Left = 8
      Top = 141
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCnpjCpf: TMaskEditC_G_C_
      Tag = 99
      Left = 67
      Top = 141
      Width = 239
      Height = 22
      Color = 16768952
      EditMask = '999.999.999-99;0;'
      MaxLength = 14
      TabOrder = 4
      Text = ''
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomEmit: TEditFocus
      Tag = 99
      Left = 8
      Top = 182
      Width = 298
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 250
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 368
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 250
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 218
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 186
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 154
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 154
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 186
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 218
    Top = 40
  end
end
