inherited frmAnaliseProducao: TfrmAnaliseProducao
  Width = 1024
  Height = 638
  BorderStyle = bsSizeable
  Caption = 'An'#225'lise de Produ'#231#227'o'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitLeft = 0
  ExplicitWidth = 1024
  ExplicitHeight = 638
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 555
    Width = 1008
    TabOrder = 2
    ExplicitTop = 555
    ExplicitWidth = 1008
    DesignSize = (
      1008
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 82
        Height = 22
        Caption = '&Listar'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 82
        Top = 0
        Width = 91
        Height = 22
        Caption = '&Imprimir'
        Enabled = False
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
        TabOrder = 1
        OnClick = btnImprimirClick
      end
      object btnImprimirQtdPro: TBitBtnLocked
        Left = 173
        Top = 0
        Width = 146
        Height = 22
        Caption = 'Imprimir Qtd. Produzir'
        Enabled = False
        TabOrder = 5
        OnClick = btnImprimirQtdProClick
      end
      object btnManOrdProIndustrial: TBitBtnLocked
        Left = 319
        Top = 0
        Width = 213
        Height = 22
        Caption = 'Manuten'#231#227'o de Ordem de Produ'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00010000000A0D0A0865251A17EC5A4238EC1A13105C00000007000000000000
          0000000000000000000000000000000000000000000000000000000000010000
          0009130E0C6968554CFEC9AA97FFC8AA97FF584037EA0000000E000000000000
          0000000000000000000000000001000000060000000B0000000D000000101812
          1069776358FED8BBAAFFD8BBA8FFDCC9BCFF5C433AEC0000000D000000020000
          00060000000A0000000D01010119271C1788422D25D84B332BFF3D2921E6836E
          63FEDCC1B2FFDCC2B0FFEAD7CCFF917B71FE1F16145F00000005000000068060
          54BDC3A396FFCCB5ADFF7A6057FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
          B8FFDFC7B7FFE9DACFFF9B857BFF95827AEC000000100000000100000008B78A
          79FFF6F0ECFFAB9991FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
          BDFFE2CEBFFFA08A80FFBDAFA7FFCDB7AEFF0000000D0000000000000008B98F
          7EFFF5EFEBFF8D7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
          BFFFD1B9ABFF82675DFFEDE6E0FFB89182FF0000000C0000000000000007BE93
          81FFD3B6A9FF8B6F63FFB7A299FFAE9286FFCDAFA2FFAA8E82FFAF9B92FFE6D1
          C3FFE6D2C7FF7E6459FFF1E9E4FFAE806FFF0000000B0000000000000007C197
          86FFF7F3F0FF9D857AFFC7B8B0FFD5B8ABFFF8F1EDFFEAE2DDFF71574DFFE7D4
          C6FFD2C0B8FF8C746AFFF4ECE8FFB18473FF0000000B0000000000000006C59C
          8BFFFBF7F5FFF8F2EEFFF9F2EEFFD9BCAFFFF6F0ECFFA99891FF937C72FFEEE0
          D8FFB09C92FFB9A9A2FFF7F0ECFFB58877FF0000000A0000000000000006C9A0
          8FFFDCC1B5FFDCC0B3FFDCC0B3FFDABEB2FF9D8175FF8F7A72FFCABAB2FFB6A2
          97FF9C8073FFD6B8AEFFDABCB1FFB88D7BFF0000000A0000000000000005CCA4
          93FFFDF9F8FFFBF6F4FFFBF7F4FFDBC0B5FFAC958AFF987D6FFFA58E85FFB79C
          90FFF6F0EDFFFAF5F2FFFBF6F3FFBC907FFF000000090000000000000005CFA8
          97FFFDFAF9FFFBF7F5FFFCF7F5FFDFC5B8FFFAF6F3FFFAF5F3FFF9F5F3FFDDC3
          B6FFFCF7F5FFFBF7F4FFFBF7F4FFC09584FF000000080000000000000004C38A
          5BFFE6C79EFFD6A771FFD6A56FFFB67948FFD5A26AFFD49F69FFD49E65FFB474
          43FFD39961FFD2985FFFD1965EFFB37240FF000000080000000000000004C58E
          5EFFF2DBB5FFF2DAB3FFF0D7B0FFC6966BFFEFD4AAFFEFD2A7FFEECFA4FFBE89
          5BFFEBCB9CFFEAC99AFFEAC696FFB67744FF000000070000000000000002936A
          48BFC68E60FFC58D5FFFC48C5CFFC38A5BFFC28958FFC08756FFC08554FFBE83
          52FFBD8150FFBB7F4DFFBA7E4CFF895C36C10000000400000000}
        TabOrder = 2
        OnClick = btnManOrdProIndustrialClick
      end
      object btnSaldoReservado: TBitBtnLocked
        Left = 532
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F7] Saldo Reservado'
        TabOrder = 3
        OnClick = btnSaldoReservadoClick
      end
      object btnZerarProduzir: TBitBtnLocked
        Left = 657
        Top = 0
        Width = 127
        Height = 22
        Caption = 'Zerar Qtd. Produzir'
        TabOrder = 4
        OnClick = btnZerarProduzirClick
      end
      object btnExportDados: TBitBtnLocked
        Left = 784
        Top = 0
        Width = 127
        Height = 22
        Caption = 'Exportar Dados'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFCEAF69FFBA8D2CFFB68B2AFFB3892AFFB18728FFAF8526FFAD82
          25FFAA7F24FFA77D22FFA67C21FFA57A20FFA2761FFF6C4F14AD0000000BB079
          66FFFDFBFBFFBD932FFFDBC292FFFAF5F4FFF9F5F3FFB3892AFFF8F2F1FFF7F2
          EFFFD2B98AFFAA7E23FFC4A86EFFF5EEEAFFC2A66CFFA1791FFF0000000AB37C
          69FFFEFCFBFFC09430FFFBF7F6FFBB8E2DFFB88D2BFFB58B2AFFB3872AFFAF85
          27FFF7F2EFFFAC8124FFE4D5BCFFCEB686FFE2D3BAFFA37A20FF00000009B67F
          6CFFFEFDFCFFC19531FFFBF8F7FFBC922EFFBA8D2CFFB68C2BFFD7C08EFFF9F4
          F1FFD4BC8CFFAD8225FFF6F1EEFFA97E22FFF6EEEAFFA37B21FF00000009B983
          71FFFEFDFCFFC29732FFFCF8F8FFC0932FFFBB912FFFBA8D2DFFFAF5F3FFB489
          2AFFB18728FFAF8526FFF7F1EFFFAA7F24FFF6F0ECFFA67C21FF00000008BC88
          77FFFEFEFDFFC69933FFDFC996FFFCF8F8FFFAF8F7FFBB912EFFDAC291FFFAF5
          F4FFF8F3F0FFB18728FFF8F2F0FFAC8225FFF6F0EDFFA77D22FF00000007BF8C
          7AFFFEFEFDFFD7B871FFC39932FFC29532FFC09431FFBC922FFFBB8E2DFFB88D
          2CFFB58B2AFFB38729FFB18628FFAE8325FFAC8124FF735618AD00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
        TabOrder = 6
        OnClick = btnExportDadosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      ExplicitLeft = 928
    end
  end
  inherited pnlStatus: TPanel
    Top = 583
    Width = 1008
    TabOrder = 3
    ExplicitTop = 583
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
      object shpMultSel: TShape
        Left = 603
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
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
    Width = 1008
    Height = 353
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 5
      Top = 0
      Width = 1001
      Height = 121
      Caption = 'Produtos a Granel'
      TabOrder = 0
      object Label7: TLabel
        Left = 47
        Top = 25
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label2: TLabel
        Left = 12
        Top = 48
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label11: TLabel
        Left = 40
        Top = 71
        Width = 40
        Height = 14
        Caption = 'Produto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 9
        Top = 94
        Width = 71
        Height = 14
        Caption = 'Grupo An'#225'lise:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 82
        Top = 22
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 135
        Top = 22
        Width = 534
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
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 45
        Width = 52
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 2
        Text = ''
        OnExit = mskLinGruExit
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 135
        Top = 45
        Width = 534
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtCodProduto: TEditFocus
        Tag = 99
        Left = 82
        Top = 68
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnExit = edtCodProdutoExit
        OnKeyPress = edtCodProdutoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProduto: TEditFocus
        Left = 135
        Top = 68
        Width = 534
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
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodGruGer: TEditFocus
        Tag = 99
        Left = 82
        Top = 91
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        OnKeyPress = edtCodGruGerKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesGruGer: TEditFocus
        Left = 135
        Top = 91
        Width = 534
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
    end
    object GroupBox2: TGroupBox
      Left = 4
      Top = 127
      Width = 1001
      Height = 220
      Caption = 'Produtos Acabados'
      TabOrder = 1
      object Label3: TLabel
        Left = 47
        Top = 25
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label4: TLabel
        Left = 12
        Top = 48
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label5: TLabel
        Left = 40
        Top = 71
        Width = 40
        Height = 14
        Caption = 'Produto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblQtdDia: TLabel
        Left = 433
        Top = 132
        Width = 24
        Height = 14
        Caption = 'Dias:'
        Enabled = False
      end
      object lbl1: TLabel
        Left = 26
        Top = 176
        Width = 54
        Height = 14
        Caption = 'Data Inicial:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 154
        Top = 176
        Width = 50
        Height = 14
        Caption = 'Data Final:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 809
        Top = 84
        Width = 87
        Height = 14
        Caption = 'Dias Para Giro/Dia'
      end
      object Label9: TLabel
        Left = 518
        Top = 132
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo?:'
      end
      object ColorLabel1: TColorLabel
        Left = 575
        Top = 132
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object Label10: TLabel
        Left = 9
        Top = 94
        Width = 71
        Height = 14
        Caption = 'Grupo An'#225'lise:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 686
        Top = 132
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Atende Pedido?'
      end
      object ColorLabel2: TColorLabel
        Left = 793
        Top = 132
        Width = 145
        Height = 14
        Caption = '(P)Positivo (N)egativo (T)odos'
        CorDestaque = clRed
      end
      object edtCodMarAca: TEditFocus
        Tag = 99
        Left = 82
        Top = 22
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        OnExit = edtCodMarAcaExit
        OnKeyPress = edtCodMarAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMarAca: TEditFocus
        Left = 135
        Top = 22
        Width = 370
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
      object mskLinGruAca: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 45
        Width = 52
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 2
        Text = ''
        OnExit = mskLinGruAcaExit
        OnKeyPress = mskLinGruAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGruAca: TEditFocus
        Left = 135
        Top = 45
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
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
      object edtCodProdutoAca: TEditFocus
        Tag = 99
        Left = 82
        Top = 68
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnExit = edtCodProdutoAcaExit
        OnKeyPress = edtCodProdutoAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProdutoAca: TEditFocus
        Left = 135
        Top = 68
        Width = 370
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
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgEstoque: TRadioGroup
        Left = 511
        Top = 16
        Width = 158
        Height = 75
        Caption = 'Filtro de Estoque'
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Abaixo do Estoque M'#237'nimo'
          'Estoque Negativo')
        TabOrder = 7
      end
      object rdgGiro: TRadioGroup
        Left = 675
        Top = 16
        Width = 89
        Height = 75
        Caption = 'Op'#231#227'o de Giro'
        ItemIndex = 0
        Items.Strings = (
          '3 meses'
          '6 meses'
          '12 meses')
        TabOrder = 8
      end
      object chkOrdPro: TCheckBox
        Left = 252
        Top = 131
        Width = 178
        Height = 17
        Caption = 'Considerar Ordem de Produ'#231#227'o'
        TabOrder = 14
        OnClick = chkOrdProClick
      end
      object edtQtdDia: TEditFocus
        Left = 461
        Top = 128
        Width = 44
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object chkNecPro: TCheckBox
        Left = 770
        Top = 25
        Width = 228
        Height = 17
        Caption = 'Exibir Itens sem necessidade de produ'#231#227'o'
        TabOrder = 9
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 173
        Width = 65
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 19
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 207
        Top = 173
        Width = 66
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 20
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object rdbAnaSin: TRadioButton
        Left = 82
        Top = 200
        Width = 105
        Height = 17
        Caption = 'An'#225'lise Sint'#233'tica'
        Checked = True
        TabOrder = 22
        TabStop = True
        OnKeyPress = rdbAnaSinKeyPress
      end
      object rdbAnaAna: TRadioButton
        Left = 194
        Top = 200
        Width = 105
        Height = 17
        Caption = 'An'#225'lise An'#225'litica'
        TabOrder = 23
        OnKeyPress = rdbAnaSinKeyPress
      end
      object chkLibera: TCheckBox
        Left = 770
        Top = 42
        Width = 214
        Height = 29
        Caption = 'Considerar apenas pedidos com libera'#231#227'o financeira?'
        Checked = True
        State = cbChecked
        TabOrder = 10
        WordWrap = True
      end
      object edtDiasGiro: TEditFocus
        Tag = 99
        Left = 770
        Top = 81
        Width = 33
        Height = 22
        Alignment = taCenter
        TabOrder = 11
        Text = '10'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object chkConMin: TCheckBox
        Left = 82
        Top = 131
        Width = 157
        Height = 17
        Caption = 'Considerar estoque m'#237'nimo'
        Checked = True
        State = cbChecked
        TabOrder = 13
      end
      object chkQbrLin: TCheckBox
        Left = 770
        Top = 105
        Width = 164
        Height = 29
        Caption = 'Quebrar relat'#243'rio por Linha'
        TabOrder = 12
        WordWrap = True
      end
      object edtStatus: TEditFocus
        Tag = 99
        Left = 550
        Top = 128
        Width = 19
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 16
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object chkConMax: TCheckBox
        Left = 82
        Top = 151
        Width = 157
        Height = 17
        Caption = 'Considerar estoque m'#225'ximo'
        Checked = True
        State = cbChecked
        TabOrder = 18
      end
      object edtCodGruGerAca: TEditFocus
        Tag = 99
        Left = 82
        Top = 91
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        OnKeyPress = edtCodGruGerAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesGruGerAca: TEditFocus
        Left = 135
        Top = 91
        Width = 370
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
        TabOrder = 24
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object grpEntFut: TcxGroupBox
        Left = 477
        Top = 166
        Caption = 'Considerar Entrega Futura Pendente'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.Shadow = True
        Style.IsFontAssigned = True
        TabOrder = 21
        Height = 35
        Width = 430
        object chkFaltaProduto: TCheckBox
          Left = 9
          Top = 14
          Width = 97
          Height = 17
          Caption = 'Falta de Produto'
          TabOrder = 0
          StyleElements = [seFont]
        end
        object chkPrevisaoEntrega: TCheckBox
          Left = 145
          Top = 14
          Width = 121
          Height = 17
          Caption = 'Previs'#227'o de Entrega'
          TabOrder = 1
          StyleElements = [seFont]
        end
        object chkAguardandoCliente: TCheckBox
          Left = 296
          Top = 14
          Width = 120
          Height = 17
          Caption = 'Aguardando Cliente'
          TabOrder = 2
          StyleElements = [seFont]
        end
      end
      object edtAtePed: TEditFocus
        Tag = 99
        Left = 768
        Top = 130
        Width = 19
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 17
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object rdgTipoFiltroData: TRadioGroup
        Left = 300
        Top = 164
        Width = 166
        Height = 50
        Caption = 'Filtrar data da: '
        ItemIndex = 0
        Items.Strings = (
          'Previs'#227'o do pedido'
          'Entrega por item')
        TabOrder = 25
      end
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 353
    Width = 1008
    Height = 181
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataModeController.DetailInSQLMode = True
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 50
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 147
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Width = 31
      end
      object cxgItensViewPESLIQ: TcxGridDBColumn
        Caption = 'Peso Liq.'
        DataBinding.FieldName = 'PESLIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000'
        Options.Editing = False
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Estoq. Atual'
        DataBinding.FieldName = 'SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensViewSALDIS: TcxGridDBColumn
        Caption = 'Saldo Disp.'
        DataBinding.FieldName = 'SALDIS'
        Options.Editing = False
      end
      object cxgItensViewESTMIN: TcxGridDBColumn
        Caption = 'Est.M'#237'n.'
        DataBinding.FieldName = 'ESTMIN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 53
      end
      object cxgItensViewColumn8: TcxGridDBColumn
        Caption = 'Est.M'#225'x.'
        DataBinding.FieldName = 'ESTMAX'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 56
      end
      object cxgItensViewColumn6: TcxGridDBColumn
        Caption = 'Ped. Venda'
        DataBinding.FieldName = 'SALRES'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensQTDPEN: TcxGridDBColumn
        Caption = 'Entreg. Fut.'
        DataBinding.FieldName = 'QTDPEN'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgItensViewColumn7: TcxGridDBColumn
        Caption = 'OP'
        DataBinding.FieldName = 'SALOPR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 52
      end
      object cxgItensSALFIN: TcxGridDBColumn
        Caption = 'Saldo Final'
        DataBinding.FieldName = 'SALFIN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensViewSALFEM: TcxGridDBColumn
        Caption = 'Atende Pedido'
        DataBinding.FieldName = 'SALFEM'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 94
      end
      object cxgItensViewCAPMAX: TcxGridDBColumn
        Caption = 'Cap. M'#225'x. Prod'
        DataBinding.FieldName = 'CAPMAX'
        Options.Editing = False
        Width = 89
      end
      object cxgItensViewQTDPRO: TcxGridDBColumn
        Caption = 'Qtd.Produzir'
        DataBinding.FieldName = 'QTDPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Properties.OnEditValueChanged = cxgItensViewQTDPROPropertiesEditValueChanged
        Width = 70
      end
      object cxgItensViewColumn9: TcxGridDBColumn
        Caption = 'M'#233'dia Giro'
        DataBinding.FieldName = 'MEDGIR'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensViewGIRDIA: TcxGridDBColumn
        Caption = 'Giro/Dia'
        DataBinding.FieldName = 'GIRDIA'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 58
      end
      object cxgItensViewDIAEST: TcxGridDBColumn
        Caption = 'Dias Estoq. (Com Saldo F'#237'sico)'
        DataBinding.FieldName = 'DIAEST'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 62
      end
      object cxgItensPREVIS: TcxGridDBColumn
        Caption = 'Dta.Prx.Ent.'
        DataBinding.FieldName = 'PREVIS'
        Options.Editing = False
      end
      object cxgItensQTDPRE: TcxGridDBColumn
        Caption = 'Qtd. Ent.'
        DataBinding.FieldName = 'QTDPRE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 47
      end
      object cxgItensViewSALDOP: TcxGridDBColumn
        Caption = 'Dias Est. (Saldo Disp. + OP )'
        DataBinding.FieldName = 'SALDOP'
        Options.Editing = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 534
    Width = 1008
    Height = 21
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      1008
      21)
    object Shape1: TShape
      Left = 878
      Top = 4
      Width = 12
      Height = 14
      Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
      Anchors = [akTop, akRight]
      Brush.Color = clRed
      ParentShowHint = False
      Pen.Style = psClear
      ShowHint = True
    end
    object Label1: TLabel
      Left = 893
      Top = 3
      Width = 108
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Saldo Final negativo'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 0
  end
  object frxDBItens: TfrxDBDataset
    UserName = 'frxDBItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 208
    Top = 432
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40961.780128935200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 144
    Top = 436
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787404020000000000
        ParentFont = False
        Top = 370.393940000000000000
        Width = 1065.827460000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1065.827460000000000000
          Height = 20.787404020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmDescricao: TfrxMemoView
          Left = 35.795300000000000000
          Top = 1.889763780000010000
          Width = 160.251968500000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Top = 1.889763780000010000
          Width = 34.015770000000010000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
        end
        object Memo9: TfrxMemoView
          Left = 197.519790000000000000
          Top = 1.889763779527584000
          Width = 34.015770000000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 1005.236860000000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."DIAEST"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 716.433520000000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."SALFIN"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 654.961040000000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."SALOPR"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 594.488560000000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."SALRES"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 294.787570000000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."ESTMIN"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 234.448716380000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."SALDOS"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 354.819110000000000000
          Top = 1.889763779527584000
          Width = 58.582677170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."ESTMAX"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 415.291590000000000000
          Top = 1.889763779527584000
          Width = 92.598447170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItens."CODFAB"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 510.338900000000000000
          Top = 1.889763779527584000
          Width = 81.259857170000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxDBItens."PREVIS"> = 0, '#39#39',   FormatDateTime('#39'dd/mm/yyyy' +
              #39', <frxDBItens."PREVIS">))]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 777.244590000000000000
          Top = 1.889763780000010000
          Width = 103.937037170000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."SALFEM"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 882.512370000000000000
          Top = 1.889763779527584000
          Width = 62.362202280000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."MEDGIR"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 946.764380000000000000
          Top = 1.889763779527584000
          Width = 54.803142280000000000
          Height = 15.118110236220470000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."GIRDIA"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 453.543600000000000000
        Width = 1065.827460000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661409999999989000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'frmAnaliseProducao')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 710.627460000000000000
          Top = 5.661409999999989000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 1065.827460000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 1065.827460000000000000
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Align = baClient
          Width = 1065.827460000000000000
          Height = 17.000000000000000000
          Fill.BackColor = clSilver
        end
        object Memo17: TfrxMemoView
          Left = 197.519790000000000000
          Top = 1.000000000000000000
          Width = 34.015748030000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 234.315090000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EST. ATU.')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 294.787570000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EST.M'#205'N.')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 594.488560000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PED.VEN.')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 654.961040000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ORD.PRO.')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 716.433520000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SAL.FIN.')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 1005.236860000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DIAS EST')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 354.819110000000000000
          Top = 1.000000000000000000
          Width = 58.582677170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'EST.M'#193'X.')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 415.291590000000000000
          Top = 1.000000000000000000
          Width = 92.598447170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D. F'#193'BRICA')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 510.338900000000000000
          Top = 1.000000000000000000
          Width = 81.259857170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT.PR'#211'X.ENT.')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 777.244590000000000000
          Top = 1.000000000000000000
          Width = 103.937037170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SAl. FIN. EST. M'#193'X.')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 882.512370000000000000
          Top = 1.000000000000000000
          Width = 62.362207170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'M'#201'D. GIRO')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 946.764380000000000000
          Top = 1.000000000000000000
          Width = 54.803147170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'GIRO/DIA')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 1.000000000000000000
          Width = 195.779527559055000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO - DESC. PRODUTO')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 247.504020000000000000
        Top = 18.897650000000000000
        Width = 1065.827460000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 168.113730000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 363.704330000000000000
          Top = 34.000000000000000000
          Width = 338.418800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 943.521460000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 991.521460000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 896.957700000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 81.220470000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCAACA]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Top = 160.590600000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ORDPRO]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 239.889920000000000000
          Width = 1065.827460000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Top = 100.047310000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAACA]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 119.944960000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTOACA]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 139.401670000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NECCOM]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Top = 179.315090000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESTOQUE]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 199.094620000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GIRO]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 368.393940000000000000
          Top = 81.370130000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 368.393940000000000000
          Top = 100.196970000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHA]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 368.393940000000000000
          Top = 120.094620000000000000
          Width = 365.102350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Top = 219.212740000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONMIN]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41057.665690463000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 68
    Top = 432
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      PrintIfEmpty = False
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object frxDBItensfrxDBItens: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 57.600000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."DIAEST"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."MEDGIR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALFIN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALOPR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALRES"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."ESTMIN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALDOS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 556.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."ESTMAX"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              '[IIF(<frxDBItens."PREVIS"> = 0, '#39#39',   FormatDateTime('#39'dd/mm/yyyy' +
              #39', <frxDBItens."PREVIS">))]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 2332.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALFIN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALFEM"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1353.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."GIRDIA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'frmAnaliseProducao')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 255.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO-DESCRICAO DO ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DIAS '
            'ESTOQ')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'ESTOQ '
            'ATUAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'ESTOQ'
            'MIN')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'PEDIDO '
            'VENDA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'ORDEM'
            'PRODU'#199#195'O')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'SALDO'
            'FINAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MEDIA'
            'GIRO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'ESTOQ'
            'MAX')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO'
            'FABRICA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DTA PROX '
            'ENTREGA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 2332.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'SALDO FIN.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'SAlDO FIN '
            'EST. MAX')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 1353.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'GIRO'
            '/DIA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 374.400000000000000000
          Top = 34.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1382.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 34.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#77'
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[MARCAACA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINHAACA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PRODUTOACA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[ORDPRO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[ESTOQUE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[GIRO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[NECCOM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 68.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 85.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINHA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 102.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[CONMIN]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportM_ANAQTP: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41057.665690463000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 52
    Top = 372
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      TopMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      PrintIfEmpty = False
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object frxDBItensfrxDBItens: TfrxDMPMemoView
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."QTDPRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."CAPMAX"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 2332.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SALFIN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxDBItens."CODPAG"> + '#39'-'#39' + <frxDBItens."CODCOR">]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 357.000000000000000000
        Width = 768.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'frmAnaliseProducao')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 768.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO-DESCRICAO DO ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CAP. MAXI.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PRODUZ.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 2332.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'SALDO FIN.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'FORMULA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[MARCAACA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINHAACA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PRODUTOACA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[ORDPRO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[ESTOQUE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[GIRO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[NECCOM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 68.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINHA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[CONMIN]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ_ANAQTP: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40961.780128935200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 172
    Top = 367
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787404020000000000
        ParentFont = False
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 20.787404020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmDescricao: TfrxMemoView
          Left = 40.795300000000000000
          Top = 1.889763780000000000
          Width = 385.889732050000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Top = 1.889763780000010000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
        end
        object Memo9: TfrxMemoView
          Left = 429.189240000000000000
          Top = 2.110233780000000000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 538.338780390000000000
          Top = 2.110233780000000000
          Width = 81.259844960000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."CAPMAX"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 623.023622050000000000
          Top = 2.110233780000000000
          Width = 92.598422760000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBItens."QTDPRO"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 465.661720000000000000
          Top = 2.267716540000000000
          Width = 69.921267170000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxDBItens."CODPAG"> + '#39'-'#39' + <frxDBItens."CODCOR">]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661409999999989000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'frmAnaliseProducao')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 362.910700000000000000
          Top = 5.661409999999989000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 17.000000000000000000
          Fill.BackColor = clSilver
        end
        object Memo17: TfrxMemoView
          Left = 429.189240000000000000
          Top = 1.220470000000000000
          Width = 34.015748030000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 538.457020000000000000
          Top = 1.220470000000000000
          Width = 81.259857170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CAP. M'#193'XIMA')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 1.000000000000000000
          Width = 426.330857560000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO - DESC. PRODUTO')
        end
        object Memo19: TfrxMemoView
          Left = 622.842920000000000000
          Top = 1.220470000000000000
          Width = 92.598447170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PRODUZIR')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 465.779959610000000000
          Top = 1.133858270000000000
          Width = 69.921267170000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'F'#211'RMULA')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 232.385900000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 18.897869685039350000
          Top = 1.220469999999999000
          Width = 680.314960629921300000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 189.845950000000000000
          Top = 18.220470000000000000
          Width = 338.418800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 602.910700000000000000
          Top = 18.220470000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 560.201980000000000000
          Top = 35.220470000000010000
          Width = 157.908720000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 69.220470000000000000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCAACA]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Top = 148.590600000000000000
          Width = 353.461409999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ORDPRO]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 228.889920000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 88.047310000000000000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAACA]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 107.944960000000000000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTOACA]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 127.401670000000000000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NECCOM]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Top = 167.315090000000000000
          Width = 353.461409999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESTOQUE]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 187.094620000000000000
          Width = 353.461409999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GIRO]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 364.346940000000100000
          Top = 69.370130000000000000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baRight
          Left = 364.346940000000100000
          Top = 88.196969999999990000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHA]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baRight
          Left = 364.346940000000100000
          Top = 108.094620000000000000
          Width = 353.763759999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Top = 207.212740000000000000
          Width = 353.461410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONMIN]')
          ParentFont = False
        end
      end
    end
  end
end
