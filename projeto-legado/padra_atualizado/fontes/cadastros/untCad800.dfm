inherited frmCad800: TfrmCad800
  Width = 659
  Height = 567
  Caption = 'Atendimento 0800'
  OnDestroy = FormDestroy
  ExplicitWidth = 659
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 44
    Top = 42
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'Telefone:'
  end
  object Label2: TLabel [1]
    Left = 53
    Top = 10
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 36
    Top = 65
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Solicitante:'
  end
  object Label4: TLabel [3]
    Left = 39
    Top = 88
    Width = 49
    Height = 14
    Alignment = taRightJustify
    Caption = 'Endere'#231'o:'
  end
  object Label5: TLabel [4]
    Left = 52
    Top = 111
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cidade:'
  end
  object Label6: TLabel [5]
    Left = 353
    Top = 111
    Width = 32
    Height = 14
    Alignment = taRightJustify
    Caption = 'Bairro:'
  end
  object Label7: TLabel [6]
    Left = 54
    Top = 134
    Width = 34
    Height = 14
    Alignment = taRightJustify
    Caption = 'Motivo:'
  end
  object Label8: TLabel [7]
    Left = 7
    Top = 157
    Width = 81
    Height = 14
    Alignment = taRightJustify
    Caption = 'Como conheceu:'
  end
  object Label9: TLabel [8]
    Left = 176
    Top = 10
    Width = 25
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel [9]
    Left = 277
    Top = 10
    Width = 26
    Height = 14
    Alignment = taRightJustify
    Caption = 'Hora:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel [10]
    Left = 372
    Top = 10
    Width = 49
    Height = 14
    Alignment = taRightJustify
    Caption = 'Operador:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel [11]
    Left = 0
    Top = 33
    Width = 653
    Height = 3
    Shape = bsTopLine
  end
  object Label12: TLabel [12]
    Left = 8
    Top = 419
    Width = 80
    Height = 11
    Caption = 'Loja     :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel [13]
    Left = 8
    Top = 437
    Width = 80
    Height = 11
    Caption = 'Endere'#231'o :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel [14]
    Left = 8
    Top = 456
    Width = 80
    Height = 11
    Caption = 'Bairro   :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label15: TLabel [15]
    Left = 8
    Top = 475
    Width = 80
    Height = 11
    Caption = 'Telefone :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label16: TLabel [16]
    Left = 418
    Top = 456
    Width = 64
    Height = 11
    Caption = 'Cidade :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label17: TLabel [17]
    Left = 418
    Top = 475
    Width = 64
    Height = 11
    Caption = 'CEP    :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtNomCli: TDBText [18]
    Left = 96
    Top = 419
    Width = 549
    Height = 14
    DataField = 'NOMCLI'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtEndere: TDBText [19]
    Left = 96
    Top = 437
    Width = 549
    Height = 14
    DataField = 'ENDERE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtBairro: TDBText [20]
    Left = 96
    Top = 456
    Width = 316
    Height = 14
    DataField = 'BAIRRO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtFone01: TDBText [21]
    Left = 96
    Top = 475
    Width = 137
    Height = 14
    DataField = 'FONE01'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtNomCid: TDBText [22]
    Left = 496
    Top = 456
    Width = 149
    Height = 14
    DataField = 'NOMCID'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtCep: TDBText [23]
    Left = 496
    Top = 475
    Width = 149
    Height = 14
    DataField = 'C_E_P_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbtFone02: TDBText [24]
    Left = 249
    Top = 475
    Width = 137
    Height = 14
    DataField = 'FONE02'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 497
    Width = 653
    Height = 25
    ExplicitTop = 497
    ExplicitWidth = 653
    ExplicitHeight = 25
    DesignSize = (
      653
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 649
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 649
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        ExplicitWidth = 71
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        ExplicitLeft = 71
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        ExplicitLeft = 142
        ExplicitWidth = 71
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        ExplicitLeft = 213
        ExplicitWidth = 71
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 71
        ExplicitLeft = 284
        ExplicitWidth = 71
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 355
        Width = 75
        ExplicitLeft = 355
        ExplicitWidth = 75
      end
      object btnRelatorio: TBitBtnLocked
        Left = 430
        Top = 0
        Width = 72
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = 'R&elat'#243'rio'
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
        TabOrder = 6
        OnClick = btnRelatorioClick
      end
      object btnImprime: TBitBtnLocked
        Left = 502
        Top = 0
        Width = 68
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = 'I&mprimir'
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
        TabOrder = 7
        OnClick = btnImprimeClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 573
      Width = 70
      Height = 20
      ExplicitLeft = 573
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 2000
    Width = 89
    Height = 41
    Align = alNone
    ExplicitLeft = 2000
    ExplicitWidth = 89
    ExplicitHeight = 41
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 81
      ExplicitHeight = 9
    end
  end
  object dbeFone01: TDBEditFocus [28]
    Tag = 99
    Left = 94
    Top = 39
    Width = 105
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_FONE01'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeSequen: TDBEditFocus [29]
    Tag = 50
    Left = 95
    Top = 7
    Width = 77
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    Color = 14342874
    DataField = 'TEL_SEQUEN'
    DataSource = dtsCad800
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 13
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeSolici: TDBEditFocus [30]
    Tag = 99
    Left = 94
    Top = 62
    Width = 549
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_SOLICI'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeEndere: TDBEditFocus [31]
    Tag = 99
    Left = 94
    Top = 85
    Width = 549
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_ENDERE'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodCid: TDBEditFocus [32]
    Tag = 99
    Left = 94
    Top = 108
    Width = 43
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_CODCID'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 6
    OnKeyPress = dbeCodCidKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
    OnChamaCadastro = dbeCodCidChamaCadastro
  end
  object edtDesCid: TEditFocus [33]
    Left = 137
    Top = 108
    Width = 172
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object dbeCodBai: TDBEditFocus [34]
    Tag = 99
    Left = 391
    Top = 108
    Width = 68
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_CODBAI'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 8
    OnKeyPress = dbeCodBaiKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
    OnChamaCadastro = dbeCodBaiChamaCadastro
  end
  object edtDesBai: TEditFocus [35]
    Left = 459
    Top = 108
    Width = 184
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbeMotivo: TDBEditFocus [36]
    Tag = 99
    Left = 94
    Top = 131
    Width = 549
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_MOTIVO'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 10
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodCac: TDBEditFocus [37]
    Tag = 99
    Left = 94
    Top = 154
    Width = 43
    Height = 22
    CharCase = ecUpperCase
    DataField = 'TEL_CODCAC'
    DataSource = dtsCad800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 11
    OnKeyPress = dbeCodCacKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
    OnChamaCadastro = dbeCodCacChamaCadastro
  end
  object edtDesCac: TEditFocus [38]
    Left = 138
    Top = 154
    Width = 505
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 12
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbeCodEmp: TDBEditFocus [39]
    Tag = 50
    Left = 683
    Top = 8
    Width = 87
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    Color = 14342874
    DataField = 'TEL_CODEMP'
    DataSource = dtsCad800
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 14
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeDtaCad: TDBEditFocus [40]
    Tag = 50
    Left = 203
    Top = 7
    Width = 71
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    Color = 14342874
    DataField = 'TEL_DTACAD'
    DataSource = dtsCad800
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 15
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeHorCad: TDBEditFocus [41]
    Tag = 50
    Left = 309
    Top = 7
    Width = 56
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    Color = 14342874
    DataField = 'TEL_HORCAD'
    DataSource = dtsCad800
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 16
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object dbeCodOpe: TDBEditFocus [42]
    Tag = 50
    Left = 422
    Top = 7
    Width = 38
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    Color = 14342874
    DataField = 'TEL_CODOPE'
    DataSource = dtsCad800
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 17
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttNumerico
  end
  object edtDesOpe: TEditFocus [43]
    Tag = 50
    Left = 460
    Top = 7
    Width = 184
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Color = 14342874
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 18
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 0
    TipoTexto = ttNumerico
  end
  object edtEstado: TEditFocus [44]
    Left = 313
    Top = 108
    Width = 34
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 19
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbgBairros: TcxGrid [45]
    Left = 6
    Top = 183
    Width = 637
    Height = 226
    Enabled = False
    TabOrder = 20
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgBairrosDBTableView: TcxGridDBTableView
      OnDblClick = dbgBairrosDBTableViewDblClick
      OnKeyDown = dbgBairrosDBTableViewKeyDown
      OnMouseLeave = dbgBairrosDBTableViewMouseLeave
      OnMouseMove = dbgBairrosDBTableViewMouseMove
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = dbgBairrosDBTableViewCellClick
      OnCustomDrawCell = dbgBairrosDBTableViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object dbgBairrosDBTableViewMarca: TcxGridDBColumn
        Caption = '  X'
        DataBinding.FieldName = 'MARCA'
        RepositoryItem = cxEditRepository1ImageComboBoxItem1
        Options.Filtering = False
        Width = 27
      end
      object dbgBairrosDBTableViewNOMCLI: TcxGridDBColumn
        Caption = 'Loja'
        DataBinding.FieldName = 'NOMCLI'
        Width = 304
      end
      object dbgBairrosDBTableViewNOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'NOMCID'
        Width = 158
      end
      object dbgBairrosDBTableViewESTADO: TcxGridDBColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'ESTADO'
        Width = 42
      end
      object dbgBairrosDBTableViewFONE01: TcxGridDBColumn
        Caption = 'Telefone'
        DataBinding.FieldName = 'FONE01'
        Width = 100
      end
    end
    object dbgBairrosLevel: TcxGridLevel
      GridView = dbgBairrosDBTableView
    end
  end
  inherited pnlStatus: TPanel
    Top = 522
    Width = 653
    ExplicitTop = 522
    ExplicitWidth = 653
    inherited pnlNomeForm: TPanel
      Left = 306
      ExplicitLeft = 306
    end
    inherited pnlInfo: TPanel
      Width = 306
      ExplicitWidth = 306
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 706
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 706
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 706
    Top = 88
  end
  object dtsCad800: TDataSource
    Left = 696
    Top = 24
  end
  object imgLista: TImageList
    Left = 140
    Top = 284
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00D6D6D600D6D6D600D6D6D600DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE009C9C9C009C9C9C009C9C
      9C009C9C9C009494940094949400949494009494940094949400949494009494
      9400949494008C8C8C00B5B5B500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7
      F700F7F7F700FFFFFF00ADADAD00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700EFEFEF008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF00E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      000000000000000000000000000000000000EFEFEF00E7E7E700DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600CECECE00D6D6D6008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      000000000000000000000000000000000000E7E7E700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00D6D6D600D6D6D600D6D6D600CECECE00CECECE00CECECE00CECE
      CE00CECECE00CECECE00CECECE008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      000000000000000000000000000000000000E7E7E700DEDEDE00D6D6D600D6D6
      D600D6D6D600D6D6D600CECECE00CECECE00CECECE00CECECE00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A0000000000000000000000000000000000E7E7E700D6D6D600D6D6D600D6D6
      D600CECECE00CECECE00CECECE00C6C6C600C6C6C600C6C6C600C6C6C600BDBD
      BD00BDBDBD00BDBDBD00BDBDBD008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A00000000000000000000000000DEDEDE00D6D6D600D6D6D600CECE
      CE00CECECE00CECECE00C6C6C600C6C6C600C6C6C600BDBDBD00BDBDBD00B5B5
      B500B5B5B500B5B5B500B5B5B5008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD5200299431000000000000000000DEDEDE00D6D6D600D6D6D600CECE
      CE00CECECE00C6C6C600C6C6C600C6C6C600BDBDBD00BDBDBD00B5B5B500B5B5
      B500B5B5B500ADADAD00B5B5B5008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD600DEDEDE00D6D6D600D6D6D600CECE
      CE00CECECE00C6C6C600C6C6C600BDBDBD00BDBDBD00B5B5B500B5B5B500ADAD
      AD00ADADAD00A5A5A500ADADAD008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B57300DEDEDE00D6D6D600CECECE00CECE
      CE00C6C6C600C6C6C600BDBDBD00BDBDBD00B5B5B500B5B5B500ADADAD00ADAD
      AD00A5A5A500A5A5A500A5A5A5008C8C8C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD00EFEFEF00DEDEDE00D6D6D600D6D6
      D600CECECE00CECECE00C6C6C600C6C6C600BDBDBD00BDBDBD00B5B5B500B5B5
      B500ADADAD00ADADAD00B5B5B500949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C60000000000F7F7F700EFEFEF00EFEFEF00E7E7
      E700E7E7E700E7E7E700DEDEDE00DEDEDE00DEDEDE00D6D6D600D6D6D600D6D6
      D600CECECE00CECECE00D6D6D600949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7F7F700F7F7F700EFEF
      EF00EFEFEF00EFEFEF00E7E7E700E7E7E700E7E7E700E7E7E700DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00E7E7E7009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00ADADAD00DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC1FFFFF00010000EFF7FFFF00000000
      C7E3C1FF0000000083C1C0FF00000000C183C07F00000000E007803F00000000
      F00F801F00000000F81F800F00000000F81F040700000000F00F060300000000
      E0078F0000000000C183FFC00000000083C1FFE000000000C7E3FFF100000000
      EFF7FFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object cxEditRepository1: TcxEditRepository
    Left = 224
    Top = 288
    PixelsPerInch = 96
    object cxEditRepository1ImageComboBoxItem1: TcxEditRepositoryImageComboBoxItem
      Properties.Images = imgLista
      Properties.Items = <
        item
          ImageIndex = 0
          Value = 'N'
        end
        item
          ImageIndex = 1
          Value = 'S'
        end>
    end
  end
end
