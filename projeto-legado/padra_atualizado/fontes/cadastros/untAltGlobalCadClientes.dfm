inherited frmAltGlobalCadClientes: TfrmAltGlobalCadClientes
  Width = 1024
  Height = 768
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o Global de Clientes'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 1008
    ExplicitTop = 685
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 927
      ExplicitWidth = 927
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 98
        Height = 24
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 929
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1008
    ExplicitTop = 713
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object pnlFiltro: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 285
    Align = alTop
    TabOrder = 3
    object Label19: TLabel
      Left = 53
      Top = 10
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label9: TLabel
      Left = 577
      Top = 10
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object ColorLabel1: TColorLabel
      Left = 669
      Top = 9
      Width = 116
      Height = 14
      Caption = '(A)tivo (I)nativo (T)odos'
      CorDestaque = clRed
    end
    object Label3: TLabel
      Left = 52
      Top = 56
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label1: TLabel
      Left = 537
      Top = 33
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Consumidor Final:'
    end
    object ColorLabel2: TColorLabel
      Left = 669
      Top = 32
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 583
      Top = 103
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Revista:'
    end
    object ColorLabel5: TColorLabel
      Left = 669
      Top = 101
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label6: TLabel
      Left = 542
      Top = 126
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela de Pre'#231'o:'
    end
    object clbPrcVenda: TColorLabel
      Left = 669
      Top = 124
      Width = 178
      Height = 14
      Caption = 'Pre'#231'o de Venda (1)(2)(3)(4)(5)(6)(7)'
      CorDestaque = clRed
    end
    object lbl1: TLabel
      Left = 52
      Top = 126
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object Label7: TLabel
      Left = 38
      Top = 217
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object lbl3: TLabel
      Left = 52
      Top = 79
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object lbl6: TLabel
      Left = 56
      Top = 102
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object lbl11: TLabel
      Left = 14
      Top = 240
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Representante:'
    end
    object lbl5: TLabel
      Left = 574
      Top = 147
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object lbl9: TLabel
      Left = 16
      Top = 171
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rede de Lojas:'
    end
    object Label8: TLabel
      Left = 3
      Top = 194
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Canal de Acesso:'
    end
    object lbl12: TLabel
      Left = 29
      Top = 147
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Regi'#227'o:'
    end
    object Label12: TLabel
      Left = 561
      Top = 193
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador (1):'
    end
    object Label13: TLabel
      Left = 561
      Top = 216
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador (2):'
    end
    object Label15: TLabel
      Left = 66
      Top = 33
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label156: TLabel
      Left = 35
      Top = 263
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Categoria:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 90
      Top = 6
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
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
      Left = 152
      Top = 6
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSituacao: TEditFocus
      Tag = 99
      Left = 625
      Top = 6
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 2
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 90
      Top = 52
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
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
    object edtNomCid: TEditFocus
      Left = 152
      Top = 52
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtConsum: TEditFocus
      Tag = 99
      Left = 625
      Top = 29
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtRevist: TEditFocus
      Tag = 99
      Left = 625
      Top = 98
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtTabPre: TEditFocus
      Tag = 99
      Left = 625
      Top = 121
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 90
      Top = 121
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 12
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
    object edtNomReg: TEditFocus
      Left = 152
      Top = 121
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomVen: TEditFocus
      Left = 152
      Top = 213
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 27
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 90
      Top = 213
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 26
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
    object edtEstado: TEditFocus
      Left = 90
      Top = 75
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 2
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 90
      Top = 98
      Width = 410
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 90
      Top = 236
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 30
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
      Left = 152
      Top = 236
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 31
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
      Left = 625
      Top = 144
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 17
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
      Left = 666
      Top = 144
      Width = 336
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 18
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
      Left = 90
      Top = 167
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 19
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesRed: TEditFocus
      Left = 152
      Top = 167
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCac: TEditFocus
      Tag = 99
      Left = 90
      Top = 190
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 22
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
      Left = 152
      Top = 190
      Width = 348
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
    object edtDesSub: TEditFocus
      Left = 152
      Top = 144
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
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
      Left = 90
      Top = 144
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 15
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 625
      Top = 190
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 24
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 666
      Top = 190
      Width = 336
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
    object edtCodPor2: TEditFocus
      Tag = 99
      Left = 625
      Top = 213
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 28
      OnExit = edtCodPor2Exit
      OnKeyPress = edtCodPor2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor2: TEditFocus
      Left = 666
      Top = 213
      Width = 336
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object pnlTipCli: TPanel
      Left = 503
      Top = 235
      Width = 506
      Height = 24
      BevelOuter = bvNone
      TabOrder = 32
      object lblTipCli: TLabel
        Left = 46
        Top = 4
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Cliente:'
      end
      object edtDesTpc: TEditFocus
        Left = 163
        Top = 1
        Width = 336
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTipCli: TEditFocus
        Tag = 99
        Left = 122
        Top = 1
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtTipCliExit
        OnKeyPress = edtTipCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlForPag: TPanel
      Left = 503
      Top = 166
      Width = 503
      Height = 23
      BevelOuter = bvNone
      TabOrder = 21
      object Label11: TLabel
        Left = 15
        Top = 4
        Width = 104
        Height = 14
        Alignment = taRightJustify
        Caption = 'Forma de Pagamento:'
      end
      object edtCodFpg: TEditFocus
        Tag = 99
        Left = 122
        Top = 1
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodFpgExit
        OnKeyPress = edtCodFpgKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesFpg: TEditFocus
        Left = 163
        Top = 1
        Width = 336
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
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
    object pnlPeMIFF: TPanel
      Left = 503
      Top = 52
      Width = 503
      Height = 22
      BevelOuter = bvNone
      TabOrder = 7
      object Label2: TLabel
        Left = 17
        Top = 4
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Permitir FF (A Prazo):'
      end
      object ColorLabel3: TColorLabel
        Left = 166
        Top = 3
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtPermFF: TEditFocus
        Tag = 99
        Left = 122
        Top = 0
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object pnlPeMIFV: TPanel
      Left = 503
      Top = 74
      Width = 503
      Height = 23
      BevelOuter = bvNone
      TabOrder = 9
      object Label4: TLabel
        Left = 19
        Top = 6
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Permitir FF ('#192' Vista):'
      end
      object ColorLabel4: TColorLabel
        Left = 166
        Top = 4
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtPermFV: TEditFocus
        Tag = 99
        Left = 122
        Top = 1
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object pnlCodCnd: TPanel
      Left = 503
      Top = 258
      Width = 521
      Height = 24
      BevelOuter = bvNone
      TabOrder = 34
      object Label14: TLabel
        Left = 0
        Top = 4
        Width = 119
        Height = 14
        Alignment = taRightJustify
        Caption = 'Condi'#231#227'o de Pagamento:'
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 122
        Top = 1
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodCndExit
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCnd: TEditFocus
        Left = 163
        Top = 1
        Width = 336
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
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
    object cmbCategoria: TComboBoxFocus
      Tag = 99
      Left = 90
      Top = 259
      Width = 39
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 33
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
    object edtCep: TMaskEditFocus
      Left = 90
      Top = 29
      Width = 59
      Height = 22
      EditMask = '99999-999;0;_'
      MaxLength = 9
      TabOrder = 3
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlCamposVisualizados: TPanel [3]
    Left = 0
    Top = 285
    Width = 1008
    Height = 389
    Align = alClient
    TabOrder = 2
    object nbDados: TNotebook
      Left = 1
      Top = 1
      Width = 1006
      Height = 387
      Align = alClient
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = 'Parametro'
        object grdCampos: TcxGridCitel
          Left = 0
          Top = 20
          Width = 768
          Height = 308
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdCamposTv: TcxGridDBTableViewCitel
            OnKeyPress = grdCamposTvKeyPress
            Navigator.Buttons.CustomButtons = <>
            FilterBox.Visible = fvNever
            OnEditing = grdCamposTvEditing
            OnEditKeyPress = grdCamposTvEditKeyPress
            DataController.DataSource = dtsCampos
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir o filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracImmediately
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdCamposCAMPO: TcxGridDBColumn
              DataBinding.FieldName = 'CAMPO'
              Visible = False
              Width = 64
            end
            object grdCamposABA: TcxGridDBColumn
              Caption = 'Aba Cad. de Cliente'
              DataBinding.FieldName = 'ABA'
              Options.Editing = False
              Width = 150
            end
            object grdCamposDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o do Campo'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Width = 365
            end
            object grdCamposMARCADO: TcxGridDBColumn
              Caption = 'Sel.'
              DataBinding.FieldName = 'MARCADO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ImmediatePost = True
              Properties.OnChange = grdCamposMARCADOPropertiesChange
            end
            object grdCamposVALOR: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR'
              OnGetDisplayText = grdCamposVALORGetDisplayText
              OnGetProperties = grdCamposVALORGetProperties
              HeaderAlignmentHorz = taCenter
              Styles.OnGetContentStyle = grdCamposVALORStylesGetContentStyle
              Width = 200
            end
            object grdCamposPROPER: TcxGridDBColumn
              DataBinding.FieldName = 'PROPER'
              Visible = False
            end
            object grdCamposDESVAL: TcxGridDBColumn
              DataBinding.FieldName = 'DESVAL'
              Visible = False
            end
          end
          object grdCamposLvl: TcxGridLevel
            GridView = grdCamposTv
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 1006
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label16: TLabel
            Left = 331
            Top = 0
            Width = 675
            Height = 20
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Campos Visualizados'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitLeft = 480
            ExplicitWidth = 609
            ExplicitHeight = 24
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 331
            Height = 20
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object btnLimpaFiltros: TBitBtnLocked
              Left = 0
              Top = 0
              Width = 108
              Height = 20
              Align = alLeft
              BiDiMode = bdLeftToRight
              Caption = '[F8] Limpa Filtros'
              ParentBiDiMode = False
              TabOrder = 0
              OnClick = btnLimpaFiltrosClick
            end
          end
        end
        object pnlCndPag: TPanel
          Left = 0
          Top = 357
          Width = 1006
          Height = 30
          Align = alBottom
          Enabled = False
          TabOrder = 2
          object Label10: TLabel
            Left = 13
            Top = 7
            Width = 195
            Height = 14
            Caption = 'Opera'#231#227'o para Condi'#231#227'o de Pagamento:'
          end
          object rdbIncluir: TRadioButton
            Left = 224
            Top = 6
            Width = 72
            Height = 17
            Caption = 'Incluir'
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object rdgExcluir: TRadioButton
            Left = 312
            Top = 6
            Width = 72
            Height = 17
            Caption = 'Excluir'
            TabOrder = 1
          end
        end
        object pnlLiberacao: TPanel
          Left = 0
          Top = 328
          Width = 1006
          Height = 29
          Align = alBottom
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Visible = False
          object Label17: TLabel
            Left = 1
            Top = 1
            Width = 890
            Height = 14
            Align = alClient
            Alignment = taCenter
            Caption = 
              'Aten'#231#227'o! Existem campos selecionados que v'#227'o precisar de libera'#231 +
              #227'o de direito de acesso para serem alterados. Ao continuar, a so' +
              'licita'#231#227'o de libera'#231#227'o ser'#225' feita no final da opera'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
          end
        end
        object Panel3: TPanel
          Left = 768
          Top = 20
          Width = 238
          Height = 308
          Align = alRight
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object GroupBox1: TGroupBox
            Left = 10
            Top = 14
            Width = 208
            Height = 92
            TabOrder = 0
            object shpConsulta: TShape
              Left = 13
              Top = 10
              Width = 12
              Height = 14
              Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
              Brush.Color = 11206613
              ParentShowHint = False
              ShowHint = True
            end
            object Label18: TLabel
              Left = 31
              Top = 11
              Width = 158
              Height = 14
              Caption = 'Utilize [ ? ]  ou [ / ] para consultar'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object shpLista: TShape
              Left = 13
              Top = 30
              Width = 12
              Height = 14
              Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
              Brush.Color = 10801663
              ParentShowHint = False
              ShowHint = True
            end
            object Label20: TLabel
              Left = 31
              Top = 31
              Width = 108
              Height = 14
              Caption = 'Possui lista de valores'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Shape3: TShape
              Left = 13
              Top = 64
              Width = 12
              Height = 14
              Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
              Brush.Color = clRed
              ParentShowHint = False
              ShowHint = True
            end
            object Label21: TLabel
              Left = 31
              Top = 65
              Width = 160
              Height = 14
              Caption = 'Informa'#231#245'es que ser'#227'o alteradas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
          end
        end
      end
    end
  end
  object pgbProgresso: TProgressBar [4]
    Left = 0
    Top = 674
    Width = 1008
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  object cdsParametros: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsParametrosBeforePost
    AfterPost = cdsParametrosAfterPost
    Left = 544
    Top = 440
    object cdsParametrosDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsParametrosCAMPO: TStringField
      FieldName = 'CAMPO'
      Size = 10
    end
    object cdsParametrosMARCADO: TBooleanField
      FieldName = 'MARCADO'
      OnChange = cdsParametrosMARCADOChange
    end
    object cdsParametrosABA: TStringField
      FieldName = 'ABA'
      Size = 100
    end
    object cdsParametrosPROPER: TStringField
      FieldName = 'PROPER'
      Size = 100
    end
    object cdsParametrosVALOR: TStringField
      FieldName = 'VALOR'
      Size = 6000
    end
    object cdsParametrosDESVAL: TStringField
      FieldName = 'DESVAL'
      Size = 300
    end
  end
  object dtsCampos: TDataSource
    DataSet = cdsParametros
    Left = 612
    Top = 440
  end
  object cxEditRepository: TcxEditRepository
    Left = 860
    Top = 131
    PixelsPerInch = 96
    object cxeString16: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 16
    end
    object cxeString20: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
    end
    object cxeString02: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 2
    end
    object cxeString03: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
    end
    object cxeString05: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 5
    end
    object cxeString06: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 6
    end
    object cxeString07: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 7
    end
    object cxeString08: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 8
    end
    object cxeString10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
    end
    object cxeString25: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 25
    end
    object cxeString30: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 30
    end
    object cxeString50: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 50
    end
    object cxeString70: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 70
    end
    object cxeString80: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 80
    end
    object cxeDate: TcxEditRepositoryDateItem
    end
    object cxeInt03: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 3
      Properties.OnValidate = cxeInt03PropertiesValidate
    end
    object cxeInt11: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 11
      Properties.OnValidate = cxeInt03PropertiesValidate
    end
    object cmbSimNao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeMemo: TcxEditRepositoryMemoItem
      Properties.CharCase = ecUpperCase
      Properties.ScrollBars = ssBoth
      Properties.VisibleLineCount = 5
    end
    object cxeMasVal: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasValPropertiesValidate
    end
    object cxeMasPer: TcxEditRepositoryTextItem
      Properties.OnValidate = cxeMasPerPropertiesValidate
    end
    object cxeMasInt: TcxEditRepositoryTextItem
    end
    object cxeConsTam8: TcxEditRepositoryTextItem
      Properties.MaxLength = 8
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam6: TcxEditRepositoryTextItem
      Properties.MaxLength = 6
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam5: TcxEditRepositoryTextItem
      Properties.MaxLength = 5
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam3: TcxEditRepositoryTextItem
      Properties.MaxLength = 3
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam4: TcxEditRepositoryTextItem
      Properties.MaxLength = 4
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam2: TcxEditRepositoryTextItem
      Properties.MaxLength = 2
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam7: TcxEditRepositoryTextItem
      Properties.MaxLength = 7
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cmbPropCategoria: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsEditFixedList
    end
    object cmbBolImp: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeString40: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 40
    end
    object cxeString01: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 1
    end
    object cxeRegTri: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeIndCom: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeTFTNES: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbTabPre: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsEditFixedList
    end
    object cxeSitIpi: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeSitP_C: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeTipFre: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeInt07: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 7
      Properties.OnValidate = cxeInt03PropertiesValidate
    end
    object cxeInt20: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 20
    end
    object cxeCodCna: TcxEditRepositoryMaskItem
      Properties.EditMask = '9999-9/99;0;_'
    end
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 384
    Top = 488
    PixelsPerInch = 96
    object cxsCorAzul: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsCombo: TcxStyle
      AssignedValues = [svColor]
      Color = 10801663
    end
    object cxsAltera: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsConsulta: TcxStyle
      AssignedValues = [svColor]
      Color = 11206613
    end
  end
  object cdsClientesAlteracao: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CLI_CODCLI'
    Params = <>
    ProviderName = 'dspClientesAlteracao'
    Left = 472
    Top = 552
  end
  object dspClientesAlteracao: TUniDataSetProvider
    Options = []
    Left = 440
    Top = 552
  end
end
