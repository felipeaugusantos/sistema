inherited frmReqEnvioMatVidro: TfrmReqEnvioMatVidro
  Left = 124
  Top = 185
  Width = 884
  Height = 600
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Requisi'#231#227'o de Envio de Materiais - Vidro'
  Position = poMainFormCenter
  ExplicitWidth = 884
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object pgbItens: TProgressBar [0]
    Left = 0
    Top = 515
    Width = 878
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 9
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 487
    Width = 878
    TabOrder = 8
    ExplicitTop = 487
    ExplicitWidth = 878
    DesignSize = (
      878
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 874
      ExplicitWidth = 874
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 5
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlItem: TPanel [4]
    Left = 0
    Top = 161
    Width = 878
    Height = 136
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label7: TLabel
      Left = 74
      Top = 12
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 40
      Top = 37
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 38
      Top = 113
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 213
      Top = 113
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 420
      Top = 113
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 369
      Top = 37
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 19
      Top = 63
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Movimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 458
      Top = 37
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTipoEntSai: TColorLabel
      Left = 142
      Top = 63
      Width = 83
      Height = 14
      Caption = '(E)ntrada (S)a'#237'da'
      CorDestaque = clRed
    end
    object lblNumLot: TLabel
      Left = 607
      Top = 12
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote:'
    end
    object lblComPec: TLabel
      Left = 174
      Top = 87
      Width = 48
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Altura:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblLarPec: TLabel
      Left = 359
      Top = 87
      Width = 49
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Largura:'
    end
    object lblQtdMadeira: TLabel
      Left = 93
      Top = 87
      Width = 3
      Height = 14
      Alignment = taRightJustify
    end
    object lblMedCom: TLabel
      Tag = 99
      Left = 342
      Top = 87
      Width = 14
      Height = 14
      Caption = 'cm'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblMedLar: TLabel
      Tag = 99
      Left = 516
      Top = 87
      Width = 14
      Height = 14
      Caption = 'cm'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 99
      Top = 9
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 99
      Top = 109
      Width = 103
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtUnitar: TEditFocus
      Left = 283
      Top = 109
      Width = 126
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
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
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtTotIte: TEditFocus
      Left = 478
      Top = 109
      Width = 120
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
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
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtEntSai: TEditFocus
      Tag = 99
      Left = 99
      Top = 59
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 6
      Text = 'S'
      OnEnter = edtEntSaiEnter
      OnKeyPress = edtEntSaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesIte: TEditFocus
      Left = 156
      Top = 9
      Width = 442
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 99
      Top = 34
      Width = 265
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 414
      Top = 34
      Width = 35
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSaldos: TEditFocus
      Left = 497
      Top = 34
      Width = 101
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 633
      Top = 9
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 2
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 619
      Top = 88
      Width = 103
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
      TabOrder = 13
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 619
      Top = 110
      Width = 103
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
      TabOrder = 14
      OnClick = btnCancelaItemClick
    end
    object edtComPec: TEditFocus
      Tag = 99
      Left = 223
      Top = 84
      Width = 117
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtLarPec: TEditFocus
      Tag = 99
      Left = 410
      Top = 84
      Width = 104
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtQtdPec: TEditFocus
      Tag = 99
      Left = 99
      Top = 84
      Width = 71
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object btnImportarArqTxt: TBitBtnLocked
      Left = 619
      Top = 60
      Width = 103
      Height = 22
      Caption = '&Importar Lista'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000000000
        000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000000000
        000000000000000000003C3C3CFF3C3C3CFF0000000000000000000000000000
        0000000000000000000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF000000003C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000001E1E1E80000000003C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF1E1E1E80000000001E1E1E803C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000001E1E1E80000000003C3C3CFF3C3C
        3CFF000000003C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF0000
        000000000000000000003C3C3CFF000000003C3C3CFF000000003C3C3CFF0000
        000000000000000000003C3C3CFF000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000003C3C3CFF3C3C3CFF000000000000
        000000000000000000003C3C3CFF3C3C3CFF0000000000000000000000000000
        0000000000000000000000000000000000003C3C3CFF3C3C3CFF000000000000
        000000000000000000003C3C3CFF3C3C3CFF0000000000000000000000000000
        0000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF000000000000
        000000000000000000003C3C3CFF3C3C3CFF0000000000000000000000000000
        0000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000
        000000000000000000003C3C3CFF3C3C3CFF0000000000000000000000000000
        0000000000003C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E00000000000000000000
        000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF3C3C3CFF1E1E1E7E0000000000000000000000000000
        000000000000000000003C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C3CFF3C3C
        3CFF3C3C3CFF3C3C3CFF1E1E1E7E000000000000000000000000}
      TabOrder = 15
      TabStop = False
      OnClick = btnImportarArqTxtClick
    end
  end
  object pnlBotoesEnt: TPanel [5]
    Left = 0
    Top = 526
    Width = 878
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 25
      Align = alLeft
      Caption = '[ F10 ] Fechamento'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 765
      Top = 2
      Width = 111
      Height = 25
      Align = alRight
      Caption = '[ Esc ] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
    end
    object btnEstLoj: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 119
      Height = 25
      Align = alLeft
      Caption = '[ F6 ] Estoque Lojas'
      Enabled = False
      TabOrder = 2
      OnClick = btnEstLojClick
    end
  end
  object pnlDocumento: TPanel [6]
    Left = 0
    Top = 0
    Width = 878
    Height = 54
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label5: TLabel
      Left = 39
      Top = 9
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label1: TLabel
      Left = 51
      Top = 31
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 185
      Top = 9
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 99
      Top = 5
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 99
      Top = 28
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 228
      Top = 5
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 1
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 180
      Top = 28
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  object pnlDados: TPanel [7]
    Left = 0
    Top = 54
    Width = 878
    Height = 77
    Align = alTop
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 61
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label6: TLabel
      Left = 46
      Top = 31
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label9: TLabel
      Left = 446
      Top = 31
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Emiss'#227'o:'
    end
    object Label3: TLabel
      Left = 35
      Top = 54
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pagto:'
    end
    object Label12: TLabel
      Left = 461
      Top = 54
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
    end
    object edtNomCli: TEditFocus
      Left = 99
      Top = 4
      Width = 499
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomVen: TEditFocus
      Left = 99
      Top = 27
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDtaEmi: TEditFocus
      Tag = 99
      Left = 517
      Top = 27
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtConPag: TEditFocus
      Left = 99
      Top = 51
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtValDoc: TEditFocus
      Tag = 99
      Left = 517
      Top = 51
      Width = 81
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  object pnlGrid: TPanel [8]
    Left = 0
    Top = 297
    Width = 878
    Height = 190
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 3
    object cxgItens: TcxGrid
      Left = 1
      Top = 1
      Width = 876
      Height = 188
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItensView: TcxGridDBTableView
        OnKeyDown = cxgItensViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsRequisicao
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            FieldName = 'ITE_ENTFUT'
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        object cxgITE_CODITE: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'ITE_CODITE'
          Width = 50
        end
        object cxgITE_DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'ITE_DESITE'
          Width = 250
        end
        object cxgITE_ENTSAI: TcxGridDBColumn
          Caption = 'E/S'
          DataBinding.FieldName = 'ITE_ENTSAI'
          Width = 22
        end
        object cxgITE_REFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'ITE_REFERE'
          Width = 118
        end
        object cxgITE_CODUNI: TcxGridDBColumn
          Caption = 'UN'
          DataBinding.FieldName = 'ITE_CODUNI'
          Width = 35
        end
        object cxgITE_SALDIS: TcxGridDBColumn
          Caption = 'Saldo Dispon'#237'vel'
          DataBinding.FieldName = 'ITE_SALDIS'
          HeaderAlignmentHorz = taRightJustify
          Width = 110
        end
        object cxgITE_QTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'ITE_QTDITE'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 93
        end
        object cxgITE_UNITAR: TcxGridDBColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'ITE_UNITAR'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 95
        end
        object cxgITE_TOTITE: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'ITE_TOTITE'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 98
        end
      end
      object cxgItenslevel: TcxGridLevel
        GridView = cxgItensView
      end
    end
  end
  object pnlDetalhe: TPanel [9]
    Left = 0
    Top = 487
    Width = 878
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 10
    object Label32: TLabel
      Left = 610
      Top = 8
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtTotGer: TEditFocus
      Left = 769
      Top = 3
      Width = 98
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDigitador: TPanel [10]
    Left = 0
    Top = 131
    Width = 878
    Height = 30
    Align = alTop
    Color = 16770261
    TabOrder = 11
    object lblDigita: TLabel
      Left = 51
      Top = 8
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 99
      Top = 4
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 156
      Top = 4
      Width = 442
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnDevEntrada: TBitBtnLocked
      Left = 619
      Top = 4
      Width = 126
      Height = 22
      Caption = '&Devolu'#231#227'o - entrada'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000001000000050000000D0000000F00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000020000000A170F093B72472CC3A1643DFF00000010000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        00060604031955382594AB754CF9D5A670FFA56942FF00000022000000110000
        000D000000080000000300000000000000000000000000000000000000053525
        195F9A6A48E5CB9C6DFFE8C089FFE8C189FFA86F48FF88512EFC724125E4532E
        17B92F1A0D7B090502270000000700000001000000000000000000000008BD8D
        64FFECD4B3FFF1D8ACFFEBCA95FFEAC68FFFE7CBA4FFF2DBB9FFE1C39EFFC59D
        74FFA16F47FF512C16BE1B0E065200000008000000010000000000000004392C
        1F59A8815EE2DBBB97FFF3DFBDFFF0D4A6FFC69C74FFBB8B62FFC49870FFD3AE
        89FFE0C29BFFB78A60FF5C351CCB120A043E0000000400000000000000010000
        000407050415614B378CC39D76F9E7CEADFFC1936AFF060503242B21174E644A
        359AB48F6BECD7B891FFAB7E56FF3C2110970000000A00000000000000020000
        00080000000B0000000F1A140F328A6C4FBBC79A70FF0000000C000000040000
        000C56412F86D2AD87FFD8BD9DFF60351CD50000000F00000000000000062379
        49F9237B4AFF247A4AFF030A06220000000900000009000000060000000A0000
        000B100C0927C5996FFFC4986EFFAE7C57F90000000D0000000000000005246E
        49CE5BC49EFF308E62FF0D311C7E00000008000000030000000A247B4AFF0A37
        1ABF020B053900000015000000110000000D000000030000000000000003194B
        32885BB691FF6DC3A6FF2F7A54EA103B229107190F470104021C267F4DFF34A5
        78FF17633BF9092B169101030218000000060000000100000000000000010919
        112F2C7451C07AC8AAFF8BD7BFFF56A886FF33875DFF207345FF3A976AFF6ADA
        BBFF4BC89FFF30966AFF145530E5061D0F5F0000000600000000000000000000
        00020E251A41266C4BB263BB96FF8AD3BAFFA8E7D6FFBAF3E7FFA4E4D2FF89EA
        D5FF77E1C6FF75DDBDFF80D7BCFF278551FF0000000A00000000000000000000
        000000000002050D091A17412D6A276D4CAD338E64DF3AA06FFB3AA271FF9EF0
        E0FFB4F1E5FF6EC5A3FF348B60E1102E1F5A0000000500000000000000000000
        000000000000000000010000000200000004000000050000000C3EA977FF9AE0
        C9FF4CAC82F81E52398902060415000000040000000100000000000000000000
        000000000000000000000000000000000000000000000000000541AF7DFF2D79
        56B70816102B0000000500000001000000000000000000000000}
      TabOrder = 2
      TabStop = False
      OnClick = btnDevEntradaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 878
    TabOrder = 6
    ExplicitTop = 555
    ExplicitWidth = 878
    inherited pnlNomeForm: TPanel
      Left = 731
      Width = 147
      ExplicitLeft = 731
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 731
      ExplicitWidth = 731
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 304
  end
  object dtsRequisicao: TDataSource
    OnDataChange = dtsRequisicaoDataChange
    Left = 360
    Top = 304
  end
end
