inherited frmRelFatComparatVenda: TfrmRelFatComparatVenda
  Left = 322
  Top = 174
  Width = 600
  Height = 720
  Caption = 'Relat'#243'rio de Comparativo de Vendas'
  OnClose = FormClose
  ExplicitWidth = 600
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 647
    Width = 594
    ExplicitTop = 647
    ExplicitWidth = 594
    inherited btnSair: TBitBtnLocked
      Left = 513
      ExplicitLeft = 513
    end
  end
  inherited pnlDados: TPanel
    Width = 594
    Height = 647
    ExplicitWidth = 594
    ExplicitHeight = 647
    object Label7: TLabel [0]
      Left = 497
      Top = 35
      Width = 72
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Somente Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [1]
      Left = 8
      Top = 1
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
    object lbl2: TLabel [2]
      Left = 87
      Top = 1
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
    object lbl3: TLabel [3]
      Left = 171
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
    object lbl4: TLabel [4]
      Left = 8
      Top = 77
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
    object lblEmpresa: TLabel [5]
      Left = 8
      Top = 402
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
    object lbl5: TLabel [6]
      Left = 8
      Top = 185
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
    object lbl6: TLabel [7]
      Left = 8
      Top = 257
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel [8]
      Left = 8
      Top = 329
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
    object lbl8: TLabel [9]
      Left = 8
      Top = 221
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
    object lbl9: TLabel [10]
      Left = 8
      Top = 113
      Width = 71
      Height = 14
      Caption = 'Representante'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel [11]
      Left = 8
      Top = 149
      Width = 132
      Height = 14
      Caption = 'Departamento do Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl11: TLabel [12]
      Left = 8
      Top = 438
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object lbl12: TLabel [13]
      Left = 91
      Top = 438
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object lbl13: TLabel [14]
      Left = 137
      Top = 438
      Width = 169
      Height = 14
      Caption = 'Tabela de Venda p/ Pre'#231'o Sugerido'
    end
    object lbl15: TLabel [15]
      Left = 8
      Top = 293
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
    object lbl16: TLabel [16]
      Left = 8
      Top = 365
      Width = 88
      Height = 14
      Caption = 'Linha/Grupo Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl17: TLabel [17]
      Left = 238
      Top = 365
      Width = 84
      Height = 14
      Caption = 'Linha/Grupo Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpVen: TShape [18]
      Left = 7
      Top = 91
      Width = 8
      Height = 22
    end
    object Label11: TLabel [19]
      Left = 8
      Top = 40
      Width = 39
      Height = 14
      Caption = 'Gerente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpGer: TShape [20]
      Left = 8
      Top = 54
      Width = 8
      Height = 22
    end
    object Label12: TLabel [21]
      Left = 257
      Top = 40
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Gerente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpSubGer: TShape [22]
      Left = 255
      Top = 54
      Width = 8
      Height = 20
    end
    inherited gpbDestino: TGroupBox
      Left = 297
      Top = 515
      Width = 194
      Height = 43
      TabOrder = 33
      ExplicitLeft = 297
      ExplicitTop = 515
      ExplicitWidth = 194
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
        ExplicitTop = 15
      end
    end
    object lstClaFis: TMemo
      Left = 497
      Top = 54
      Width = 91
      Height = 504
      TabStop = False
      Anchors = [akTop, akRight]
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
      ScrollBars = ssVertical
      TabOrder = 40
      WantReturns = False
      WordWrap = False
    end
    object chkPreCus: TCheckBox
      Left = 454
      Top = 606
      Width = 134
      Height = 17
      Caption = 'Exibir pre'#231'o de custo'
      TabOrder = 38
      WordWrap = True
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 15
      Width = 76
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
      Left = 87
      Top = 15
      Width = 78
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 15
      Top = 91
      Width = 58
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
      Left = 74
      Top = 91
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 416
      Width = 38
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
      TabOrder = 26
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
      Left = 47
      Top = 416
      Width = 444
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 27
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
      Top = 199
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
      TabOrder = 12
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
      Left = 74
      Top = 199
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
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
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 8
      Top = 271
      Width = 65
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
      TabOrder = 16
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Left = 74
      Top = 271
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 343
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 20
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 74
      Top = 343
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
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
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 8
      Top = 235
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 14
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
      Left = 74
      Top = 235
      Width = 417
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRep: TEditFocus
      Left = 8
      Top = 127
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodRepExit
      OnKeyPress = edtCodRepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesRep: TEditFocus
      Left = 74
      Top = 127
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 8
      Top = 163
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesDep: TEditFocus
      Left = 74
      Top = 163
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDocumento: TEditFocus
      Left = 8
      Top = 452
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ParentFont = False
      TabOrder = 28
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Left = 91
      Top = 452
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 29
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxTabPre: TComboBoxFocus
      Left = 137
      Top = 452
      Width = 171
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 30
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object rdgEmpresa: TRadioGroup
      Left = 297
      Top = 474
      Width = 194
      Height = 40
      Caption = 'Empresa de'
      Columns = 2
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      ParentCtl3D = False
      TabOrder = 32
    end
    object rdgOpcao: TRadioGroup
      Left = 7
      Top = 474
      Width = 286
      Height = 84
      Caption = 'Op'#231#227'o'
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico por Documento'
        'Sint'#233'tico por Vendedor'
        'Sint'#233'tico por Condi'#231#227'o/Forma de Pagto e Documento')
      ParentCtl3D = False
      TabOrder = 31
      OnClick = rdgOpcaoClick
    end
    object chkVendMenSug: TCheckBox
      Left = 8
      Top = 606
      Width = 429
      Height = 17
      Caption = 
        'Exibir somente documentos/itens que o valor vendido '#233' menor que ' +
        'o valor sugerido'
      Checked = True
      State = cbChecked
      TabOrder = 37
      WordWrap = True
    end
    object chkDiferenca: TCheckBox
      Left = 8
      Top = 572
      Width = 180
      Height = 25
      Caption = 'Exibir somente documentos/itens com diferen'#231'a'
      Checked = True
      State = cbChecked
      TabOrder = 34
      WordWrap = True
      OnClick = chkDiferencaClick
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 639
      Width = 592
      Height = 7
      Align = alBottom
      Smooth = True
      TabOrder = 41
      Visible = False
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 8
      Top = 307
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
      MaxLength = 6
      ParentFont = False
      TabOrder = 18
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 74
      Top = 307
      Width = 417
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
    object edtDesGruIni: TEditFocus
      Left = 66
      Top = 379
      Width = 170
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskGruIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 379
      Width = 53
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 22
      Text = ''
      OnKeyPress = mskGruIniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGruFin: TEditFocus
      Left = 296
      Top = 379
      Width = 195
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskGruFin: TMaskEditFocus
      Tag = 99
      Left = 238
      Top = 379
      Width = 53
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 24
      Text = ''
      OnKeyPress = mskGruFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object gpbDif: TGroupBox
      Left = 194
      Top = 558
      Width = 297
      Height = 45
      TabOrder = 35
      object lblEDif: TLabel
        Left = 204
        Top = 18
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = 'e'
        WordWrap = True
      end
      object lblTitDif: TLabel
        Left = 10
        Top = 18
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'Exibir diferen'#231'as entre:'
        WordWrap = True
      end
      object edtDifFin: TEditFocus
        Tag = 99
        Left = 216
        Top = 15
        Width = 71
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        Text = '0,00'
        OnEnter = edtDifIniEnter
        OnExit = edtDifIniExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#0.00'
      end
      object edtDifIni: TEditFocus
        Tag = 99
        Left = 128
        Top = 15
        Width = 71
        Height = 22
        Alignment = taRightJustify
        TabOrder = 0
        Text = '-999.999,99'
        OnEnter = edtDifIniEnter
        OnExit = edtDifIniExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#0.00'
      end
    end
    object rdgDif: TRadioGroup
      Left = 497
      Top = 558
      Width = 91
      Height = 45
      Caption = 'Exibir dif. em'
      ItemIndex = 0
      Items.Strings = (
        'Porcentual'
        'Valor')
      TabOrder = 36
    end
    object edtCodGer: TEditFocus
      Tag = 99
      Left = 16
      Top = 54
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
      TabOrder = 2
      OnExit = edtCodGerExit
      OnKeyPress = edtCodGerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGer: TEditFocus
      Left = 57
      Top = 54
      Width = 192
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSubGer: TEditFocus
      Tag = 99
      Left = 263
      Top = 53
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
      TabOrder = 4
      OnExit = edtCodSubGerExit
      OnKeyPress = edtCodSubGerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesSubGer: TEditFocus
      Left = 301
      Top = 53
      Width = 190
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
    object chkExibeOpeLiberacao: TCheckBox
      Left = 8
      Top = 622
      Width = 273
      Height = 17
      Caption = 'Exibir operador que realizou a libera'#231#227'o de pre'#231'o'
      TabOrder = 39
      WordWrap = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 675
    Width = 594
    ExplicitTop = 675
    ExplicitWidth = 594
    inherited pnlNomeForm: TPanel
      Left = 423
      TabOrder = 1
      ExplicitLeft = 423
    end
    inherited pnlInfo: TPanel
      Width = 423
      TabOrder = 0
      ExplicitWidth = 423
      inherited shpMultSel: TShape
        Left = 405
        Top = 2
        Height = 12
        Align = alRight
        ExplicitLeft = 377
        ExplicitTop = 2
        ExplicitHeight = 12
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 520
    Top = 32
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 384
    Top = 184
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 520
    Top = 80
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 416
    Top = 88
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 384
    Top = 88
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 416
    Top = 120
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 384
    Top = 120
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 384
    Top = 152
  end
  inherited frxGen: TfrxUserDataSet
    Left = 416
    Top = 152
  end
  inherited frxDesigner: TfrxDesigner
    Left = 488
    Top = 168
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 520
    Top = 168
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.Icon.Data = {
      0000010001002020000000000000A80800001600000028000000200000004000
      000001000800000000008004000000000000000000000001000000000000FFFF
      FF00FFFFFF00CEFFFF009CFFFF0063FFFF0031FFFF0031FFFF0000FFFF0000FF
      FF0042E7FF0042E7FF00FFCEFF00CECEFF009CCEFF009CCEFF0063CEFF0063CE
      FF0031CEFF0000CEFF0010ADFF0010ADFF00FF9CFF00FF9CFF00CE9CFF009C9C
      FF00639CFF00319CFF00319CFF00009CFF00009CFF006363FF000063FF000063
      FF000000FF00F7F7F700F7F7F700EFEFEF00E7E7E700E7E7E7000084E7000000
      E700DEDEDE00DEDEDE00D6D6D600D6D6D600FFFFCE00CEFFCE00CEFFCE0063FF
      CE0063FFCE00FFCECE00CECECE00CECECE009CCECE00FF9CCE00CE9CCE00CE9C
      CE009C9CCE009C9CCE00639CCE00319CCE00319CCE009C63CE009C63CE006363
      CE003131CE003131CE000031CE000031CE00FF00CE00FF00CE000000CE000000
      CE00C6C6C600BDBDBD00BDBDBD00B5B5B5000000B5000000B500ADADAD00A5A5
      A500A5A5A500FFFF9C00CEFF9C00CEFF9C00FFCE9C00CECE9C00CECE9C009CCE
      9C009CCE9C0063CE9C0063CE9C00FF9C9C00CE9C9C009C9C9C00639C9C00639C
      9C00009C9C00009C9C00FF639C00FF639C00CE639C00CE639C009C639C009C63
      9C0063639C0063639C0031639C0000639C0000639C0031319C0031009C003100
      9C0000009C0094949400949494008C8C8C008C8C8C0084848400848484000000
      84007B7B7B007B7B7B00737373006B6B6B006B6B6B0000006B0000006B00FFCE
      6300CECE63009CCE630063CE630063CE6300FF9C6300FF9C6300CE9C63009C9C
      6300639C6300639C6300FF636300FF636300CE6363009C636300636363003163
      63000063630000636300CE316300CE3163009C31630063316300633163000031
      63009C0063009C0063005A5A5A00525252005252520000005200000052004A4A
      4A004A4A4A0042424200424242003939390039393900FFFF3100FFFF3100FFCE
      3100FFCE3100CECE3100CECE31009CCE31009CCE3100FF9C3100FF9C3100CE9C
      3100CE9C31009C9C31009C9C3100FF633100CE6331009C63310063633100FF31
      3100CE313100CE3131009C313100633131003131310000313100003131009C00
      31009C0031006300310063003100310031003100310029292900212121002121
      2100181818000000180000001800101010000808080000FF000000E7000000CE
      000000B5000000B50000319C0000319C0000009C00000084000000840000006B
      0000FF630000FF630000CE630000CE6300009C6300009C630000636300006363
      0000006300000052000000520000FF310000FF310000CE3100009C3100006331
      000063310000313100000031000000180000FF000000E7000000E7000000CE00
      0000B5000000B50000009C00000084000000840000006B0000006B0000005200
      000052000000310000001800000018000000000000000000000000000000FDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFFCAFF7C79797C7979FDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFFCAB485EEFF79797979797CFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDFDCAB4B4B485EEEEFB7C797C797979FDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDFFB4B4B485EEEEEDEEFF79797C797979FDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDCAB4B4B485EEEEEDEEEEFB7C7979797979FDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFDFFB4B4B485EEEEEEEEEEEDFF7C797C7979FDFD
      FDFDFDFFFFFF7C797979797979FFB4B485EEEEEDEEEEEDEEFF797979FDFDFDFD
      FDFFECFFFFEEFF79797C7979FFB4B4B485EEEEEDEEEEEDEEFF79FDFDFDFDFDFF
      FFB4B4B4FFEEEEFB7C797979ECB4B4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFF
      B4B4B4B4C9EEEEEDFF7979FFFFB4B4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFD
      FFB4B4B4B4FFEEEEEDFFC9B4B48BB485EEEEEDEEEEEDEEFFFDFDFDFDFDFDFDFD
      FFB4B4B4B4ECEEFFCAB4B4B4B4B4B485EEEEEEEEEEEDFFFDFDFDFDFDFDFDFDFD
      FDFFB4B4B4FFC9B4B4B4B4B4B4B4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFD
      FDFFB4B4B4B4B4B4B4B4B4FFB4B4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFD
      FDFFB4B4B4B4B4B4B4FFFFFFB4B485EEEEEDEEEEEDEEFFFDFDFDFDFDFDFDFDFD
      FDFDFFB4B4B4B4ECFF8585FFB4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFDFD
      FDFDFFB4B4B4B4FFEEEE85CAB4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFDFD
      FDFDFDFFB4B4B4B4ECEEFFB4B4B485EEEEEEEEEEEDFFFDFDFDFDFDFDFDFDFDFD
      FDFDFDFFB4B4B4B4CAEEFFB4B485EEEEEDEEEEEDEEFFFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFFB4B4B4B4FFFFB4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFFB4B4B4B4FFCAB4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFFB4B4B4B4B4B4B485EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFFB4B4B4B4B4B485EEEEEDEEEEEDEEFFFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFFB4B4B4B4B45555EEEEEDEEEEEDFFFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFFB4B45555858555EEEEEDEEEEFAFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFF555585858B858555EEEEEDEEFFFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFF8585858585858555EEEEEDFFFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFF8585858585858555EEFFFDFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFF8585858585858555FFFDFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFF8585858585FFFFFDFDFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFF8585FFFFFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
      FDFDFDFDFDFDFDFDFDFDFDFDFFFFFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFFFF
      E00FFFFF8007FFFF0003FFFE0001FFFE0000FFFE0000F8000003E000000F8000
      003F8000003FC000003FC000007FE000007FE000007FE000007FF00000FFF000
      00FFF80000FFF80000FFFC0001FFFC0001FFFE0001FFFE0001FFFE0003FFFF00
      03FFFF0003FFFF8003FFFFC007FFFFE007FFFFF00FFFFFF83FFFFFFCFFFF}
    HintStyle.IconType = cxhiCustom
    HintStyle.Rounded = True
    Left = 384
    Top = 272
  end
end
