inherited frmEmailMarketing: TfrmEmailMarketing
  Tag = 99
  Left = 283
  Top = 140
  Width = 728
  Height = 484
  HorzScrollBar.Range = 358
  VertScrollBar.Range = 207
  BorderIcons = [biSystemMenu]
  Caption = 'E-Mail Marketing - Clientes'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 728
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 412
    Width = 722
    Height = 27
    TabOrder = 1
    ExplicitTop = 412
    ExplicitWidth = 722
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Left = 103
      Width = 540
      Height = 23
      TabOrder = 2
      ExplicitLeft = 103
      ExplicitWidth = 540
      ExplicitHeight = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 643
      Top = 2
      Height = 23
      Align = alRight
      ExplicitLeft = 643
      ExplicitTop = 2
      ExplicitHeight = 23
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 101
      Height = 23
      Align = alLeft
      Caption = '&Enviar E-Mail'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 439
    Width = 722
    TabOrder = 2
    ExplicitTop = 439
    ExplicitWidth = 722
    inherited pnlNomeForm: TPanel
      Left = 580
      Width = 142
      TabOrder = 1
      ExplicitLeft = 580
      ExplicitWidth = 142
    end
    inherited pnlInfo: TPanel
      Width = 580
      TabOrder = 0
      ExplicitWidth = 580
      object shpMultSel: TShape
        Left = 562
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 365
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 722
    Height = 412
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lbl5: TLabel
      Left = 14
      Top = 73
      Width = 56
      Height = 14
      Caption = 'Nome Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 404
      Top = 73
      Width = 52
      Height = 14
      Caption = 'Nome Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 37
      Top = 96
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 23
      Top = 119
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
    object lbl9: TLabel
      Left = 423
      Top = 96
      Width = 33
      Height = 14
      Caption = 'Estado'
    end
    object lbl10: TLabel
      Left = 385
      Top = 119
      Width = 71
      Height = 14
      Caption = 'Representante'
    end
    object lbl11: TLabel
      Left = 20
      Top = 210
      Width = 50
      Height = 14
      Caption = 'End. Inicial'
    end
    object lbl12: TLabel
      Left = 410
      Top = 210
      Width = 46
      Height = 14
      Caption = 'End. Final'
    end
    object lbl13: TLabel
      Left = 25
      Top = 142
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblRegiao: TLabel
      Left = 37
      Top = 165
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o'
    end
    object lblEmpresa: TLabel
      Left = 28
      Top = 234
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
    object lbl1: TLabel
      Left = 507
      Top = 95
      Width = 29
      Height = 14
      Caption = 'Bairro'
    end
    object lbl2: TLabel
      Left = 410
      Top = 142
      Width = 46
      Height = 14
      Caption = 'Categoria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTipCli: TLabel
      Left = 401
      Top = 165
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Cliente'
    end
    object lbl3: TLabel
      Left = 518
      Top = 142
      Width = 51
      Height = 14
      Caption = 'Tab. Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 406
      Top = 188
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'C. Acesso'
    end
    object lbl4: TLabel
      Left = 14
      Top = 187
      Width = 56
      Height = 14
      Caption = 'Sub-Regi'#227'o'
    end
    object lbl14: TLabel
      Left = 570
      Top = 234
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sexo:'
    end
    object shpCodVen: TShape
      Left = 72
      Top = 115
      Width = 8
      Height = 22
    end
    object shpCodRep: TShape
      Left = 462
      Top = 115
      Width = 8
      Height = 22
    end
    object Label9: TLabel
      Left = 3
      Top = 256
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento'
    end
    object lblCliente: TLabel
      Left = 38
      Top = 280
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdgTipCli: TRadioGroup
      Tag = 99
      Left = 6
      Top = 312
      Width = 280
      Height = 45
      Caption = 'Pessoa:'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica'
        'Todos')
      TabOrder = 35
      OnClick = rdgTipDtaClick
    end
    object gpbClienteFF: TGroupBox
      Left = 448
      Top = 312
      Width = 130
      Height = 45
      Caption = 'Cliente FF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 37
      object ColorLabel6: TColorLabel
        Left = 30
        Top = 20
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object edtClienteFF: TEditFocus
        Tag = 99
        Left = 8
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
    object gpbEnvBol: TGroupBox
      Left = 581
      Top = 312
      Width = 130
      Height = 45
      Caption = 'Recebe boleto p/ e-mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 38
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 20
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object edtEnvBol: TEditFocus
        Tag = 99
        Left = 8
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
    object cbbCategoria: TComboBoxFocus
      Left = 462
      Top = 138
      Width = 39
      Height = 22
      Style = csDropDownList
      MaxLength = 1
      TabOrder = 16
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        ' ')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtNomeInicial: TEditFocus
      Left = 72
      Top = 69
      Width = 308
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
      ParentFont = False
      TabOrder = 4
      OnChange = edtNomeInicialChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomeFinal: TEditFocus
      Left = 462
      Top = 69
      Width = 249
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      OnExit = edtNomeFinalExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 72
      Top = 92
      Width = 39
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
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 81
      Top = 115
      Width = 30
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
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtCodRepresentante: TEditFocus
      Tag = 99
      Left = 471
      Top = 115
      Width = 30
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
      OnExit = edtCodRepresentanteExit
      OnKeyPress = edtCodRepresentanteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Left = 462
      Top = 92
      Width = 39
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
      MaxLength = 2
      ParentFont = False
      TabOrder = 8
      OnExit = edtEstadoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesCidade: TEditFocus
      Left = 112
      Top = 92
      Width = 268
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
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 112
      Top = 115
      Width = 268
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
    object edtDesRepresentante: TEditFocus
      Left = 503
      Top = 115
      Width = 208
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
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbStatus: TGroupBox
      Left = 290
      Top = 312
      Width = 155
      Height = 45
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 36
      object ColorLabel3: TColorLabel
        Left = 30
        Top = 20
        Width = 116
        Height = 14
        Caption = '(A)tivo (I)nativo (T)odos'
        CorDestaque = clRed
      end
      object edtStatus: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
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
    object edtEndIni: TEditFocus
      Tag = 99
      Left = 72
      Top = 207
      Width = 308
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 26
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEndFin: TEditFocus
      Tag = 99
      Left = 462
      Top = 207
      Width = 249
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 27
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbAniv: TGroupBox
      Left = 382
      Top = 4
      Width = 161
      Height = 60
      Caption = 'Anivers'#225'rio Clientes (dia/m'#234's)'
      TabOrder = 2
      object lbl15: TLabel
        Left = 13
        Top = 16
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object lbl16: TLabel
        Left = 63
        Top = 16
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object mskAniIni: TMaskEditFocus
        Tag = 99
        Left = 13
        Top = 30
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
        ValidaData = False
      end
      object mskAniFin: TMaskEditFocus
        Tag = 99
        Left = 63
        Top = 30
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
        ValidaData = False
      end
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 72
      Top = 138
      Width = 39
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
      OnExit = edtCodAtiExit
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtAtividade: TEditFocus
      Left = 112
      Top = 138
      Width = 268
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
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbData: TGroupBox
      Left = 8
      Top = 4
      Width = 240
      Height = 60
      TabOrder = 0
      object lbl17: TLabel
        Left = 8
        Top = 16
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
      object lblTitData: TLabel
        Left = 154
        Top = 34
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
      object lbl18: TLabel
        Left = 82
        Top = 16
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
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 30
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
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 30
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
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object rdgTipDta: TRadioGroup
      Tag = 99
      Left = 253
      Top = 3
      Width = 124
      Height = 61
      Caption = 'Filtrar por data de:'
      ItemIndex = 0
      Items.Strings = (
        'Cadastro'
        'Nascimento'
        #218'ltima Venda')
      TabOrder = 1
      OnClick = rdgTipDtaClick
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 72
      Top = 161
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 18
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
      Left = 112
      Top = 161
      Width = 268
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 72
      Top = 230
      Width = 39
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
      TabOrder = 28
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
      Left = 112
      Top = 230
      Width = 268
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 29
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 543
      Top = 92
      Width = 168
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTipCli: TEditFocus
      Tag = 99
      Left = 462
      Top = 161
      Width = 39
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
      TabOrder = 20
      OnExit = edtTipCliExit
      OnKeyPress = edtTipCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesTpc: TEditFocus
      Left = 503
      Top = 161
      Width = 208
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object cbbTabPre: TComboBoxFocus
      Left = 577
      Top = 138
      Width = 134
      Height = 22
      Style = csDropDownList
      MaxLength = 1
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCodCac: TEditFocus
      Tag = 99
      Left = 462
      Top = 184
      Width = 39
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
      TabOrder = 24
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
      Left = 503
      Top = 184
      Width = 208
      Height = 22
      TabStop = False
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
    object edtCodSub: TEditFocus
      Tag = 99
      Left = 72
      Top = 184
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 22
      OnExit = edtCodSubExit
      OnKeyPress = edtCodSubKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesSub: TEditFocus
      Left = 112
      Top = 184
      Width = 268
      Height = 22
      TabStop = False
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
    object cmbSexo: TComboBoxFocus
      Tag = 99
      Left = 603
      Top = 230
      Width = 108
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 2
      TabOrder = 30
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
    object gpbAnivCont: TGroupBox
      Left = 547
      Top = 4
      Width = 164
      Height = 60
      Caption = 'Anivers'#225'rio Contatos (dia/m'#234's)'
      TabOrder = 3
      object lblIniCont: TLabel
        Left = 13
        Top = 16
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object lblFinCont: TLabel
        Left = 63
        Top = 16
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object mskAniIniCont: TMaskEditFocus
        Tag = 99
        Left = 13
        Top = 30
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
        ValidaData = False
      end
      object mskAniFinCont: TMaskEditFocus
        Tag = 99
        Left = 63
        Top = 30
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
        ValidaData = False
      end
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 72
      Top = 253
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 31
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDep: TEditFocus
      Left = 112
      Top = 253
      Width = 268
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 32
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgLeiLGPD: TRadioGroup
      Tag = 99
      Left = 6
      Top = 363
      Width = 583
      Height = 45
      Caption = 'Lei LGPD:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Listar somente clientes com aceite no Termo da LGPD.'
        'Listar todos os clientes.')
      TabOrder = 39
      OnClick = rdgTipDtaClick
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 72
      Top = 276
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 33
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 138
      Top = 276
      Width = 242
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 34
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
    Left = 720
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 816
    Top = 184
  end
  object dlgExcel: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Planilha do Excel|*.xls'
    Left = 688
    Top = 216
  end
end
