inherited frmImpressaoCP: TfrmImpressaoCP
  Width = 428
  Height = 594
  BorderIcons = [biSystemMenu]
  Caption = 'Impress'#227'o de Controle de Pagamento'
  Position = poScreenCenter
  ExplicitWidth = 428
  ExplicitHeight = 594
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 520
    Width = 422
    Height = 29
    ExplicitTop = 520
    ExplicitWidth = 422
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 418
      Height = 25
      ExplicitWidth = 418
      ExplicitHeight = 25
      object btnImprimir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 76
        Height = 22
        Anchors = [akRight, akBottom]
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
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 343
      ExplicitLeft = 343
    end
  end
  inherited pnlStatus: TPanel
    Top = 549
    Width = 422
    ExplicitTop = 549
    ExplicitWidth = 422
    inherited pnlNomeForm: TPanel
      Left = 257
      Width = 165
      ExplicitLeft = 257
      ExplicitWidth = 165
    end
    inherited pnlInfo: TPanel
      Width = 257
      ExplicitWidth = 257
      object shpMultSel: TShape
        Left = 240
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas desta rotina possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 422
    Height = 520
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 5
      Width = 62
      Height = 14
      Caption = 'Compet'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 43
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
    object Label7: TLabel
      Left = 118
      Top = 61
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
    object Label6: TLabel
      Left = 202
      Top = 43
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
    object Label8: TLabel
      Left = 312
      Top = 61
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
    object Label12: TLabel
      Left = 8
      Top = 121
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
    object Label3: TLabel
      Left = 8
      Top = 159
      Width = 45
      Height = 14
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
      Left = 8
      Top = 233
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
    object lblPortador: TLabel
      Left = 8
      Top = 311
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 82
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
    object Label10: TLabel
      Left = 117
      Top = 100
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
    object Label11: TLabel
      Left = 202
      Top = 82
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
    object Label13: TLabel
      Left = 312
      Top = 100
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
    object GroupBox1: TGroupBox
      Left = 8
      Top = 349
      Width = 132
      Height = 44
      Caption = 'Veio NF ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      object ColorLabel17: TColorLabel
        Left = 30
        Top = 21
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtVeioNota: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
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
    object gpbBoleto: TGroupBox
      Left = 144
      Top = 349
      Width = 132
      Height = 44
      Caption = 'Veio Boleto ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ColorLabel2: TColorLabel
        Left = 30
        Top = 21
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtBoleto: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
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
    object gpbDeposito: TGroupBox
      Left = 280
      Top = 349
      Width = 132
      Height = 44
      Caption = 'Dep'#243'sito ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      object ColorLabel12: TColorLabel
        Left = 30
        Top = 21
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtDeposito: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
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
    object gpbCheque: TGroupBox
      Left = 8
      Top = 393
      Width = 132
      Height = 44
      Caption = 'Cheque ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      object ColorLabel11: TColorLabel
        Left = 30
        Top = 21
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtCheque: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
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
    object gpbFornFilial: TGroupBox
      Left = 144
      Top = 393
      Width = 132
      Height = 44
      Caption = 'Fornecedor Filial ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 21
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtFornecFilial: TEditFocus
        Tag = 99
        Left = 8
        Top = 17
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
    object edtCodFornecedor: TEditFocus
      Left = 8
      Top = 135
      Width = 61
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
      TabOrder = 5
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 71
      Top = 135
      Width = 340
      Height = 22
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
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAtv: TEditFocus
      Left = 8
      Top = 173
      Width = 61
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
      TabOrder = 7
      OnExit = edtCodAtvExit
      OnKeyPress = edtCodAtvKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAtv: TEditFocus
      Left = 71
      Top = 173
      Width = 340
      Height = 22
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
      TabOrder = 8
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
      Left = 8
      Top = 247
      Width = 61
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
      Left = 71
      Top = 247
      Width = 340
      Height = 22
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
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 8
      Top = 325
      Width = 61
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
      TabOrder = 13
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
    object edtDesPortador: TEditFocus
      Left = 71
      Top = 325
      Width = 340
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
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkExiCreditos: TCheckBox
      Left = 279
      Top = 399
      Width = 133
      Height = 17
      Caption = 'Exibir somente cr'#233'ditos'
      TabOrder = 20
      OnClick = chkExiCreditosClick
    end
    object chkNExiCreditos: TCheckBox
      Left = 279
      Top = 419
      Width = 113
      Height = 17
      Caption = 'N'#227'o exibir cr'#233'ditos'
      TabOrder = 22
      OnClick = chkNExiCreditosClick
    end
    object gpbIncPrevis: TGroupBox
      Left = 10
      Top = 437
      Width = 402
      Height = 44
      Caption = 'Gerar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      object ColorLabel4: TColorLabel
        Left = 37
        Top = 19
        Width = 97
        Height = 14
        Caption = 'Apenas (P)revis'#245'es'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 172
        Top = 19
        Width = 80
        Height = 14
        Caption = '(S)em Previs'#245'es'
        CorDestaque = clRed
      end
      object ColorLabel6: TColorLabel
        Left = 290
        Top = 19
        Width = 38
        Height = 14
        Caption = '(T)odos'
        CorDestaque = clRed
      end
      object edtIncPrevis: TEditFocus
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
    object mskDtaIniC: TcxDateEdit
      Tag = 99
      Left = 8
      Top = 57
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
      Width = 105
    end
    object mskDtaFinC: TcxDateEdit
      Tag = 99
      Left = 202
      Top = 57
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
      TabOrder = 2
      Width = 105
    end
    object mskDtaIniV: TcxDateEdit
      Tag = 99
      Left = 8
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
      TabOrder = 3
      Width = 105
    end
    object mskDtaFinV: TcxDateEdit
      Tag = 99
      Left = 202
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
      TabOrder = 4
      Width = 105
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 75
      Height = 22
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 0
      Top = 196
      Width = 419
      Height = 36
      TabOrder = 9
      ExplicitTop = 196
      ExplicitWidth = 419
      ExplicitHeight = 36
      inherited lblEventos: TLabel
        Left = 8
        Top = 0
        Width = 84
        Height = 14
        Alignment = taLeftJustify
        Caption = 'Centro de Custos'
        ExplicitLeft = 8
        ExplicitTop = 0
        ExplicitWidth = 84
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Left = 8
        Top = 14
        Width = 62
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        ExplicitLeft = 8
        ExplicitTop = 14
        ExplicitWidth = 62
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 72
        Top = 14
        Width = 339
        Height = 22
        ExplicitLeft = 72
        ExplicitTop = 14
        ExplicitWidth = 339
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 7
      Top = 272
      Width = 408
      Height = 39
      TabOrder = 12
      ExplicitLeft = 7
      ExplicitTop = 272
      ExplicitWidth = 408
      ExplicitHeight = 39
      inherited lblPlaContas: TLabel
        Left = 2
        Top = 0
        Width = 81
        Height = 14
        ExplicitLeft = 2
        ExplicitTop = 0
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 64
        Top = 15
        Width = 340
        Height = 22
        ExplicitLeft = 64
        ExplicitTop = 15
        ExplicitWidth = 340
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 1
        Top = 15
        Width = 61
        Height = 22
        OnExit = fraPlanoDeContasMskCodCtaExit
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 1
        ExplicitTop = 15
        ExplicitWidth = 61
        ExplicitHeight = 22
      end
    end
    object chkLancDeb: TCheckBox
      Left = 19
      Top = 490
      Width = 310
      Height = 17
      Caption = 'Mostrar esp'#233'cie LD - (Lan'#231'amento de D'#233'bito Caixa)'
      TabOrder = 23
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 680
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 744
    Top = 224
  end
end
