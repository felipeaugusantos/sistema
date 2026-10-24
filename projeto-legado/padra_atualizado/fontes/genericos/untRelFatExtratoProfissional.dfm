inherited frmRelFatExtratoProfissional: TfrmRelFatExtratoProfissional
  Width = 630
  Height = 373
  Caption = 'Extrato de Comiss'#227'o de Profissionais'
  ExplicitWidth = 630
  ExplicitHeight = 373
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 302
    Width = 624
    ExplicitTop = 302
    ExplicitWidth = 624
    inherited FlwBotoes: TFlowPanel
      Width = 543
      ExplicitTop = 2
      ExplicitWidth = 543
    end
    inherited btnSair: TBitBtnLocked
      Left = 545
      ExplicitLeft = 545
    end
  end
  inherited pnlDados: TPanel
    Width = 624
    Height = 302
    ExplicitWidth = 624
    ExplicitHeight = 302
    object lbl1: TLabel [0]
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
    object lblDtaIni: TLabel [1]
      Left = 79
      Top = 26
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
    object lbl2: TLabel [2]
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
    object lblDtaFin: TLabel [3]
      Left = 79
      Top = 64
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
    object lbl3: TLabel [4]
      Left = 179
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
    object lbl4: TLabel [5]
      Left = 179
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
    object lbl5: TLabel [6]
      Left = 248
      Top = 64
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
    object lbl6: TLabel [7]
      Left = 248
      Top = 26
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
    object lbl7: TLabel [8]
      Left = 8
      Top = 84
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
    object lbl8: TLabel [9]
      Left = 320
      Top = 84
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
    object lbl9: TLabel [10]
      Left = 8
      Top = 122
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
    object lbl10: TLabel [11]
      Left = 320
      Top = 122
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
    object lblEmpresa: TLabel [12]
      Left = 8
      Top = 160
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
    object lbl11: TLabel [13]
      Left = 431
      Top = 160
      Width = 182
      Height = 14
      Caption = 'Imprimir somente Comiss'#245'es acima de'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 466
      Top = 198
      Width = 150
      TabOrder = 17
      ExplicitLeft = 466
      ExplicitTop = 198
      ExplicitWidth = 150
      inherited edtDestino: TEditFocus
        Left = 8
        ExplicitLeft = 8
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
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
      Width = 68
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
    object mskDtaBai: TMaskEditFocus
      Tag = 99
      Left = 179
      Top = 22
      Width = 65
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
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
      Top = 60
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
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 8
      Top = 98
      Width = 60
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
      OnExit = edtCodProExit
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomPro: TEditFocus
      Left = 69
      Top = 98
      Width = 250
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
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 320
      Top = 98
      Width = 45
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
      OnExit = edtCodAtiExit
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAti: TEditFocus
      Left = 366
      Top = 98
      Width = 247
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 136
      Width = 60
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
      TabOrder = 8
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
      Left = 69
      Top = 136
      Width = 250
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
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 320
      Top = 136
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 10
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
    object edtNomRed: TEditFocus
      Left = 371
      Top = 136
      Width = 242
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 174
      Width = 45
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
      TabOrder = 12
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
    object edtNomEmp: TEditFocus
      Left = 54
      Top = 174
      Width = 265
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
    object rdgOpcao: TRadioGroup
      Left = 8
      Top = 198
      Width = 250
      Height = 45
      Caption = 'Op'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Calculado na Venda'
        '% Cad. Diversos')
      TabOrder = 14
    end
    object gpbFiltro: TGroupBox
      Left = 262
      Top = 198
      Width = 200
      Height = 45
      Caption = 'Filtrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 20
        Width = 156
        Height = 14
        Caption = '(P)endentes (B)aixados (T)odos'
        CorDestaque = clRed
      end
      object edtFiltro: TEditFocus
        Tag = 99
        Left = 8
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
    object edtValMin: TCurrencyEditFocus
      Left = 513
      Top = 174
      Margins.Left = 4
      Margins.Top = 1
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 100
    end
    object rdgTipCom: TRadioGroup
      Left = 8
      Top = 249
      Width = 250
      Height = 40
      Caption = 'Tipo de Comiss'#227'o:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Comiss'#227'o por Valor'
        'Comiss'#227'o por Pontos')
      TabOrder = 18
    end
    object rdgOrdena: TRadioGroup
      Left = 262
      Top = 249
      Width = 354
      Height = 40
      Caption = 'Ordem:'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Nome Profissional'
        'Cresc. p/ Pontos'
        'Decresc. p/ Pontos')
      TabOrder = 19
    end
  end
  inherited pnlStatus: TPanel
    Top = 328
    Width = 624
    ExplicitTop = 328
    ExplicitWidth = 624
    inherited pnlNomeForm: TPanel
      Left = 453
      ExplicitLeft = 453
    end
    inherited pnlInfo: TPanel
      Width = 453
      ExplicitWidth = 453
      inherited shpMultSel: TShape
        Left = 437
        ExplicitLeft = 437
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 392
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 456
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 424
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 584
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 552
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 520
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 456
  end
  inherited frxGen: TfrxUserDataSet
    Left = 488
  end
  inherited frxDesigner: TfrxDesigner
    Left = 520
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 552
    Top = 40
  end
end
