inherited frmEntMercadorias: TfrmEntMercadorias
  Left = 185
  Top = 156
  Width = 1000
  Height = 655
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Entrada de Mercadorias'
  Position = poMainFormCenter
  ExplicitWidth = 1000
  ExplicitHeight = 655
  PixelsPerInch = 96
  TextHeight = 14
  object pgbCalculoFiscal: TProgressBar [0]
    Left = 0
    Top = 599
    Width = 994
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 610
    Width = 994
    TabOrder = 4
    ExplicitTop = 610
    ExplicitWidth = 994
    DesignSize = (
      994
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 990
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 610
    Width = 994
    TabOrder = 3
    ExplicitTop = 610
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 823
      ExplicitLeft = 823
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 823
    end
  end
  inherited pgcDados: TPageControl
    Top = 292
    Width = 994
    Height = 224
    TabOrder = 2
    Visible = False
    ExplicitTop = 292
    ExplicitWidth = 994
    ExplicitHeight = 224
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 986
      ExplicitHeight = 192
    end
  end
  object pnlItem: TPanel [4]
    Left = 0
    Top = 130
    Width = 994
    Height = 162
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 1
    object Label7: TLabel
      Left = 80
      Top = 26
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label10: TLabel
      Left = 46
      Top = 49
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label14: TLabel
      Left = 44
      Top = 72
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label16: TLabel
      Left = 268
      Top = 72
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Unit'#225'rio:'
    end
    object Label18: TLabel
      Left = 506
      Top = 72
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
    end
    object lblCodAbf: TLabel
      Left = 12
      Top = 95
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrevia'#231#227'o Fiscal:'
    end
    object Label12: TLabel
      Left = 47
      Top = 118
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base ICMS:'
    end
    object Label15: TLabel
      Left = 266
      Top = 118
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota ICMS:'
    end
    object Label19: TLabel
      Left = 504
      Top = 118
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor ICMS:'
    end
    object Label21: TLabel
      Left = 61
      Top = 141
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base IPI:'
    end
    object Label23: TLabel
      Left = 280
      Top = 141
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota IPI:'
    end
    object Label30: TLabel
      Left = 518
      Top = 141
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor IPI:'
    end
    object Label26: TLabel
      Left = 404
      Top = 49
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label3: TLabel
      Left = 529
      Top = 49
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo:'
    end
    object lblSigla: TLabel
      Left = 413
      Top = 72
      Width = 34
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sigla:'
    end
    object lblNumLot: TLabel
      Left = 638
      Top = 26
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote:'
    end
    object lblEmbala: TLabel
      Left = 638
      Top = 49
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object lbl1: TLabel
      Left = 434
      Top = 95
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classifica'#231#227'o de IPI:'
    end
    object Label11: TLabel
      Left = 638
      Top = 95
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEST:'
    end
    object shpUnitarGarantia: TShape
      Left = 403
      Top = 69
      Width = 10
      Height = 22
      Visible = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 106
      Top = 22
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 3
      OnEnter = edtCodIteEnter
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      OnKeyUp = edtCodIteKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAbf: TEditFocus
      Tag = 99
      Left = 106
      Top = 91
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 11
      OnEnter = edtCodAbfEnter
      OnKeyPress = edtCodAbfKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 106
      Top = 68
      Width = 63
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      OnEnter = edtQtdIteEnter
      OnExit = edtQtdIteExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtUnitar: TEditFocus
      Tag = 99
      Left = 339
      Top = 68
      Width = 62
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      OnEnter = edtUnitarEnter
      OnExit = edtUnitarExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtTotIte: TEditFocus
      Tag = 99
      Left = 563
      Top = 68
      Width = 71
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      OnEnter = edtTotIteEnter
      OnExit = edtTotIteExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtBasIPI: TEditFocus
      Tag = 99
      Left = 106
      Top = 137
      Width = 63
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = clWhite
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      OnEnter = edtBasIPIEnter
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtAlqIPI: TEditFocus
      Tag = 99
      Left = 338
      Top = 137
      Width = 63
      Height = 22
      HelpType = htKeyword
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      OnEnter = edtAlqIPIEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtBasIcm: TEditFocus
      Left = 106
      Top = 114
      Width = 63
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      OnEnter = edtBasIcmEnter
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = 16768952
      Requerido = True
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtAlqIcm: TEditFocus
      Left = 338
      Top = 114
      Width = 63
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      OnEnter = edtAlqIcmEnter
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = 16768952
      Requerido = True
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtValIcm: TEditFocus
      Left = 563
      Top = 114
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = 16768952
      Requerido = True
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtvalIpi: TEditFocus
      Tag = 99
      Left = 563
      Top = 137
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 19
      OnEnter = edtvalIpiEnter
      OnExit = edtvalIpiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '##,#0.00'
    end
    object edtDesIte: TEditFocus
      Left = 196
      Top = 22
      Width = 397
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      OnEnter = edtDesIteEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 106
      Top = 45
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 22
      OnEnter = edtRefereEnter
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidad: TEditFocus
      Tag = 99
      Left = 447
      Top = 45
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ReadOnly = True
      TabOrder = 6
      OnEnter = edtUnidadEnter
      OnKeyPress = edtUnidadKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtDesAbf: TEditFocus
      Left = 170
      Top = 91
      Width = 231
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object rdbCodFab: TRadioButton
      Left = 209
      Top = 4
      Width = 113
      Height = 14
      Caption = 'C'#243'digo da F'#225'brica'
      TabOrder = 1
      OnClick = rdbCodFabClick
    end
    object rdbCodIte: TRadioButton
      Left = 105
      Top = 4
      Width = 96
      Height = 14
      Caption = 'C'#243'digo do Item'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbCodIteClick
    end
    object edtSaldo: TEditFocus
      Left = 563
      Top = 45
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object rdbProdAcabado: TRadioButton
      Left = 329
      Top = 4
      Width = 113
      Height = 14
      Caption = 'Produto Acabado'
      TabOrder = 2
      OnClick = rdbProdAcabadoClick
    end
    object edtSigla: TEditFocus
      Tag = 99
      Left = 447
      Top = 68
      Width = 37
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
      TabOrder = 25
      OnEnter = edtSiglaEnter
      OnExit = btnAdicionarClick
      NormalColor = 16768952
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 664
      Top = 22
      Width = 119
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 5
      OnEnter = edtNumLotEnter
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEmbala: TEditFocus
      Tag = 99
      Left = 697
      Top = 45
      Width = 86
      Height = 22
      Alignment = taRightJustify
      Color = clWhite
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      OnEnter = edtEmbalaEnter
      OnExit = edtEmbalaExit
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtClaIpi: TEditFocus
      Tag = 99
      Left = 532
      Top = 91
      Width = 102
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 12
      OnEnter = edtClaIpiEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 667
      Top = 114
      Width = 116
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 20
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 667
      Top = 137
      Width = 116
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 21
      OnClick = btnCancelaItemClick
    end
    object edtCodCest: TEditFocus
      Tag = 99
      Left = 667
      Top = 91
      Width = 116
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 13
      OnEnter = edtCodCestEnter
      OnKeyPress = edtCodCestKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 994
    Height = 130
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 11
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Entrada:'
    end
    object Label2: TLabel
      Left = 22
      Top = 34
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nro. Documento:'
    end
    object lblCliFor: TLabel
      Left = 43
      Top = 57
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label4: TLabel
      Left = 321
      Top = 34
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object Label5: TLabel
      Left = 252
      Top = 11
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data do Documento:'
    end
    object Label6: TLabel
      Left = 504
      Top = 34
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label8: TLabel
      Left = 491
      Top = 11
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Devolu'#231#227'o:'
      Visible = False
    end
    object ColorLabel1: TColorLabel
      Left = 619
      Top = 11
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Visible = False
      CorDestaque = clRed
    end
    object lblCgcCpf: TLabel
      Left = 512
      Top = 57
      Width = 33
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CNPJ:'
    end
    object lblCotDol: TLabel
      Left = 630
      Top = 34
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cota'#231#227'o do D'#243'lar:'
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 105
      Top = 7
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = mskDtaEntExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 105
      Top = 30
      Width = 96
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnExit = edtNumDocExit
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 352
      Top = 30
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaDoc: TMaskEditFocus
      Tag = 99
      Left = 352
      Top = 7
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnExit = mskDtaDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 549
      Top = 30
      Width = 63
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ParentFont = False
      TabOrder = 4
      OnExit = edtEspDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 105
      Top = 53
      Width = 96
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 202
      Top = 53
      Width = 304
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
    object edtEntDev: TEditFocus
      Left = 549
      Top = 7
      Width = 63
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 7
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCgcCpf: TEditFocus
      Left = 549
      Top = 53
      Width = 135
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCotDol: TEditFocus
      Tag = 99
      Left = 719
      Top = 30
      Width = 82
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object pnlObsFornecedor: TPanel
      Left = 2
      Top = 77
      Width = 990
      Height = 51
      Align = alBottom
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 10
      Visible = False
      object lblObsFornecedor: TLabel
        Left = 34
        Top = 19
        Width = 66
        Height = 14
        Caption = 'Observa'#231#245'es'
      end
      object mmoObsFornecedor: TMemoFocus
        Left = 103
        Top = 0
        Width = 677
        Height = 50
        TabStop = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
  end
  object pnlBotoesEnt: TPanel [6]
    Left = 0
    Top = 573
    Width = 994
    Height = 26
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object btnCancelarEntrada: TBitBtnLocked
      Left = 907
      Top = 2
      Width = 85
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
    end
    object FlwPnlBotoesEntrada: TFlowPanel
      Left = 2
      Top = 2
      Width = 905
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Fechamento'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnAlterPrecos: TBitBtnLocked
        Left = 110
        Top = 0
        Width = 93
        Height = 22
        Caption = '[ F5 ] Pre'#231'os'
        Enabled = False
        TabOrder = 1
        OnClick = btnAlterPrecosClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 203
        Top = 0
        Width = 95
        Height = 22
        Caption = '[ F6 ] Inicia Busca'
        Enabled = False
        TabOrder = 2
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 298
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F7 ] Localiza Pr'#243'xima'
        Enabled = False
        TabOrder = 3
        OnClick = btnLocProxClick
      end
      object btnCadLot: TBitBtnLocked
        Left = 423
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ F8 ] Cad. Lotes'
        TabOrder = 4
        OnClick = btnCadLotClick
      end
      object btnCadProduto: TBitBtnLocked
        Left = 523
        Top = 0
        Width = 107
        Height = 22
        Caption = '[ F9 ] Cad. Produtos'
        TabOrder = 5
        OnClick = btnCadProdutoClick
      end
      object btnApaga: TBitBtnLocked
        Left = 630
        Top = 0
        Width = 93
        Height = 22
        Caption = '[ DEL ] Apaga'
        TabOrder = 6
        Visible = False
        OnClick = btnApagaClick
      end
    end
  end
  object pnlDetalhe: TPanel [7]
    Left = 0
    Top = 542
    Width = 994
    Height = 31
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 7
    object Label28: TLabel
      Left = 493
      Top = 9
      Width = 53
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Itens'
    end
    object Label29: TLabel
      Left = 359
      Top = 9
      Width = 50
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total IPI'
    end
    object Label32: TLabel
      Left = 618
      Top = 9
      Width = 87
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Geral'
    end
    object lblTotSub: TLabel
      Left = 239
      Top = 9
      Width = 50
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Sub.'
    end
    object lblTotAnt: TLabel
      Left = 22
      Top = 9
      Width = 133
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total ICMS Antecipado:'
    end
    object edtTotIpi: TEditFocus
      Left = 413
      Top = 4
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotal: TEditFocus
      Left = 549
      Top = 4
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
    object edtTotGer: TEditFocus
      Left = 711
      Top = 4
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotSub: TEditFocus
      Left = 293
      Top = 4
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotAnt: TEditFocus
      Left = 159
      Top = 4
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlInfAdi: TPanel [8]
    Left = 0
    Top = 516
    Width = 994
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 9
    object Label9: TLabel
      Left = 12
      Top = 6
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de F'#225'brica:'
    end
    object dbeCodFab: TDBEdit
      Left = 106
      Top = 2
      Width = 203
      Height = 22
      TabStop = False
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
    end
  end
  object dbgItensGrid: TcxGrid [9]
    Left = 0
    Top = 292
    Width = 994
    Height = 224
    Align = alClient
    TabOrder = 8
    OnEnter = dbgItensGridEnter
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgItens: TcxGridDBTableView
      OnDblClick = dbgItensDblClick
      OnKeyDown = dbgItensKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgItensCustomDrawCell
      OnEditKeyDown = dbgItensEditKeyDown
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object dbgItensColumNROITE: TcxGridDBColumn
        Caption = 'Seq.'
        DataBinding.FieldName = 'ENT_N_ITEM_TELA'
        Options.Editing = False
        Width = 35
      end
      object dbgItensColumItem: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'ENT_CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 70
      end
      object dbgItensColumDesc: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ENT_DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 180
      end
      object dbgItensDesMarca: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'ENT_DESMAR'
        Options.Editing = False
        Options.Focusing = False
        Width = 134
      end
      object dbgItensColumRef: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ENT_REFERE'
        Options.Editing = False
        Options.Focusing = False
        Width = 60
      end
      object dbgItensColumUnid: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'ENT_CODUNI'
        Options.Editing = False
        Options.Focusing = False
        Width = 104
      end
      object dbgItensColumEmb: TcxGridDBColumn
        Caption = 'Embalagem'
        DataBinding.FieldName = 'ENT_EMBALA'
        Options.Editing = False
        Options.Focusing = False
        Width = 90
      end
      object dbgItensColumQuant: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ENT_QTDITE'
        Width = 86
      end
      object dbgItensColumValUnit: TcxGridDBColumn
        Caption = 'Vr. Unitario'
        DataBinding.FieldName = 'ENT_UNITAR'
        Width = 70
      end
      object dbgItensColumValorTotal: TcxGridDBColumn
        Caption = 'Vr. Total'
        DataBinding.FieldName = 'ENT_TOTITE'
        Width = 62
      end
      object dbgItensColumValorIPI: TcxGridDBColumn
        Caption = 'Valor de IPI'
        DataBinding.FieldName = 'ENT_VALIPI'
        Options.Editing = False
        Options.Focusing = False
        Width = 88
      end
      object dbgItensColumALTITEM: TcxGridDBColumn
        DataBinding.FieldName = 'ENT_ALTITEM'
        Visible = False
      end
    end
    object dbgItenslv: TcxGridLevel
      GridView = dbgItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 360
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 320
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 344
  end
end
