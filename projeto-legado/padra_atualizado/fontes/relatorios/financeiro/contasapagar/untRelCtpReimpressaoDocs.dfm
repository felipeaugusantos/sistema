inherited frmRelCtpReimpressaoDoc: TfrmRelCtpReimpressaoDoc
  Width = 310
  Height = 274
  Caption = 'Reimpress'#227'o de Duplicatas Pagas'
  Position = poMainFormCenter
  ExplicitWidth = 310
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 201
    Width = 304
    TabOrder = 1
    ExplicitTop = 201
    ExplicitWidth = 304
    inherited FlwBotoes: TFlowPanel
      Left = 78
      Width = 147
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 300
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 225
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 221
    end
    object btnImprimir: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 76
      Height = 24
      Align = alLeft
      Caption = '&Imprimir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnImprimirClick
      ExplicitLeft = 5
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 304
    Height = 201
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      304
      201)
    object Label1: TLabel
      Left = 8
      Top = 2
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label11: TLabel
      Left = 8
      Top = 75
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
    object lblDesDtaIni: TLabel
      Left = 96
      Top = 55
      Width = 123
      Height = 14
      Caption = '(DATA DE PAGAMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel
      Left = 96
      Top = 92
      Width = 123
      Height = 14
      Caption = '(DATA DE PAGAMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 38
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
    object lblEmpresa: TLabel
      Left = 8
      Top = 112
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
    object Label2: TLabel
      Left = 8
      Top = 148
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 15
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      OnChange = edtNumDocChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 126
      Width = 29
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
      TabOrder = 3
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
      Top = 126
      Width = 257
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
    object edtCodFor: TEditFocus
      Left = 8
      Top = 162
      Width = 64
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
      Top = 162
      Width = 222
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
      ParentFont = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 8
      Top = 51
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
        79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
        DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
        35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
        BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
        B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
        FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
        30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
        F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
        78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
        16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
        A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
        7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
        48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
        67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
        43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
        F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
        3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
        ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
        49454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      TabOrder = 1
      Width = 82
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 8
      Top = 88
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
        79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
        DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
        35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
        BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
        B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
        FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
        30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
        F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
        78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
        16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
        A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
        7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
        48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
        67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
        43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
        F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
        3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
        ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
        49454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      TabOrder = 2
      Width = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 229
    Width = 304
    TabOrder = 2
    ExplicitTop = 229
    ExplicitWidth = 304
    inherited pnlNomeForm: TPanel
      Left = 160
      Width = 144
      ExplicitLeft = 160
      ExplicitWidth = 144
    end
    inherited pnlInfo: TPanel
      Width = 160
      ExplicitWidth = 160
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 48
  end
end
