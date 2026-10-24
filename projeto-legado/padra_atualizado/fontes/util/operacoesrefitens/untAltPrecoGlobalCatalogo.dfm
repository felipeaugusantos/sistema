inherited frmAltPrecoGlobalCatalogo: TfrmAltPrecoGlobalCatalogo
  Left = 221
  Top = 191
  Width = 613
  Height = 487
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o Global de Pre'#231'os - Cat'#225'logo'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 613
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 14
  object lblInfoFator: TLabel [0]
    AlignWithMargins = True
    Left = 3
    Top = 341
    Width = 601
    Height = 14
    Align = alBottom
    Caption = 
      'Somente os campos referentes a pre'#231'o de venda,pre'#231'o de compra ou' +
      ' margem bruta sofrer'#227'o altera'#231#227'o por fator'
    Visible = False
    ExplicitWidth = 547
  end
  object pgbProgresso: TProgressBar [1]
    Left = 0
    Top = 431
    Width = 607
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 355
    Width = 607
    TabOrder = 4
    ExplicitTop = 355
    ExplicitWidth = 607
    DesignSize = (
      607
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 603
      ExplicitWidth = 603
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 442
    Width = 607
    TabOrder = 3
    ExplicitTop = 442
    ExplicitWidth = 607
    inherited pnlNomeForm: TPanel
      Left = 460
      Width = 147
      ExplicitLeft = 460
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 460
      ExplicitWidth = 460
    end
  end
  inherited pgcDados: TPageControl
    Top = 141
    Width = 607
    Height = 197
    TabOrder = 2
    Visible = False
    ExplicitTop = 141
    ExplicitWidth = 607
    ExplicitHeight = 197
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 599
      ExplicitHeight = 165
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 607
    Height = 141
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 81
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label8: TLabel
      Left = 74
      Top = 12
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblClaIpi: TLabel
      Left = 6
      Top = 58
      Width = 127
      Height = 14
      Alignment = taRightJustify
      Caption = 'NCM / Classifica'#231#227'o de IPI:'
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 135
      Top = 32
      Width = 439
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = edtDesIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 135
      Top = 9
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
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
      Left = 204
      Top = 9
      Width = 370
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
    object rdgTipAlt: TRadioGroup
      Left = 27
      Top = 79
      Width = 323
      Height = 51
      Caption = 'Tipo de Altera'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Alterar Custos e/ou Pre'#231'o de Venda refletindo na Margem'
        'Alterar Custos e/ou Margem refletindo no Pre'#231'o de Venda')
      TabOrder = 4
      OnClick = rdgTipAltClick
    end
    object rdgAltCat: TRadioGroup
      Left = 363
      Top = 79
      Width = 233
      Height = 51
      Caption = 'Alterar Cat'#225'logos'
      Columns = 3
      ItemIndex = 1
      Items.Strings = (
        'Ativos'
        'Inativos'
        'Todos')
      TabOrder = 5
      OnClick = rdgTipAltClick
    end
    object edtClaIpi: TEditFocus
      Tag = 99
      Left = 135
      Top = 55
      Width = 155
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttNumerico
      EditFormat = '####.##.##'
    end
  end
  object dbgTiposAlt: TDBGridCitel [6]
    Left = 0
    Top = 141
    Width = 607
    Height = 197
    Align = alClient
    DataSource = dtsConsulta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgTiposAltDrawColumnCell
    OnDblClick = dbgTiposAltDblClick
    OnKeyDown = dbgTiposAltKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_DESCAM'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o do Tipo de Altera'#231#227'o'
        Width = 405
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_VALCAM'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 150
        Visible = True
      end>
  end
  object pnlDadosAlt: TPanel [7]
    Left = 0
    Top = 355
    Width = 607
    Height = 48
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 6
    object lblCamAlt: TLabel
      Left = 8
      Top = 6
      Width = 221
      Height = 14
      Caption = 'A Descri'#231#227'o campo sendo alterado vai aqui....'
    end
    object edtCamAlt: TEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 190
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyPress = edtCamAltKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConfirmaAlt: TBitBtnLocked
      Left = 214
      Top = 20
      Width = 93
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
      OnClick = btnConfirmaAltClick
    end
    object btnCancelaAlt: TBitBtnLocked
      Left = 312
      Top = 20
      Width = 93
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
      TabOrder = 2
      OnClick = btnCancelaAltClick
    end
  end
  object pnlBotoesEnt: TPanel [8]
    Left = 0
    Top = 403
    Width = 607
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 7
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairAlt: TBitBtnLocked
      Left = 485
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAltClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 216
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 384
    Top = 176
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 416
    Top = 176
  end
  object dspItens: TUniDataSetProvider
    Options = []
    Left = 352
    Top = 224
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 384
    Top = 224
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 416
    Top = 224
  end
end
