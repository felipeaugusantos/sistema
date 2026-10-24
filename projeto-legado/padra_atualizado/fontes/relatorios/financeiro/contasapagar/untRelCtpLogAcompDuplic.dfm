inherited frmRelCtpLogAcompDuplic: TfrmRelCtpLogAcompDuplic
  Width = 800
  Height = 576
  Caption = 'Relat'#243'rio de Log de Acompanhamento das Duplicatas'
  Position = poDesigned
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 503
    Width = 794
    TabOrder = 2
    ExplicitTop = 503
    ExplicitWidth = 794
    object lblCampoAlterados2: TLabel [0]
      Left = 536
      Top = 6
      Width = 87
      Height = 14
      Caption = 'Campos alterados'
      Color = clBtnFace
      ParentColor = False
      Visible = False
    end
    object Shp_inferior: TShape [1]
      Left = 505
      Top = 6
      Width = 25
      Height = 14
      Brush.Color = 8417535
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 373
      Align = alLeft
      ExplicitWidth = 373
      object btnGeraCSV: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 115
        Height = 22
        Caption = '&Gerar Arquivo CSV'
        TabOrder = 1
        OnClick = btnGeraCSVClick
      end
      object btnAcompLogCtpDet: TBitBtnLocked
        Left = 115
        Top = 0
        Width = 240
        Height = 22
        Caption = '&Exibir Acompanhamento do Desmembramento'
        Enabled = False
        TabOrder = 0
        OnClick = btnAcompLogCtpDetClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 704
      Top = 2
      Width = 85
      Caption = '&Cancelar'
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
      ExplicitLeft = 704
      ExplicitTop = 2
      ExplicitWidth = 85
    end
  end
  inherited pnlStatus: TPanel
    Top = 531
    Width = 794
    TabOrder = 3
    ExplicitTop = 531
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 177
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      794
      177)
    object Label12: TLabel
      Left = 13
      Top = 31
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 27
      Top = 54
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 15
      Top = 8
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label3: TLabel
      Left = 175
      Top = 8
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Parcela:'
    end
    object Label4: TLabel
      Left = 18
      Top = 101
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 164
      Top = 101
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 271
      Top = 8
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object Label6: TLabel
      Left = 301
      Top = 101
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = '( CADASTRO )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 18
      Top = 127
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 164
      Top = 127
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 301
      Top = 127
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = '( VENCIMENTO )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 23
      Top = 78
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 74
      Top = 51
      Width = 62
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
      TabOrder = 5
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
      Left = 138
      Top = 51
      Width = 471
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
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFornecedor: TEditFocus
      Tag = 99
      Left = 74
      Top = 28
      Width = 62
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
      TabOrder = 3
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFornecedor: TEditFocus
      Left = 138
      Top = 28
      Width = 471
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
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 74
      Top = 5
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtParcel: TEditFocus
      Tag = 99
      Left = 216
      Top = 5
      Width = 26
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 301
      Top = 5
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object btnConsultar: TBitBtnLocked
      Left = 618
      Top = 107
      Width = 111
      Height = 24
      Caption = 'C&onsultar'
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
      OnClick = btnConsultarClick
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 74
      Top = 97
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
      TabOrder = 8
      Width = 82
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 216
      Top = 97
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
      TabOrder = 9
      Width = 82
    end
    object mskDtaFinVen: TcxDateEdit
      Tag = 99
      Left = 216
      Top = 123
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
      TabOrder = 11
      Width = 82
    end
    object mskDtaIniVen: TcxDateEdit
      Tag = 99
      Left = 74
      Top = 123
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
      TabOrder = 10
      Width = 82
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 74
      Top = 74
      Width = 62
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
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomeOpe: TEditFocus
      Left = 138
      Top = 74
      Width = 471
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
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbRegcomAlteracao: TGroupBox
      Left = 392
      Top = 99
      Width = 218
      Height = 73
      Caption = 'Somente Registros com Altera'#231#227'o'
      TabOrder = 12
      object Label11: TLabel
        Left = 6
        Top = 33
        Width = 54
        Height = 14
        Caption = 'Informa'#231#227'o'
      end
      object chkRegComAlteracao: TCheckBox
        Left = 6
        Top = 16
        Width = 206
        Height = 17
        Caption = 'Mostrar somente registros c/ altera'#231#227'o'
        TabOrder = 0
        OnClick = chkRegComAlteracaoClick
      end
      object cmbInfRegAlterado: TComboBox
        Left = 6
        Top = 47
        Width = 205
        Height = 22
        TabOrder = 1
        Items.Strings = (
          'Data de Vencimento'
          'Portador'
          'Valor da Duplicata')
      end
    end
    object GroupBox1: TGroupBox
      Left = 641
      Top = 4
      Width = 151
      Height = 50
      Anchors = [akTop, akRight]
      Caption = 'Legenda de cores'
      TabOrder = 15
      object Shape1: TShape
        Left = 16
        Top = 24
        Width = 25
        Height = 14
        Brush.Color = 8417535
      end
      object Label13: TLabel
        Left = 47
        Top = 24
        Width = 87
        Height = 14
        Caption = 'Campos alterados'
      end
    end
  end
  object dbgConsulta: TcxGrid [3]
    Left = 0
    Top = 177
    Width = 794
    Height = 326
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgConsultaDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgConsultaDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para adicionar um filtro'
      FilterRow.SeparatorColor = clActiveBorder
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OnCustomDrawGroupCell = dbgConsultaDBTableView1CustomDrawGroupCell
      object dbgConsultaDBTableView1CTP_DTALOG: TcxGridDBColumn
        Caption = 'Data Log.'
        DataBinding.FieldName = 'CTP_DTALOG'
        Options.AutoWidthSizable = False
        Width = 65
      end
      object dbgConsultaDBTableView1CTP_HORLOG: TcxGridDBColumn
        Caption = 'Hora Log.'
        DataBinding.FieldName = 'CTP_HORLOG'
        Options.AutoWidthSizable = False
      end
      object dbgConsultaDBTableView1CTP_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CTP_DESCRI'
        Options.AutoWidthSizable = False
        Width = 150
      end
      object dbgConsultaDBTableView1CTP_NOMFRM: TcxGridDBColumn
        Caption = 'Nome do Formul'#225'rio'
        DataBinding.FieldName = 'CTP_NOMFRM'
        Options.AutoWidthSizable = False
        Width = 101
      end
      object dbgConsultaDBTableView1CTP_OPELOG: TcxGridDBColumn
        Caption = 'C'#243'd. Operador Log.'
        DataBinding.FieldName = 'CTP_OPELOG'
        Options.AutoWidthSizable = False
        Width = 101
      end
      object dbgConsultaDBTableView1CTP_NUMDUP: TcxGridDBColumn
        Caption = 'Num. Doc'
        DataBinding.FieldName = 'CTP_NUMDUP'
        Options.AutoWidthSizable = False
        Width = 85
      end
      object dbgConsultaDBTableView1CTP_PARCEL: TcxGridDBColumn
        Caption = 'Parcela'
        DataBinding.FieldName = 'CTP_PARCEL'
        Options.AutoWidthSizable = False
        Width = 65
      end
      object dbgConsultaDBTableView1CTP_CODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Fornecedor'
        DataBinding.FieldName = 'CTP_CODFOR'
        Options.AutoWidthSizable = False
        Width = 75
      end
      object dbgConsultaDBTableView1CTP_CODEMP: TcxGridDBColumn
        Caption = 'Cod. Empresa'
        DataBinding.FieldName = 'CTP_CODEMP'
        Options.AutoWidthSizable = False
        Width = 84
      end
      object dbgConsultaDBTableView1CTP_SEQBAI: TcxGridDBColumn
        Caption = 'Seq. Baixa'
        DataBinding.FieldName = 'CTP_SEQBAI'
        Options.AutoWidthSizable = False
        Width = 76
      end
      object dbgConsultaDBTableView1CTP_CODVEN: TcxGridDBColumn
        Caption = 'C'#243'd. Vendedor'
        DataBinding.FieldName = 'CTP_CODVEN'
        Options.AutoWidthSizable = False
        Width = 95
      end
      object dbgConsultaDBTableView1CTP_CODPOR: TcxGridDBColumn
        Caption = 'C'#243'd. Portador'
        DataBinding.FieldName = 'CTP_CODPOR'
        Options.AutoWidthSizable = False
        Width = 83
      end
      object dbgConsultaDBTableView1CTP_DTACAD: TcxGridDBColumn
        Caption = 'Data Cadastro'
        DataBinding.FieldName = 'CTP_DTACAD'
        Options.AutoWidthSizable = False
        Width = 90
      end
      object dbgConsultaDBTableView1CTP_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTP_DTAVEN'
        Options.AutoWidthSizable = False
        Width = 74
      end
      object dbgConsultaDBTableView1CTP_VALDUP: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CTP_VALDUP'
        Options.AutoWidthSizable = False
        Width = 70
      end
      object dbgConsultaDBTableView1CTP_VALORI: TcxGridDBColumn
        Caption = 'Valor Original'
        DataBinding.FieldName = 'CTP_VALORI'
        Options.AutoWidthSizable = False
        Width = 82
      end
      object dbgConsultaDBTableView1CTP_OUTENT: TcxGridDBColumn
        Caption = 'Outras Ent.'
        DataBinding.FieldName = 'CTP_OUTENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Properties.ReadOnly = True
        Options.Editing = False
      end
      object dbgConsultaDBTableView1CTP_HIST01: TcxGridDBColumn
        Caption = 'Hist'#243'rico 1'
        DataBinding.FieldName = 'CTP_HIST01'
        Options.AutoWidthSizable = False
        Width = 198
      end
      object dbgConsultaDBTableView1CTP_HIST02: TcxGridDBColumn
        Caption = 'Hist'#243'rico 2'
        DataBinding.FieldName = 'CTP_HIST02'
        Options.AutoWidthSizable = False
        Width = 168
      end
      object dbgConsultaDBTableView1CTP_PORBAI: TcxGridDBColumn
        Caption = 'Portador da Baixa'
        DataBinding.FieldName = 'CTP_PORBAI'
        Options.AutoWidthSizable = False
        Width = 99
      end
      object dbgConsultaDBTableView1CTP_HISBAI: TcxGridDBColumn
        Caption = 'Hist'#243'rico da Baixa'
        DataBinding.FieldName = 'CTP_HISBAI'
        Options.AutoWidthSizable = False
        Width = 184
      end
      object dbgConsultaDBTableView1CTP_CTABAI: TcxGridDBColumn
        Caption = 'Pl. Contas da Baixa'
        DataBinding.FieldName = 'CTP_CTABAI'
        Options.AutoWidthSizable = False
        Width = 100
      end
      object dbgConsultaDBTableView1CTP_OPEBAI: TcxGridDBColumn
        Caption = 'Ope. Baixa'
        DataBinding.FieldName = 'CTP_OPEBAI'
        Options.AutoWidthSizable = False
        Width = 85
      end
      object dbgConsultaDBTableView1CTP_DTAPAG: TcxGridDBColumn
        Caption = 'Data de Pag.'
        DataBinding.FieldName = 'CTP_DTAPAG'
        Options.AutoWidthSizable = False
        Width = 85
      end
      object dbgConsultaDBTableView1CTP_VALPAG: TcxGridDBColumn
        Caption = 'Valor Pag.'
        DataBinding.FieldName = 'CTP_VALPAG'
        Options.AutoWidthSizable = False
        Width = 93
      end
      object dbgConsultaDBTableView1CTP_VALJUR: TcxGridDBColumn
        Caption = 'Valor do Juros'
        DataBinding.FieldName = 'CTP_VALJUR'
        Options.AutoWidthSizable = False
        Width = 100
      end
      object dbgConsultaDBTableView1CTP_VALDES: TcxGridDBColumn
        Caption = 'Valor Desc.'
        DataBinding.FieldName = 'CTP_VALDES'
        Options.AutoWidthSizable = False
        Width = 74
      end
      object dbgConsultaDBTableView1CTP_BCOENV: TcxGridDBColumn
        Caption = 'Envio Banco'
        DataBinding.FieldName = 'CTP_BCOENV'
        Options.AutoWidthSizable = False
        Width = 91
      end
      object dbgConsultaDBTableView1CTP_DTAENV: TcxGridDBColumn
        Caption = 'Data Envio'
        DataBinding.FieldName = 'CTP_DTAENV'
        Options.AutoWidthSizable = False
        Width = 80
      end
      object dbgConsultaDBTableView1CTP_CODEVE: TcxGridDBColumn
        Caption = 'C'#243'd. Ctr.Custos'
        DataBinding.FieldName = 'CTP_CODEVE'
        Options.AutoWidthSizable = False
        Width = 84
      end
      object dbgConsultaDBTableView1CTP_CODCTA: TcxGridDBColumn
        Caption = 'C'#243'd. Pl. Contas'
        DataBinding.FieldName = 'CTP_CODCTA'
        Options.AutoWidthSizable = False
        Width = 94
      end
      object dbgConsultaDBTableView1CTP_EMPBAI: TcxGridDBColumn
        Caption = 'C'#243'd. Emp. Baixa'
        DataBinding.FieldName = 'CTP_EMPBAI'
        Options.AutoWidthSizable = False
        Width = 97
      end
      object dbgConsultaDBTableView1Duplicata: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'DUPLIC'
        Visible = False
        GroupIndex = 0
        Options.AutoWidthSizable = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 65
      end
      object dbgConsultaDBTableView1Column1: TcxGridDBColumn
        Caption = 'Motivo Estorno'
        DataBinding.FieldName = 'MotEst'
        Width = 400
      end
      object dbgConsultaDBTableView1CTP_VEIOBO: TcxGridDBColumn
        Caption = 'Veio Boleto?'
        DataBinding.FieldName = 'CTP_VEIOBO'
        OnGetDataText = dbgConsultaDBTableView1CTP_VEIOBOGetDataText
        Options.AutoWidthSizable = False
        Width = 68
      end
      object dbgConsultaDBTableView1CTP_VEIONF: TcxGridDBColumn
        Caption = 'Veio NF?'
        DataBinding.FieldName = 'CTP_VEIONF'
        OnGetDataText = dbgConsultaDBTableView1CTP_VEIONFGetDataText
        Options.AutoWidthSizable = False
        Width = 50
      end
      object dbgConsultaDBTableView1CTP_PREVIS: TcxGridDBColumn
        Caption = 'Previs'#227'o?'
        DataBinding.FieldName = 'CTP_PREVIS'
        OnGetDataText = dbgConsultaDBTableView1CTP_PREVISGetDataText
        Options.AutoWidthSizable = False
        Width = 56
      end
      object dbgConsultaDBTableView1CTP_USACHQ: TcxGridDBColumn
        Caption = 'Cheque?'
        DataBinding.FieldName = 'CTP_USACHQ'
        OnGetDataText = dbgConsultaDBTableView1CTP_USACHQGetDataText
        Options.AutoWidthSizable = False
        Width = 51
      end
      object dbgConsultaDBTableView1CTP_PAGANT: TcxGridDBColumn
        Caption = 'Pagto. Antecipado?'
        DataBinding.FieldName = 'CTP_PAGANT'
        OnGetDataText = dbgConsultaDBTableView1CTP_PAGANTGetDataText
        Options.AutoWidthSizable = False
        Width = 101
      end
      object dbgConsultaDBTableView1CTP_DEPOSI: TcxGridDBColumn
        Caption = 'Dep'#243'sito?'
        DataBinding.FieldName = 'CTP_DEPOSI'
        OnGetDataText = dbgConsultaDBTableView1CTP_DEPOSIGetDataText
        Options.AutoWidthSizable = False
        Width = 57
      end
      object dbgConsultaDBTableView1CTP_USOCON: TcxGridDBColumn
        Caption = 'Uso e Consumo?'
        DataBinding.FieldName = 'CTP_USOCON'
        OnGetDataText = dbgConsultaDBTableView1CTP_USOCONGetDataText
        Options.AutoWidthSizable = False
        Width = 89
      end
      object dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn
        DataBinding.FieldName = 'ALTERACOES'
        Visible = False
        VisibleForCustomization = False
      end
      object dbgConsultaDBTableView1CTP_NOMEXE: TcxGridDBColumn
        Caption = 'Nome EXE'
        DataBinding.FieldName = 'CTP_NOMEXE'
        Width = 130
      end
      object dbgConsultaDBTableView1CTP_DTAEXE: TcxGridDBColumn
        Caption = 'Data EXE'
        DataBinding.FieldName = 'CTP_DTAEXE'
        Width = 65
      end
      object dbgConsultaDBTableView1CTP_HOREXE: TcxGridDBColumn
        Caption = 'Hora EXE'
        DataBinding.FieldName = 'CTP_HOREXE'
      end
      object dbgConsultaDBTableView1CTP_VEREXE: TcxGridDBColumn
        Caption = 'Vers'#227'o EXE'
        DataBinding.FieldName = 'CTP_VEREXE'
        Width = 95
      end
    end
    object dbgConsultaLevel1: TcxGridLevel
      GridView = dbgConsultaDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 720
    Top = 60
  end
  object cxsrConsulta: TcxStyleRepository
    Left = 686
    Top = 117
    PixelsPerInch = 96
  end
end
