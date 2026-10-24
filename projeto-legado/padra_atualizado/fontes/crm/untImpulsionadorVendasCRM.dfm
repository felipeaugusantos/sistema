inherited frmImpulsionadorVendasCRM: TfrmImpulsionadorVendasCRM
  Width = 1024
  Height = 768
  Caption = 'Oferta de Consum'#237'veis - CRM'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 697
    Width = 1018
    Height = 26
    ExplicitTop = 697
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 937
      Height = 22
      ExplicitWidth = 937
      ExplicitHeight = 22
      object btnGerarOrcamento: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F10] Gerar Or'#231'amento'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000513322B74C2C
          1CB700000000412112B73E1D0EB7000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000005B3E2CBD5638
          26BD000000004A2A1ABD452414BD000000000000000000000000000000000000
          0000000000000000000002060B15102D58AE0E2952A8010307120000000D0000
          0013000000160000001800000015000000070000000100000000000000000000
          0000000000000A1C30541D4E89EC4D8EC4FF2069AFFF183969E2885032F98649
          2CFF7D4226FF743920FF6C311AFD0B0502340000000200000000000000000308
          0E1517416CAE2E72AFFF449BD5FF74B7E4FF257EC6FF3D6995FFA97150FFE0A9
          7EFFD79868FFCF9061FF7C4629FF45210FD200000007000000000E273C57296A
          A2EC4597CEFF4FAADFFF4BA6DDFF88C2E8FF2780C7FF646D7BFFC38E6BFFE5B6
          92FFE5B692FFE1B28FFFAE7B5CFF5B2E1AFB03010114000000002B76B4FF5BB6
          E2FF5AB6E4FF54B0E2FF50ABDFFF9DCEEDFF2883C9FF8D6D5DFFA16744FF9C60
          3FFF955A39FF8D5233FF86492DFF683A22F9180C0749000000002D7BB9FF66C3
          EBFF60BDE7FF5BB7E5FF56B1E2FFB1DAF1FF2986CCFF2781C8FF247BC4FF2176
          C1FF1F70BDFF1D6BB7FF133571FF3A241988351E1388000000002F80BDFF6CCA
          EEFF67C4EBFF61BEE8FF5CB8E5FFC3E4F5FF2A89CEFF2885CBFF2680C9FF237B
          C6FF2077C4FF1F72C2FF153C7AFF1D140E3C70462FFF311C127C3085C1FF72D0
          F0FF6DCBEDFF67C5EBFF77C8EBFFF3FAFDFFBADAF0FF3E94D2FF2782CAFF247E
          C8FF2279C5FF2075C3FF16407FFF02010103774F38F770462EFF3288C5FF78D7
          F2FF77D3F0FFADE2F4FFDBEFF7FF88CCE3FF81C8E3FFD1E9F5FF74B2DEFF2680
          C9FF247CC6FF2177C4FF184483FF000000000000000000000000338DC7FF7FCE
          EBFFC1E2F2FF8FC1E2FF4297CFFF3892CCFF3490CDFF3994CEFF97D0E8FFA3D0
          EAFF3C8DCEFF237AC6FF1A4A88FF0000000000000000000000000C22303C2669
          96C055ACD9FF7AD9F2FF7EDDF5FF7AD8F2FF78D3F0FF318FCCFF3CA8D5FF54B1
          DAFF98CEE9FF60A6D9FF1C4F8EFF000000000000000000000000000000000000
          00000C212F3C256693C050A8D5FF77D5F0FF7AD6F1FF318FCDFF3CA8D5FF35A3
          D3FF309ED3FF4799CDFF1E5493FF000000000000000000000000000000000000
          000000000000000000000C202E3C24628FC04198CEFF318FCCFF3AA2D2FF2D88
          C3FF2467A3F514395F9906121F33000000000000000000000000000000000000
          0000000000000000000000000000000000000B1E2D3C235D8CC0225E8FC9102C
          44630205080C0000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnGerarOrcamentoClick
      end
      object btnSelecionarTodos: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F7] Selecionar Todos'
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
        TabOrder = 1
        OnClick = btnSelecionarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F8] Desmarcar Todos'
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
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnEstoqueLojas: TBitBtnLocked
        Left = 450
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F6] Estoque das Lojas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000060000
          0016000000180000000800000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000005000000270D24
          44B30E294FC70001033C0000000C000000010000000000000000000000000000
          00000000000500000012000000140000000700000005000000200F2A4AB3387B
          B6FF2169AFFF113668E702060D56000000120000000300000000000000010000
          00070103062A0F2951B90F2952C3010307390000001A112F50A53781BCFF67B4
          E2FF2782CAFF2271B9FF16417CF5050E1D75000000190000000400000007050E
          184119457CE3397FBBFF2069AFFF143A71EC040C1A722464A3FF54B0E2FF7FC1
          E8FF2884CBFF257FC8FF2276C0FF194C8DFD09193295000000110D243C6B2764
          A0F94398D2FF55A8DEFF257FC8FF2174BDFF18498AFD266AA9FF5BB7E5FF9CD1
          EEFF2986CCFF2782CAFF257DC8FF2278C4FF16417FFF0000001B2465A4FF52AC
          DFFF4FAADFFF67B4E2FF2782CAFF247CC7FF206EB8FF2870AEFF61BEE8FFDDF0
          FAFFBEDBF0FF4093D1FF2680C9FF237BC6FF194585FF00000017266AAAFF5AB6
          E4FF54B0E2FF7FC1E8FF2884CBFF257FC8FF2171B9FF2A75B3FFB4E2F5FFB4E6
          F3FF93DAEEFFD6EEF8FF76B3DFFF267FC8FF1A4B89FF000000102870AEFF60BD
          E7FF5BB7E5FF9CD1EEFF2986CCFF2782CAFF2374BDFF3981BCFFAFE4F4FF69CE
          EAFF65CAE7FF65C8E6FF9CDAEEFF99CEE9FF336AA2FF000000092A75B3FF67C4
          EBFF61BEE8FFBBE1F4FF2A89CEFF2885CBFF257CC4FF246FB4FF2E78B4FF5CB9
          DEFF67CCE8FF61C7E6FF59C2E3FF4697C5FB1129426E000000032D7AB9FF6DCB
          EDFF67C5EBFFEBF7FCFFBEDCF0FF4196D3FF2781C9FF237AC3FF216FB7FF256C
          AEFF307EBAFF43A1D4FF225E91D8050F182800000001000000002F7FBCFF73D2
          F0FFB7E6F7FFB4E6F3FF93DAEEFFD6EEF8FF77B5E0FF2881C9FF247BC4FF2072
          BDFF1B4C8BFF1B4B73A9010406090000000000000000000000003083C1FFA1D9
          EFFFB6E8F5FF69CEEAFF65CAE7FF65C8E6FF9CDAEEFF99CEEAFF3A8ECEFF237A
          C6FF1A4A88FF00000009000000000000000000000000000000000C202E3C2463
          90C04CA3D0FF69CBE9FF67CCE8FF61C7E6FF59C2E3FF63C2E4FF81C9E6FF3B88
          C4FF1C4F8EFF0000000500000000000000000000000000000000000000000000
          00000B1F2D3C23608DC03B91C7FF55B9E0FF50B6DEFF3790C6FF24639FF51337
          5C9B06111D370000000100000000000000000000000000000000000000000000
          000000000000000000000B1D2C3C215A88C0215A8CC90F2A42630205080C0000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnEstoqueLojasClick
      end
      object btnCfg: TBitBtnLocked
        Left = 600
        Top = 0
        Width = 89
        Height = 22
        Caption = 'Configurar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 4
        OnClick = btnCfgClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlAnaliseResumoVendas: TPanel [2]
    Left = 0
    Top = 592
    Width = 1018
    Height = 105
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblTitulo3: TcxLabel
      Left = 0
      Top = 0
      Align = alTop
      Caption = 'An'#225'lise de Resumo de Vendas - '#218'ltimos 6 Meses'
      ParentFont = False
      Style.BorderStyle = ebsUltraFlat
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -15
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.HotTrack = False
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = True
      Style.Shadow = False
      Style.TransparentBorder = True
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      AnchorX = 507
      AnchorY = 11
    end
    object pnlMes6: TPanel
      Left = 720
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 5
      object grbMes6: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes6: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes6: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes6: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          Width = 60
        end
        object edtVlrMes6: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
    object pnlMes5: TPanel
      Left = 576
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 4
      object grbMes5: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes5: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes5: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes5: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          Width = 60
        end
        object edtVlrMes5: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
    object pnlMes4: TPanel
      Left = 432
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 3
      object grbMes4: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes4: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes4: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes4: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          Width = 60
        end
        object edtVlrMes4: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
    object pnlMes3: TPanel
      Left = 288
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      object grbMes3: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes3: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes3: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes3: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          Width = 60
        end
        object edtVlrMes3: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
    object pnlMes2: TPanel
      Left = 144
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      object grbMes2: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes2: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes2: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes2: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          Width = 60
        end
        object edtVlrMes2: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
    object pnlMes1: TPanel
      Left = 0
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object grbMes1: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes1: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes1: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes1: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          Width = 60
        end
        object edtVlrMes1: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
    object pnlMes7: TPanel
      Left = 864
      Top = 21
      Width = 144
      Height = 80
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      ParentBackground = False
      ParentColor = True
      TabOrder = 6
      object grbMes7: TGroupBox
        Left = 7
        Top = 7
        Width = 130
        Height = 66
        Align = alClient
        Caption = '00/0000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblQtdMes7: TLabel
          Left = 4
          Top = 19
          Width = 26
          Height = 14
          Caption = 'Qtde.'
        end
        object lblVlrMes7: TLabel
          Left = 65
          Top = 19
          Width = 49
          Height = 14
          Caption = 'Valor (R$)'
        end
        object edtQtdMes7: TcxCurrencyEdit
          Left = 4
          Top = 37
          EditValue = 0
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 0
          Width = 60
        end
        object edtVlrMes7: TcxCurrencyEdit
          Left = 65
          Top = 37
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.ReadOnly = True
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 60
        end
      end
    end
  end
  object pnlFiltros: TPanel [3]
    Left = 0
    Top = 23
    Width = 1018
    Height = 147
    Align = alTop
    Anchors = []
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object lblFornecedor: TLabel
      Left = 12
      Top = 30
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblMarca: TLabel
      Left = 39
      Top = 54
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblLinGru: TLabel
      Left = 520
      Top = 32
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lblPrdGru: TLabel
      Left = 500
      Top = 55
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Produto:'
    end
    object lblDepartamento: TLabel
      Left = 1
      Top = 76
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object Label6: TLabel
      Left = 533
      Top = 76
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 711
      Top = 76
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object lblFiltro1: TcxLabel
      Left = 0
      Top = 0
      Align = alTop
      Caption = 'Filtros Resumo de Vendas'
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsUltraFlat
      Style.Color = 16770261
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      AnchorX = 507
      AnchorY = 11
    end
    object edtCodFornecedor: TEditFocus
      Tag = 99
      Left = 73
      Top = 27
      Width = 64
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
      Left = 138
      Top = 27
      Width = 350
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 138
      Top = 50
      Width = 350
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 73
      Top = 50
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 2
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
    object edtLinGru: TEditFocus
      Left = 657
      Top = 27
      Width = 350
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
    object edtCodGru: TEditFocus
      Tag = 99
      Left = 592
      Top = 27
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      TabOrder = 6
      OnExit = edtCodGruExit
      OnKeyPress = edtCodGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 592
      Top = 50
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 8
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object pnlBotoes1: TPanel
      Left = 0
      Top = 118
      Width = 1014
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      Padding.Right = 7
      Padding.Bottom = 3
      TabOrder = 12
      object btnFiltrar: TBitBtnLocked
        Left = 807
        Top = 0
        Width = 85
        Height = 22
        Caption = '[F5] Filtrar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000100000002000000080000000C0000000F0000000F0000000D0000
          0007000000040000000700000007000000020000000000000000000000000000
          0001000000050204031C102F2291184A34D31E5C41FF1E5B40FF184732D2112F
          227D0000000E14382995072C1B95000000090000000100000000000000010000
          00080A1C145722674CE723966DFF23B481FF24CA92FF39CF9DFF37886AFF0C21
          185D06100C392A7B5CFB146744FB020C08370000000400000000000000060D25
          1C652E8867FF28B586FF3BDAA8FF59E0B7FF6FE5C2FF5FC6A6FF1F533FBF0000
          00161E523DBF27B786FF1EB07DFF0C3E28BF0000000C00000001040A08223080
          62F62BBA8BFF42DDADFF65CEADFF53AB8EFF3A8B6EFF2F7D60FA07120D360E24
          1B5D2F9671FF28D59EFF28D59EFF1D805AFF051B125C00000005194434903CAC
          88FF2DDAA5FF5ECFAEFF45987CF914362A750409072002050415010302162B73
          57E12ACC98FF29D8A1FF2AD7A0FF26C592FF145438E00001010F2A7258D438C7
          9BFF30DDA9FF5CB699FF194133810000000700000001000000061941328460B8
          9CFF83ECCFFF2BDAA5FF34DBA8FF88EDD0FF479D7FFF0B2A1C77358C6DF250DF
          B6FF61E8C2FF3F9475FF040A081E00000002000000000205040F36896CF4378F
          70FF419A7BFF30DCA8FF38D7A7FF358A6BFF34886AFF317E61EF3B997AFA98ED
          D8FF8DF1D8FF398E6DFF040B0820000000010000000000000002000000070205
          04193F9675FF43E2B3FF4DDAB1FF1D6749F20000000F0000000734856AD398E1
          CFFF9AF4DEFF57A98BFF11382681000000060000000100000001000000051237
          287659B092FF8BF1D7FF6ECEB2FF1E6047D400000006000000002359478A81CF
          BAFFB4F9EAFF82D3BCFF3A8767FB0E352383030C0823030C08230E3222753D8E
          6EF984DFC7FFAAF6E5FF6FB8A0FF1642328C0000000300000000050D0A1855B2
          95F5A5E5D5FFBCFAEDFF94E5D0FF56A386FF2D7B59FF2D7B59FF54A386FF85D4
          BDFFB5F8EAFF9ADAC9FF419477F5030A0719000000010000000000000002173A
          2F5669C6AAFFAAE7D9FFCBFDF3FFC1FBEFFFBAF9ECFFB8F9EBFFBEFBEEFFC7FC
          F2FFA6E5D5FF5CB096FF12302657000000020000000000000000000000000000
          0002122E264453AB90E38AD7C2FFB2EADDFFCEF9F1FFCEF9F1FFB1EADCFF87D4
          BFFF50A78CE40F29204400000002000000000000000000000000000000000000
          0000000000010409070F255D4C813A9076C849B896FC49B795FC399075C8255B
          4A82030907100000000100000000000000000000000000000000000000000000
          0000000000000000000000000001000000020000000200000002000000020000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnFiltrarClick
      end
      object btnLimparFiltro: TBitBtnLocked
        Left = 892
        Top = 0
        Width = 115
        Height = 22
        Caption = '[F4] Limpar Filtro'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00020000000A0000000F00000011000000110000001200000012000000130000
          00130000001300000014000000130000000D0000000300000000000000000000
          000981594BC1B37B67FFB27B66FFB27A66FFB27864FFB17965FFB17965FFB177
          65FFB17763FFB07664FFB07664FF7E5548C50000000C00000000000000000000
          000DB57D6BFFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFF8F0EBFFF9F0EAFFB17866FF0000001200000000000000000000
          000DB7816DFFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
          E5FFF8EBE4FFF6EBE4FFF9F1ECFFB37A68FF0000001300000000000000000000
          000DB98472FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
          E6FFF7ECE5FFF6ECE5FFFAF2EEFFB57D6BFF0000001200000000000000000000
          000CBB8775FFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
          E7FFF8EEE7FFF8EDE7FFFAF4EFFFB7816EFF0000001100000000000000000000
          000BBE8A79FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
          E9FFF8EFE9FFF8EFE8FFFAF5F1FFBA8571FF0000001000000000000000000000
          000AC08F7EFFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
          EBFFF9F1EBFFF8F0EAFFFBF6F3FFBB8975FF0000000F00000000000000000000
          0009C49380FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
          EDFFF9F2EDFFF9F1EBFFFCF7F4FFBE8B79FF0000000F00000000000000000000
          0009C69686FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFAF3EFFFFDF9F7FFC18E7DFF0000000E00000000000000000000
          0008C99B8AFFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFAF5F0FFFDFAF8FFC39382FF0000000D00000000000000000000
          0007C99E8DFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFBF6F1FFFDFBF9FFC69786FF0000000C00000000000000000000
          0006CEA190FFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
          F5FFFBF7F4FFFCF7F3FFFDFCFAFFC89B8AFF0000000B00000000000000000000
          0006CEA393FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
          F6FFFBF7F6FFFCF7F5FFFEFCFCFFCB9D8DFF0000000B00000000000000000000
          0005D0A696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
          FEFFFEFEFEFFFEFEFEFFFEFEFDFFCDA191FF0000000900000000000000000000
          00039C7C71C0D2A898FFD1A897FFD1A897FFD1A797FFD0A696FFD0A696FFD0A6
          95FFD0A595FFCFA595FFCFA494FF98796EC20000000600000000}
        TabOrder = 1
        OnClick = btnLimparFiltroClick
      end
    end
    object edtDesPrdPro: TEditFocus
      Left = 657
      Top = 50
      Width = 350
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
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 73
      Top = 73
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDep: TEditFocus
      Left = 138
      Top = 73
      Width = 350
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 592
      Top = 73
      Width = 64
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 10
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 767
      Top = 73
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 11
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object rdgTipPre: TRadioGroup
      Left = 1
      Top = 96
      Width = 253
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Na coluna Pre'#231'o Venda carregar:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o de Tabela'
        'Pre'#231'o Ult. Venda')
      TabOrder = 14
      StyleElements = [seFont, seClient]
    end
  end
  object pnlResumoVendas: TPanel [4]
    Left = 0
    Top = 170
    Width = 1018
    Height = 398
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitHeight = 422
    object lblFiltro2: TcxLabel
      Left = 0
      Top = 0
      Align = alTop
      Caption = 'Resumo de Vendas'
      ParentFont = False
      Style.BorderStyle = ebsUltraFlat
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      AnchorX = 507
      AnchorY = 11
    end
    object grdResumoVendas: TcxGridCitel
      Left = 0
      Top = 22
      Width = 1014
      Height = 372
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 396
      object grdResumoVendasTableView1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
      end
      object grdResumoVendasView: TcxGridDBTableViewCitel
        OnKeyDown = grdResumoVendasViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdResumoVendasViewCustomDrawCell
        OnEditValueChanged = grdResumoVendasViewEditValueChanged
        DataController.DataSource = dtsResumoVendas
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
        OptionsView.GroupByBox = False
        Preview.AutoHeight = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdResumoVendasSELECT: TcxGridDBColumn
          DataBinding.FieldName = 'SELECT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 1
          Properties.ValueGrayed = '0'
          Properties.ValueUnchecked = 0
          HeaderGlyph.SourceDPI = 96
          HeaderGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            000F000000110000001100000012000000120000001200000013000000130000
            001300000014000000130000000D00000003000000000000000981594BC1B37B
            67FFB27B66FFB27A66FFB27864FFB17965FFB17965FFB17965FFB17765FFB177
            63FFB07664FFB07664FF7E5548C50000000C000000000000000DB57D6BFFFDFB
            F9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFFBF4EFFFF9F3EEFFF9F2EEFFFAF2
            ECFFF8F0EBFFF9F0EAFFB17866FF00000012000000000000000DB7816DFFFDFB
            FAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF7EDE6FFF6ECE5FFF6ECE5FFF8EB
            E4FFF6EBE4FFF9F1ECFFB37A68FF00000013000000000000000DB98472FFFDFC
            FBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF8EEE7FFF7EEE7FFF7ECE6FFF7EC
            E5FFF6ECE5FFFAF2EEFFB57D6BFF00000012000000000000000CBB8775FFFEFC
            FBFFF9F0EAFFF8F0EAFFA5928BFFA5928AFFF8EFE8FFF8EEE9FFF8EEE7FFF8EE
            E7FFF8EDE7FFFAF4EFFFB7816EFF00000011000000000000000BBE8A79FFFEFD
            FCFFF9F2EDFFA6948EFF553930FF543830FFA6938CFFF8F0EAFFF8F0E9FFF8EF
            E9FFF8EFE8FFFAF5F1FFBA8571FF00000010000000000000000AC08F7EFFFEFD
            FDFFFAF3EFFF563B32FFA99891FFA99790FF553931FFA6948CFFF9F0EBFFF9F1
            EBFFF8F0EAFFFBF6F3FFBB8975FF0000000F0000000000000009C49380FFFEFE
            FDFFFBF5F1FFAA9A93FFFBF4F0FFFAF3EFFFA99892FF573B32FFA6958EFFF9F2
            EDFFF9F1EBFFFCF7F4FFBE8B79FF0000000F0000000000000009C69686FFFEFE
            FDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFAA9A93FF573B33FFA896
            8FFFFAF3EFFFFDF9F7FFC18E7DFF0000000E0000000000000008C99B8AFFFEFE
            FEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF6F3FFFCF4F2FFAB9A94FF583C
            34FFA99791FFFDFAF8FFC39382FF0000000D0000000000000007C99E8DFFFFFE
            FEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFBF6F4FFFCF6F3FFAC9B
            95FF5A3D35FFFDFBF9FFC69786FF0000000C0000000000000006CEA190FFFFFF
            FEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7
            F4FFAC9C96FFFDFCFAFFC89B8AFF0000000B0000000000000006CEA393FFFFFF
            FFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7
            F6FFFCF7F5FFFEFCFCFFCB9D8DFF0000000B0000000000000005D0A696FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFE
            FEFFFEFEFEFFFEFEFDFFCDA191FF0000000900000000000000039C7C71C0D2A8
            98FFD1A897FFD1A897FFD1A797FFD0A696FFD0A696FFD0A696FFD0A695FFD0A5
            95FFCFA595FFCFA494FF98796EC20000000600000000}
          Width = 20
          IsCaptionAssigned = True
        end
        object grdResumoVendasCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 60
        end
        object grdResumoVendasDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Options.Editing = False
          Width = 250
        end
        object grdResumoVendasUNIDAD: TcxGridDBColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'UNIDAD'
          Options.Editing = False
          Width = 50
        end
        object grdResumoVendasNVLGIR: TcxGridDBColumn
          Caption = 'N'#237'vel de Giro de Est. Geral'
          DataBinding.FieldName = 'NVLGIR'
          Options.Editing = False
          Width = 136
        end
        object grdResumoVendasNUMDOC: TcxGridDBColumn
          Caption = 'Docto '#218'lt.Venda'
          DataBinding.FieldName = 'NUMDOC'
          Options.Editing = False
          Width = 150
        end
        object grdResumoVendasDTAUVE: TcxGridDBColumn
          Caption = 'Dt. Ult. Venda'
          DataBinding.FieldName = 'DTAUVE'
          Options.Editing = False
          Width = 75
        end
        object grdResumoVendasQTDUVE: TcxGridDBColumn
          Caption = 'Qtde. '#218'lt. Venda'
          DataBinding.FieldName = 'QTDUVE'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasPREUVE: TcxGridDBColumn
          Caption = 'Pre'#231'o '#218'lt. Venda'
          DataBinding.FieldName = 'PREUVE'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasQTDITE: TcxGridDBColumn
          Caption = 'Qtde. Venda'
          DataBinding.FieldName = 'QTDITE'
          Width = 90
        end
        object grdResumoVendasUNITAR: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda'
          DataBinding.FieldName = 'UNITAR'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasTOTITE: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'TOTITE'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasMARGEM: TcxGridDBColumn
          Caption = '% Margem'
          DataBinding.FieldName = 'MARGEM'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasQTDORC: TcxGridDBColumn
          Caption = 'Qtde. Or'#231'.'
          DataBinding.FieldName = 'QTDORC'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasTOTORC: TcxGridDBColumn
          Caption = 'Valor Total Or'#231'.'
          DataBinding.FieldName = 'TOTORC'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasQTDPED: TcxGridDBColumn
          Caption = 'Qtde. Pedido'
          DataBinding.FieldName = 'QTDPED'
          Options.Editing = False
          Width = 90
        end
        object grdResumoVendasTOTPED: TcxGridDBColumn
          Caption = 'Valor Total Pedido'
          DataBinding.FieldName = 'TOTPED'
          Options.Editing = False
          Width = 90
        end
      end
      object grdResumoVendasLvl1: TcxGridLevel
        GridView = grdResumoVendasView
      end
    end
  end
  object lblCliente: TcxLabel [5]
    Left = 0
    Top = 0
    Align = alTop
    Caption = ' Cliente: '
    ParentColor = False
    ParentFont = False
    Style.Color = clHighlight
    Style.Edges = [bLeft, bTop, bRight, bBottom]
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = 'Arial'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = [fsBold]
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    AnchorY = 12
  end
  object Panel1: TPanel [6]
    Left = 0
    Top = 568
    Width = 1018
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 1008
      Height = 14
      Caption = 
        '* As informa'#231#245'es contidas nas colunas Docto '#218'lt. Venda, Dt. Ult.' +
        ' Venda, Qtde. '#218'lt. Venda e Pre'#231'o '#218'lt. Venda s'#227'o referentes a '#250'lt' +
        'ima venda realizada independentemente do per'#237'odo de vendas infor' +
        'mado no filtro'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
  end
  object dtsResumoVendas: TDataSource
    Left = 464
    Top = 248
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 192
    Top = 280
    PixelsPerInch = 96
    object cxConteudo: TcxStyle
    end
  end
end
