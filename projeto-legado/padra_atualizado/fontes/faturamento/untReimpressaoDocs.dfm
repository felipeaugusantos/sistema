inherited frmReimpressaoDocs: TfrmReimpressaoDocs
  Left = 405
  Top = 270
  Width = 421
  Height = 473
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio de Reimpress'#227'o de Documentos'
  Position = poMainFormCenter
  ExplicitWidth = 421
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 400
    Width = 415
    TabOrder = 1
    ExplicitTop = 400
    ExplicitWidth = 415
    inherited FlwBotoes: TFlowPanel
      Left = 78
      Width = 258
      TabOrder = 1
      ExplicitLeft = 78
      ExplicitWidth = 258
    end
    inherited btnSair: TBitBtnLocked
      Left = 336
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      OnExit = btnSairExit
      ExplicitLeft = 336
      ExplicitTop = 2
      ExplicitHeight = 24
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 428
    Width = 415
    TabOrder = 2
    ExplicitTop = 428
    ExplicitWidth = 415
    inherited pnlNomeForm: TPanel
      Left = 244
      ExplicitLeft = 244
    end
    inherited pnlInfo: TPanel
      Width = 244
      ExplicitWidth = 244
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 415
    Height = 400
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlFiltrosPadrao: TPanel
      Left = 2
      Top = 84
      Width = 411
      Height = 173
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        411
        173)
      object Label1: TLabel
        Left = 14
        Top = 5
        Width = 54
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Documento'
        ExplicitTop = 96
      end
      object Label4: TLabel
        Left = 98
        Top = 5
        Width = 38
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Esp'#233'cie'
        ExplicitTop = 96
      end
      object Label2: TLabel
        Left = 140
        Top = 5
        Width = 25
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'S'#233'rie'
        ExplicitTop = 96
      end
      object lblNumCoo: TLabel
        Left = 178
        Top = 5
        Width = 19
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Coo'
        Visible = False
        ExplicitTop = 96
      end
      object Label12: TLabel
        Left = 14
        Top = 43
        Width = 51
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitTop = 134
      end
      object lblDesDtaIni: TLabel
        Left = 81
        Top = 61
        Width = 105
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = '(DATA DE ENTRADA)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 152
      end
      object Label11: TLabel
        Left = 14
        Top = 86
        Width = 47
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitTop = 177
      end
      object lblDesDtaFin: TLabel
        Left = 81
        Top = 106
        Width = 105
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = '(DATA DE ENTRADA)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 197
      end
      object edtNumCoo: TEditFocus
        Tag = 99
        Left = 178
        Top = 19
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 9
        TabOrder = 3
        Visible = False
        OnChange = edtEspDocChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 9
        TipoTexto = ttInteiro
      end
      object edtSerieDoc: TEditFocus
        Tag = 99
        Left = 138
        Top = 19
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 98
        Top = 19
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 1
        OnChange = edtEspDocChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 14
        Top = 19
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 57
        Width = 63
        Height = 22
        Anchors = [akLeft, akBottom]
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
        TabOrder = 4
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 102
        Width = 64
        Height = 22
        Anchors = [akLeft, akBottom]
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
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object rdgCliFor: TRadioGroup
        Left = 14
        Top = 129
        Width = 392
        Height = 41
        Anchors = [akLeft, akBottom]
        Caption = 'Filtrar Documentos de :'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Cliente'
          'Fornecedor')
        TabOrder = 6
        OnClick = rdgCliForClick
      end
      object rgpNotasFiscais: TRadioGroup
        Left = 244
        Top = 5
        Width = 161
        Height = 113
        Anchors = [akLeft, akBottom]
        Caption = 'Notas Fiscais'
        ItemIndex = 0
        Items.Strings = (
          'Todas'
          'Venda'
          'Devolu'#231#227'o'
          'Exceto Venda e Devolu'#231#227'o')
        TabOrder = 7
        Visible = False
      end
    end
    object pnlBtnCliente: TPanel
      Left = 2
      Top = 257
      Width = 411
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object btnCliOutroVendedor: TBitBtnLocked
        Left = 14
        Top = 3
        Width = 132
        Height = 24
        Align = alCustom
        Caption = 'Cliente de outro vendedor'
        Layout = blGlyphBottom
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = False
        WordWrap = True
        OnClick = btnCliOutroVendedorClick
      end
    end
    object pnlFiltrosRodape: TPanel
      Left = 2
      Top = 284
      Width = 411
      Height = 114
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      DesignSize = (
        411
        114)
      object lblCliFor: TLabel
        Left = 17
        Top = 5
        Width = 32
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitTop = 1
      end
      object Label3: TLabel
        Left = 14
        Top = 45
        Width = 47
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Vendedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitTop = 41
      end
      object shpLiberado: TShape
        Left = 5
        Top = 60
        Width = 8
        Height = 22
        Anchors = [akLeft, akBottom]
        ExplicitTop = 56
      end
      object edtCodCliente: TEditFocus
        Left = 14
        Top = 19
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
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
        TabOrder = 0
        OnExit = edtCodClienteExit
        OnKeyPress = edtCodClienteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCliente: TEditFocus
        Left = 80
        Top = 19
        Width = 326
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
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
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVendedor: TEditFocus
        Tag = 99
        Left = 14
        Top = 60
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
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
        TabOrder = 2
        OnExit = edtCodVendedorExit
        OnKeyPress = edtCodVendedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesVendedor: TEditFocus
        Left = 80
        Top = 60
        Width = 326
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkDocCan: TCheckBox
        Left = 14
        Top = 88
        Width = 278
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Exibir Documentos Cancelados'
        TabOrder = 4
      end
    end
    object pnlCabecalho: TPanel
      Left = 2
      Top = 2
      Width = 411
      Height = 82
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblEmpresa: TLabel
        Left = 14
        Top = 2
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
      object lblVeiculo: TLabel
        Left = 15
        Top = 44
        Width = 35
        Height = 14
        Caption = 'Ve'#237'culo'
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 14
        Top = 18
        Width = 40
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
        TabOrder = 0
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
        Top = 18
        Width = 350
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskPlaVei: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 59
        Width = 82
        Height = 22
        AutoSelect = False
        AutoSize = False
        CharCase = ecUpperCase
        EditMask = 'aaa-9a99;0; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 2
        Text = ''
        OnKeyPress = mskPlaVeiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesVeiculo: TEditFocus
        Left = 98
        Top = 59
        Width = 308
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 480
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 260
    Top = 188
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 192
  end
end
