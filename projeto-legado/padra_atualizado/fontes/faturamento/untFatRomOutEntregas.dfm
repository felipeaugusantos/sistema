inherited frmFatRomOutEntregas: TfrmFatRomOutEntregas
  Left = 240
  Top = 305
  Width = 701
  Height = 520
  BorderStyle = bsDialog
  Caption = 'Digita'#231#227'o de Outras Entregas Romaneio'
  Position = poMainFormCenter
  ExplicitWidth = 701
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 475
    Width = 695
    TabOrder = 8
    ExplicitTop = 475
    ExplicitWidth = 695
    inherited FlwBotoes: TFlowPanel
      Width = 691
      ExplicitWidth = 691
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 695
    TabOrder = 7
    ExplicitTop = 475
    ExplicitWidth = 695
    inherited pnlNomeForm: TPanel
      Left = 524
      ExplicitLeft = 524
    end
    inherited pnlInfo: TPanel
      Width = 524
      ExplicitWidth = 524
    end
  end
  inherited pgcDados: TPageControl
    Width = 73
    Height = 33
    Align = alNone
    TabOrder = 6
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object dbgOutEnt: TDBGridCitel [3]
    Left = 0
    Top = 281
    Width = 695
    Height = 194
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgOutEntDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DIG_DTAETR'
        Title.Caption = 'Data Entrega'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_CODREG'
        Title.Caption = 'Regi'#227'o'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_CODCLI'
        Title.Caption = 'Cliente'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DIG_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_ENDCON'
        Title.Caption = 'Endere'#231'o'
        Width = 241
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_BAIRRO'
        Title.Caption = 'Bairro'
        Width = 156
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_CEPCON'
        Title.Caption = 'CEP'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_NOMCID'
        Title.Caption = 'Cidade'
        Width = 138
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_ESTADO'
        Title.Caption = 'UF'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_PESBRU'
        Title.Caption = 'Peso Total'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIG_VALDOC'
        Title.Caption = 'Valor Doc.'
        Width = 70
        Visible = True
      end>
  end
  object pnlDigitacao: TPanel [4]
    Left = 0
    Top = 0
    Width = 695
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object lblRegiao: TLabel
      Left = 52
      Top = 39
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object Label2: TLabel
      Left = 8
      Top = 11
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Entrega:'
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 94
      Top = 35
      Width = 37
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 1
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
      Left = 134
      Top = 35
      Width = 453
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object mskDtaEtr: TMaskEditFocus
      Tag = 99
      Left = 94
      Top = 7
      Width = 65
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
      ValidaData = False
    end
  end
  object pnlCliente: TPanel [5]
    Left = 0
    Top = 61
    Width = 695
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 53
      Top = 7
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 94
      Top = 3
      Width = 69
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
    object edtDesCliente: TEditFocus
      Left = 166
      Top = 3
      Width = 421
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
  end
  object pnlDescricao: TPanel [6]
    Left = 0
    Top = 251
    Width = 695
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 36
      Top = 9
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object edtOuEnt: TEditFocus
      Tag = 99
      Left = 94
      Top = 4
      Width = 493
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConfirma: TBitBtnLocked
      Left = 593
      Top = 4
      Width = 86
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
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object pnlEndereco: TPanel [7]
    Left = 0
    Top = 120
    Width = 695
    Height = 131
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object gpbEnderecoEntrega: TGroupBox
      Left = 0
      Top = 0
      Width = 695
      Height = 131
      Align = alClient
      Caption = 'Dados da entrega'
      TabOrder = 0
      object lblEndCon: TLabel
        Left = 39
        Top = 50
        Width = 49
        Height = 14
        Caption = 'Endere'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblBaiCon: TLabel
        Left = 205
        Top = 78
        Width = 32
        Height = 14
        Caption = 'Bairro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblComple: TLabel
        Left = 21
        Top = 78
        Width = 67
        Height = 14
        Caption = 'Complemento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCidade: TLabel
        Left = 188
        Top = 24
        Width = 36
        Height = 14
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCep: TLabel
        Left = 66
        Top = 23
        Width = 22
        Height = 14
        Caption = 'CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEndRef: TLabel
        Left = 30
        Top = 105
        Width = 56
        Height = 14
        Caption = 'Refer'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtEndCon: TEditFocus
        Tag = 99
        Left = 94
        Top = 47
        Width = 493
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtBairro: TEditFocus
        Tag = 99
        Left = 243
        Top = 75
        Width = 222
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtComple: TEditFocus
        Tag = 99
        Left = 94
        Top = 75
        Width = 99
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 5
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
        Left = 229
        Top = 20
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 1
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
        Left = 301
        Top = 20
        Width = 246
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
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
      object edtEstado: TEditFocus
        Left = 550
        Top = 20
        Width = 37
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object edtCepCon: TEditFocus
        Tag = 99
        Left = 94
        Top = 20
        Width = 87
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
        TabOrder = 0
        OnKeyPress = edtCepConKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtRefCon: TEditFocus
        Tag = 99
        Left = 92
        Top = 102
        Width = 493
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
    end
  end
  object pnlPesoValor: TPanel [8]
    Left = 0
    Top = 88
    Width = 695
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblPesBru: TLabel
      Left = 11
      Top = 8
      Width = 77
      Height = 14
      Caption = 'Peso Total Doc.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblValDoc: TLabel
      Left = 179
      Top = 8
      Width = 85
      Height = 14
      Caption = 'Valor Documento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtPesBru: TEditFocus
      Tag = 99
      Left = 94
      Top = 5
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
      TabOrder = 0
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
    object edtValDoc: TEditFocus
      Tag = 99
      Left = 269
      Top = 5
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
      TabOrder = 1
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 344
    Top = 0
  end
end
