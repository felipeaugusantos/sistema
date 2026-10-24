inherited frmEmailMarketingProfissionais: TfrmEmailMarketingProfissionais
  Tag = 99
  Left = 283
  Top = 140
  Width = 635
  Height = 330
  HorzScrollBar.Range = 358
  VertScrollBar.Range = 207
  Caption = 'E-Mail Marketing - Profissionais'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 635
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 257
    Width = 629
    TabOrder = 1
    ExplicitTop = 257
    ExplicitWidth = 629
    inherited FlwBotoes: TFlowPanel
      Left = 103
      Width = 447
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 550
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 550
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 101
      Height = 24
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
      ExplicitLeft = 8
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 629
    Height = 257
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      629
      257)
    object lbl5: TLabel
      Left = 8
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
      Left = 318
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
      Left = 31
      Top = 97
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
    object lbl9: TLabel
      Left = 337
      Top = 97
      Width = 33
      Height = 14
      Caption = 'Estado'
    end
    object lbl11: TLabel
      Left = 14
      Top = 144
      Width = 50
      Height = 14
      Caption = 'End. Inicial'
    end
    object lbl12: TLabel
      Left = 324
      Top = 144
      Width = 46
      Height = 14
      Caption = 'End. Final'
    end
    object lbl13: TLabel
      Left = 19
      Top = 121
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
    object lblEmpresa: TLabel
      Left = 22
      Top = 168
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
      Left = 421
      Top = 97
      Width = 29
      Height = 14
      Caption = 'Bairro'
    end
    object rdgTipDiv: TRadioGroup
      Tag = 99
      Left = 6
      Top = 191
      Width = 190
      Height = 45
      Anchors = [akLeft, akBottom]
      Caption = 'Pessoa:'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica'
        'Todos')
      TabOrder = 15
      OnClick = rdgTipDtaClick
    end
    object edtNomeInicial: TEditFocus
      Left = 70
      Top = 70
      Width = 242
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
      TabOrder = 3
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
      Left = 376
      Top = 70
      Width = 242
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
      TabOrder = 4
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
      Left = 70
      Top = 94
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
      TabOrder = 5
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
    object edtEstado: TEditFocus
      Left = 376
      Top = 94
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
      TabOrder = 7
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
      Left = 110
      Top = 94
      Width = 202
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
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbStatus: TGroupBox
      Left = 201
      Top = 191
      Width = 155
      Height = 45
      Anchors = [akLeft, akBottom]
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
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
      Left = 70
      Top = 141
      Width = 242
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
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
      Left = 376
      Top = 141
      Width = 242
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbAniv: TGroupBox
      Left = 384
      Top = 4
      Width = 131
      Height = 60
      Caption = 'Anivers'#225'rio (dia/m'#234's)'
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
      Left = 70
      Top = 118
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
      TabOrder = 9
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
      Left = 110
      Top = 118
      Width = 202
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
      TabOrder = 10
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
      Left = 254
      Top = 4
      Width = 124
      Height = 60
      Caption = 'Filtrar por data de:'
      ItemIndex = 0
      Items.Strings = (
        'Cadastro'
        'Nascimento')
      TabOrder = 1
      OnClick = rdgTipDtaClick
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 70
      Top = 165
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
      TabOrder = 13
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
      Left = 110
      Top = 165
      Width = 202
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
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
      Left = 456
      Top = 94
      Width = 162
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 246
      Width = 627
      Height = 10
      Align = alBottom
      Smooth = True
      TabOrder = 17
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 629
    TabOrder = 2
    ExplicitTop = 285
    ExplicitWidth = 629
    inherited pnlNomeForm: TPanel
      Left = 487
      Width = 142
      TabOrder = 1
      ExplicitLeft = 487
      ExplicitWidth = 142
    end
    inherited pnlInfo: TPanel
      Width = 487
      TabOrder = 0
      ExplicitWidth = 487
      object shpMultSel: TShape
        Left = 469
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
