inherited frmRelChqRepassados: TfrmRelChqRepassados
  Left = 430
  Top = 233
  Width = 319
  Height = 443
  Caption = 'Relat'#243'rio de Cheques Repassados'
  OnDestroy = FormDestroy
  ExplicitWidth = 319
  ExplicitHeight = 443
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 371
    Width = 313
    ExplicitTop = 371
    ExplicitWidth = 313
    inherited btnSair: TBitBtnLocked
      Left = 230
      ExplicitLeft = 230
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      Width = 80
      ExplicitLeft = 81
      ExplicitWidth = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 313
    Height = 371
    ExplicitWidth = 313
    ExplicitHeight = 371
    object Label12: TLabel [0]
      Left = 8
      Top = 56
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
    object lblDesDtaIni: TLabel [1]
      Left = 98
      Top = 74
      Width = 55
      Height = 14
      Caption = '(REPASSE)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel [2]
      Left = 8
      Top = 94
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
    object lblDesDtaFin: TLabel [3]
      Left = 98
      Top = 112
      Width = 55
      Height = 14
      Caption = '(REPASSE)'
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
      Top = 132
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
    object Label1: TLabel [5]
      Left = 8
      Top = 170
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
    object Label2: TLabel [6]
      Left = 8
      Top = 288
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
    object lblEmpresa: TLabel [7]
      Left = 8
      Top = 326
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
    object Label13: TLabel [8]
      Left = 8
      Top = 206
      Width = 61
      Height = 14
      Caption = '1-Cnpj/2-Cpf'
    end
    object Label14: TLabel [9]
      Left = 8
      Top = 245
      Width = 40
      Height = 14
      Caption = 'Emitente'
    end
    inherited gpbDestino: TGroupBox
      Left = 164
      Top = 8
      Width = 140
      TabOrder = 1
      ExplicitLeft = 164
      ExplicitTop = 8
      ExplicitWidth = 140
      inherited ColorLabel1: TColorLabel
        Top = 18
        ExplicitTop = 18
      end
      inherited edtDestino: TEditFocus
        Top = 15
        ExplicitTop = 15
      end
    end
    object gpbOrdem: TGroupBox
      Left = 8
      Top = 8
      Width = 148
      Height = 45
      Caption = 'Ordem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel2: TColorLabel
        Left = 27
        Top = 20
        Width = 119
        Height = 14
        Caption = '(R)epasse (V)encimento'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
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
        Text = 'R'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 70
      Width = 87
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 108
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
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodFornecedor: TEditFocus
      Left = 8
      Top = 146
      Width = 63
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
    object edtDesFornecedor: TEditFocus
      Left = 72
      Top = 146
      Width = 235
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliente: TEditFocus
      Left = 8
      Top = 184
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
      TabOrder = 6
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
      Top = 184
      Width = 241
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 8
      Top = 302
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
      MaxLength = 5
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 10
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttInteiro
    end
    object edtDesPor: TEditFocus
      Left = 66
      Top = 302
      Width = 241
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 340
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
      TabOrder = 12
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
      Left = 66
      Top = 340
      Width = 241
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
    object edtNomEmit: TEditFocus
      Tag = 99
      Left = 8
      Top = 260
      Width = 299
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
    object edtValidaCnpjCpf: TEditFocus
      Tag = 99
      Left = 8
      Top = 219
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object mskCnpjCpf: TMaskEditC_G_C_
      Tag = 99
      Left = 66
      Top = 219
      Width = 241
      Height = 22
      Color = 16768952
      EditMask = '999.999.999-99;0;'
      MaxLength = 14
      TabOrder = 8
      Text = ''
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 399
    Width = 313
    ExplicitTop = 399
    ExplicitWidth = 313
    inherited pnlNomeForm: TPanel
      Left = 154
      Width = 159
      ExplicitLeft = 154
      ExplicitWidth = 159
    end
    inherited pnlInfo: TPanel
      Width = 154
      ExplicitWidth = 154
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 280
    Top = 72
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 248
    Top = 104
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 280
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 216
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 184
    Top = 40
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 216
    Top = 72
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 216
    Top = 104
  end
  inherited frxGen: TfrxUserDataSet
    Left = 184
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 72
  end
end
