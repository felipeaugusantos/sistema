inherited frmRelFatRelOrc: TfrmRelFatRelOrc
  Left = 447
  Top = 360
  Width = 329
  Height = 671
  Caption = 'Relat'#243'rio de Or'#231'amentos'
  ExplicitWidth = 329
  ExplicitHeight = 671
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 599
    Width = 323
    TabOrder = 4
    ExplicitTop = 553
    ExplicitWidth = 327
    inherited btnSair: TBitBtnLocked
      Left = 238
      ExplicitLeft = 242
    end
    inherited btnImprimir: TBitBtnLocked
      Left = -2
      ExplicitLeft = 2
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 75
      ExplicitLeft = 79
    end
  end
  inherited pnlDados: TPanel
    Width = 323
    Height = 488
    Align = alTop
    BevelOuter = bvNone
    ExplicitWidth = 327
    ExplicitHeight = 488
    object Label11: TLabel [0]
      Left = 7
      Top = 38
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
      Left = 78
      Top = 20
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 78
      Top = 57
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
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
      Top = 2
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
    object lblEmpresa: TLabel [4]
      Left = 7
      Top = 294
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
    object Label1: TLabel [5]
      Left = 7
      Top = 145
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
    object Label2: TLabel [6]
      Left = 7
      Top = 74
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
    object Label16: TLabel [7]
      Left = 7
      Top = 110
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
    object Label4: TLabel [8]
      Left = 7
      Top = 220
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
    object Label3: TLabel [9]
      Left = 7
      Top = 258
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
    object Label7: TLabel [10]
      Left = 7
      Top = 182
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
    inherited gpbDestino: TGroupBox
      Top = 372
      Width = 142
      Height = 63
      TabOrder = 17
      ExplicitTop = 372
      ExplicitWidth = 142
      ExplicitHeight = 63
      inherited ColorLabel1: TColorLabel
        Left = 35
        Top = 12
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitLeft = 35
        ExplicitTop = 12
        ExplicitWidth = 36
      end
      object ColorLabel2: TColorLabel [1]
        Left = 35
        Top = 45
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel [2]
        Left = 35
        Top = 28
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 8
        Top = 26
        OnExit = nil
        ExplicitLeft = 8
        ExplicitTop = 26
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 16
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
      Left = 7
      Top = 52
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
      ValidaData = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 308
      Width = 31
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
      TabOrder = 14
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
      Left = 39
      Top = 308
      Width = 282
      Height = 22
      Alignment = taLeftJustify
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
    object edtCodVendedor: TEditFocus
      Left = 7
      Top = 159
      Width = 66
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
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 74
      Top = 159
      Width = 247
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
    object gpbTipo: TGroupBox
      Left = 7
      Top = 329
      Width = 142
      Height = 43
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object lbl5: TColorLabel
        Left = 29
        Top = 20
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
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
    object edtCodCliente: TEditFocus
      Left = 7
      Top = 88
      Width = 66
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
      Left = 74
      Top = 88
      Width = 247
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
    object gpbSituacao: TGroupBox
      Left = 152
      Top = 329
      Width = 169
      Height = 106
      Caption = 'Situa'#231#227'o'
      TabOrder = 18
      object lbTodos: TColorLabel
        Left = 31
        Top = 15
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object lbFaturados: TColorLabel
        Left = 31
        Top = 38
        Width = 71
        Height = 14
        Caption = '(J)'#225' Faturados'
        CorDestaque = clRed
      end
      object lbNaoFaturados: TColorLabel
        Left = 31
        Top = 61
        Width = 79
        Height = 14
        Caption = '(N)'#227'o Faturados'
        CorDestaque = clRed
      end
      object lbBaixadosNaoFat: TColorLabel
        Left = 31
        Top = 85
        Width = 127
        Height = 14
        Caption = '(B)aixados N'#227'o Faturados'
        CorDestaque = clRed
      end
      object edtSituacao: TEditFocus
        Tag = 99
        Left = 7
        Top = 43
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
    object edtCodRede: TEditFocus
      Left = 7
      Top = 124
      Width = 66
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
      Left = 74
      Top = 124
      Width = 247
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
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 234
      Width = 66
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 10
      Text = ''
      OnEnter = mskLinhaGrupoEnter
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 74
      Top = 234
      Width = 247
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
    object mskLinhaGrupo2: TMaskEditFocus
      Left = 7
      Top = 272
      Width = 66
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 12
      Text = ''
      OnExit = mskLinhaGrupo2Exit
      OnKeyPress = mskLinhaGrupo2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo2: TEditFocus
      Left = 74
      Top = 272
      Width = 247
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
    object edtDesRepresentante: TEditFocus
      Left = 74
      Top = 197
      Width = 247
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
    object edtCodRepresentante: TEditFocus
      Left = 7
      Top = 197
      Width = 66
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
      OnExit = edtCodRepresentanteExit
      OnKeyPress = edtCodRepresentanteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object gpbVendedor: TGroupBox
      Left = 7
      Top = 437
      Width = 314
      Height = 41
      Caption = 'Op'#231#227'o de Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      object lblVendedor: TColorLabel
        Left = 31
        Top = 19
        Width = 146
        Height = 14
        Caption = '(1)Vendedor 1  (2)Vendedor 2'
        CorDestaque = clRed
      end
      object edtVendedor: TEditFocus
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
  end
  object pnlDados2: TPanel [3]
    Left = 0
    Top = 555
    Width = 323
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 509
    ExplicitWidth = 327
    object chkMsgs: TCheckBox
      Left = 7
      Top = 17
      Width = 202
      Height = 17
      Caption = 'Imprimir as mensagens do or'#231'amento'
      TabOrder = 1
    end
    object chkAgrVend: TCheckBox
      Left = 7
      Top = 2
      Width = 131
      Height = 17
      Caption = 'Agrupar por Vendedor'
      TabOrder = 0
    end
  end
  object pnlOcorrencia: TPanel [4]
    Left = 0
    Top = 484
    Width = 323
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 1
    ExplicitTop = 438
    ExplicitWidth = 327
    object Label5: TLabel
      Left = 7
      Top = -2
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
    object edtCodOco: TEditFocus
      Left = 7
      Top = 12
      Width = 31
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
      OnExit = edtCodOcoExit
      OnKeyPress = edtCodOcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesOco: TEditFocus
      Left = 39
      Top = 12
      Width = 282
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object pbProgresso: TProgressBar [5]
    Left = 0
    Top = 589
    Width = 323
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
    ExplicitTop = 543
    ExplicitWidth = 327
  end
  object pnlFaseObra: TPanel [6]
    Left = 0
    Top = 519
    Width = 323
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 473
    ExplicitWidth = 327
    object Label6: TLabel
      Left = 7
      Top = -1
      Width = 66
      Height = 14
      Caption = 'Fase da Obra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodFase: TEditFocus
      Left = 7
      Top = 13
      Width = 41
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
      OnExit = edtCodFaseExit
      OnKeyPress = edtCodFaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesFase: TEditFocus
      Left = 49
      Top = 13
      Width = 271
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  inherited pnlStatus: TPanel
    Top = 627
    Width = 323
    TabOrder = 5
    ExplicitTop = 581
    ExplicitWidth = 327
    inherited pnlNomeForm: TPanel
      Left = 152
      ExplicitLeft = 156
    end
    inherited pnlInfo: TPanel
      Width = 152
      ExplicitWidth = 156
      inherited shpMultSel: TShape
        Left = 130
        ExplicitLeft = 130
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 104
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 328
    Top = 104
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 360
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 328
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 360
    Top = 136
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 328
    Top = 136
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 360
    Top = 168
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 360
    Top = 200
  end
  inherited frxGen: TfrxUserDataSet
    Left = 328
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 72
  end
end
