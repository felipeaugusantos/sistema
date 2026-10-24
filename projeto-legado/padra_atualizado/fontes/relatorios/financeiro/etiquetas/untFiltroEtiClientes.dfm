inherited frmFiltroEtiClientes: TfrmFiltroEtiClientes
  Left = 323
  Top = 190
  Width = 358
  Height = 676
  BorderIcons = [biSystemMenu]
  Caption = 'Filtros - Clientes'
  Position = poMainFormCenter
  ExplicitWidth = 358
  ExplicitHeight = 676
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 631
    Width = 352
    ExplicitTop = 631
    ExplicitWidth = 352
    inherited FlwBotoes: TFlowPanel
      Width = 348
      ExplicitWidth = 348
    end
    inherited btnSair: TBitBtnLocked
      Left = 284
      ExplicitLeft = 284
    end
  end
  inherited pnlStatus: TPanel
    Top = 631
    Width = 352
    ExplicitTop = 631
    ExplicitWidth = 352
    inherited pnlNomeForm: TPanel
      Left = 176
      Width = 176
      ExplicitLeft = 176
      ExplicitWidth = 176
    end
    inherited pnlInfo: TPanel
      Width = 176
      ExplicitWidth = 176
      object shpMultSel: TShape
        Left = 158
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 352
    Height = 631
    Visible = False
    ExplicitWidth = 352
    ExplicitHeight = 631
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 344
      ExplicitHeight = 599
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 352
    Height = 631
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 33
      Top = 14
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Inicial:'
    end
    object Label2: TLabel
      Left = 37
      Top = 37
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Final:'
    end
    object Label3: TLabel
      Left = 42
      Top = 60
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label4: TLabel
      Left = 44
      Top = 83
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label6: TLabel
      Left = 56
      Top = 106
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label8: TLabel
      Left = 60
      Top = 175
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label9: TLabel
      Left = 56
      Top = 198
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label10: TLabel
      Left = 22
      Top = 605
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Etiquetas:'
    end
    object Label5: TLabel
      Left = 7
      Top = 129
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Canal de Acesso:'
    end
    object Label7: TLabel
      Left = 56
      Top = 152
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object lbl5: TLabel
      Left = 54
      Top = 221
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Revista:'
    end
    object ColorLabel1: TColorLabel
      Left = 135
      Top = 221
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      StyleElements = []
      CorDestaque = clRed
    end
    object lblSexo: TLabel
      Left = 193
      Top = 198
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sexo:'
    end
    object lblTipCli: TLabel
      Left = 17
      Top = 243
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Cliente:'
    end
    object lblConFin: TLabel
      Left = 5
      Top = 267
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Consumidor Final: '
    end
    object clbConFin: TColorLabel
      Left = 135
      Top = 267
      Width = 98
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      StyleElements = []
      CorDestaque = clRed
    end
    object edtNomCid: TEditFocus
      Left = 141
      Top = 102
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNomIni: TEditFocus
      Tag = 99
      Left = 96
      Top = 10
      Width = 237
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFin: TEditFocus
      Tag = 99
      Left = 96
      Top = 33
      Width = 237
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 96
      Top = 56
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
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
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 96
      Top = 79
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
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
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 96
      Top = 102
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 4
      OnExit = edtCodCidExit
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 96
      Top = 171
      Width = 237
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Tag = 99
      Left = 96
      Top = 194
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 96
      Top = 601
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtNomVen: TEditFocus
      Left = 141
      Top = 56
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAti: TEditFocus
      Left = 141
      Top = 79
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object GroupBox2: TGroupBox
      Left = 159
      Top = 549
      Width = 174
      Height = 49
      Caption = ' A'#231#227'o '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      object chkMosFil: TCheckBox
        Left = 10
        Top = 12
        Width = 156
        Height = 31
        Caption = '&Mostrar apenas registros que satisfa'#231'am o filtro'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        WordWrap = True
      end
    end
    object gpb1: TGroupBox
      Left = 20
      Top = 340
      Width = 155
      Height = 95
      Caption = 'Per'#237'odo'
      TabOrder = 15
      object lbl3: TLabel
        Left = 12
        Top = 19
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object lbl4: TLabel
        Left = 16
        Top = 43
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object Label11: TLabel
        Left = 4
        Top = 62
        Width = 63
        Height = 28
        Caption = 'Valor de Faturamento:'
        WordWrap = True
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 69
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
        Left = 69
        Top = 39
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
      object edtVlrFat: TEditFocus
        Tag = 99
        Left = 69
        Top = 67
        Width = 78
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 50
        TabOrder = 2
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object gpbAniv: TGroupBox
      Left = 181
      Top = 340
      Width = 152
      Height = 72
      Caption = 'Anivers'#225'rio (Dia/M'#234's)'
      TabOrder = 16
      object lbl1: TLabel
        Left = 56
        Top = 21
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object lbl2: TLabel
        Left = 60
        Top = 45
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object mskAniIni: TMaskEditFocus
        Tag = 99
        Left = 93
        Top = 17
        Width = 44
        Height = 22
        EditMask = '!99/99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        Text = '  /  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskAniFin: TMaskEditFocus
        Tag = 99
        Left = 93
        Top = 41
        Width = 44
        Height = 22
        EditMask = '!99/99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 1
        Text = '  /  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object edtCodCac: TEditFocus
      Tag = 99
      Left = 96
      Top = 125
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 5
      OnExit = edtCodCacExit
      OnKeyPress = edtCodCacKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCac: TEditFocus
      Left = 141
      Top = 125
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbTipPeriodo: TGroupBox
      Left = 20
      Top = 290
      Width = 313
      Height = 49
      Caption = 'Tipo de Per'#237'odo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      object lblTipPeriodo: TColorLabel
        Left = 32
        Top = 23
        Width = 211
        Height = 14
        Caption = '(1) Per'#237'odo de Venda        (2) '#218'ltima Compra'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        StyleElements = []
        CorDestaque = clRed
      end
      object edtTipPer: TEditFocus
        Tag = 99
        Left = 9
        Top = 19
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
        TamCampo = 1
        TipoTexto = ttInteiro
      end
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 96
      Top = 148
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 6
      OnExit = edtCodRegExit
      OnKeyPress = edtCodRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesReg: TEditFocus
      Left = 141
      Top = 148
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtRevist: TEditFocus
      Tag = 99
      Left = 96
      Top = 217
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object cmbSexo: TComboBoxFocus
      Tag = 99
      Left = 225
      Top = 194
      Width = 108
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 2
      TabOrder = 9
      Text = 'TODOS'
      Items.Strings = (
        'MASCULINO'
        'FEMININO'
        'TODOS')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object gpbCGCCPF: TGroupBox
      Left = 20
      Top = 549
      Width = 133
      Height = 49
      Caption = ' Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      object lblOrdem1: TColorLabel
        Left = 33
        Top = 13
        Width = 87
        Height = 14
        Caption = '(J)ur'#237'dica  (F)'#237'sica'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        StyleElements = []
        CorDestaque = clRed
      end
      object ColorLabel2: TColorLabel
        Left = 33
        Top = 26
        Width = 87
        Height = 14
        Caption = '(T)odos'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        StyleElements = []
        CorDestaque = clRed
      end
      object edtCGCCPF: TEditFocus
        Tag = 99
        Left = 9
        Top = 18
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
    end
    object edtTipCli: TEditFocus
      Tag = 99
      Left = 96
      Top = 240
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 11
      OnKeyPress = edtTipCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesTpc: TEditFocus
      Left = 135
      Top = 240
      Width = 198
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConFin: TEditFocus
      Tag = 99
      Left = 96
      Top = 263
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object gpbCompraPeri: TGroupBox
      Left = 20
      Top = 438
      Width = 313
      Height = 109
      Caption = 'Clientes que n'#227'o compram por per'#237'odo'
      TabOrder = 17
      object Label12: TLabel
        Left = 12
        Top = 41
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object Label13: TLabel
        Left = 177
        Top = 41
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object Label14: TLabel
        Left = 12
        Top = 20
        Width = 231
        Height = 14
        Caption = 'Clientes que compraram alguma vez no per'#237'odo:'
      end
      object Label15: TLabel
        Left = 12
        Top = 62
        Width = 155
        Height = 14
        Caption = 'Mas n'#227'o compraram no per'#237'odo:'
      end
      object Label16: TLabel
        Left = 12
        Top = 82
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object Label17: TLabel
        Left = 177
        Top = 82
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object mskCompraIni: TMaskEditFocus
        Tag = 99
        Left = 69
        Top = 38
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
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskCompraFin: TMaskEditFocus
        Tag = 99
        Left = 221
        Top = 37
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
      object mskNaoCompraIni: TMaskEditFocus
        Tag = 99
        Left = 69
        Top = 79
        Width = 77
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
      object mskNaoCompraFin: TMaskEditFocus
        Tag = 99
        Left = 220
        Top = 79
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
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 0
  end
end
