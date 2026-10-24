inherited frmRelCtrCartoes: TfrmRelCtrCartoes
  Left = 400
  Top = 228
  Width = 454
  Height = 709
  Caption = 'Relat'#243'rio de Cart'#245'es'
  OnDestroy = FormDestroy
  ExplicitTop = -263
  ExplicitWidth = 454
  ExplicitHeight = 709
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 640
    Width = 448
    ExplicitTop = 640
    ExplicitWidth = 428
    inherited btnSair: TBitBtnLocked
      Left = 369
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 349
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 90
      Height = 24
      Align = alLeft
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 90
      ExplicitHeight = 24
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 92
      Top = 2
      Width = 90
      Height = 24
      Align = alLeft
      ExplicitLeft = 92
      ExplicitTop = 2
      ExplicitWidth = 90
      ExplicitHeight = 24
    end
  end
  inherited pnlDados: TPanel
    Width = 448
    Height = 640
    ExplicitWidth = 428
    ExplicitHeight = 640
    object lblEmpresa: TLabel [0]
      Left = 8
      Top = 425
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
    object Label6: TLabel [1]
      Left = 8
      Top = 248
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
    object lblDtaIni: TLabel [2]
      Left = 81
      Top = 234
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
    object lblDtaFin: TLabel [3]
      Left = 81
      Top = 269
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
    object Label5: TLabel [4]
      Left = 8
      Top = 213
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
    object Label1: TLabel [5]
      Left = 8
      Top = 355
      Width = 32
      Height = 14
      Caption = 'Cart'#227'o'
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
      Top = 390
      Width = 43
      Height = 14
      Caption = 'Bandeira'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [7]
      Left = 8
      Top = 496
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
    object Label3: TLabel [8]
      Left = 8
      Top = 460
      Width = 98
      Height = 14
      Caption = 'Seq'#252'encial de Baixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [9]
      Left = 8
      Top = 571
      Width = 46
      Height = 14
      Caption = 'Operador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [10]
      Left = 194
      Top = 2
      Width = 32
      Height = 14
      Caption = 'Op'#231#227'o'
    end
    object Label9: TLabel [11]
      Left = 336
      Top = 269
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
    object Label10: TLabel [12]
      Left = 336
      Top = 234
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
    object Label11: TLabel [13]
      Left = 263
      Top = 213
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
    object Label12: TLabel [14]
      Left = 263
      Top = 248
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
    object Label13: TLabel [15]
      Left = 82
      Top = 341
      Width = 83
      Height = 14
      Caption = '(RECEBIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel [16]
      Left = 82
      Top = 306
      Width = 83
      Height = 14
      Caption = '(RECEBIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel [17]
      Left = 9
      Top = 285
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
    object Label16: TLabel [18]
      Left = 9
      Top = 320
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
    object Label8: TLabel [19]
      Left = 8
      Top = 532
      Width = 86
      Height = 14
      Caption = 'Portador da Baixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 43
      Width = 259
      Height = 43
      TabOrder = 2
      ExplicitLeft = 8
      ExplicitTop = 43
      ExplicitWidth = 259
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 189
        Caption = '(V)'#237'deo         (I)mpressora          (E)xcel'
        ExplicitTop = 19
        ExplicitWidth = 189
      end
    end
    object gpbTitulos: TGroupBox
      Left = 8
      Top = 0
      Width = 180
      Height = 43
      Caption = 'Titulos...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 19
        Width = 136
        Height = 14
        Caption = '(A)berto (Q)uitados (T)odos'
        CorDestaque = clRed
      end
      object edtTitulos: TEditFocus
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 439
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 19
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
      Left = 56
      Top = 439
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 29
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 227
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
      TabOrder = 7
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
      Top = 262
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
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodCartoes: TEditFocus
      Left = 8
      Top = 369
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 15
      OnExit = edtCodCartoesExit
      OnKeyPress = edtCodCartoesKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCartoes: TEditFocus
      Left = 54
      Top = 369
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gbpOpcDta: TGroupBox
      Left = 8
      Top = 86
      Width = 412
      Height = 43
      Caption = 'Agrupar por Data de'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 19
        Width = 205
        Height = 14
        Caption = '(V)encimento   (C)adastro   (R)ecebimento'
        CorDestaque = clRed
      end
      object edtOpcaoData: TEditFocus
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
        Text = 'V'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gbpVenCar: TGroupBox
      Left = 279
      Top = 43
      Width = 141
      Height = 43
      Caption = 'Agrupar por'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 19
        Width = 73
        Height = 14
        Caption = '(C)art'#227'o (D)ata'
        CorDestaque = clRed
      end
      object edtVenCar: TEditFocus
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
    object rdgEmpresa: TRadioGroup
      Left = 300
      Top = 292
      Width = 120
      Height = 67
      Caption = 'Empresa'
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      TabOrder = 14
    end
    object edtCodBan: TEditFocus
      Left = 8
      Top = 404
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 17
      OnExit = edtCodBanExit
      OnKeyPress = edtCodBanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesBan: TEditFocus
      Left = 53
      Top = 404
      Width = 367
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbTipoBai: TGroupBox
      Left = 8
      Top = 172
      Width = 412
      Height = 43
      Caption = 'Cart'#245'es por'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object ColorLabel6: TColorLabel
        Left = 28
        Top = 19
        Width = 166
        Height = 14
        Caption = '(V)enda   (R)ecebimento   (T)odos'
        CorDestaque = clRed
      end
      object edtTipBai: TEditFocus
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
    object gpbOrdDta: TGroupBox
      Left = 8
      Top = 129
      Width = 412
      Height = 43
      Caption = 'Ordenar por Data de'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object ColorLabel7: TColorLabel
        Left = 28
        Top = 19
        Width = 205
        Height = 14
        Caption = '(V)encimento   (C)adastro   (R)ecebimento'
        CorDestaque = clRed
      end
      object edtOrdenarData: TEditFocus
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
        Text = 'V'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkAjuDta: TCheckBox
      Left = 8
      Top = 606
      Width = 322
      Height = 17
      Caption = 'Ajustar venctos considerando S'#225'bados, Domingos e Feriados'
      TabOrder = 27
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 510
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 21
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
      Left = 54
      Top = 510
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSeqCon: TEditFocus
      Tag = 99
      Left = 8
      Top = 474
      Width = 98
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
      MaxLength = 10
      ParentFont = False
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttNumerico
    end
    object rdgTipCar: TRadioGroup
      Left = 172
      Top = 292
      Width = 120
      Height = 67
      Caption = 'Tipo de Cart'#227'o'
      Columns = 2
      ItemIndex = 2
      Items.Strings = (
        'TEF'
        'POS'
        'Todos')
      TabOrder = 13
    end
    object chkNaoExibeVend: TCheckBox
      Left = 8
      Top = 621
      Width = 339
      Height = 17
      Caption = 'N'#227'o Exibir Nome Vendedor, C'#243'digo de Libera'#231#227'o e N'#250'mero do NSU'
      TabOrder = 28
    end
    object edtDesOpe: TEditFocus
      Left = 54
      Top = 584
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 8
      Top = 584
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 25
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object cmbOpcao: TComboBoxFocus
      Left = 194
      Top = 17
      Width = 222
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Anal'#237'tico '
      OnChange = cmbOpcaoChange
      Items.Strings = (
        'Anal'#237'tico '
        'Sint'#233'tico por Cart'#227'o'
        'Sint'#233'tico por Cart'#227'o / Vencto'
        'Sint'#233'tico por M'#234's/Ano (Vencto)')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtPorBai: TEditFocus
      Tag = 99
      Left = 8
      Top = 546
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 23
      OnExit = edtPorBaiExit
      OnKeyPress = edtPorBaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesPorBai: TEditFocus
      Left = 54
      Top = 546
      Width = 366
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskVenIni: TMaskEditFocus
      Tag = 99
      Left = 263
      Top = 227
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
      TabOrder = 9
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskVenFin: TMaskEditFocus
      Tag = 99
      Left = 263
      Top = 262
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
      TabOrder = 10
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskRecIni: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 299
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
      TabOrder = 11
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskRecFin: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 334
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
      TabOrder = 12
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 668
    Width = 448
    ExplicitTop = 668
    ExplicitWidth = 428
    inherited pnlNomeForm: TPanel
      Left = 277
      ExplicitLeft = 257
    end
    inherited pnlInfo: TPanel
      Width = 277
      ExplicitWidth = 257
      inherited shpMultSel: TShape
        Left = 142
        Visible = True
        ExplicitLeft = 142
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 444
    Top = 190
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 477
    Top = 190
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 444
    Top = 157
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 411
    Top = 190
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 543
    Top = 124
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 411
    Top = 157
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 510
    Top = 124
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 444
    Top = 124
  end
  inherited frxGen: TfrxUserDataSet
    Left = 510
    Top = 157
  end
  inherited frxDesigner: TfrxDesigner
    Left = 477
    Top = 124
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 543
    Top = 157
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 411
    Top = 124
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 88
  end
end
