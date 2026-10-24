object fraDDAAPIAutenticacaoFrame: TfraDDAAPIAutenticacaoFrame
  Left = 0
  Top = 0
  Width = 624
  Height = 313
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 313
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblAmbienteAPI: TLabel
      Left = 521
      Top = 260
      Width = 88
      Height = 14
      Caption = 'HOMOLOGA'#199#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAmbienteAPITexto: TLabel
      Left = 470
      Top = 260
      Width = 49
      Height = 13
      Caption = 'Ambiente:'
    end
    object lblMensagem: TLabel
      Left = 104
      Top = 283
      Width = 513
      Height = 32
      AutoSize = False
      Caption = 'lblMensagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
      StyleElements = [seClient, seBorder]
    end
    object pnlChaveAppDev: TPanel
      Left = 0
      Top = 0
      Width = 624
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      Visible = False
      object lblChaveAppDev: TLabel
        Left = 24
        Top = 4
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Caption = 'Chave APP Pix:'
      end
      object edtChaveAppDev: TEditFocus
        Tag = 99
        Left = 104
        Top = 1
        Width = 513
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlChavesClient: TPanel
      Left = 0
      Top = 23
      Width = 624
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object lblClientID: TLabel
        Left = 53
        Top = 4
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Client ID:'
      end
      object lblClientSecret: TLabel
        Left = 33
        Top = 29
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'Client Secret:'
      end
      object edtClientID: TEditFocus
        Tag = 99
        Left = 104
        Top = 1
        Width = 513
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtClientSecret: TEditFocus
        Tag = 99
        Left = 104
        Top = 24
        Width = 513
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlCertificadoPFX: TPanel
      Left = 0
      Top = 70
      Width = 624
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      Visible = False
      object Label8: TLabel
        Left = 9
        Top = 3
        Width = 89
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Certificado PFX:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
        ParentFont = False
      end
      object edtArquivoPFX: TEditFocus
        Tag = 99
        AlignWithMargins = True
        Left = 104
        Top = 0
        Width = 489
        Height = 21
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        TabStop = False
        Alignment = taLeftJustify
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnArquivoPFX: TcxButton
        Left = 594
        Top = 0
        Width = 23
        Height = 22
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
          526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000022249444154
          785EA593BD6B545110C57F6FF3242AA9B412144B3FB1500CA20663FC032C6C44
          B0B010041194147616366295805A88A058898D8D106C444D6C44123426120959
          36B8316FD9F8F2B15F6FDFBD7746B9EFAD82019B1CB81C6698397366E006AACA
          461000859CC959F327FC079DC1E1C4C381D785807EB21815A827E642DF8DB1E7
          E30F4E8BA2A0CA1F12A5F7FA281D8488F61FBAFC940C8A6DD5987A76F3DE9D4B
          FB468F5C7D53653D0470B94B426704DC2AA4DF517184380E9EBBB6DD99E1F2A9
          03DB4072BB0AA2608C1B1BB8F5E10C6032012BA00E5C422016D4D2250D0E5F1C
          24E8DE0104A00208AA8ED1BB57FA80AEBF02A9CB046C82DA26625BE00CD4CBA8
          CF1B54F21A1556AB75809E20080A800BDEDD3EA67D8343C8CA272AD3E3C40B15
          54404510C92EA7A28888E7A5F92AEAD38A38AD862675B4E28864A1C872D460FF
          F961BC786E1B71A85A108B3A8B8A0149894BDF78FB6868DEAFB05A2E11CFCCD2
          B3AB174D221AB32F51DF90DD47457C8C737E1D114769B2CCCA9A19094DDBB154
          9A632D5A66E7F1BDB42BD3D85ADC29CC9A54C04F17C40B0951B1C29772FD4598
          B62D4B73737477F7B0796B487D6602DB58F6D63B2E347391E71CB59536F1CFC6
          D7FBEFA362D86AA4B018B1E7C44992C529926AD14F50BF7BA749BD082A5EA8BA
          9010D7CD0860C24633FD88AB1D9D1C79C5647E5D72560001505401554421B55A
          FEFCA3F9184803600BB00928B01EC13FB10206489E9CDDED0036FC9D7F01FAB6
          A14B22EE620A0000000049454E44AE426082}
        TabOrder = 1
        TabStop = False
        OnClick = btnArquivoPFXClick
      end
    end
    object pnlSenhaCertificado: TPanel
      Left = 0
      Top = 93
      Width = 624
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      Visible = False
      object lblSenhaCertificado: TLabel
        Left = 9
        Top = 3
        Width = 89
        Height = 13
        Alignment = taRightJustify
        Caption = 'Senha Certificado:'
      end
      object lblValidadeCertificado: TLabel
        Left = 496
        Top = 3
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Validade:'
      end
      object edtSenhaCertificado: TEditFocus
        Tag = 99
        Left = 104
        Top = 0
        Width = 385
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValidadeCertificado: TEditFocus
        Tag = 99
        Left = 543
        Top = 0
        Width = 74
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlChaveBasic: TPanel
      Left = 0
      Top = 117
      Width = 624
      Height = 123
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
      Visible = False
      object lblChaveBasic: TLabel
        Left = 10
        Top = 3
        Width = 88
        Height = 13
        Alignment = taRightJustify
        Caption = 'Autoriza'#231#227'o Basic:'
      end
      object btnGerarChaveBasic: TBitBtnLocked
        Left = 104
        Top = 99
        Width = 125
        Height = 24
        Caption = 'Gerar Chave Basic'
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
        TabOrder = 1
        OnClick = btnGerarChaveBasicClick
      end
      object edtChaveBasic: TMemoFocus
        Left = 104
        Top = 0
        Width = 513
        Height = 97
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object btnValidarDadosPix: TBitBtnLocked
      Left = 104
      Top = 256
      Width = 161
      Height = 24
      Caption = 'Validar Dados Autoriza'#231#227'o'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        000A0000000F0000001000000010000000100000001000000011000000110000
        0011000000110000001100000011000000100000000A0000000200000009845E
        4FC1B6836EFFB7826DFFB5816DFFB5806CFFB5806CFFB4806CFFB47E6BFFB47E
        6AFFB37D69FFB37D68FFB27D69FFB27C68FF80584AC20000000A0000000EBC8B
        76FFF8F2EDFFF6EFEBFFF6EEEAFFF6EFEAFFF6EFEAFFF6EEE9FFF6EEE9FFF5EE
        E9FFF6EDE8FFF5EEE8FFF5EDE8FFF6EFEBFFBB8774FF0000000E0000000EBE8D
        79FFF8F3EFFFF5EEE9FFF6EEE9FFF5EEEBFFF4F0ECFFEBE8E5FFEEE9E8FFF5EF
        EAFFF5ECE7FFF4ECE6FFF4EBE6FFF6F0ECFFBD8A76FF0000000F0000000DC08F
        7CFFFAF3F1FFF7EFEAFFF6F0EBFFF2EEECFFCEBDB2FFA36442FFB08C7AFFEBE8
        E5FFF5EEE9FFF5EDE7FFF5ECE7FFF7F1EDFFBD8B78FF0000000E0000000CC291
        7EFFFAF5F3FFF8F1EDFFF5F1EFFFD3C2B8FFB57E59FFE2BD8BFFAB724DFFC7B5
        ABFFF1EDEBFFF5EEE9FFF5EEE9FFF8F3EDFFBF8E7BFF0000000D0000000CC395
        81FFFBF8F4FFF6F3F1FFD9C8BFFFB9845EFFE4C18FFFE6C393FFDCB687FFA36D
        4FFFDDD6D2FFF6F0EDFFF6EFEAFFF9F3EFFFC0907DFF0000000D0000000BC597
        85FFFAF7F5FFE1D1C7FFBE8D6AFFEACCA5FFF1DEBFFFF5E4CAFFEBCCA1FFCEA2
        76FFAB7F6AFFE8E6E3FFF6F2EEFFF9F3F1FFC29380FF0000000C0000000AC69A
        88FFFBF9F7FFDBC5B8FFC99F81FFE4CCB4FFCAA082FFB98463FFEAD5BBFFEBCE
        A4FFC4936BFFB89786FFEEEAE8FFF8F3F0FFC39683FF0000000B0000000AC89D
        8BFFFCFAF8FFFAF7F6FFD9C3B4FFC1957BFFD4BDAFFFDED3CDFFBC8E71FFEBD7
        BEFFEED3ADFFBB8661FFC4AEA2FFF0ECE9FFC49885FF0000000A00000009CAA0
        8EFFFBFAF8FFFCF9F6FFFAF7F6FFF8F5F3FFF9F6F4FFF8F6F4FFE8DFDAFFBC8E
        71FFE5CDB5FFF1DEBDFFBA8562FFE9E6E3FFC59A88FF0000000A00000008CCA3
        91FFFCFBFAFFFCF8F5FFFCF8F5FFFBF7F4FFFBF7F4FFFAF6F5FFFAF7F6FFEBE5
        E1FFC0967BFFC5987AFFD1C3BAFFF1EFECFFC99E8CFF0000000900000007CDA5
        93FFFDFBFAFFFCF9F7FFFCF9F7FFFCF8F6FFFBF9F5FFFBF8F5FFFBF8F5FFFAF8
        F6FFF4F2F1FFEEECEBFFF4F2F0FFFAF7F6FFCBA18FFF0000000800000006CEA7
        96FFFDFBFAFFFEFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFB
        F9FFFCFBFBFFFAF9F8FFFBFAF8FFFCFAF8FFCCA391FF00000007000000049A7E
        71C1CFA998FFCFA898FFCFA997FFCFA997FFCFA897FFCEA796FFCFA796FFCFA8
        96FFCFA796FFCEA696FFCEA794FFCEA694FF987B6FC100000005000000010000
        0004000000050000000600000006000000060000000600000006000000060000
        0006000000060000000600000006000000060000000400000001}
      TabOrder = 5
      Visible = False
    end
  end
end
