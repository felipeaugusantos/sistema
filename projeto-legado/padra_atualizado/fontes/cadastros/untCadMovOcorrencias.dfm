inherited frmCadMovOcorrencias: TfrmCadMovOcorrencias
  Width = 790
  Height = 724
  Caption = 'Ocorr'#234'ncias'
  PrintScale = poPrintToFit
  OnDestroy = FormDestroy
  ExplicitWidth = 790
  ExplicitHeight = 724
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 631
    Width = 784
    Height = 24
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 631
    ExplicitWidth = 784
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 0
      Top = 0
      Width = 265
      Align = alLeft
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 265
      inherited btnIncluir: TBitBtnLocked
        Width = 88
        Height = 24
        Enabled = False
        Visible = False
        ExplicitWidth = 88
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Left = 88
        Width = 88
        Height = 24
        Align = alLeft
        ExplicitLeft = 88
        ExplicitWidth = 88
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 176
        Width = 88
        Height = 24
        Enabled = False
        Visible = False
        ExplicitLeft = 176
        ExplicitWidth = 88
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 0
        Top = 24
        Width = 88
        Height = 24
        Align = alLeft
        ExplicitLeft = 0
        ExplicitTop = 24
        ExplicitWidth = 88
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Left = 88
        Top = 24
        Width = 88
        Height = 24
        Align = alLeft
        ExplicitLeft = 88
        ExplicitTop = 24
        ExplicitWidth = 88
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 176
        Top = 24
        Enabled = False
        Visible = False
        ExplicitLeft = 176
        ExplicitTop = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 703
      Top = 0
      Width = 81
      Height = 24
      Align = alRight
      TabOrder = 3
      ExplicitLeft = 703
      ExplicitTop = 0
      ExplicitWidth = 81
      ExplicitHeight = 24
    end
    object btnArquivos: TBitBtnLocked
      Left = 353
      Top = 0
      Width = 88
      Height = 24
      Hint = 'Anexar arquivos a essa ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Anexos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6
        A4C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFE
        FCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBC2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFC
        FBC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFAF5FEFCFBFEFAF5FEFAF5FE
        FCFBFEFAF5FEFAF5FEFCFBFEFAF5FEFAF5C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFA
        F5C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FE
        F7F0FEF7F0FEF7F0FEF7F0FEF7F0FEF7F0C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FEF3E9FEF7F0FEF7F0FEF3E9FEF7F0FEF7
        F0C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FEF3E9FEF3E9FEF3E9FE
        F3E9FEF3E9FEF3E9FEF3E9FEF3E9FEF3E9C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFF0E2FFF0E2FEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEE
        DEC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FFEEDEFFF0E2FEF3E9FF
        EEDEFFF0E2DDCFC2DDCFC2DDCFC2DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEEDEFFEEDEFFEEDEFFEEDEFFEEDEFFEEDEC3B4A8C3B4A8C3B4A8C3B4
        A8C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FFEEDEFFEAD7FFEEDEFFEAD7FF
        EAD7FFEEDEB0A296B0A296B0A296B0A296C2A6A4FF00FFFF00FFFF00FFFF00FF
        C2A6A4FFEAD7FFEAD7FFEAD7FFEAD7FFEAD7C9B9ACFEFAF5FEF7F0E6DAD9C2A6
        A4FF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4FFEAD7FFE6D0FFEAD7FFE6D0FF
        EAD7C5B5A9FEFAF5DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C2A6A4FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0C9B9ACDDCFC2C2A6A4FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2
        A6A4C2A6A4C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnArquivosClick
    end
    object btnConsultaAD: TBitBtnLocked
      Left = 265
      Top = 0
      Width = 88
      Height = 24
      Hint = 'Consulta autoriza'#231#227'o de devolu'#231#227'o(AD)'
      Align = alLeft
      Caption = 'Consultar AD'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnConsultaADClick
    end
    object btnEnviarEmail: TBitBtnLocked
      Left = 577
      Top = 0
      Width = 98
      Height = 24
      Align = alLeft
      Caption = 'Enviar E-mail'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000020000
        00070000000B0000000C0000000D0000000D0000000E0000000E0000000E0000
        000F0000000F0000000E0000000A000000020000000000000000000000067F54
        46BEB07561FFB07460FFB07360FFAF745FFFAE7460FFAE735FFFAF725FFFAE72
        5EFFAE725EFFAE725EFF7C5143C100000009000000000000000000000008B379
        66FFFCFAF9FFFCF7F5FFFBF7F4FFFCF7F4FFFCF7F4FFFCF7F4FFFBF5F4FFFBF5
        F4FFFCF6F3FFFCF9F8FFB17562FF0000000D000000000000000000000008B77F
        6BFFFCF9F8FFFAF5F1FFFAF4F2FFFAF4F1FFFAF4F1FFFAF4F1FFFAF4F0FFFAF4
        F0FFFAF3F0FFFCF9F7FFB37A67FF0000000D000000000000000000000007BA84
        72FFE1C8BDFFF9F3F0FFFAF4F0FFEFE3DEFFDDC7BFFFDDC7BFFFEFE1DCFFFAF2
        EFFFF9F2EEFFE1C8BCFFB77F6DFF0000000C000000000000000000000006BE8A
        79FFE5D2C4FFD8B8AAFFE8D7D0FFD1B5ABFFAC7D6DFF966254FFC9AA9FFFE6D4
        CDFFE2CAC0FFECDDD3FFCDA698FF0000000B000000000000000000000005C290
        80FFEBDDD3FFE3D2C8FFBD9384FFCCAEA5FFFCFAF9FFFCF9F9FFC1A49BFFAF83
        73FFF0E6E0FF82A5CEFFDFC5BCFF082E5B86000000000000000000000004C697
        85FFE4D3C9FFBC9385FFE5D6D0FFFDFBFAFFFBF7F4FFFBF7F4FFFDFCFAFFEFE7
        E4FFD6C0B8FF1664B9FF467BBAFF1462B7FF000000000000000000000003CB9C
        8CFFD5BAAFFFF3EBE8FFFDF9F7FFFBF7F5FFFCF7F5FFFCF7F5FFFDF8F7FF8AB1
        DCFF1C6ABEFF80D2F8FF4EAEE9FF5CC0F8FF1967BCFF0C335C7E00000002CFA2
        92FFFCFAF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF5995D3FF6DBDEDFF6ECBF8FF58B1EAFF185290BD00000000000000019C7C
        71BED2A797FFD1A697FFD1A796FFD1A696FFD1A596FFD0A595FFDCBCB0FF85A4
        CAFF2879CAFFABE4FCFF89C9EFFFA7E2FBFF2576C7FF133B6481000000000000
        0001000000020000000200000002000000020000000300000003000000030000
        0004000000042C7FCEFF215F9AC12B7ECDFF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000001842687E000000001841687E0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 4
      OnClick = btnEnviarEmailClick
      ExplicitLeft = 441
    end
    object btnAlterarCli: TBitBtnLocked
      Left = 441
      Top = 0
      Width = 136
      Height = 24
      Align = alLeft
      Caption = '&Alterar Cliente '
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
      TabOrder = 5
      Visible = False
      OnClick = btnAlterarCliClick
      ExplicitLeft = 545
      ExplicitTop = -18
    end
  end
  inherited pnlStatus: TPanel
    Top = 679
    Width = 784
    TabOrder = 0
    ExplicitTop = 679
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 582
      Width = 202
      ExplicitLeft = 582
      ExplicitWidth = 202
    end
    inherited pnlInfo: TPanel
      Width = 582
      ExplicitWidth = 582
    end
  end
  inherited pgcDados: TPageControl
    Width = 784
    Height = 631
    TabOrder = 1
    ExplicitWidth = 784
    ExplicitHeight = 631
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 776
      ExplicitHeight = 599
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 784
    Height = 631
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlCliente: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 43
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object grbCliente: TGroupBox
        Left = 1
        Top = 1
        Width = 780
        Height = 41
        Align = alClient
        Caption = 'Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object dbeCodCli: TDBEditFocus
          Tag = 99
          Left = 27
          Top = 14
          Width = 69
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OCO_CODCLI'
          DataSource = dtsMovOco
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtDesCodCli: TEditFocus
          Left = 97
          Top = 14
          Width = 393
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 25
          Top = 14
          Width = 4
          Height = 22
          CharCase = ecUpperCase
          DataField = 'OCO_CODOCO'
          DataSource = dtsMovOco
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
      end
    end
    object pnlGrupoOcorr: TPanel
      Left = 1
      Top = 44
      Width = 782
      Height = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object grbOcorrencias: TGroupBox
        Left = 1
        Top = 1
        Width = 780
        Height = 43
        Align = alClient
        Caption = 'Grupo Ocorr'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object edtDesCodGoc: TEditFocus
          Left = 97
          Top = 16
          Width = 393
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbeCodGoc: TEditFocus
          Tag = 99
          Left = 27
          Top = 16
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodGocKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
    end
    object pgcGeral: TPageControl
      Left = 1
      Top = 255
      Width = 782
      Height = 375
      ActivePage = tbsInfGerais
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      TabStop = False
      object tbsInfGerais: TTabSheet
        Caption = 'Informa'#231#245'es Gerais'
        object pnlInfGerais: TPanel
          Left = 0
          Top = 0
          Width = 774
          Height = 346
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object pnlCabInf: TPanel
            Left = 1
            Top = 1
            Width = 772
            Height = 268
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object Label5: TLabel
              Left = 103
              Top = 11
              Width = 23
              Height = 14
              Alignment = taRightJustify
              Caption = 'Tipo:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label6: TLabel
              Left = 47
              Top = 77
              Width = 79
              Height = 14
              Alignment = taRightJustify
              Caption = 'Usu'#225'rio Destino:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblProtocolo: TLabel
              Left = 78
              Top = 222
              Width = 48
              Height = 14
              Alignment = taRightJustify
              Caption = 'Protocolo:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label10: TLabel
              Left = 59
              Top = 31
              Width = 67
              Height = 14
              Alignment = taRightJustify
              Caption = 'Complemento:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label9: TLabel
              Left = 81
              Top = 54
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Situa'#231#227'o:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblEmail: TLabel
              Left = 60
              Top = 179
              Width = 66
              Height = 14
              Alignment = taRightJustify
              Caption = 'E-mail Cliente:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblEmailDestino: TLabel
              Left = 16
              Top = 199
              Width = 110
              Height = 14
              Alignment = taRightJustify
              Caption = 'E-mail Usu'#225'rio Destino:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeTipOco: TDBEditFocus
              Tag = 99
              Left = 128
              Top = 5
              Width = 55
              Height = 22
              CharCase = ecUpperCase
              DataField = 'OCO_CODTOC'
              DataSource = dtsMovOco
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              OnKeyPress = dbeTipOcoKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttAlfanumerico
            end
            object edtDesTipOco: TEditFocus
              Left = 184
              Top = 5
              Width = 540
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 11
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDesOpeOco: TEditFocus
              Left = 184
              Top = 74
              Width = 540
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
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
            object dbeOpeOco: TDBEditFocus
              Tag = 99
              Left = 128
              Top = 74
              Width = 55
              Height = 22
              CharCase = ecUpperCase
              DataField = 'OCO_CODOPE'
              DataSource = dtsMovOco
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 3
              OnKeyPress = dbeOpeOcoKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttAlfanumerico
            end
            object dblProtocolo: TcxDBLabel
              Left = 128
              Top = 221
              DataBinding.DataField = 'OCO_PROTOC'
              DataBinding.DataSource = dtsMovOco
              Properties.LabelStyle = cxlsRaised
              Properties.ShadowedColor = clGray
              Style.BorderStyle = ebsOffice11
              Height = 22
              Width = 556
            end
            object dbeComple: TDBEditFocus
              Tag = 99
              Left = 128
              Top = 28
              Width = 55
              Height = 22
              CharCase = ecUpperCase
              DataField = 'OCO_CODCOC'
              DataSource = dtsMovOco
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 1
              OnExit = dbeCompleExit
              OnKeyPress = dbeCompleKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttAlfanumerico
            end
            object dbeDesComple: TEditFocus
              Left = 184
              Top = 28
              Width = 540
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
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
            object ChkEmerge: TDBCheckBox
              Left = 128
              Top = 98
              Width = 212
              Height = 17
              Caption = 'Gerar Ocorr'#234'ncia Emergencial'
              DataField = 'OCO_EMERGE'
              DataSource = dtsMovOco
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkEnvEmail: TCheckBox
              Tag = 50
              Left = 128
              Top = 115
              Width = 335
              Height = 17
              Caption = 'Enviar ocorr'#234'ncia por e-mail - Cliente'
              Checked = True
              DoubleBuffered = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentDoubleBuffered = False
              ParentFont = False
              State = cbChecked
              TabOrder = 5
              OnClick = chkEnvEmailClick
            end
            object dbeCodSit: TDBEditFocus
              Tag = 99
              Left = 128
              Top = 51
              Width = 55
              Height = 22
              CharCase = ecUpperCase
              DataField = 'OCO_CODSIT'
              DataSource = dtsMovOco
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              ParentFont = False
              TabOrder = 2
              OnKeyPress = dbeCodSitKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttAlfanumerico
            end
            object edtDesSit: TEditFocus
              Left = 184
              Top = 51
              Width = 540
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 15
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmail: TEditFocus
              Tag = 99
              Left = 128
              Top = 174
              Width = 596
              Height = 22
              Alignment = taLeftJustify
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object btnCopiarProtocolo: TcxButton
              Left = 690
              Top = 195
              Width = 34
              Height = 22
              Hint = 'Copiar n'#186' protocolo'
              OptionsImage.Glyph.SourceDPI = 96
              OptionsImage.Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                6100000025744558745469746C6500436F70793B426172733B526962626F6E3B
                5374616E646172643B436C6F6E656D0EDF5B000001B649444154785E7D90318B
                53411446CF7DD94D229AC24A2BC1CADE56248D8A76D65A2B6C6721DA0A82D66A
                A1A58DFD7656168B0B36D6AB85827F40566159F3E6CDBD9F929921210B4E3317
                1EE7BC33D724B17E66B3D9E8F9EBBD0F9DD95C18104842180290109053FAF8E4
                C18D6B5B9C3C9DD07CE7CE65A0C9A9F06A7EF1F6F35560B4149899011D6093C9
                647CE1FC1952EAF9B37000A28266DD3F62C47432C2B303582BE89EBDF954B265
                7CF97EC8C1B79F88AE660702CE9D9D72FBE62526E35364DF10483E7F74FFCA7F
                B39FBEDA27E78C24D210EB02CC73418E6BB6B07207C8C474DC2DB3DD45881305
                960747802464566E00A3CC1572050A11454013903C00080C095001010221897E
                88B5026D3E21832042C8A83308812850CE840721E1B1B18361080484B4064351
                14B1BB2384043E6C1464CFE54314A87A304140CB66BADD11802B00B47AC29254
                2D68FF368450D4820876DF1FF0F5C711B93FDA07721330785058519750E02613
                780A1EEE5CBF381E8F7F0103B06802A2EEE0F4740B54F090210588964D4AE9B0
                EFFBDF8D6B02EFD3F1DEBDC7BB73B15AA299AABD088645C906D814A4772FEFDE
                02B601033879A396BD2EF80B61825062DDA3F2C70000000049454E44AE426082}
              ParentShowHint = False
              ShowHint = True
              SpeedButtonOptions.CanBeFocused = False
              SpeedButtonOptions.Flat = True
              TabOrder = 16
              OnClick = btnCopiarProtocoloClick
            end
            object pnlProtocoloCancelamento: TPanel
              Left = 0
              Top = 245
              Width = 772
              Height = 23
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 17
              object Label12: TLabel
                Left = 56
                Top = -3
                Width = 70
                Height = 28
                Caption = 'Protocolo de cancelamento:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                WordWrap = True
              end
              object btnCopiarProtocoloCancelamento: TcxButton
                Left = 690
                Top = -1
                Width = 34
                Height = 22
                Hint = 'Copiar n'#186' protocolo'
                OptionsImage.Glyph.SourceDPI = 96
                OptionsImage.Glyph.Data = {
                  89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                  6100000025744558745469746C6500436F70793B426172733B526962626F6E3B
                  5374616E646172643B436C6F6E656D0EDF5B000001B649444154785E7D90318B
                  53411446CF7DD94D229AC24A2BC1CADE56248D8A76D65A2B6C6721DA0A82D66A
                  A1A58DFD7656168B0B36D6AB85827F40566159F3E6CDBD9F929921210B4E3317
                  1EE7BC33D724B17E66B3D9E8F9EBBD0F9DD95C18104842180290109053FAF8E4
                  C18D6B5B9C3C9DD07CE7CE65A0C9A9F06A7EF1F6F35560B4149899011D6093C9
                  647CE1FC1952EAF9B37000A28266DD3F62C47432C2B303582BE89EBDF954B265
                  7CF97EC8C1B79F88AE660702CE9D9D72FBE62526E35364DF10483E7F74FFCA7F
                  B39FBEDA27E78C24D210EB02CC73418E6BB6B07207C8C474DC2DB3DD45881305
                  960747802464566E00A3CC1572050A11454013903C00080C095001010221897E
                  88B5026D3E21832042C8A83308812850CE840721E1B1B18361080484B4064351
                  14B1BB2384043E6C1464CFE54314A87A304140CB66BADD11802B00B47AC29254
                  2D68FF368450D4820876DF1FF0F5C711B93FDA07721330785058519750E02613
                  780A1EEE5CBF381E8F7F0103B06802A2EEE0F4740B54F090210588964D4AE9B0
                  EFFBDF8D6B02EFD3F1DEBDC7BB73B15AA299AABD088645C906D814A4772FEFDE
                  02B601033879A396BD2EF80B61825062DDA3F2C70000000049454E44AE426082}
                ParentShowHint = False
                ShowHint = True
                SpeedButtonOptions.CanBeFocused = False
                SpeedButtonOptions.Flat = True
                TabOrder = 0
                OnClick = btnCopiarProtocoloCancelamentoClick
              end
              object lblProtocoloCancelamento: TcxLabel
                Left = 128
                Top = 0
                AutoSize = False
                ParentColor = False
                Style.BorderStyle = ebsOffice11
                Style.Color = 16770261
                Properties.LabelStyle = cxlsRaised
                Properties.ShadowedColor = clGray
                Height = 22
                Width = 556
              end
            end
            object chkEnvEmailDestino: TCheckBox
              Tag = 50
              Left = 128
              Top = 131
              Width = 335
              Height = 17
              Caption = 'Enviar ocorr'#234'ncia por e-mail - Usu'#225'rio Destino'
              Checked = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              State = cbChecked
              TabOrder = 6
              OnClick = chkEnvEmailDestinoClick
            end
            object edtEmailDestino: TEditFocus
              Tag = 99
              Left = 128
              Top = 197
              Width = 596
              Height = 22
              Alignment = taLeftJustify
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object chkEmailEnvio: TcxCheckComboBox
              Left = 128
              Top = 151
              Properties.EmptySelectionText = 'Selecionar e-mail contato'
              Properties.EditValueFormat = cvfIndices
              Properties.Items = <>
              Properties.OnChange = chkEmailEnvioPropertiesChange
              TabOrder = 7
              Width = 596
            end
            object chkTornarRecorrente: TCheckBox
              Tag = 50
              Left = 607
              Top = 128
              Width = 109
              Height = 17
              Caption = 'Tornar Recorrente'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 18
              OnClick = chkTornarRecorrenteClick
            end
            object chkGerCom: TCheckBox
              Tag = 50
              Left = 607
              Top = 98
              Width = 117
              Height = 17
              Caption = 'Gerar Compromisso'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              OnClick = chkTornarRecorrenteClick
            end
          end
          object dbmDescri: TDBMemoFocus
            Left = 1
            Top = 269
            Width = 772
            Height = 76
            Align = alClient
            DataField = 'OCO_DESCRI'
            DataSource = dtsMovOco
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
      end
      object tbsHistorico: TTabSheet
        Caption = 'Hist'#243'rico de ocorr'#234'ncias'
        ImageIndex = 2
        object Label8: TLabel
          Left = 0
          Top = 326
          Width = 774
          Height = 20
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'Passe o mouse sobre a coluna ou pressione enter para ver o hist'#243 +
            'rico completo'
          Layout = tlCenter
          ExplicitTop = 300
          ExplicitWidth = 512
        end
        object cxGridCitel: TcxGridCitel
          Left = 0
          Top = 0
          Width = 774
          Height = 326
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxTableViewHisOco: TcxGridDBTableViewCitel
            OnKeyPress = cxTableViewHisOcoKeyPress
            OnMouseDown = cxTableViewHisOcoMouseDown
            OnMouseMove = cxTableViewHisOcoMouseMove
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxTableViewHisOcoCustomDrawCell
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = False
            CorZebra = clMoneyGreen
            object HisOcoColumnDESCRI: TcxGridDBColumn
              Caption = 'Hist.'
              DataBinding.FieldName = 'DESCRI'
              Options.FilteringFilteredItemsList = False
              Options.AutoWidthSizable = False
              Width = 32
            end
            object HisOcoColumnDTAINC: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DTAINC'
              Width = 61
            end
            object HisOcoColumnHORINC: TcxGridDBColumn
              Caption = 'Hora'
              DataBinding.FieldName = 'HORINC'
              Width = 57
            end
            object HisOcoColumnOPEORI: TcxGridDBColumn
              Caption = 'Operador origem'
              DataBinding.FieldName = 'OPEORI'
              Width = 113
            end
            object HisOcoColumnOPEDES: TcxGridDBColumn
              Caption = 'Operador destino'
              DataBinding.FieldName = 'OPEDES'
              Width = 121
            end
            object HisOcoColumnNUMDOC: TcxGridDBColumn
              Caption = 'Documento'
              DataBinding.FieldName = 'NUMDOC'
              Width = 130
            end
            object HisOcoColumnTIPOCO: TcxGridDBColumn
              Caption = 'Tipo ocorr'#234'ncia'
              DataBinding.FieldName = 'TIPOCO'
              Width = 234
            end
            object HisOcoColumnCODCOC: TcxGridDBColumn
              Caption = 'Complemento'
              DataBinding.FieldName = 'CODCOC'
            end
            object HisOcoColumnCODSIT: TcxGridDBColumn
              Caption = 'Situa'#231#227'o'
              DataBinding.FieldName = 'CODSIT'
              Width = 171
            end
            object HisOcoColumnOBSERV: TcxGridDBColumn
              Caption = 'Hist'#243'rico Simplificado'
              DataBinding.FieldName = 'OBSERV'
              Width = 511
            end
          end
          object cxGridCitelLevel1: TcxGridLevel
            GridView = cxTableViewHisOco
          end
        end
      end
      object tbsParticipa: TTabSheet
        Caption = 'Participantes'
        ImageIndex = 2
        object dbgOcoPar: TDBGridCitel
          Left = 0
          Top = 0
          Width = 774
          Height = 324
          Align = alClient
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = [fsBold]
          OnKeyDown = dbgOcoParKeyDown
          OnKeyPress = dbgOcoParKeyPress
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'PAR_NOMPAR'
              Title.Caption = 'Nome'
              Width = 105
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAR_FUNPAR'
              Title.Caption = 'Fun'#231#227'o'
              Width = 132
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAR_EMPRES'
              Title.Caption = 'Empresa'
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAR_OBSPAR'
              Title.Caption = 'Observa'#231#227'o'
              Width = 268
              Visible = True
            end>
        end
        object Panel2: TPanel
          Left = 0
          Top = 324
          Width = 774
          Height = 22
          Align = alBottom
          BevelOuter = bvNone
          Caption = '[INSERT] - Novo Registro   [CTRL + DEL] - Excluir registro'
          TabOrder = 1
        end
      end
    end
    object pnlSituacao: TPanel
      Left = 1
      Top = 133
      Width = 782
      Height = 45
      Align = alTop
      Color = 16770261
      Enabled = False
      ParentBackground = False
      TabOrder = 3
      Visible = False
      object grbSit: TGroupBox
        Left = 1
        Top = 1
        Width = 780
        Height = 43
        Align = alClient
        Caption = 'Situa'#231#227'o da Ocorr'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object edtDesSitOco: TEditFocus
          Left = 97
          Top = 16
          Width = 393
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object edtCodSit: TEditFocus
          Tag = 99
          Left = 27
          Top = 16
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodGocKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
    end
    object pnlComplemento: TPanel
      Left = 1
      Top = 89
      Width = 782
      Height = 44
      Align = alTop
      Color = 16770261
      Enabled = False
      ParentBackground = False
      TabOrder = 4
      Visible = False
      object gpComplemento: TGroupBox
        Left = 1
        Top = 1
        Width = 780
        Height = 42
        Align = alClient
        Caption = 'Complemento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object edtCodCpl: TEditFocus
          Tag = 99
          Left = 27
          Top = 16
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCpl: TEditFocus
          Left = 97
          Top = 15
          Width = 393
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
    end
    object pnlDatas: TPanel
      Left = 1
      Top = 178
      Width = 782
      Height = 77
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      Visible = False
      object grbDatas: TGroupBox
        Left = 1
        Top = 1
        Width = 780
        Height = 75
        Align = alClient
        Caption = 'Hor'#225'rios'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 17
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Inclus'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 7
          Top = 40
          Width = 69
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hora Inclus'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 568
          Top = 17
          Width = 79
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Conclus'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 567
          Top = 40
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hora Conclus'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object shpData: TShape
          Left = 651
          Top = 13
          Width = 8
          Height = 22
        end
        object shpHora: TShape
          Left = 651
          Top = 36
          Width = 8
          Height = 22
        end
        object lblTxtLim: TLabel
          Left = 506
          Top = 60
          Width = 124
          Height = 14
          Caption = 'Limite para conclus'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblHraLim: TLabel
          Left = 634
          Top = 60
          Width = 99
          Height = 14
          Caption = '99/99/9999 99:99:99'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label7: TLabel
          Left = 162
          Top = 17
          Width = 94
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Agendamento:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 161
          Top = 40
          Width = 95
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hora Agendamento:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 344
          Top = 17
          Width = 133
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Agendamento Original:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 343
          Top = 40
          Width = 134
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hora Agendamento Original:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbeDtaInc: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 13
          Width = 68
          Height = 22
          TabStop = False
          DataField = 'OCO_DTAINC'
          DataSource = dtsMovOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHorInc: TDBEditFocus
          Tag = 99
          Left = 83
          Top = 36
          Width = 68
          Height = 22
          TabStop = False
          DataField = 'OCO_HORINC'
          DataSource = dtsMovOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaCon: TDBEditFocus
          Tag = 99
          Left = 660
          Top = 13
          Width = 68
          Height = 22
          DataField = 'OCO_DTACON'
          DataSource = dtsMovOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnExit = dbeDtaConExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHorCon: TDBEditFocus
          Tag = 99
          Left = 660
          Top = 36
          Width = 68
          Height = 22
          DataField = 'OCO_HORCON'
          DataSource = dtsMovOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnExit = dbeHorConExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaAge: TDBEditFocus
          Tag = 99
          Left = 263
          Top = 13
          Width = 68
          Height = 22
          DataField = 'OCO_DTAAGE'
          DataSource = dtsMovOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHorAge: TDBEditFocus
          Tag = 99
          Left = 263
          Top = 36
          Width = 68
          Height = 22
          DataField = 'OCO_HORAGE'
          DataSource = dtsMovOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDataAgendamentoOriginal: TDBEditFocus
          Tag = 99
          Left = 484
          Top = 13
          Width = 68
          Height = 22
          DataField = 'OCO_DTAAGO'
          DataSource = dtsMovOco
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHoraAgendamentoOriginal: TDBEditFocus
          Tag = 99
          Left = 484
          Top = 36
          Width = 68
          Height = 22
          DataField = 'OCO_HORAGO'
          DataSource = dtsMovOco
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 655
    Width = 784
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    object BitBtnLocked2: TBitBtnLocked
      Left = 10
      Top = 26
      Width = 72
      Height = 20
      Caption = '&Incluir'
      Enabled = False
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
      TabOrder = 5
      Visible = False
      OnClick = btnIncluirClick
    end
    object BitBtnLocked6: TBitBtnLocked
      Left = 363
      Top = 26
      Width = 72
      Height = 20
      Caption = '&Pesquisar'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 7
      Visible = False
      OnClick = btnPesquisaClick
    end
    object BitBtnLocked7: TBitBtnLocked
      Left = 155
      Top = 26
      Width = 72
      Height = 20
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
      TabOrder = 6
      Visible = False
      OnClick = btnAlterarClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 88
      Top = 0
      Width = 88
      Height = 24
      Hint = 'Imprimir a ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Imprimir'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FF6C6A6A6C6A6AFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6C6A6AAAA7A7A19F9F6C6A6A6C
        6A6A6C6A6AE5E3E36C6A6A6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FFFF00FF
        6C6A6ADAD9D9A19F9FA19F9FA19F9F3736363535356C6D6DBFBFBFE1E2E2B7B6
        B66C6A6A6C6A6A6C6A6AFF00FF6C6A6AD4D3D3CACACA8E8C8C8E8C8C8E8C8C3C
        3B3B0A090A0707070B0B0B0707077A7A7ABBBBBB6C6A6AFF00FF6C6A6ACACACA
        CACACA8E8C8CD7D4D4CECBCBBFBCBCB1AFAFA3A0A08886865E5B5C0707070909
        090808086C6A6A7673736C6A6ACACACA8E8C8CEFEEEEFFFEFEFBFAFAE3E0E1DE
        DEDEDEDDDDCFCECEBDBCBCADABAB8B89895856567A78787573736C6A6A8E8C8C
        FFFFFFFEFCFCFAFAFAD5D4D5989193A09899B2ABACC4C0C1D7D7D7D8D8D8C7C6
        C6B7B6B6918F8F6C6969FF00FF6C6A6A6C6A6AEDEBEBB1A6A77A6F728A838896
        92959690919D97989A93959E9899BBBABAD1D1D1C2C2C26C6A6AFF00FFFF00FF
        FF00FF6C6A6ABB897FA7876D8B6F647D67606F62657973798F8B8EA9A3A4CBCA
        CAC1C1C16C6A6AFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFE3B4FFD39FE9
        B281C99973BA916CBD8281807D7E6C6A6A6C6A6AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFBD8281FFE0B8FFD3A7FFD09DFFCE90FFC688BD8281FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC08683FFE7CFFFE0C0FFD9B2FF
        D3A5FFD099BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFBD8281FEEBD8FFE6CCFFDEBDFFD8B1FED3A4BD8281FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281FFFFF2FFFFF2FFEBD8FFE5CAFF
        E1BDF3C7A7BD8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        BD8281BD8281BD8281FBEFE2FBE3CFFBDDC2BD8281FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD8281BD8281BD
        8281FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnImprimirClick
    end
    object btnHistorico: TBitBtnLocked
      Left = 176
      Top = 0
      Width = 88
      Height = 24
      Align = alLeft
      Caption = '&Gerar Fluxo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF5F5D5D5F5D5D5F5D5D5F5D5D5F5D5D5F5D5DFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5F5C5C5F5D5DB7B7B8A1A09F90
        8C84928A809C918FAFA0A15F5D5D5F5D5DFF00FFFF00FFFF00FFFF00FFFF00FF
        5F5D5DCFCED09F9F9D918F80BCBBA6A1A7BF8390C2C1BCAA928979907E79C2A9
        AA5F5D5DFF00FFFF00FFFF00FF5F5D5DD5D3D4417841427D3CFAEDD3FCDDB895
        A1ED3D59F2FFE7CEFFFFFAAFADA087746CC9A9AA5F5D5DFF00FFFF00FF5F5D5D
        639263046B0B046B0B7AA054F2CA8EF4BD7BF3AD68EDB476FBE7BBFFFFFCACAA
        9C9578745F5D5DFF00FF5F5D5D81AF84046B0B38D46543E278046B0B96C077FE
        F2BDF7D79FEEB87FEEBD81F4D09DFCFBED887A6BC9A1A15F5D5D447047046B0B
        26BD462CC44F34CE5D34C75C046B0B93C17DFCF8C9FFEDB4FCC282EFA966FFE3
        BFB8B1A3AD8B865F5D5D046B0B046B0B09741123BB4125B644046B0B046B0B04
        6B0B6B6C639EA1849C8765C08A5795A1ED909ABD9D7E765F5D5D5F5D5DD5CFCA
        046B0B1BAB331DAA35046B0BFCFCCC8F8F7E1A1C1D2223211A1C1DA67F523D59
        F26679BCA5867A5F5D5D5F5D5DDEDDDD046B0B16A32917A72D599E5CFFFFE6F4
        F4CBB5B59A1A1C1DA9A183FFD593FFE0ACBFBC9FB48F8F5F5D5D5F5D5DE1E0E2
        9DA487046B0B16AA29046B0BACCEADFFFFEFFFFFE3CFCFB21A1C1D877359FCF8
        D1958C7DC9A1A45F5D5DFF00FF5F5D5DD1CECB6D935B046B0B16A729046B0B60
        A4649FC79DB1D3B0A5BB908E8E7FBFC0A5A189875F5D5DFF00FFFF00FF5F5D5C
        D3D4D5BDB8B4789D65046B0B046B0B046B0B046B0B046B0B80B57DD4D5B59C8C
        87CAAAAA5F5D5DFF00FFFF00FFFF00FF5F5D5DCBCBCEC4BFBCC1B6A5E0D3C0D5
        DAD7C0D4DCE0DCCBB5B1A1AD9C99C1A7A75F5D5DFF00FFFF00FFFF00FFFF00FF
        FF00FF5F5D5D5F5D5DB8BABBB6B4B1B5AFA7B6ADA4B1A7A4B2A5A65F5D5D5F5D
        5DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF605E5E5F5D5D5F
        5D5D5F5D5D5F5D5D605E5EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnHistoricoClick
    end
    object btnFinalizar: TBitBtnLocked
      Left = 352
      Top = 0
      Width = 88
      Height = 24
      Hint = 'Finalizar essa ocorr'#234'ncia.'
      Align = alLeft
      Caption = 'Finalizar'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D008D6E8D00A856A800C837C800E41B
        E400F509F500FC02FC00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FE02FE00FD03FD00FC05FC00FB09FB00FA0DFA00F814F800F129F400E940
        F000E15AEC00D977E600D191E100C9AEDB00C1C1DB00B9D4DE00B3D7E500AFD9
        EA00AFDDEF00B0E0F200B2E3F400B3E5F600B4E7F700B5E8F800B3E8F800B1E7
        F800AFE7F800A9E5F800A3E3F8009CE0F80096DEF8008FDBF8008DDAF8008AD8
        F90086D6F90081D5F8007DD4F7007AD4F60079D2F40078D0F40077CDF20074CC
        F1006FCBEE006AC9EB0066C8EA0063C6E7005FC3E40059BEE00053BBDD004DB9
        D90047B7D80041B5D70039B2D70034AED60030ABD5002BA9D40027A7D30023A5
        D10020A3CF001FA0CC001E9FCC001C9DCA001A9AC8001998C6001494C500108F
        C0000F8BBC000E87B8000D83B4000B81B3000C7EAE000C7DAE009E9E9E9E9E9E
        9E9E9E9E9E9E9E9E9E9E9E9E9EFBEEEAECF1ED9E9E9E9E9E9E9E9E9EFAF9E4DA
        DCDFE5E7EE9E9E9E9E9E9E9EF8F6E3D9DFE4EBE0DBE79E9E9E9E9E9EF6F2DDD5
        D8EAFCE8DCDBF49E9E9E9E9EF2EFD5CFD4E8FFE9DFDCF49E9E9E9E9EF0EDCBCF
        CFD4F8E6DBE0F49E9E9E9E9EF4EDEBE9EAEAE7E3DAD9F49E9E9E9E9EF5EBF1EE
        EEF2EDE7DBE3F89E9E9E9E9EF5EBFCF2DDECF2FBF8ECF99E9E9E9E9E9EFFFFF7
        DDDDEEFEFCF99E9E9E9E9E9E9E9EFDFC9EF0F9FFFE9E9E9E9E9E9E9E9E9EECFB
        9E9E9EFFFF9E9E9E9E9E9E9E9E9EF9E4F79EFFFB9E9E9E9E9E9E9E9E9E9E9EF3
        E5E8EEFD9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnFinalizarClick
    end
    object btnEnvMsg: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 88
      Height = 24
      Hint = 'Enviar mensagem.'
      Align = alLeft
      Caption = 'Mensagem'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000090000
        000E0000000F0000000F00000010000000100000001000000010000000100000
        00100000001000000010000000100000000F0000000A00000002845D50C1B780
        6EFFB67E6CFFB47C6AFFB47A69FFB27967FFB17765FFB07662FFAF7461FFAE73
        5FFFAD725EFFAD715DFFAC705CFFAC6F5BFF7B4F40C100000009BB8775FFFAF4
        F0FFF9F1EDFFF9F1ECFFF9F0ECFFF8F1EBFFF8F0EBFFF8F0EBFFF8F0EAFFF7F0
        EAFFF7F0EAFFF7EFEAFFF7EFEAFFF8EFEAFFB37B68FF0000000DBD8A79FFFBF6
        F3FFF7EFE8FFF9F2EEFFF9F2EEFFF9F2EEFFF9F2EEFFF9F2EDFFF9F2EDFFF7ED
        E7FFF6EDE7FFF7EDE7FFF6EDE7FFF9F1EBFFB67E6CFF0000000DC08F7EFFFCF9
        F6FFF8EFE9FFC19989FFC09989FFBF9787FFBF9686FFBE9585FFBD9484FFF7EF
        E9FFF7EEE9FFF7EEE8FFF7EEE8FFF9F2EFFFB98371FF0000000CC49382FFFDFA
        F9FFF8F0EBFFFAF4F0FFFAF4EFFFFAF3EFFFFAF4EFFFFAF4EFFFFAF3EFFFF7EF
        E9FFF7EFE9FFF8EFE9FFF7EFE9FFFAF5F1FFBB8776FF0000000BC69787FFFEFC
        FBFFF8F1ECFFC49F90FFC49E8FFFC49D8DFFC39C8CFFC29B8BFFC1998AFFF8F0
        EBFFF8F0EBFFF8F0EAFFF8EFEAFFFBF7F4FFBE8C7AFF00000009C89B8BFFFEFD
        FDFFF8F2EEFFF9F1EDFFF8F1EDFFF8F1EDFFF8F1EDFFF8F1EDFFF8F1EDFFF8F1
        ECFFF8F1ECFF4A62DAFF4860D9FFFCF9F7FFC1907FFF00000008CA9F8FFFFEFE
        FDFFF9F2EEFFFAF2EEFFFAF2EEFFF9F2EEFFF9F2EEFFF9F2EDFFF9F2EDFFF9F2
        EDFFF9F1EEFF526CDEFF506ADCFFFDFAF8FFC39483FF00000007CCA192FFFFFF
        FEFFFAF3F0FFF9F3F0FFF9F3EFFFFAF3F0FFFAF3F0FFF9F3EFFFFAF3EFFFF9F2
        EFFFF9F3EEFF5B76E1FF5974E0FFFDFBFAFFC69887FF00000006CDA394FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFC99C8CFF00000005A08377BFD8B0
        A1FFD7B0A0FFD7B0A0FFD7AF9FFFD6AF9FFFD6AE9EFFD5AE9EFFD5AD9DFFD4AC
        9CFFD4AB9CFFD3AA9AFFD2A999FFD2A899FF9A7B70C000000003000000010000
        0002000000020000000300000003000000030000000300000003000000030000
        0003000000030000000300000003000000030000000200000001000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      OnClick = btnEnvMsgClick
    end
    object btnAltSituacao: TBitBtnLocked
      Left = 264
      Top = 0
      Width = 88
      Height = 24
      Hint = 'Alterar situa'#231#227'o da ocorr'#234'ncia'
      Align = alLeft
      Caption = 'Alt. Situa'#231#227'o'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Visible = False
      OnClick = btnAltSituacaoClick
    end
    object btnGravarEfinalizar: TBitBtnLocked
      Left = 440
      Top = 0
      Width = 136
      Height = 24
      Align = alLeft
      Caption = 'Gravar e Finali&zar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 8
      OnClick = btnGravarEfinalizarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 256
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 8
  end
  object dtsMovOco: TDataSource
    OnStateChange = dtsMovOcoStateChange
    Left = 192
    Top = 8
  end
  object imgButton: TImageList
    Left = 20
    Top = 246
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000884
      BD0031ADD60042B5DE0039B5D60021A5D60031ADD60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000088CBD00108C
      C60063CEEF0084D6FF007BD6F7007BD6F70063C6E7005ABDE70031ADD6000000
      00000000000000000000000000000000000018427B00215AA500215AA500215A
      A500215AA500215AA500215AA500215AA5002152A5002152A5002152A5002152
      A5002152A50018428C0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001094C600189C
      CE006BCEEF008CDEFF007BD6F70063CEEF0042B5D60073CEF70084D6FF005ABD
      E70000000000000000000000000000000000215AA500316BAD006BA5D60084CE
      F70042A5E70042A5E70042A5E70039A5E700399CE700399CE700399CE700319C
      E700319CDE002973C60010294A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0021A5
      CE007BD6F7009CE7FF008CDEFF0042B5DE000884B50052BDDE007BD6F70084D6
      FF00189CCE00000000000000000000000000296BAD004A84BD004A8CC600B5E7
      FF006BBDEF0052B5EF0052ADEF004AADE7004AADE7004AADE70042A5E70042A5
      E70042A5E7003994D600184A8400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5CE0029AD
      D6009CE7FF00B5EFFF00A5E7FF0052BDDE00087BAD004ABDDE007BD6F7007BD6
      F700189CCE00000000000000000000000000296BB5006BA5D6003984C600ADDE
      F7009CDEF70063BDEF0063BDEF0063BDEF005AB5EF005AB5EF0052B5EF0052B5
      EF0052ADE7004AADE700296BB500000810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5D60031AD
      D600B5E7F700B5EFFF00B5EFFF00A5E7FF001094C6005AC6E70084D6FF0073CE
      F700189CCE000000000000000000000000003173BD008CC6E700529CD60084BD
      E700C6EFFF007BCEF70073CEF70073C6F7006BC6F7006BC6EF006BC6EF0063BD
      EF0063BDEF0063BDEF00428CCE0010294A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0031AD
      D60042B5D6004ABDDE0042B5DE0042B5DE005ABDE7006BCEEF0084D6FF008CDE
      FF00189CCE00000000000000000000000000317BBD00ADE7F70073CEEF005AA5
      D600DEF7FF00DEFFFF00DEF7FF00DEF7FF00DEF7FF00D6F7FF00D6F7FF00CEEF
      FF00C6EFFF00C6EFFF009CCEEF00215284000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D60021A5D60031ADD60031ADD60021A5CE0031ADD6005ABDE70084D6FF006BCE
      EF001094C6000000000000000000000000003984C600C6F7FF0094E7FF0063BD
      E7004A9CD6004A9CD6004A9CD6004A9CCE004A9CCE004A94CE004294CE004294
      CE003173B5003173B5002973B5002963A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D6000884B50021A5CE007BD6F70039B5D60021A5CE000884BD001094C60039B5
      D600108CC600000000000000000000000000398CC600CEF7FF00A5EFFF009CEF
      FF0094E7FF008CE7FF008CDEFF0084DEFF0084DEFF007BDEFF007BD6FF007BD6
      FF00296BB5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000087B
      AD00087BAD00189CC6007BD6F7007BD6F70031ADD600087BAD000884B500108C
      C60000000000000000000000000000000000398CCE00D6FFFF00ADF7FF00ADEF
      FF00A5EFFF00A5EFFF00BDF7FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00CEF7
      FF003184BD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000884B5000884B5000000000021A5D600108CC600087BAD00087BAD000000
      0000000000000000000000000000000000003994CE00D6FFFF00B5F7FF00B5F7
      FF00B5F7FF00BDEFFF004A94CE00398CC600398CC600398CC600398CC6003984
      C600296394000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039B5D6000884BD00000000000000000000000000087BAD00087BAD000000
      0000000000000000000000000000000000004294CE00E7FFFF00E7FFFF00E7FF
      FF00D6F7FF00428CBD0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000108CC60063CEEF00189CC60000000000087BAD000884BD00000000000000
      00000000000000000000000000000000000031739C00429CD600429CD600429C
      D6004294CE001031420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000018A5CE0063C6E70052BDDE0031ADD6000884B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000E07FFFFF00000000
      C01F000100000000C00F000100000000C007000100000000C007000000000000
      C007000000000000C007000000000000C007000000000000C007000700000000
      E00F000700000000F21F000700000000F39F01FF00000000F13F03FF00000000
      F83FFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object cxHint: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Lucida Console'
    HintStyle.Font.Style = []
    Left = 21
    Top = 298
  end
  object popOcorrencias: TPopupMenu
    Left = 414
    Top = 22
    object mnuEfetivarOrcamento: TMenuItem
      Caption = 'Efetivar em Pedido'
      ShortCut = 32881
      OnClick = mnuEfetivarOrcamentoClick
    end
    object mnuAlterarDocumento: TMenuItem
      Caption = 'Alterar Documento'
      ShortCut = 32882
      OnClick = mnuAlterarDocumentoClick
    end
    object mnuEnviarEmail: TMenuItem
      Caption = 'Enviar por E-mail'
      ShortCut = 32883
      OnClick = mnuEnviarEmailClick
    end
    object mnuGerarPDF: TMenuItem
      Caption = 'Gerar PDF'
      ShortCut = 32884
      OnClick = mnuGerarPDFClick
    end
    object mnuReimprimir: TMenuItem
      Caption = 'Reimprimir'
      ShortCut = 32885
      OnClick = mnuReimprimirClick
    end
    object mnuGerarVendaPerdida: TMenuItem
      Caption = 'Gerar Venda Perdida'
      ShortCut = 32886
      OnClick = mnuGerarVendaPerdidaClick
    end
  end
  object popPedido: TPopupMenu
    Left = 442
    Top = 22
    object mnuFatPedido: TMenuItem
      Caption = 'Pedido'
      Hint = 'frmFatVendas - PD'
    end
  end
  object popOrcamento: TPopupMenu
    Left = 470
    Top = 22
    object mnuFatOrcamento: TMenuItem
      Caption = 'Or'#231'amento'
      Hint = 'frmFatVendas - OR'
    end
  end
end
