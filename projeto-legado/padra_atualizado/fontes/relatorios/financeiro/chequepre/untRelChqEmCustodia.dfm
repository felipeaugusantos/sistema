inherited frmRelChqEmCustodia: TfrmRelChqEmCustodia
  Left = 371
  Top = 301
  Width = 358
  Height = 487
  Caption = 'Relat'#243'rio de Cheques em Cust'#243'dia'
  OnDestroy = FormDestroy
  ExplicitWidth = 358
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 415
    Width = 352
    ExplicitTop = 457
    ExplicitWidth = 352
    inherited btnSair: TBitBtnLocked
      Left = 269
      ExplicitLeft = 269
    end
    inherited btnConfigurar: TBitBtnLocked
      Width = 80
      ExplicitWidth = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 352
    Height = 415
    ExplicitWidth = 352
    ExplicitHeight = 457
    object Label9: TLabel [0]
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
    object lblDesDtaIni: TLabel [1]
      Left = 82
      Top = 72
      Width = 63
      Height = 14
      Caption = '(CUSTODIA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 82
      Top = 107
      Width = 63
      Height = 14
      Caption = '(CUSTODIA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 7
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
    object Label10: TLabel [4]
      Left = 7
      Top = 124
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
    object Label1: TLabel [5]
      Left = 7
      Top = 161
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
    object lblEmpresa: TLabel [6]
      Left = 7
      Top = 286
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
    object lbl1: TLabel [7]
      Left = 7
      Top = 323
      Width = 81
      Height = 14
      Caption = 'Lote de Cust'#243'dia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [8]
      Left = 151
      Top = 50
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
    object Label3: TLabel [9]
      Left = 151
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
    object Label4: TLabel [10]
      Left = 228
      Top = 71
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
    object Label5: TLabel [11]
      Left = 226
      Top = 108
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
    object lblCnpjCpf: TLabel [12]
      Left = 5
      Top = 204
      Width = 61
      Height = 14
      Caption = '1-Cnpj/2-Cpf'
    end
    object lblEmit: TLabel [13]
      Left = 7
      Top = 244
      Width = 40
      Height = 14
      Caption = 'Emitente'
    end
    inherited gpbDestino: TGroupBox
      Left = 166
      Top = 7
      Width = 173
      Height = 43
      TabOrder = 1
      ExplicitLeft = 166
      ExplicitTop = 7
      ExplicitWidth = 173
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Top = 18
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 18
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 15
        TamCampo = 1
        ExplicitTop = 15
      end
    end
    object gpbOrdem: TGroupBox
      Left = 7
      Top = 7
      Width = 154
      Height = 43
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
        Top = 18
        Width = 118
        Height = 14
        Caption = '(C)ust'#243'dia (V)encimento'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 65
      Width = 70
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
      Left = 7
      Top = 101
      Width = 70
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 7
      Top = 138
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 6
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPor: TEditFocus
      Left = 72
      Top = 138
      Width = 267
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliente: TEditFocus
      Left = 7
      Top = 176
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 8
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
      Left = 72
      Top = 176
      Width = 267
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 300
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
      Left = 37
      Top = 300
      Width = 302
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOpcChq: TRadioGroup
      Left = 7
      Top = 360
      Width = 332
      Height = 45
      Caption = 'Cheques'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Em Aberto'
        'Depositados')
      TabOrder = 15
    end
    object edtLotCus: TEditFocus
      Tag = 99
      Left = 7
      Top = 337
      Width = 91
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
      MaxLength = 12
      ParentFont = False
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object chkLotCus: TCheckBox
      Left = 154
      Top = 340
      Width = 185
      Height = 17
      Caption = 'Exibir n'#250'mero do Lote de Cust'#243'dia'
      TabOrder = 14
    end
    object mskDtaIniVen: TMaskEditFocus
      Tag = 99
      Left = 151
      Top = 64
      Width = 69
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
    object mskDtaFinVen: TMaskEditFocus
      Tag = 99
      Left = 151
      Top = 101
      Width = 70
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
      ValidaData = False
    end
    object edtNomEmit: TEditFocus
      Tag = 99
      Left = 7
      Top = 258
      Width = 331
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
    object edtValidaCnpjCpf: TEditFocus
      Tag = 99
      Left = 7
      Top = 216
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttNumerico
    end
    object mskCnpjCpf: TMaskEditC_G_C_
      Tag = 99
      Left = 72
      Top = 216
      Width = 267
      Height = 22
      Color = 16768952
      EditMask = '999.999.999-99;0;'
      MaxLength = 14
      TabOrder = 10
      Text = ''
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 443
    Width = 352
    ExplicitTop = 485
    ExplicitWidth = 352
    inherited pnlNomeForm: TPanel
      Left = 193
      Width = 159
      ExplicitLeft = 193
      ExplicitWidth = 159
    end
    inherited pnlInfo: TPanel
      Width = 193
      ExplicitWidth = 193
      inherited shpMultSel: TShape
        Left = 137
        ExplicitLeft = 137
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 144
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 488
    Top = 168
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 528
    Top = 120
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 496
    Top = 120
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 464
    Top = 120
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 432
    Top = 120
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 400
    Top = 120
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 336
    Top = 120
  end
  inherited frxGen: TfrxUserDataSet
    Left = 368
    Top = 120
  end
  inherited frxDesigner: TfrxDesigner
    Left = 424
    Top = 144
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 456
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 128
  end
end
