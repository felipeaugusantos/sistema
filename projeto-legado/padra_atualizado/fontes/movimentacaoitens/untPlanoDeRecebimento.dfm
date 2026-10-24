inherited frmPlanoDeRecebimento: TfrmPlanoDeRecebimento
  Width = 1269
  Height = 759
  BorderStyle = bsSingle
  Caption = 'Plano de Recebimento'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1269
  ExplicitHeight = 759
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 1263
    Height = 29
    ExplicitTop = 685
    ExplicitWidth = 1263
    ExplicitHeight = 29
    object lblPesquisa: TLabel [0]
      Left = 850
      Top = 4
      Width = 295
      Height = 14
      Caption = 'Utilize a pesquisa "/" para trocar a localiza'#231#227'o f'#237'sica sugerida'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1182
      Height = 25
      ExplicitWidth = 1182
      ExplicitHeight = 25
      inherited btnConfirma: TBitBtnLocked
        Width = 102
        Align = alLeft
        Enabled = False
        ModalResult = 0
        ExplicitWidth = 102
      end
      object btnAlterar: TBitBtnLocked
        Left = 102
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Alterar'
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
          CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
          A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
          820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
          860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
          C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
          D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
          9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnAlterarClick
      end
      object btnCancela: TBitBtnLocked
        Left = 192
        Top = 0
        Width = 100
        Height = 22
        Caption = 'Ca&ncelar'
        Enabled = False
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
        TabOrder = 4
        OnClick = btnCancelaClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 292
        Top = 0
        Width = 119
        Height = 22
        Align = alLeft
        Caption = '&Imprimir Etiquetas'
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
      object btnDesmembra: TBitBtnLocked
        Left = 411
        Top = 0
        Width = 155
        Height = 22
        Align = alLeft
        Caption = '&Desmembrar Documentos'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000002000000080000000C0000000D0000000D0000000E0000000E0000
          000E0000000E0000000F0000000F0000000E0000000900000002000000000000
          0000000000078B664BBFB57951FFB47851FFB4764FFFB2754EFFB2744DFFB273
          4CFFB1734CFFB1714AFFB07149FFAF6F48FF7E4F33C100000009000000000000
          00000000000ACBA07AFFF9EFD0FFEFD9AEFFEFD6ADFFEED5AAFFEDD4A9FFECD3
          A7FFEBD1A5FFEBD0A3FFEACEA1FFEACD9FFFB47750FF0000000D000000000000
          000000000009D0A984FFFBF4D7FFE7C593FFE6C491FFE7C390FFE5C18FFFE5C0
          8DFFE3C08CFFE5BF8BFFE3BE8AFFEDD4A8FFBA815AFF0000000D000000000000
          000000000008D3AE89FFFDF7DCFFFCF6DAFFFCF5D9FFFCF4D8FFFBF3D6FFFBF2
          D4FFFAF0D2FFF9EFCFFFF8EDCDFFF8EBCBFFBF8C66FF0000000B000000000000
          0000000000059D8267C2D3B08BFFD4AF8AFFD4AF8AFFD4AF8AFFD2AF8AFFD3AE
          89FFD3AE89FFD3AE89FFD2AD88FFD2AC87FF9B7F63C400000007000000040000
          0006000000080000000B0000000E0000000E0000000F00000010000000100000
          0010000000100000000E0000000A0000000900000006000000028B664BBBB579
          51FFB47851FFB4764FFFB2754EFFB2744DFFB2734CFFB1734CFFB1714AFFB071
          49FFAF6F48FF7D5033BC00000005000000000000000000000000CBA07AFFFBF2
          D5FFF4E3BEFFF4E1BCFFF3E0BBFFF2DFB9FFF1DEB7FFF1DCB5FFF1DBB3FFF0D9
          B1FFEFD8AFFFB47750FF00000007000000000000000000000000D0A984FFFCF6
          DAFFF1DAB1FFF0D8AFFFF0D7ADFFEED6ACFFEED4AAFFEDD4A8FFEDD2A7FFECD1
          A5FFF2DFB9FFBA815AFF00000006000000000000000000000000D3AE89FFFDF8
          DDFFFDF8DDFFFDF7DCFFFDF6DBFFFCF6DAFFFCF5D9FFFCF4D7FFFBF3D6FFFAF2
          D4FFFAF0D2FFBF8C66FF000000050000000000000000000000009D8267BFD3B0
          8BFFD4AF8AFFD4AF8AFFD4AF8AFFD2AF8AFFD3AE89FFD3AE89FFD3AE89FFD2AD
          88FFD2AC87FF9B7E63C000000003000000000000000000000000000000010000
          0002000000020000000200000002000000030000000300000003000000030000
          0003000000030000000200000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnDesmembraClick
      end
      object btnImprimirMaisEtiqID: TBitBtnLocked
        Left = 566
        Top = 0
        Width = 150
        Height = 22
        Align = alLeft
        Caption = '&Imprimir Etiquetas ID'
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
        TabOrder = 5
        OnClick = btnImprimirMaisEtiqIDClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1184
      Top = 2
      Height = 25
      Align = alRight
      ExplicitLeft = 1184
      ExplicitTop = 2
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 714
    Width = 1263
    ExplicitTop = 714
    ExplicitWidth = 1263
    inherited pnlNomeForm: TPanel
      Left = 1092
      ExplicitLeft = 1092
    end
    inherited pnlInfo: TPanel
      Width = 1092
      ExplicitWidth = 1092
    end
  end
  object pnlContainer: TPanel [2]
    Left = 0
    Top = 0
    Width = 1263
    Height = 685
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1263
      Height = 93
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lbl1: TLabel
        Left = 9
        Top = 5
        Width = 26
        Height = 14
        Alignment = taRightJustify
        Caption = 'Placa'
      end
      object Label1: TLabel
        Left = 9
        Top = 49
        Width = 87
        Height = 14
        Caption = 'Seq. Recebimento'
      end
      object Label2: TLabel
        Left = 137
        Top = 5
        Width = 113
        Height = 14
        Caption = 'Data/Hora Recebimento'
      end
      object Label3: TLabel
        Left = 260
        Top = 5
        Width = 126
        Height = 14
        Caption = 'Operador do Recebimento'
      end
      object Bevel1: TBevel
        Left = 120
        Top = 0
        Width = 10
        Height = 92
        Shape = bsLeftLine
      end
      object Label5: TLabel
        Left = 137
        Top = 49
        Width = 89
        Height = 14
        Caption = 'Nome do Motorista'
      end
      object lblConferido: TLabel
        Left = 623
        Top = 6
        Width = 69
        Height = 14
        Caption = 'Conferido por:'
      end
      object Bevel2: TBevel
        Left = 879
        Top = 0
        Width = 10
        Height = 92
        Shape = bsLeftLine
      end
      object edtPlaca_: TMaskEditFocus
        Tag = 99
        Left = 11
        Top = 22
        Width = 93
        Height = 22
        CharCase = ecUpperCase
        EditMask = '>aaa-9a99;1;'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        Text = '   -    '
        OnKeyPress = edtPlaca_KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtIdeDig: TEditFocus
        Tag = 99
        Left = 9
        Top = 65
        Width = 95
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
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        OnKeyPress = edtIdeDigKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDtaRec: TEditFocus
        Tag = 99
        Left = 137
        Top = 21
        Width = 117
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 44
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 260
        Top = 21
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 44
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtNomOpe: TEditFocus
        Tag = 99
        Left = 304
        Top = 21
        Width = 313
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 44
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtNomMot: TEditFocus
        Tag = 99
        Left = 137
        Top = 65
        Width = 480
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 44
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtConferido: TEditFocus
        Tag = 99
        Left = 623
        Top = 21
        Width = 250
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 44
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object pnlPlanoJaFinalizado: TPanel
        AlignWithMargins = True
        Left = 934
        Top = 25
        Width = 299
        Height = 43
        Margins.Top = 25
        Margins.Right = 30
        Margins.Bottom = 25
        Align = alRight
        BevelOuter = bvNone
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 7
        Visible = False
        StyleElements = [seFont, seBorder]
        object lblPlanoFinalizado: TLabel
          Left = 13
          Top = 12
          Width = 264
          Height = 16
          Caption = 'PLANO DE RECEBIMENTO J'#193' FINALIZADO'
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
      end
    end
    object pnlGridsPlano: TPanel
      Left = 0
      Top = 93
      Width = 1263
      Height = 473
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object sptSplitter: TSplitter
        Left = 0
        Top = 332
        Width = 1263
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        Color = clYellow
        ParentColor = False
        Visible = False
        OnMoved = sptSplitterMoved
        ExplicitTop = 0
      end
      object pnlGridSuperior: TPanel
        Left = 0
        Top = 0
        Width = 1263
        Height = 332
        Align = alClient
        TabOrder = 0
        object Splitter1: TSplitter
          AlignWithMargins = True
          Left = 635
          Top = 4
          Width = 6
          Height = 324
          Align = alRight
          Color = clYellow
          ParentColor = False
          OnMoved = Splitter1Moved
          ExplicitLeft = 389
          ExplicitTop = -25
          ExplicitHeight = 278
        end
        object cxgItens: TcxGridCitel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 625
          Height = 324
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgItensTableView: TcxGridDBTableViewCitel
            PopupMenu = popReimpressao
            OnKeyDown = cxgItensTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxgItensTableViewCustomDrawCell
            OnEditing = cxgItensTableViewEditing
            OnEditKeyDown = cxgItensTableViewEditKeyDown
            OnEditKeyPress = cxgItensTableViewEditKeyPress
            OnFocusedRecordChanged = cxgItensTableViewFocusedRecordChanged
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.CopyRecordsToClipboard = False
            OptionsCustomize.ColumnMoving = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgItensTableViewMODCUB: TcxGridDBColumn
              Caption = 'Cubagem'
              DataBinding.FieldName = 'MODCUB'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Autom'#225'tica'
                'Manual')
              OnGetDisplayText = cxgItensTableViewMODCUBGetDisplayText
              Options.Editing = False
              Width = 63
            end
            object cxgItensTableViewCONFER: TcxGridDBColumn
              Caption = 'C'
              DataBinding.FieldName = 'CONFER'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = cxImageList2
              Properties.Items = <
                item
                  ImageIndex = 0
                  Value = 'MAIS'
                end
                item
                  ImageIndex = 1
                  Value = 'MENOS'
                end
                item
                  ImageIndex = 2
                  Value = 'OK'
                end>
              HeaderHint = 'Legenda do Status da Confer'#234'ncia'
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Width = 20
            end
            object cxgItensTableViewLEGEND: TcxGridDBColumn
              Caption = 'E'
              DataBinding.FieldName = 'LEGEND'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = cxImageList1
              Properties.Items = <
                item
                  ImageIndex = 0
                  Value = '0'
                end
                item
                  ImageIndex = 1
                  Value = '2'
                end
                item
                  ImageIndex = 2
                  Value = '1'
                end>
              HeaderHint = 'Legenda do Status do Endere'#231'amento'
              Options.Editing = False
              Options.Focusing = False
              Width = 20
            end
            object cxgItensTableViewCODITE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 53
            end
            object cxgItensTableViewDESITE: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 197
            end
            object cxgItensTableViewCODUNI: TcxGridDBColumn
              Caption = 'Unidade'
              DataBinding.FieldName = 'UNI_SIGUNI'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
            end
            object cxgItensTableViewNIVGIR: TcxGridDBColumn
              Caption = 'N'#237'vel de Giro'
              DataBinding.FieldName = 'NIVGIR'
              Options.Editing = False
              Options.Focusing = False
              Width = 69
            end
            object cxgItensTableViewQTDITE: TcxGridDBColumn
              Caption = 'Emb. master'
              DataBinding.FieldName = 'QTDITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 77
            end
            object cxgItensTableViewEMBREC: TcxGridDBColumn
              Caption = 'Emb. rec'
              DataBinding.FieldName = 'EMBREC'
              Options.Editing = False
            end
            object cxgItensTableViewQTDUNI: TcxGridDBColumn
              Caption = 'Qtd. Total (Un.)'
              DataBinding.FieldName = 'DET_QTDITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 78
            end
            object cxgItensTableViewQTDCON: TcxGridDBColumn
              Caption = 'Qtd. Conferida (Un.)'
              DataBinding.FieldName = 'QTDCON'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.OnEditValueChanged = cxgItensTableViewQTDCONPropertiesEditValueChanged
              OnCustomDrawCell = cxgItensTableViewQTDCONCustomDrawCell
              Options.Focusing = False
              Width = 103
            end
            object cxgItensTableViewQTDEND: TcxGridDBColumn
              Caption = 'Qtde. Endere.'
              DataBinding.FieldName = 'QTDEND'
              Options.Editing = False
              Options.Focusing = False
              Width = 77
            end
            object cxgItensTableViewCLASSE: TcxGridDBColumn
              Caption = 'Classe de Local'
              DataBinding.FieldName = 'CLASSE'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.DropDownListStyle = lsEditFixedList
              Properties.Sorted = True
              Width = 90
            end
            object cxgItensTableViewCXCAMA: TcxGridDBColumn
              Caption = 'Caixas p/ Camada'
              DataBinding.FieldName = 'CXCAMA'
              Options.Editing = False
              Options.Focusing = False
              Width = 100
            end
            object cxgItensTableViewQTCAMA: TcxGridDBColumn
              Caption = 'Empilhamento'
              DataBinding.FieldName = 'QTCAMA'
              Options.Editing = False
              Options.Focusing = False
              Width = 77
            end
            object cxgItensTableViewQTDETI: TcxGridDBColumn
              Caption = 'Qtd. Etiquetas'
              DataBinding.FieldName = 'QTDETI'
              Width = 76
            end
            object cxgItensTableViewIMPETI: TcxGridDBColumn
              DataBinding.FieldName = 'IMPETI'
              Visible = False
            end
            object cxgItensTableViewEXCEDE: TcxGridDBColumn
              Caption = 'Excedente?'
              DataBinding.FieldName = 'EXCEDENTE'
              Visible = False
            end
            object cxgItensTableViewQTDITE_POR_ETIQUETA: TcxGridDBColumn
              Caption = 'Qtd. Item Por Etiqueta'
              DataBinding.FieldName = 'QTDITE_POR_ETIQUETA'
            end
            object cxgItensTableViewSELECE: TcxGridDBColumn
              DataBinding.FieldName = 'SELECE'
              Visible = False
            end
            object cxgItensTableViewABPICK: TcxGridDBColumn
              DataBinding.FieldName = 'ABPICK'
              Visible = False
            end
            object cxgItensTableViewCLA_CHEEXC: TcxGridDBColumn
              DataBinding.FieldName = 'CLA_CHEEXC'
              Visible = False
            end
          end
          object cxgItensLevel: TcxGridLevel
            GridView = cxgItensTableView
          end
        end
        object pnlGridsPlanoSuge: TPanel
          Left = 644
          Top = 1
          Width = 618
          Height = 330
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object cxgSugestao: TcxGridCitel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 610
            Height = 266
            Margins.Right = 5
            Align = alClient
            TabOrder = 0
            OnEnter = cxgSugestaoEnter
            OnExit = cxgSugestaoExit
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgSugestaoTableView: TcxGridDBTableViewCitel
              PopupMenu = popReimpressao
              OnKeyPress = cxgSugestaoTableViewKeyPress
              Navigator.Buttons.CustomButtons = <>
              OnCanFocusRecord = cxgSugestaoTableViewCanFocusRecord
              OnCustomDrawCell = cxgSugestaoTableViewCustomDrawCell
              DataController.DataSource = dtsLocSug
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxgSugestaoTableViewEndere: TcxGridDBColumn
                DataBinding.FieldName = 'ENDERE'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Images = cxImageList1
                Properties.Items = <
                  item
                    ImageIndex = 0
                    Value = 'N'
                  end
                  item
                    ImageIndex = 1
                    Value = 'S'
                  end>
                Options.Editing = False
                Options.Focusing = False
                Options.Grouping = False
                Width = 22
                IsCaptionAssigned = True
              end
              object cxgSugestaoTableViewABPICK: TcxGridDBColumn
                DataBinding.FieldName = 'ABPICK'
                Visible = False
                OnCustomDrawCell = cxgSugestaoTableViewABPICKCustomDrawCell
                OnGetDisplayText = cxgSugestaoTableViewABPICKGetDisplayText
                HeaderAlignmentHorz = taCenter
                SortIndex = 0
                SortOrder = soDescending
                IsCaptionAssigned = True
              end
              object cxgSugestaoTableViewSELECE: TcxGridDBColumn
                Caption = 'Selecionar'
                DataBinding.FieldName = 'SELECE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.Alignment = taCenter
                Properties.ImmediatePost = True
                Properties.NullStyle = nssUnchecked
                HeaderAlignmentHorz = taCenter
                Width = 53
              end
              object cxgSugestaoTableViewCODITE: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'CODITE'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 38
              end
              object cxgSugestaoTableViewDESITE: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESITE'
                Options.Editing = False
                Width = 173
              end
              object cxgSugestaoTableViewLocFis: TcxGridDBColumn
                Caption = 'Localiza'#231#227'o'
                DataBinding.FieldName = 'LOCFIS'
                OnCustomDrawCell = cxgSugestaoTableViewLocFisCustomDrawCell
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 90
              end
              object cxgSugestaoTableViewDtaVal: TcxGridDBColumn
                Caption = 'Validade'
                DataBinding.FieldName = 'DTAVAL'
                HeaderAlignmentHorz = taCenter
                Width = 65
              end
              object cxgSugestaoTableViewQtdIte: TcxGridDBColumn
                Caption = 'Emb. master'
                DataBinding.FieldName = 'QTDITE'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Options.Focusing = False
                Width = 71
              end
              object cxgSugestaoTableEMBREC: TcxGridDBColumn
                Caption = 'Emb. rec'
                DataBinding.FieldName = 'EMBREC'
                Options.Editing = False
              end
              object cxgSugestaoTableViewQtdVen: TcxGridDBColumn
                Caption = 'Qtde. Total (Un)'
                DataBinding.FieldName = 'QTDVEN'
                Options.Editing = False
                Options.Focusing = False
                Width = 81
              end
              object cxgSugestaoTableViewBufVen: TcxGridDBColumn
                DataBinding.FieldName = 'BUFVEN'
                Visible = False
              end
              object cxgSugestaoTableViewFISPIC: TcxGridDBColumn
                DataBinding.FieldName = 'FISPIC'
                Visible = False
              end
              object cxgSugestaoTableViewEXCESS: TcxGridDBColumn
                DataBinding.FieldName = 'EXCESS'
                Visible = False
              end
              object cxgSugestaoTableViewLOCTIPO: TcxGridDBColumn
                Caption = 'Tipo de localiza'#231#227'o f'#237'sica'
                DataBinding.FieldName = 'LOCTIPO'
                Visible = False
                GroupIndex = 0
              end
            end
            object cxgSugestaoLevel1: TcxGridLevel
              GridView = cxgSugestaoTableView
            end
          end
          object pnlLegendaLocalSeparacao: TFlowPanel
            Left = 0
            Top = 272
            Width = 618
            Height = 58
            Align = alBottom
            AutoSize = True
            BevelOuter = bvNone
            TabOrder = 1
            object pnlEnderecado: TPanel
              Left = 0
              Top = 0
              Width = 91
              Height = 19
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Label7: TLabel
                Left = 22
                Top = 1
                Width = 58
                Height = 14
                Caption = 'Endere'#231'ado'
              end
              object imgEndere: TImage
                Left = 0
                Top = 0
                Width = 16
                Height = 19
                Align = alLeft
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  00000000000000000002000000090000000E0000000F0000000F0000000F0000
                  001000000010000000100000001100000011000000100000000B000000030000
                  00000000000000000008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73
                  C0FF2870BEFF266EBDFF256DBCFF226BBBFF216AB9FF154B84C20000000A0000
                  0000000000000000000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2
                  E8FF58B0E7FF54AFE7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F0000
                  0000000000000000000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583
                  C7FF3381C6FF307FC4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F0000
                  0000000000000000000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEA
                  E7FFE6E1DEFFE9E4E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F0000
                  0000000000000000000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7
                  AFFF125838FF668877FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E0000
                  0000000000000000000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E82
                  5BFF2EE1AAFF15744FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D0000
                  000000000000000000094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40EC
                  B9FF38ECB7FF2BD19CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D0000
                  000000000000000000094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9
                  D7FF77F7D7FF41EBB9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C0000
                  000000000000000000085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E
                  7EFF237956FF6ADFC1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D0000
                  00000000000000000007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8
                  A9FFC5D1CBFF408D6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF000000150000
                  00010000000000000007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEE
                  ECFFEDEBEAFFD1D9D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B0000
                  000200000000000000065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E
                  5DFF696462FFABA8A8FFB2B7B3FF3B826DFF359170FF6D95A5FF000000130000
                  000000000000000000055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0
                  DDFFCFC6C1FFB8AFAAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A0000
                  000000000000000000034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CC
                  CAFFC8C3C1FF6C6664FF76726FFF837F7DFF5C95CBFF4E7BA6CA000000050000
                  000000000000000000010000000300000004000000050000000525232243716C
                  6ACA605B59CA1D1B1B4400000006000000060000000600000004000000010000
                  0000}
                Transparent = True
                ExplicitLeft = 8
              end
            end
            object Panel1: TPanel
              Left = 91
              Top = 0
              Width = 160
              Height = 19
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 1
              object imgNaoEnd: TImage
                Left = 0
                Top = 0
                Width = 16
                Height = 19
                Align = alLeft
                Picture.Data = {
                  07544269746D617036040000424D360400000000000036000000280000001000
                  0000100000000100200000000000000400000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000001010306110B3F6F1F1473CB2518
                  8AF425188AF41F1473CB110B3F6F010103060000000000000000000000000000
                  00000000000000000000000000000503101B251B79CF2A28B0FF242FC0FF2535
                  C8FF2435C8FF232FC1FF2A27B0FF261B7AD00503101B00000000000000000000
                  00000000000000000000010104072B227FD03236BCFF263AC7FF2231C0FF2A3A
                  C6FF2A3AC6FF202FC0FF263AC7FF3135BCFF2B2280D101010407000000000000
                  000000000000000000001A16466E3B3CBFFF283DC8FF646ECEFF9EA2DBFF3744
                  C3FF3544C3FF9A9DD6FF6069CBFF283DC9FF393ABDFF1A16466E000000000000
                  00000000000000000000363085C73E4ED1FF1F33C4FF9B93C1FFFFFFECFFB3B1
                  DBFFB2AFD8FFFFFFF4FF9A94C3FF1B2EC0FF3E4ED3FF363085C7000000000000
                  000000000000000000004B46AEF94158DAFF364ED4FF3540B8FFAA9AB5FFFFFF
                  F2FFFFFFF7FFB1A5C1FF343FB8FF374ED3FF4258DAFF4945AAF3000000000000
                  000000000000000000005350B6F9435BDDFF576CDBFF4C5DD1FFACABD8FFFFFF
                  F1FFFFFFF1FFA9A8D5FF4353CAFF5268DBFF455EDDFF5350B5F8000000000000
                  00000000000000000000494897C7778AE6FF6579DBFF9E97C5FFFFFFF7FFAFA6
                  C7FFA395B5FFFFFFF2FF9C97C7FF4D61D1FF6A7DE5FF494897C7000000000000
                  000000000000000000002B2B556D8890E0FF859BECFF7D80C4FF8E81ADFF636E
                  CBFF5D67C4FF8C7EA9FF767AC5FF6B83E4FF7B84E0FF2B2B556D000000000000
                  00000000000000000000030305065859A8CF95A1E8FF8CA1EBFF6C7DD8FF97AC
                  F1FF95ABF2FF6273D5FF778EE5FF8A97E8FF585AA9D003030607000000000000
                  00000000000000000000000000000C0C161B5D60ACCF9CA5E7FFAEBFF5FFA6BB
                  F3FFA4B7F2FFA4B8F4FF959FE7FF5D60ACCF0C0C161B00000000000000000000
                  0000000000000000000000000000000000000303050634355E6E5E61A9C77276
                  CFF37276CFF35E61A9C734355E6E030305060000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000}
                Transparent = True
                ExplicitLeft = -95
                ExplicitHeight = 16
              end
              object Label6: TLabel
                Left = 16
                Top = 0
                Width = 138
                Height = 19
                Align = alLeft
                Caption = 'Aguardando endere'#231'amento'
                ExplicitHeight = 14
              end
            end
            object pnlEndPar: TPanel
              Left = 251
              Top = 0
              Width = 185
              Height = 19
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 2
              object imgSepPar: TImage
                Left = 2
                Top = 1
                Width = 16
                Height = 16
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF610000004D744558745469746C6500436F6E6469
                  74696F6E616C466F726D617474696E7349636F6E536574547261666669634C69
                  6768747352696D6D6564333B436F6E646974696F6E616C466F726D617474696E
                  673B060A9CC10000027449444154785E6593CD6B545718C67FE7DE3B5FE6DE24
                  922FC710A319051310B1114111DA52E84A745D70EFC26DC145C1A5CBFE056EC4
                  BFA0B8D24D711715295DB4D19898766C11AC339D64BEEECCBDEFFB5A0EC265E8
                  E1700EE7E57D9EF37B0E1CB779E5DAB751A972CFE1362906863131ACA89AE92F
                  E374F8C3AF2F1E3F894AA5F2C3D593AB8BC9F434A8826F00332B046A380CC557
                  E875BB179ACDBF1E00272233B718C7316FF7F649D39464162E7EADAC9C16A223
                  235A1F72DEED86BCDA9AA277006094CB65800520080C45454887434E9C81DB77
                  13AEDF68B0796E9DB563A758582CD3389FF2CDCD8F2CAF39540D4C3155F0066A
                  E4AAC4B3C677B7124E2FAF915467288715E2DA34F5F9E338074149B8726D4032
                  E3100335C53B981926C2175FC2D2FC3C98C311E27080A356AE82056090598F0B
                  572B9819EA0970819A22AA9C5CCF0883904C32321993498E6A4E3F1DA02A98BF
                  55686C94B022828B4CD5BB05A58CEEE080B89A0081178FB2117FFFF31E11F5D9
                  0317529B0AC013C8670215F23CA7D31EB3FFBE49ABDB6638EEFBFD75F30D87BD
                  9E3730336A9598615F310C95CF04AAEA1BF6B7434AB51EDDC12E189E2A17F58D
                  22867301D35347F9EDF9C8D388E68581AAB0BD5565E5EC88B09483F9898A61E6
                  C52CCCD4B13CE2F9D343CC822282887882C37F95678F660935C1344072F599E3
                  DA0CF5B955428EF0D3830E07AD0C2623086AE291FFDC513AF7232E7D55A7B151
                  612A09E87795DF5FA43CFBB9C3415B3C91158F886B6C5CFEB0746C792113C1D9
                  E427B262A528C3281DD269B73EBEDB7B79261AF6BBDFFFF176E7479C9BF3066E
                  52E300983C9B693BCFD23B40EA800A5003C2A27F42C7FF7D1060008C3F010888
                  84CBDB5B77810000000049454E44AE426082}
                Transparent = True
              end
              object lblSepPar: TLabel
                Left = 24
                Top = 1
                Width = 122
                Height = 14
                Caption = 'Endere'#231'ado Parcialmente'
              end
            end
            object pnlLocalizacao: TPanel
              Left = 0
              Top = 19
              Width = 424
              Height = 19
              BevelOuter = bvNone
              TabOrder = 3
              object shpMsgDtaVal: TShape
                Left = 3
                Top = 3
                Width = 12
                Height = 12
                Brush.Color = clRed
                Pen.Style = psClear
              end
              object lblMsgDtaVal: TLabel
                Left = 23
                Top = 1
                Width = 359
                Height = 14
                Caption = 
                  'Localiza'#231#227'o picking por'#233'm no buffer tem item com data de validad' +
                  'e inferior'
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
            end
            object Panel4: TPanel
              Left = 424
              Top = 19
              Width = 152
              Height = 19
              BevelOuter = bvNone
              TabOrder = 4
              object shpMsgLocExc: TShape
                Left = 3
                Top = 3
                Width = 12
                Height = 12
                Brush.Color = 7314943
                Pen.Style = psClear
              end
              object lblMsgLocExc: TLabel
                Left = 23
                Top = 1
                Width = 118
                Height = 14
                Caption = 'Localiza'#231#227'o de excesso'
                Font.Charset = ANSI_CHARSET
                Font.Color = 4227327
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
            end
            object pnlAbastecer: TPanel
              Left = 0
              Top = 38
              Width = 121
              Height = 18
              BevelOuter = bvNone
              TabOrder = 5
              object lblLegAbPick: TLabel
                Left = 21
                Top = 2
                Width = 87
                Height = 14
                Caption = 'Abastecer picking'
                Font.Charset = ANSI_CHARSET
                Font.Color = 16711808
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object shpAbPick: TShape
                Left = 3
                Top = 4
                Width = 12
                Height = 12
                Margins.Top = 5
                Margins.Bottom = 0
                Brush.Color = 16711808
                Pen.Style = psClear
              end
            end
            object Panel2: TPanel
              Left = 121
              Top = 38
              Width = 448
              Height = 20
              BevelOuter = bvNone
              TabOrder = 6
              object lblAtualizarSugestoes: TLabel
                AlignWithMargins = True
                Left = 140
                Top = 3
                Width = 43
                Height = 17
                Cursor = crHandPoint
                Align = alLeft
                Caption = 'Atualizar'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsUnderline]
                ParentFont = False
                OnClick = lblAtualizarSugestoesClick
                ExplicitHeight = 14
              end
              object chkAllPick: TCheckBox
                Left = 0
                Top = 0
                Width = 137
                Height = 20
                Align = alLeft
                Caption = 'Exibir Todos Os Picking'#39's'
                TabOrder = 0
                OnClick = chkAllPickClick
              end
            end
          end
        end
      end
      object pnlEtiquetasID: TPanel
        Left = 0
        Top = 337
        Width = 1263
        Height = 136
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object cxgEtiqueta: TcxGridCitel
          AlignWithMargins = True
          Left = 3
          Top = 27
          Width = 1257
          Height = 106
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgEtiquetaTableView: TcxGridDBTableViewCitel
            OnKeyPress = cxgEtiquetaTableViewKeyPress
            Navigator.Buttons.CustomButtons = <>
            OnCanFocusRecord = cxgEtiquetaTableViewCanFocusRecord
            OnCustomDrawCell = cxgEtiquetaTableViewCustomDrawCell
            OnFocusedRecordChanged = cxgEtiquetaTableViewFocusedRecordChanged
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnMoving = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgEtiquetaTableViewCHAVE: TcxGridDBColumn
              Caption = 'Etiqueta ID'
              DataBinding.FieldName = 'CHAVE'
              Visible = False
              GroupIndex = 0
              Width = 348
            end
            object cxgEtiquetaTableViewCODBAR: TcxGridDBColumn
              Caption = 'C'#243'd. Barras'
              DataBinding.FieldName = 'ITE_CODBAR'
              Options.Editing = False
              Width = 126
            end
            object cxgEtiquetaTableViewCODITE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODITE'
              Options.Editing = False
              Width = 78
            end
            object cxgEtiquetaTableViewDESITE: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'ITE_DESITE'
              Options.Editing = False
              Width = 389
            end
            object cxgEtiquetaTableViewCODUN: TcxGridDBColumn
              Caption = 'Unidade'
              DataBinding.FieldName = 'ITE_CODUNI'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 123
            end
            object cxgEtiquetaTableViewNIVGIR: TcxGridDBColumn
              Caption = 'N'#237'vel de Giro'
              DataBinding.FieldName = 'ITE_NIVGIR'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 92
            end
            object cxgEtiquetaTableViewQTDEMB: TcxGridDBColumn
              Caption = 'Qtd. Emb.'
              DataBinding.FieldName = 'ETI_QTDEMB'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 138
            end
            object cxgEtiquetaTableViewQTDITE: TcxGridDBColumn
              Caption = 'Qtd. UN.'
              DataBinding.FieldName = 'ETI_QTDITE'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 113
            end
            object cxgEtiquetaTableViewSTATUS: TcxGridDBColumn
              DataBinding.FieldName = 'STATUS'
              Visible = False
            end
            object cxgEtiquetaTableViewID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object cxgEtiquetaTableViewLOCFIS: TcxGridDBColumn
              Caption = 'Localiza'#231#227'o f'#237'sica'
              DataBinding.FieldName = 'LOCFIS'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 267
            end
          end
          object cxgEtiquetaLevel1: TcxGridLevel
            GridView = cxgEtiquetaTableView
          end
        end
        object pnlTituloEtiquetas: TPanel
          Left = 0
          Top = 0
          Width = 1263
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object lblTituloPainelEtiquetas: TLabel
            Left = 5
            Top = 3
            Width = 318
            Height = 17
            Caption = 'Etiquetas ID dos produtos com cubagem manual'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblExpandirRecolherEtiquetasID: TLabel
            AlignWithMargins = True
            Left = 345
            Top = 6
            Width = 88
            Height = 14
            Cursor = crHandPoint
            Caption = 'Expandir/Recolher'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblExpandirRecolherEtiquetasIDClick
          end
        end
      end
    end
    object pnlLegendas: TPanel
      Left = 0
      Top = 566
      Width = 1263
      Height = 119
      Align = alBottom
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 2
      object pnlLegendaConferencia: TPanel
        Left = 0
        Top = 50
        Width = 1263
        Height = 37
        Align = alBottom
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 0
        object Image1: TImage
          Left = 2
          Top = 2
          Width = 17
          Height = 16
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            0000001008060000001FF3FF61000000A449444154785EDD93310E83300C456B
            D443B477E80598AAEEE11A9C82915330F60AED8E3A7562E302C0005720038628
            128E1591286240E24B1E9C48DFEFCB3220E2658FA2A58E35B89A0D00ACCDED03
            2CDB90A08A1B46500B54C506D8040E75D21F8161DDBF11632C9EBA4D7F7C722F
            26D824C862F268A5FD96FFC11DA1F563BB0DDE15E1BE1E9AA6ACC16740AB32D7
            4834F48788015B18832370C986D0693AD7098E690678DC3BE2CD8F272E000000
            0049454E44AE426082}
          Transparent = True
        end
        object Label8: TLabel
          Left = 22
          Top = 3
          Width = 186
          Height = 14
          Caption = 'Quantidade conferida maior que o total'
        end
        object Image2: TImage
          Left = 217
          Top = 1
          Width = 17
          Height = 16
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            0000001008060000001FF3FF610000008649444154785EA5933D0E80200C85DB
            F83B791207BCFFEE8A83675171A9404A2426A65A9AF0DEC4D73E1A9088A0A4EA
            A888C6ABFD099880688900C7977F96ED009001BAEA5284430918BC144D001280
            D85102E4114661AD2B66384D04274598B30E277BAB7D83047E0D25AD716327ED
            043B7BA5056CECCD0780F1B63C013DFB4B0313A4F83B5F3F122766C617C08000
            00000049454E44AE426082}
          Transparent = True
        end
        object Label9: TLabel
          Left = 237
          Top = 3
          Width = 190
          Height = 14
          Caption = 'Quantidade conferida menor que o total'
        end
        object Image3: TImage
          Left = 434
          Top = 1
          Width = 17
          Height = 16
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            0000001008060000001FF3FF6100000021744558745469746C65004170706C79
            3B4F4B3B436865636B3B426172733B526962626F6E3B6463C8680000037D4944
            4154785E4D8E7F4C94051CC63FEF7B77E02073EA92742577579B684891E62AB6
            C4526B6013696BC9DC5A0B33D0322DA716D3CA94A21A8E96E976AEB654688E40
            9B46B859CC249500E3F81588234EE0F875DC1DF7A3BB7BDFF7DBC16AEBD9F3D9
            BEFF3CCFF7C13555CB58A80140014CC5E5696BF638D24FBEF7EDF2D683550F7B
            0E5666B4969C5A5EBBEBCB652F0209803A116E6438F82377A66A60385007A0E4
            EFB2A5BC51B1B4AEF4EC5AB9D476583A87AA642C7055BA47CE4A43F727527131
            57F67D93DE54B0DFBE04308D867E9E290050725F4BBDB7F8E8B29EAA86B7C4E5
            BF203DDEE3D23E71585AC6F648E7E4C7D2E777C870A05E7E68DE277B4F668C6E
            DE6BCF00D4017F350A607EF548DAB99CECBC9CF4343BC3E1264CAA60C282AAA8
            288A028A30313E852DE509EE0C4D72EEF26967CD17FD4F0EDE0A064DF9BBEDEB
            6CD6C51F3C9DF5382EFF1540104014216E500C2ED6DDA4F67C3BEDB79BC9C95E
            C3E8F8784AD28288BBADC1D36C4E98652A7C2C7D2543816674430304C4885B07
            55E1CC99EBCC51D750F14E35DBCB32E91DF98DCCA5ABE8FCB36733E0500D3132
            EF9EAB108C7AE9ED1BA6B4AC969F2E39896A11CE5F68212529975D5B4A395A59
            C40B79CF6049D0489AAD81AA3C0A9854436741140FE148809AEA16CA8AAEA34C
            65F1E9E7F524EBEBD99A7F8053751FB2707118EB836642311F31C63174497C28
            6BEE6C55D3F48971DF2088C1A60D6BF9BAB6849D0547D8FD520D2F3F5F822FD8
            C7AFCEEF58B16A11FEC828313DC6A87F8868C488745C9D0C9AF5A8D2E51EF15B
            E72FD248B127E2F5FE8DE3FBFDEC28280755E1FDCFB691BF310B6FC48566C4C0
            30F08D458984B40E4057837EADAAA7CB87A0E2090EB2E491594C1A4DD45C2EC7
            79AB0E53B287C4399384A353718288A8F4767B09F8F4F380069094BBDD7AB3E4
            74869CB8B1428E5DCB90AAB60DB2E59055B2B621C72EAF93134D99723C8EE3F7
            9572A83A5336EEB439EF9A67990FA82A1071F7855EF9E35AC0D3EB0C010A9EF0
            00799B56F1EEDBAFC7BF87D00D411185BEEE30AD8DFE88AB2B501CF0C4FC5706
            DE34CC0D7F15E9AB53BF6A17784ED78C4AB72BF6803DDD82B6B013D5A420064C
            B875FABB628CB8A21DEEDBA1A2D6FAB11B8066480C7EE92F045000737CD6BCA7
            36DFB77F7D616A63EE769BCCB0C326CF6E4D6D5B5D70FF47C9732CF700164099
            CE4D3373FCA76CAB43052CFF62065440001D884E130F19FC4FFF00FE20CB5D5D
            F1FFF30000000049454E44AE426082}
          Transparent = True
        end
        object Label10: TLabel
          Left = 457
          Top = 3
          Width = 77
          Height = 14
          Caption = 'Confer'#234'ncia OK'
        end
        object lblLegNaoLocalizado: TLabel
          Left = 697
          Top = 3
          Width = 101
          Height = 14
          Caption = 'N'#227'o localizado na NF'
          Color = clBlack
          ParentColor = False
        end
        object shpRed: TShape
          Left = 674
          Top = 0
          Width = 17
          Height = 17
          Brush.Color = 8421631
          Pen.Style = psClear
        end
        object Label4: TLabel
          Left = 568
          Top = 3
          Width = 96
          Height = 14
          Caption = 'Etiqueta j'#225' impressa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object shpImpresso: TShape
          Left = 546
          Top = 1
          Width = 16
          Height = 16
          Brush.Color = clGreen
          Pen.Color = clGreen
        end
        object shpClaPic: TShape
          Left = 261
          Top = 20
          Width = 16
          Height = 16
          Brush.Color = 8421440
          Pen.Color = clGreen
          Visible = False
        end
        object lblClaPic: TLabel
          Left = 283
          Top = 22
          Width = 69
          Height = 14
          Caption = 'Classe picking'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object shpPicExc: TShape
          Left = 357
          Top = 20
          Width = 17
          Height = 17
          Brush.Color = 16711808
          Pen.Style = psClear
          Visible = False
        end
        object lblPicExc: TLabel
          Left = 380
          Top = 23
          Width = 269
          Height = 14
          Caption = 'Quantidade do item vai exceder/encher a classe picking'
          Color = clBlack
          ParentColor = False
          Visible = False
        end
        object Image4: TImage
          Left = 828
          Top = 1
          Width = 16
          Height = 16
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            0000001008060000001FF3FF610000004D744558745469746C6500436F6E6469
            74696F6E616C466F726D617474696E7349636F6E536574547261666669634C69
            6768747352696D6D6564333B436F6E646974696F6E616C466F726D617474696E
            673B060A9CC10000027449444154785E6593CD6B545718C67FE7DE3B5FE6DE24
            922FC710A319051310B1114111DA52E84A745D70EFC26DC145C1A5CBFE056EC4
            BFA0B8D24D711715295DB4D19898766C11AC339D64BEEECCBDEFFB5A0EC265E8
            E1700EE7E57D9EF37B0E1CB779E5DAB751A972CFE1362906863131ACA89AE92F
            E374F8C3AF2F1E3F894AA5F2C3D593AB8BC9F434A8826F00332B046A380CC557
            E875BB179ACDBF1E00272233B718C7316FF7F649D39464162E7EADAC9C16A223
            235A1F72DEED86BCDA9AA277006094CB65800520080C45454887434E9C81DB77
            13AEDF68B0796E9DB563A758582CD3389FF2CDCD8F2CAF39540D4C3155F0066A
            E4AAC4B3C677B7124E2FAF915467288715E2DA34F5F9E338074149B8726D4032
            E3100335C53B981926C2175FC2D2FC3C98C311E27080A356AE82056090598F0B
            572B9819EA0970819A22AA9C5CCF0883904C32321993498E6A4E3F1DA02A98BF
            55686C94B022828B4CD5BB05A58CEEE080B89A0081178FB2117FFFF31E11F5D9
            0317529B0AC013C8670215F23CA7D31EB3FFBE49ABDB6638EEFBFD75F30D87BD
            9E3730336A9598615F310C95CF04AAEA1BF6B7434AB51EDDC12E189E2A17F58D
            22867301D35347F9EDF9C8D388E68581AAB0BD5565E5EC88B09483F9898A61E6
            C52CCCD4B13CE2F9D343CC822282887882C37F95678F660935C1344072F599E3
            DA0CF5B955428EF0D3830E07AD0C2623086AE291FFDC513AF7232E7D55A7B151
            612A09E87795DF5FA43CFBB9C3415B3C91158F886B6C5CFEB0746C792113C1D9
            E427B262A528C3281DD269B73EBEDB7B79261AF6BBDFFFF176E7479C9BF3066E
            52E300983C9B693BCFD23B40EA800A5003C2A27F42C7FF7D1060008C3F010888
            84CBDB5B77810000000049454E44AE426082}
          Transparent = True
        end
        object Label11: TLabel
          Left = 850
          Top = 1
          Width = 122
          Height = 14
          Caption = 'Endere'#231'ado Parcialmente'
        end
        object chkGerCob: TCheckBox
          Left = 3
          Top = 20
          Width = 252
          Height = 17
          Caption = 'Gerar cobran'#231'a de descarregamento de pallets?'
          TabOrder = 0
        end
      end
      object pnlBotoesEtiquetas: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1257
        Height = 44
        Align = alBottom
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object lblLegIDFechada: TLabel
          Left = 28
          Top = 3
          Width = 81
          Height = 14
          Caption = 'Etiqueta fechada'
          Color = clBlack
          ParentColor = False
          StyleElements = [seFont, seBorder]
        end
        object shpIDFechada: TShape
          Left = 5
          Top = 1
          Width = 17
          Height = 17
          Brush.Color = clMoneyGreen
          Pen.Style = psClear
        end
        object shpLegEtiqFechada: TShape
          Left = 130
          Top = 1
          Width = 17
          Height = 17
          Brush.Color = 4227327
          Pen.Style = psClear
        end
        object lblLegEtiqEnderecada: TLabel
          Left = 153
          Top = 3
          Width = 99
          Height = 14
          Caption = 'Etiqueta endere'#231'ada'
          Color = clBlack
          ParentColor = False
          StyleElements = [seFont, seBorder]
        end
        object btnLimparEtiqueta: TBitBtnLocked
          AlignWithMargins = True
          Left = 0
          Top = 19
          Width = 165
          Height = 22
          Margins.Top = 10
          Caption = '[F8] - Limpar etiqueta'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00020000000900000012000000180000001A0000001A00000018000000100000
            0005000000010000000000000000000000000000000000000000000000020000
            000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
            022800000006000000010000000000000000000000000000000000000008442F
            1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
            2AD80302042A00000006000000010000000000000000000000000000000DB07D
            4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
            7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
            329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
            CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
            000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
            CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
            00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
            D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
            0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
            F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
            000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
            F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
            000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
            F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
            00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
            F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
            000000000000000000000000000000000000000000010000000736457A9FD8F0
            FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
            0000000000000000000000000000000000000000000000000001000000063947
            7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
            0000000000000000000000000000000000000000000000000000000000010000
            00053543728E4F63AACD151A2D40000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0001000000030000000400000002000000000000000000000000}
          TabOrder = 0
          OnClick = btnLimparEtiquetaClick
        end
        object btnTirarProduto: TBitBtnLocked
          AlignWithMargins = True
          Left = 171
          Top = 19
          Width = 175
          Height = 22
          Margins.Top = 10
          Caption = '[F9] - Tirar produto da etiqueta'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000070000
            000C0000000D0000000E0000000F000000100000001100000013000000140000
            00140000000D0000000303400A81000000000000000000000000977050BECF9A
            6EFFCE986CFFCD976AFFCC9568FFCB9366FFC99164FFC99162FFC88F60FFC78D
            5EFF8E6442C50000000D078115FF03400A810000000000000000D19E72FFFFFF
            FFFFF9F2EAFFF8F1E8FFF9F1E6FFF8F0E5FFF8EFE4FFF7EEE3FFF7EEE2FFF7ED
            E1FFC78D5FFF00000012088316FF2A963AFF033F0A8100000000D3A175FFFFFF
            FFFFFAF3EBFFF9F2EAFFF9F1E8FFF9F1E7FFF8F0E6FFF8F0E4FFF8EFE3FFF7EE
            E3FFC88F61FF00000011098517FF4DAB5FFF168C28FF033F0A81D4A277FFFFFF
            FFFFD9B28DFFD8B08BFFD7AF8AFFD6AD88FFD5AC87FFD4AC86FFD4AB85FFF8EE
            E3FFC99264FF000000100B8819FF50AE62FF209231FF033F0B7ED6A47AFFFFFF
            FFFFFBF5EEFFFAF5EDFFF9F4ECFFF9F3EBFFF9F2EAFFF8F1E8FFF9F1E7FFF8F0
            E5FFCA9465FF0000000E0B8B1AFF2F9C40FF04420B7E00000000D7A77CFFFFFF
            FFFFDBB591FFDBB48FFFDAB28EFFD8B18CFFD7B08BFFD7AE89FFD5AD87FFF8F0
            E7FFCC9668FF0000000C0C8D1BFF05450D7E0000000000000000D8A87EFFFFFF
            FFFFFBF7F2FFFBF6F0FFFAF6EFFFFBF5EEFFFAF4EDFFFAF4EBFFF9F3EAFFF9F1
            E9FFCE986BFF0000000B06460E7E000000000000000000000000DAAB80FFFFFF
            FFFFDEB895FFDDB893FFDCB692FFDCB490FFDBB38EFFD9B28DFFD8B18CFFF9F3
            EAFFCF9A6DFF0000000900000000000000000000000000000000DBAC82FFFFFF
            FFFFFCF8F4FFFCF9F4FFFBF8F3FFFBF6F1FFFBF6F0FFFAF5EFFFFBF4EEFFFAF4
            ECFFD19D70FF0000000800000000000000000000000000000000DCAD84FFFFFF
            FFFFE0BA98FFDFB997FFDEB995FFDDB794FFDDB793FFDCB591FFDAB48FFFFAF5
            EEFFD29F73FF0000000600000000000000000000000000000000DDAF85FFFFFF
            FFFFFDFAF7FFF9F7F4FFEFEDEAFFEAE7E2FFE8E4DFFFE5E1DDFFE2DED9FFE0DA
            D6FFBA8E67FF0000001D00000007000000000000000000000000DEB087FFFFFF
            FFFFFFFFFFFFF8F8F8FF077CDDFF0679DCFF0576D9FF0572D7FF036FD5FF036C
            D3FF026AD1FF0167CFFF00000016000000000000000000000000A58365BDDEB1
            87FFDDAF86FFD9AC83FF077DDEFF89DBFFFF81D7FFFF78D4FFFF6ECFFFFF64CB
            FFFF5CC7FFFF0369CFFF00000015000000000000000000000000000000000000
            00000000000000000000077EDFFF067CDDFF0679DCFF0676D9FF0574D7FF0470
            D5FF036DD2FF036AD1FF0000000B000000000000000000000000}
          TabOrder = 1
          OnClick = btnTirarProdutoClick
        end
        object btnSugerirLocFisica: TBitBtnLocked
          AlignWithMargins = True
          Left = 354
          Top = 19
          Width = 165
          Height = 22
          Margins.Top = 10
          Caption = '[F10] - Sugerir loc. f'#237'sica'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000936E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6542B7000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000C19369ECD09D70FFCE9C6DFFCC996AFFCB9668FFB9875BEC000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000080000
            000F000000130000001600000017000000110000000400000000000000000000
            0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF0C498EBF1165
            C6FF0F63C5FF0E61C4FF0D60C3FF09448BC80000001100000000552D12810000
            00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D4ABD1268C8FFA3DA
            FFFF59BCFFFF56BBFFFF53BAFFFF0E60C3FF0000001700000000A95A25FF552D
            12810000000000000000000000000000000000000000000000001369C9FFB5E1
            FFFF5BBDFFFF59BBFFFF56BAFFFF0F61C3FFAD5E2AFFAC5D28FFAA5B27FFAA59
            24FF2C1709420000000000000000000000000000000000000000146ACAFFC6E8
            FFFFB7E2FFFFA7DCFFFF97D5FFFF0F63C5FF0000001200000000AC5D28FF542D
            137E0000000000000000000000000000000000000000000000000F5097BF136A
            CAFF1368C9FF1267C7FF1065C6FF0C4A93C60000000A00000000552F157E0000
            0000936E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6542B7000000010000
            0003000000050000000700000008000000070000000200000000000000000000
            0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D4ABD000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 2
          OnClick = btnSugerirLocFisicaClick
        end
        object btnReimprimirEtiqueta: TBitBtnLocked
          AlignWithMargins = True
          Left = 526
          Top = 19
          Width = 175
          Height = 22
          Margins.Top = 10
          Caption = '[F11] - Reimprimir etiqueta'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000766E66B7A498
            8EFFA2978CFFA1958BFF9F948AFF9E9288FF9D9187FF9C9086FF9A8F85FF998D
            84FF988D83FF978C82FF968A81FF958980FF948980FF69625AB7A69A90FFF6F3
            EFFFF6F2EFFFF5F1EDFFF0ECE8FFE4E1DDFFDEDCD7FFDCDAD4FFDBD7D2FFDAD6
            D1FFD8D4CFFFD6D3CDFFD5D1CBFFD9D4CFFFEAE5DFFF938980FFA89B90FFF7F3
            F0FFF6F3F0FFF5F2EEFFEAE6E3FFB19C8CFF92745EFF90735DFF8D715BFF8C70
            59FF886D56FF866B54FF866A54FFA49181FFDAD6D0FF958980FFA89D92FFF7F4
            F1FFF2EFEDFFE6E2E0FFD6D3D0FF947861FFFFFFFFFFE8E4E0FFE6E2DDFFE5DF
            DBFFE2DCD6FFE0DAD4FFD2C8C0FF856953FFD8D3CDFF958B81FFAA9E93FFF8F5
            F2FFE9E5E4FFD19B6CFFCB9668FF967862FFFFFFFFFFC18752FFAF5F18FFAD5D
            16FFAB5A13FFBA7E49FFD3CAC1FF856A54FFDBD7D1FF978B82FFAB9F94FFF8F5
            F3FFE8E4E3FFD29D6EFFF0E4D8FF967A63FFFFFFFFFFB2641CFFF2B17BFFF0AE
            7AFFE6A16DFFAA5A13FFD4CAC2FF876B55FFDDD9D3FF988D83FFACA095FFF9F6
            F4FFEAE7E5FFD39E6FFFF2E8DFFF997B64FFFFFFFFFFC58C5DFFC38B5BFFC38A
            5AFFC28858FFC18858FFFFFFFFFF896D57FFDFDAD6FF998E84FFADA196FFF9F7
            F5FFECE8E8FFD4A071FFF6ECE4FFB39D8DFF987A65FFC68D5DFFFAF1E9FFFAF0
            E7FFF9EDE3FFC28858FF8C7058FFA79281FFE4E1DCFF9A8F85FFAEA397FFFAF7
            F6FFEEEBEAFFD6A172FFF9F1EAFFF6EDE5FFEFE6DDFFC79060FFFBF3EDFFFBF2
            ECFFFAF1E9FFC38A5BFFDEDBD6FFE8E4E1FFF0EBE7FF9B9086FFAFA397FFFAF7
            F7FFF0EEEDFFD7A374FFFAF5EFFFDBB28FFFD9B08EFFC79161FFC79060FFC68F
            5FFFC48C5DFFC48B5CFFECE9E5FFF4F0EBFFF4EFEBFF9D9187FFB0A599FFFAF8
            F7FFF2F0EEFFD8A475FFFCF7F3FFFBF4F0FFF9F3ECFFF6EDE6FFF4E9E0FFF1E6
            DCFFCC9668FFDEDCD8FFF3F0EBFFF4F1EDFFF4F0ECFF9E9288FFB1A69AFFFBF8
            F8FFF4F2F1FFD8A576FFFCF9F7FFDBB28FFFDBB28FFFDBB28FFFDBB28FFFF7ED
            E4FFD29C6DFFE7E2E0FFF6F2EFFFF5F1EDFFF4F1ECFFA09489FFB2A69AFFFBF9
            F8FFF6F4F3FFD9A678FFFDFDFBFFFDFBF8FFFCF8F4FFFBF6F1FFFAF4EDFFF8F1
            E9FFD39E6FFFE8E5E2FFF6F3EFFFF6F2EFFFF5F2EEFFA1958BFFB3A69BFFFBF9
            F9FFF8F6F5FFDAA678FFD9A678FFD8A477FFD8A476FFD7A274FFD6A274FFD5A0
            72FFD49F71FFEDEAE7FFF7F3F0FFF6F3EFFFF6F2EEFFA2978CFFB3A79BFFFBFA
            F9FFFAF8F8FFF8F6F5FFF7F5F4FFF6F3F2FFF4F2F1FFF3F0EFFFF1EFEDFFEFED
            EBFFF1EDEBFFF5F3F0FFF7F4F1FFF7F3F0FFF6F3EFFFA4978EFF857D74BDB3A7
            9BFFB3A69BFFB2A69AFFB1A599FFB1A499FFB0A398FFAEA397FFADA196FFACA0
            95FFAB9F94FFAA9E92FFA89D92FFA89B91FFA69A8FFF7A716ABD}
          TabOrder = 3
          OnClick = btnReimprimirEtiquetaClick
        end
        object btnAtualizarEtiqueta: TBitBtnLocked
          AlignWithMargins = True
          Left = 1154
          Top = 10
          Width = 100
          Height = 31
          Margins.Top = 10
          Align = alRight
          Caption = '[F5] - Atualizar'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000001000000020000000400000007000000080000000A0000
            000B0000000B0000000A00000008000000060000000400000002000000000000
            000000000000000000010000000305100C331F5D43FF05100C390F2C20831847
            33CA1E5940F8184833C90F2C2082040C08290000000700000004000000000000
            000000000000000000020000000414392A9A4EA78CFF2A7055FF40977AFF53B7
            99FF60CEAFFF53B799FF41987BFF2C7157FF0817114300000005000000020000
            000400000005000000080000000B26694EFF80DBC0FF62C4A3FF76D7B9FF8CE0
            C9FF9DE8D6FF97E5D1FF83DDC3FF60B397FF34795FFF050D0A25000000060000
            000B0000000F00000012000000152B7055FFADE9D6FF9AE4CDFF99DCC7FF639F
            89FF35785EFF6BA18DFF9DD2C0FFA9E8D4FF6FAC96FF1536297E64483F9BA97A
            6AFFA97A6AFFA87A6AFFA77969FF358063FFD8F6EDFFD3F4EAFFD5F5EBFF98C6
            B5FF368064FF142F256474AC98FFD7F5ECFFB5DCCFFF29634DC7AA7B6BFFFEFD
            FCFFFBF6F4FFFBF6F4FFF9F4F2FF2F5E4CA43C8C6EFF3C8C6EFF3C8C6EFF2352
            41990B19133200000007235241993C8C6EFF2E6C55C816332860AB7D6DFFFBF6
            F4FFE4C191FFE4C191FFF5ECE7FF0605050B0000000700000009000000090000
            0008000000090000000A0000000B0000000B0000000900000006AC7E6FFFFBF6
            F4FFE4C191FFE3C090FFF4EBE6FF1D332973184733C81F5C42FF1236279B0000
            000D05100C391236279C1F5C42FF1F5C42FF1F5C42FF12362799AD8071FFFBF6
            F4FFE4C191FFE3C090FFF4EBE6FF31624CDE64C3ADFF63D2B3FF3C8C71FF0D25
            1B6A226348FF4FA88EFF5CCDABFF55C8A3FF64D3B5FF226247FFAF8273FFFBF6
            F4FFE4C191FFE4C191FFF5ECE7FF809D8DEF66A994FF90E2CCFF6BC2A6FF4693
            77FF2B7055FF469378FF73CFB3FF7BD9BDFF8ADFC8FF26694EFFB08475FFFBF6
            F4FFF7EEE9FFF7EEE9FFF6EDE8FFDADBD3FF428168FF94C4B3FFB7ECDBFFA6E7
            D3FFA0E6D0FFA6E7D3FFB5EBDAFFA8DBCAFFC3EFE1FF2B7055FFB28778FFFBF6
            F4FFE4C191FFE4C191FFF6EDE8FFF5ECE7FFC6D1C6FF4B8F75FF87B9A7FFB4DC
            CEFFD1F2E7FFB4DCCEFF87B9A7FF4B9075FF9AC7B7FF1F4B3A98B58B7DFFFBF6
            F4FFE4C191FFE4C191FFF7EEE9FFF6EDE8FFF6EDE8FFDDDFD7FF9BBDACFF65A1
            88FF418F72FF568B71FF1D4435800B1913303D8C6FFF0B19132FB88F81FFFEFD
            FCFFFBF6F4FFFBF6F4FFFBF6F4FFFBF6F4FFFBF6F4FFFAF5F3FFFAF5F3FFFAF5
            F3FFFCFBFAFFB78E80FF000000030000000100010002000000006E564E97BA92
            84FFBA9284FFBA9284FFBA9284FFBA9284FFBA9284FFBA9284FFBA9284FFBA92
            84FFBA9284FF6E564E9700000001000000000000000000000000}
          TabOrder = 4
          OnClick = btnAtualizarEtiquetaClick
        end
        object btnLimparLocFisica: TBitBtnLocked
          AlignWithMargins = True
          Left = 706
          Top = 19
          Width = 175
          Height = 22
          Margins.Top = 10
          Caption = '[Ctrl + DEL] - Limpar loc. f'#237'sica'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000030316271111
            7FE7020315270000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000040417271B1D91EA2939
            CAFF141689EA0303152700000000000000000000000000000000000000000000
            000000000000000000000000000000000000050519271B1C8EE71C1C99FF3750
            E2FF161690FF12127EE702031527000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000001E1E9DFF3E59
            E7FF191994FF0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000002221A0FF1E1E
            9CFF1C1C99FF0000000000000000000000000000000000000000000000040000
            000E000000130000001300000014000000140000001500000015000000160000
            00160000001700000017000000170000001800000013000000050000000D9070
            55BCD2A27BFFD1A079FFD09F76FFCE9C73FFCD9B71FF3938C3FF3636C1FF3334
            BFFF3131BDFF2F2FBCFFC79063FFC78F62FF876141C1000000120000000ED4A6
            80FFFFFFFFFFFFFFFFFFE1BFA2FFFFFFFFFFFFFFFFFF3C3CC5FF6564E6FF6161
            E4FF5E5EE2FF3332BEFFFFFFFFFFFFFFFFFFC68F62FF000000150000000DD5A8
            81FFFFFFFFFFFFFFFFFFE2C0A3FFFFFFFFFFFFFFFFFF403FC8FF6868E8FF6564
            E6FF6161E4FF3636C1FFFFFFFFFFFFFFFFFFC89063FF000000140000000BD7AA
            84FFFFFFFFFFFFFFFFFFE2C1A4FFFFFFFFFFFFFFFFFF4444CBFF6B6BEBFF6968
            E9FF6565E7FF3939C4FFFFFFFFFFFFFFFFFFC99165FF000000120000000AD7AB
            85FFFFFFFFFFFFFFFFFFE3C2A5FFFFFFFFFFFFFFFFFF4848CEFF6F6EEDFF6C6B
            EAFF6867E9FF3D3DC6FFFFFFFFFFFFFFFFFFC99367FF0000001000000009D7AC
            87FFFFFFFFFFFFFFFFFFE3C2A6FFFFFFFFFFFFFFFFFF4B4BD1FF7272EFFF6F6E
            EDFF6C6BEAFF4141CAFFFFFFFFFFFFFFFFFFCA9569FF0000000F00000008D9AE
            89FFFFFFFFFFFFFFFFFFE3C3A8FFFFFFFFFFFFFFFFFF4F50D4FF7474F0FF7271
            EFFF6F6FEEFF4546CCFFFFFFFFFFFFFFFFFFCB966BFF0000000D00000007D9AF
            8BFFFFFFFFFFFFFFFFFFE3C3A8FFFFFFFFFFFFFFFFFF5353D7FF7676F2FF7474
            F1FF7171EFFF4949D0FFFFFFFFFFFFFFFFFFCB986DFF0000000B00000006DAB0
            8CFFFFFFFFFFFFFFFFFFE4C4A9FFFFFFFFFFFFFFFFFF5656D9FF7979F3FF7676
            F2FF7474F0FF4C4DD2FFFFFFFFFFFFFFFFFFCD9A6FFF0000000A000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 5
          OnClick = btnLimparLocFisicaClick
        end
      end
      object pnlCtrlModCub: TPanel
        Left = 0
        Top = 87
        Width = 1263
        Height = 32
        Align = alBottom
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 2
        object btnCubAut: TBitBtnLocked
          AlignWithMargins = True
          Left = 174
          Top = 8
          Width = 165
          Height = 21
          Margins.Top = 8
          Align = alLeft
          Caption = '[F4] - Cubagem Autom'#225'tica'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00310000003400000036000000380000003B0000003D00000040000000430000
            0044000000470000004A0000004C000000500000005200000000000000000000
            001400000016000000190000001B0000001D0000001E00000021000000230000
            0026000000280000002A0000002D0000002F0000003200000000000000000000
            00030000000400000005000000060000000700000008000000090000000B0000
            000C0000000D0000000F00000011000000130000001500000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000683C0FDC774411FF5E350DCB0000000000000000000000002B18
            05605C330AD16F3D0BFF6E3C0AFF000000000000000000000000000000000000
            000000000000010100036D3F10E7120A03270000000000000000000000000302
            000666390CE7703E0CFF1D100342000000000000000000000000000000000000
            0000000000000000000041250A8744280A900000000000000000000000002817
            055773410EFF5F350BD500000000000000000000000000000000000000000000
            00000000000000000000100903217A4713FF794512FF784511FF774410FF7642
            10FF74410FFF311B066C00000000000000000000000000000000000000000000
            000000000000000000000000000058340EB72E1B076000000000150C032D7744
            11FF70400FF30704010F00000000000000000000000000000000000000000000
            000000000000000000000000000028170751603810C600000000492A0B997845
            12FF46280A960000000000000000000000000000000000000000000000000000
            000000000000000000000000000001010003714213E71C100439754412F37A46
            12FF150C032D0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000040250B815F3710C17C4814FF5E36
            0FC3000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000F09031E7D4916FC7E4915FF2B19
            0757000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000005A3510B4784615F00302
            0006000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 0
          OnClick = btnCubAutClick
        end
        object btnCubMan: TBitBtnLocked
          AlignWithMargins = True
          Left = 3
          Top = 8
          Width = 165
          Height = 21
          Margins.Top = 8
          Align = alLeft
          Caption = '[F3] - Cubagem Manual'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000080000
            000C0000000E0000000E0000000E0000000E0000000F0000000F0000000F0000
            001000000010000000100000001000000011000000100000000A7C5B53BFAD7F
            73FFAC7F73FFAC7F72FFAC7F72FFAC7F72FFAC7F72FFAC7E72FFAB7E71FFAB7E
            71FFAB7E71FFAB7E70FFAB7D70FFAA7D70FFAA7D70FF7A5A50C1AF8276FFF9F4
            F0FFF6EDE8FFF6EDE8FFF6EDE8FFCCAEA5FFF6EDE8FFF6EDE8FFF6EDE8FFF6ED
            E8FFCBABA1FFF6EDE8FFF6EDE8FFF6EDE8FFF6EDE8FFAD8174FFAF8377FFF9F4
            F0FFF9F4F0FFF9F4F0FFF9F4F0FFDFCBC4FFF9F4F0FFF9F4F0FFF9F4F0FFF9F4
            F0FFDEC9C2FFF9F4F0FFF9F4F0FFF9F4F0FFF9F4F0FFAF8176FF937A72C1C6A4
            9AFFC5A398FFC4A298FFC4A196FFC3A095FFC29F94FFC19E93FFC19C92FFC09B
            90FFBF9A8FFFBE998EFFBD978DFFBC968BFFBC958AFF8A6D65C3000000030000
            0005000000050000000500000006000000060000000600000006000000070000
            00090000000E000000120000001400000014000000130000000C000000000000
            0000000000003636363694949494949494949494949400000000000000000000
            00067B4D30BEAB6C43FFAB6C43FFAA6C43FFAA6B42FF7A4D30BE000000000000
            00006A6A6A6ABFBFBFBFA6968FD17A4D3DF1BFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFC1B77D55FFE9CDA0FFE5C192FFE4C091FFE3C090FFB77D55FF000000000000
            00006A6A6A6A907163E2682F1AFF672E19FF662D18FF662D18FF652C18FFBFBF
            BFC1BA825AFFEBD1A7FFE6C598FFE5C397FFE5C396FFBA835AFF000000000000
            00006A6A6A6ABFBFBFBFAC9E9ACD7F5343EFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFC1BD8960FFEDD7ADFFEDD5ACFFECD5ABFFECD4A9FFBD895FFF000000000000
            0000000000002B2B2B2B90909090909090909090909000000000000000000000
            00039C7B5AC1D2A679FFD2A679FFD2A679FFD2A679FF9C7B5AC1000000080000
            000C0000000E0000000E0000000E0000000E0000000F0000000F0000000F0000
            001100000013000000140000001500000016000000150000000D80625ABFB388
            7CFFB3887BFFB2877BFFB2877AFFB2867AFFB18679FFB18679FFB08578FFB185
            78FFB08577FFB08477FFAF8477FFAF8376FFAF8376FF7E5E55C1B78D81FFFDFA
            F9FFFBF8F5FFFBF7F5FFFBF7F5FFCCAEA5FFFBF7F5FFFBF6F4FFFBF7F3FFFAF6
            F4FFCBABA1FFFBF6F3FFFBF5F3FFFAF5F3FFFBF6F3FFB58C7FFFB78E82FFFDFB
            FAFFFDFBFAFFFDFBFAFFFDFAFAFFDFCBC4FFFDFAF9FFFDFAF9FFFDFAF9FFFDFA
            F9FFDEC9C2FFFCFAF9FFFCFAF9FFFDFAF9FFFCFAF9FFB78C81FF947B73C1C6A5
            9BFFC6A49AFFC6A399FFC5A398FFC5A297FFC4A197FFC4A096FFC3A095FFC29F
            94FFC29E93FFC29D92FFC19C91FFC09B90FFC09A90FF8D726AC3}
          TabOrder = 1
          OnClick = btnCubManClick
        end
        object chkRepModCubTodos: TCheckBox
          AlignWithMargins = True
          Left = 697
          Top = 10
          Width = 300
          Height = 19
          Margins.Top = 10
          Align = alLeft
          Caption = 'Replicar modo de cubagem para todos os itens?'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
        end
        object btnCubReset: TBitBtnLocked
          AlignWithMargins = True
          Left = 345
          Top = 8
          Width = 165
          Height = 21
          Margins.Top = 8
          Align = alLeft
          Caption = '[F6] - Resetar cubagem'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000B8824DFFAE7B
            49F1A17243DF805A35B149331E65060503090000000000000000000000000000
            0000000000000000000000000000000000000000000000000000B8824DFFB882
            4DFFB8824DFFB8824DFFB8824DFFA57445E42A1E123A00000000000000000000
            0000000000000000000000000000000000000000000000000000B8824DFFB882
            4DFFB8824DFFB8824DFFB8824DFFB8824DFFAF7C49F319110A22000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000E0A06132F2114418F653CC6B8824DFFB8824DFF704F2F9B000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000001A120B24B8824DFFB8824DFFA17243DF000000000000
            0000000000000A07040E8B623AC1B8824DFFB7814DFE4F38216D000000000000
            0000000000000000000000000000B8824DFFB8824DFFB07C4AF4000000000000
            00000D09051292673DCAB8824DFFB7814DFE4A351F6700000000000000000000
            0000000000000000000018110A21B8824DFFB8824DFFA27244E000000000110C
            0717986B3FD2B8824DFFB6804CFC45311D600000000000000000000000000000
            00000403020523190F318D633BC3B8824DFFB8824DFF71502F9D160F091E9C6E
            41D8B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
            4DFFB8824DFFB8824DFFB8824DFFB8824DFFB07C4AF41A120B24896139BEB882
            4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
            4DFFB8824DFFB8824DFFB8824DFFA77646E82C1F123D00000000120D0819996C
            40D4B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB07C
            4AF4A27344E1825C36B44C36206A0A07040E0000000000000000000000000D09
            051291663DC9B8824DFFB7814DFE49331E650000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000907040D886039BDB8824DFFB7814DFE4C36206A00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000060402087F5A35B0B8824DFFB7814DFE5039226F000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 3
          OnClick = btnCubResetClick
        end
        object btnProcCub: TBitBtnLocked
          AlignWithMargins = True
          Left = 516
          Top = 8
          Width = 175
          Height = 21
          Margins.Top = 8
          Align = alLeft
          Caption = '[F7] - Processar cubagem aut.'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            000000000002000000090000000E0000000F0000000F00000010000000100000
            0010000000100000000F0000000A000000020000000000000000000000000000
            0000000000081E5943C0287657FF277355FF267052FF256D50FF256C4EFF246A
            4BFF226749FF226547FF174733C10000000A0000000000000000000000000000
            000000000009389C79FF61E1BFFF47D3ADFF44D0A9FF42CEA5FF40CCA2FF3ECA
            9FFF3CC79CFF38C599FF267052FF0000000A0000000000000000000000000000
            00000000000430856AC140B28DFF3FAE8AFF3DAB87FF3CA884FF3BA581FF39A2
            7FFF389E7BFF369B79FF266D54C1000000040000000000000000000000000000
            000000000000000000010000000200000002000000030B20176D0A1B136F0000
            0004000000030000000200000002000000000000000000000000000000000000
            000000000000000000000000000000000003040C092E21664AF41C583FF6030A
            072F000000030000000000000000000000000000000000000000000000000000
            00000000000000000000000000010001010C1B4F39CA2FB084FF2CAB7EFF143F
            2BCD0001010D0000000100000000000000000000000000000000000000000000
            000000000000000000010000000512352788329C78FF35CA99FF35C999FF298E
            6AFF0E291D8B0000000600000001000000000000000000000000000000000000
            00000000000000000003091A1343328968FD42CEA2FF38CC9DFF37CB9CFF3CCB
            9DFF256F53FD07140E4700000003000000000000000000000000000000000000
            00000000000102060413297156E24FCCA5FF41D1A4FF3ECFA2FF3CCEA1FF3DCE
            A0FF3FC198FF1D553DE302050417000000010000000000000000000000000000
            0000000000031F5641AA65C4A7FF8BE9CFFF86E7CEFF74E4C5FF73E4C5FF66DF
            BDFF6CDFBEFF5DB69AFF153E2DAE000000040000000000000000000000000000
            0000000000033FA280FF3FA07FFF3E9F7FFFB8F5E6FF8CEDD6FF8CEDD5FF9BEF
            DBFF389071FF388F71FF378E6FFF000000040000000000000000000000000000
            000000000001000000030000000741A585FFC9F9EFFF9EF4E1FF9EF3E0FFADF5
            E6FF3B9878FF0000000900000004000000010000000000000000000000000000
            000000000000000000000000000344AC89FFDEFCF7FFDEFCF7FFDEFCF7FFDEFC
            F7FF3F9E7EFF0000000400000000000000000000000000000000000000000000
            0000000000000000000000000002308569BF41B48EFF41B48EFF41B48EFF41B4
            8EFF2E8166B90000000200000000000000000000000000000000000000000000
            0000000000000000000000000000000000010000000200000002000000020000
            0002000000020000000000000000000000000000000000000000}
          TabOrder = 4
          Visible = False
          OnClick = btnProcCubClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 232
  end
  object cdsLocSug: TUniClientDataSet
    PersistDataPacket.Data = {
      CB0100009619E0BD010000001800000013000000000003000000CB0105434841
      56450100490000000100055749445448020002001400064C4F43464953010049
      00000001000557494454480200020014000644544156414C0400060000000000
      0651544449544508000400000000000651544456454E08000400000000000645
      4E44455245010049000000010005574944544802000200010006415554494E43
      01004900000001000557494454480200020014000642554656454E0100490000
      0001000557494454480200020001000646495350494301004900000001000557
      494454480200020064000645584345535302000300000000000653454C454345
      02000300000000000641425049434B0100490000000100055749445448020002
      000100065049434B4E4701004900000001000557494454480200020001000643
      4F4449544501004900000001000557494454480200020007000A41494C5F494D
      5052455301004900000001000557494454480200020001000644455349544501
      00490000000100055749445448020002004600074C4F435449504F0100490000
      00010005574944544802000200320006454D4252454308000400000000000653
      455155454E04000100000000000000}
    Active = True
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'CHAVE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LOCFIS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DTAVAL'
        DataType = ftDate
      end
      item
        Name = 'QTDITE'
        DataType = ftFloat
      end
      item
        Name = 'QTDVEN'
        DataType = ftFloat
      end
      item
        Name = 'ENDERE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BUFVEN'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FISPIC'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EXCESS'
        DataType = ftBoolean
      end
      item
        Name = 'SELECE'
        DataType = ftBoolean
      end
      item
        Name = 'ABPICK'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PICKNG'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'AIL_IMPRES'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'LOCTIPO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EMBREC'
        DataType = ftFloat
      end
      item
        Name = 'SEQUEN'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = cdsLocSugBeforePost
    Left = 568
    Top = 168
    object cdsLocSugCHAVE: TStringField
      DisplayWidth = 18
      FieldName = 'CHAVE'
    end
    object cdsLocSugLOCFIS: TStringField
      DisplayWidth = 24
      FieldName = 'LOCFIS'
    end
    object cdsLocSugDTAVAL: TDateField
      DisplayWidth = 12
      FieldName = 'DTAVAL'
    end
    object cdsLocSugQTDITE: TFloatField
      DisplayWidth = 12
      FieldName = 'QTDITE'
    end
    object cdsLocSugQTDVEN: TFloatField
      FieldName = 'QTDVEN'
    end
    object cdsLocSugENDERE: TStringField
      FieldName = 'ENDERE'
      Size = 1
    end
    object cdsLocSugAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsLocSugBUFVEN: TStringField
      FieldName = 'BUFVEN'
      Size = 1
    end
    object cdsLocSugFISPIC: TStringField
      FieldName = 'FISPIC'
      Size = 100
    end
    object cdsLocSugEXCESS: TBooleanField
      FieldName = 'EXCESS'
    end
    object cdsLocSugSELECE: TBooleanField
      FieldName = 'SELECE'
    end
    object cdsLocSugABPICK: TStringField
      FieldName = 'ABPICK'
      Size = 1
    end
    object cdsLocSugPICKNG: TStringField
      FieldName = 'PICKNG'
      Size = 1
    end
    object cdsLocSugCODITE: TStringField
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsLocSugAIL_IMPRES: TStringField
      FieldName = 'AIL_IMPRES'
      Size = 1
    end
    object cdsLocSugQTDEMB: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QTDEMB'
      Calculated = True
    end
    object cdsLocSugDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsLocSugLOCTIPO: TStringField
      FieldName = 'LOCTIPO'
      Size = 50
    end
    object cdsLocSugEMBREC: TFloatField
      FieldName = 'EMBREC'
    end
    object cdsLocSugSEQUEN: TIntegerField
      FieldName = 'SEQUEN'
    end
    object cdsLocSugTOTSUG: TAggregateField
      FieldName = 'TOTSUG'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDVEN)'
    end
  end
  object dtsLocSug: TDataSource
    DataSet = cdsLocSug
    Left = 648
    Top = 160
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 13632012
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000001010306110B3F6F1F1473CB25188AF425188AF41F14
          73CB110B3F6F0101030600000000000000000000000000000000000000000000
          0000000000000503101B251B79CF2A28B0FF242FC0FF2535C8FF2435C8FF232F
          C1FF2A27B0FF261B7AD00503101B000000000000000000000000000000000000
          0000010104072B227FD03236BCFF263AC7FF2231C0FF2A3AC6FF2A3AC6FF202F
          C0FF263AC7FF3135BCFF2B2280D1010104070000000000000000000000000000
          00001A16466E3B3CBFFF283DC8FF646ECEFF9EA2DBFF3744C3FF3544C3FF9A9D
          D6FF6069CBFF283DC9FF393ABDFF1A16466E0000000000000000000000000000
          0000363085C73E4ED1FF1F33C4FF9B93C1FFFFFFECFFB3B1DBFFB2AFD8FFFFFF
          F4FF9A94C3FF1B2EC0FF3E4ED3FF363085C70000000000000000000000000000
          00004B46AEF94158DAFF364ED4FF3540B8FFAA9AB5FFFFFFF2FFFFFFF7FFB1A5
          C1FF343FB8FF374ED3FF4258DAFF4945AAF30000000000000000000000000000
          00005350B6F9435BDDFF576CDBFF4C5DD1FFACABD8FFFFFFF1FFFFFFF1FFA9A8
          D5FF4353CAFF5268DBFF455EDDFF5350B5F80000000000000000000000000000
          0000494897C7778AE6FF6579DBFF9E97C5FFFFFFF7FFAFA6C7FFA395B5FFFFFF
          F2FF9C97C7FF4D61D1FF6A7DE5FF494897C70000000000000000000000000000
          00002B2B556D8890E0FF859BECFF7D80C4FF8E81ADFF636ECBFF5D67C4FF8C7E
          A9FF767AC5FF6B83E4FF7B84E0FF2B2B556D0000000000000000000000000000
          0000030305065859A8CF95A1E8FF8CA1EBFF6C7DD8FF97ACF1FF95ABF2FF6273
          D5FF778EE5FF8A97E8FF585AA9D0030306070000000000000000000000000000
          0000000000000C0C161B5D60ACCF9CA5E7FFAEBFF5FFA6BBF3FFA4B7F2FFA4B8
          F4FF959FE7FF5D60ACCF0C0C161B000000000000000000000000000000000000
          000000000000000000000303050634355E6E5E61A9C77276CFF37276CFF35E61
          A9C734355E6E0303050600000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000000F00000010000000100000
          00100000001100000011000000100000000B0000000300000000000000000000
          0008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266E
          BDFF256DBCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000
          000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AF
          E7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000
          000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307F
          C4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000
          000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4
          E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000
          000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF6688
          77FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000
          000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF1574
          4FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D00000000000000000000
          00094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD1
          9CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D00000000000000000000
          00094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EB
          B9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C00000000000000000000
          00085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADF
          C1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D00000000000000000000
          0007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D
          6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF0000001500000001000000000000
          0007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9
          D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B00000002000000000000
          00065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8
          A8FFB2B7B3FF3B826DFF359170FF6D95A5FF0000001300000000000000000000
          00055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AF
          AAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A00000000000000000000
          00034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C66
          64FF76726FFF837F7DFF5C95CBFF4E7BA6CA0000000500000000000000000000
          00010000000300000004000000050000000525232243716C6ACA605B59CA1D1B
          1B44000000060000000600000006000000040000000100000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000070000
          0010000000130000001400000014000000150000001500000015000000150000
          0016000000160000001600000015000000120000000800000002100B0A5E2B1E
          18EC2F211AFF2F201BFF2F211AFF2F201AFF2F201AFF2F2019FF2F201AFF2F20
          1AFF2F201AFF2F2019FF2F201AFF2A1D17ED0E0A086200000008342720EA5442
          3AFF513F35FF513E36FF503E35FF503E35FF503E35FF503E34FF4F3E34FF4F3E
          34FF4F3D34FF4F3D34FF4F3D34FF46352DFF2F201BEB000000103E2D26FF6452
          49FF4C3830FF4C3830FF4F4A3FFF598A75FF60B498FF62C1A3FF60B498FF588A
          75FF4D493EFF4A372FFF49362EFF4F3D34FF372721FF00000013412F28FF6753
          4BFF4E3A32FF515E4FFF4BAE8CFF40AD88FF3CAB85FF40AD88FF4BB491FF5DBF
          9FFF61BB9EFF515C4FFF4A372FFF503E35FF3A2923FF0000001344322BFF6956
          4EFF504B40FF41AB86FF3EB089FF3EAF89FF3EAF88FF3DAC86FF3CAB85FF3EAC
          86FF57BB9BFF61BB9EFF4F4A3EFF513E35FF3C2C25FF0000001246342DFF6C58
          50FF488369FF42B58FFF43B790FF43B690FF41B48EFF3FB18AFF3DAE88FF3CAB
          85FF3EAC86FF5DBF9FFF598974FF523F36FF3F2E27FF0000001148362FFF6E5B
          53FF45AC8AFF4EC19DFF67D5B7FF70DCC1FF65D3B5FF4BBD9AFF40B28CFF3DAE
          88FF3CAB85FF4CB491FF60B397FF534138FF43302AFF000000104B3831FF725F
          57FF4BBE9AFF6CDABEFF79E2CAFF7BE2CAFF77E0C8FF70DBC1FF4CBE9AFF3FB1
          8BFF3DAC86FF40AD88FF62BEA0FF544139FF45332CFF0000000F4D3A32FF7461
          59FF50B998FF7BE4CBFF82E7D1FF84E7D2FF7FE4CDFF77E0C8FF65D3B5FF41B4
          8EFF3EAE88FF3DAC86FF60B397FF554239FF48352EFF0000000E4F3B34FF7663
          5CFF559078FF78E2C8FF87EAD6FF8AEAD7FF83E7D2FF7BE2CAFF6FDBC0FF44B6
          90FF3EAF89FF40AD88FF5B8974FF57433AFF4A372FFF0000000D503C35FF7966
          5DFF555146FF64CEB1FF86EBD6FF87EAD6FF82E7D1FF7AE2CAFF67D5B7FF42B7
          90FF3EB089FF4CAE8DFF544D43FF58443BFF4C3931FF0000000C513E36FF7B68
          61FF56413AFF576758FF64D0B2FF78E2C9FF7BE4CBFF6CD9BEFF4DC19EFF42B6
          8FFF41AB87FF566253FF533E36FF58453EFF4E3A33FF0000000C533E37FF7E6B
          63FF5F4A42FF57423AFF575247FF55937BFF52B798FF4BC19CFF47AB89FF4A87
          6CFF554F44FF554038FF544038FF5A463EFF503C34FF0000000A4B3A33E9725F
          57FF806D64FF7E6B64FF7E6B64FF7E6A63FF7D6962FF7C6962FF7C6961FF7B67
          60FF7A6761FF7A675FFF79675EFF6C5A52FF493730EA0000000815100E464232
          2CCC543F38FF543F38FF543F38FF543F38FF533F37FF533F37FF533F37FF533F
          37FF533E37FF523E37FF523E36FF41312BCE140F0D4900000003}
      end>
  end
  object popReimpressao: TPopupMenu
    Left = 360
    Top = 184
    object ReimprimirEtiqueta1: TMenuItem
      Caption = 'Reimprimir Etiqueta'
      OnClick = ReimprimirEtiqueta1Click
    end
  end
  object cxImageList2: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 13894096
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000001B318FF01B318FF01B318FF01B3
          18FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000001B318FF00D21EFF00D21EFF01B3
          18FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000001B318FF00D93BFF00D93BFF01B3
          18FF000000000000000000000000000000000000000000000000000000000000
          00000000000001B318FF01B318FF01B318FF01B318FF00DF59FF00DF59FF01B3
          18FF01B318FF01B318FF01B318FF000000000000000000000000000000000000
          00000000000001B318FF00E676FF00E676FF00E676FF00E676FF00E676FF00E6
          76FF00E676FF00E676FF01B318FF000000000000000000000000000000000000
          00000000000001B318FF00EC94FF00EC94FF00EC94FF00EC94FF00EC94FF00EC
          94FF00EC94FF00EC94FF01B318FF000000000000000000000000000000000000
          00000000000001B318FF01B318FF01B318FF01B318FF00F2B2FF00F2B2FF01B3
          18FF01B318FF01B318FF01B318FF000000000000000000000000000000000000
          00000000000000000000000000000000000001B318FF00F9CFFF00F9CFFF01B3
          18FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000001B318FF00FFECFF00FFECFF01B3
          18FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000001B318FF01B318FF01B318FF01B3
          18FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          1E2F0000A1FF0000A1FF0000A1FF0000A1FF0000A1FF0000A1FF0000A1FF0000
          A1FF0000A1FF0000A1FF0000A1FF0000A1FF00001E2F00000000000000000000
          A8FF0000A8FF0000A8FF0000A8FF0000A8FF0000A8FF000099FF000099FF0000
          A8FF0000A8FF0000A8FF0000A8FF0000A8FF0000A8FF00000000000000000000
          AFFF0000AFFF0000AFFF0000AFFF0000AFFF0000AFFF0000A3FF0000A3FF0000
          AFFF0000AFFF0000AFFF0000AFFF0000AFFF0000AFFF00000000000000000000
          B6FF0000B6FF0000B6FF0000B6FF0000B6FF0000B6FF0000ACFF0000ACFF0000
          B6FF0000B6FF0000B6FF0000B6FF0000B6FF0000B6FF00000000000000000000
          BEFF0000BEFF0000BEFF0000BEFF0000BEFF0000BEFF0000B7FF0000B7FF0000
          BEFF0000BEFF0000BEFF0000BEFF0000BEFF0000BEFF00000000000000000000
          C5FF0000C5FF0000C5FF0000C5FF0000C5FF0000C5FF0000BFFF0000BFFF0000
          C5FF0000C5FF0000C5FF0000C5FF0000C5FF0000C5FF00000000000000000000
          CCFF0000CCFF0000CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF0000CCFF0000CCFF0000CCFF00000000000000000000
          D3FF0000D3FF0000D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF0000D3FF0000D3FF0000D3FF00000000000000000000
          DBFF0000DBFF0000DBFF0000DBFF0000DBFF0000DBFF0000DAFF0000DAFF0000
          DBFF0000DBFF0000DBFF0000DBFF0000DBFF0000DBFF00000000000000000000
          E2FF0000E2FF0000E2FF0000E2FF0000E2FF0000E2FF0000E2FF0000E2FF0000
          E2FF0000E2FF0000E2FF0000E2FF0000E2FF0000E2FF00000000000000000000
          E9FF0000E9FF0000E9FF0000E9FF0000E9FF0000E9FF0000E9FF0000E9FF0000
          E9FF0000E9FF0000E9FF0000E9FF0000E9FF0000E9FF00000000000000000000
          F1FF0000F1FF0000F1FF0000F1FF0000F1FF0000F1FF0000F1FF0000F1FF0000
          F1FF0000F1FF0000F1FF0000F1FF0000F1FF0000F1FF00000000000000000000
          F8FF0000F8FF0000F8FF0000F8FF0000F8FF0000F8FF0000F8FF0000F8FF0000
          F8FF0000F8FF0000F8FF0000F8FF0000F8FF0000F8FF00000000000000000000
          30300000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000303000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
      end>
  end
  object dtsEtiquetas: TDataSource
    Left = 360
    Top = 245
  end
end
